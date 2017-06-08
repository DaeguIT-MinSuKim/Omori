package com.dgit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.TestQuestionVO;
import com.dgit.persistence.TestQuestionDao;

@Service
public class TestQuestionServiceImpl implements TestQuestionService {
	@Autowired
	private TestQuestionDao dao;

	@Override
	public List<TestQuestionVO> selectAllTestQuestionForMock(int tno) throws Exception {
		return dao.selectAllTestQuestionForMock(tno);
	}

	@Override
	public List<TestQuestionVO> selectAllTestQuestionForSubject(TestQuestionVO vo) throws Exception {
		return dao.selectAllTestQuestionForSubject(vo);
	}

	@Override
	public TestQuestionVO selectOneTestQuestion(int tno, int tq_small_no) throws Exception {
		return dao.selectOneTestQuestion(tno, tq_small_no);
	}

	@Override
	public TestQuestionVO selectOneTestQuestionByTqno(int tq_no) throws Exception {
		return dao.selectOneTestQuestionByTqno(tq_no);
	}
	
	@Override
	public void insertTestQuestion(TestQuestionVO vo) throws Exception {
		dao.insertTestQuestion(vo);
	}

}
