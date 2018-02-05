package com.project.sns.addr.service;

import com.project.sns.addr.dao.AddrDAO;
import com.project.sns.addr.vo.AddrVO;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

@Service
public class AddrServiceImpl implements AddrService{
	@Autowired
	private AddrDAO dao;

	@Override
	public int inputAddr(List<AddrVO> vo) {
		return dao.inputAddr(vo);
	}
	
	@Override
	public int inputAddrCat(List<AddrVO> vo) {
		return dao.inputAddrCat(vo);
	}
	
	@Override
	public int deleteAddr(List<AddrVO> vo) {
		return dao.deleteAddr(vo);
	}
	
	@Override
	public List<AddrVO> getAddress() throws Exception {
		return dao.getAddress();
	}
	
	@Override
	   public List<AddrVO> getAddress2(String inside) throws Exception {
	      System.out.println("inside : " + inside);
	      return dao.getAddress2(inside);
	   }
	@Override
	 public AddrVO getAddress3() throws Exception {
	      return dao.getAddress3();
	   }
	
	@Override
	 public List<AddrVO> getScope() throws Exception {
	      return dao.getScope();
	   }
}
