package com.dgit.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dgit.domain.ImageVO;
import com.dgit.domain.TestExampleVO;
import com.dgit.domain.TestNameVO;
import com.dgit.domain.TestQuestionVO;
import com.dgit.service.ImageService;
import com.dgit.service.TestExampleService;
import com.dgit.service.TestNameService;
import com.dgit.service.TestQuestionService;

@Controller
@RequestMapping(value = "/android/*")
public class AndroidController {
	@Autowired
	private TestQuestionService questionService;
	@Autowired
	private TestNameService nameService;
	@Autowired
	private TestExampleService exampleService;
	@Autowired ImageService imageService;
	
	@ResponseBody
	@RequestMapping(value = "/selectAllSubject", method = RequestMethod.POST)
	public ResponseEntity<List<TestNameVO>> selectAllSubject(){
		ResponseEntity<List<TestNameVO>> entity = null;
		
		try {
			List<TestNameVO> testNameList = nameService.selectAllTestName();
			
			System.out.println("★★★★★★★★★★selectAllSubject★★★★★★★★★★");
			entity = new ResponseEntity<>(testNameList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	

	@ResponseBody
	@RequestMapping(value = "/mockTestStart", method = RequestMethod.POST)
	public ResponseEntity<List<TestQuestionVO>> androidTest(HttpServletRequest req){
		ResponseEntity<List<TestQuestionVO>> entity = null;
		
		int tno = Integer.parseInt(req.getParameter("tno"));
		String tq_subject = req.getParameter("subject");
		
		try {
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
			
			System.out.println("★★★★★★★★★★mockTestStart★★★★★★★★★★");
			
			entity = new ResponseEntity<>(questionList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
