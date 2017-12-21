package com.project.sns.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.sns.board.dao.BoardDAO;
import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ReplyVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Inject
	private BoardDAO dao;
	
	@Override
	public List<BoardVO> getBoardList() throws Exception {
		return dao.getBoardList();
	}

	@Override
	public int getBoardCount() throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void upBoardCount(int board_seq) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public BoardVO getBoardValue(int board_seq) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ReplyVO> getBoardReply(int board_seq) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int inputBoardReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int inputBoard(BoardVO vo) {
		return dao.inputBoard(vo);
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
