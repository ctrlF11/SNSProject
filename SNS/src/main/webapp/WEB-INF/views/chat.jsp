<%@page import="com.project.sns.user.vo.UserVO"%>
<%@page import="A.algorithm.AES"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.project.sns.chat.vo.ChatVO"%>
<%@page import="java.util.List"%>
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
<link rel="stylesheet" href="resources/css/message.css?val=1"></link>
<script src="resources/facebook/assets/js/check.js"></script>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">
<% 
String userID = (String) session.getAttribute("id");
AES aes = new AES();
userID = aes.setDecrypting(userID);

//String toID = "456";

%>
/*    $(document).ready(
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
   
      function autoClosingAlert(selector, delay){
      var alert = $(selector).alert();
      alert.show();
      window.setTimeout(function(){alert.hide()}, delay);
   } */
      
      $(document).ready(function(){
         $('.conversation').hide();
      })
   
   
   function submitFunction(){
      var chatContent = $('#chatContent').val();
      if(chatContent == ''){
         alert('내용을 입력하세요.');
         return false;
      }
      $.ajax({
         type:'post',
         url:'chat.do',
         headers:{
            "Content-Type": "application/json",
            "X-HTTP-Method-Override" : "POST"},
            dataType:'text',
            data: JSON.stringify({fromID:fromID, toID:toID, chatContent:chatContent})
      })
      $("#chatContent").val('');
   }
   
   var lastID = 0;
   var fromID = '<%=userID%>';
   var toID = '';
   
   function chatListFunction(data) {
      $.ajax({
         type : "POST",
         url : "chat/list.do",
         data : JSON.stringify({
            fromID : fromID,
            toID : toID,
            chatID : lastID
         }),
         contentType : "application/json; charset=UTF-8",
         success : function(data) {
            getSide();
            if (data == "")
               return;
            console.log("data : " + data);
            for (var i = 0; i < data.length; i++) {
               addChat(data[i].fromID, data[i].chatContent,
                     data[i].chatTime);
               console.log(data[i].fromID);
               console.log(data[i].chatContent);
               console.log(data[i].chatTime);
               lastID = data[i].chatID;
               console.log(lastID);
            }
            //   lastID = Number(data.last);
            //   console.log(data.last.chatID);
            //lastID= NUMBER(parsed.last);
         }
      });
   }
   function addChat(chatName, chatContent, chatTime) {
      if (chatName == fromID) {//내가 보낸 메세지
         $('#chatlist').append(
               '<div class="col-sm-12 message-main-sender">'
                     + '<div class="sender">'
                     + '<div class="message-text">' + chatContent
                     + '</div>'
                     + '<span class="message-time pull-right">'
                     + chatTime + '</span></div></div>')
      } else {//내가 받은 메세지
         $('#chatlist').append(
               '<div class="col-sm-12 message-main-receiver">'
                     + '<div class="receiver">'
                     + '<div class="message-text">' + chatContent
                     + '</div>'
                     + '<span class="message-time pull-right">'
                     + chatTime + '</span></div></div>')
      }
      $('#conversation').scrollTop($('#conversation')[0].scrollHeight);
   }
   function getInfiniteChat() {
      setInterval(function() {
         chatListFunction(lastID);
      }, 30000); //30초에 1번 실행
   }
</script>
<style>
#message {
   margin-top: 65px;
}
</style>
</head>
<body>
   <div class="wrapper">
      <div class="box">
         <div class="row1 row-offcanvas row-offcanvas-left">
            <!--
                  col-sm-12, col-xs-12 둘 다 같은 width 설정 class.
                  col-xs-12는 disable된 상태
                  
                  맨 뒤의 숫자를 변경하면(col-sm-10) 회색 화면의 가로가 줄어들어 
                  백그라운드의 회색 화면이 나타남.                  
                -->
            <div id="main" class="column col-sm-12 col-xs-12" style="overflow-y: auto;">
               <%@ include file="include/topbar.jsp"%>
               <div id="message" class="app">
               <div class="app-one">
                  <div class="col-sm-4 side">
                     <div class="side-one">
                        <div class="row1 heading">
                           <div class="col-sm-3 col-xs-3 heading-avatar">
                              <div class="heading-avatar-icon">
                              <%
                                 UserVO myvo = (UserVO)request.getAttribute("myInfo");
                                 if(myvo.getProfile_img()!=null){
                              %>
                                 <img src="<%=myvo.getProfile_img()%>"/>
                              <%
                                 }else{
                              %>
                                 <img src="https://bootdey.com/img/Content/avatar/avatar1.png">
                                 
                              <%
                                 }
                              %>
                                 <div class="heading-name"><%=myvo.getName()%></div>
                              </div>
                           </div>
