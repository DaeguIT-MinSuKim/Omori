package com.dgit.persistence;

import java.util.List;

import javax.xml.stream.events.Namespace;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.TestExampleVO;

@Repository
public class TestExampleDaoImpl implements TestExampleDao {
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.dgit.mapper.TestExampleMapper";

	@Override
	public List<TestExampleVO> selectAllTestExampleByTqNo(int tq_no) throws Exception {
		return session.selectList(namespace+".selectAllTestExampleByTqNo", tq_no);
	}

	@Override
	public TestExampleVO selectOneTestExampleCorrectAnswer(int tq_no) throws Exception {
		return session.selectOne(namespace+".selectOneTestExampleCorrectAnswer", tq_no);
	}

	@Override
	public void insertTestExample(TestExampleVO vo) throws Exception {
		session.insert(namespace+".insertTestExample", vo);
	}

}
