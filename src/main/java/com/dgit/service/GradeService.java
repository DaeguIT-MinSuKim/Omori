package com.dgit.service;

import java.util.List;

import com.dgit.domain.GradeVO;
import com.dgit.domain.TestNameVO;

public interface GradeService {
	GradeVO selectOneGradeLatest(String uid) throws Exception;
	int countSaveNo() throws Exception;
	List<TestNameVO> selectTnoForGrade(String uid) throws Exception;
	List<GradeVO> selectAllGradeGroupByTno(String uid, int tno) throws Exception;
	List<String> selectGradeDate(String uid, int tno) throws Exception; 
	List<GradeVO> selectListGradeByDate(String uid, int tno, String g_date) throws Exception;
	List<GradeVO> selectListGradeBySubject(String uid, int tno, String g_subject) throws Exception;
	void insertGrade(List<GradeVO> gradeList) throws Exception;
}
