package com.project.sns.board.dao;


import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ReplyVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "com.project.sns.mapper.boardMapper";
	

	
	@Override
	public List<BoardVO> getBoardList(int line_seq) throws Exception {
		return sqlSession.selectList(namespace+".getBoardList", line_seq);
	}

	@Override
	public int getBoardCount(int line_seq) throws Exception {
		return sqlSession.selectOne(namespace+".getBoardCount", line_seq);
	}

	@Override
	public BoardVO getBoardValue(int line_seq, int board_seq) {
		// TODO Auto-generated method stub
		return null;
	}


	
	@Override
	public void upBoardHeart(BoardVO vo) {
		sqlSession.update(namespace+".upBoardHeart", vo);
	}

	@Override
	public int inputBoardReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int inputBoard(BoardVO vo) {
		int a = sqlSession.insert(namespace+".inputBoard", vo);
		return a;
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
	
	
	@Override
	public List<ReplyVO> getBoardReply(int board_seq) {
		return sqlSession.selectList( "com.project.sns.mapper.boardMapper.getBoardReply",board_seq);
	}
	
	@Override
	public int insertReply(ReplyVO vo) {
		int a = sqlSession.insert(namespace+".insertReply", vo);
		return a;
	}
	
}
