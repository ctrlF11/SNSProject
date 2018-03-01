package com.project.sns.board.controller;

import java.lang.ProcessBuilder.Redirect;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.board.service.BoardService;
import com.project.sns.board.vo.BoardVO;
import com.project.sns.board.vo.ImageVO;
import com.project.sns.board.vo.ReplyVO;
import com.project.sns.board.vo.StoryVO;
import com.project.sns.board.vo.TIME_MAXIMUM;
import com.project.sns.chat.service.ChatService;
import com.project.sns.chat.vo.ChatVO;
import com.project.sns.user.service.UserService;
import com.project.sns.user.vo.UserVO;
import A.algorithm.AES;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {

	private final Logger logger = LoggerFactory.getLogger(BoardController.class);
	AES aes = new AES();

	@Autowired
	private BoardService service;
	@Autowired
	private UserService userService;
	@Autowired
	private ChatService cservice;

	/**
	 * Simply selects the home view to render by returning its name.
	 */

	@ResponseBody
	@RequestMapping("/getBoardStoryList.do")
	public List<BoardVO> getBoardStoryList(@RequestParam("boardUser") String boardUser, HttpServletRequest request,
			HttpSession se) throws Exception {

		BoardVO vo = new BoardVO();
		vo.setWriter(boardUser);
		System.out.println("�뒪�넗由� 媛� : " + vo.getWriter());
		return service.getBoardStoryList(vo);
	}

	@RequestMapping("/getMainBoardList.do") // �뜝�룞�삕�뜝�룞�삕�솕�뜝�룞�삕 �뜝�룦�룞源띿삕 �뜝�뙗�뼲�삕
	public String getMainBoardList(@RequestParam("index") int index, HttpServletRequest request) throws Exception {
		TIME_MAXIMUM time = new TIME_MAXIMUM();
		logger.info("getMainBoardList");
		System.out.println("index : " + index);
		List<BoardVO> mainTable = service.getMainBoardList(index);
		ArrayList<String> mainTime = new <String>ArrayList();
		for (int i = 0; i < mainTable.size(); i++) {
			mainTime.add(time.calculateTime(mainTable.get(i).getRegdate()));
		}
		request.setAttribute("mainTime", mainTime);
		request.setAttribute("mainTable", mainTable);
		return "mainTable";
	}

	// @RequestMapping("insertReply.do")
	// String insertReply(ReplyVO vo,Model model){
	// service.insertReply(vo);
	// model.addAttribute("reply",service.getBoardReply(vo.getBoard_seq()));
	// return "replylist";
	// }

	@RequestMapping("/homeview.do")
	public String home1(@RequestParam("story_seq") int story_seq, HttpServletRequest request, HttpSession se) {

		String id = (String) se.getAttribute("id");
		if (null == id) {
			return "redirect:login.do";
		} else {
			id = aes.setDecrypting(id);
			request.setAttribute("story_seq", story_seq);
			return "home1";
		}

	}// 占쎈쐻占쎈셾占쎈뻻繹먮씮�굲

	@RequestMapping("/modifyBoard")
	public String writeForm(Model model, HttpServletRequest request, HttpServletResponse res) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		id = AES.setDecrypting(id);
		List<StoryVO> story = service.getStory(id);
		if (story != null) {
			model.addAttribute("story", story);
		}
		return "modifyBoard";
	}

	@ResponseBody
	@RequestMapping("/inputStory")
	public int inputStory(StoryVO vo) {
		vo.setId(AES.setDecrypting(vo.getId()));
		service.inputStory(vo);
		int nr = vo.getStory_seq();
		return nr;
	}

	@RequestMapping("/mainHomeView.do")
	public String mainHome(HttpServletRequest request) throws SQLException {
		return "mainHome";
	}

	@RequestMapping("/killSession.do")
	public String killSession(HttpServletRequest request) throws SQLException {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:mainHomeView.do";
	}

	@RequestMapping("/message")
	public String message(HttpServletRequest request, HttpSession session) {
		String id = (String) session.getAttribute("id");
		AES aes = new AES();
		id = aes.setDecrypting(id);

		List<ChatVO> resultList = new ArrayList<ChatVO>();
		List<ChatVO> list = cservice.getFollowerList(id);
		List<String> namecheck = new ArrayList<String>();
		UserVO myvo = cservice.getUser(id);
		if (list != null) {
			for (ChatVO vo : list) {
				String name = "";
				UserVO uvo = null;
				if (vo.getToID() == id) {
					name = vo.getFromID();
				} else {
					name = vo.getToID();
				}
				System.out.println(resultList.indexOf(name));
				if (namecheck.indexOf(name) == -1) {
					namecheck.add(name);
					uvo = cservice.getUser(name);
					vo.setName(uvo.getName());
					vo.setPicture(uvo.getProfile_img());
					resultList.add(vo);
				}
			}
		}
		//�뙏濡쒖썙 紐⑥쓬
		List<UserVO> followerlist = userService.getFollower(id);
		request.setAttribute("myInfo", myvo);
		request.setAttribute("chatList", resultList);
		request.setAttribute("follower", followerlist);
		
		return "chat";
	}

	@RequestMapping("/deleteBoard")
	public void deleteBoard(BoardVO vo) {
		service.deleteBoard(vo);
	}

	@RequestMapping("/saveImage")
	public void saveImage(ImageVO vo) throws SQLException {
		service.saveImage(vo);
	}

	/*
	 * @RequestMapping("/getUser1.do") public String getUser1(@RequestParam("index")
	 * int index, HttpServletRequest request) throws Exception{
	 * logger.info("getBoardList"); System.out.println("index : " + index);
	 * List<UserVO> user = userService.getUser1(index); request.setAttribute("user",
	 * user); if(index == 0) return "home1"; else return "user"; }
	 */

	@RequestMapping("/inputReply.do")
	public String inputReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		return "home1";
	}

	@RequestMapping("/list.do") // �뙎湲� 由ъ뒪�듃
	@ResponseBody
	private List<ReplyVO> replyList(Model model, ReplyVO vo) throws Exception {
		logger.info("list.do");
		return service.replyList(vo);
	}

	@RequestMapping("/insert.do") // �뙎湲� �옉�꽦
	@ResponseBody
	private int replyInsert(@RequestParam int board_seq, @RequestParam int story_seq, @RequestParam String rcontent,
			HttpSession se) throws Exception {
		String id = (String) se.getAttribute("id");
		id = aes.setDecrypting(id);

		logger.info("insert.do");

		ReplyVO reply = new ReplyVO();
		reply.setBoard_seq(board_seq);
		reply.setRcontent(rcontent);
		reply.setStory_seq(story_seq);
		;
		System.out.println("insert.do : " + rcontent + " : " + board_seq);
		// 濡쒓렇�씤 湲곕뒫�쓣 援ы쁽�뻽嫄곕굹 �뵲濡� �뙎湲� �옉�꽦�옄瑜� �엯�젰諛쏅뒗 �뤌�씠 �엳�떎硫� �엯�젰 諛쏆븘�삩 媛믪쑝濡� �궗�슜�븯硫� �맗�땲�떎. ���뒗 �뵲濡� �뤌�쓣 援ы쁽�븯吏�
		// �븡�븯湲곕븣臾몄뿉 �엫�떆濡� "test"�씪�뒗 媛믪쓣 �엯�젰�빐�넧�뒿�땲�떎.
		reply.setRwriter(id);
		return service.replyInsert(reply);
	}

	@ResponseBody
	@RequestMapping("/update.do") // �뙎湲� �닔�젙
	private int mCommentServiceUpdateProc(ReplyVO reply) throws Exception {
		logger.info("update.do");
		return service.replyUpdate(reply);
	}

	@ResponseBody
	@RequestMapping("/delete.do") // �뙎湲� �궘�젣
	private int mCommentServiceDelete(ReplyVO reply) throws Exception {
		logger.info("delete.do");
		return service.replyDelete(reply);
	}

	/**
	 * Simply selects the home view to render by returning its name.
	 */

	   @RequestMapping("/getBoardList.do")
	   public String getBoardList(@RequestParam("index") int index, @RequestParam("story_seq") int story_seq,
	         HttpServletRequest request) throws Exception {
	      logger.info("getBoardList");
	      System.out.println("index : " + index + " story-seq : " + story_seq);
	      HashMap map = new HashMap();
	      map.put("index", index);
	      map.put("story_seq", story_seq);
	      List<BoardVO> user = service.getBoardList(map);
	      TIME_MAXIMUM time = new TIME_MAXIMUM();
	      ArrayList<String> timeS = new <String>ArrayList();
	      for (int i = 0; i < user.size(); i++) {
	         timeS.add(time.calculateTime(user.get(i).getRegdate()));
	      }
	      
	      for (int i = 0; i < timeS.size(); i++) {
	         System.out.println(timeS.get(i));
	      }
	      map.clear();
	      HttpSession session = request.getSession();
	      String id = (String) session.getAttribute("id");
	      id = AES.setDecrypting(id).trim();
	      map.put("id", id);
	      map.put("writer", user.get(0).getWriter());
	      
	      System.out.println("map id : " + map.get("id"));
	      
	      int f_result = userService.getFollow(map);
	      	
	      request.setAttribute("f_result", f_result);
	      request.setAttribute("user", user);
	      request.setAttribute("time",timeS);
	      /*
	       * if(index == 0) return "home1"; else
	       */
	      HttpSession se = request.getSession();
	      se.setAttribute("userH", user);
	      return "table";
	   }

	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping("/getBoardStoryList.do") public List<BoardVO>
	 * getBoardStoryList(HttpServletRequest request, HttpSession se) throws
	 * Exception {
	 * 
	 * String id = (String) se.getAttribute("id"); System.out.println("�븘�씠�뵒 : " +
	 * id); id = aes.setDecrypting(id); System.out.println("蹂듯샇�솕�븳 �븘�씠�뵒 : " + id);
	 * BoardVO vo = new BoardVO(); vo.setWriter(id); System.out.println("�뒪�넗由� 媛� : " +
	 * vo.getWriter()); return service.getBoardStoryList(vo); }
	 */

	// @RequestMapping("insertReply.do")
	// String insertReply(ReplyVO vo,Model model){
	// service.insertReply(vo);
	// model.addAttribute("reply",service.getBoardReply(vo.getBoard_seq()));
	// return "replylist";
	// }

	@ResponseBody
	@RequestMapping("/getStoryCount.do")
	public int getStoryCount(@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("getStoryCount");
		id = AES.setDecrypting(id);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;chatset=UTF-8");
		System.out.println("getStoryCount.do : id : " + id);
		int count = service.getStoryCount(id);
		System.out.println("count : " + count);
		return count;
	}

	@ResponseBody
	@RequestMapping("/inputBoard")
	public void inputBoard(BoardVO vo) throws Exception {
		System.out.println("BoardVO.getFiles() : " + vo.getFiles());
		System.out.println("BoardVO.getTitle() : " + vo.getTitle());
		vo.setWriter(AES.setDecrypting(vo.getWriter()));
		// �뜝�뙃�떆源띿삕 �뜝�룞�삕�뜝�룞�삕�솗�뜝�룞�삕
		int i = service.getBoardSeq(vo);
		int k = 100;
		if (i == 0) {
			service.regist(vo);
		} else
			service.registup(vo);
	}

	/*
	 * @RequestMapping("/insert.do") // �뙎湲� �옉�꽦
	 * 
	 * @ResponseBody private int replyInsert(@RequestParam int
	 * board_seq, @RequestParam int story_seq, @RequestParam String rcontent) throws
	 * Exception {
	 * 
	 * ReplyVO reply = new ReplyVO(); reply.setBoard_seq(board_seq);
	 * reply.setRcontent(rcontent); reply.setStory_seq(story_seq); ;
	 * System.out.println("insert.do : " + rcontent + " : " + board_seq); // 濡쒓렇�씤 湲곕뒫�쓣
	 * 援ы쁽�뻽嫄곕굹 �뵲濡� �뙎湲� �옉�꽦�옄瑜� �엯�젰諛쏅뒗 �뤌�씠 �엳�떎硫� �엯�젰 諛쏆븘�삩 媛믪쑝濡� �궗�슜�븯硫� �맗�땲�떎. ���뒗 �뵲濡� �뤌�쓣 援ы쁽�븯吏� // �븡�븯湲곕븣臾몄뿉 �엫�떆濡�
	 * "test"�씪�뒗 媛믪쓣 �엯�젰�빐�넧�뒿�땲�떎. reply.setRwriter("test"); return
	 * service.replyInsert(reply); }
	 */

	// 2018/02/05 in : story.do, getStoryList.do
	@RequestMapping("/story.do")
	public String story() {
		return "story";
	}

	@RequestMapping("/getStoryList.do")
	public String getStoryList(@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("getStoryList.do");
		request.setCharacterEncoding("UTF-8");
		System.out.println("�븘�씠�뵒 : " + id);
		id = AES.setDecrypting(id);
		System.out.println("蹂듯샇�솕�븳 �븘�씠�뵒 : " + id);

		List<StoryVO> list = service.getStoryAll(id);
		request.setAttribute("list", list);
		return "table2";
	}

	@RequestMapping("/getFollowerStoryList.do")
	public String getFollowerStoryList(@RequestParam("index") int index, @RequestParam("id") String id,
			HttpServletRequest request, HttpServletResponse res) {
		id = AES.setDecrypting(id);
		logger.info("getMainBoardList");
		System.out.println("index : " + index);
		int index2 = index + 6;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("index", index);
		map.put("index2", index2);
		List<BoardVO> storyList = service.getFollowerStoryList(map);
		request.setAttribute("storyList", storyList);
		return "table3";
	}

