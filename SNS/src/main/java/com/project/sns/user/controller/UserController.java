package com.project.sns.user.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.sns.user.service.UserService;
import com.project.sns.addr.vo.AddrVO;
import com.project.sns.board.vo.BoardVO;
import com.project.sns.user.vo.UserVO;

@Controller
public class UserController {
	private final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/register.do")
	public String write(UserVO vo){
		logger.info("write");
		userService.insertUser(vo);
		return "writeForm";
	}
	
	@RequestMapping("/registerForm.do")
	public String writeForm(){
		return "register";
	}
	
	@RequestMapping("/Address.do")
	public String Address(HttpServletRequest req) throws Exception{
		List<AddrVO> list = userService.getAddress();
		System.out.println(list.get(1).getMapx());
		req.setAttribute("list", list);
		return "result";
	}
	
	

	@RequestMapping("/Map.do")
	public String Map(HttpServletRequest req) throws Exception{
		List<AddrVO> list = userService.getAddress();
		System.out.println(list.get(1).getMapx());
		req.setAttribute("list", list);
		return "mmm";
	}
	
	
	//login
	
    @RequestMapping("/writeForm.do")
    public String writeForm2(){
       return "login";
    }
    
    
    @RequestMapping("/login1.do")
    public String login(UserVO vo, HttpServletRequest request)
    {
       List<UserVO> list = userService.getUser(vo);
       UserVO user = list.get(0);
       System.out.println("idididi" + vo.getId());
       System.out.println("id : " + user.getId());
       if(user != null)
       {
          request.setAttribute("userId",user.getId() );
          request.setAttribute("userPassword",user.getPassword() );
          return "redirect:Map.do";
       }
       else return "login";
    }
    
    @RequestMapping("/homeview.do")
    public String home1(){
    	return "home1";
    }
 // =-=======================게시글 추가   
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
