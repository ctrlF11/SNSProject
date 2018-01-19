package com.project.sns.addr.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.board.vo.ReplyVO;
import com.project.sns.user.vo.UserVO;

public interface AddrDAO {
	public int inputAddr(List<AddrVO> vo);
	public void getAddr(int first, int last);
	public int inputAddrCat(List<AddrVO> vo);
	public int deleteAddr(List<AddrVO> vo);
	public List<AddrVO> getTourBoard(@Param("index") int index);

}
