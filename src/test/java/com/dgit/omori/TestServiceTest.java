package com.dgit.omori;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dgit.domain.ImageVO;
import com.dgit.domain.NoteVO;
import com.dgit.domain.NowGradeVO;
import com.dgit.domain.SelectedAnswerVO;
import com.dgit.domain.TestExampleVO;
import com.dgit.domain.TestNameVO;
import com.dgit.domain.TestQuestionVO;
import com.dgit.domain.UserVO;
import com.dgit.service.GradeService;
import com.dgit.service.ImageService;
import com.dgit.service.NoteService;
import com.dgit.service.NowGradeService;
import com.dgit.service.SelectedAnswerService;
import com.dgit.service.TestExampleService;
import com.dgit.service.TestNameService;
import com.dgit.service.TestQuestionService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class TestServiceTest {
	@Inject
	private TestNameService nameService;
	@Inject
	private TestQuestionService questionService;
	@Inject
	private TestExampleService exmapleService;
	@Inject
	private ImageService imageService;
	@Inject
	private GradeService gradeService;
	@Inject
	private SelectedAnswerService answerService;
	@Inject
	private NowGradeService nowGradeService;
	@Inject
	private NoteService noteService;
	
	/*......................*/
	/*TestName				*/
	/*......................*/
//	@Test
	public void selectAllTestName() throws Exception{
		List<TestNameVO> list = nameService.selectAllTestName();
	}
	
//	@Test
	public void selectOneTestName() throws Exception{
		TestNameVO vo =  nameService.selectOneTestName(1);
	}
	
//	@Test
	public void insertTestName() throws Exception{
		TestNameVO vo = new TestNameVO();
		vo.setTname("정보처리기사 2016년 1회");
		vo.setTdate("2016-03-06");
		nameService.insertTestName(vo);
	}
	
	/*......................*/
	/*TestQuestion			*/
	/*......................*/
//	@Test
	public void selectAllTestQuestionForMock() throws Exception{
		questionService.selectAllTestQuestionForMock(1);
	}
	
//	@Test
	public void selectAllTestQuestionForSubject() throws Exception{
		TestNameVO name = new TestNameVO();
		name.setTno(1);
		TestQuestionVO vo = new TestQuestionVO();
		vo.setTestName(name);
		vo.setTq_subject_no(1);
		questionService.selectAllTestQuestionForSubject(vo);
	}
	
//	@Test
	public void selectOneTestQuestion() throws Exception{
		questionService.selectOneTestQuestion(1, 1);
	}
	
//	@Test
	public void selectOneTestQuestionByTqno() throws Exception{
		questionService.selectOneTestQuestionByTqno(1);
	}
	
//	@Test
	public void insertTestQuestion() throws Exception{
		TestNameVO name = new TestNameVO();
		name.setTno(1);
		TestQuestionVO vo = new TestQuestionVO();
		vo.setTestName(name);
		vo.setTq_subject("데이터베이스");
		vo.setTq_subject_no(1);
		vo.setTq_small_no(1);
		vo.setTq_question("이행적 함수 종속 관계를 의미하는 것은?");
		vo.setTq_answer(1);
		vo.setTq_per(90);
		questionService.insertTestQuestion(vo);
	}
	
//	@Test
	public void selectQuestionAndAnswer() throws Exception{
		List<TestQuestionVO> questionList = questionService.selectQuestionAndAnswer(1, "test1");
		System.out.println(questionList.get(0).getAnswer().getSa_answer() + "을 선택했다");
	}
	
//	@Test
	public void selectOnlySubject() throws Exception{
		questionService.selectOnlySubject(1);
	}
	
	
	/*......................*/
	/*TestExample			*/
	/*......................*/
//	@Test
	public void selectAllTestExampleByTqNo() throws Exception{
		exmapleService.selectAllTestExampleByTqNo(1);
	}
	
//	@Test
	public void selectOneTestExampleCorrectAnswer() throws Exception{
		exmapleService.selectOneTestExampleCorrectAnswer(2);
	}
	
//	@Test
	public void insertTestExample() throws Exception{
		TestQuestionVO question = new TestQuestionVO();
		question.setTq_no(1);
		TestExampleVO vo = new TestExampleVO();
		vo.setQuestion(question);
		vo.setTe_small_no(4);
		vo.setTe_content("문제2번의 보기4");
		exmapleService.insertTestExample(vo);
	}
	
	/*......................*/
	/*Image					*/
	/*......................*/
//	@Test
	public void selectImageByTqNo() throws Exception{
		imageService.selectImageByTqNo(1);
	}
	
//	@Test
	public void insertImage() throws Exception{
		TestQuestionVO question = questionService.selectOneTestQuestion(1, 1);
		ImageVO vo = new ImageVO();
		vo.setQuestion(question);
		vo.setImgsource("이미지2");
		
		imageService.insertImage(vo);
	}
	
	/*......................*/
	/*Grade					*/
	/*......................*/
//	@Test
	public void selectAllGradeLatest() throws Exception{
		gradeService.selectAllGradeLatest("test1");
	}
	
	/*......................*/
	/*SelectedAnswer		*/
	/*......................*/
//	@Test
	public void selectOneAnswerByTqno() throws Exception{
		SelectedAnswerVO vo = new SelectedAnswerVO();
		
		UserVO user = new UserVO();
		user.setUid("test1");
		vo.setUser(user);
		vo.setTq_no(1);
		
		answerService.selectOneAnswerByTqno(1, "test1");
	}
	
//	@Test
	public void insertSelectedAnswer() throws Exception{
		SelectedAnswerVO vo = new SelectedAnswerVO();
		
		UserVO user = new UserVO();
		user.setUid("test1");
		vo.setUser(user);
		
		vo.setTq_no(1);
		vo.setSa_answer(4);
		vo.setSa_date(new Date());
		
		answerService.insertSelectedAnswer(vo);
	}
	
	/*......................*/
	/*NowGrade				*/
	/*......................*/
//	@Test
	public void selectOneNowGradeLatest() throws Exception{
		UserVO user = new UserVO();
		user.setUid("test1");
		
		nowGradeService.selectOneNowGradeLatest(1, "데이터베이스", user);
	}
	
//	@Test
	public void insertNowGrade() throws Exception{
//		UserVO user = new UserVO();
//		user.setUid("test1");
//		
//		nowGradeService.insertNowGrade(1, user);
	}
	
	/*......................*/
	/*Note					*/
	/*......................*/
//	@Test
	public void insertNote() throws Exception{
		NoteVO vo = new NoteVO();
		
		UserVO user = new UserVO();
		user.setUid("test1");
		vo.setUser(user);
		
		TestNameVO testName = nameService.selectOneTestName(1);
		vo.setTestName(testName);
		
		TestQuestionVO question = questionService.selectOneTestQuestionByTqno(1);
		vo.setQuestion(question);
		
		vo.setNote_content("문제 1번의 오답풀이 내용");
		vo.setNote_memo("내가 왜 이걸 틀렸을까");
		vo.setNote_date(new Date());
		
		noteService.insertNote(vo);
	}
	
//	@Test
	public void selectAllNoteByTno() throws Exception{
		noteService.selectAllNoteByTno("test1", 1);
	}
	
//	@Test
	public void selectOneNoteByTnoTqno() throws Exception{
		NoteVO vo = new NoteVO();
		
		UserVO user = new UserVO();
		user.setUid("test1");
		vo.setUser(user);
		
		TestNameVO testName = nameService.selectOneTestName(1);
		vo.setTestName(testName);
		
		TestQuestionVO question = questionService.selectOneTestQuestionByTqno(1);
		vo.setQuestion(question);
		
		noteService.selectOneNoteByTnoTqno("test1", 1, 1);
	}
	
//	@Test
	public void updateNote() throws Exception{
		NoteVO vo = noteService.selectOneNoteByTnoTqno("test1", 1, 1);
		vo.setNote_content("123123");
		vo.setNote_memo("123456789");
		vo.setNote_date(new Date());
		
		noteService.updateNote(vo);
	}
	
//	@Test
	public void deleteNote() throws Exception{
		noteService.deleteNote(1);
	}
}
