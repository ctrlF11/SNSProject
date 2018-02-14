package com.project.sns.board.controller;
 
import java.lang.ProcessBuilder.Redirect;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.sns.board.service.BoardService;
import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ImageVO;
import com.project.sns.board.vo.ReplyVO;
import com.project.sns.board.vo.StoryVO;
import com.project.sns.board.vo.TIME_MAXIMUM;
import com.project.sns.user.service.UserService;

import A.algorithm.AES;
 
/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
    
    private final Logger logger = LoggerFactory.getLogger(BoardController.class);
    AES aes = new AES();
    
	@Autowired
    private BoardService service;
    private UserService  userService;
    /**
     * Simply selects the home view to render by returning its name.
     */
    @RequestMapping("/getBoardList.do")
    public String getBoardList(@RequestParam("index") int index,@RequestParam("story_seq") int stroy_seq, HttpServletRequest req,HttpSession se) throws Exception{
    	    logger.info("getBoardList");
            System.out.println("index : " + index +" story-seq : " + stroy_seq);
            HashMap map = new HashMap();
            map.put("index", index);
            map.put("story_seq", stroy_seq);
            List<BoardVO> user = service.getBoardList(map);
            req.setAttribute("user", user);
            /*if(index == 0)
              return "home1";
            else*/ 
            //se.setAttribute("userH", user);
            return "table";
      
      

    }
    
 @ResponseBody
 @RequestMapping("/getBoardStoryList.do")
    public List<BoardVO> getBoardStoryList(@RequestParam("boardUser") String boardUser,HttpServletRequest req,HttpSession se) throws Exception{
	 	 
	     BoardVO vo = new BoardVO();
	     vo.setWriter(boardUser);
	     System.out.println("스토리 값 : "+ vo.getWriter());
	     return service.getBoardStoryList(vo);
    }
 	
    @RequestMapping("/getMainBoardList.do")  // 占쏙옙占쏙옙화占쏙옙 占쏟동깍옙 占쌜억옙
    public String getMainBoardList(@RequestParam("index") int index, HttpServletRequest req) throws Exception{
    	TIME_MAXIMUM time = new  TIME_MAXIMUM();
        logger.info("getMainBoardList");
        System.out.println("index : " + index);
        List<BoardVO> mainTable = service.getMainBoardList(index);
        ArrayList<String> mainTime = new <String>ArrayList();
        for(int i = 0; i < mainTable.size(); i++)
        {
        	mainTime.add(time.calculateTime( mainTable.get(i).getRegdate()) );
        }
        req.setAttribute("mainTime", mainTime);
        req.setAttribute("mainTable", mainTable);
        return "mainTable";
    }
       
//    @RequestMapping("insertReply.do")
//    String insertReply(ReplyVO vo,Model model){ 
//    	service.insertReply(vo);
//    	model.addAttribute("reply",service.getBoardReply(vo.getBoard_seq()));
//       return "replylist";
//    }
    
    @RequestMapping("/homeview.do")
    public String home1(@RequestParam("story_seq") int story_seq,HttpServletRequest req,HttpSession se){
     
	 	 String id = (String)se.getAttribute("id");
	     if(null == id)
	     {
	    	 return "redirect:login.do";
	     }
	     else
	     {
		     id = aes.setDecrypting(id);
	    	 req.setAttribute("story_seq", story_seq);
	    	 return "home1";
	     }
        
    }//�뜝�뙃�떆源띿삕
    
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
    	//占쌉시깍옙 占쏙옙占쏙옙확占쏙옙
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
    
    
    
    @RequestMapping("/list.do") //댓글 리스트
    @ResponseBody
    private List<ReplyVO> replyList(Model model,ReplyVO vo) throws Exception{
    	logger.info("list.do");
        return service.replyList(vo);
    }
    @RequestMapping("/insert.do") //댓글 작성 
    @ResponseBody
    private int replyInsert(@RequestParam int board_seq,@RequestParam int story_seq, @RequestParam String rcontent,HttpSession se) throws Exception{
	 	 String id = (String)se.getAttribute("id");
         id = aes.setDecrypting(id);

	     
    	logger.info("insert.do");
    	
        ReplyVO reply = new ReplyVO();
        reply.setBoard_seq(board_seq);
        reply.setRcontent(rcontent);
        reply.setStory_seq(story_seq);;
        System.out.println("insert.do : " + rcontent + " : " + board_seq);
        //로그인 기능을 구현했거나 따로 댓글 작성자를 입력받는 폼이 있다면 입력 받아온 값으로 사용하면 됩니다. 저는 따로 폼을 구현하지 않았기때문에 임시로 "test"라는 값을 입력해놨습니다.
        reply.setRwriter(id);  
        return service.replyInsert(reply);
    }
    
    @RequestMapping("/update.do") //댓글 수정  
    @ResponseBody
    private int mCommentServiceUpdateProc(ReplyVO reply) throws Exception{
    	logger.info("update.do");
        return service.replyUpdate(reply);
    }
    
    @RequestMapping("/delete.do") //댓글 삭제  
    @ResponseBody
    private int mCommentServiceDelete(ReplyVO reply) throws Exception{
    	logger.info("delete.do");
        return service.replyDelete(reply);
    }


}
