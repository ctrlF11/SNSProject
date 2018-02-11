<%@page import="com.project.sns.addr.vo.AddrVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<meta name="viewport"
   content="width=device-width, initial-scale=1, maximum-scale=1">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0"></script>
<link rel="stylesheet"
   href="resources/facebook/assets/css/bootstrap2.css">
<link rel="stylesheet"
   href="resources/facebook/assets/css/facebook2.css">
<link rel="stylesheet" href="resources/css/map.css?ver=1" type="text/css"/>
<script type="text/javascript" src="resources/js/map.js"></script>
<script type="text/javascript" src="resources/facebook/assets/js/jquery.js"></script>
<script type="text/javascript" src="resources/facebook/assets/js/bootstrap.js"></script>

<title>TourSNS</title>
</head>
<body>   

<div class="wrapper">
      <div class="box">
         <div class="row row-offcanvas row-offcanvas-left">
               <!--
                  col-sm-12, col-xs-12 둘 다 같은 width 설정 class.
                  col-xs-12는 disable된 상태
                  
                  맨 뒤의 숫자를 변경하면(col-sm-10) 회색 화면의 가로가 줄어들어 
                  백그라운드의 회색 화면이 나타남.                  
                -->
            <div id="main" class="column col-sm-12 col-xs-12">
               
               <!-- 
                  Topbar. 기존 부트스트랩보다 height를 늘림.
                -->
               <div class="navbar navbar-blue navbar-static-top">
                  <!-- 
                     아이콘 영역. 기존 부트스트랩보다 margin-top을 늘림.
                   -->
                  <div class="navbar-header">
                     <!-- 토글용 버튼인데.... collapse되어있어 비활성화된 듯 함. -->
                     <button class="navbar-toggle" type="button"
                        data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle</span>
                     </button>
                     <!-- 아이콘. margin-top을 늘림. -->
                     <a href="main.do" class="navbar-brand logo">N</a>
                  </div>
                  
                  <!-- 아이콘을 제외한 오른쪽 영역. -->
                  <nav class="navbar-collapse" role="navigation">
                     <!-- 검색 폼. -->
                     <div class="search_wrap">
                        <form class="navbar-form navbar-left" method="post" onsubmit="return checkgo();" id="searchForm">
                           <div class="input-group input-group-sm">
                              <select id="search_category" style="width: 55.2px; height: 30px;" >
                                 <option value="user">사람</option>
                                 <option value="map">가게</option>
                                 <option value="board">글</option>
                              </select>
                              <input class="form-control" placeholder="Search" name="srch-term" id="srch-term" type="text">
                              <div class="input-group-btn">
                                 <button class="btn btn-default" type="submit">
                                    <i class="glyphicon glyphicon-search"></i>
                                 </button>
                              </div>
                           </div>
                        </form>
                     </div>
                     <!-- 오른쪽 아이콘 모음집. 가로 957.333px에 찌그러짐-->
                     <div class="icon_wrap">
                        <ul class="nav navbar-nav navbar-right">
                           <li>
                              <a href="#">로그인</a>
                           </li>
                           <li>
                              <a href="#postModal" role="button" data-toggle="modal">
                              추천 경로+</a>
                           </li>
                           <li>
                              <a href="#">스토리</a>
                           </li>
                           <!-- 드롭다운(클릭하면 밑으로 튀어나오는 메뉴) -->
                            <li class="dropdown">
                           <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                           <i class="glyphicon glyphicon-user"></i></a>
                           <ul class="dropdown-menu">
                             <li><a href="">More</a></li>
                             <li><a href="">More</a></li>
                             <li><a href="">More</a></li>
                             <li><a href="">More</a></li>
                             <li><a href="">More</a></li>
                           </ul>
                          </li>
                        </ul>
                     </div>
                  </nav>
               </div>
   <div id="setDiv">
      <div id="mask"></div>
      <div id="window"></div>
      <div id="mapBox">
      	<div id="searchBox" style="z-index: 2;">
	      <input type="text" id="searchMap" onkeydown="enterkey();"/><input id = "searchMapBtn" type="button" value="검색" onclick="searchMap();"/>
		</div>
      	<div id="map" style="z-index: 1;" ></div> 
      </div>
      
      <!-- 오른쪽 사이드 -->  
      <div id="sidemenu">  
      	<button class="sideBtn" id="getpath" onclick="getpath()">경로 찾기</button>
      	<button class="sideBtn" id="newpath" onclick="newpath()">경로 새로고침</button>
      	<button class="sideBtn" id="savepath" onclick="savepath()">경로 저장</button>
      	<ul class="accordian">
      		<li class="accordian--box">
      			<h3 id="recommend" onclick="recommend()">추천코스</h3>
      			<h4 id="pathlist"></h4>
      		</li>
      	</ul>
      	<div id="path"></div>        
      </div>      
   </div>
            </div>         
         </div>
      </div>
   </div>
<script>



var accModule = function() {

     // private member (비공개 멤버, 고유멤버)
     var acc_wrap = $('.accodian'),
       question = acc_wrap.find('h3'),
       answer = question.next('h4');

     // privilieged member(공용 인터페이스)
     return {
       runInit: function() {
         this.accHandler();
       },
       accHandler: function() {
         var accodian = {
           targetClick: function(e) {
             var eTarget = $(e.currentTarget);
             if (eTarget.next().is(':visible')) {
               eTarget.next().slideUp();
               return;
             }
             answer.slideUp();
             eTarget.next().slideDown();
           }
         };
         question.on('click', accodian.targetClick);
       }
     }
   }();

   // 실행
   accModule.runInit();

var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 8 // 지도의 확대 레벨
    };

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
customOverlay = new daum.maps.CustomOverlay({});

// 마커를 표시할 위치와 title 객체 배열입니다 
var positions =  [
<%
   List<AddrVO> list = (List<AddrVO>) request.getAttribute("list");
   for (int i = 0; i < list.size(); i++) {
%>
{title : "<%=list.get(i).getTitle()%>",
 contenttypeid : "<%=list.get(i).getContentTypeId()%>",
 contentid : "<%=list.get(i).getContentId()%>",
 latlng : new daum.maps.LatLng(<%=list.get(i).getMapy()%>,<%=list.get(i).getMapx()%>),
 mapx : "<%=list.get(i).getMapx()%>",
 mapy : "<%=list.get(i).getMapy()%>"
}

<%
   if (list.size() - 1 > i) {
         out.append(",");
      }
   }
%>
];






 
	

 


</script>      
</body>
</html>