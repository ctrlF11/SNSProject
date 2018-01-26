package com.project.sns.user.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.project.sns.user.service.UserService;
import com.project.sns.user.vo.UserVO;

import A.algorithm.AES;

@Controller
/*@SessionAttributes({"id", "name", "ip"})
*/public class UserController {
	private final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService service;
	
	@RequestMapping("/register.do")
	public String write(UserVO vo){
		logger.info("write");
		service.insertUser(vo);
		return "home1";
	}
	
	@RequestMapping("/registerForm.do")
	public String writeForm(){
		return "register";
	}	

    @RequestMapping("/writeForm.do")
    public String writeForm2(){
       return "login";
    }
    
    
    @RequestMapping("/login1.do")
    public String login(UserVO vo, HttpServletRequest request)
    {
       List<UserVO> list = service.getUserList(vo);
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
    
  
//    @RequestMapping("/getUser1.do")
//    public String getUser1(@RequestParam("index") int index, HttpServletRequest req) throws Exception{
//        logger.info("getBoardList");
//        System.out.println("index : " + index);
//        List<UserVO> user = service.getUser1(index);
//        req.setAttribute("user", user);
//        if(index == 0)
//          return "home1";
//        else 
//        	return "user";
//    }
    
    @RequestMapping("/login.do")
    public String login(){
    	return "login";
    }
    
    @RequestMapping("/loginCheck.do")
    public String loginCheck(UserVO vo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
    	request.setCharacterEncoding("UTF-8");
    	response.setContentType("text/html;charset=UTF-8");
    	UserVO checkVO = service.getUser(vo.getId());
    	System.out.println(vo.getId());
    	System.out.println(vo.getPassword());
    	PrintWriter out = response.getWriter();
    	if(checkVO == null) {
    		out.println("<script>");
    		out.println("alert('없는 아이디입니다.');");
    		out.println("</script>");
    		return "redirect:login.do";
    	}
    	if(vo.getPassword() == "" || checkVO.getPassword().equals(vo.getPassword())) {
    		out.println("<script>");
    		out.println("alert('비밀번호가 틀립니다.');");
    		out.println("</script>");
    		return "redirect:login.do";
    	} 
    	
    	String ip = getIP(request);
    	System.out.println("IP : " + ip);
    	out.println("<script>");
    	out.println("alert('뭐.');");
    	out.println("</script>");
    	
    	
    	AES aes = new AES();
    	aes.encrypt(checkVO.getId().trim());
    	System.out.println("original : " + checkVO.getId());
    	System.out.println("encrypted : " + aes.getEncryptedString());
    	
    	model.addAttribute("id", checkVO.getId());
    	model.addAttribute("name", checkVO.getName());
    	model.addAttribute("ip", ip);
    	
    	
    	return "main";
    }
    
    
    
    
    
    public static String getIP(HttpServletRequest request) {
    	String ip = request.getHeader("X-FORWARDED-FOR");
    	
    	// 프록시 검증
    	if(ip == null || ip.length() == 0) {
    		ip = request.getHeader("Proxy-Client-IP");
    	}
    	
    	// 웹 로직 서버인 경우
    	if(ip == null || ip.length() == 0) {
    		ip = request.getHeader("WL-Proxy-Client-IP");
    	}

    	// 최종적으로 IP 확인
    	if(ip == null || ip.length() == 0) {
    		ip = request.getRemoteAddr();
    	}
    	
    	return ip;
    }
    
    
}
