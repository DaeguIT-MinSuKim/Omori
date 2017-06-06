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
	public List<GradeVO> selectAllGradeLatest(String uid) throws Exception {
		return dao.selectAllGradeLatest(uid);
	}

}
