package com.dgit.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.GradeVO;

@Repository
public class GradeDaoImpl implements GradeDao{
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.dgit.mapper.GradeMapper";
	
	@Override
	public void insertGrade(GradeVO vo) throws Exception {
		session.insert(namespace + ".insertGrade", vo);
	}

	@Override
	public GradeVO selectOneGradeLatest(String uid) throws Exception {
		return session.selectOne(namespace + ".selectOneGradeLatest", uid);
	}
}
