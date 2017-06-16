package com.dgit.controller;

import java.util.ArrayList;
import java.util.Date;
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

import com.dgit.domain.NoteVO;
import com.dgit.domain.TestNameVO;
import com.dgit.domain.TestQuestionVO;
import com.dgit.domain.UserVO;
import com.dgit.interceptor.LoginInterceptor;
import com.dgit.service.NoteService;
import com.dgit.service.TestNameService;
import com.dgit.service.TestQuestionService;

@Controller
@RequestMapping("/note/")
public class NoteController {
	@Autowired
	private NoteService noteService;
	@Autowired
	private TestNameService nameService;
	@Autowired
	private TestQuestionService questionService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String noteHomeGET(HttpServletRequest req, Model model) throws Exception{
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		List<TestNameVO> testNameList = new ArrayList<>();
		List<Integer> tnoList = noteService.selectAllNoteDistinctTno(user.getUid());
		
		for (Integer i : tnoList) {
			TestNameVO name = nameService.selectOneTestName(i);
			testNameList.add(name);
		}
		
		if(testNameList.size() > 0){
			model.addAttribute("testNameList", testNameList);
			model.addAttribute("firstTestName", testNameList.get(0));
		}
		
		return "note/note_home";
	}
	
	@ResponseBody
	@RequestMapping(value="/getQuestionAnswerNote", method=RequestMethod.POST)
	public ResponseEntity<List<TestQuestionVO>> getQuestionAnswerNote(HttpServletRequest req, int tno) throws Exception{
		ResponseEntity<List<TestQuestionVO>> entity = null;
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);
		
		try {
			List<TestQuestionVO> questionWithAnswerList = questionService.selectQuestionAndAnswerWithNotePercent(tno, user.getUid());
			
			entity = new ResponseEntity<>(questionWithAnswerList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getQuestionAnswerNote

	@ResponseBody
	@RequestMapping(value="/insertNotePost", method=RequestMethod.POST)
	public ResponseEntity<String> insertNotePost(HttpServletRequest req, int tno, int tq_no, String note_content, String note_memo) throws Exception{
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);

		ResponseEntity<String> entity = null;
		
		NoteVO vo = new NoteVO();
		vo.setUser(user);
		vo.setTno(tno);
		vo.setTq_no(tq_no);
		vo.setNote_content(note_content);
		vo.setNote_memo(note_memo);
		vo.setNote_date(new Date());
		
		try {
			noteService.insertNote(vo);
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//insertNotePost
	
	@ResponseBody
	@RequestMapping(value="/updateNotePost", method=RequestMethod.POST)
	public ResponseEntity<String> updateNotePost(HttpServletRequest req, int tno, int tq_no, String note_content, String note_memo) throws Exception{
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);

		ResponseEntity<String> entity = null;
		
		NoteVO vo = noteService.selectOneNoteByTnoTqno(user.getUid(), tno, tq_no);
		vo.setNote_content(note_content);
		vo.setNote_memo(note_memo);
		
		try {
			noteService.updateNote(vo);
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//updateNotePost
	
	@ResponseBody
	@RequestMapping(value="/deleteNotePost", method=RequestMethod.POST)
	public ResponseEntity<String> deleteNotePost(HttpServletRequest req, int tno, int tq_no) throws Exception{
		UserVO user = (UserVO) req.getSession().getAttribute(LoginInterceptor.LOGIN);

		ResponseEntity<String> entity = null;
		
		NoteVO vo = noteService.selectOneNoteByTnoTqno(user.getUid(), tno, tq_no);
		
		try {
			noteService.deleteNote(vo.getNote_no());
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//deleteNotePost
}
