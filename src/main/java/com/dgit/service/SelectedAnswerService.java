package com.dgit.service;

import java.util.List;

import com.dgit.domain.SelectedAnswerVO;

public interface SelectedAnswerService {
	List<SelectedAnswerVO> selectAllAnswerByTnoDate(SelectedAnswerVO vo) throws Exception;
	void insertSelectedAnswer(SelectedAnswerVO vo) throws Exception;
}
