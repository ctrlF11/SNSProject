package com.project.sns.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.sns.board.dao.BoardDAO;
import com.project.sns.board.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Inject
	private BoardDAO dao;
	
	@Override
	public List<BoardVO> getBoardList() throws Exception {
		return dao.getBoardList();
	}
}
