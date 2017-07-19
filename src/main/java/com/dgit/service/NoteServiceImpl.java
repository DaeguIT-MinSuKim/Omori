package com.dgit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.NoteVO;
import com.dgit.persistence.NoteDao;

@Service
public class NoteServiceImpl implements NoteService{
	@Autowired
	private NoteDao dao;

	@Override
	public void insertNote(NoteVO vo) throws Exception {
		dao.insertNote(vo);
	}

	@Override
	public List<NoteVO> selectAllNoteByTno(String uid, int tno) throws Exception {
		return dao.selectAllNoteByTno(uid, tno);
	}

	@Override
	public NoteVO selectOneNoteByTnoTqno(String uid, int tno, int tq_no) throws Exception {
		return dao.selectOneNoteByTnoTqno(uid, tno, tq_no);
	}

	@Override
	public void updateNote(NoteVO vo) throws Exception {
		dao.updateNote(vo);
	}

	@Override
	public void deleteNote(int note_no) throws Exception {
		dao.deleteNote(note_no);
	}

	@Override
	public List<Integer> selectAllNoteDistinctTno(String uid) throws Exception {
		return dao.selectAllNoteDistinctTno(uid);
	}
}
