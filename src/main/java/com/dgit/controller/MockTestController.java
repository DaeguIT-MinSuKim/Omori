package com.dgit.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dgit.domain.GradeVO;
import com.dgit.domain.ImageVO;
import com.dgit.domain.SelectedAnswerVO;
import com.dgit.domain.TestExampleVO;
import com.dgit.domain.TestNameVO;
import com.dgit.domain.TestQuestionVO;
import com.dgit.domain.UserVO;
import com.dgit.interceptor.LoginInterceptor;
import com.dgit.service.GradeService;
import com.dgit.service.ImageService;
import com.dgit.service.TestExampleService;
import com.dgit.service.TestNameService;
import com.dgit.service.TestQuestionService;

@Controller
@RequestMapping("/mock_test/*")
public class MockTestController {
	private static final Logger logger = LoggerFactory.getLogger(MockTestController.class);
	
	@Autowired
	private TestNameService nameService;
	@Autowired
	private TestExampleService exampleService;
	@Autowired
	private TestQuestionService questionService;
	@Autowired
	private ImageService imageServie;
	@Autowired
	private GradeService gradeService;
	
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String mockTestHomeGET(){
		logger.info("mockTestHome GET......................");
		
		return "mock_test/mock_test_home";
	}//mockTestHomeGET
	
	@RequestMapping(value="/start_test/{tno}", method=RequestMethod.GET)
	public String startTestGet(@PathVariable("tno") int tno, Model model) throws Exception{
		logger.info("startTest GET......................");
		
		TestNameVO testName = nameService.selectOneTestName(tno);
		List<TestQuestionVO> questionList = questionService.selectAllTestQuestionForMock(tno);
		
		for(int i=0; i<questionList.size(); i++){
			TestQuestionVO question = questionList.get(i);
			int tq_no = question.getTq_no();
			List<TestExampleVO> exampleList = exampleService.selectAllTestExampleByTqNo(tq_no);
			List<ImageVO> imageList = imageServie.selectImageByTqNo(tq_no);
			
			question.setExampleList(exampleList);
			question.setImageList(imageList);
		}
		
		model.addAttribute("testName", testName);
		return "mock_test/start_test";
	}//startTestGet
	
	@RequestMapping(value="/test_result", method=RequestMethod.POST)
	public String testResultPost(HttpServletRequest req, int tno, int[] tq_no, int[] sa_answer, Model model) throws Exception{
		logger.info("testResult Post......................");
		
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		TestNameVO testName = nameService.selectOneTestName(tno);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(new Date());
		
		for(int i = 0; i < tq_no.length; i++){
			SelectedAnswerVO answer = new SelectedAnswerVO();
			TestQuestionVO question = questionService.selectOneTestQuestionByTqno(tq_no[i]);
			
			answer.setTestName(testName);
			answer.setQuestion(question);
			answer.setUser(user);
			answer.setSa_date(date);
		}
		
		model.addAttribute("tq_noList", tq_no);
		model.addAttribute("sa_answerList", sa_answer);
		return "mock_test/test_result";
	}//testResultPost
	
	@ResponseBody
	@RequestMapping(value="/latestTestName", method=RequestMethod.POST)
	public ResponseEntity<TestNameVO> latestTestName(HttpServletRequest req) throws Exception{
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		ResponseEntity<TestNameVO> entity = null;
		
		List<GradeVO> gradeList = gradeService.selectAllGradeLatest(user.getUid());
		
		try {
			TestNameVO testName = null;
			if (gradeList.size() > 0) {
				int tno = gradeList.get(0).getTestName().getTno();
				testName = nameService.selectOneTestName(tno);
			}
			
			entity = new ResponseEntity<>(testName, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//latestTestName
	
	@ResponseBody
	@RequestMapping(value = "/getQuestionAndExampleByTno/{tno}", method = RequestMethod.POST)
	public ResponseEntity<List<TestQuestionVO>> getQuestionAndExampleByTno(@PathVariable("tno") int tno) throws Exception{
		logger.info("getQuestionAndExampleByTno................................");
		
		ResponseEntity<List<TestQuestionVO>> entity = null;
		
		TestNameVO testName = nameService.selectOneTestName(tno);
		List<TestQuestionVO> questionList = questionService.selectAllTestQuestionForMock(tno);
		
		for(int i=0; i<questionList.size(); i++){
			TestQuestionVO question = questionList.get(i);
			question.setTestName(testName);
			
			int tq_no = question.getTq_no();
			List<TestExampleVO> exampleList = exampleService.selectAllTestExampleByTqNo(tq_no);
			List<ImageVO> imageList = imageServie.selectImageByTqNo(tq_no);
			
			question.setExampleList(exampleList);
			question.setImageList(imageList);
		}
		
		try {
			entity = new ResponseEntity<>(questionList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getQuestionAndExampleByTno
	
}
