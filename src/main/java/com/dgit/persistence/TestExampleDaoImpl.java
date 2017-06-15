package com.dgit.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public TestExampleVO selectOneTestExampleNotTeNo(int tq_no, int te_small_no) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("tq_no", tq_no);
		map.put("te_small_no", te_small_no);
		return session.selectOne(namespace+".selectOneTestExampleNotTeNo", map);
	}

	@Override
	public void deleteTestExampleByTqnoTesmallno(int tq_no, int te_small_no) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("tq_no", tq_no);
		map.put("te_small_no", te_small_no);
		session.delete(namespace+".deleteTestExampleByTqnoTesmallno", map);
	}

	@Override
	public TestExampleVO selectOneTestExampleByTeNo(int te_no) throws Exception {
		return session.selectOne(namespace+".selectOneTestExampleByTeNo", te_no);
	}

	@Override
	public void updateTestExample(TestExampleVO vo) throws Exception {
		session.update(namespace+".updateTestExample", vo);
	}
}
