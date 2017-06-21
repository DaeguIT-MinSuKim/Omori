package com.dgit.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dgit.domain.GradeVO;
import com.dgit.domain.ImageVO;
import com.dgit.domain.NoteVO;
import com.dgit.domain.SelectedAnswerVO;
import com.dgit.domain.TestExampleVO;
import com.dgit.domain.TestNameVO;
import com.dgit.domain.TestQuestionVO;
import com.dgit.domain.UserVO;
import com.dgit.interceptor.LoginInterceptor;
import com.dgit.service.GradeService;
import com.dgit.service.ImageService;
import com.dgit.service.NoteService;
import com.dgit.service.NowGradeService;
import com.dgit.service.SelectedAnswerService;
import com.dgit.service.TestExampleService;
import com.dgit.service.TestNameService;
import com.dgit.service.TestQuestionService;
import com.dgit.service.UserService;
import com.fasterxml.jackson.core.Base64Variant;
import com.fasterxml.jackson.core.JsonLocation;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonStreamContext;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.core.ObjectCodec;
import com.fasterxml.jackson.core.Version;
import com.fasterxml.jackson.core.io.JsonStringEncoder;
import com.fasterxml.jackson.core.JsonParser.NumberType;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;

@Controller
@RequestMapping(value = "/android/*")
public class AndroidController {
	@Autowired
	private TestQuestionService questionService;
	@Autowired
	private TestNameService nameService;
	@Autowired
	private TestExampleService exampleService;
	@Autowired 
	private ImageService imageService;
	@Autowired
	private UserService userService;
	@Autowired
	private SelectedAnswerService answerService;
	@Autowired
	private NowGradeService nowService;
	@Autowired
	private NoteService noteService;
	@Autowired
	private GradeService gradeService;
	
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
	}//selectAllSubject
	
	@ResponseBody
	@RequestMapping(value = "/mockTestStart", method = RequestMethod.POST)
	public ResponseEntity<List<TestQuestionVO>> mockTestStart(HttpServletRequest req){
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
	}//mockTestStart
	
	@ResponseBody
	@RequestMapping(value = "/mockTestResultBySubject", method = RequestMethod.POST)
	public ResponseEntity<List<TestQuestionVO>> mockTestResultBySubject(HttpServletRequest req) throws Exception{
		ResponseEntity<List<TestQuestionVO>> entity = null;
		
		//params
		String uid = req.getParameter("user");
		int tno = Integer.parseInt(req.getParameter("tno"));
		String subject = req.getParameter("subject");
		String tqNoStr = req.getParameter("tqNoList");
		String selAnswerStr = req.getParameter("selAnswerList");
		
		//jsonarray to list
		ArrayList<Integer> tqNoList = new ObjectMapper().readValue(tqNoStr, ArrayList.class);
		ArrayList<String> selAnswerList = new ObjectMapper().readValue(selAnswerStr, ArrayList.class);
		
		UserVO user = userService.selectOneUserByUid(uid);
		
		try {
			for(int i = 0; i < tqNoList.size(); i++){
				int tq_no = tqNoList.get(i);
				int sa_answer = Integer.parseInt(selAnswerList.get(i));
				
				SelectedAnswerVO answer = new SelectedAnswerVO();
				answer.setUser(user);
				answer.setTq_no(tq_no);
				answer.setSa_answer(sa_answer);
				answer.setSa_date(new Date());
				
				answerService.insertSelectedAnswer(answer);
			}
			
			List<TestQuestionVO> questionWithAnswerList = questionService.selectQuestionAndAnswerBySubjectWithNote(tno, user.getUid(), subject);
			nowService.insertNowGrade(questionWithAnswerList, user);
			
			System.out.println("★★★★★★★★★★mockTestResultBySubject★★★★★★★★★★");
			entity = new ResponseEntity<>(questionWithAnswerList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//mockTestResultBySubject
	
	@ResponseBody
	@RequestMapping(value="/note/updateNote", method=RequestMethod.POST)
	public ResponseEntity<String> updateNote(HttpServletRequest req) throws Exception{
		ResponseEntity<String> entity = null;
		
		//params
		String uid = req.getParameter("uid");
		int tno = Integer.parseInt(req.getParameter("tno"));
		int tq_no = Integer.parseInt(req.getParameter("tq_no"));
		String note_content = req.getParameter("note_content");
		String note_memo = req.getParameter("note_memo");
		
		UserVO user = userService.selectOneUserByUid(uid);
		
		NoteVO vo = noteService.selectOneNoteByTnoTqno(user.getUid(), tno, tq_no);
		vo.setNote_content(note_content);
		vo.setNote_memo(note_memo);
		
		try {
			noteService.updateNote(vo);
			
			System.out.println("★★★★★/note/updateNote★★★★★");
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//updateNote
	
	@ResponseBody
	@RequestMapping(value="/note/deleteNote", method=RequestMethod.POST)
	public ResponseEntity<String> deleteNote(HttpServletRequest req) throws Exception{
		ResponseEntity<String> entity = null;
		
		//params
		String uid = req.getParameter("uid");
		int tno = Integer.parseInt(req.getParameter("tno"));
		int tq_no = Integer.parseInt(req.getParameter("tq_no"));
		
		UserVO user = userService.selectOneUserByUid(uid);
		NoteVO vo = noteService.selectOneNoteByTnoTqno(user.getUid(), tno, tq_no);
		
		try {
			noteService.deleteNote(vo.getNote_no());
			
			System.out.println("★★★★★/note/deleteNote★★★★★");
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//deleteNote
	
	@ResponseBody
	@RequestMapping(value="/note/insertNote", method=RequestMethod.POST)
	public ResponseEntity<String> insertNote(HttpServletRequest req) throws Exception{
		ResponseEntity<String> entity = null;
		
		//params
		String uid = req.getParameter("uid");
		int tno = Integer.parseInt(req.getParameter("tno"));
		int tq_no = Integer.parseInt(req.getParameter("tq_no"));
		String note_content = req.getParameter("note_content");
		String note_memo = req.getParameter("note_memo");
		
		UserVO user = userService.selectOneUserByUid(uid);
		
		NoteVO vo = new NoteVO();
		vo.setUser(user);
		vo.setTno(tno);
		vo.setTq_no(tq_no);
		vo.setNote_content(note_content);
		vo.setNote_memo(note_memo);
		vo.setNote_date(new Date());
		
		try {
			noteService.insertNote(vo);
			
			System.out.println("★★★★★/note/insertNote★★★★★");
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//insertNote
	
	@ResponseBody
	@RequestMapping(value="/grade/insertGrade", method=RequestMethod.POST)
	public ResponseEntity<String> insertGrade(HttpServletRequest req) throws Exception{
		ResponseEntity<String> entity = null;
		
		//params
		String uid = req.getParameter("uid");
		int tno = Integer.parseInt(req.getParameter("tno"));
		int finalGrade = Integer.parseInt(req.getParameter("finalGrade"));
		String subjectStr = req.getParameter("subjectList");
		String gradeStr = req.getParameter("gradeList");
		
		
		UserVO user = userService.selectOneUserByUid(uid);
		
		TestNameVO testName = nameService.selectOneTestName(tno);
		
		ObjectMapper om = new ObjectMapper();
		ArrayList<String> subjectList = om.readValue(subjectStr, ArrayList.class);
		ArrayList<Integer> gradeForSubjList = om.readValue(gradeStr, ArrayList.class);
		
		List<GradeVO> gradeList = new ArrayList<>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd H:m");
		String date = sdf.format(new Date());
		
		int g_save_no = gradeService.countSaveNo();
		
		for (int i = 0; i < subjectList.size(); i++) {
			String subject = subjectList.get(i);
			int subjectGrade = gradeForSubjList.get(i);
			
			GradeVO vo = new GradeVO();
			vo.setUser(user);
			vo.setTestName(testName);
			vo.setG_save_no(g_save_no);
			vo.setGrade(finalGrade);
			vo.setG_subject(subject);
			vo.setG_subject_grade(subjectGrade);
			vo.setG_date(date);
			
			gradeList.add(vo);
		}
		
		try {
			gradeService.insertGrade(gradeList);
			
			System.out.println("★★★★★/grade/insertGrade★★★★★");
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//insertGrade
	
	@ResponseBody
	@RequestMapping(value = "/note/getNoteTestNameList", method = RequestMethod.POST)
	public ResponseEntity<List<TestNameVO>> noteTestNameList(HttpServletRequest req) throws Exception{
		ResponseEntity<List<TestNameVO>> entity = null;
		
		//params
		String uid = req.getParameter("uid");
		
		UserVO user = userService.selectOneUserByUid(uid.trim());
		
		try {
			List<TestNameVO> testNameList = new ArrayList<>();
			List<Integer> tnoList = noteService.selectAllNoteDistinctTno(user.getUid());
			
			for (Integer i : tnoList) {
				TestNameVO name = nameService.selectOneTestName(i);
				testNameList.add(name);
			}
			
			System.out.println("★★★★★/note/getNoteTestNameList★★★★★");
			entity = new ResponseEntity<>(testNameList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getNoteTestNameList
	
	@ResponseBody
	@RequestMapping(value="/note/getQuestionAndNote", method=RequestMethod.POST)
	public ResponseEntity<List<TestQuestionVO>> getQuestionAnswerNote(HttpServletRequest req) throws Exception{
		ResponseEntity<List<TestQuestionVO>> entity = null;
		
		//params
		String uid = req.getParameter("uid");
		int tno = Integer.parseInt(req.getParameter("tno"));
		
		UserVO user = userService.selectOneUserByUid(uid);
		
		try {
			List<TestQuestionVO> questionWithAnswerList = questionService.selectQuestionAndAnswerWithNotePercent(tno, user.getUid());
			
			System.out.println("★★★★★/note/getQuestionAnswerNote★★★★★");
			entity = new ResponseEntity<>(questionWithAnswerList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getQuestionAnswerNote
	
	@ResponseBody
	@RequestMapping(value="/grade/getGradeGroupByTno", method=RequestMethod.POST)
	public ResponseEntity<List<GradeVO>> getGradeGroupByTno(HttpServletRequest req) throws Exception{
		ResponseEntity<List<GradeVO>> entity = null;
		
		//params
		String uid = req.getParameter("uid");
		int tno = Integer.parseInt(req.getParameter("tno"));
		
		UserVO user = userService.selectOneUserByUid(uid);
		
		try {
			TestNameVO testName = nameService.selectOneTestName(tno);
			List<GradeVO> gradeList = gradeService.selectAllGradeGroupByTno(user.getUid(), tno);
			for (GradeVO gradeVO : gradeList) {
				gradeVO.setTestName(testName);
			}
			
			System.out.println("★★★★★/grade/getGradeGroupByTno★★★★★");
			entity = new ResponseEntity<>(gradeList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getGradeGroupByTno
}
