package com.dgit.service;

import java.io.File;
import java.util.List;

import com.dgit.domain.TestQuestionVO;
import com.dgit.domain.UserVO;

public interface TestQuestionService {
	List<TestQuestionVO> selectAllTestQuestionForMock(int tno) throws Exception;
	List<TestQuestionVO> selectAllTestQuestionForSubject(TestQuestionVO vo) throws Exception;
	TestQuestionVO selectOneTestQuestion(int tno, int tq_small_no) throws Exception;
	TestQuestionVO selectOneTestQuestionByTqno(int tq_no) throws Exception;
	List<String> selectOnlySubject(int tno) throws Exception;
	int selectCountBySubject(int tno, String tq_subject) throws Exception;
	int selectLastTqno() throws Exception;
	void insertTestQuestion(TestQuestionVO vo) throws Exception;
	List<Integer> selectAllTqSmallNoByTno(int tno) throws Exception;
	List<TestQuestionVO> selectQuestionAndAnswer(int tno, String uid) throws Exception; 
}
