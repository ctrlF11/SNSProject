package com.project.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.UserDAO;
import com.project.vo.UserVO;

@Service
public class UserService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int insertArticle(UserVO vo){
		UserDAO boardDao = sqlSessionTemplate.getMapper(UserDAO.class);
		return boardDao.insertUser(vo);

	
}
}
