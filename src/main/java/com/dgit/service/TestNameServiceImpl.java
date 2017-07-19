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
	
	@Override
	public int selectLastTno() throws Exception {
		return nameDao.selectLastTno();
	}

	@Override
	public void updateTestName(TestNameVO vo) throws Exception {
		nameDao.updateTestName(vo);
	}

	@Override
	public void deleteTestName(int tno) throws Exception {
		nameDao.deleteTestName(tno);
	}

	@Override
	public void initAutoIncrementName(int num) throws Exception {
		nameDao.initAutoIncrementName(num);
	}
}
