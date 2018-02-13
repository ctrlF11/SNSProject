package com.project.sns.user.service;

import java.util.List;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.user.vo.UserVO;

public interface UserService {
	public int insertUser(UserVO vo);
	public List<UserVO> getUserList(UserVO vo);
	public UserVO getUser(String keyword);
//	public List<UserVO> getUser1(int index);
	public String getUserImage(String id);
}