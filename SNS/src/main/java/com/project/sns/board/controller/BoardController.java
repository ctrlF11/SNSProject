package com.project.sns.board.controller;
 
import java.util.List;
import java.util.Locale;
 
import javax.inject.Inject;
 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.sns.board.service.BoardService;
import com.project.sns.board.vo.BoardVO;
 
/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
    
    private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
    
    @Inject
    private BoardService service;
    
    /**
     * Simply selects the home view to render by returning its name.
     */
    @RequestMapping("/getBoardList.do")
    public String getBoardList(Locale locale, Model model) throws Exception{
 
        logger.info("getBoardList");
        
        List<BoardVO> boardList = service.getBoardList();
        
        model.addAttribute("boardList", boardList);
 
        return "BoardList";
    }
    
    @RequestMapping("/getBoardValue.do")
    public String getBoardValue(int board_seq) {
    	logger.info("getBoardValue");
    	BoardVO vo = service.getBoardValue(board_seq);
    	
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
}
