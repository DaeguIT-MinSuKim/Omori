package com.dgit.service;

import java.util.List;

import com.dgit.domain.GradeVO;

public interface GradeService {
	List<GradeVO> selectAllGradeLatest(String uid) throws Exception;
}
