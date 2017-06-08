package com.dgit.persistence;

import java.util.List;

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
	public List<SelectedAnswerVO> selectAllAnswerByTnoDate(SelectedAnswerVO vo) throws Exception {
		return session.selectList(namespace + ".selectAllAnswerByTnoDate", vo);
	}

	@Override
	public void insertSelectedAnswer(SelectedAnswerVO vo) throws Exception {
		session.insert(namespace + ".insertSelectedAnswer", vo);
	}

}
