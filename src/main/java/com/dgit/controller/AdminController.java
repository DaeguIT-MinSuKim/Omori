package com.dgit.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
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

	@RequestMapping(value = "/insert_exam", method = RequestMethod.GET)
	public String insertExamGET(Model model) throws Exception {
		List<TestNameVO> list = nameService.selectAllTestName();
		
		model.addAttribute("nameList", list);

		return "admin/insert_exam";
	}// insertExamGET
	
	@ResponseBody
	@RequestMapping(value = "/insertTestName", method = RequestMethod.POST)
	public ResponseEntity<String> insertTestName(String tname, String tdate) throws Exception {
		ResponseEntity<String> entity = null;
		
		try {
			TestNameVO vo = new TestNameVO();
			vo.setTname(tname.trim());
			vo.setTdate(tdate.trim());
			nameService.insertTestName(vo);
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//insertTestName
	
	@ResponseBody
	@RequestMapping(value = "/insertQuestionExample", method = RequestMethod.POST)
	public ResponseEntity<String> insertQuestionExample(int tno, String tq_subject, int tq_small_no, String tq_question, int tq_answer, String[] te_content) throws Exception {
		ResponseEntity<String> entity = null;
		
		try {
			TestQuestionVO vo = new TestQuestionVO();
			
			TestNameVO testName = new TestNameVO();
			testName.setTno(tno);
			
			vo.setTestName(testName);
			vo.setTq_subject(tq_subject);
			vo.setTq_small_no(tq_small_no);
			vo.setTq_question(tq_question);
			vo.setTq_answer(tq_answer);
			
			questionService.insertTestQuestion(vo);

			for(int i=0; i<te_content.length; i++){
				TestExampleVO example = new TestExampleVO();
				example.setQuestion(vo);
				example.setTe_small_no(i+1);
				example.setTe_content(te_content[i]);
				exampleService.insertTestExample(example);
			}
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//insertQuestionExample
	
	@ResponseBody
	@RequestMapping(value = "/getLastTnoTqno", method = RequestMethod.POST)
	public ResponseEntity<List<Integer>> getLastTnoTqno() throws Exception {
		ResponseEntity<List<Integer>> entity = null;
		
		try {
			int tno = nameService.selectLastTno();
			int tqno = questionService.selectLastTqno();
			List<Integer> list = new ArrayList<>();
			list.add(tno);
			list.add(tqno);
			
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getLastTnoTqno
	
	@ResponseBody
	@RequestMapping(value = "/getTqSmallNoList", method = RequestMethod.POST)
	public ResponseEntity<List<Integer>> getTqSmallNoList(int tno) throws Exception {
		ResponseEntity<List<Integer>> entity = null;
		
		try {
			List<Integer> list = questionService.selectAllTqSmallNoByTno(tno);
			
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//getTqSmallNoList 

	@RequestMapping(value = "/insert_result", method = RequestMethod.POST)
	public String insertResultPOST(int tno, TestQuestionVO questionVO, String[] te_small_no, String[] te_content,
			List<MultipartFile> files, HttpServletRequest request, Model model) throws Exception {
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
			String savedName = uid.toString() + "_" + file.getOriginalFilename(); // 랜덤이름_원본이름

			File target = new File(root_path + "/" + innerUploadPath, savedName);
			FileCopyUtils.copy(file.getBytes(), target);

			fileNames.add(innerUploadPath + "/" + savedName);

			/* insert image */
			ImageVO imgVO = new ImageVO();
			imgVO.setQuestion(newQuestionVO);
			imgVO.setImgsource(savedName);
			imageService.insertImage(imgVO);
		}

		for (int i = 0; i < te_small_no.length; i++) {
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
	}// insertExamPOST

	@ResponseBody
	@RequestMapping(value = "/selectAllTestName", method = RequestMethod.POST)
	public ResponseEntity<List<TestNameVO>> selectAllTestNamePOST() {
		logger.info("selectAllTestName POST................");

		ResponseEntity<List<TestNameVO>> entity = null;

		try {
			entity = new ResponseEntity<>(nameService.selectAllTestName(), HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}// selectAllTestName

	/*@ResponseBody
	@RequestMapping(value = "/selectSubjectNames", method = RequestMethod.POST)
	public ResponseEntity<String[]> selectSubjectNamesPOST(int tno) throws Exception {
		logger.info("selectSubjectNames POST................");

		ResponseEntity<String[]> entity = null;

		TestNameVO vo = nameService.selectOneTestName(tno);

		try {
			entity = new ResponseEntity<>(vo.getSubjectNames(), HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}*/// selectSubjectNames

	@RequestMapping(value = "/update_test/{tno}", method = RequestMethod.GET)
	public String update_test(@PathVariable("tno") int tno, Model model) throws Exception {
		TestNameVO testName = nameService.selectOneTestName(tno);
		List<TestQuestionVO> questionList = questionService.selectAllTestQuestionForMock(tno);

		for (int i = 0; i < questionList.size(); i++) {
			TestQuestionVO question = questionList.get(i);
			int tq_no = question.getTq_no();
			List<TestExampleVO> exampleList = exampleService.selectAllTestExampleByTqNo(tq_no);
			List<ImageVO> imageList = imageService.selectImageByTqNo(tq_no);

			question.setExampleList(exampleList);
			question.setImageList(imageList);
		}

		model.addAttribute("testName", testName);
		return "admin/update_test";
	}// update_test

	@RequestMapping(value = "/update_form/{tno}/{tq_no}", method = RequestMethod.POST)
	public ResponseEntity<TestQuestionVO> update_form(@PathVariable("tno") int tno, @PathVariable("tq_no") int tq_no,
			Model model) throws Exception {
		ResponseEntity<TestQuestionVO> entity = null;

		try {
			TestNameVO testName = nameService.selectOneTestName(tno);
			TestQuestionVO question = questionService.selectOneTestQuestionByTqno(tq_no);
			List<TestExampleVO> exampleList = exampleService.selectAllTestExampleByTqNo(tq_no);
			List<ImageVO> imageList = imageService.selectImageByTqNo(tq_no);

			question.setExampleList(exampleList);
			question.setImageList(imageList);

			entity = new ResponseEntity<TestQuestionVO>(question, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}// update_form
	
	public void uploadExcelFile(File target) throws IOException{
		FileInputStream fis = new FileInputStream(target);
		XSSFWorkbook workbook = new XSSFWorkbook(fis);
		int rowindex = 0;
		int columnindex = 0;
		// 시트 수 (첫번째에만 존재하므로 0을 준다)
		// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		XSSFSheet sheet = workbook.getSheetAt(0);
		// 행의 수
		int rows = sheet.getPhysicalNumberOfRows();
		for (rowindex = 1; rowindex < rows; rowindex++) {
			// 행을읽는다
			XSSFRow row = sheet.getRow(rowindex);
			if (row != null) {
				// 셀의 수
				int cells = row.getPhysicalNumberOfCells();
				for (columnindex = 0; columnindex <= cells; columnindex++) {
					// 셀값을 읽는다
					XSSFCell cell = row.getCell(columnindex);
					String value = "";
					// 셀이 빈값일경우를 위한 널체크
					if (cell == null) {
						continue;
					} else {
						// 타입별로 내용 읽기
						switch (cell.getCellType()) {
						case XSSFCell.CELL_TYPE_FORMULA:
							value = cell.getCellFormula();
							break;
						case XSSFCell.CELL_TYPE_NUMERIC:
							if(DateUtil.isCellDateFormatted(cell)){
								Date date = cell.getDateCellValue();
								value = new SimpleDateFormat("yyyy-MM-dd").format(date);
							}else{
								value = (int) cell.getNumericCellValue() + "";
							}
							break;
						case XSSFCell.CELL_TYPE_STRING:
							value = cell.getStringCellValue() + "";
							break;
						case XSSFCell.CELL_TYPE_BLANK:
							value = cell.getBooleanCellValue() + "";
							break;
						case XSSFCell.CELL_TYPE_ERROR:
							value = cell.getErrorCellValue() + "";
							break;
						}
					}
					System.out.println("각 셀 내용 :" + value);
				}
			}
		}
	}
	
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	public String uploadFile(MultipartFile nameFile, MultipartFile questionFile, MultipartFile exampleFile, HttpServletRequest req) throws IOException{
		String root_path = req.getSession().getServletContext().getRealPath("/");
		String innerUploadPath = "resources/upload";

		File dir = new File(root_path + "/" + innerUploadPath);
		if (!dir.exists()) {
			dir.mkdir();
		}
		
		UUID uid = UUID.randomUUID();
		String savedName1 = uid.toString() + "_" + nameFile.getOriginalFilename(); //랜덤이름_원본이름
		String savedName2 = uid.toString() + "_" + questionFile.getOriginalFilename();
		String savedName3 = uid.toString() + "_" + exampleFile.getOriginalFilename();
		
		File target1 = new File(root_path + "/" + innerUploadPath, savedName1);
		FileCopyUtils.copy(nameFile.getBytes(), target1);
		
		File target2 = new File(root_path + "/" + innerUploadPath, savedName2);
		FileCopyUtils.copy(questionFile.getBytes(), target2);
		
		File target3 = new File(root_path + "/" + innerUploadPath, savedName3);
		FileCopyUtils.copy(exampleFile.getBytes(), target3);
		
		uploadExcelFile(target1);
		uploadExcelFile(target2);
		uploadExcelFile(target3);
		
		return "/excelTest";
	}//uploadFile

	@ResponseBody
	@RequestMapping(value = "/excelUploadAjax", method = RequestMethod.POST)
	public String excelUploadAjax(MultipartFile excelFile, HttpServletRequest req, HttpServletResponse res) throws Exception {
		ResponseEntity<String> entity = null;

		String root_path = req.getSession().getServletContext().getRealPath("/");
		String innerUploadPath = "resources/upload";

		File dir = new File(root_path + "/" + innerUploadPath);
		if (!dir.exists()) {
			dir.mkdir();
		}

		String savedName = excelFile.getOriginalFilename(); // 원본이름
		System.out.println("savedName : " + savedName);

		File target = new File(root_path + "/" + innerUploadPath, savedName);
		FileCopyUtils.copy(excelFile.getBytes(), target);

		FileInputStream fis = new FileInputStream(target);
		XSSFWorkbook workbook = new XSSFWorkbook(fis);
		int rowindex = 0;
		int columnindex = 0;
		// 시트 수 (첫번째에만 존재하므로 0을 준다)
		// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
		XSSFSheet sheet = workbook.getSheetAt(0);
		// 행의 수
		int rows = sheet.getPhysicalNumberOfRows();
		for (rowindex = 1; rowindex < rows; rowindex++) {
			// 행을읽는다
			XSSFRow row = sheet.getRow(rowindex);
			if (row != null) {
				// 셀의 수
				int cells = row.getPhysicalNumberOfCells();
				for (columnindex = 0; columnindex <= cells; columnindex++) {
					// 셀값을 읽는다
					XSSFCell cell = row.getCell(columnindex);
					String value = "";
					// 셀이 빈값일경우를 위한 널체크
					if (cell == null) {
						continue;
					} else {
						// 타입별로 내용 읽기
						switch (cell.getCellType()) {
						case XSSFCell.CELL_TYPE_FORMULA:
							value = cell.getCellFormula();
							break;
						case XSSFCell.CELL_TYPE_NUMERIC:
							value = (int) cell.getNumericCellValue() + "";
							break;
						case XSSFCell.CELL_TYPE_STRING:
							value = cell.getStringCellValue() + "";
							break;
						case XSSFCell.CELL_TYPE_BLANK:
							value = cell.getBooleanCellValue() + "";
							break;
						case XSSFCell.CELL_TYPE_ERROR:
							value = cell.getErrorCellValue() + "";
							break;
						}
					}
					System.out.println("각 셀 내용 :" + value);
				}
			}
		}

		/**
		 * 다운로드 부분
		 */
		FileInputStream in = new FileInputStream(target);
		byte b[] = new byte[in.available()];
		String uploadPath = req.getRealPath("upload");
		String sFilePath = uploadPath + "\\" + savedName; //실제 파일 경로
		String sMimeType = req.getServletContext().getMimeType(sFilePath);
		System.out.println("sMimeType : " + sMimeType);
		
		if (sMimeType == null) {
			//octet-stream은 8비트로 된 일련의 데이터
			//지정되지 않은 파일 형식
			sMimeType = "application/octet-stream";
		}
		
		res.setContentType(sMimeType);
		
		//한글 깨지지 않도록
		String sEncoding = URLEncoder.encode(savedName, "utf-8");

		//브라우저에 다운 파일 인식
		res.setHeader("Content-Disposition", "attachment; filename=" + sEncoding);
		ServletOutputStream out = res.getOutputStream();
		
		//파일 데이터 읽어오기
		int numRead;
		while ( (numRead = in.read(b, 0, b.length)) != -1) {
			out.write(b, 0, numRead);
		}
		
		/*
		 * HSSFWorkbook workbook = new HSSFWorkbook(fis); int rowindex=0; int
		 * columnindex=0; //시트 수 (첫번째에만 존재하므로 0을 준다) //만약 각 시트를 읽기위해서는 FOR문을 한번더
		 * 돌려준다 HSSFSheet sheet=workbook.getSheetAt(0); //행의 수 int
		 * rows=sheet.getPhysicalNumberOfRows();
		 * for(rowindex=1;rowindex<rows;rowindex++){ //행을 읽는다 HSSFRow
		 * row=sheet.getRow(rowindex); if(row !=null){ //셀의 수 int
		 * cells=row.getPhysicalNumberOfCells();
		 * for(columnindex=0;columnindex<=cells;columnindex++){ //셀값을 읽는다
		 * HSSFCell cell=row.getCell(columnindex); String value=""; //셀이 빈값일경우를
		 * 위한 널체크 if(cell==null){ continue; }else{ //타입별로 내용 읽기 switch
		 * (cell.getCellType()){ case HSSFCell.CELL_TYPE_FORMULA:
		 * value=cell.getCellFormula(); break; case HSSFCell.CELL_TYPE_NUMERIC:
		 * value=cell.getNumericCellValue()+""; break; case
		 * HSSFCell.CELL_TYPE_STRING: value=cell.getStringCellValue()+""; break;
		 * case HSSFCell.CELL_TYPE_BLANK: value=cell.getBooleanCellValue()+"";
		 * break; case HSSFCell.CELL_TYPE_ERROR:
		 * value=cell.getErrorCellValue()+""; break; } } System.out.println(
		 * "각 셀 내용 :"+value); } } }
		 */
		return "/exceltest";
	}
	
	@RequestMapping(value = "/downloadExcel/{filename}", method=RequestMethod.GET)
	public String downloadExcel(HttpServletRequest req, HttpServletResponse res, @PathVariable String filename) throws IOException {
		//ResponseEntity<String> entity = null;
		
		String root_path = req.getSession().getServletContext().getRealPath("/");
		String innerUploadPath = "resources/upload";
		String savedName = filename+".xlsx";
		File target = new File(root_path + "/" + innerUploadPath, savedName);
		
		System.out.println(root_path+"/"+innerUploadPath+"/"+savedName);
		
		/*
		 * 다운로드 부분
		 */
		FileInputStream in = new FileInputStream(target);
		byte b[] = new byte[in.available()];
		String uploadPath = req.getRealPath("upload");
		String sFilePath = uploadPath + "\\" + savedName; //실제 파일 경로
		String sMimeType = req.getServletContext().getMimeType(sFilePath);
		
		System.out.println("uploadPath : "+uploadPath);
		System.out.println("sFilePath : "+sFilePath);
		System.out.println("sMimeType : " + sMimeType);
		
		if (sMimeType == null) {
			//octet-stream은 8비트로 된 일련의 데이터
			//지정되지 않은 파일 형식
			sMimeType = "application/octet-stream";
		}
		
		res.setContentType(sMimeType);
		
		//한글 깨지지 않도록
		String sEncoding = URLEncoder.encode(savedName, "utf-8");

		//브라우저에 다운 파일 인식
		res.setHeader("Content-Disposition", "attachment; filename=" + sEncoding);
		ServletOutputStream out = res.getOutputStream();
		
		//파일 데이터 읽어오기
		int numRead;
		while ( (numRead = in.read(b, 0, b.length)) != -1) {
			out.write(b, 0, numRead);
		}
		
		out.flush();
		out.close();
		in.close();
		
		return "admin/insert_exam";
	}
}
