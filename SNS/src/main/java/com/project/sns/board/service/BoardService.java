package com.project.sns.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ReplyVO;

@Service
public interface BoardService {
		// 湲� 由ъ뒪�듃(�씪�씤 踰덊샇)
	    public List<BoardVO> getBoardList(int index);
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
