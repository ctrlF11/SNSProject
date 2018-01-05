package com.project.sns.chat.controller;

import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.cxf.helpers.IOUtils;
import org.apache.cxf.io.CachedOutputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.sns.board.service.BoardService;
import com.project.sns.board.vo.BoardVO;
import com.project.sns.chat.service.ChatService;
import com.project.sns.chat.vo.ChatVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/chat")
public class ChatController {

	@Autowired
	private ChatService service;

	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ChatVO vo) {
		ResponseEntity<String> entity = null;
		try {
			System.out.println(vo.getFromID());
			System.out.println(vo.getChatContent());
			service.submit(vo);

			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public ResponseEntity<List<ChatVO>> getList(@RequestBody ChatVO vo) {
		ResponseEntity<List<ChatVO>> entity = null;
		try {
			System.out.println(vo.getFromID());
			System.out.println(vo.getToID());
			System.out.println(vo.getChatID());
			System.out.println(entity);
			entity = new ResponseEntity<>(service.getChatListById(vo), HttpStatus.OK);
			service.readChat(vo);

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	@RequestMapping("/public")
	public String publicData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=";
		String serviceKey = "429e9l%2BRPBvvMYSqI0TIu0JgvFl1vio2dcUfXj7d66%2F%2B2glco1EDs1HDHJBssw9U7HAt1A11Cy6N0Hbk2INDfQ%3D%3D";
		String parameter = "";
		// serviceKey = URLEncoder.encode(serviceKey,"utf-8");

		PrintWriter out = response.getWriter();
		// PrintWriter out = new PrintWriter(new OutputStream
		// Writer(response.getOutputStream(),"KSC5601"));
		// ServletOutputStream out = response.getOutputStream();
		parameter = parameter + "&"
				+ "contentTypeId=39&areaCode=1&sigunguCode=1&cat1=A05&cat2=A0502&cat3=A05020800&listYN=Y&MobileOS=ETC&MobileApp=TourAPI3.0_Guide&arrange=A&numOfRows=12&pageNo=1";
		// parameter = parameter + "&" + "eventStartDate=20171201";
		// parameter = parameter + "&" + "eventEndDate=20171231";
		// parameter = parameter + "&" + "pageNo=1&numOfRows=10";
		// parameter = parameter + "&" + "MobileOS=ETC";
		// parameter = parameter + "&" + "MobileApp=aa";
		parameter = parameter + "&" + "_type=json";

		addr = addr + serviceKey + parameter;
		URL url = new URL(addr);

		System.out.println(addr);

		// BufferedReader in = new BufferedReader(new
		// InputStreamReader(url.openStream(), "UTF-8"));

		InputStream in = url.openStream();
		CachedOutputStream bos1 = new CachedOutputStream();
		// ByteArrayOutputStream bos1 = new ByteArrayOutputStream();
		IOUtils.copy(in, bos1);
		in.close();
		bos1.close();

		// String mbos = bos1.toString("UTF-8");
		// System.out.println("mbos: "+mbos);

		// byte[] b = mbos.getBytes("UTF-8");
		// String s = new String(b, "UTF-8");
		// out.println(s);
		// System.out.println("s: " + s);

		String data = bos1.getOut().toString();
		out.println(data);

		JSONObject json = new JSONObject();
		// json.put("data", s);
		json.put("data", data);
		System.out.println("json: " + json);

		JSONObject jso = json.getJSONObject("data");
		JSONObject js = jso.getJSONObject("response");
		JSONObject jj = js.getJSONObject("body");
		JSONObject items = jj.getJSONObject("items");

		JSONArray jArray = items.getJSONArray("item");

		for (int i = 0; i < jArray.size(); i++) {
			JSONObject a = jArray.getJSONObject(i);

			System.out.println(a.get("addr1"));
			System.out.println(a.get("title"));
			System.out.println(a.get("mapx"));
			System.out.println(a.get("mapy"));
		}

		return "publicData";
	}

}
