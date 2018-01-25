package com.project.sns.user.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.user.vo.UserVO;

@Service
public class UserDAOImpl implements UserDAO{
	@Autowired
	SqlSessionTemplate sqlSession;
	
	private static final String namespace = "com.project.sns.mapper.userMapper";
	
	@Override // insert new user
	public int insertUser(UserVO vo) {
		return sqlSession.insert(namespace+".insertUser",vo);
	}
	
	@Override // get user list
	public List<UserVO> getUserList(UserVO vo){
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".getUserList",vo);	
	}
	
/*	@Override // ?
	public List<UserVO> getUser1(int index){
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".getUser1",index);	
	}
*/
	@Override // get one user data
	public UserVO getUser(String keyword) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".getUser", keyword);
	}
}
