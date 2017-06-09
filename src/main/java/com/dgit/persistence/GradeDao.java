package com.dgit.persistence;

import java.util.List;

import com.dgit.domain.GradeVO;

public interface GradeDao {
	GradeVO selectOneGradeLatest(String uid) throws Exception;
	void insertGrade(GradeVO vo) throws Exception;
}
