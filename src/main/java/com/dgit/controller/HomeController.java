package com.dgit.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}
	
	@RequestMapping(value = "/android")
	public void androidTest() {
		logger.info("꺄륵***********************************************");
	}
	
	@RequestMapping("/android2")
	public void androidTestWithRequest(HttpServletRequest request) {
		logger.info("두번째 android 2");
//		System.out.println(request.getParameter("test"));
		System.out.println(request.getParameter("title"));
		System.out.println(request.getParameter("memo"));
	}
	
	@RequestMapping("/android3")
    @ResponseBody
    public Map<String, String> androidTestWithRequestAndResponse(HttpServletRequest request){
        System.out.println(request.getParameter("title"));
        System.out.println(request.getParameter("memo"));
        
        Map<String, String> result = new HashMap<String, String>();
        result.put("data1", "메모에요");
        result.put("data2", "두번째 메모입니다.");
        
        return result;
	}
}
