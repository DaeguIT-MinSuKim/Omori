package com.dgit.service;

import java.util.List;

import com.dgit.domain.GradeVO;
import com.dgit.domain.TestNameVO;

public interface GradeService {
	GradeVO selectOneGradeLatest(String uid) throws Exception;
	int countSaveNo() throws Exception;
	List<TestNameVO> selectTnoForGrade(String uid) throws Exception;
	List<GradeVO> selectAllGradeByTno(String uid, int tno) throws Exception;
	void insertGrade(List<GradeVO> gradeList) throws Exception;
}
