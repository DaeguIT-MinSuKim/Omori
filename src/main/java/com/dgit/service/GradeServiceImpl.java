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
		if(list.get(0) != null){
			for (Integer i : list) {
				TestNameVO testName = nameService.selectOneTestName(i);
				testNameList.add(testName);
			}
			return testNameList;
		}else{
			return null;
		}
	}

	@Override
	public List<GradeVO> selectAllGradeGroupByTno(String uid, int tno) throws Exception {
		List<GradeVO> list =  dao.selectAllGradeGroupByTno(uid, tno);
		TestNameVO testName = nameService.selectOneTestName(tno);
		for (GradeVO vo : list) {
			vo.setTestName(testName);
		}
		return list;
	}

	@Override
	public List<String> selectGradeDate(String uid, int tno) throws Exception {
		return dao.selectGradeDate(uid, tno);
	}

	@Override
	public List<GradeVO> selectListGradeByDate(String uid, int tno, String g_date) throws Exception {
		return dao.selectListGradeByDate(uid, tno, g_date);
	}

	@Override
	public List<GradeVO> selectListGradeBySubject(String uid, int tno, String g_subject) throws Exception {
		return dao.selectListGradeBySubject(uid, tno, g_subject);
	}

}