<<<<<<< HEAD
=======
	@RequestMapping("/likeUp.do") // �뙎湲� �옉�꽦
>>>>>>> branch 'kimit' of https://github.com/ctrlF11/SNSProject
	@ResponseBody
	@RequestMapping("/likeUp.do") // 좋아요
	private String likeUp(@RequestParam int board_seq, @RequestParam int story_seq, HttpSession session) throws Exception {
		logger.info("likeUp.do");

		int heart = 0;
		BoardVO vo = new BoardVO();
		String id = (String)session.getAttribute("id");
		id = aes.setDecrypting(id);
		HashMap map = new HashMap();
		map.put("heartId", id);
		map.put("story_seq", story_seq);
		map.put("hboard_seq", board_seq);
		
		int h_result = service.getHeart(map);
		
		System.out.println("좋아요 있냐 없냐 : " + h_result);
		
		vo.setBoard_seq(board_seq);
		vo.setStory_seq(story_seq);
		vo.setHeart_id(id);
		if(h_result == 0) {
			vo.setHeart(service.getHeartCount(vo) + 1);
			heart = vo.getHeart();
			service.likeInsert(vo);
<<<<<<< HEAD
			service.likeUp(vo);// 좋아요 +1 업데이트
			System.out.println("좋아요 수 :" + heart);
			return Integer.toString(heart);
		} else if(h_result == 1) {
			vo.setHeart(service.getHeartCount(vo) - 1);
			heart = vo.getHeart();
			service.likeUp(vo);
=======
			vo.setHeart(service.getBoard(vo).get(0).getHeart());// 醫뗭븘�슂 +1
			service.likeUp(vo);// 醫뗭븘�슂 +1 �뾽�뜲�씠�듃
			heart = service.getBoard(vo).get(0).getHeart();// +1 �맂 醫뗭븘�슂 諛섑솚
			System.out.println("醫뗭븘�슂 �닔 :" + heart);
			return heart;

		} catch (Exception e) {

			vo.setBoard_seq(board_seq);
			vo.setStory_seq(story_seq);
			vo.setHeart_id(id);
			heart = service.getBoard(vo).get(0).getHeart();
			heart = heart - 2;
>>>>>>> branch 'kimit' of https://github.com/ctrlF11/SNSProject
			service.likeDelete(vo);
			return Integer.toString(heart);
		}
	
		return "에러. 문의해 주세요.";
	}

	@RequestMapping("/webStart.do")
	public String webStart(HttpServletRequest request) throws SQLException {
		return "web";
	}

	@RequestMapping("/modifyStory.do")
	public String modifyStory(@RequestParam("story_seq") int story_seq) {
		return "modifyStory";
	}

	@RequestMapping("/deleteStory.do")
	public String deleteStory(@RequestParam("story_seq") int story_seq, HttpSession session) {
		StoryVO vo = new StoryVO();
		String id = (String)session.getAttribute("id");
		id = AES.setDecrypting(id);
		vo.setId(id);
		vo.setStory_seq(story_seq);
		service.deleteBoardByStory(vo);
		service.deleteStory(vo);
		return "redirect:myPage.do";
	}
	
	
}
