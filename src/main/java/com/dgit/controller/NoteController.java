package com.dgit.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dgit.domain.NoteVO;
import com.dgit.domain.UserVO;
import com.dgit.interceptor.LoginInterceptor;
import com.dgit.service.NoteService;

@Controller
@RequestMapping("/note/")
public class NoteController {
	private static final Logger logger = LoggerFactory.getLogger(NoteController.class);

	@Autowired
	private NoteService noteService;

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
