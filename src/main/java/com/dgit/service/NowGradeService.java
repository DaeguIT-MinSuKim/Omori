package com.dgit.service;

import java.util.List;

import com.dgit.domain.NowGradeVO;
import com.dgit.domain.TestQuestionVO;
import com.dgit.domain.UserVO;

public interface NowGradeService {
	NowGradeVO selectOneNowGradeLatest(int tno, String tq_subject, UserVO user) throws Exception;
	void insertNowGrade(List<TestQuestionVO> queAnsList, UserVO user) throws Exception;
}
