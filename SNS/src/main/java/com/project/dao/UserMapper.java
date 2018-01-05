package com.project.dao;

import java.util.List;

import com.project.vo.AddrVO;
import com.project.vo.UserVO;

public interface UserMapper {

	public int insertUser(UserVO vo);
	public List<AddrVO> list();
	
}
