package com.project.sns.search.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.sns.board.vo.BoardVO;
import com.project.sns.search.service.SearchService;
import com.project.sns.tour.vo.TourMapVO;
import com.project.sns.user.vo.UserVO;

@Controller
public class SearchController{
	private final Logger logger = LoggerFactory.getLogger(SearchController.class);
	
	@Autowired
	private SearchService service;
	
	@RequestMapping("/searchAll.do")
	public String SearchAll(@RequestParam("keyword") String keyword, @RequestParam("number") int number, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<UserVO> list = service.searchUser(keyword);
		request.setAttribute("list", list);
		HashMap<Integer, List> map = new HashMap<Integer, List>();
		PrintWriter out = response.getWriter();
		keyword = '%'+keyword+'%';
		List<UserVO> userList = service.searchUser(keyword);
		List<TourMapVO> tourMapList = service.searchMap(keyword);
		List<BoardVO> boardList = service.searchBoard(keyword);
		System.out.println("userListSize : " + userList.size());
		System.out.println("tourMapListSize : " + tourMapList.size());
		System.out.println("boardListSize : " + boardList.size());
		
		if(number == 1) {
			map.put(1, userList);
			map.put(2, tourMapList);
			map.put(3, boardList);
		} else if(number == 2) {
			map.put(1, tourMapList);
			map.put(2, userList);
			map.put(3, boardList);
		} else if(number == 3) {
			map.put(1, boardList);
			map.put(3, userList);
			map.put(2, tourMapList);			
		} else {
			out.println("<script>");
			out.println("alert('잘못된 동작입니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		request.setAttribute("map", map);		
		
		return "searchTest";
	}
}
