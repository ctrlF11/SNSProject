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
<c:forEach var="mainTable" items="${requestScope.mainTable}">
	<div class="panel panel-default">
		<a href="/sns/homeview.do?story_seq=${mainTable.story_seq}"> <img class="card-img-top img-fluid w-100"
			src="resources/facebook/assets/img/uFp_tsTJboUY7kue5XAsGAs28.png"
			alt="">
		</a>
		<div class="card-body">
			<h6 class="card-title mb-1">
				<a
					href="getBoardValue.do?story_seq=${mainTable.story_seq }&writer=${mainTable.writer}"><img
					src="${mainTable.firstimage }"></a>
			</h6>
			<p class="card-text small">${mainTable.content}
				<a href="#">#workinghardorhardlyworking</a>
			</p>
		</div>
		<hr class="my-0">
		<div class="card-body py-2 small">
			<a class="mr-3 d-inline-block" href="#">
				<i class="fa fa-fw fa-thumbs-up"></i>Like
			</a>
			<a class="mr-3 d-inline-block" href="#" name="comment">
				<i class="fa fa-fw fa-comment"></i>Comment
			</a>
			<a class="d-inline-block" href="#">
				<i class="fa fa-fw fa-share"></i>Share
			</a>
		</div>
		<hr class="my-0">
		<div class="card-body small bg-faded"></div>
		<div id="replyDiv${user.board_seq }" class="reply" style="display: block;">
				<table>
					<tr>
						<td class="header" width="370">댓글</td>
					</tr>
					<tr>
						<td>
							<textarea id="rContent" cols="50" rows="2">
							</textarea>
							<div id="cmsg">
							</div>
						</td>
						<td align="right" class="bottom">
							<button class="rBtn">댓글등록</button>
						</td>
					</tr>
				</table>
			</div>
</c:forEach>



