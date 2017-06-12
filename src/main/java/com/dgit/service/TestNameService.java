package com.dgit.service;

import java.util.List;

import com.dgit.domain.TestNameVO;

public interface TestNameService {
	/*testname : 자격증이름*/
	List<TestNameVO> selectAllTestName() throws Exception;
	List<TestNameVO> selectAllTestNameOrderByTnoDesc() throws Exception;
	TestNameVO selectOneTestName(int tno) throws Exception;
	void insertTestName(TestNameVO vo) throws Exception;
}
