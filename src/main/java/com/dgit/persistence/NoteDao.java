package com.dgit.persistence;

import java.util.List;

import com.dgit.domain.NoteVO;

public interface NoteDao {
	void insertNote(NoteVO vo) throws Exception;
	List<NoteVO> selectAllNoteByTno(String uid, int tno) throws Exception;
	NoteVO selectOneNoteByTnoTqno(String uid, int tno, int tq_no) throws Exception;
	void updateNote(NoteVO vo) throws Exception;
	void deleteNote(int note_no) throws Exception;
	List<Integer> selectAllNoteDistinctTno(String uid) throws Exception;
}
