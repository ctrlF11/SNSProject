package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.service.UserService;
import com.project.vo.UserVO;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	
	@RequestMapping("/write.do")
	public String write(UserVO vo){
		userService.insertArticle(vo);
		return "index.html";
	}
	
	@RequestMapping("/writeForm.do")
	public String writeForm(){
		return "writeForm";
	}
	
}
