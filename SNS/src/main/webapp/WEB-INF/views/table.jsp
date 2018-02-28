<%-- <%@include file ="addT.jsp" %> --%>
<%@page import="A.algorithm.AES"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.project.sns.board.vo.BoardVO"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<link href="resources/startbootstrap-coming-soon-gh-pages/vendor/font-awesome/css/font-awesome.min.css"
   rel="stylesheet" type="text/css">
<meta name="viewport"
   content="width=device-width, initial-scale=1, maximum-scale=1">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0"></script>
<script>
// 지도에 마커를 표시합니다 

var mapContainer = document.getElementById('map'), // 지도의 중심좌표
 mapOption = { 
 center: new daum.maps.LatLng(33.451475, 126.570528), // 지도의 중심좌표
level: 3 // 지도의 확대 레벨
 }; 
var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var positions =  [
      <%
      List<BoardVO> list = (List<BoardVO>) request.getAttribute("user");
         for (int i = 0; i < list.size(); i++) {
      %>
      {
       title : "<%=list.get(i).getTitle()%>",
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
                '                <img src="<%=list.get(i).getFirstimage()%>" width="73" height="70">' +
                '           </div>' + 
                '            <div class="desc">' + 
                '                <div class="ellipsis"><%=list.get(i).getAddr1()%></div>' + 
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
/* for (var i = 0; i < positions.length; i ++) {
    
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
    
    var infowindow = new daum.maps.InfoWindow({
       content : contents[i].value,
       map : map,
       position : positions[i].latlng   
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
} */ // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
for (var i = 0; i < positions.length; i ++) {
    // 마커를 생성합니다
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
    
    var infowindow = new daum.maps.InfoWindow({
       content : contents[i].value
   });

    // 마커에 이벤트를 등록하는 함수 만들고 즉시 호출하여 클로저를 만듭니다
    // 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    (function(marker, infowindow) {
        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
        daum.maps.event.addListener(marker, 'mouseover', function() {
            infowindow.open(map, marker);
        });

        // 마커에 mouseout 이벤트를 등록하고 마우스 아웃 시 인포윈도우를 닫습니다
        daum.maps.event.addListener(marker, 'mouseout', function() {
            infowindow.close();
        });
    })(marker, infowindow);
}









/* function closeOverlay() {
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
 */
</script>

<c:forEach var="user" items="${requestScope.user}">
<br/>
   <div class="panel panel-default" id = "table_${status.count}" >
   <div class="card mb-3">
   <div class="card-body">
      스토리 번호 : ${user.story_seq }
   ${status.count}
  <%=list.size()%>
 <input type="hidden" name="count_x${status.count}" value="${user.mapx}">
 <input type="hidden"  name="count_y${status.count}" value="${user.mapy}">
 <input type="hidden" id="size" value="<%=list.size()%>">
         <h6 class="card-title mb-1">
            <a
               href="getBoardValue.do?story_seq=${user.story_seq}&writer=${user.writer}">
               <input type="hidden" id="boardUser" value="${user.writer}"  />
               ${user.content}
               </a>
         </h6>
  
        
       <p class="card-text small" >
        <a href="#"><strong>by ${user.writer}</strong></a>
       </p>
       <p class="card-text small"><strong>
       ${user.regdate}
       <c:forEach var="time" items="${requestScope.time}" begin="${status.index}" end="${status.index }">${time}</strong></c:forEach>
       </p>
       <c:set var="id2" value="${user.writer}" scope="request"/>
        <%       
         String id = (String) session.getAttribute("id");
         AES aes = new AES();
         id = aes.setDecrypting(id);
         
         String id2 = (String) request.getAttribute("id2");
         if(id.equals(id2))
         {
        %>
       <button class="btn btn-default"  style = "color :#e1494a" id="up${user.board_seq}" onclick="updateBoard(this)"> 수정 </button>
       <button class="btn btn-default"  style = "color :#e1494a" id="del${user.board_seq}" name="${user.story_seq}" onclick="deleteBoard(this)"> 삭제</button>
       <%}%>
      </div>
      <hr class="my-0">
      <div class="card-body py-2 small">
         <a class="mr-3 d-inline-block" name="like${user.board_seq}" onclick="like_button(${user.board_seq},${user.story_seq})" href="#" style = "color :#e1494a;">
            <i class="fa fa-fw fa-thumbs-up"></i>${user.heart}명 Like
         </a>
         <a class="mr-3 d-inline-block" onclick="togglethis(${user.board_seq})" name="comment" style = "color :#e1494a;">
            <i class="fa fa-fw fa-comment"></i>Comment
         </a>
         <a class="d-inline-block" href="#" style = "color :#e1494a;">
            <i class="fa fa-fw fa-share"></i>Share
         </a>
      </div>
      </div>

      
      
   <!--                     추가                         -->
    <!--  댓글  -->
    <div class="container">
        <form name="commentInsertForm">
            <div class="input-group">
               <input type="hidden" name="board_seq${user.board_seq}" value="${user.board_seq}" id="board_seq${user.board_seq}" />
               <input type="hidden" name="story_seq${user.story_seq}" value="${user.story_seq}" id="board_seq${user.story_seq}"/>
               <input type="text" class="form-control" id="content" name="content${user.board_seq}" placeholder="내용을 입력하세요.">
               <span class="input-group-btn">
                    <button class="btn btn-default" type="button" name="rbtn" onclick="r_button(${user.board_seq},${user.story_seq})" style = "color :#e1494a;">등록</button>
               </span>
              </div>
        </form>
    </div>
    <div class="container" >
        <div class="commentList" name="commentList${user.board_seq}"></div>
    </div>
</div>
<!--                     추가                         -->
</c:forEach>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
      <%
       for (int i = 0; i < list.size(); i++) {
       %>
       replyList( <%=list.get(i).getBoard_seq()%>,<%=list.get(i).getStory_seq()%>);
      <%}%>
      
})

