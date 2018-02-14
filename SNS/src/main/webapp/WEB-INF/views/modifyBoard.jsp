<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<meta name="viewport"
   content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet"
   href="resources/facebook/assets/css/bootstrap2.css">
<link rel="stylesheet"
   href="resources/facebook/assets/css/facebook2.css">
<link rel="stylesheet"
   href="resources/css/map.css">
<script type="text/javascript" src="resources/facebook/assets/js/jquery.js"></script>
<script type="text/javascript" src="resources/facebook/assets/js/bootstrap.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> -->
<link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<style>

#map {
   position: fixed;
}

.fileDrop {
	width: 100%;
	height: 50px;
	background: gray;
	border: 1px dotted black;
}

.pull-right{
	float: right !important;
	}
	
.con{
	overflow:hidden;
	height:auto;
	}
	
#content{
	width: 100%;
	height: 300px;
	background: white;
	margin-top: 10px;
	margin-bottom: 10px;
	overflow: auto;
	padding: 10px;
	}
	
#searchBox{
	position: fixed;
	float: right;
	background-color: #4CAF50;
	height : 50px;
	top: 115px;
	right: 1%;
	}
	
#searchResult{
	position: fixed;
	bottom: 0;
	right: 0;
	background-color: #4CAF50;
	height : 250px;
	width : 41%;
	}

#searchContent{
	background: white;
	padding: 14px 40px;
	font-size: 16px;
	border-radius: 12px;
	width: auto;
	margin: 10px;
	overflow: auto;
	}
	
#file{
	display:none;
	}
	
.toolBox{
	height : 50px;
	}

#glyphicon span {
    font-size: 50px;
    margin-left : 0;
    margin-right : 0;

}

#modifyForm{
	margin-top : 80px;
	}

.story {
	margin-top : 20px;
	
	}
	
#searchMap{
	background-color: white;
	background-image: url('musica-searcher.png');
	background-position: 2px 2px;
	background-repeat: no-repeat;
	padding-left: 40px;
	}

</style>
<title>Insert title here</title>

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

>                        
                        
            <!--  수정 폼 -->           
			<div class="col-sm-6" id="modifyForm">
					<button id='save' class="btn btn-warning pull-right" >저장</button>
					
					<!--  스토리  -->
					<div class='story form-group'>
						<form class='storyForm'>
							<select name='storyBox' id='storyBox' class='form-control'>
								<option>스토리 선택</option>
								<c:forEach items="${story}" var="story">
									<option value='${story.story_seq}'>${story.story_title}</option>
								</c:forEach>
								<option disabled></option>
								<option value="스토리삭제">스토리삭제</option>
								<option value="스토리추가">스토리추가</option>
							</select> 
						</form>
					</div>
					<hr>
					
					<!-- 글작성 -->
					<div class='board form-group'>
						<div class="btitle">
							<input  class="form-control" type="text" id='title' placeholder='글 제목'/>
						</div>

						<div class='uploadedList' id="content" contentEditable="true"></div>
						<div class='toolBox'>
							<form id="imageUpload" method='POST' enctype='multipart/form-data'>
								<input type="file" name="image" id="file"/>
							</form>
							<div id="glyphicon">
								<span class="glyphicon glyphicon-picture" id="imageUp" aria-hidden="true"></span>
								<span class="glyphicon glyphicon-trash" id="delete" aria-hidden="true"></span>
								<span class="glyphicon glyphicon-screenshot" id="reloacate" aria-hidden="true"></span>
							</div>
							<!-- <div class='fileDrop'></div>  -->
						</div>
					</div>
					<hr>
				</div>
 
               <div class="col-sm-6">
                   <div class="panel panel-default">
                        <div id="mapBox">
	                   		<div id="searchBox" style="z-index: 2;">
	                  			<input type="text" id="searchMap" onkeydown="enterkey();" placeholder="검색.."/><input id = "searchMapBtn" type="button" onclick="searchMap();" value="검색"/>
	                   		</div>
	                   		<div id="map" style="width: 40%; height: 100%;" style="z-index: 1;"></div>
	                   		<div id="searchResult" style="z-index: 3;">
	                   			<div id="searchContent" style="z-index: 4;"></div>
	                   		</div>
                    	</div>
                   </div>
                </div>
            </div>
         </div>
      </div>
   </div>
					
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0"></script>
<script type="text/javascript">

