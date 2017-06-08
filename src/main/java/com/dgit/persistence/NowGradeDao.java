package com.dgit.persistence;

import com.dgit.domain.NowGradeVO;

public interface NowGradeDao {
	NowGradeVO selectOneNowGradeLatest(NowGradeVO vo) throws Exception;
	void insertNowGrade(NowGradeVO vo) throws Exception;
}
