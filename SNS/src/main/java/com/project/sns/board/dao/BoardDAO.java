package com.project.sns.board.dao;

import java.util.List;

import com.project.sns.board.vo.BoardVO;

public interface BoardDAO {
	public void insertBoard(BoardVO vo);
	public void updateBoard(BoardVO vo);
	public void deleteBoard(BoardVO vo);
	public BoardVO getBoard(int board_seq, int line_seq);
	public List<BoardVO> getBoardList();
}
