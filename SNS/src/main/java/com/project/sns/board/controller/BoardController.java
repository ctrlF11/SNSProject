package com.project.sns.board.controller;
 
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;
import java.util.Locale;
 
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.cxf.helpers.IOUtils;
import org.json.simple.JSONObject;
import org.omg.CORBA.portable.InputStream;
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
    @RequestMapping("/do")
    public String home(Locale locale, Model model) throws Exception{
 
        logger.info("home");
        
        List<BoardVO> boardList = service.getBoardList();
        
        model.addAttribute("boardList", boardList);
 
        return "home";
    }
    
    @RequestMapping("/test")
    public String test() {
    	return "test";
    }
    
    @RequestMapping("/testGet")
    public String testGet(BoardVO vo) {
    	logger.info("testGet");
    	vo.setTitle(vo.getTitle());
    	service.inputBoard(vo);
    	return "redirect:do.do";
    }
    
    @RequestMapping("/tourget.do")
    public void testGet(HttpServletResponse response) throws IOException 
    {
    	String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?ServiceKey=";
		String serviceKey = "429e9l%2BRPBvvMYSqI0TIu0JgvFl1vio2dcUfXj7d66%2F%2B2glco1EDs1HDHJBssw9U7HAt1A11Cy6N0Hbk2INDfQ%3D%3D";
		String parameter = "";
//		serviceKey = URLEncoder.encode(serviceKey,"utf-8");
		PrintWriter out = response.getWriter();
		parameter = parameter + "&" + "areaCode=1";
		parameter = parameter + "&" + "eventStartDate=20171201";
		parameter = parameter + "&" + "eventEndDate=20171231";
		parameter = parameter + "&" + "pageNo=1&numOfRows=10";
		parameter = parameter + "&" + "MobileOS=ETC";
		parameter = parameter + "&" + "MobileApp=aa";
		parameter = parameter + "&" + "_type=json";
		
		
		addr = addr + serviceKey + parameter;
		URL url = new URL(addr);

		System.out.println(addr);
		
//		BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

		java.io.InputStream in = url.openStream(); 
//		CachedOutputStream bos = new CachedOutputStream();
		ByteArrayOutputStream  bos1 = new ByteArrayOutputStream();
		IOUtils.copy(in, bos1);
		in.close();
		bos1.close();
	    
		String mbos = bos1.toString("UTF-8");
		System.out.println("mbos: "+mbos);
	    
		byte[] b = mbos.getBytes("UTF-8");
		String s = new String(b, "UTF-8");
		out.println(s);
		
		JSONObject json = new JSONObject();
		json.put("data", s);
//		json.put("data", data);
		System.out.println("json: "+json);
		
    }
}
