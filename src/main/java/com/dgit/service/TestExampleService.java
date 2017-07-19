package com.dgit.service;

import java.util.List;

import com.dgit.domain.TestExampleVO;

public interface TestExampleService {
	List<TestExampleVO> selectAllTestExampleByTqNo(int tq_no) throws Exception;
	TestExampleVO selectOneTestExampleCorrectAnswer(int tq_no) throws Exception;
	void insertTestExample(TestExampleVO vo) throws Exception;
	TestExampleVO selectOneTestExampleNotTeNo(int tq_no, int te_small_no) throws Exception;
	void deleteTestExampleByTqnoTesmallno(int tq_no, int te_small_no) throws Exception;
	TestExampleVO selectOneTestExampleByTeNo(int te_no) throws Exception;
	void updateTestExample(TestExampleVO vo) throws Exception;
}
