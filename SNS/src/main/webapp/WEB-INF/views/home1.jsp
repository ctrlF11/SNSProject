<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet"
	href="resources/facebook/assets/css/bootstrap2.css">
<link rel="stylesheet"
	href="resources/facebook/assets/css/facebook2.css">
<link rel="stylesheet" href="resources/facebook/assets/css/original.css">
<script src="resources/facebook/assets/js/check.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
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
						
})

var scollB = function(){
		$.ajax({
			url : 'getBoardList.do',
			data : {
				index : index,
				story_seq :
<%=request.getAttribute("story_seq")%>
	},
			success : function(data) {
				$("#col-sm-6").append(data);
			}
		})

}

var index = 0;
function togglethis(num) {
		var replyDiv = document.getElementById("replyDiv" + num);
		if (replyDiv.style.display == "none") {
			replyDiv.style.display = "block";
		} else {
			replyDiv.style.display = "none";
		}
}

$(function(){
	 	scollB();
		$("#main").scroll(function() {
			var sh = $("#main").scrollTop() + $("#main").height();
			var dh = $("#main").prop("scrollHeight");

			if (sh == dh) {
				index += 4;
				$.ajax({
					url : 'getBoardList.do',
					data : {
						index : index,
						story_seq :
<%=request.getAttribute("story_seq")%>
	},
					success : function(data) {
						$("#col-sm-6").append(data);
					}
				})
			}
		})

}); //게시판 스크롤 비동기

	
function r_button(){ //댓글 등록 버튼 클릭시 
var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
		$.ajax({
					url : 'insert.do',
					type : 'get',
					data : {
						board_seq : $('[name=board_seq]').val(),
						rcontent : $('[name=content]').val(),
						story_seq : $('[name=story_seq]').val()
					},
					success : function(data) {
						if (data == 1) {
							replyList();
							$('[name=content]').val('');
						}
					} //Insert 함수호출(아래)
				});

}
function replyList(){//댓글 비동기 불러올 때 
 	 $.ajax({
	        url : 'list.do',
	        type : 'get',
	        data : {
		        	'board_seq': $('[name=board_seq]').val(),
		        	'story_seq' : $('[name=story_seq]').val()	
	        },
	        success : function(data){
	            var a =''; 
	            $.each(data, function(key, value){ 
	                a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
	                a += '<div class="commentInfo'+value.reply_seq+'">'+'댓글번호 : '+value.reply_seq+' / 작성자 : '+value.rwriter;
	                a += '<button onclick="replyUpdate('+value.reply_seq+',\''+value.rcontent+'\');"> 수정 </button>';
	                a += '<button onclick="replyDelete('+value.reply_seq+');"> 삭제 </button> </div>';
	                a += '<div class="commentContent'+value.reply_seq+'"> <p> 내용 : '+value.rcontent +'</p>';
	                a += '</div></div>';
	            });
	            
	            $("[name=commentList]").html(a);
	        }
	    });
}

//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
function replyUpdate(reply_seq, rcontent) {
	var a = '';

	a += '<div class="input-group">';
	a += '<input type="text" class="form-control" name="content_'+reply_seq+'" value="'+rcontent+'"/>';
	a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="replyUpdateProc('
			+ reply_seq + ');">수정</button> </span>';
	a += '</div>';

	$('.commentContent' + reply_seq).html(a);

}

//댓글 수정
function replyUpdateProc(reply_seq) {
	var updateContent = $('[name=content_' + reply_seq + ']').val();
	
	$.ajax({
		url : 'update.do',
		type : 'post',
		data : {
			'rcontent' : $('[name=content_' + reply_seq + ']').val(),
			'reply_seq' : reply_seq,
			'board_seq' : $('[name=board_seq]').val(),
			'story_seq' : $('[name=story_seq]').val()
		},
		success : function(data) {
			
			if (data == 1){
				alert("수정완료");
				replyList();//댓글 수정후 목록 출력 
			}	
		}
	});
}
//댓글 삭제 
function replyDelete(reply_seq){
    $.ajax({
        url : 'delete.do',
        type : 'post',
		data : {
			'reply_seq' : reply_seq,
			'board_seq' : $('[name=board_seq]').val(),
			'story_seq' : $('[name=story_seq]').val()
		}, 
        success : function(data){
            if(data == 1) replyList(); //댓글 삭제후 목록 출력 
        }
    });
}
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
						<li><a href="#" data-toggle="offcanvas"
							class="visible-xs text-center"><i
								class="glyphicon glyphicon-chevron-right"></i></a></li>
					</ul>

					<ul class="nav hidden-xs" id="lg-menu">
						<li class="active"><a href="#featured"><i
								class="glyphicon glyphicon-list-alt"></i> Featured</a></li>
						<li><a href="#stories"><i
								class="glyphicon glyphicon-list"></i> Stories</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-paperclip"></i>
								Saved</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-refresh"></i>
								Refresh</a></li>
					</ul>
					<ul class="list-unstyled hidden-xs" id="sidebar-footer">
						<li><a href="http://usebootstrap.com/theme/facebook"><h3>Bootstrap</h3>
								<i class="glyphicon glyphicon-heart-empty"></i> Bootply</a></li>
					</ul>

					<ul class="nav visible-xs" id="xs-menu">
						<li><a href="#featured" class="text-center"><i
								class="glyphicon glyphicon-list-alt"></i></a></li>
						<li><a href="#stories" class="text-center"><i
								class="glyphicon glyphicon-list"></i></a></li>
						<li><a href="#" class="text-center"><i
								class="glyphicon glyphicon-paperclip"></i></a></li>
						<li><a href="#" class="text-center"><i
								class="glyphicon glyphicon-refresh"></i></a></li>
					</ul>

				</div>
				<!--
                  col-sm-12, col-xs-12 둘 다 같은 width 설정 class.
                  col-xs-12는 disable된 상태
                  
                  맨 뒤의 숫자를 변경하면(col-sm-10) 회색 화면의 가로가 줄어들어 
                  백그라운드의 회색 화면이 나타남.                  
                -->
				<div id="main" class="column col-sm-10 col-xs-11"
					style="overflow-y: auto;">
					<!-- 
                  Topbar. 기존 부트스트랩보다 height를 늘림.
                -->
					<%@ include file="include/topbar.jsp"%>
					<%@ include file="include/half_map.jsp"%>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('[data-toggle=offcanvas]')
									.click(
											function() {
												$(this)
														.toggleClass(
																'visible-xs text-center');
												$(this)
														.find('i')
														.toggleClass(
																'glyphicon-chevron-right glyphicon-chevron-left');
												$('.row-offcanvas')
														.toggleClass('active');
												$('#lg-menu').toggleClass(
														'hidden-xs')
														.toggleClass(
																'visible-xs');
												$('#xs-menu').toggleClass(
														'visible-xs')
														.toggleClass(
																'hidden-xs');
												$('#btnShow').toggle();
											});
						});
		function checkgo() {
			var check = document.getElementById("search_category").value;
			var keyword = document.getElementById("srch-term").value;
			alert(check);
			alert(keyword);
			if (keyword == "") {
				alert("키워드를 입력해주세요.");
				return false;
			}
			if (check == "user") {
				location.href = "searchAll.do?keyword=" + keyword + "&number=1";
			}
			if (check == "map") {
				location.href = "searchAll.do?keyword=" + keyword + "&number=2";
			}
			if (check == "board") {
				location.href = "searchAll.do?keyword=" + keyword + "&number=3";
			}
			return false;
		}
	</script>
</body>
</html>

