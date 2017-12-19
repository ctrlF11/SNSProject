package com.project.sns.board.service;

import java.util.List;

import com.project.sns.board.vo.BoardVO;

public interface BoardService {
	public List<BoardVO> getBoardList() throws Exception;
}
