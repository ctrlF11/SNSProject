package com.project.sns.addr.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Deque;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.cxf.helpers.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.sns.addr.service.AddrService;
import com.project.sns.addr.vo.AddrVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class AddrController {
   private final Logger logger = LoggerFactory.getLogger(AddrController.class);

   @Autowired
   private AddrService service;

   
	public static int[][] W;
	public static int[][] dp;
	public static int N;
	public static final int INF = 1000000000;
	private static Deque<Integer> route = new ArrayDeque<>();
	private static List<Integer> solution;
	private static List<Integer> path;
	static int re = INF;
   
	
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
   
   
   //추가!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   @RequestMapping("/Path.do")
   public String Path(HttpServletRequest req) throws Exception{
	   List<AddrVO> list = service.getAddress();
	   req.setAttribute("list", list);   
	   return "path";
   }

   @RequestMapping("/marker.do")
   public String marker(HttpServletRequest req) throws Exception {
      return "marker";
   }
   
   
   //추가!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   @ResponseBody
   @RequestMapping(value = "/getpath", method= {RequestMethod.POST})
   public List<AddrVO> path(HttpServletRequest req, @RequestBody List<AddrVO> paramData) throws Exception{
	   
	   	System.out.println("paramData의 길이" + paramData.size());
	   //노드간 거리 구하기
	      double distanceMeter = 0;
	      //그래프 저장용 맵
	        //HashMap<출발지, HashMap<도착지, 거리>>
	        HashMap<String, HashMap<String, ArrayList>> distanceMap = 
	                new HashMap<String, HashMap<String, ArrayList>>();
	        //도착지, 거리 저장용 임시 맵
	        //tempMap을 만든후 이를 다시 distanceMap에 put
	        HashMap<String, ArrayList> tempMap = new HashMap<String, ArrayList>();
	        
	        //순서대로 저장
	        List<String> name = new ArrayList<>();
	        name.add("0");//시작 1에 맞추려고 그냥 넣음.
	        for(AddrVO vo : paramData) {
	        	name.add(vo.getTitle());
	        }
	        
	        N = paramData.size();
			W = new int[N + 1][N + 1];
			dp = new int[N + 1][1 << N];
	        
	        for(int i = 0; i < N; i++) {
	            tempMap = new HashMap<>();
	            for(int j = 0; j < N; j++) {
	            	if(i==j)continue;
	               distanceMeter = distance(Double.parseDouble(paramData.get(i).getMapy()), Double.parseDouble(paramData.get(i).getMapx()), Double.parseDouble(paramData.get(j).getMapy()), Double.parseDouble(paramData.get(j).getMapx()), "meter");   
	               W[i+1][j+1] = (int) Math.floor(distanceMeter);	               
	               ArrayList<Object> mapList = new ArrayList<>();
	               mapList.add(distanceMeter);
	               mapList.add(paramData.get(j).getGrade());
	               tempMap.put(paramData.get(j).getTitle(), mapList);         
	            }   
	            distanceMap.put(paramData.get(i).getTitle(), tempMap);
	         }
	        
			// 2차원 배열의 모든 원소를 -1로
			for (int i = 1; i <= N; i++) {
				Arrays.fill(dp[i], -1);
			}
			
			
//			path.clear();
			int start = 1;
//			System.out.println(getShortestPath(start, 1));
			
			path = getPath(start,1);
			
//			getShortestPath(start,1);
			
			Collections.reverse(path);
			
			System.out.println("path의 길이 : " + path.size());
			
			
			int longest = 0;
			int star = 0;			
			for(int i = 0; i < path.size(); i++) {
				if(i == path.size()-1) {
					if(W[path.get(i)][path.get(0)] > longest) {
						longest = W[path.get(i)][path.get(0)];
						star = path.get(0);
					}
				}else if(W[path.get(i)][path.get(i+1)] > longest) {
					longest = W[path.get(i)][path.get(i+1)];
					star = path.get(i+1);
				}
			}
			System.out.println("longest : " + longest);
			System.out.println("star : " + star);
			
			
			
			System.out.println("W : ");
			for(int i = 0; i<W.length; i++) {
				for(int j = 0; j <W[0].length; j++) {
					System.out.print(W[i][j] + " ");
				}
				System.out.println();
			}
			
			
			int index = path.indexOf(star);
			List<Integer> result = new ArrayList<>();
			for(int i = index; i < path.size(); i++) {
				result.add(path.get(i));
			}
			for(int i = 0; i < index; i++) {
				result.add(path.get(i));
			}
			
			System.out.println("result의 길이 : " + result.size());

			
			System.out.println("result : ");
			for(int i : result) {
				System.out.print(i + " ");
				System.out.println(name.get(i));
			}
			
			List<AddrVO> re = new ArrayList<>();
			for(int i : result) {
				re.add(paramData.get(i-1));
			}

			System.out.println("re의 길이 : " + re.size());
			
			return re;
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
      
//      int distPoint = (int) Math.floor(dist/1000);
      
      return (Math.floor(dist));
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
           HashMap<String, Integer> gradePath= new HashMap<>();
           
           //출발지의 최단거리는 0, 이전 노드는 없음
           shortestPath.put(start, 0.0);
           preNode.put(start, "");
//           gradePath.put(start, 1);
           
           //그래프의 각 노드를 저장할 집합
           HashSet<String> Q = new HashSet<>();
           
           for(String key: graph.keySet()){       //출발->도착까지 모든 노드 Q에 저장
               Q.add(key);
               if(!key.equals(start)){            //출발지가 아니면 경로, 이전 노드 초기화
                  shortestPath.put(key, INFINITY);
                   preNode.put(key, "");
//                   gradePath.put(key, 0);
               }
           }
           
           while(!Q.isEmpty()){                 //Q가 빌때 까지 반복
               //현재 Q안에서 최소 distance인 node 찾은 후 꺼내기
               String minNode = "";
               double minNodeDistance = INFINITY;
               int grade = 0;
               
               for(String node: Q){
//                  if(gradePath.get(node) > grade){
                     if(shortestPath.get(node) < minNodeDistance){   //최소거리 map에서 node까지의 거리가 가장 낮은걸 minNode, minNodeDistance에 업데이트
//                     grade = gradePath.get(node);
                     minNode = node;                        
                       minNodeDistance = shortestPath.get(node);   
                     }                    
//                  }
               }
               Q.remove(minNode);   // 노드간 거리들 중 가장 낮은 거리는 Q에서 제외시킴
               
               //거리 최소 node의 이웃 노드까지 거리 Map 읽어 오기
               //최소 node 까지 거리 + 이웃 노드까지 거리 < 현재 이웃 노드의 최소 거리 이면 shortestPath, preNode 갱신      
               
               HashMap<String, ArrayList> minNodeMap = graph.get(minNode);      //가장 적은 거리를 통해 이동했으니깐 거기서 출발(minNode=출발)   
               
               for(String key: minNodeMap.keySet()) {   

/*                  if(grade < Integer.parseInt(minNodeMap.get(key).get(1).toString())) {
                       grade = Integer.parseInt(minNodeMap.get(key).get(1).toString());
                    }*/
                                    
                      double distance = minNodeDistance + Double.parseDouble(minNodeMap.get(key).get(0).toString());
                                  //이동한 거리 + 출발지에서 다음 노드까지 거리
                      switch (minNodeMap.get(key).get(1).toString()){
                      case "1": distance = distance + 10; break;
                      case "2": distance = distance + 8; break;
                      case "3": distance = distance + 6; break;
                      case "4": distance = distance + 4; break;
                      case "5": distance = distance + 2; break;
                      default : distance = distance + 0; break;
                      }
                      

                      
//                      if(grade > gradePath.get(key)) {                      
                      if(distance < shortestPath.get(key)){                  //key까지 최소거리보다 distance가 적으면 그거로 바꿈                         
                         shortestPath.put(key, distance);                  //minNode(출발) -> key(도착) 거리 update
                          preNode.put(key, minNode);                        //minNode -> key 이전 노드(=minNode) 
//                          gradePath.put(key, grade);
//                      }
                      }
                  }            
               }
                      
           Result result = new Result();
           result.shortestPath.putAll(shortestPath);
           result.preNode.putAll(preNode);
           
           return result;
       }
      
    
    public static List<Integer> getPath(int current, int visited){
    	getShortestPath(current, visited);
    	
    	return path;
    }
       
	public static int getShortestPath(int current, int visited) {
		
		// 모든 정점을 다 들른 경우
		if (visited == (1 << N) - 1) {	
			route.push(1);
			//1까지 경로 리턴
			return W[current][1];
		}

		int ret = INF;
		
		// 집합에서 다음에 올 원소를 고르자!
		for (int i = 1; i <= N; i++) {
			int next = i;
			
			// 이미 들렀던 곳일때 pass
			if ((visited & (1 << (next - 1))) != 0) { 
				continue;
			}
			
			// 0은 경로가 없으므로 pass
			if(W[current][next] == 0)
				continue;
			
			route.push(i);

			int temp = W[current][next] + getShortestPath(next, visited + (1 << (next - 1)));

			if(route.size()==N) {
						solution = new ArrayList<>(route);
				route.pop();
			}
			if(route.size()==2) {
				if(re > temp + W[i][1]) {
					path = new ArrayList<>(solution);
					re = temp;
				}
			}
			route.pop();
			ret = Math.min(ret, temp);		
		}	
		return dp[current][visited] = ret;
		
	}
}
