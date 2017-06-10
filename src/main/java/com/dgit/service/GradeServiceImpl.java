package com.dgit.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.GradeVO;
import com.dgit.domain.TestNameVO;
import com.dgit.persistence.GradeDao;

@Service
public class GradeServiceImpl implements GradeService{
	@Autowired
	private GradeDao dao;
	@Autowired
	private TestNameService nameService;

	@Override
	public void insertGrade(List<GradeVO> gradeList) throws Exception {
		for (GradeVO vo : gradeList) {
			dao.insertGrade(vo);
		}
	}

	@Override
	public GradeVO selectOneGradeLatest(String uid) throws Exception {
		return dao.selectOneGradeLatest(uid);
	}

	@Override
	public int countSaveNo() throws Exception {
		return dao.countSaveNo();
	}

	@Override
	public List<TestNameVO> selectTnoForGrade(String uid) throws Exception {
		List<Integer> list =  dao.selectTnoForGrade(uid);
		List<TestNameVO> testNameList = new ArrayList<>();
		for (Integer i : list) {
			TestNameVO testName = nameService.selectOneTestName(i);
			testNameList.add(testName);
		}
		return testNameList;
	}

	@Override
	public List<GradeVO> selectAllGradeByTno(String uid, int tno) throws Exception {
		return dao.selectAllGradeByTno(uid, tno);
	}

}
