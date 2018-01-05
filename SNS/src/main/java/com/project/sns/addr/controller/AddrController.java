package com.project.sns.addr.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.cxf.helpers.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.sns.addr.service.AddrService;
import com.project.sns.addr.vo.AddrVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class AddrController {
	private final Logger logger = LoggerFactory.getLogger(AddrController.class);

	@Autowired
	private AddrService service;
//
	@RequestMapping("/inputAddr.do")
	public String inputAddr(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("PublicData2");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?ServiceKey=";
		String serviceKey = "429e9l%2BRPBvvMYSqI0TIu0JgvFl1vio2dcUfXj7d66%2F%2B2glco1EDs1HDHJBssw9U7HAt1A11Cy6N0Hbk2INDfQ%3D%3D";
		String parameter = "";
		// serviceKey = URLEncoder.encode(serviceKey,"utf-8");

		PrintWriter out = response.getWriter();
		// PrintWriter out = new PrintWriter(new OutputStream
		// Writer(response.getOutputStream(),"KSC5601"));
		// ServletOutputStream out = response.getOutputStream();
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

		// BufferedReader in = new BufferedReader(new
		// InputStreamReader(url.openStream(), "UTF-8"));

		InputStream in = url.openStream();
		// CachedOutputStream bos = new CachedOutputStream();
		ByteArrayOutputStream bos1 = new ByteArrayOutputStream();
		IOUtils.copy(in, bos1);
		in.close();
		bos1.close();

		String mbos = bos1.toString("UTF-8");
		System.out.println("mb: " + mbos);

		byte[] b = mbos.getBytes("UTF-8");
		String s = new String(b, "UTF-8");
		out.println(s);
		System.out.println("s: " + s);

		JSONObject json = new JSONObject();
		json.put("data", s);
		// json.put("data", data);
		System.out.println("json: " + json);
		
		JSONObject jso = json.getJSONObject("data");
		System.out.println("json1: " + jso);
		JSONObject js = jso.getJSONObject("response");
		System.out.println("json2: " + js);
		JSONObject jj = js.getJSONObject("body");
		System.out.println("json3: " + jj);
		JSONObject items = jj.getJSONObject("items");
		System.out.println("json4: " + items);
		JSONArray jArray = items.getJSONArray("item");
		System.out.println("json5: " + jArray);

		
		List<AddrVO> list = new ArrayList<AddrVO>();
		for (int i = 0; i < 10; i++) {
			JSONObject a = jArray.getJSONObject(i);
			
			AddrVO vo = new AddrVO();
			vo.setAddr1(a.getString("addr1"));
			vo.setTitle(a.getString("title"));
			vo.setMapX(a.getString("mapx"));
			vo.setMapY(a.getString("mapy"));
			list.add(vo);
		}
		int i = service.inputAddr(list);
		System.out.println(i);
		return "test";
	}
}
