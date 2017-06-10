package com.dgit.persistence;

import java.util.List;

import com.dgit.domain.GradeVO;
import com.dgit.domain.TestNameVO;

public interface GradeDao {
	GradeVO selectOneGradeLatest(String uid) throws Exception;
	int countSaveNo() throws Exception;
	List<Integer> selectTnoForGrade(String uid) throws Exception;
	List<GradeVO> selectAllGradeByTno(String uid, int tno) throws Exception;
	void insertGrade(GradeVO vo) throws Exception;
}
