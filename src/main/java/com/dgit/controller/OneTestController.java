package com.dgit.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dgit.domain.GradeVO;
import com.dgit.domain.TestNameVO;
import com.dgit.domain.TestQuestionVO;
import com.dgit.domain.UserVO;
import com.dgit.interceptor.LoginInterceptor;
import com.dgit.service.GradeService;
import com.dgit.service.TestExampleService;
import com.dgit.service.TestNameService;
import com.dgit.service.TestQuestionService;

@Controller
@RequestMapping(value="/one_test/*")
public class OneTestController {
	@Autowired
	private GradeService gradeService;
	@Autowired
	private TestNameService nameService;
	@Autowired
	private TestQuestionService questionService;
	@Autowired
	private TestExampleService exampleService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String oneTestHomeGET(HttpServletRequest req, Model model) throws Exception{
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		GradeVO grade = gradeService.selectOneGradeLatest(user.getUid());
		if(grade != null){
			TestNameVO testName = nameService.selectOneTestName(grade.getTestName().getTno());
			model.addAttribute("testName", testName);
		}
		
		List<TestNameVO> testNameList = nameService.selectAllTestName();
		model.addAttribute("testNameList", testNameList);
		return "one_test/one_test_home";
	}//oneTestHomeGET
	
	@RequestMapping(value="/{tno}", method=RequestMethod.GET)
	public String startSubjectTestGET(@PathVariable("tno") int tno, Model model, HttpServletRequest req) throws Exception{
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		TestNameVO testName = nameService.selectOneTestName(tno);
		model.addAttribute("testName", testName);
		
		List<TestQuestionVO> questionList = new ArrayList<>();
		if(testName.getTname().contains("정보처리기사")){
			questionList = questionService.selectQuestionAndAnswerBySubjectWithNote(tno, user.getUid(), "데이터베이스");
		}
		
		model.addAttribute("questionList", questionList);
		return "one_test/start_oneTest";
	}//startSubjectTestGET
}
