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
	
	@RequestMapping("/register.do")
	public String write(UserVO vo){
		userService.insertUser(vo);
		return "writeForm";
	}
	
	@RequestMapping("/registerForm.do")
	public String writeForm(){
		return "register";
	}
	
}
