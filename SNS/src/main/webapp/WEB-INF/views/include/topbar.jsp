<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta name="viewport"
   content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet"
   href="resources/facebook/assets/css/bootstrap2.css?val=2">
<link rel="stylesheet"
   href="resources/facebook/assets/css/facebook2.css?val=2">
<script type="text/javascript" src="resources/facebook/assets/js/jquery.js"></script>
<script type="text/javascript" src="resources/facebook/assets/js/bootstrap.js"></script>

</head>
<body>
               <div class="navbar navbar-blue navbar-static-top">
                  <!-- 
                     아이콘 영역. 기존 부트스트랩보다 margin-top을 늘림.
                   -->
                  <nav class="navbar-collapse" role="navigation">
                     <div class="main_icon">
                        <a href="mainHomeView.do"><img src="문민웅-메인페이지_02.jpg"></img></a>
                     </div>
                     <!-- 검색 폼. -->
                     <div class="search_wrap" id="search_wrap">
                        <form class="navbar-form navbar-left" method="post" onsubmit="return checkgo();" id="searchForm">
                           <div class="input-group input-group-sm">
                              <select id="search_category" style="height: 32px; margin-right:10px;">
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
                           <%
                              if(session.getAttribute("id") == null) {
                                 %>
                                    <a href="login.do"><img src="login.jpg"></img></a>
                                 <%
                              }
                              else {
                                 %>
                                    <a href="logout.do">로그아웃</a>
                                 <%
                              }
                           %>
                           </li>
                           <li>
                              <a href="newMap.do"><img src="path.jpg" role="button"></a>
                              </img>
                           </li>
                           <li>
                              <a href="#">스토리</a>
                           </li>
                           <li>
                              <a href="message.do" role="button">메세지</a>
                           </li>
                           <li>
                              <a href="modifyBoard.do"><img src="write.jpg" onclick="message.do"></img></a>
                           </li>
                           <!-- 드롭다운(클릭하면 밑으로 튀어나오는 메뉴) -->
                           <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                              <img src="mypage.jpg"></img></a>
                           <ul class="dropdown-menu">
                             <li><a href="myPage.do">마이페이지</a></li>
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
</body>
</html>