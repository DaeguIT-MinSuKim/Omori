package com.dgit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.GradeVO;
import com.dgit.persistence.GradeDao;

@Service
public class GradeServiceImpl implements GradeService{
	@Autowired
	private GradeDao dao;

	@Override
	public void insertGrade(List<GradeVO> gradeList) throws Exception {
		for (GradeVO vo : gradeList) {
			dao.insertGrade(vo);
		}
	}

	@Override
	public GradeVO selectOneGradeLatest(String uid) throws Exception {
		return dao.selectOneGradeLatest(uid);
	}

}
