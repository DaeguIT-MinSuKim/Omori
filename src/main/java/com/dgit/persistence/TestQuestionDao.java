package com.dgit.persistence;

import java.util.List;

import com.dgit.domain.TestQuestionVO;

public interface TestQuestionDao {
	List<TestQuestionVO> selectAllTestQuestionForMock(int tno) throws Exception;
	List<TestQuestionVO> selectAllTestQuestionForSubject(int tno, String tq_subject) throws Exception;
	TestQuestionVO selectOneTestQuestion(int tno, int tq_small_no) throws Exception;
	TestQuestionVO selectOneTestQuestionByTqno(int tq_no) throws Exception;
	List<String> selectOnlySubject(int tno) throws Exception;
	int selectCountBySubject(int tno, String tq_subject) throws Exception;
	int selectLastTqno() throws Exception;
	void insertTestQuestion(TestQuestionVO vo) throws Exception;
	List<Integer> selectAllTqSmallNoByTno(int tno) throws Exception;
	void initAutoIncrementQue(int num) throws Exception;
	void deleteTestQuestion(int tq_no) throws Exception;
	void updateTestQuestion(TestQuestionVO vo) throws Exception;
}
