package com.project.sns.board.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ImageVO;
import com.project.sns.board.vo.ReplyVO;
import com.project.sns.board.vo.StoryVO;

public interface BoardDAO {
	public List<BoardVO> getBoardList(@Param("index") int index);
	// 湲� 媛쒖닔(�씪�씤 踰덊샇)
	public int getBoardCount(int line_seq) throws Exception;

	// 湲� �긽�꽭(湲� 踰덊샇, �씪�씤 踰덊샇[BoardVO])
	public BoardVO getBoardValue(int line_seq, int board_seq);
	
	
	
	public void upBoardHeart(BoardVO vo);
	public int inputBoardReply(ReplyVO vo);
	public int delBoard(int seq);
	public int delBoardReply(int seq);
	public int boardModify(BoardVO vo);	
	public void regist(BoardVO board) throws Exception;
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
	public void registup(BoardVO board) throws Exception;
	
	public int saveImage(ImageVO vo) throws SQLException;
	public ImageVO getImage(int img_seq) throws Exception;
	public void insertReply(ReplyVO vo);
	
}
