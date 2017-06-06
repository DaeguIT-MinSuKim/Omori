package com.dgit.omori;

import java.util.Date;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dgit.domain.LoginDTO;
import com.dgit.domain.UserVO;
import com.dgit.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class UserServiceTest {
	@Inject
	private UserService service;
	
//	@Test
	public void insertUserTest() throws Exception{
		UserVO vo = new UserVO();
		vo.setUid("test2");
		vo.setUpw("test2");
		vo.setUemail("test@naver.com");
		vo.setUjoindate(new Date());
		vo.setIsadmin(false);
		service.insertUser(vo);
	}
	
//	@Test
	public void selectOneUserTest() throws Exception{
		LoginDTO dto =  new LoginDTO();
		dto.setUid("test1");
		dto.setUpw("test1");
		UserVO vo = service.selectOneUser(dto);
	}
}
