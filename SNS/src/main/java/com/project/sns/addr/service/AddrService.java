package com.project.sns.addr.service;

import java.util.List;

import com.project.sns.addr.vo.AddrVO;

public interface AddrService {
	public int inputAddr(List<AddrVO> vo);
	public int inputAddrCat(List<AddrVO> vo);
	public int deleteAddr(List<AddrVO> vo);
	public List<AddrVO> getAddress() throws Exception;
}
