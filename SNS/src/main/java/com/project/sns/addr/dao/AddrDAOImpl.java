package com.project.sns.addr.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.sns.addr.vo.AddrVO;

@Repository
public class AddrDAOImpl implements AddrDAO{
	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "com.project.sns.mapper.addrMapper";

	@Override
	public int inputAddr(List<AddrVO> vo) {
		return sqlSession.insert(namespace+".inputAddr", vo);
	}

	@Override
	public void getAddr(int first, int last) {
		// TODO Auto-generated method stub
		
	}
	
	
}
