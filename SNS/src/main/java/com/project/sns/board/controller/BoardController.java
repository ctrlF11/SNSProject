package com.project.sns.board.controller;
 
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
 
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.board.service.BoardService;
import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ImageVO;
import com.project.sns.board.vo.ReplyVO;
import com.project.sns.board.vo.StoryVO;
import com.project.sns.user.service.UserService;
import com.project.sns.user.vo.UserVO;
 
/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
    
    private final Logger logger = LoggerFactory.getLogger(BoardController.class);
    
    
	//추가!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	@RequestMapping("/message")
	public String message() {
		return "chat";
	}
	
	@Autowired
    private BoardService service;
    private UserService  userService;
    /**
     * Simply selects the home view to render by returning its name.
     */
    
    @RequestMapping("/getBoardList.do")
    public String getBoardList(@RequestParam("index") int index,@RequestParam("story_seq") int story_seq, HttpServletRequest req) throws Exception{
        logger.info("getBoardList");
        System.out.println("index : " + index +" story-seq : " + story_seq);
        HashMap map = new HashMap();
        map.put("index", index);
        map.put("story_seq", story_seq);
        
        List<BoardVO> user = service.getBoardList(map);
        req.setAttribute("user", user);
        /*if(index == 0)
          return "home1";
        else*/ 
        	return "table";
    }
    
    @RequestMapping("/getMainBoardList.do")  // ����ȭ�� �񵿱� �۾�
    public String getMainBoardList(@RequestParam("index") int index, HttpServletRequest req) throws Exception{
        logger.info("getMainBoardList");
        System.out.println("index : " + index);
        List<BoardVO> mainTable = service.getMainBoardList(index);
        req.setAttribute("mainTable", mainTable);
        
        return "mainTable";
    }
       
    @RequestMapping("insertReply.do")
    String insertReply(ReplyVO vo,Model model){ 
    	service.insertReply(vo);
    	model.addAttribute("reply",service.getBoardReply(vo.getBoard_seq()));
       return "replylist";
    }
    
    @RequestMapping("/homeview.do")
    public String home1(@RequestParam("story_seq") int story_seq,HttpServletRequest req){
       req.setAttribute("story_seq", story_seq);
       return "home1";
    }//占쌉시깍옙
    
    @RequestMapping("/modifyBoard")
    public String writeForm(Model model) {
    	String id = "123asdf";
    	List<StoryVO> story = service.getStory(id);
    	
    	model.addAttribute("story",story);
    	return "modifyBoard";
    }
    
    @ResponseBody
    @RequestMapping("/inputStory")
    public int inputStory(StoryVO vo) {    	
    	service.inputStory(vo);
    	int nr = vo.getStory_seq();

    	return nr;
    }
    
    @ResponseBody
    @RequestMapping("/inputBoard")
    public void inputBoard(BoardVO vo) throws Exception {
    	System.out.println("BoardVO.getFiles() : " + vo.getFiles());
    	System.out.println("BoardVO.getTitle() : " + vo.getTitle());
    	//�Խñ� ����Ȯ��
    	int i = service.getBoardSeq(vo);
    	int k = 100;
    	if(i == 0) {
    		service.regist(vo);
    	}else
    		service.registup(vo);
    }
    
     @RequestMapping("/mainHomeView.do")
    public String mainHome(ImageVO vo) throws SQLException{
    	
    	return "mainHome";
    }
    
    @RequestMapping("/deleteBoard")
    public void deleteBoard(BoardVO vo){
    	service.deleteBoard(vo);
    }
    
    @RequestMapping("/deleteStory")
    public void deleteStory(StoryVO vo){
    	service.deleteStory(vo);
    	service.deleteBoardByStory(vo);
    }
    
    @RequestMapping("/saveImage")
    public void saveImage(ImageVO vo) throws SQLException{
    	service.saveImage(vo);
    }
    
   /* @RequestMapping("/getUser1.do")
    public String getUser1(@RequestParam("index") int index, HttpServletRequest req) throws Exception{
        logger.info("getBoardList");
        System.out.println("index : " + index);
        List<UserVO> user = userService.getUser1(index);
        req.setAttribute("user", user);
        if(index == 0)
          return "home1";
        else 
        	return "user";
    }*/
    
//  @RequestMapping("/getBoardList.do")
//  public String getBoardList(@RequestParam("line_seq") int line_seq, Model model) throws Exception{
//
//      logger.info("getBoardList");
//      
//      List<BoardVO> boardList = service.getBoardList(line_seq);
//      
//      model.addAttribute("boardList", boardList);
//
//      return "BoardList";
//  }
  
//  @RequestMapping("/getBoardList2.do")
//  public String getBoardList2(@RequestParam("line_seq") int line_seq, Model model) throws Exception{
//  	
//  	logger.info("getBoardList2");
//  	
//  	List<BoardVO> boardList = service.getBoardList(line_seq);
//  	System.out.println(boardList.get(0).getLine_seq());
//  	model.addAttribute("boardList", boardList);
//  	
//  	return "BoardList2";
//  }
    
    /* @RequestMapping("/getBoardValue.do")
    public String getBoardValue(@RequestParam("board_seq") int board_seq, @RequestParam("line_seq") int line_seq) {
    	logger.info("getBoardValue");
    	BoardVO vo = service.getBoardValue(line_seq, board_seq);
    	
    	return "BoardValue";
    }*/
    
    /*@RequestMapping("/test")
    public String test() {
    	return "test";
    }*/
    
  /*  @RequestMapping("/testGet")
    public String testGet(BoardVO vo) {
    	logger.info("testGet");
    	service.inputBoard(vo);
    	return "redirect:do.do";
    }
    
    @RequestMapping("/getTest")
    public String getTest() {
    	return "getTest";
    }*/
    
    @RequestMapping("/inputReply.do")
    public String inputReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	request.setCharacterEncoding("UTF-8");
    	response.setContentType("text/html;charset=UTF-8");
    	
    	
    	
    	return "home1";
    }
}
