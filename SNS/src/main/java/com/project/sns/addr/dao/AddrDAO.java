package com.project.sns.addr.dao;

import java.util.List;

import com.project.sns.addr.vo.AddrVO;

public interface AddrDAO {
	public int inputAddr(List<AddrVO> vo);
	public void getAddr(int first, int last);
}
