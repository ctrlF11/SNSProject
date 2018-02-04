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
<!-- <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> -->
<link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<style>
.wrap {
   position: absolute;
   left: 0;
   bottom: 40px;
   width: 288px;
   height: 132px;
   margin-left: -144px;
   text-align: left;
   overflow: hidden;
   font-size: 12px;
   font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
   line-height: 1.5;
}

.wrap * {
   padding: 0;
   margin: 0;
}

.wrap .info {
   width: 286px;
   height: 120px;
   border-radius: 5px;
   border-bottom: 2px solid #ccc;
   border-right: 1px solid #ccc;
   overflow: hidden;
   background: #fff;
}

.wrap .info:nth-child(1) {
   border: 0;
   box-shadow: 0px 1px 2px #888;
}

.info .title {
   padding: 5px 0 0 10px;
   height: 30px;
   background: #eee;
   border-bottom: 1px solid #ddd;
   font-size: 18px;
   font-weight: bold;
}

.info .close {
   position: absolute;
   top: 10px;
   right: 10px;
   color: #888;
   width: 17px;
   height: 17px;
   background:
      url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}

.info .close:hover {
   cursor: pointer;
}

.info .body {
   position: relative;
   overflow: hidden;
}

.info .desc {
   position: relative;
   margin: 13px 0 0 90px;
   height: 75px;
}

.desc .ellipsis {
   overflow: hidden;
   text-overflow: ellipsis;
   white-space: nowrap;
}

.desc .jibun {
   font-size: 11px;
   color: #888;
   margin-top: -2px;
}

.info .img {
   position: absolute;
   top: 6px;
   left: 5px;
   width: 73px;
   height: 71px;
   border: 1px solid #ddd;
   color: #888;
   overflow: hidden;
}

.info:after {
   content: '';
   position: absolute;
   margin-left: -12px;
   left: 50%;
   bottom: 0;
   width: 22px;
   height: 12px;
   background:
      url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.info .link {
   color: #5085BB;
}

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

</style>
<title>Insert title here</title>
<script type="text/javascript">

<%
//임시
 String id = "123asdf";
%>

var id = '<%=id%>';
var files = [];
var blob;

//보드 받아올 때 빼오기. 
var board_seq =3; 



$(function(){
	

	
	//스토리 추가 선택 시 스토리 추가하기.
	$('#storyBox').change(function(){
		
		if((this.value)=='스토리추가'){
			var a = prompt('새로운 스토리명을 입력하시오.');
			
			$.ajax({
				url: 'inputStory.do',
				type: 'POST',
				data: {id:id, story_title:a},
				success: function(data){
					$('#storyBox option:last').before("<option value='"+ data + "'>" + a + "</option>");
					$('#storyBox').val(data).prop('selected',true);		
					
					//스토리로 글 조회.
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

		//임시
		var mtitle = '강남역';
		var contentID = '1231345345';
		
		
		$.ajax({
			url:'inputBoard.do',
			type:'POST',
			data:{story_seq:story_seq, title:title, content:content, writer:id, mtitle:mtitle, contentID:contentID}
				
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
	
})

   $(document).on(function() {
      $(".reply").hide();
   })

</script>
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
               
               <div class="padding">
                  <div class="full col-sm-9" id="full1">
                     <div class="row">                        
                        
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
								<input type="file" name="image" hidden/>
							</form>
							<img src='landscape (1).png' id="imageUp"/>
							<img src='rubbish-bin.png' id='delete'/>
							<img src='placeholder.png' id='relocate'/>
							<div class='fileDrop'></div>
				
						</div>
					</div>
					
					<hr>
				</div>
                           
                        
                        
                        <div class="col-sm-6">
                           <div class="panel panel-default"></div>
                           <div class="panel panel-default">
                              <div id="map" style="width: 40%; height: 100%;"></div>
                              <script type="text/javascript"
                                 src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0"></script>
                              <script>
                                 var mapContainer = document
                                       .getElementById('map'), // 지도의 중심좌표
                                 mapOption = {
                                    center : new daum.maps.LatLng(
                                          33.451475, 126.570528), // 지도의 중심좌표
                                    level : 15
                                 // 지도의 확대 레벨
                                 };
                                 var map = new daum.maps.Map(
                                       mapContainer, mapOption); // 지도를 생성합니다
                              </script>
                           </div>
                        </div>
                     </div>
                  </div>
                  
                  
                  
                  
                  
                  
               </div>
            </div>
         </div>
      </div>
   </div>

					<%@ include file="include/topbar.jsp" %>
					<%@ include file="include/half_map.jsp" %>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	
		$(document).ready(function() {
			$('[data-toggle=offcanvas]').click(function() {
				$(this).toggleClass('visible-xs text-center');
				$(this).find('i').toggleClass('glyphicon-chevron-right glyphicon-chevron-left');
				$('.row-offcanvas').toggleClass('active');
				$('#lg-menu').toggleClass('hidden-xs').toggleClass('visible-xs');
				$('#xs-menu').toggleClass('visible-xs').toggleClass('hidden-xs');
				$('#btnShow').toggle();
			});
        });
		
		function checkgo() {
			var check = document.getElementById("search_category").value;
			var keyword = document.getElementById("srch-term").value;
			alert(check);
			alert(keyword);
			if(keyword == "") {
				alert("키워드를 입력해주세요.");
				return false;
			}			
			if(check == "user") {
				location.href = "searchAll.do?keyword=" + keyword + "&number=1";
			}
			if(check == "map") {
				location.href = "searchAll.do?keyword=" + keyword + "&number=2";
			}
			if(check == "board") {
				location.href = "searchAll.do?keyword=" + keyword + "&number=3";
			}
			return false;
		}
	</script>

</body>
</html>