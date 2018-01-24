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
import org.springframework.web.bind.annotation.RequestParam;

import com.project.sns.addr.service.AddrService;
import com.project.sns.addr.vo.AddrVO;
import com.project.sns.tour.vo.TourMapVO;

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

		String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=";
		String serviceKey = "429e9l%2BRPBvvMYSqI0TIu0JgvFl1vio2dcUfXj7d66%2F%2B2glco1EDs1HDHJBssw9U7HAt1A11Cy6N0Hbk2INDfQ%3D%3D";
		String parameter = "";
		// serviceKey = URLEncoder.encode(serviceKey,"utf-8");

		PrintWriter out = response.getWriter();
		// PrintWriter out = new PrintWriter(new OutputStream
		// Writer(response.getOutputStream(),"KSC5601"));
		// ServletOutputStream out = response.getOutputStream();
		parameter = parameter + "&" + "areaCode=1";
		parameter = parameter + "&" + "numOfRows=4000";
		parameter = parameter + "&" + "cat2=A0102";
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
		for (int i = 0; i < 3361; i++) {
			JSONObject a = jArray.getJSONObject(i);
			
			AddrVO vo = new AddrVO();

//TourMap DB			
			if(a.has("contenttypeid")&&a.has("contentid")&&a.has("title")&&a.has("tel")&&a.has("addr1")&&a.has("firstimage")&&
				a.has("firstimage2") && a.has("cat2") && a.has("cat3") && a.has("mapx") && a.has("mapy")){
			vo.setContentTypeId(a.getString("contenttypeid"));
			vo.setContentId(a.getString("contentid"));
			vo.setTitle(a.getString("title"));
			vo.setTel(a.getString("tel"));
			vo.setAddr1(a.getString("addr1"));
			vo.setFirstimage(a.getString("firstimage"));
			vo.setFirstimage2(a.getString("firstimage2"));
			vo.setCat2(a.getString("cat2"));
			vo.setCat3(a.getString("cat3"));			
			vo.setMapx(a.getString("mapx"));
			vo.setMapy(a.getString("mapy"));
			list.add(vo);
			}
		}
		
		int i = service.inputAddr(list);
		System.out.println(i);
		return "test";
	}
	
	
	@RequestMapping("/callDetail.do")
	public void callDetail(HttpServletRequest request, HttpServletResponse response, @RequestParam String contentId, @RequestParam String contentTypeId) throws Exception {
		logger.info("callDetail");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
	
		String addr = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro?ServiceKey=";
		String serviceKey = "429e9l%2BRPBvvMYSqI0TIu0JgvFl1vio2dcUfXj7d66%2F%2B2glco1EDs1HDHJBssw9U7HAt1A11Cy6N0Hbk2INDfQ%3D%3D";
		String parameter = "";

		PrintWriter out = response.getWriter();

		parameter = parameter + "&" + "contentId=" + contentId;
		parameter = parameter + "&" + "contentTypeId=" + contentTypeId;
		parameter = parameter + "&" + "MobileOS=ETC";
		parameter = parameter + "&" + "MobileApp=aa";
		parameter = parameter + "&" + "_type=json";

		addr = addr + serviceKey + parameter;
		URL url = new URL(addr);  

		System.out.println(addr);

		InputStream in = url.openStream();   

		ByteArrayOutputStream bos1 = new ByteArrayOutputStream();
		IOUtils.copy(in, bos1);  
		in.close();
		bos1.close();

		String mbos = bos1.toString("UTF-8");
		
		byte[] b = mbos.getBytes("UTF-8");
		String s = new String(b, "UTF-8");
		out.println(s);

		JSONObject json = new JSONObject();
		json.put("data", s);
	}
	
	@RequestMapping("/Address.do")
	public String Address(HttpServletRequest req) throws Exception{
		List<AddrVO> list = service.getAddress();
		req.setAttribute("list", list);
		return "Map";
	}
	
	@RequestMapping("/marker.do")
	public String marker(HttpServletRequest req) throws Exception{
		return "marker";
	}

	
	@RequestMapping("/line.do")
	public void line(HttpServletRequest req, AddrVO vo) throws Exception{
    List<AddrVO> list = service.getAddress();
		for(int i =0; i < 10; i++)
		{
			System.out.println(list.get(i).getMapx());
		}
		
		System.out.println("ML : " + list.size());
//		double[][] distanceMeter = new double[mapx.length][mapy.length];
//		for(int i=0; i<mapx.length; i++) {
//			for(int j=0; j<mapy.length; j++) {
//				distanceMeter[i][j] = distance(Double.parseDouble(mapx[i]), Double.parseDouble(mapy[i]), Double.parseDouble(mapx[j]), Double.parseDouble(mapy[j]), "kilometer");
//				System.out.println(distanceMeter[i][j]);
//			}
//		}
		
		
	}
	
	   private static double distance(double lat1, double lon1, double lat2, double lon2, String unit) {
	         
	        double theta = lon1 - lon2;
	        double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
	         
	        dist = Math.acos(dist);
	        dist = rad2deg(dist);
	        dist = dist * 60 * 1.1515;
	         
	        if (unit == "kilometer") {
	            dist = dist * 1.609344;
	        } else if(unit == "meter"){
	            dist = dist * 1609.344;
	        }
	 
	        return (dist);
	    }
	     
	 
	    // This function converts decimal degrees to radians
	    private static double deg2rad(double deg) {
	        return (deg * Math.PI / 180.0);
	    }
	     
	    // This function converts radians to decimal degrees
	    private static double rad2deg(double rad) {
	        return (rad * 180 / Math.PI);
	    }
	 
	
}
