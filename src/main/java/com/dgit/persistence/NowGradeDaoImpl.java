package com.dgit.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.NowGradeVO;

@Repository
public class NowGradeDaoImpl implements NowGradeDao{
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.dgit.mapper.NowGradeMapper";

	@Override
	public NowGradeVO selectOneNowGradeLatest(NowGradeVO vo) throws Exception {
		return session.selectOne(namespace + ".selectOneNowGradeLatest", vo);
	}

	@Override
	public void insertNowGrade(NowGradeVO vo) throws Exception {
		session.insert(namespace+".insertNowGrade", vo);
	}

}
