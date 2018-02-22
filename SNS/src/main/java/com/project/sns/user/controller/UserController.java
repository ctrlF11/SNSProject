package com.project.sns.user.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

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
import org.springframework.web.bind.annotation.SessionAttributes;

import com.project.sns.board.vo.BoardVO;
import com.project.sns.user.service.MailServiceImpl;
import com.project.sns.user.service.UserService;
import com.project.sns.user.vo.UserVO;

import A.algorithm.AES;

@Controller
/*@SessionAttributes({"id", "name", "ip"})
*/public class UserController {
	private final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService service;
	@Autowired
	private MailServiceImpl  serviceM;
	
	@RequestMapping("/register.do")
	public String write(UserVO vo){
		logger.info("write");
		service.insertUser(vo);
		return "redirect:login.do";
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
    
    @ResponseBody
    @RequestMapping("/checkId.do")
    private String getId(UserVO vo) {
        String memberId = vo.getId();
        System.out.println("받아온 아이디 : " + memberId);
           UserVO id = new UserVO();
           id.setId(memberId);   
           try {
        	  service.getId(id).getId();
        	  return "get";
		} catch (Exception e) {
			// TODO: handle exception
			return "no";
		}
           
     }
    
    @ResponseBody
    @RequestMapping("/check.do")
    private String sendMail(UserVO vo) {
          String memberId = vo.getId();
          int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
          String joinCode = String.valueOf(ran);
          System.out.println(joinCode);
          String subject = "회원가입 인증 코드 발급 안내 입니다.";
          StringBuilder sb = new StringBuilder();
          sb.append("귀하의 인증 코드는 " + joinCode + " 입니다.");
          serviceM.send(subject,sb.toString(), "mmwalsdnd123@gmail.com", memberId);
          return joinCode;
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
    
    @RequestMapping("/replyLogin.do")
    public String replyLogin() {
    	System.out.println("replyLogin");
    	return "redirect:login.do";
    }
    
    @RequestMapping("/login.do")
    public String login(){
    	System.out.println("login");
    	return "login";
    }
    

    
    @RequestMapping("/loginCheck.do")
    public String loginCheck(UserVO vo, HttpServletRequest request, HttpServletResponse response) throws Exception{
    	request.setCharacterEncoding("UTF-8");
    	response.setContentType("text/html;charset=UTF-8");
    	UserVO checkVO = service.getUser(vo.getId());
    	System.out.println(vo.getId());
    	System.out.println(vo.getPassword());
    	PrintWriter out = response.getWriter();
    	HttpSession session = request.getSession();
    	if(checkVO == null) {
    		System.out.println("checkVO = null");
    		out.println("<script>");
    		out.println("alert('�뾾�뒗 �븘�씠�뵒�엯�땲�떎.');");
    		out.println("</script>");
    		return "redirect:login.do";
    	}
    	if(vo.getPassword() == "" || !checkVO.getPassword().equals(vo.getPassword())) {
    		System.out.println(checkVO.getPassword().equals(vo.getPassword()));
    		System.out.println("vo.getPassword = '' | checkVO.getPassword().equals(vo.getPassword())");
    		out.println("<script>");
    		out.println("alert('鍮꾨�踰덊샇媛� ��由쎈땲�떎.');");
    		out.println("</script>");
    		return "redirect:login.do";
    	} 
    	
    	String ip = getIP(request);
    	System.out.println("IP : " + ip);
    	out.println("<script>");
    	out.println("alert('萸�.');");
    	out.println("</script>");
    	
    	
    	AES aes = new AES();
    	System.out.println("original : " + checkVO.getId());
    	checkVO.setId(aes.setCrypting(checkVO.getId()));
    	System.out.println("encrypted : " + checkVO.getId());
    	
    	session.setAttribute("id", checkVO.getId());
    	session.setAttribute("name", checkVO.getName());
    	session.setAttribute("ip", ip);
    	
    	
    	return "redirect:mainHomeView.do";
    }
    
    @RequestMapping("/logout.do")
    public String logout(HttpSession session) {
    	session.invalidate();
    	return "home1";
    }
    
    
    
    public static String getIP(HttpServletRequest request) {
    	String ip = request.getHeader("X-FORWARDED-FOR");
    	
    	// �봽濡앹떆 寃�利�
    	if(ip == null || ip.length() == 0) {
    		ip = request.getHeader("Proxy-Client-IP");
    	}
    	
    	// �쎒 濡쒖쭅 �꽌踰꾩씤 寃쎌슦
    	if(ip == null || ip.length() == 0) {
    		ip = request.getHeader("WL-Proxy-Client-IP");
    	}

    	// 理쒖쥌�쟻�쑝濡� IP �솗�씤
    	if(ip == null || ip.length() == 0) {
    		ip = request.getRemoteAddr();
    	}
    	
    	return ip;
    }
    
    
}
