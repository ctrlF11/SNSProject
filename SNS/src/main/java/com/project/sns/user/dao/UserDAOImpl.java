package com.project.sns.user.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.user.vo.UserVO;

public class UserDAOImpl implements UserDAO{
	@Autowired
	SqlSessionTemplate sqlSession;
	
	private static final String namespace = "com.project.sns.mapper.userMapper";
	
	public int insertUser(UserVO vo) {
		return sqlSession.insert(namespace+".insertUser",vo);
	}

	@Override
	public List<AddrVO> getAddress() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".getAddress");
				
			
	}
}