<!--                            <div class="col-sm-1 col-xs-1  heading-dot  pull-right">
                              <i class="fa fa-ellipsis-v fa-2x  pull-right"
                                 aria-hidden="true"></i>
                           </div> -->
                            <div class="col-sm-2 col-xs-2 heading-compose  pull-right">
                              <i class="fa fa-comments fa-2x  pull-right" aria-hidden="true"></i>
                           </div> 
                        </div>
<!--                         <div class="row1 searchBox">
                           <div class="col-sm-12 searchBox-inner">
                              <div class="form-group has-feedback">
                                 <input id="searchText" type="text" class="form-control"
                                    name="searchText" placeholder="Search"> <span
                                    class="glyphicon glyphicon-search form-control-feedback"></span>
                              </div>
                           </div>
                        </div> -->
                        <div class="row1 sideBar">
                        <%
                        List<ChatVO> list = (List<ChatVO>)request.getAttribute("chatList");
                        String st = "";
                        List<String> followArr = new ArrayList<String>();
                        for(ChatVO vo : list){
                           String follow = "";
                           if(userID == vo.getFromID()){
                              follow = vo.getFromID();
                           }else{
                              follow = vo.getToID();
                           }
                           if(followArr.indexOf(userID)==-1){
                              followArr.add(follow);
                        %>
                            <div class="row1 sideBar-body" onclick="getNewChat('<%=follow%>')">
                              <div class="col-sm-3 col-xs-3 sideBar-avatar">
                                <div class="avatar-icon">
                                <%
                                if(vo.getPicture()!=null){
                                %>
                                   <img src="<%=vo.getPicture()%>"/>
                                <%
                                }else{
                                %>
                                   <img src="https://bootdey.com/img/Content/avatar/avatar1.png">
                                <%
                                }
                                %>
                                  
                                </div>
                              </div>
                              <div class="col-sm-9 col-xs-9 sideBar-main">
                                <div class="row1">
                                  <div class="col-sm-8 col-xs-8 sideBar-name">
                                    <span class="name-meta"><%=vo.getName()%>
                                  </span>
                                  </div>
                                  <div class="col-sm-4 col-xs-4 pull-right sideBar-time">
                                    <span class="time-meta pull-right"><%=vo.getChatTime()%>
                                  </span>
                                  </div>
                                </div>
                              </div>
                            </div>
                        
                        <%
                           }
                        }
                        %>
                        
                        </div>
                     </div>


                     <div class="side-two">
                        <div class="row1 newMessage-heading">
                           <div class="row1 newMessage-main">
                              <div class="col-sm-2 col-xs-2 newMessage-back">
                                 <i class="fa fa-arrow-left" aria-hidden="true"></i>
                              </div>
                              <div class="col-sm-10 col-xs-10 newMessage-title">New
                                 Chat</div>
                           </div>
                        </div>
