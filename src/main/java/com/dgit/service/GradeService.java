package com.dgit.service;

import java.util.List;

import com.dgit.domain.GradeVO;

public interface GradeService {
	GradeVO selectOneGradeLatest(String uid) throws Exception;
	void insertGrade(List<GradeVO> gradeList) throws Exception;
}
