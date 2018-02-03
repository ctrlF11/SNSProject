package com.project.sns.addr.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.cxf.helpers.IOUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.sns.addr.service.AddrService;
import com.project.sns.addr.vo.AddrVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
@Controller
public class AddrController {
	private final Logger logger = LoggerFactory.getLogger(AddrController.class);

	@Autowired
	private AddrService service;

	//DB 저장
	@RequestMapping("/inputAddr.do")
	public String inputAddr(HttpServletRequest request, HttpServletResponse response) throws Exception {
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

		byte[] b = mbos.getBytes("UTF-8");
		String s = new String(b, "UTF-8");
		out.println(s);

		JSONObject json = new JSONObject();
		json.put("data", s);
		// json.put("data", data);

		JSONObject jso = json.getJSONObject("data");
		JSONObject js = jso.getJSONObject("response");
		JSONObject jj = js.getJSONObject("body");
		JSONObject items = jj.getJSONObject("items");
		JSONArray jArray = items.getJSONArray("item");

		List<AddrVO> list = new ArrayList<AddrVO>();
		for (int i = 0; i < 3361; i++) {
			JSONObject a = jArray.getJSONObject(i);


			AddrVO vo = new AddrVO();

			// TourMap DB
			if (a.has("contenttypeid") && a.has("contentid") && a.has("title") && a.has("tel") && a.has("addr1")
					&& a.has("firstimage") && a.has("firstimage2") && a.has("cat2") && a.has("cat3") && a.has("mapx")
					&& a.has("mapy")) {
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
		return "test";
	}

	//DB 저장(축제 update)
	@RequestMapping("/updateFest.do")
	public String updateFest(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		parameter = parameter + "&" + "contentTypeId=15";
		parameter = parameter + "&" + "numOfRows=4000";
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

		byte[] b = mbos.getBytes("UTF-8");
		String s = new String(b, "UTF-8");
		out.println(s);

		JSONObject json = new JSONObject();
		json.put("data", s);
		// json.put("data", data);

		JSONObject jso = json.getJSONObject("data");
		JSONObject js = jso.getJSONObject("response");
		JSONObject jj = js.getJSONObject("body");
		JSONObject items = jj.getJSONObject("items");
		JSONArray jArray = items.getJSONArray("item");

		List<AddrVO> list = new ArrayList<AddrVO>();
		for (int i = 0; i < 377; i++) {
			JSONObject a = jArray.getJSONObject(i);

			AddrVO vo = new AddrVO();

			// TourMap DB
			if (a.has("contenttypeid") && a.has("contentid") && a.has("title") && a.has("tel") && a.has("addr1")
					&& a.has("firstimage") && a.has("firstimage2") && a.has("cat2") && a.has("cat3") && a.has("mapx")
					&& a.has("mapy")) {
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
		return "test";
	}

	@RequestMapping("/callDetail.do")
	public void callDetail(HttpServletRequest request, HttpServletResponse response, @RequestParam String contentId,
			@RequestParam String contentTypeId) throws Exception {
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
		
		System.out.println(s);
		System.out.println(json);
	}

	@RequestMapping("/Address.do")
	public String Address(HttpServletRequest req) throws Exception {
		List<AddrVO> list = service.getAddress();
		req.setAttribute("list", list);		
		return "Map";
	}

	@RequestMapping("/marker.do")
	public String marker(HttpServletRequest req) throws Exception {
		return "marker";
	}

	@RequestMapping("/getPath.do")
	public @ResponseBody Map<String, Object> getPath(HttpServletRequest req) throws Exception {
		   String[] temp = new String[3];
	        String[] wfKor = new String[3];
	        String[] hour1 = new String[3];
	        int weather =0 ;
	        try {
	              DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
	              DocumentBuilder parser = f.newDocumentBuilder();
	            
	              Document xmlDoc = null;
	              String url = "http://www.weather.go.kr/wid/queryDFSRSS.jsp?zone=1159068000";
	              xmlDoc = parser.parse(url);
	            
	              Element root = xmlDoc.getDocumentElement();
	              // System.out.println(root.getTagName());
	               
	              for (int i = 0; i < temp.length; i++) {
	               Node xml = root.getElementsByTagName("pubDate").item(0);     
	               Node xmlNode1 = root.getElementsByTagName("data").item(i);
	               
	               Node xmlNode21 = ((Element) xmlNode1).getElementsByTagName(
	                 "pty").item(0);
	               Node xmlNode22 = ((Element) xmlNode1).getElementsByTagName(
	                 "wfKor").item(0);
	               Node xmlNode23 = ((Element) xmlNode1).getElementsByTagName(
	                 "hour").item(0);
	                
	               temp[i] = xmlNode21.getTextContent();
	               wfKor[i] = xmlNode22.getTextContent();
	               hour1[i] = "기준시각 : " + xmlNode23.getTextContent() + "시";
	               
	               System.out.println("기준 시간"+xml.getTextContent());
	               System.out.println("기온 : 0 => 맑음  1,2,3 => 눈/비           현상태 =>"+temp[i] + "    날씨: " + wfKor[i] + "    시간: " +hour1[i]);
	               if(temp[i].equals("0"))
	                  weather = 1;
	               else 
	                  weather = 2;
	               System.out.println("weather : "+weather);
	              }
	            
	             } catch (Exception e) {
	              System.out.println(e.getMessage());
	              System.out.println(e.toString());
	             }
	        
	  
	       List<AddrVO> list = null;
	       if(weather == 1)
	       {
	
	          list = service.getAddress2("1");
	          AddrVO vo = service.getAddress3();
	          list.add(vo);
	          System.out.println( "콘탠트 아이디 :"+vo.getContentId());
	          System.out.println(list.get(1).getMapx());
	          req.setAttribute("randomPath", list);

	       }
	       else 
	       {
	          list = service.getAddress2("2");
	          AddrVO vo = service.getAddress3();
	          list.add(vo);
	          System.out.println( "주소 :"+vo.getAddr1());
	          System.out.println(list.get(1).getMapx());
	       }
	      
		double distanceMeter = 0;
		//그래프 저장용 맵
        //HashMap<출발지, HashMap<도착지, 거리>>
        HashMap<String, HashMap<String, ArrayList>> distanceMap = 
                new HashMap<String, HashMap<String, ArrayList>>();
        
        //도착지, 거리 저장용 임시 맵
        //tempMap을 만든후 이를 다시 distanceMap에 put
        HashMap<String, ArrayList> tempMap = new HashMap<String, ArrayList>();
       
		
		for(int i=0; i<list.size(); i++) {
			tempMap = new HashMap<>();
			for(int j=0; j<list.size(); j++) {
				distanceMeter = distance(Double.parseDouble(list.get(i).getMapy()), Double.parseDouble(list.get(i).getMapx()), Double.parseDouble(list.get(j).getMapy()), Double.parseDouble(list.get(j).getMapx()), "meter");	
//				System.out.println(list.get(i).getTitle() + " --> " + distanceMeter + " --> " + list.get(j).getTitle() );	
				ArrayList<Object> mapList = new ArrayList<>();
				mapList.add(distanceMeter);
				mapList.add(list.get(j).getGrade());
				tempMap.put(list.get(j).getContentId(), mapList);			
			}	
			distanceMap.put(list.get(i).getContentId(), tempMap);
		}
		
	
		String destination = "2520648";
		
		Result result = dijkstra(distanceMap, "2383039");    	//dijkstra(거리 맵, 출발지)
        double distance = result.shortestPath.get(destination);	//destination의 거리 값
        
        
        
        ArrayList<String> path = new ArrayList<>();
        String curNode = destination; 	//현재노드는 destination   
        						
        path.add(destination);				        
        while(!result.preNode.get(curNode).isEmpty()){		
            curNode = result.preNode.get(curNode);
            path.add(curNode);
        }
        
        System.out.println(destination + "까지의 최소 이동 거리: " + distance);
        System.out.println("=====이동 경로=====");
        for(int i = path.size()-1; i>=0; i--){
            System.out.println(path.get(i));
        }
        System.out.println("================");
        
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> jsonData = new HashMap<String, Object>();
        jsonData.put("path",path);
        System.out.println(jsonData);
        return jsonData;
	}

	//좌표로 위치 계산
	private static double distance(double lat1, double lon1, double lat2, double lon2, String unit) {

		double theta = lon1 - lon2;
		double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2))
				+ Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));

		dist = Math.acos(dist);
		dist = rad2deg(dist);
		dist = dist * 60 * 1.1515;

		if (unit == "kilometer") {
			dist = dist * 1.609344;
		} else if (unit == "meter") {
			dist = dist * 1609.344;
		}
		
		int distPoint = (int) Math.floor(dist/2000) * 10;
		//Meter로 계산할 때 2000으로 나눠서 소수점 이하 버림
		// * 10은 가중치 값 계산할 때 범위 적용가능하게 범위 늘리기용
		
		return (distPoint);
	}

