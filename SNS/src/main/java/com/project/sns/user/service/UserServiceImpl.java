package com.project.sns.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.user.dao.UserDAO;
import com.project.sns.user.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDao;

	@Override // new user insert
	public int insertUser(UserVO vo) {
		return userDao.insertUser(vo);
	}
	
	@Override // get user data
	public List<UserVO> getUserList(UserVO vo){
		return userDao.getUserList(vo);
	}

	@Override // get one user data
	public UserVO getUser(String keyword) {
		return userDao.getUser(keyword);
	}
	
	/*@Override
	public List<UserVO> getUser1(int index){
		return userDao.getUser1(index);
	}*/
}