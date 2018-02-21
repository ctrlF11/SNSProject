package com.project.sns.user.service;

import java.util.HashMap;
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

	@Override
	public String getUserImage(String id) {
		// TODO Auto-generated method stub
		return userDao.getUserImage(id);
	}

	@Override
	public int getFollowingCount(String id) {
		// TODO Auto-generated method stub
		return userDao.getFollowingCount(id);
	}

	@Override
	public int getFollowerCount(String id) {
		// TODO Auto-generated method stub
		return userDao.getFollowerCount(id);
	}

	@Override
	public int followByBoard(HashMap<String, String> ids) {
		// TODO Auto-generated method stub
		return userDao.followByBoard(ids);
	}
	
	@Override
	public int followByPage(HashMap<String, String> ids) {
		// TODO Auto-generated method stub
		return userDao.followByPage(ids);
	}
	
	/*@Override
	public List<UserVO> getUser1(int index){
		return userDao.getUser1(index);
	}*/
}