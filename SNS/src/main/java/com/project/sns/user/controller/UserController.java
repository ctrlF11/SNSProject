package com.project.sns.user.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.sns.user.service.UserService;
import com.project.sns.addr.vo.AddrVO;
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
	
}
