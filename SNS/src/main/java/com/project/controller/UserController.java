package com.project.controller;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.cxf.helpers.IOUtils;
import org.apache.cxf.io.CachedOutputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.project.service.UserService;
import com.project.vo.AddrVO;
import com.project.vo.UserVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
public class UserController {

   private static final Logger logger = LoggerFactory.getLogger(UserController.class);
   
   @Autowired
   private UserService userService;
   
   @RequestMapping("/register.do")
   public String write(UserVO vo){
      logger.info("write");
      userService.insertUser(vo);
      return "home";
   }
   
   @RequestMapping("/registerForm.do")
   public String writeForm(){
      return "register";
   }
   
   @RequestMapping("/PublicData.do")
   public void PublicData(HttpServletRequest request, HttpServletResponse response) throws IOException{
            
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?ServiceKey=";
        String serviceKey = "BplkfbrGDFjXCIwsZB7NvAN9%2B729jsK7%2Bklaa4%2BJbOIVt90ql8rlPJXEjxRKklXhym6ldsKyjFGgPYvT023Yjw%3D%3D";
        String parameter = "";
        //serviceKey = URLEncoder.encode(serviceKey,"utf-8");
        PrintWriter out = response.getWriter();
        parameter = parameter + "&" + "areaCode=1";
        parameter = parameter + "&" + "eventStartDate=20160101";
        parameter = parameter + "&" + "eventEndDate=20161231";
        parameter = parameter + "&" + "pageNo=1&numOfRows=10";
        parameter = parameter + "&" + "MobileOS=ETC";
        parameter = parameter + "&" + "MobileApp=aa";
        parameter = parameter + "&" + "_type=json";
         
         
        addr = addr + serviceKey + parameter;
        URL url = new URL(addr);
         
        InputStream in = url.openStream(); 
        CachedOutputStream bos = new CachedOutputStream();
        IOUtils.copy(in, bos);
        in.close();
        bos.close();
         
        out.println(addr);
         
        String data = bos.getOut().toString();      
        out.println(data);
         
        JSONObject json = new JSONObject();
        json.put("data", data);
        
       }


@RequestMapping("/public")
public String publicData(HttpServletRequest request, HttpServletResponse response) throws Exception{
   request.setCharacterEncoding("utf-8");
   response.setContentType("text/html; charset=utf-8");
   
   String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?ServiceKey=";
   String serviceKey = "429e9l%2BRPBvvMYSqI0TIu0JgvFl1vio2dcUfXj7d66%2F%2B2glco1EDs1HDHJBssw9U7HAt1A11Cy6N0Hbk2INDfQ%3D%3D";
   String parameter = "";
//   serviceKey = URLEncoder.encode(serviceKey,"utf-8");

   PrintWriter out = response.getWriter();
//   PrintWriter out = new PrintWriter(new OutputStream Writer(response.getOutputStream(),"KSC5601"));
//   ServletOutputStream out = response.getOutputStream();
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
   
//   BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));

   InputStream in = url.openStream(); 
//   CachedOutputStream bos = new CachedOutputStream();
   ByteArrayOutputStream  bos1 = new ByteArrayOutputStream();
   IOUtils.copy(in, bos1);
   in.close();
   bos1.close();
    
   String mbos = bos1.toString("UTF-8");
   System.out.println("mbos: "+mbos);
    
   byte[] b = mbos.getBytes("UTF-8");
   String s = new String(b, "UTF-8");
   out.println(s);
   System.out.println("s: " + s);
   
   JSONObject json = new JSONObject();
   json.put("data", s);
//   json.put("data", data);
   System.out.println("json: "+json);
   
   
   JSONObject jso = json.getJSONObject("data");
   JSONObject js = jso.getJSONObject("response");
   JSONObject jj = js.getJSONObject("body");
   JSONObject items = jj.getJSONObject("items"); 
  
   JSONArray jArray =  items.getJSONArray("item");
   
   
//   ArrayList<ChatVO> array = new ArrayList<>();
//   for(int i = 0; i < 10; i++) {
//      JSONObject a = jArray.getJSONObject(i);
//   
//      System.out.println(a.get("addr1"));
//      System.out.println(a.get("title"));
//      System.out.println(a.get("mapx"));
//      System.out.println(a.get("mapy"));
//   }
   
   return "publicData";
}

	@RequestMapping("/list")
	public String list(HttpServletRequest request)
	{
		logger.info("list");
		
		System.out.println(userService.list().get(1).getMapX());
		request.setAttribute("list",userService.list());
		return "publicData";
	}

} 