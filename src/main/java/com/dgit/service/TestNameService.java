package com.dgit.service;

import java.util.List;

import com.dgit.domain.TestNameVO;

public interface TestNameService {
	List<TestNameVO> selectAllTestName() throws Exception;
	int selectLastTno() throws Exception;
	TestNameVO selectOneTestName(int tno) throws Exception;
	void insertTestName(TestNameVO vo) throws Exception;
	void updateTestName(TestNameVO vo) throws Exception;
	void deleteTestName(int tno) throws Exception;
	void initAutoIncrementName(int num) throws Exception;
}
