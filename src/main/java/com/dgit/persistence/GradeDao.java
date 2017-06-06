package com.dgit.persistence;

import java.util.List;

import com.dgit.domain.GradeVO;

public interface GradeDao {
	List<GradeVO> selectAllGradeLatest(String uid) throws Exception;
}
