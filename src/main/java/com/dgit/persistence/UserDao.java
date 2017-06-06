package com.dgit.persistence;

import com.dgit.domain.LoginDTO;
import com.dgit.domain.UserVO;

public interface UserDao {
	void insertUser(UserVO vo) throws Exception;
	UserVO selectOneUser(LoginDTO dto) throws Exception;
}
