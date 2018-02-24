<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.project.sns.board.vo.BoardVO"%>
<%@ page import="java.util.*"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<head>
<link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<style>
*{ margin: 0; padding: 0;}
body { width: 500px; margin: 30px auto;}
.tit { padding: 10px; font-weight: bold;}
.accodian {list-style: none }
.accodian--box { margin-bottom: 5px;}
.accodian--box h3 { background: #333; padding: 5px; color: #fff;cursor: pointer}
.accodian--box div { background: #ccc; padding: 5px; display: none; }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="resources/facebook/assets/css/bootstrap2.css">
<link rel="stylesheet" href="resources/facebook/assets/css/facebook2.css">
<link rel="stylesheet" href="resources/facebook/assets/css/original.css">
<script src="resources/facebook/assets/js/check.js"></script>
<script src="js/home1.js" type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">
var index = 0;
$(function(){
      index = 0;
      var story_seq = 10;
      getBoard(story_seq);
      $("#main").scroll(function() {
         var sh = $("#main").scrollTop() + $("#main").height();
         var dh = $("#main").prop("scrollHeight");
      
         if (sh == dh) {   
            alert("만난다");
            getBoardScroll(story_seq);
         }
        })
   
     
 $('[data-toggle=offcanvas]').click(function() {
               $(this).toggleClass('visible-xs text-center');
               $(this).find('i').toggleClass('glyphicon-chevron-right glyphicon-chevron-left');
               $('.row-offcanvas').toggleClass('active');
               $('#lg-menu').toggleClass('hidden-xs').toggleClass('visible-xs');
               $('#xs-menu').toggleClass('visible-xs').toggleClass('hidden-xs');
               $('#btnShow').toggle();
  });   
   
}); //게시판 스크롤 비동기 클릭 토글
function togglethis(num) {
      var replyDiv = document.getElementById("replyDiv" + num);
      if (replyDiv.style.display == "none") {
         replyDiv.style.display = "block";
      } else {
         replyDiv.style.display = "none";
      }
}
function getBoardScroll(story)
{
   alert("스크롤 인덱스:"+index);
   alert("만나서 실행");
   index += 4;
   $.ajax({
      url : 'getBoardList.do',
      data : {
             index : index,
             story_seq : story
               },
      success : function(data){
         alert("만나서 실행 성공");
         $("#col-sm-6").append(data);
      }
   })
}

function getBoard(story_seq){
   index = 0;
   $.ajax({
      url : 'getBoardList.do',
      data : {
               index : index,
               story_seq : story_seq
               },
      success : function(data) {
         $("#col-sm-6").append(data);
         alert("비동기 진입전");
          getStory(story_seq);
      }
   })

}

function getStory()
{

    $.ajax({
      url : 'getBoardStoryList.do',
      data:{
           boardUser : $('#boardUser').val()
       },
       success : function(data){
         var b ='';
         var title = '';
      
            $.each(data, function(key, value){
               if(key==0){
                 title = value.story_title;
                   b += '<ul class="accodian">';
                   b += '<ul class="accodian">';
                   b += '<input type ="hidden" value ="'+value.story_seq+'" name = "storyHidden">';
                   b += '<h3 onclick = "story_button('+value.story_seq+')"><a href = "#">#'+title+'</a></h3>';
                   b += '</ul>';
                   b += '</ul>';
               }
               
                  if(key >= 1){
                  

                  if(title == value.story_title){
                     return true;
                  }else{
                     title = value.story_title;
                       b += '<ul class="accodian">';
                       b += '<ul class="accodian">';
                       b += '<input type ="hidden" value ="'+value.story_seq+'" name = "storyHidden">';
                       b += '<h3 onclick = "story_button('+value.story_seq+')"><a href = "#">#'+title+'</a></h3>';
                       b += '</ul>';
                       b += '</ul>';
                  }

               }
           });
         
              $("[name=story]").html(b); 
    }
})
}

function story_button(story)
{
       alert(story);
         index = 0;
         alert("index ="+index);
       $.ajax({
         url : 'getBoardList.do',
         data : {
                  index : index,
                  story_seq : story
                  },
         success : function(data) {
            $("#col-sm-6").html(data);
            getStory();
         }
      })
         alert("바뀌어서 만낫다");
         getBoardScroll(story);
   
}

function r_button(board_seq,story_seq){ //댓글 등록 버튼 클릭시 
var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
      $.ajax({
               url : 'insert.do',
               type : 'get',
               data : {
                  board_seq : board_seq,
                  rcontent : $('[name=content'+board_seq+']').val(),
                  story_seq : story_seq
               },
               success : function(data) {
                  if (data == 1) {
                     replyList(board_seq,story_seq);
                     $('[name=content'+board_seq+']').val('');
                  }
               } //Insert 함수호출(아래)
            });
}

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
                   a += '<div class="commentInfo'+value.reply_seq+'">'+'댓글번호 : '+value.reply_seq+' / 작성자 : '+value.rwriter;
                   a += '<button onclick="replyUpdate('+value.reply_seq+ ',\'' +value.rcontent+ '\',' +value.board_seq+ ',' +value.story_seq+');"> 수정 </button>';
                   a += '<button onclick="replyDelete('+value.reply_seq+','+value.board_seq+ ',' +value.story_seq+ ');"> 삭제 </button> </div>';
                   a += '<div class="commentContent'+value.reply_seq+'"> <p> 내용 : '+value.rcontent +'</p>';
                   a += '</div></div>';
                   $('[name=commentList'+board_seq+']').html(a);
               });
               
               
           }
       });
} 
//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
function replyUpdate(reply_seq, rcontent, board_seq, story_seq){
      var a = '';
      a += '<div class="input-group">';
      a += '<input type="text" class="form-control" name="content_'+reply_seq+'" value="'+rcontent+'"/>';
      a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="replyUpdateProc('
            + reply_seq +","+board_seq+","+story_seq+ ');">수정</button> </span>';
      a += '</div>'; 
     $('.commentContent' + reply_seq).html(a);
}
//댓글 수정
function replyUpdateProc(reply_seq,board_seq,story_seq) {
   var updateContent = $('[name=content_' + reply_seq + ']').val();

   $.ajax({
      url : 'update.do',
      type : 'post',
      data : {
         'rcontent' : $('[name=content_' + reply_seq + ']').val(),
         'reply_seq' : reply_seq,
         'board_seq' : board_seq,
         'story_seq' : story_seq
      },
      success : function(data) {
         
         if (data == 1){
            replyList(board_seq,story_seq);//댓글 수정후 목록 출력 
         }   
      }
   });
}
//댓글 삭제 

