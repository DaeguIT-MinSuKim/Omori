package com.dgit.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import com.dgit.domain.NowGradeVO;
import com.dgit.domain.SelectedAnswerVO;
import com.dgit.domain.TestExampleVO;
import com.dgit.domain.TestNameVO;
import com.dgit.domain.TestQuestionVO;
import com.dgit.domain.UserVO;
import com.dgit.interceptor.LoginInterceptor;
import com.dgit.service.GradeService;
import com.dgit.service.ImageService;
import com.dgit.service.NowGradeService;
import com.dgit.service.SelectedAnswerService;
import com.dgit.service.TestExampleService;
import com.dgit.service.TestNameService;
import com.dgit.service.TestQuestionService;

@Controller
@RequestMapping(value = "/subject_test/*")
public class SubjectTestController {
	@Autowired
	private GradeService gradeService;
	@Autowired
	private TestNameService nameService;
	@Autowired
	private TestQuestionService questionService;
	@Autowired
	private TestExampleService exampleService;
	@Autowired
	private ImageService imageService;
	@Autowired
	private NowGradeService nowService;
	@Autowired
	private SelectedAnswerService answerService;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String subjectTestHomeGET(HttpServletRequest req, Model model) throws Exception{
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		GradeVO grade = gradeService.selectOneGradeLatest(user.getUid());
		if(grade != null){
			TestNameVO testName = nameService.selectOneTestName(grade.getTestName().getTno());
			model.addAttribute("testName", testName);
		}
		
		List<TestNameVO> testNameList = nameService.selectAllTestName();
		model.addAttribute("testNameList", testNameList);
		
		return "subject_test/subject_test_home";
	}//subjectTestHomeGET
	
	@RequestMapping(value="/{tno}/{subject}", method=RequestMethod.GET)
	public String startSubjectTestGET(@PathVariable("tno") int tno, @PathVariable("subject") String subject, Model model) throws Exception{
		TestNameVO testName = nameService.selectOneTestName(tno);
		model.addAttribute("testName", testName);
		model.addAttribute("subject", subject);
		
		return "subject_test/start_subjectTest";
	}//startSubjectTestGET
	
	@RequestMapping(value="/result_subjectTest", method=RequestMethod.POST)
	public String result_subjectTest(HttpServletRequest req, int tno, int[] tq_no, int[] sa_answer, String tq_subject, Model model) throws Exception{
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		for(int i = 0; i < tq_no.length; i++){
			SelectedAnswerVO answer = new SelectedAnswerVO();
			answer.setUser(user);
			answer.setTq_no(tq_no[i]);
			answer.setSa_answer(sa_answer[i]);
			answer.setSa_date(new Date());
			
			answerService.insertSelectedAnswer(answer);
		}
		
		TestNameVO testName = nameService.selectOneTestName(tno);
		model.addAttribute("testName", testName);
		model.addAttribute("subject", tq_subject);
		
		return "subject_test/result_subjectTest";
	}//result_subjectTest
	
	@ResponseBody
	@RequestMapping(value="/getQueAndExBySubject", method=RequestMethod.POST)
	public ResponseEntity<List<TestQuestionVO>> getQueAndExBySubject(int tno, String tq_subject) throws Exception{
		ResponseEntity<List<TestQuestionVO>> entity = null;
		
		TestNameVO testName = nameService.selectOneTestName(tno);
		List<TestQuestionVO> questionList = questionService.selectAllTestQuestionForSubject(tno, tq_subject);
		
		for(int i=0; i<questionList.size(); i++){
			TestQuestionVO question = questionList.get(i);
			question.setTestName(testName);
			
			int tq_no = question.getTq_no();
			List<TestExampleVO> exampleList = exampleService.selectAllTestExampleByTqNo(tq_no);
			List<ImageVO> imageList = imageService.selectImageByTqNo(tq_no);
			
			question.setExampleList(exampleList);
			question.setImageList(imageList);
		}
		
		try {
			entity = new ResponseEntity<>(questionList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getQueAndExBySubject
	
	@ResponseBody
	@RequestMapping(value="/getMarkSubjectTest", method=RequestMethod.POST)
	public ResponseEntity<List<TestQuestionVO>> getMarkSubjectTest(HttpServletRequest req, int tno, String tq_subject) throws Exception{
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		ResponseEntity<List<TestQuestionVO>> entity = null;
		
		try {
			List<TestQuestionVO> questionWithAnswerList = questionService.selectQuestionAndAnswerBySubjectWithNote(tno, user.getUid(), tq_subject);
			nowService.insertNowGrade(questionWithAnswerList, user);
			
			entity = new ResponseEntity<>(questionWithAnswerList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getMarkSubjectTest
	
	@ResponseBody
	@RequestMapping(value="/getNowGrade", method=RequestMethod.POST)
	public ResponseEntity<NowGradeVO> getNowGrade(HttpServletRequest req, int tno, String tq_subject) throws Exception{
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		ResponseEntity<NowGradeVO> entity = null;
		
		try {
			NowGradeVO now = nowService.selectOneNowGradeLatest(tno, tq_subject, user);
			
			entity = new ResponseEntity<>(now, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getNowGrade
	
}
