package com.project.sns.user.controller;

import java.io.PrintWriter;
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
import org.springframework.web.bind.annotation.SessionAttributes;

import com.project.sns.board.service.BoardService;
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
	private BoardService boardService;
	
	@RequestMapping("/register.do")
	public String write(UserVO vo){
		logger.info("write");
		service.insertUser(vo);
		return "redirect:mainHomeView.do";
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
    	checkVO.setId(aes.setCrypting(checkVO.getId()).trim());
    	System.out.println("encrypted : " + checkVO.getId());
    	
    	session.setAttribute("id", checkVO.getId());
    	session.setAttribute("name", checkVO.getName());
    	session.setAttribute("ip", ip);
    	
    	
    	return "redirect:mainHomeView.do";
    }
    
    @RequestMapping("/logout.do")
    public String logout(HttpSession session) {
    	session.invalidate();
    	return "redirect:mainHomeView.do";
    }
    
    @RequestMapping("/myPage.do")
    public String myPage(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	request.setCharacterEncoding("UTF-8");
    	response.setContentType("text/html;chatset=UTF-8");
    	HttpSession session = request.getSession();
    	String id = (String)session.getAttribute("id");
    	System.out.println("아이디 : " + id);
    	if(id == null || id == "") {
    		return "redirect:login.do";
    	}
	     id = AES.setDecrypting(id);
	     System.out.println("복호화한 아이디 : " + id);
    	String img = service.getUserImage(id);
    	
    	request.setAttribute("img", img);

		int storyCount = boardService.getStoryCount(id);
		int followingCount = service.getFollowingCount(id);
		int followerCount = service.getFollowerCount(id);
		
		request.setAttribute("storyCount", storyCount);
		request.setAttribute("followingCount", followingCount);
		request.setAttribute("followerCount", followerCount);
    	return "myPage";
    }
    
    @RequestMapping("/followByBoard.do")
    public String followByBoard(@RequestParam("id") String id, @RequestParam("writer") String writer,
    		HttpServletRequest req, HttpServletResponse res) {
    	id = AES.setDecrypting(id);
    	HashMap<String, String> ids = new HashMap();
    	System.out.println("fBB id : " + id);
    	System.out.println("fBB writer : " + writer);
    	ids.put("id", id);
    	ids.put("writer", writer);
    	service.followByBoard(ids);
    	String uri = req.getHeader("Referer").substring(26);
    	return "redirect:"+uri;
    }
    
    @ResponseBody
    @RequestMapping("/followByPage.do")
    public int followByPage(@RequestParam("id") String id, @RequestParam("f_id") String f_id,
    		HttpServletRequest req, HttpServletResponse res) {
    	id = AES.setDecrypting(id);
    	HashMap<String, String> ids = new HashMap();
    	ids.put("id", id);
    	ids.put("f_id", f_id);
    	int result = service.followByPage(ids);
    	return result;
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
