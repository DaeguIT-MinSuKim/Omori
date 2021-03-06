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
	public List<GradeVO> selectAllGradeGroupByTno(String uid, int tno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("tno", tno);
		return session.selectList(namespace+".selectAllGradeGroupByTno", map);
	}

	@Override
	public List<String> selectGradeDate(String uid, int tno) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("tno", tno);
		return session.selectList(namespace+".selectGradeDate", map);
	}

	@Override
	public List<GradeVO> selectListGradeByDate(String uid, int tno, String g_date) throws Exception{
		Map<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("tno", tno);
		map.put("g_date", g_date);
		return session.selectList(namespace+".selectListGradeByDate", map);
	}

	@Override
	public List<GradeVO> selectListGradeBySubject(String uid, int tno, String g_subject) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("uid", uid);
		map.put("tno", tno);
		map.put("g_subject", g_subject);
		return session.selectList(namespace+".selectListGradeBySubject", map);
	}
}
