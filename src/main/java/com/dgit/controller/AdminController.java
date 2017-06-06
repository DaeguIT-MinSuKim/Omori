package com.dgit.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dgit.domain.ImageVO;
import com.dgit.domain.TestExampleVO;
import com.dgit.domain.TestNameVO;
import com.dgit.domain.TestQuestionVO;
import com.dgit.service.ImageService;
import com.dgit.service.TestExampleService;
import com.dgit.service.TestNameService;
import com.dgit.service.TestQuestionService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private TestNameService nameService;
	@Autowired
	private TestQuestionService questionService;
	@Autowired
	private TestExampleService exampleService;
	@Autowired
	private ImageService imageService;
	
	@RequestMapping(value="/insert_exam", method=RequestMethod.GET)
	public String insertExamGET() throws Exception{
		logger.info("insertExam GET................");
		
		return "admin/insert_exam";
	}//insertExamGET
	
	@RequestMapping(value="/insert_result", method=RequestMethod.POST)
	public String insertResultPOST(int tno, TestQuestionVO questionVO, String[] te_small_no, String[] te_content, 
										List<MultipartFile> files, HttpServletRequest request, Model model) throws Exception{
		logger.info("insertExam POST................");
		
		TestNameVO testName = nameService.selectOneTestName(tno);
		questionVO.setTestName(testName);
		questionService.insertTestQuestion(questionVO);
		
		TestQuestionVO newQuestionVO = questionService.selectOneTestQuestion(tno, questionVO.getTq_small_no());
		
		String root_path = request.getSession().getServletContext().getRealPath("/");
		String innerUploadPath = "resources/upload";
		
		File dir = new File(root_path + "/" + innerUploadPath);
		if (!dir.exists()) {
			dir.mkdir();
		}
		
		ArrayList<String> fileNames = new ArrayList<>(); 
		for (MultipartFile file : files) {
			UUID uid = UUID.randomUUID();
			String savedName = uid.toString() + "_" + file.getOriginalFilename(); //랜덤이름_원본이름
			
			File target = new File(root_path + "/" + innerUploadPath, savedName);
			FileCopyUtils.copy(file.getBytes(), target);
			
			fileNames.add(innerUploadPath + "/" + savedName);
			
			/*insert image*/
			ImageVO imgVO = new ImageVO();
			imgVO.setQuestion(newQuestionVO);
			imgVO.setImgsource(savedName);
			imageService.insertImage(imgVO);
		}
		
		for(int i = 0; i < te_small_no.length; i++){
			TestExampleVO vo = new TestExampleVO();
			vo.setQuestion(newQuestionVO);
			vo.setTe_small_no(Integer.parseInt(te_small_no[i]));
			vo.setTe_content(te_content[i]);
			
			exampleService.insertTestExample(vo);
		}
		
		int tq_no = newQuestionVO.getTq_no();
		List<ImageVO> imgList = imageService.selectImageByTqNo(tq_no);
		List<TestExampleVO> exampleList = exampleService.selectAllTestExampleByTqNo(tq_no);
		
		model.addAttribute("TestQuestionVO", newQuestionVO);
		model.addAttribute("exampleList", exampleList);
		model.addAttribute("imgList", imgList);

		return "admin/insert_result";
	}//insertExamPOST
	
	@ResponseBody
	@RequestMapping(value="/selectAllTestName", method=RequestMethod.POST)
	public ResponseEntity<List<TestNameVO>> selectAllTestNamePOST(){
		logger.info("selectAllTestName POST................");
		
		ResponseEntity<List<TestNameVO>> entity = null;
		
		try{
			entity = new ResponseEntity<>(nameService.selectAllTestName(), HttpStatus.OK);
		}catch (Exception e){
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}//selectAllTestName
	
	@ResponseBody
	@RequestMapping(value="/selectSubjectNames", method=RequestMethod.POST)
	public ResponseEntity<String[]> selectSubjectNamesPOST(int tno) throws Exception{
		logger.info("selectSubjectNames POST................");
		
		ResponseEntity<String[]> entity = null;
		
		TestNameVO vo = nameService.selectOneTestName(tno);
		
		try{
			entity = new ResponseEntity<>(vo.getSubjectNames(), HttpStatus.OK);
		}catch (Exception e){
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//selectSubjectNames
	
	
	@ResponseBody
	@RequestMapping(value="/insertTestName", method=RequestMethod.POST)
	public ResponseEntity<String> insertTestNamePost(String tname, String tdate){
		logger.info("insertTestName POST................");
		
		ResponseEntity<String> entity = null;
		
		TestNameVO vo = new TestNameVO();
		vo.setTname(tname);
		vo.setTdate(tdate);
		
		try{
			nameService.insertTestName(vo);
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		}catch(Exception e){
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}//insertTestNamePost
}
