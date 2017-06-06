package com.dgit.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.TestNameVO;

@Repository
public class TestNameDaoImpl implements TestNameDao{
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.dgit.mapper.TestNameMapper";

	@Override
	public List<TestNameVO> selectAllTestName() throws Exception {
		return session.selectList(namespace + ".selectAllTestName");
	}

	@Override
	public TestNameVO selectOneTestName(int tno) throws Exception {
		return session.selectOne(namespace + ".selectOneTestName", tno);
	}

	@Override
	public void insertTestName(TestNameVO vo) throws Exception {
		session.insert(namespace+".insertTestName", vo);
	}
}
