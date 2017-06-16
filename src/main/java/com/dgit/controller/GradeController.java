package com.dgit.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String gradeGET(HttpServletRequest req, Model model) throws Exception{
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		List<TestNameVO> testNameList = gradeService.selectTnoForGrade(user.getUid());
		
		if (testNameList != null) {
			model.addAttribute("testNameList", testNameList);
			model.addAttribute("testName", testNameList.get(0));

			List<String> dateList = gradeService.selectGradeDate(user.getUid(), testNameList.get(0).getTno());
			
			model.addAttribute("dateList", dateList);
		}
		
		return "grade/grade_home";
	}//gradeGET
	
	@ResponseBody
	@RequestMapping(value="/insertGradeAll", method=RequestMethod.POST)
	public ResponseEntity<String> insertGradeAll(HttpServletRequest req, int tno, int grade, String arrSubject, String arrSubjectGrade) throws Exception{
		ResponseEntity<String> entity = null;
		
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		TestNameVO testName = nameService.selectOneTestName(tno);
		
		String[] subjectList = arrSubject.split(",");
		String[] subjectGradeList = arrSubjectGrade.split(",");
		List<GradeVO> gradeList = new ArrayList<>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd H:m");
		String date = sdf.format(new Date());
		
		int g_save_no = gradeService.countSaveNo();
		
		for (int i = 0; i < subjectList.length; i++) {
			String subject = subjectList[i];
			int subjectGrade = Integer.parseInt(subjectGradeList[i]);
			
			GradeVO vo = new GradeVO();
			vo.setUser(user);
			vo.setTestName(testName);
			vo.setG_save_no(g_save_no);
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
	}//insertGradePost
	
	@ResponseBody
	@RequestMapping(value="/insertGradeOnlySubject", method=RequestMethod.POST)
	public ResponseEntity<String> insertGradeOnlySubject(HttpServletRequest req, int tno, int grade, String subject, String subjectGrade) throws Exception{
		ResponseEntity<String> entity = null;
		
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		TestNameVO testName = nameService.selectOneTestName(tno);
		
		List<GradeVO> gradeList = new ArrayList<>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd H:m");
		String date = sdf.format(new Date());
		
		int g_save_no = gradeService.countSaveNo();
		int subjGrade = Integer.parseInt(subjectGrade);
			
		GradeVO vo = new GradeVO();
		vo.setUser(user);
		vo.setTestName(testName);
		vo.setG_save_no(g_save_no);
		vo.setGrade(grade);
		vo.setG_subject(subject);
		vo.setG_subject_grade(subjGrade);
		vo.setG_date(date);
			
		gradeList.add(vo);
		
		try {
			gradeService.insertGrade(gradeList);
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//insertGradeOnlySubject
	
	@ResponseBody
	@RequestMapping(value="/getGradeGroupByTno", method=RequestMethod.POST)
	public ResponseEntity<List<GradeVO>> getGradeGroupByTno(HttpServletRequest req, int tno){
		ResponseEntity<List<GradeVO>> entity = null;
		
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		try {
			TestNameVO testName = nameService.selectOneTestName(tno);
			List<GradeVO> gradeList = gradeService.selectAllGradeGroupByTno(user.getUid(), tno);
			for (GradeVO gradeVO : gradeList) {
				gradeVO.setTestName(testName);
			}
			
			entity = new ResponseEntity<>(gradeList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getGradeGroupByTno
	
	@ResponseBody
	@RequestMapping(value="/getDateList", method=RequestMethod.POST)
	public ResponseEntity<List<String>> getDateList(HttpServletRequest req, int tno) throws Exception{
		ResponseEntity<List<String>> entity = null;
		
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		TestNameVO testName = nameService.selectOneTestName(tno);
		
		try {
			List<String> dateList = new ArrayList<>();
			List<String> tempList = gradeService.selectGradeDate(user.getUid(), tno);
			
			if(testName.getTname().contains("정보처리기사")){
				System.out.println("정보처리산업기사");
				for (String date : tempList) {
					List<GradeVO> gradeList = gradeService.selectListGradeByDate(user.getUid(), tno, date);
					
					if(gradeList.size() > 1){
						dateList.add(date);
					}
				}
			}
			
			entity = new ResponseEntity<>(dateList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getDateList
	
	@ResponseBody
	@RequestMapping(value="/getGradeListByDate", method=RequestMethod.POST)
	public ResponseEntity<List<GradeVO>> getGradeListByDate(HttpServletRequest req, int tno, String g_date){
		ResponseEntity<List<GradeVO>> entity = null;
		
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		try {
			TestNameVO testName = nameService.selectOneTestName(tno);
			List<GradeVO> list = gradeService.selectListGradeByDate(user.getUid(), tno, g_date);
			for (GradeVO gradeVO : list) {
				gradeVO.setTestName(testName);
			}
			
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getGradeListByDate
	
	@ResponseBody
	@RequestMapping(value="/getGradeListBySubject", method=RequestMethod.POST)
	public ResponseEntity<List<GradeVO>> getGradeListBySubject(HttpServletRequest req, int tno, String g_subject){
		ResponseEntity<List<GradeVO>> entity = null;
		
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		try {
			TestNameVO testName = nameService.selectOneTestName(tno);
			List<GradeVO> list = gradeService.selectListGradeBySubject(user.getUid(), tno, g_subject);
			for (GradeVO gradeVO : list) {
				gradeVO.setTestName(testName);
			}
			
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getGradeListBySubject
	
}
