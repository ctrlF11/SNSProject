package com.project.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.UserMapper;
import com.project.vo.UserVO;

@Service
public class UserService {

	@Autowired
	UserMapper userDao;
	
	public int insertUser(UserVO vo){
		return userDao.insertUser(vo);	
}
}
