<%@page import="com.project.sns.addr.vo.AddrVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<meta name="viewport"
   content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet"
   href="resources/facebook/assets/css/bootstrap2.css">
<link rel="stylesheet"
   href="resources/facebook/assets/css/facebook2.css">
<script type="text/javascript" src="resources/facebook/assets/js/jquery.js"></script>
<script type="text/javascript" src="resources/facebook/assets/js/bootstrap.js"></script>
<script type="text/javascript">
   $(document)
         .ready(
               function() {
                  $('[data-toggle=offcanvas]')
                        .click(
                              function() {
                                 $(this).toggleClass(
                                       'visible-xs text-center');
                                 $(this)
                                       .find('i')
                                       .toggleClass(
                                             'glyphicon-chevron-right glyphicon-chevron-left');
                                 $('.row-offcanvas').toggleClass(
                                       'active');
                                 $('#lg-menu').toggleClass(
                                       'hidden-xs').toggleClass(
                                       'visible-xs');
                                 $('#xs-menu').toggleClass(
                                       'visible-xs').toggleClass(
                                       'hidden-xs');
                                 $('#btnShow').toggle();
                              });
               });
</script>

<title>Insert title here</title>
    <style>

        #setDiv {           
            text-align: center;               
        }
        #mask {
            position:absolute;
            left:0;
            top:0;
            z-index:9999;
            background-color:#000;
            display:none;           
        }
        #window {
            display: none;
            background-color: #ffffff;
            height: 200px;
            z-index:99999;
            width:600px;
            height:250px;
            border:1px;
            solid :#ccc;
            position:fixed;           
        }      
        #sidemenu{
           	width:450px;
           	height:100vh;
           	padding-top:70px;
        	float:right;  
        	background-color:#393939;      		
        }
		#map{
		 	position: absolute;
		 	/* padding-left: 100px; */
			width: calc(100% - 450px);
			height:100%;
			float:left;
		}        
        
        *{ margin: 0; padding: 0;}
		.accodian {list-style: none }
		.accodian--box { margin-bottom: 5px;}
		.accodian--box h3 { background: #333; padding: 5px; color: #fff; cursor: pointer}
		.accodian--box h4 { background: #ccc; padding: 5px; display: none; }
    </style>	
</head>
<body>	
<div class="wrapper">
      <div class="box">
         <div class="row row-offcanvas row-offcanvas-left">
         
                  <!--
                     원본 왼쪽에 있던 사이드바.
                     다만 밑의 메인 화면의 가로 길이를 100%로 하였기 때문에
                     글씨가 겹쳐 보이는 문제가 발생함.
                  -->
                   <div class="column col-sm-2 col-xs-1 sidebar-offcanvas" id="sidebar">
                 
                  <ul class="nav">
                     <li><a href="#" data-toggle="offcanvas" class="visible-xs text-center"><i class="glyphicon glyphicon-chevron-right"></i></a></li>
                  </ul>
                  
                  <ul class="nav hidden-xs" id="lg-menu">
                     <li class="active"><a href="#featured"><i class="glyphicon glyphicon-list-alt"></i> </a></li>
                     <li><a href="#stories"><i class="glyphicon glyphicon-list"></i> </a></li>
                     <li><a href="#"><i class="glyphicon glyphicon-paperclip"></i> </a></li>
                     <li><a href="#"><i class="glyphicon glyphicon-refresh"></i> </a></li>
                  </ul>
                  <ul class="list-unstyled hidden-xs" id="sidebar-footer">
                     <li>
                       <a href="http://usebootstrap.com/theme/facebook"><h3>Bootstrap</h3> <i class="glyphicon glyphicon-heart-empty"></i> Bootply</a>
                     </li>
                  </ul>
                 
                  <!-- tiny only nav -->
                  <ul class="nav visible-xs" id="xs-menu">
                     <li><a href="#featured" class="text-center"><i class="glyphicon glyphicon-list-alt"></i></a></li>
                     <li><a href="#stories" class="text-center"><i class="glyphicon glyphicon-list"></i></a></li>
                     <li><a href="#" class="text-center"><i class="glyphicon glyphicon-paperclip"></i></a></li>
                     <li><a href="#" class="text-center"><i class="glyphicon glyphicon-refresh"></i></a></li>
                  </ul>
                 
               </div> 
               <!--
                  col-sm-12, col-xs-12 둘 다 같은 width 설정 class.
                  col-xs-12는 disable된 상태
                  
                  맨 뒤의 숫자를 변경하면(col-sm-10) 회색 화면의 가로가 줄어들어 
                  백그라운드의 회색 화면이 나타남.                  
                -->
            <div id="main" class="column col-sm-10 col-xs-11">
               
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
		<div id="map"></div>	
		<div id="sidemenu">	        
			<ul class="accodian">
				<li class="accodian--box">
					<h3>모바일 웹을 이용하려면</h3>
					<h4>알아서 잘 이용하세요 ㅋㅋ</h4>
				</li>
				<li class="accodian--box">
					<h3>질문 있어요~~</h3>
					<h4>답변입니다요~~</h4>
				</li>
				<li class="accodian--box">
					<h3>Lorem ipsum dolor sit.</h3>
					<h4>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
						Dignissimos, voluptatibus?</h4>
				</li>
			</ul>
		</div>		
	</div>
            </div>         
         </div>
      </div>
   </div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0"></script>
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
        level: 3 // 지도의 확대 레벨
    };

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커를 표시할 위치와 title 객체 배열입니다 
var positions =  [
	<%
	   List<AddrVO> list = (List<AddrVO>) request.getAttribute("list");
	   for (int i = 0; i < 10; i++) {
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

 	
	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
	for (var i = 0; i < positions.length; i ++) {

	    addMarker(positions[i].latlng, positions[i].title, positions[i].contentid, positions[i].contenttypeid);    
	} 

	 // 뒤 검은 마스크를 클릭시에도 모두 제거하도록 처리합니다.
    $('#mask').click(function () {
        $(this).hide();
        $('#window').hide();
    });	
	 
	 
 function addMarker(position, title, contentid, contenttypeid) {	

    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new daum.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
    var marker = new daum.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: position, // 마커를 표시할 위치
        title : title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });
	
	
    
	daum.maps.event.addListener(marker, 'click', function() {
	
		wrapWindowByMask();
		
		$.ajax({        
		      url: 'callDetail.do',
		      type: 'get',
		      data : {"contentId" : contentid, "contentTypeId" : contenttypeid},
		      dataType: 'json',
		      success: function(data){
		    	  console.log(data);
	 	          console.log(data.response.body.items.item);
 		          var myItem = data.response.body.items.item;
		              var output = '';
		              output += '<h4>'+myItem.treatmenu+'</h4>';
		              output += '<h4>'+myItem.opentimefood+'</h4>';
		              output += '<h4>'+myItem.reservationfood+'</h4>'; 
		              
			          $('#window').html(output);
		      },
	    	error: function(XMLHttpRequest, textStatus, errorThrown) { 
	        	alert("Status: " + textStatus); alert("Error: " + errorThrown); 
	    	} 
	});
	});
	} 
  

function wrapWindowByMask(){ //화면의 높이와 너비를 구한다.
	 
	var maskHeight = $(document).height();
	var maskWidth = $('#map').width(); //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
	
	$('#mask').css({'width':maskWidth,'height':maskHeight});	//마스크의 투명도 처리 
	$('#mask').fadeTo("slow",0.8);

 	var left = ( $('#map').scrollLeft() + ( $('#map').width() - $('#window').width()) / 2 );
    var top = ( $('#map').scrollTop() + ( $('#map').height() - $('#window').height()) / 2 ); 
    
    $('#window').css({'left':left,'top':top, 'position':'absolute'});
    
    $('#window').show();
}
	
<%-- var linePath =  [
	<%
	   List<AddrVO> list2 = (List<AddrVO>) request.getAttribute("list");
	   for (int i = 0; i < list.size(); i++) {
	%>
	 new daum.maps.LatLng(<%=list2.get(i).getMapY()%>,<%=list2.get(i).getMapX()%>)
	

	<%
	   if (list2.size() - 1 > i) {
	         out.append(",");
	      }
	   }
	%>
	];
 var polyline = new daum.maps.Polyline({
    path: linePath, // 선을 구성하는 좌표배열 입니다
    strokeWeight: 5, // 선의 두께 입니다
    strokeColor: '#FFAE00', // 선의 색깔입니다
    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
    strokeStyle: 'solid' // 선의 스타일입니다
});

// 지도에 선을 표시합니다 
polyline.setMap(map);    --%>


</script>      
</body>
</html>