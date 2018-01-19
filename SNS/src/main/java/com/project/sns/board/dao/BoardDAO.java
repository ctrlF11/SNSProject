package com.project.sns.board.dao;

import java.util.List;

import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ReplyVO;

public interface BoardDAO {
	public List<BoardVO> getBoardList(int line_seq) throws Exception;
	
	// 湲� 媛쒖닔(�씪�씤 踰덊샇)
	public int getBoardCount(int line_seq) throws Exception;

	// 湲� �긽�꽭(湲� 踰덊샇, �씪�씤 踰덊샇[BoardVO])
	public BoardVO getBoardValue(int line_seq, int board_seq);
	
	
	
	public void upBoardHeart(BoardVO vo);
	public int inputBoardReply(ReplyVO vo);
	public int inputBoard(BoardVO vo);
	public int delBoard(int seq);
	public int delBoardReply(int seq);
	public int boardModify(BoardVO vo);
	
	public List<ReplyVO> getBoardReply(int board_seq);
	public int insertReply(ReplyVO vo);
}