<%
//임시
 String id = "123asdf";
%>

var id = '<%=id%>';
var files = [];
var blob;

var contentId;
var mtitle;

//보드 받아올 때 빼오기. 
var board_seq =3; 
//선택한 마커
var selectedMarker = null;
//검색결과.
var array = new Array();

var markersArr = []; 
var markers = [];

$(function(){
	
	$('#searchResult').hide();
	$('#searchContent').hide();
})	
	
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	mapOption = { 
	    center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

var marker_width = 24,
	marker_height = 35,
	over_marker_width = 30,
	over_marker_height = 40,
	sprite_marker_url = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png",
	click_marker_url = "markerStarRed.png";
	
var markerSize = new daum.maps.Size(marker_width, marker_height), 
	overMarkerSize = new daum.maps.Size(over_marker_width, over_marker_height),
	spriteImageSize = new daum.maps.Size(marker_width, marker_height);

//마커이미지의 주소와, 크기, 옵션으로 마커 이미지를 생성하여 리턴하는 함수입니다
function createMarkerImage(src, size){
	var markerImage = new daum.maps.MarkerImage(src, size);
	return markerImage;
}
	//좌표와 마커이미지를 받아 마커를 생성하여 리턴하는 함수입니다
function createMarker(position, image){
	var marker = new daum.maps.Marker({
		position: position,
		image: image
	});
	return marker;
}


//마커 추가.
function addMarker(position, title, contentid, contenttypeid, mapy, mapx) {     		 
 
   var normalImage = createMarkerImage(sprite_marker_url, markerSize),
       overImage = createMarkerImage(sprite_marker_url, overMarkerSize),
       clickImage = createMarkerImage(click_marker_url, markerSize);
    // 마커를 생성합니다
   var marker = new daum.maps.Marker({
   	contentId: contentid,
       map: map, // 마커를 표시할 지도
       position: position, // 마커를 표시할 위치
       title : title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
       image : normalImage // 마커 이미지
   });
   
   markers.push(marker);
   
	// 마커 객체에 마커아이디와 마커의 기본 이미지를 추가합니다
   marker.normalImage = normalImage;
   
    //마커에 mouseover 이벤트 등록    
    daum.maps.event.addListener(marker, 'mouseover', function(){
    	//클릭된 마커가 없고, mouseover된 마커가 클릭된 마커가 아니면 마커의 이미지를 오버 이미지로 변경
    	if(!selectedMarker || selectedMarker != marker){
    		marker.setImage(overImage);
    	}
    });
    
	// 마커에 mouseout 이벤트를 등록합니다
    daum.maps.event.addListener(marker, 'mouseout', function() {

        // 클릭된 마커가 없고, mouseout된 마커가 클릭된 마커가 아니면 마커의 이미지를 기본 이미지로 변경합니다
        if (!selectedMarker || selectedMarker !== marker) {
            marker.setImage(normalImage);
        }
    });
	
  //선택한 마커를 생성하고 선택마커 배열에 추가하는 함수
    function createArrMarkers(){
    		marker.setImage(clickImage);
    		markersArr.pop();
    		markersArr.push(marker);
    		marker.setMap(map);
    }
   
    //마커 클릭시! 
   daum.maps.event.addListener(marker, 'click', function() {
       // 클릭된 마커가 없고, click 마커가 클릭된 마커가 아니면 마커의 이미지를 클릭 이미지로 변경합니다
       if (!selectedMarker || selectedMarker !== marker) {

           // 클릭된 마커 객체가 null이 아니면 클릭된 마커의 이미지를 기본 이미지로 변경하고
           !!selectedMarker && selectedMarker.setImage(selectedMarker.normalImage);

           // 현재 클릭된 마커의 이미지는 클릭 이미지로 변경합니다
           marker.setImage(clickImage);
       }

       // 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
       selectedMarker = marker;
       contentId = contentid;
       mtitle = title;
       
      createArrMarkers();
      
      $.ajax({        
          url: 'callDetail.do',
          type: 'get',
          data : {"contentId" : contentid, "contentTypeId" : contenttypeid},
          dataType: 'json',
          success: function(data){
               var myItem = data.response.body.items.item;
                  var output = '<div class="pin ' + contentid + '" id="' + contentid + '" text-align:left>';
                  	output += '<h4 id="title">' + title + '</h4>';
                  if(contenttypeid == 12){
 	                    output += '<p class="p" >'+'주차장 : ' + myItem.parking+'</p>';
 	                    output += '<p class="p" >' +'휴무일 : ' + myItem.restdate + '</p>';
 	                    output += '<p class="p" >' +'연락처 : ' + myItem.infocenter + '</p>';
                  }else if(contenttypeid == 14){
 	                    output += '<p class="p" >'+'입장료 : ' + myItem.usefee+'</p>';
 	                    output += '<p class="p" >'+'운영시간 : ' + myItem.usetimeculture+'</p>';
 	                    output += '<p class="p" >' +'휴무일 : ' + myItem.restdateculture + '</p>';
 	                    output += '<p class="p" >' +'연락처 : ' + myItem.infocenterculture + '</p>';
                  }else if(contenttypeid == 15){
 	                    output += '<p class="p" >'+'행사 장소 : ' + myItem.eventplace+'</p>';
 	                    output += '<p class="p" >'+'행사 일정 : ' + myItem.eventstartdate + '~' + myItem.eventenddate +'</p>';
 	                    output += '<p class="p" >' +'행사 시간 : ' + myItem.playtime + '</p>';
 	                    output += '<p class="p" >' +'주최처 : ' + myItem.sponsor1 + " tel) " + myItem.sponsor1tel + '</p>';
                  }else if(contenttypeid == 28){
 	                    output += '<p class="p" >'+'운영시간 : ' + myItem.usetimeleports+'</p>';
 	                    output += '<p class="p" >' +'연락처 : ' + myItem.infocenterleports + '</p>';
                  }else if(contenttypeid == 32){
 	                    output += '<p class="p" >'+'예약 : ' + myItem.reservationurl+'</p>';
 	                    output += '<p class="p" >' +'시설 : ' + myItem.subfacility + '</p>';
 	                    output += '<p class="p" >' +'연락처 : ' + myItem.infocenterlodging + '</p>';
                  }else if(contenttypeid == 38){
 	                    output += '<p class="p" >'+'취급물품 : ' + myItem.saleitem+'</p>';
 	                    output += '<p class="p" >'+'운영시간 : ' + myItem.opentime+'</p>';
 	                    output += '<p class="p" >' +'휴무일 : ' + myItem.restdateshopping + '</p>';
 	                    output += '<p class="p" >' +'연락처 : ' + myItem.infocenter + '</p>';
                  }else if(contenttypeid == 39){
 	                    output += '<p class="p" >'+'메뉴 : ' + myItem.treatmenu+'</p>';
 	                    output += '<p class="p" >'+'운영시간 : ' + myItem.opentimefood+'</p>';
 	                    output += '<p class="p" >' +'휴무일 : ' + myItem.restdatefood + '</p>';
 	                    output += '<p class="p" >' +'연락처 : ' + myItem.infocenterfood + '</p>';
                  }
                  output += '</div>';
                  $('#searchResult').show();
                  $('#searchContent').show();
                  $('#searchContent').html(output);
          },
        error: function(XMLHttpRequest, textStatus, errorThrown) { 
            alert("Status: " + textStatus); alert("Error: " + errorThrown); 
        } 
 	});
   });
   } 
	
	
	function setMarkers(map){
		 $.each(markers,function(i, val){
			 val.setMap(map);
		 })
	 }
	
	function setMarkersArr(map){
		$.each(markersArr,function(i,val){
			val.setMap(map);
		})
	}
	

	
	//스토리 추가 선택 시 스토리 추가하기.
	$('#storyBox').change(function(){
		
		if((this.value)=='스토리추가'){
			var a = prompt('새로운 스토리명을 입력하시오.');
			if(a==false || a==null){
				$('#storyBox').val('스토리선택').prop('selected',true); 
				return false;
				}
			$.ajax({
				url: 'inputStory.do',
				type: 'POST',
				data: {id:id, story_title:a},
				success: function(data){
					//$('#storyBox option:last').before("<option value='"+ data + "'>" + a + "</option>");
					$('#storyBox option:eq(-3)').before("<option value='"+ data + "'>" + a + "</option>");
					$('#storyBox').val(data).prop('selected',true);
					
					//스토리로 글 조회 추가하기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				}
			})
		}else if((this.value)=='스토리삭제'){
			
		}
	})
	
	//저장버튼 클릭시 글 전체와 이미지 저장
	$('#save').click(function(){
		
		var story_seq = $('#storyBox').val();
		var title = $('#title').val();
		var content = $('#content').html();
		
		
		$.ajax({
			url:'inputBoard.do',
			type:'POST',
			data:{story_seq:story_seq, title:title, content:content, writer:id, mtitle:mtitle, contentId:contentId}
				
				//성공시 글 전체 조회.
		})
		
	})
	
	//이미지 클릭시 업로드창 실행
	$('#imageUp').click(function(){
		console.log('fileadd');
		$('input[name="image"]').click();
	})
	
	//업로드 파일체인지가 됐을 경우 실행되는 이벤트
	$('input[name="image"]').change(function(event){
		
		
		var form = $('#imageUpload')[0];
		var formData = new FormData(form);
		var f = $('input[name="image"]')[0].files[0]
		formData.append('file',f);	
		
		
		$.ajax({
			  url: 'uploadAjax.do',
			  data: formData,
			  dataType:'text',
			  processData: false,
			  contentType: false,
			  type: 'POST',
			  success: function(data){
				 // files.push(data);
				  var str ="";

				  
				  console.log(name);
				  //if(checkImageType(name)){
					  str = "<br/><img src='displayFile.do?img_seq="+data+"' style='max-width: 100%; height: auto;'/><br/>";
				  //}
				  
				  $(".uploadedList").append(str);
			  }
			});	
		
		
		
	})
	
	$(".fileDrop").on("dragenter dragover", function(event) {
		event.preventDefault();
	});

	$(".fileDrop").on("drop", function(event){
		event.preventDefault();
		
	
		var fils = event.originalEvent.dataTransfer.files;
		var file = fils[0];		
		var formData = new FormData();		
		formData.append("file", file);
				
		$.ajax({
			  url: 'uploadAjax.do',
			  data: formData,
			  dataType:'text',
			  processData: false,
			  contentType: false,
			  type: 'POST',
			  success: function(data){
				 // files.push(data);
				  var str ="";
				  var name = data.img_name;
				  if(checkImageType(data.getImg_name())){
					  str ="<br/><img src='displayFile.do?img_seq="+data+"'style='max-width: 100%; height: auto;'/><br/>";
				  }
				  
				  $(".uploadedList").append(str);
			  }
			});	
	});

	
	$('#delete').click(function(){
		
		//var delete_confirm = function(){
			if(confirm('현재 작성 중이던 글을 삭제하시겠습니까?')){
				//yes click
				if(board_seq!=null){
					$.ajax({
						url:"deleteBoard.do",
						type:"post",
						data:{board_seq:board_seq}
						//성공시 글 전체 조회.
					})
					}else{
						$('.board').remove();
					}
			}
		//}
		
	})
			
		function checkImageType(fileName){
			var pattern = /jpg|gif|png|jpeg/i;
			return fileName.match(pattern);
		}
	

//})

//엔터로 검색
	function enterkey(){
		if(window.event.keyCode == 13){
			searchMap();
		}
	}

//지도 검색
function searchMap(){
	var keyword = $('#searchMap').val();
	if(keyword == null){
		alert("검색어를 입력하세요.");
		return false;
	}
	if(array!=null){
	setMarkers(null);
	setMarkersArr(map);
	}
	$.ajax({
		url:'search.do',
		type: 'POST',
		data: {keyword:keyword},
		success: function(data){
			console.log(data);
			array = data;
			if(array.length==0){
				alert("검색 결과가 없습니다.");
				
			}
			var bounds = new daum.maps.LatLngBounds();
			
			$.each(array, function(i, val){
				var latlng = new daum.maps.LatLng(val.mapY,val.mapX);
				bounds.extend(latlng);
				addMarker(latlng, val.title, val.contentId, val.contentTypeId, val.mapY, val.mapX);
			})
			map.setBounds(bounds);
		}
	})
}

function setMarkers(map){
	 $.each(markers,function(i, val){
		 val.setMap(map);
	 })
}

function setMarkersArr(map){
	$.each(markersArr,function(i,val){
		val.setMap(map);
	})
}


</script>
</body>
</html>