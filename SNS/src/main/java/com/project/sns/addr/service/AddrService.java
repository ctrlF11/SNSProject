package com.project.sns.addr.service;

import java.util.List;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.board.vo.BoardVO;

public interface AddrService {
	public int inputAddr(List<AddrVO> vo);
	public int inputAddrCat(List<AddrVO> vo);
	public List<AddrVO> getAddress() throws Exception;
	
	public List<AddrVO> getAddrByWeather(String sigungucode, String inside) throws Exception;
	public List<AddrVO> getAddrWithCode(String sigungucode) throws Exception;  
	public List<BoardVO> getHeart() throws Exception;  
	
	public void insertPath(BoardVO vo);
	public int getCount(String id);
	
	public AddrVO callInfo(String contentId) throws Exception;
	public AddrVO callReview(String contentId) throws Exception;
	public double getStarAvg(String contentId) throws Exception;
}
