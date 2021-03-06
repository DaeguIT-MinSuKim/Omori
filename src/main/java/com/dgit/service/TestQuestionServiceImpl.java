package com.dgit.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.ImageVO;
import com.dgit.domain.NoteVO;
import com.dgit.domain.SelectedAnswerVO;
import com.dgit.domain.TestExampleVO;
import com.dgit.domain.TestNameVO;
import com.dgit.domain.TestQuestionVO;
import com.dgit.persistence.ImageDao;
import com.dgit.persistence.NoteDao;
import com.dgit.persistence.SelectedAnswerDao;
import com.dgit.persistence.TestExampleDao;
import com.dgit.persistence.TestNameDao;
import com.dgit.persistence.TestQuestionDao;
import com.dgit.util.ExcelRead;
import com.dgit.util.ExcelReadOption;

@Service
public class TestQuestionServiceImpl implements TestQuestionService {
	@Autowired
	private TestQuestionDao dao;
	@Autowired
	private SelectedAnswerDao answerDao;
	@Autowired
	private TestNameDao nameDao;
	@Autowired
	private ImageDao imageDao;
	@Autowired
	private TestExampleDao exampleDao;
	@Autowired
	private NoteDao noteDao;

	@Override
	public List<TestQuestionVO> selectAllTestQuestionForMock(int tno) throws Exception {
		return dao.selectAllTestQuestionForMock(tno);
	}

