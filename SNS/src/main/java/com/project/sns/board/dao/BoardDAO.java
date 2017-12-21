package com.project.sns.board.dao;

import java.util.List;

import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ReplyVO;

public interface BoardDAO {
	public int getBoardCount() throws Exception;
	public void upBoardCount(int board_seq);
	public List<BoardVO> getBoardList() throws Exception;
	public BoardVO getBoardValue(int board_seq);
	public List<ReplyVO> getBoardReply(int board_seq);
	public int inputBoardReply(ReplyVO vo);
	public int inputBoard(BoardVO vo);
	public int delBoard(int seq);
	public int delBoardReply(int seq);
	public int boardModify(BoardVO vo);
}
