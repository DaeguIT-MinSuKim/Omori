package com.dgit.persistence;

import java.util.List;

import com.dgit.domain.SelectedAnswerVO;

public interface SelectedAnswerDao {
	SelectedAnswerVO selectOneAnswerByTqno(int tq_no, String uid) throws Exception;
	void insertSelectedAnswer(SelectedAnswerVO vo) throws Exception;
}
