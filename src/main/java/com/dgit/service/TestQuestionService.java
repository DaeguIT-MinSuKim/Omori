package com.dgit.service;

import java.util.List;

import com.dgit.domain.TestQuestionVO;

public interface TestQuestionService {
	List<TestQuestionVO> selectAllTestQuestionForMock(int tno) throws Exception;
	List<TestQuestionVO> selectAllTestQuestionForSubject(TestQuestionVO vo) throws Exception;
	TestQuestionVO selectOneTestQuestion(int tno, int tq_small_no) throws Exception;
	void insertTestQuestion(TestQuestionVO vo) throws Exception;
}
