package com.project.sns.addr.dao;

import java.util.List;

import com.project.sns.addr.vo.AddrVO;

public interface AddrDAO {
	public int inputAddr(List<AddrVO> vo);
	public int inputAddrCat(List<AddrVO> vo);
	public int deleteAddr(List<AddrVO> vo);
	public List<AddrVO> getAddress() throws Exception;
	
	   public List<AddrVO> getAddress2(String inside) throws Exception;
	   public AddrVO getAddress3() throws Exception;
}
