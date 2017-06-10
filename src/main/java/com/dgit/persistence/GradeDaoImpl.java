package com.dgit.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public int countSaveNo() throws Exception {
		return session.selectOne(namespace + ".countSaveNo");
	}

	@Override
	public List<Integer> selectTnoForGrade(String uid) throws Exception {
		return session.selectList(namespace+ ".selectTnoForGrade", uid);
	}

	@Override
	public List<GradeVO> selectAllGradeByTno(String uid, int tno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("tno", tno);
		return session.selectList(namespace+".selectAllGradeByTno", map);
	}
}
