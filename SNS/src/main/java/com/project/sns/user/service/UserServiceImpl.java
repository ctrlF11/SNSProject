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

	@Override
	public int insertUser(UserVO vo) {
		return userDao.insertUser(vo);
	}

	@Override
	public List<AddrVO> getAddress() throws Exception {
		return userDao.getAddress();
	}
}