	@Override
	public List<TestQuestionVO> selectAllTestQuestionForSubject(int tno, String tq_subject) throws Exception {
		return dao.selectAllTestQuestionForSubject(tno, tq_subject);
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
	public int selectCountBySubject(int tno, String tq_subject) throws Exception {
		return dao.selectCountBySubject(tno, tq_subject);
	}
	
	@Override
	public void insertTestQuestion(TestQuestionVO vo) throws Exception {
		dao.insertTestQuestion(vo);
	}

	@Override
	public List<String> selectOnlySubject(int tno) throws Exception {
		return dao.selectOnlySubject(tno);
	}

	@Override
	public int selectLastTqno() throws Exception {
		return dao.selectLastTqno();
	}

	@Override
	public List<Integer> selectAllTqSmallNoByTno(int tno) throws Exception {
		return dao.selectAllTqSmallNoByTno(tno);
	}

	@Override
	public void initAutoIncrementQue(int num) throws Exception {
		dao.initAutoIncrementQue(num);
	}

	@Override
	public void deleteTestQuestion(int tq_no) throws Exception {
		dao.deleteTestQuestion(tq_no);
	}

	@Override
	public void updateTestQuestion(TestQuestionVO vo) throws Exception {
		dao.updateTestQuestion(vo);
	}
	
	@Override
	public List<TestQuestionVO> selectQuestionAndAnswerWithNote(int tno, String uid) throws Exception {
		List<TestQuestionVO> questionList = dao.selectAllTestQuestionForMock(tno);
		TestNameVO testName = nameDao.selectOneTestName(tno);
		
		for(int i = 0; i < questionList.size(); i++){
			TestQuestionVO que = questionList.get(i);
			int tqno = que.getTq_no();
			
			SelectedAnswerVO answer =  answerDao.selectOneAnswerByTqno(tqno, uid);
			que.setAnswer(answer);
			que.setTestName(testName);
			
			List<TestExampleVO> exampleList = exampleDao.selectAllTestExampleByTqNo(tqno);
			que.setExampleList(exampleList);
			
			List<ImageVO> imageList = imageDao.selectImageByTqNo(tqno);
			que.setImageList(imageList);
			
			NoteVO note = noteDao.selectOneNoteByTnoTqno(uid, tno, tqno);
			if(note != null){
				note.setNote_content(note.getNote_content().replaceAll("`", "'"));
				note.setNote_content(note.getNote_content().replaceAll("\r\n", "<br>"));
				note.setNote_content(note.getNote_content().replaceAll("u0020", "&nbsp;"));
				note.setNote_memo(note.getNote_memo().replaceAll("`", "'"));
				note.setNote_memo(note.getNote_memo().replaceAll("\r\n", "<br>"));
				note.setNote_memo(note.getNote_memo().replaceAll("u0020", "&nbsp;"));
			}
			que.setNote(note);
		}
		return questionList;
	}

	@Override
	public List<TestQuestionVO> selectQuestionAndAnswerBySubjectWithNote(int tno, String uid, String subject) throws Exception {
		List<TestQuestionVO> questionList = dao.selectAllTestQuestionForSubject(tno, subject);
		TestNameVO testName = nameDao.selectOneTestName(tno);
		
		for(int i = 0; i < questionList.size(); i++){
			TestQuestionVO que = questionList.get(i);
			int tqno = que.getTq_no();
			
			SelectedAnswerVO answer =  answerDao.selectOneAnswerByTqno(tqno, uid);
			que.setAnswer(answer);
			que.setTestName(testName);
			
			List<TestExampleVO> exampleList = exampleDao.selectAllTestExampleByTqNo(tqno);
			que.setExampleList(exampleList);
			
			List<ImageVO> imageList = imageDao.selectImageByTqNo(tqno);
			que.setImageList(imageList);
			
			NoteVO note = noteDao.selectOneNoteByTnoTqno(uid, tno, tqno);
			if(note != null){
				note.setNote_content(note.getNote_content().replaceAll("`", "'"));
				note.setNote_content(note.getNote_content().replaceAll("\r\n", "<br>"));
				note.setNote_content(note.getNote_content().replaceAll("u0020", "&nbsp;"));
				note.setNote_memo(note.getNote_memo().replaceAll("`", "'"));
				note.setNote_memo(note.getNote_memo().replaceAll("\r\n", "<br>"));
				note.setNote_memo(note.getNote_memo().replaceAll("u0020", "&nbsp;"));
			}
			que.setNote(note);
		}
		return questionList;
	}
	
	@Override
	public List<TestQuestionVO> selectQuestionAndAnswerWithNotePercent(int tno, String uid) throws Exception {
		List<TestQuestionVO> questionList = dao.selectAllTestQuestionForMock(tno);
		TestNameVO testName = nameDao.selectOneTestName(tno);
		
		for(int i = 0; i < questionList.size(); i++){
			TestQuestionVO que = questionList.get(i);
			int tqno = que.getTq_no();
			
			SelectedAnswerVO answer =  answerDao.selectOneAnswerByTqno(tqno, uid);
			que.setAnswer(answer);
			que.setTestName(testName);
			
			List<SelectedAnswerVO> answerList = answerDao.selectAllAnswerByTqno(tqno, uid);
			int max = 100;
			for(int j=0; j<answerList.size(); j++){
				int per = 100 / answerList.size();
				if(que.getTq_answer() != answerList.get(j).getSa_answer()){
					max = max - per;
				}
			}
			que.setTq_per(max);
			
			List<TestExampleVO> exampleList = exampleDao.selectAllTestExampleByTqNo(tqno);
			que.setExampleList(exampleList);
			
			List<ImageVO> imageList = imageDao.selectImageByTqNo(tqno);
			que.setImageList(imageList);
			
			NoteVO note = noteDao.selectOneNoteByTnoTqno(uid, tno, tqno);
			if(note != null){
				note.setNote_content(note.getNote_content().replaceAll("`", "'"));
				note.setNote_content(note.getNote_content().replaceAll("\r\n", "<br>"));
				note.setNote_content(note.getNote_content().replaceAll("u0020", "&nbsp;"));
				note.setNote_memo(note.getNote_memo().replaceAll("`", "'"));
				note.setNote_memo(note.getNote_memo().replaceAll("\r\n", "<br>"));
				note.setNote_memo(note.getNote_memo().replaceAll("u0020", "&nbsp;"));
			}
			que.setNote(note);
		}
		
		List<TestQuestionVO> questionWithNoteList = new ArrayList<>();
		for (int i = 0; i < questionList.size(); i++) {
			TestQuestionVO que = questionList.get(i);
			if(que.getNote() != null){
				questionWithNoteList.add(que);
			}
		}
		
		return questionWithNoteList;
	}
}
