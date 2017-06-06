package com.dgit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.TestExampleVO;
import com.dgit.persistence.TestExampleDao;

@Service
public class TestExampleServiceImpl implements TestExampleService{
	@Autowired
	private TestExampleDao dao;

	@Override
	public List<TestExampleVO> selectAllTestExampleByTqNo(int tq_no) throws Exception {
		return dao.selectAllTestExampleByTqNo(tq_no);
	}

	@Override
	public TestExampleVO selectOneTestExampleCorrectAnswer(int tq_no) throws Exception {
		return dao.selectOneTestExampleCorrectAnswer(tq_no);
	}

	@Override
	public void insertTestExample(TestExampleVO vo) throws Exception {
		dao.insertTestExample(vo);
	}

}
