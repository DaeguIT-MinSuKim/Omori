package com.dgit.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dgit.domain.GradeVO;
import com.dgit.domain.TestNameVO;
import com.dgit.domain.UserVO;
import com.dgit.interceptor.LoginInterceptor;
import com.dgit.service.GradeService;
import com.dgit.service.TestNameService;

@Controller
@RequestMapping("/grade/*")
public class GradeController {
	private static final Logger logger = LoggerFactory.getLogger(GradeController.class);
	
	@Autowired
	private GradeService gradeService;
	@Autowired
	private TestNameService nameService;
	
	@ResponseBody
	@RequestMapping(value="/insertGradePost", method=RequestMethod.POST)
	public ResponseEntity<String> insertGradePost(HttpServletRequest req, int tno, int grade, String arrSubject, String arrSubjectGrade) throws Exception{
		ResponseEntity<String> entity = null;
		
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		TestNameVO testName = nameService.selectOneTestName(tno);
		
		String[] subjectList = arrSubject.split(",");
		String[] subjectGradeList = arrSubjectGrade.split(",");
		List<GradeVO> gradeList = new ArrayList<>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd H:m");
		String date = sdf.format(new Date());
		
		for (int i = 0; i < subjectList.length; i++) {
			String subject = subjectList[i];
			int subjectGrade = Integer.parseInt(subjectGradeList[i]);
			
			GradeVO vo = new GradeVO();
			vo.setUser(user);
			vo.setTestName(testName);
			vo.setGrade(grade);
			vo.setG_subject(subject);
			vo.setG_subject_grade(subjectGrade);
			vo.setG_date(date);
			
			gradeList.add(vo);
		}
		
		try {
			gradeService.insertGrade(gradeList);
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
