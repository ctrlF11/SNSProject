<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
					<td align="right" class="bottom"><button id="rBtn">댓글등록</button></td>
				</tr>
			</table>
		</div>
		<div class="card-footer small text-muted">Tell : ${user.regdate}</div>
	</div>
</c:forEach>

<c:forEach var="reply" items="${requestScope.mtitle }">
</c:forEach>

