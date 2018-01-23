package com.project.sns.board.controller;
 
import java.util.List;
import java.util.Locale;
 
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.board.service.BoardService;
import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ReplyVO;
import com.project.sns.user.service.UserService;
import com.project.sns.user.vo.UserVO;
 
/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
    
    private final Logger logger = LoggerFactory.getLogger(BoardController.class);
    
    
	@Autowired
    private BoardService service;
    private UserService  userService;
    /**
     * Simply selects the home view to render by returning its name.
     */
//    @RequestMapping("/getBoardList.do")
//    public String getBoardList(@RequestParam("line_seq") int line_seq, Model model) throws Exception{
// 
//        logger.info("getBoardList");
//        
//        List<BoardVO> boardList = service.getBoardList(line_seq);
//        
//        model.addAttribute("boardList", boardList);
// 
//        return "BoardList";
//    }
    
//    @RequestMapping("/getBoardList2.do")
//    public String getBoardList2(@RequestParam("line_seq") int line_seq, Model model) throws Exception{
//    	
//    	logger.info("getBoardList2");
//    	
//    	List<BoardVO> boardList = service.getBoardList(line_seq);
//    	System.out.println(boardList.get(0).getLine_seq());
//    	model.addAttribute("boardList", boardList);
//    	
//    	return "BoardList2";
//    }
    
    
    @RequestMapping("/getBoardList.do")
    public String getBoardList(@RequestParam("index") int index, HttpServletRequest req) throws Exception{
        logger.info("getBoardList");
        System.out.println("index : " + index);
        List<BoardVO> user = service.getBoardList(index);
        req.setAttribute("user", user);
        if(index == 0)
          return "home1";
        else 
        	return "table";
    }
    
    @RequestMapping("/getBoardValue.do")
    public String getBoardValue(@RequestParam("board_seq") int board_seq, @RequestParam("line_seq") int line_seq) {
    	logger.info("getBoardValue");
    	BoardVO vo = service.getBoardValue(line_seq, board_seq);
    	
    	return "BoardValue";
    }
    
    @RequestMapping("/test")
    public String test() {
    	return "test";
    }
    
    @RequestMapping("/testGet")
    public String testGet(BoardVO vo) {
    	logger.info("testGet");
    	service.inputBoard(vo);
    	return "redirect:do.do";
    }
    
    @RequestMapping("/getTest")
    public String getTest() {
    	return "getTest";
    }
    
    
    @RequestMapping("insertReply.do")
    String insertReply(ReplyVO vo,Model model){ 
    	service.insertReply(vo);
    	model.addAttribute("reply",service.getBoardReply(vo.getBoard_seq()));
       return "replylist";
    }
    
    
    @RequestMapping("/homeview.do")
    public String home1(){
    	return "home1";
    }//°Ô½Ã±Û
    
    @RequestMapping("/getUser1.do")
    public String getUser1(@RequestParam("index") int index, HttpServletRequest req) throws Exception{
        logger.info("getBoardList");
        System.out.println("index : " + index);
        List<UserVO> user = userService.getUser1(index);
        req.setAttribute("user", user);
        if(index == 0)
          return "home1";
        else 
        	return "user";
    }
    
}
