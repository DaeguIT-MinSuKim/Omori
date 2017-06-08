package com.dgit.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.SelectedAnswerVO;

@Repository
public class SelectedAnswerDaoImpl implements SelectedAnswerDao{
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.dgit.mapper.SelectedAnswerMapper";

	@Override
	public SelectedAnswerVO selectOneAnswerByTqno(int tq_no, String uid) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("tq_no", tq_no);
		map.put("uid", uid);
		return session.selectOne(namespace + ".selectOneAnswerByTqno", map);
	}

	@Override
	public void insertSelectedAnswer(SelectedAnswerVO vo) throws Exception {
		session.insert(namespace + ".insertSelectedAnswer", vo);
	}

}
