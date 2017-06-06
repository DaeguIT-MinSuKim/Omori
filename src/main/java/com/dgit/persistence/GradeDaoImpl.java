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
	public List<GradeVO> selectAllGradeLatest(String uid) throws Exception {
		return session.selectList(namespace + ".selectAllGradeLatest", uid);
	}
}
