package com.project.sns.board.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ImageVO;
import com.project.sns.board.vo.ReplyVO;
import com.project.sns.board.vo.StoryVO;

@Service
public interface BoardService {
		// 疫뀐옙 �뵳�딅뮞占쎈뱜(占쎌뵬占쎌뵥 甕곕뜇�깈)
	    public List<BoardVO> getBoardList(HashMap map);
	    public List<BoardVO> getMainBoardList(int index);
	    public int getBoardCount(int line_seq) throws Exception;

		// �� ��(�� ��ȣ, ���� ��ȣ[BoardVO])
		public BoardVO getBoardValue(int line_seq, int board_seq);
		public List<ReplyVO> getBoardReply(int board_seq);
		
		public void upBoardHeart(BoardVO vo);
		public int inputBoardReply(ReplyVO vo);
		public int delBoard(int seq);
		public int delBoardReply(int seq);
		public int boardModify(BoardVO vo);

		public List<String> getAttach(Integer bno)throws Exception;
		public List<StoryVO> getStory(String id);
		public int inputStory(StoryVO vo);
		
		public List<BoardVO> getBoardList(StoryVO vo);
		public int getBoardSeq(BoardVO vo);
		public int inputBoard(BoardVO vo);
		public int updateBoard(BoardVO vo);
		
		public int deleteBoard(BoardVO vo);
		public int deleteBoardByStory(StoryVO vo);
		public int deleteStory(StoryVO vo);
		
		public int addImg(String fileName)throws Exception;
		public List<ImageVO> getImg(int board_seq)throws Exception;
		public void regist(BoardVO board) throws Exception;
		public void registup(BoardVO board) throws Exception;
		
		public int saveImage(ImageVO vo) throws SQLException;
		public ImageVO getImage(int img_seq) throws Exception;
		public void insertReply(ReplyVO vo);
		
		// 2018/02/05 in
		public List<StoryVO> getStoryAll(String id) throws Exception;
//		public List<StoryVO> getStoryAll(HashMap map) throws Exception;
		
}