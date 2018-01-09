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
}
