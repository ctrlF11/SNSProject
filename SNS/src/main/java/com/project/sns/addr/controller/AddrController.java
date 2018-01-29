package com.project.sns.addr.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.cxf.helpers.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.ListableBeanFactory;
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

	@RequestMapping("/line.do")
	public void line(HttpServletRequest req, AddrVO vo) throws Exception {
		List<AddrVO> list = service.getAddress();
		double distanceMeter = 0;
		//그래프 저장용 맵
        //HashMap<출발지, HashMap<도착지, 거리>>
        HashMap<String, HashMap<String, ArrayList>> distanceMap = 
                new HashMap<String, HashMap<String, ArrayList>>();
        
        //도착지, 거리 저장용 임시 맵
        //tempMap을 만든후 이를 다시 distanceMap에 put
        HashMap<String, ArrayList> tempMap = new HashMap<String, ArrayList>();
       
		
		for(int i=0; i<10; i++) {
			tempMap = new HashMap<>();
			for(int j=0; j<10; j++) {
				distanceMeter = distance(Double.parseDouble(list.get(i).getMapy()), Double.parseDouble(list.get(i).getMapx()), Double.parseDouble(list.get(j).getMapy()), Double.parseDouble(list.get(j).getMapx()), "meter");	
//				System.out.println(list.get(i).getTitle() + " --> " + distanceMeter + " --> " + list.get(j).getTitle() );	
				ArrayList<Object> mapList = new ArrayList<>();
				mapList.add(distanceMeter);
				mapList.add(list.get(j).getGrade());
				tempMap.put(list.get(j).getTitle(), mapList);			
			}	
			distanceMap.put(list.get(i).getTitle(), tempMap);
		}
		
	
		String destination = "양천구 어린이교통공원";
		
		Result result = dijkstra(distanceMap, "중명전");    	//dijkstra(거리 맵, 출발지)
        double distance = result.shortestPath.get(destination);	//destination의 거리 값
        
        ArrayList<String> path = new ArrayList<>();
        String curNode = destination;						//현재노드는 destination
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
	
	
	//다익스트라 알고리즘
	    final static double INFINITY = Double.MAX_VALUE;		//
    
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
	        
	        //출발지의 최단거리는 0, 이전 노드는 없음
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

	            		if(shortestPath.get(node) < minNodeDistance){	//최소 노드간 거리보다 적은 거리를 선택해 minNode, minNodeDistance 업데이트
	                    minNode = node;								
	                    minNodeDistance = shortestPath.get(node);	//minNodeDistance로 지정된 값은 다시 다른 노드간 거리와 비교하며 가장 적은 노드. 즉 minNode로 지정됨
	                }
	            }
	            		// 노드간 거리들 중 가장 낮은 거리는 Q에서 제외시킴
	            
	            //거리 최소 node의 이웃 노드까지 거리 Map 읽어 오기
	            //최소 node 까지 거리 + 이웃 노드까지 거리 < 현재 이웃 노드의 최소 거리 이면 shortestPath, preNode 갱신      
	            
	            HashMap<String, ArrayList> minNodeMap = graph.get(minNode);		
	            
	            for(String key: minNodeMap.keySet()) {	
   			       
       			     
   			        if(grade <= Integer.parseInt(minNodeMap.get(key).get(1).toString())) {
   			        	grade = Integer.parseInt(minNodeMap.get(key).get(1).toString());
   			        }
	            	
	            }
	            
	            for(String key: minNodeMap.keySet()) {	

	            	if(grade)
		                double distance = minNodeDistance + Double.parseDouble(minNodeMap.get(key).get(0).toString());	//최소거리 + 각 노드별 거리

		                if(distance < shortestPath.get(key)){						//더한 값이 shortestPath에 있는 해당 노드보다 적으면 shortestPath와 preNode 업데이트
		                	shortestPath.put(key, distance);						//처음엔 모든 값이 INF, 최소거리는 0이라서 원래의 값으로 shortestPath에 거리가 들어가게 됨
		                    preNode.put(key, minNode);
		                }
	            	}
	            Q.remove(minNode);	
	            }
	        	        
	        Result result = new Result();
	        result.shortestPath.putAll(shortestPath);
	        result.preNode.putAll(preNode);
	        
	        return result;
	    }
}

