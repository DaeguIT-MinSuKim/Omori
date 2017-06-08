package com.dgit.service;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.NowGradeVO;
import com.dgit.domain.TestQuestionVO;
import com.dgit.domain.UserVO;
import com.dgit.persistence.NowGradeDao;

@Service
public class NowGradeServiceImpl implements NowGradeService{
	@Autowired
	private NowGradeDao dao;
	@Autowired
	private TestQuestionService questionService;

	@Override
	public NowGradeVO selectOneNowGradeLatest(int tno, String tq_subject, UserVO user) throws Exception {
		NowGradeVO vo = new NowGradeVO();
		vo.setTno(tno);
		vo.setTq_subject(tq_subject);
		vo.setUser(user);
		return dao.selectOneNowGradeLatest(vo);
	}

	@Override
	public void insertNowGrade(List<TestQuestionVO> queAnsList, UserVO user) throws Exception {
		int tno = queAnsList.get(0).getTestName().getTno();
		int sum = 0; //맞은 개수
		
		for (int i = 0; i < queAnsList.size(); i++) {
			TestQuestionVO question = queAnsList.get(i);

			if(i == 0){
				if(question.getTq_answer() == question.getAnswer().getSa_answer()){
					sum++;
				}
			}else if(i == queAnsList.size()-1){
				if(question.getTq_answer() == question.getAnswer().getSa_answer()){
					sum++;
				}
				int ng_count = questionService.selectCountBySubject(tno, question.getTq_subject());
				NowGradeVO vo = new NowGradeVO();
				vo.setUser(user);
				vo.setTno(tno);
				vo.setTq_subject(question.getTq_subject());
				vo.setNowgrade(sum);
				vo.setNg_count(ng_count);
				vo.setNg_date(new Date());
				dao.insertNowGrade(vo);
			}else{
//				바로 이전  question의 subject와 현재 question의 subject를 비교해서
//				subject가 같을 동안 정답과 사용자가 선택한 답이 같은 지 또 확인하여 같으면 sum++
//				subject가 다를 때 바로 이전 question의 subject와 sum을 NowGradeVO에 심어주고
//				sum을 초기화
				TestQuestionVO preQuestion = queAnsList.get(i-1);
				
				if( preQuestion.getTq_subject().equals(question.getTq_subject()) ){
					if(question.getTq_answer() == question.getAnswer().getSa_answer()){
						sum++;
					}
				}else{
					int ng_count = questionService.selectCountBySubject(tno, preQuestion.getTq_subject());
					NowGradeVO vo = new NowGradeVO();
					vo.setUser(user);
					vo.setTno(tno);
					vo.setTq_subject(preQuestion.getTq_subject());
					vo.setNowgrade(sum);
					vo.setNg_count(ng_count);
					vo.setNg_date(new Date());
					dao.insertNowGrade(vo);
					
					sum = 0;
					
					if(question.getTq_answer() == question.getAnswer().getSa_answer()){
						sum++;
					}
				}
			}
		}
	}
}
