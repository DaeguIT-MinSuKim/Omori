package com.dgit.controller;

import java.io.File;
import java.io.FileInputStream;
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

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
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

	@RequestMapping(value = "/test_managing", method = RequestMethod.GET)
	public String testManagingGET(Model model) throws Exception {
		List<TestNameVO> list = nameService.selectAllTestName();
		
		model.addAttribute("nameList", list);

		return "admin/test_managing";
	}//test_managing
	
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
	public ResponseEntity<String> insertQuestionExample(int tno, String tq_subject, int tq_small_no, String tq_question, int tq_answer, 
			String example1, String example2, String example3, String example4) throws Exception {
		ResponseEntity<String> entity = null;
		
		String[] te_content = new String[]{example1, example2, example3, example4};
		
		try {
			TestQuestionVO vo = new TestQuestionVO();
			
			TestNameVO testName = new TestNameVO();
			testName.setTno(tno);
			
			vo.setTestName(testName);
			vo.setTq_subject(tq_subject.trim());
			vo.setTq_small_no(tq_small_no);
			vo.setTq_question(tq_question.trim());
			vo.setTq_answer(tq_answer);
			
			questionService.insertTestQuestion(vo);
			TestQuestionVO question = questionService.selectOneTestQuestion(tno, tq_small_no);

			for(int i=0; i<te_content.length; i++){
				System.out.println(te_content[i]);
				TestExampleVO example = new TestExampleVO();
				example.setQuestion(question);
				example.setTe_small_no(i+1);
				example.setTe_content(te_content[i].trim());
				exampleService.insertTestExample(example);
			}
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//insertQuestionExample
	
	@ResponseBody
	@RequestMapping(value = "/updateTestName", method = RequestMethod.POST)
	public ResponseEntity<String> updateTestName(int tno, String tname, String tdate) throws Exception {
		ResponseEntity<String> entity = null;
		
		try {
			TestNameVO vo = new TestNameVO();
			vo.setTno(tno);
			vo.setTname(tname.trim());
			vo.setTdate(tdate.trim());
			
			nameService.updateTestName(vo);
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//updateTestName
	
	@ResponseBody
	@RequestMapping(value = "/deleteTestName", method = RequestMethod.POST)
	public ResponseEntity<String> deleteTestName(int tno) throws Exception {
		ResponseEntity<String> entity = null;
		
		try {
			nameService.deleteTestName(tno);
			
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//deleteTestName
	
	@ResponseBody
	@RequestMapping(value = "/getLastTnoTqno", method = RequestMethod.POST)
	public ResponseEntity<List<Integer>> getLastTnoTqno() throws Exception {
		ResponseEntity<List<Integer>> entity = null;
		
		try {
			int tno = nameService.selectLastTno();
			int tqno = questionService.selectLastTqno();
			if(tno == 1){
				nameService.initAutoIncrementName(1);
				questionService.initAutoIncrementQue(1);
			}
			if(tqno == 1){
				questionService.initAutoIncrementQue(1);
			}
			List<Integer> list = new ArrayList<>();
			list.add(tno);
			list.add(tqno);
			
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
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
	
	@ResponseBody
	@RequestMapping(value = "/getTestNameList", method = RequestMethod.POST)
	public ResponseEntity<List<TestNameVO>> getTestNameList() {
		ResponseEntity<List<TestNameVO>> entity = null;
		
		logger.info("getTestNameList POST..........................");

		try {
			entity = new ResponseEntity<>(nameService.selectAllTestName(), HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}//getTestNameList

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
	
	/* -----------
	 * 엑셀 파일 업로드	
	 * -----------*/
	@ResponseBody
	@RequestMapping(value = "/uploadExcelFile", method = RequestMethod.POST)
	public ResponseEntity<String> uploadExcelFile(MultipartFile nameFile, MultipartFile questionFile, MultipartFile exampleFile, HttpServletRequest req) throws IOException, InvalidFormatException{
		ResponseEntity<String> entity = null;
		
		try {
			String result = "";
			
			if(nameFile.getSize() > 0){
				result = uploadExcelFile(req, nameFile, "nameFile");
			}
			if(questionFile.getSize() > 0){
				result = uploadExcelFile(req, questionFile, "questionFile");
			}
			if(exampleFile.getSize() > 0){
				result = uploadExcelFile(req, exampleFile, "exampleFile");
			}
			
			if(result == null){
				entity = new ResponseEntity<>("success", HttpStatus.OK);
			}else if(result.equals("matchingError")){
				entity = new ResponseEntity<>("matchingError", HttpStatus.OK);
			}else if(result.equals("testNameNull")){
				entity = new ResponseEntity<>("testNameNull", HttpStatus.OK);
			}else if(result.equals("testQuestoinNull")){
				entity = new ResponseEntity<>("testQuestoinNull", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}//uploadExcelFile
	
	public String uploadExcelFile(HttpServletRequest req, MultipartFile multipartFile, String fileName) throws Exception{
		String root_path = req.getSession().getServletContext().getRealPath("/");
		String innerUploadPath = "resources/upload";

		File dir = new File(root_path + "/" + innerUploadPath);
		if (!dir.exists()) {
			dir.mkdir();
		}
		
		UUID uid = UUID.randomUUID();
		String savedName1 = uid.toString() + "_" + multipartFile.getOriginalFilename(); //랜덤이름_원본이름
		
		File target = new File(root_path + "/" + innerUploadPath, savedName1);
		FileCopyUtils.copy(multipartFile.getBytes(), target);
		
		FileInputStream fis = new FileInputStream(target);
		Workbook workbook = WorkbookFactory.create(fis);
		Sheet sheet = workbook.getSheetAt(0); //시트 번째 (만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다)
		int rows = sheet.getPhysicalNumberOfRows(); // 행의 수
		String returnText = null;
		
		//행 읽는 for문
		for (int rowindex = 1; rowindex < rows; rowindex++) {
			XSSFRow row = (XSSFRow) sheet.getRow(rowindex); //각 행 읽기
			if (row != null) {
				int cells = row.getPhysicalNumberOfCells(); // 셀의 수
				
				if(fileName.equals("nameFile")){
					if(cells != 3) {
						returnText = "matchingError";
						break;
					}
				}else if(fileName.equals("questionFile")){
					if(nameService.selectLastTno() == 1){
						returnText = "testNameNull";
						break;
					}
					if(cells != 6){
						returnText = "matchingError";
						break;
					}
				}else if(fileName.equals("exampleFile")){
					if(questionService.selectLastTqno() == 1){
						returnText = "testQuestoinNull";
					}
					if(cells != 3){
						returnText = "matchingError";
						break;
					}
				}
				
				//셀 읽는 for문
				try {
					addToDB(cells, row, fileName);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
				/*for (int columnindex = 0; columnindex <= cells; columnindex++) {
					XSSFCell cell = row.getCell(columnindex); //각 셀 읽기
					String value = "";
					
					if (cell == null) {// 셀이 빈값일경우를 위한 널체크
						continue;
					} else { // 타입별로 내용 읽기
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
				}*///end of child for
			}
		}//end of parent for
		
		return returnText;
	}
	
	public void addToDB(int cells, XSSFRow row, String fileName) throws Exception{
		//nameFile
		List<String> tnoList = new ArrayList<>(); //공통
		List<String> tnameList = new ArrayList<>();
		List<String> tdateList = new ArrayList<>();
		//questionFile
		List<String> tqNoList = new ArrayList<>(); //공통
		List<String> subjectList = new ArrayList<>();
		List<String> smallNoList = new ArrayList<>();
		List<String> questionList = new ArrayList<>();
		List<String> answerList = new ArrayList<>();
		//exampleFile
		List<String> teSmallNoList = new ArrayList<>();
		List<String> contentList = new ArrayList<>();
		
		for (int columnindex = 0; columnindex <= cells; columnindex++) {
			XSSFCell cell = row.getCell(columnindex); // 셀값을 읽는다
			String value = "";
			
			if (cell == null) {// 셀이 빈값일경우를 위한 널체크
				continue;
			} else { // 타입별로 내용 읽기
				switch (cell.getCellType()) {
				case XSSFCell.CELL_TYPE_FORMULA:
					value = cell.getCellFormula();
					break;
				case XSSFCell.CELL_TYPE_NUMERIC:
					if(fileName.equals("nameFile")){
						if(DateUtil.isCellDateFormatted(cell)){
							Date date = cell.getDateCellValue();
							value = new SimpleDateFormat("yyyy-MM-dd").format(date);
						}else{
							value = (int) cell.getNumericCellValue() + "";
						}
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
			
			if(fileName.equals("nameFile")){
				switch (columnindex) {
				case 0: tnoList.add(value); break;
				case 1: tnameList.add(value); break;
				case 2: tdateList.add(value); break;
				}
			}else if(fileName.equals("questionFile")){
				switch (columnindex) {
				case 0: tqNoList.add(value); break;
				case 1: tnoList.add(value); break;
				case 2: subjectList.add(value); break;
				case 3: smallNoList.add(value); break;
				case 4: questionList.add(value); break;
				case 5: answerList.add(value); break;
				}
			}else if(fileName.equals("exampleFile")){
				switch (columnindex) {
				case 0: tqNoList.add(value); break;
				case 1: teSmallNoList.add(value); break;
				case 2: contentList.add(value); break;
				}
			}
			
			System.out.println("셀 : "+value);
		}//end of child for
		
		if(fileName.equals("nameFile")){
			for (int i = 0; i < tnoList.size(); i++) {
				int tno = Integer.parseInt(tnoList.get(i));
				
				System.out.println("tno-------------------" + tno);
				String tname = tnameList.get(i);
				String tdate = tdateList.get(i);
				
				TestNameVO vo = new TestNameVO();
				vo.setTno(tno);
				vo.setTname(tname);
				vo.setTdate(tdate);
				
				if(nameService.selectOneTestName(tno) != null){
					nameService.updateTestName(vo);
				}else{
					nameService.insertTestName(vo);
				}
			}
		}else if(fileName.equals("questionFile")){
			for (int i = 0; i < tqNoList.size(); i++) {
				int tno = Integer.parseInt(tnoList.get(i));
				int tq_no = Integer.parseInt(tqNoList.get(i));
				String tq_subject = subjectList.get(i);
				int tq_small_no = Integer.parseInt(smallNoList.get(i));
				String tq_question = questionList.get(i);
				int tq_answer = Integer.parseInt(answerList.get(i));
				
				TestQuestionVO vo = new TestQuestionVO();
				vo.setTq_no(tq_no);
				
				TestNameVO testName = nameService.selectOneTestName(tno);
				vo.setTestName(testName);
				
				vo.setTq_subject(tq_subject);
				vo.setTq_small_no(tq_small_no);
				vo.setTq_question(tq_question);
				vo.setTq_answer(tq_answer);
				
				if(questionService.selectOneTestQuestionByTqno(tq_no) != null){
					questionService.updateTestQuestion(vo);
				}else{
					questionService.insertTestQuestion(vo);
				}
			}
		}else if(fileName.equals("exampleFile")){
			for (int i = 0; i < teSmallNoList.size(); i++) {
				int tq_no = Integer.parseInt(tqNoList.get(i));
				int te_small_no = Integer.parseInt(teSmallNoList.get(i));
				String te_content = contentList.get(i);
				
				TestExampleVO vo = new TestExampleVO();
				
				TestQuestionVO question = questionService.selectOneTestQuestionByTqno(tq_no);
				vo.setQuestion(question);
				
				vo.setTe_small_no(te_small_no);
				vo.setTe_content(te_content);
				
				if(exampleService.selectOneTestExampleNotTeNo(tq_no, te_small_no) != null){
					TestExampleVO temp =  exampleService.selectOneTestExampleNotTeNo(tq_no, te_small_no);
					vo.setTe_no(temp.getTe_no());
					exampleService.updateTestExample(vo);
				}else{
					exampleService.insertTestExample(vo);
				}
			}
		}
	}
	

	@SuppressWarnings("resource")
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
		
		
		String sEncoding = URLEncoder.encode(savedName, "utf-8"); //한글 깨지지 않도록

		res.setHeader("Content-Disposition", "attachment; filename=" + sEncoding); //브라우저에 다운 파일 인식
		ServletOutputStream out = res.getOutputStream();
		
//		파일 데이터 읽어오기
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
