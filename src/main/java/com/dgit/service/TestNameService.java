package com.dgit.service;

import java.util.List;

import com.dgit.domain.TestNameVO;

public interface TestNameService {
	/*testname : 자격증이름*/
	List<TestNameVO> selectAllTestName() throws Exception;
	TestNameVO selectOneTestName(int tno) throws Exception;
	void insertTestName(TestNameVO vo) throws Exception;
	
	/*testquestion : 문제*/
//	List<TestQuestionVO> selectAllTestQuestionForMock(int tno) throws Exception;
//	List<TestQuestionVO> selectAllTestQuestionForSubject(TestQuestionVO vo) throws Exception;
//	TestQuestionVO selectOneTestQuestion(TestQuestionVO vo) throws Exception;
//	void insertTestQuestion(TestQuestionVO vo) throws Exception;
	
	/*image : 예시이미지*/
//	List<ImageVO> selectImageByTqNo(int tq_no) throws Exception;
//	void insertImage(ImageVO vo) throws Exception;	
	
	/*testexample : 보기*/
//	List<TestExampleVO> selectAllTestExampleByTqNo(int tq_no) throws Exception;
//	TestExampleVO selectOneTestExampleCorrectAnswer(int tq_small_no) throws Exception;
//	void insertTestExample(TestExampleVO vo) throws Exception;
	
	/*grade : 성적*/
//	List<GradeVO> selectAllGradeLatest(String uid) throws Exception;
}
