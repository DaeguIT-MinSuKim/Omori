package com.dgit.persistence;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.LoginDTO;
import com.dgit.domain.UserVO;

@Repository
public class UserDaoImpl implements UserDao{
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.dgit.mapper.UserMapper";

	@Override
	public void insertUser(UserVO vo) throws Exception {
		session.insert(namespace+".insertUser", vo);
	}

	@Override
	public UserVO selectOneUser(LoginDTO dto) throws Exception {
		return session.selectOne(namespace+".selectOneUser", dto);
	}

	@Override
	public UserVO selectOneUserByUid(String uid) throws Exception {
		return session.selectOne(namespace+".selectOneUserByUid", uid);
	}

}
