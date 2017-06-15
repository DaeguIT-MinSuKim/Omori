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
	public List<TestQuestionVO> selectAllTestQuestionForSubject(int tno, String tq_subject) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("tno",tno);
		paramMap.put("tq_subject", tq_subject);
		return session.selectList(namespace + ".selectAllTestQuestionForSubject", paramMap);
	}

	@Override
	public TestQuestionVO selectOneTestQuestion(int tno, int tq_small_no) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("tno",tno);
		paramMap.put("tq_small_no", tq_small_no);
		return session.selectOne(namespace + ".selectOneTestQuestion", paramMap);
	}
	
	@Override
	public TestQuestionVO selectOneTestQuestionByTqno(int tq_no) throws Exception {
		return session.selectOne(namespace + ".selectOneTestQuestionByTqno", tq_no);
	}

	@Override
	public List<String> selectOnlySubject(int tno) throws Exception {
		return session.selectList(namespace + ".selectOnlySubject", tno);
	}

	@Override
	public void insertTestQuestion(TestQuestionVO vo) throws Exception {
		session.insert(namespace+".insertTestQuestion", vo);
	}

	@Override
	public int selectCountBySubject(int tno, String tq_subject) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("tno", tno);
		map.put("tq_subject", tq_subject);
		return session.selectOne(namespace + ".selectCountBySubject", map);
	}

	@Override
	public int selectLastTqno() throws Exception {
		return session.selectOne(namespace + ".selectLastTqno");
	}

	@Override
	public List<Integer> selectAllTqSmallNoByTno(int tno) throws Exception {
		return session.selectList(namespace + ".selectAllTqSmallNoByTno", tno);
	}

	@Override
	public void initAutoIncrementQue(int num) throws Exception {
		session.update(namespace+".initAutoIncrementQue", num);
	}

	@Override
	public void deleteTestQuestion(int tq_no) throws Exception {
		session.delete(namespace+".deleteTestQuestion", tq_no);
	}

	@Override
	public void updateTestQuestion(TestQuestionVO vo) throws Exception {
		session.update(namespace+".updateTestQuestion", vo);
	}
}
