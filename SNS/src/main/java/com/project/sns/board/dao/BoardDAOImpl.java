package com.project.sns.board.dao;


import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.sns.board.vo.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "com.project.sns.mapper.memberMapper";
	
	@Override
	public List<BoardVO> getBoardList() {
		return sqlSession.selectList(namespace+".getBoardList");
	}

	@Override
	public void insertBoard(BoardVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateBoard(BoardVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBoard(BoardVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public BoardVO getBoard(int board_seq, int line_seq) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
