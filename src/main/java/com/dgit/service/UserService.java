package com.dgit.service;

import com.dgit.domain.LoginDTO;
import com.dgit.domain.UserVO;

public interface UserService {
	void insertUser(UserVO vo) throws Exception;
	UserVO selectOneUser(LoginDTO dto) throws Exception;
}