function replyDelete(reply_seq,board_seq,story_seq){
    $.ajax({
        url : 'delete.do',
        type : 'post',
      data : {
         'reply_seq' : reply_seq,
         'board_seq' : board_seq,
         'story_seq' : story_seq
      }, 
        success : function(data){
            if(data == 1) replyList(board_seq,story_seq); //댓글 삭제후 목록 출력 
        }
    });
}
//좋아요
function like_button(board_seq,story_seq)
{
       alert("좋아요 버튼 눌림");
       $.ajax({
         url : 'likeUp.do',
         data : {
                  board_seq : board_seq,
                  story_seq : story_seq
                  },
         success : function(data) {
            alert("좋아요 눌리고 나서 업데이트 된 수 :" + data);
               var a = '';
               a += '<i class="fa fa-fw fa-thumbs-up"></i>'+data+'명 Like';
               $('[name=like'+board_seq+']').html(a);
               
         }
      })
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
              
            
            <div id="main" style="overflow-y: auto;" class="column col-sm-12 col-xs-12">
               <div class="column col-sm-2 col-xs-1 sidebar-offcanvas" id="sidebar" name="story" style="position: fixed;"><ul class="accodian"><ul class="accodian"><input value="39" name="storyHidden" type="hidden"><h3 onclick="story_button(39)"><a href="#">#asdasdas</a></h3></ul></ul><ul class="accodian"><ul class="accodian"><input value="7" name="storyHidden" type="hidden"><h3 onclick="story_button(7)"><a href="#">#ㅁㄴㅇㄹ</a></h3></ul></ul><ul class="accodian"><ul class="accodian"><input value="1" name="storyHidden" type="hidden"><h3 onclick="story_button(1)"><a href="#">#강남역 맛집</a></h3></ul></ul><ul class="accodian"><ul class="accodian"><input value="5" name="storyHidden" type="hidden"><h3 onclick="story_button(5)"><a href="#">#고고고</a></h3></ul></ul><ul class="accodian"><ul class="accodian"><input value="10" name="storyHidden" type="hidden"><h3 onclick="story_button(10)"><a href="#">#동대문</a></h3></ul></ul><ul class="accodian"><ul class="accodian"><input value="37" name="storyHidden" type="hidden"><h3 onclick="story_button(37)"><a href="#">#민웅스 스퇼</a></h3></ul></ul><ul class="accodian"><ul class="accodian"><input value="6" name="storyHidden" type="hidden"><h3 onclick="story_button(6)"><a href="#">#오오오오오</a></h3></ul></ul><ul class="accodian"><ul class="accodian"><input value="2" name="storyHidden" type="hidden"><h3 onclick="story_button(2)"><a href="#">#제주도 여행</a></h3></ul></ul><ul class="accodian"><ul class="accodian"><input value="36" name="storyHidden" type="hidden"><h3 onclick="story_button(36)"><a href="#">#지니지니</a></h3></ul></ul></div><!-- 
                  Topbar. 기존 부트스트랩보다 height를 늘림.
                -->
  				<%@ include file="include/topbar.jsp" %>             
  				<div class="padding">
	<div class="full col-sm-10" id="full1" style="float: right;">
		<div class="row">
			<div class="col-sm-6" id="col-sm-6">
				<!-- ê¸ ìì­ -->
			</div>
			<div class="col-sm-6">
				<div id="map" style="width: 40%; height: 100%;"></div>
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1993b1e3b0175008e57aef80bfdd05b0"></script>
					<script>
					
					</script>
				</div>
			</div>
		</div>
</div>

            </div>
         </div>
      </div>
   </div>

   <script type="text/javascript">
      $(document).ready(function() {$('[data-toggle=offcanvas]').click(function() {
                                    $(this).toggleClass('visible-xs text-center');
                                    $(this).find('i').toggleClass('glyphicon-chevron-right glyphicon-chevron-left');
                                    $('.row-offcanvas').toggleClass('active');
                                    $('#lg-menu').toggleClass('hidden-xs')
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

      var accModule = function(){
           // private member (비공개 멤버, 고유멤버)
           var acc_wrap = $('.accodian'),
             question = acc_wrap.find('h3'),
             answer = question.next('div');

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
   
   </script>



</body>