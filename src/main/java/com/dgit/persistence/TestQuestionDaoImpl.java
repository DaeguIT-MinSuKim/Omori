package com.dgit.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.TestQuestionVO;

@Repository
public class TestQuestionDaoImpl implements TestQuestionDao{
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.dgit.mapper.TestQuestionMapper";
	
	@Override
	public List<TestQuestionVO> selectAllTestQuestionForMock(int tno) throws Exception {
		return session.selectList(namespace + ".selectAllTestQuestionForMock", tno);
	}

	@Override
	public List<TestQuestionVO> selectAllTestQuestionForSubject(TestQuestionVO vo) throws Exception {
		return session.selectList(namespace + ".selectAllTestQuestionForSubject", vo);
	}

	@Override
	public TestQuestionVO selectOneTestQuestion(int tno, int tq_small_no) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("tno",tno);
		paramMap.put("tq_small_no", tq_small_no);
		return session.selectOne(namespace + ".selectOneTestQuestion", paramMap);
	}

	@Override
	public void insertTestQuestion(TestQuestionVO vo) throws Exception {
		session.insert(namespace+".insertTestQuestion", vo);
	}


}
