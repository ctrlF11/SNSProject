package com.project.sns.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.user.vo.UserVO;

public interface UserDAO {
	public int insertUser(UserVO vo);
	public List<AddrVO> getAddress() throws Exception;
	public List<UserVO> getUser(UserVO vo);
	
	public List<UserVO> getUser1(@Param("index") int index);//비동기 추가
	
}
