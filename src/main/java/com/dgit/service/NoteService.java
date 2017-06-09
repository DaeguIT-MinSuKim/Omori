package com.dgit.service;

import java.util.List;

import com.dgit.domain.NoteVO;

public interface NoteService {
	void insertNote(NoteVO vo) throws Exception;
	List<NoteVO> selectAllNoteByTno(String uid, int tno) throws Exception;
	NoteVO selectOneNoteByTnoTqno(String uid, int tno, int tq_no) throws Exception;
	void updateNote(NoteVO vo) throws Exception;
	void deleteNote(int note_no) throws Exception;
}