	// This function converts decimal degrees to radians
	private static double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
	}

	// This function converts radians to decimal degrees
	private static double rad2deg(double rad) {
		return (rad * 180 / Math.PI);
	}
	
	
	//다익스트라 알고리즘
	    final static double INFINITY = Double.MAX_VALUE;		
    
	    //dijkstra return 오브젝트
	    private static class Result{
	        //노드 까지 최단 거리
	        HashMap<String, Double> shortestPath = new HashMap<>();
	        //자기 이전의 노드 -> 루트 추적용
	        HashMap<String, String> preNode = new HashMap<>();        
	    }
	    
	    //input: Map<출발지, Map<도착지, 거리>>, 최초 출발지
	    //output: Result object
	    //do: dijkstra 알고리즘을 이용하여 출발지부터 각 노드까지 최단 거리, 루트 계산
	    private static Result dijkstra(HashMap<String, HashMap<String, ArrayList>> graph, String start){
	        HashMap<String, Double> shortestPath= new HashMap<>();
	        HashMap<String, String> preNode = new HashMap<>();
	        
	        shortestPath.put(start, 0.0);
	        preNode.put(start, "");
	        
	        //그래프의 각 노드를 저장할 집합
	        HashSet<String> Q = new HashSet<>();
	        
	        for(String key: graph.keySet()){       //출발->도착까지 모든 노드 Q에 저장
	            Q.add(key);
	            if(!key.equals(start)){			   //출발지가 아니면 경로, 이전 노드 초기화
	            	shortestPath.put(key, INFINITY);
	                preNode.put(key, "");
	            }
	        }
	        
	        while(!Q.isEmpty()){			        //Q가 빌때 까지 반복
	            //현재 Q안에서 최소 distance인 node 찾은 후 꺼내기
	            String minNode = "";
	            double minNodeDistance = INFINITY;
	            int grade = 0;
	            
	            for(String node: Q){

	            		if(shortestPath.get(node) < minNodeDistance){	//최소거리 map에서 node까지의 거리가 가장 낮은걸 minNode, minNodeDistance에 업데이트
	            		minNode = node;								
	                    minNodeDistance = shortestPath.get(node);	
	            		}	           		
	            }
	            Q.remove(minNode);	// 노드간 거리들 중 가장 낮은 거리는 Q에서 제외시킴
	            
	            //거리 최소 node의 이웃 노드까지 거리 Map 읽어 오기
	            //최소 node 까지 거리 + 이웃 노드까지 거리 < 현재 이웃 노드의 최소 거리 이면 shortestPath, preNode 갱신      
	            
	            HashMap<String, ArrayList> minNodeMap = graph.get(minNode);		//가장 적은 거리를 통해 이동했으니깐 거기서 출발(minNode=출발)	
	            
	            for(String key: minNodeMap.keySet()) {	
	            		            	
		                double distance = minNodeDistance + Double.parseDouble(minNodeMap.get(key).get(0).toString());
		                				//이동한 거리 + 출발지에서 다음 노드까지 거리
		                switch (minNodeMap.get(key).get(1).toString()){
		                case "1": distance = distance + 5; break;
		                case "2": distance = distance + 4; break;
		                case "3": distance = distance + 3; break;
		                case "4": distance = distance + 2; break;
		                case "5": distance = distance + 1; break;
		                default : distance = distance + 10; break;
		                }
		                if(distance < shortestPath.get(key)){						//key까지 최소거리보다 distance가 적으면 그거로 바꿈		                	
		                	shortestPath.put(key, distance);						//minNode(출발) -> key(도착) 거리 update
		                    preNode.put(key, minNode);								//minNode -> key 이전 노드(=minNode) 
		                }
	            	}            
	            }
	        	        
	        Result result = new Result();
	        result.shortestPath.putAll(shortestPath);
	        result.preNode.putAll(preNode);
	        
	        return result;
	    }
	    
	    
}

