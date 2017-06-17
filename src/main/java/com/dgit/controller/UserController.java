package com.dgit.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dgit.domain.LoginDTO;
import com.dgit.domain.UserVO;
import com.dgit.interceptor.LoginInterceptor;
import com.dgit.service.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService service;
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login(RedirectAttributes rttr){
		logger.info("login GET..........");
		rttr.addFlashAttribute("showLoginForm", "showLoginForm");
		return "redirect:/";
	}
	
	@RequestMapping(value="/loginPost", method=RequestMethod.POST)
	public String loginPost(LoginDTO dto, Model model, RedirectAttributes rttr) throws Exception{
		logger.info("loginPost POST..........");
		
		UserVO user = service.selectOneUser(dto);
		
		if (user == null) {
			rttr.addFlashAttribute("showFailLoginForm", "showFailLoginForm");
			return "redirect:/";
		}else{
			model.addAttribute("userVO", user);
			return null;
		}
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logoutGET(HttpSession session){
		logger.info("logout GET..........");
		
		UserVO vo = (UserVO) session.getAttribute(LoginInterceptor.LOGIN);
		
		if (vo != null) {
			logger.info(vo.toString());
			session.removeAttribute(LoginInterceptor.LOGIN);
			session.invalidate();
		}
		return "redirect:/user/login";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String joinGet(RedirectAttributes rttr){
		logger.info("join GET..........");
		rttr.addFlashAttribute("showJoinForm", "showJoinForm");
		return "redirect:/";
	}

	@ResponseBody
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public ResponseEntity<String> joinPost(UserVO vo){
		logger.info("join POST..........");
		
		ResponseEntity<String> entity = null;
		try{
			service.insertUser(vo);
			entity = new ResponseEntity<>("success", HttpStatus.OK);
		}catch(Exception e){
			entity = new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/androidJoin", method=RequestMethod.POST)
	public ResponseEntity<String> androidJoinPost(HttpServletRequest req) throws Exception{
		System.out.println("androidJoin POST.................");
		
		ResponseEntity<String> entity = null;
		
		String uid = req.getParameter("id");
		String upw = req.getParameter("pw");
		String uemail = req.getParameter("email");
		
		try{
			LoginDTO dto = new LoginDTO();
			dto.setUid(uid);
			dto.setUpw(upw);
			
			if(service.selectOneUser(dto) != null){
				entity = new ResponseEntity<>("fail", HttpStatus.OK);
			}else{
				UserVO vo = new UserVO();
				vo.setUid(uid);
				vo.setUpw(upw);
				vo.setUemail(uemail);
				vo.setUjoindate(new Date());
				service.insertUser(vo);
				entity = new ResponseEntity<>("success", HttpStatus.OK);
			}
		}catch(Exception e){
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/androidLogin", method=RequestMethod.POST)
	public ResponseEntity<String> androidLoginPOST(HttpServletRequest req) throws Exception{
		System.out.println("androidLogin POST.................");
		
		ResponseEntity<String> entity = null;
		
		String uid = req.getParameter("id");
		String upw = req.getParameter("pw");
		
		try{
			LoginDTO dto = new LoginDTO();
			dto.setUid(uid);
			dto.setUpw(upw);
			
			UserVO user = service.selectOneUser(dto);
			
			if(user == null){
				entity = new ResponseEntity<>("fail", HttpStatus.OK);
			}else{
				entity = new ResponseEntity<>(user.getUid(), HttpStatus.OK);
			}
		}catch(Exception e){
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
