package com.dgit.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.NoteVO;

@Repository
public class NoteDaoImpl implements NoteDao{
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.dgit.mapper.NoteMapper";

	@Override
	public void insertNote(NoteVO vo) throws Exception {
		session.insert(namespace + ".insertNote", vo);
	}

	@Override
	public List<NoteVO> selectAllNoteByTno(String uid, int tno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("tno", tno);
		return session.selectList(namespace+".selectAllNoteByTno", map);
	}

	@Override
	public NoteVO selectOneNoteByTnoTqno(String uid, int tno, int tq_no) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("tno", tno);
		map.put("tq_no", tq_no);
		return session.selectOne(namespace + ".selectOneNoteByTnoTqno", map);
	}

	@Override
	public void updateNote(NoteVO vo) throws Exception {
		session.update(namespace + ".updateNote", vo);
	}

	@Override
	public void deleteNote(int note_no) throws Exception {
		session.delete(namespace+".deleteNote", note_no);
	}

	@Override
	public List<Integer> selectAllNoteDistinctTno(String uid) throws Exception {
		return session.selectList(namespace + ".selectAllNoteDistinctTno", uid);
	}
}
