package com.project.sns.addr.service;

import java.util.List;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.board.vo.ReplyVO;
import com.project.sns.user.vo.UserVO;

public interface AddrService {
	public int inputAddr(List<AddrVO> vo);
	public int inputAddrCat(List<AddrVO> vo);
	public int deleteAddr(List<AddrVO> vo);


	
}
