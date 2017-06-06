package com.dgit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.TestNameVO;
import com.dgit.persistence.TestNameDao;

@Service
public class TestNameServiceImpl implements TestNameService{
	@Autowired
	private TestNameDao nameDao;

	@Override
	public List<TestNameVO> selectAllTestName() throws Exception {
		return nameDao.selectAllTestName();
	}
	
	@Override
	public TestNameVO selectOneTestName(int tno) throws Exception {
		return nameDao.selectOneTestName(tno);
	}

	@Override
	public void insertTestName(TestNameVO vo) throws Exception {
		nameDao.insertTestName(vo);
	}
}
