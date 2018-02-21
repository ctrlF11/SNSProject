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
	public int inputAddrCat(List<AddrVO> vo) {
		return sqlSession.insert(namespace+".inputAddrCat", vo);
	}
	
	@Override
	public int deleteAddr(List<AddrVO> vo) {
		return sqlSession.delete(namespace+".deleteAddr", vo);
	}

	@Override
	public List<AddrVO> getAddress() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".getAddress");			
	}
	
	
	@Override
	public List<AddrVO> getAddress2(String inside) throws Exception {
	      // TODO Auto-generated method stub
	      System.out.println("inside impl: " + inside);
	      return sqlSession.selectList(namespace+".getAddress2",inside);   
	 }
	   
	 @Override
	 public AddrVO getAddress3() throws Exception {
	      // TODO Auto-generated method stub
	      return sqlSession.selectOne(namespace+".getAddress3");   
	 }
	 
    @Override
    public List<AddrVO> getAddrWithCode(String sigungucode) throws Exception {
         // TODO Auto-generated method stub
         return sqlSession.selectList(namespace+".getAddrWithCode", sigungucode);   
    }

	@Override
	public AddrVO callInfo(String contentId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".callInfo", contentId);
	}

	@Override
	public AddrVO callReview(String contentId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".callReview", contentId);
	}

	@Override
	public double getStarAvg(String contentId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".getStarAvg", contentId);
		
	}
	
}