function replyList(board_seq,story_seq){
     $.ajax({
           url : 'list.do',
           type : 'get',
           data : {
                 'board_seq':board_seq,
                 'story_seq' :story_seq   
           },
           success : function(data){
               var a =''; 
               $.each(data, function(key, value){ 
                   a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                   a += '<div class="commentInfo'+value.reply_seq+'"><div class="commentWrap"><a href="#"><img id ="pro" src="resources/image/gazua_icon.png" alt="Paris"></a><strong>'+value.rwriter+'</strong>';
                   a += '<button style = "color :#e1494a;" class="btn btn-default" onclick="replyUpdate('+value.reply_seq+ ',\'' +value.rcontent+ '\',' +value.board_seq+ ',' +value.story_seq+'); style = "color :#e1494a;""> 수정 </button>';
                   a += '<button style = "color :#e1494a;" class="btn btn-default" onclick="replyDelete('+value.reply_seq+','+value.board_seq+ ',' +value.story_seq+ ');"> 삭제 </button> </div>';
                   a += '<div class="commentContent'+value.reply_seq+'"> <p>'+value.rcontent +'</p>';
                   a += '</div></div></div>';
                   $('[name=commentList'+board_seq+']').html(a);
               });
               
               
           }
       });
} 
function updateBoard(value){
	var upseq = value.id.replace('up','');
	console.log(upseq);
	location.replace("modifyBoard.do?board_seq="+upseq);
	
}

function deleteBoard(value){
	var delseq = value.id.replace('del','');
	var delstr = value.name;
	console.log(delseq);
	if(confirm('현재 작성 중이던 글을 삭제하시겠습니까?')){
			$.ajax({
				url:"deleteBoard.do",
				type:"post",
				data:{board_seq:delseq},
				success: function(data){
					location.replace("homeview.do?story_seq="+delstr);
				}
			})
	}else{
		return false;
	}
}
</script>
<style>
#pro {
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 5px;
    width: 35px;
}

#pro:hover {
    box-shadow: 0 0 2px 1px rgba(0, 140, 186, 0.5);
}
</style>