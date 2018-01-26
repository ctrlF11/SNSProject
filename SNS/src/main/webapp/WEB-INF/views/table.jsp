<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.project.sns.board.vo.BoardVO"%>
<%@ page import="java.util.*"%>
<link href="resources/vendor/font-awesome/css/font-awesome.min.css"
   rel="stylesheet" type="text/css">
<meta name="viewport"
   content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet"
   href="resources/facebook/assets/css/bootstrap2.css">
<link rel="stylesheet"
   href="resources/facebook/assets/css/facebook2.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도의 중심좌표
    mapOption = { 
        center: new daum.maps.LatLng(33.451475, 126.570528), // 지도의 중심좌표
        level: 15 // 지도의 확대 레벨
    }; 

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 지도에 마커를 표시합니다 

var positions =  [
      <%
         List<BoardVO> list = (List<BoardVO>) request.getAttribute("user");
         for (int i = 0; i < list.size(); i++) {
      %>
      {title : "<%=list.get(i).getTitle()%>",
       contenttypeid : "<%=list.get(i).getContentTypeId()%>",
       contentid : "<%=list.get(i).getContentId()%>",
       latlng : new daum.maps.LatLng(<%=list.get(i).getMapy()%>,<%=list.get(i).getMapx()%>)
      }

      <%
         if (list.size() - 1 > i) {
               out.append(",");
            }
         }
      %>
      ];
// 커스텀 오버레이에 표시할 컨텐츠 입니다
// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
// 별도의 이벤트 메소드를 제공하지 않습니다 

var contents =  [
            <%
               for (int i = 0; i < list.size(); i++) {
            %>
            {
            value :  
               '<div class="wrap">' + 
                  '    <div class="info">' + 
                  '        <div class="title">' + 
                           "<%=list.get(i).getTitle()%>"+ 
                  '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
                  '        </div>' + 
                  '        <div class="body">' + 
                  '            <div class="img">' +
                  '                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
                  '           </div>' + 
                  '            <div class="desc">' + 
                  '                <div class="ellipsis">' + <%=list.get(i).getAddr1()%> + '</div>' + 
                  '                <div class="예제.. 아무정보 다들어감jibun ellipsis">(우) 63309 (지번) 영평동 2181</div>' + 
                  '                <div><a href="http://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>' + 
                  '            </div>' + 
                  '        </div>' + 
                  '    </div>' +    
                  '</div>' 
            
            }
             <%
                if (list.size() - 1 > i) {
                      out.append(",");
                   }
                }
             %>  
         ];
   

// 마커 위에 커스텀오버레이를 표시합니다
// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다


var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
for (var i = 0; i < positions.length; i ++) {
    
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new daum.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
    var marker = new daum.maps.Marker({
        map: map, // 마커를 표시할 지도
        position:positions[i].latlng, // 마커를 표시할 위치
        title : positions[i].title,  // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    }); 
    
   var overlay = new daum.maps.CustomOverlay({
       content: contents[i].value,
       map: map,
       position:positions[i].latlng   
   });
    closeOverlay();
   //마커를 클릭했을 때 커스텀 오버레이를 표시합니다
   
    daum.maps.event.addListener(marker,'mouseover', 
    function (){
    overlay.setMap(map);
    });
    daum.maps.event.addListener(marker,'mouseout', function closeOverlay(){
        overlay.setMap(null);     
    });
} 


// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}


function makeOverListener(map, marker, infowindow) {
   return function() {
     infowindow.open(map);
   };
}

   //인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
   return function() {
     infowindow.close();
   }
}
</script>
<c:forEach var="user" items="${requestScope.user}">
   <div class="panel panel-default">
      <a href="#"> <img class="card-img-top img-fluid w-100"
         src="resources/facebook/assets/img/uFp_tsTJboUY7kue5XAsGAs28.png" alt="">
      </a>
      <div class="card-body">
         <h6 class="card-title mb-1">
            <a href="#">이미지</a>
         </h6>
         <p class="card-text small">${user.content}
            <a href="#">#workinghardorhardlyworking</a>
         </p>
      </div>
      <hr class="my-0">
      <div class="card-body py-2 small">
         <a class="mr-3 d-inline-block" href="#"> <i
            class="fa fa-fw fa-thumbs-up"></i>Like
         </a> <a class="mr-3 d-inline-block" href="#" name="comment"> <i
            class="fa fa-fw fa-comment"></i>Comment
         </a> <a class="d-inline-block" href="#"> <i class="fa fa-fw fa-share"></i>Share
         </a>
      </div>
      <hr class="my-0">
      <div class="card-body small bg-faded"></div>
      <div id="replyDiv" class="reply">
         <table>
            <tr>
               <td class="header" width="370">댓글</td>
               <td class="header" width="100">작성자</td>
            </tr>

         </table>
         <table>
            <tr>
               <td><textarea id="rContent" cols="50" rows="2"></textarea>
                  <div id="cmsg"></div></td>
               <td><input type="text" id="rWriter" maxlength="20" size="10" />
                  <div id="wmsg"></div></td>
            </tr>
            <tr>
               <td class="bottom"></td>
               <td align="right" class="bottom"><button  class = "rBtn">댓글등록</button></td>
            </tr>
         </table>
      </div>
      <div class="card-footer small text-muted">Tell : ${user.regdate}</div>
   </div>
</c:forEach>



