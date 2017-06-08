package com.dgit.persistence;

import java.util.List;

import com.dgit.domain.SelectedAnswerVO;

public interface SelectedAnswerDao {
	List<SelectedAnswerVO> selectAllAnswerByTnoDate(SelectedAnswerVO vo) throws Exception;
	void insertSelectedAnswer(SelectedAnswerVO vo) throws Exception;
}
