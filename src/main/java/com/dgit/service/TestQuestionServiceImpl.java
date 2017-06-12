package com.dgit.service;

import java.io.File;
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
	public int selectCountBySubject(int tno, String tq_subject) throws Exception {
		return dao.selectCountBySubject(tno, tq_subject);
	}
	
	@Override
	public void insertTestQuestion(TestQuestionVO vo) throws Exception {
		dao.insertTestQuestion(vo);
	}

	@Override
	public List<TestQuestionVO> selectQuestionAndAnswer(int tno, String uid) throws Exception {
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
	public List<String> selectOnlySubject(int tno) throws Exception {
		return dao.selectOnlySubject(tno);
	}
}
