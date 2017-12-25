package com.project.sns.board.service;

import java.util.List;

import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ReplyVO;

public interface BoardService {
		// 글 리스트(라인 번호)
		public List<BoardVO> getBoardList(int line_seq) throws Exception;
		
		// 글 개수(라인 번호)
		public int getBoardCount(int line_seq) throws Exception;

		// 글 상세(글 번호, 라인 번호[BoardVO])
		public BoardVO getBoardValue(int board_seq, int line_seq);
		public List<ReplyVO> getBoardReply(int board_seq);
		
		
		public void upBoardHeart(BoardVO vo);
		public int inputBoardReply(ReplyVO vo);
		public int inputBoard(BoardVO vo);
		public int delBoard(int seq);
		public int delBoardReply(int seq);
		public int boardModify(BoardVO vo);
}
