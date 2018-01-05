package com.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.AddrVO;
import com.project.vo.UserVO;

@Repository
public class UserDAOImpl implements UserMapper{

	@Autowired
	SqlSessionTemplate sqlSession;
	
	public int insertUser(UserVO vo) {
		return sqlSession.insert("User.insertUser",vo);
	}
	public List<AddrVO> list()
	{
		return sqlSession.selectList("User.getMap");
	}
}
