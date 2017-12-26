package com.project.sns.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.sns.board.dao.BoardDAO;
import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ReplyVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDAO dao;
	
	@Override
	public List<BoardVO> getBoardList(int line_seq) throws Exception {
		return dao.getBoardList(line_seq);
	}

	@Override
	public int getBoardCount(int line_seq) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public BoardVO getBoardValue(int line_seq, int board_seq) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ReplyVO> getBoardReply(int board_seq) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void upBoardHeart(BoardVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int inputBoardReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int inputBoard(BoardVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delBoard(int seq) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delBoardReply(int seq) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int boardModify(BoardVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}


}