<!--                         <div class="row1 composeBox">
                           <div class="col-sm-12 composeBox-inner">
                              <div class="form-group has-feedback">
                                 <input id="composeText" type="text" class="form-control"
                                    name="searchText" placeholder="Search People"> <span
                                    class="glyphicon glyphicon-search form-control-feedback"></span>
                              </div>
                           </div>
                        </div> -->

                        <div class="row1 compose-sideBar">
                           
                        <%
                        List<ChatVO> list2 = (List<ChatVO>)request.getAttribute("chatList");
                        String st2 = "";
                        List<String> followArr2 = new ArrayList<String>();
                        for(ChatVO vo : list2){
                           String follow = "";
                           if(userID == vo.getFromID()){
                              follow = vo.getFromID();
                           }else{
                              follow = vo.getToID();
                           }
                           if(followArr2.indexOf(userID)==-1){
                              followArr2.add(follow);
                        %>
                            <div class="row1 sideBar-body">
                              <div class="col-sm-3 col-xs-3 sideBar-avatar">
                                <div class="avatar-icon">
                                  <img src="https://bootdey.com/img/Content/avatar/avatar1.png">
                                </div>
                              </div>
                              <div class="col-sm-9 col-xs-9 sideBar-main">
                                <div class="row1">
                                  <div class="col-sm-8 col-xs-8 sideBar-name">
                                    <span class="name-meta"><%=follow%>
                                  </span>
                                  </div>
                                  <div class="col-sm-4 col-xs-4 pull-right sideBar-time">
                                    <span class="time-meta pull-right"><%=vo.getChatTime()%>
                                  </span>
                                  </div>
                                </div>
                              </div>
                            </div>
                        
                        <%
                           }
                        }
                        %>
                           
                           </div>
                     </div>
                  </div>

                     <div class="col-sm-8 conversation">
                        <div class="row1 heading">
                           <div class="col-sm-2 col-md-1 col-xs-3 heading-avatar">
                              <div class="heading-avatar-icon">
                                 <!-- 상대방 프로필 이미지 등록.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1 -->
                                 <img src="https://bootdey.com/img/Content/avatar/avatar6.png">
                              </div>
                           </div>
                           <div class="col-sm-8 col-xs-7 heading-name">
                              <!-- 상대방 이름 등록.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
                              <a class="heading-name-meta">John Doe </a> 
                              <span class="heading-online">Online</span>
                           </div>
<!--                            <div class="col-sm-1 col-xs-1  heading-dot pull-right">
                              <i class="fa fa-ellipsis-v fa-2x  pull-right"
                                 aria-hidden="true"></i>
                           </div> -->
                        </div>
                        <div class="row1 message" id="conversation">
                           <div class="row1 message-previous">
                              <div class="col-sm-12 previous">
                                 <a onclick="previous(this)" id="ankitjain28" name="20">
                                    Show Previous Message! </a>
                              </div>
                           </div>
                           <div class="row1 message-body" id="chatlist"></div>
                        </div>
                        <div class="row1 reply">
                           <div class="col-sm-10 col-xs-10 reply-main"> 
                              <input type="text" class="form-control" id="chatContent" onkeydown="enterkey();"
                                 placeholder="메세지를 입력하세요." rows="1"></input>
                           </div>
                           <div class="col-sm-2 col-xs-2 reply-send">
                              <i class="fa fa-send fa-2x" aria-hidden="true"
                                 id="submitMessage"></i>
                           </div>
                        </div>
                     </div>

                  </div>
                  </div>
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
                                             .toggleClass(
                                                   'active');
                                       $('#lg-menu')
                                             .toggleClass(
                                                   'hidden-xs')
                                             .toggleClass(
                                                   'visible-xs');
                                       $('#xs-menu')
                                             .toggleClass(
                                                   'visible-xs')
                                             .toggleClass(
                                                   'hidden-xs');
                                       $('#btnShow').toggle();
                                    });
                     });
         $(document).ready(function() {
            //chatListFunction('ten');
            //getInfiniteChat();
            $('#submitMessage').click(function() {
               submitFunction();
            });
            
             $(".heading-compose").click(function() {
                 $(".side-two").css({
                   "left": "0"
                 });   
               });
               $(".newMessage-back").click(function() {
                 $(".side-two").css({
                   "left": "-100%"
                 });
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
               location.href = "searchAll.do?keyword=" + keyword
                     + "&number=1";
            }
            if (check == "map") {
               location.href = "searchAll.do?keyword=" + keyword
                     + "&number=2";
            }
            if (check == "board") {
               location.href = "searchAll.do?keyword=" + keyword
                     + "&number=3";
            }
            return false;
         }
         
         function enterkey(){
            if(window.event.keyCode == 13){
               submitFunction();
            }
         }
         
         function getNewChat(value){
            toID = value;
            lastID = 0;
            $('#chatlist').html('');
            $('.conversation').show();
            chatListFunction(lastID);
         }
         
         function getSide(){
            $.ajax({
               url:'getNewFollower.do',
               success: function(data){
                  console.log(data);
                  var side = '';
                  
               }
            })
         }
      </script>
</body>
</html>