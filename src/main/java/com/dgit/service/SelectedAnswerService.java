package com.dgit.service;

import java.util.List;

import com.dgit.domain.SelectedAnswerVO;

public interface SelectedAnswerService {
	SelectedAnswerVO selectOneAnswerByTqno(int tq_no, String uid) throws Exception;
	void insertSelectedAnswer(SelectedAnswerVO vo) throws Exception;
	List<SelectedAnswerVO> selectAllAnswerByTqno(int tq_no, String uid) throws Exception;
}
