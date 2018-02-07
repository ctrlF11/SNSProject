<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.project.sns.board.vo.BoardVO"%>
<%@ page import="java.util.*"%>
		<style>
div.img {
	border: 1px solid #ccc;
}

div.img:hover {
	border: 1px solid #777;
}

div.img img {
	width: 100%;
	height: auto;
}

div.desc {
	padding: 15px;
	text-align: center;
}

* {
	box-sizing: border-box;
}

.responsive {
	padding: 0 6px;
	float: left;
	width: 24.99999%;
}

@media only screen and (max-width: 700px) {
	.responsive {
		width: 49.99999%;
		margin: 6px 0;
	}
}

@media only screen and (max-width: 400px) {
	.responsive {
		width: 100%;
	}
}
.clearfix:after {
	content: "";
	clear: both;
}
</style>
<link href="resources/vendor/font-awesome/css/font-awesome.min.css"
   rel="stylesheet" type="text/css">
<meta name="viewport"
   content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet"
   href="resources/facebook/assets/css/bootstrap2.css">
<link rel="stylesheet"
   href="resources/facebook/assets/css/facebook2.css">
<c:forEach var="mainTable" items="${requestScope.mainTable}">
		<hr class="my-0">
		<div class="card-body small bg-faded"></div>

		<h3 style="text-align: center">빈센트 반 고흐 갤러리</h3>
		<div class="responsive">
			<div class="img">
				<a target="_blank"
					href="/sns/homeview.do?story_seq=${mainTable.story_seq}">
					<img
					src="${mainTable.firstimage }"
					alt="Wheatfield with Crows" width="473" height="269">
				</a>
				<div class="desc">
					Wheatfield with Crows, c.1890 <br /> ${mainTable.content}
				</div>
			</div>
		</div>
		<div class="responsive">
			<div class="img">
				<a target="_blank"
					href="http://cache2.allpostersimages.com/p/LRG/39/3996/FK7WF00Z/posters/vincent-van-gogh-starry-night-c-1889.jpg">
					<img
					src="http://cache2.allpostersimages.com/p/LRG/39/3996/FK7WF00Z/posters/vincent-van-gogh-starry-night-c-1889.jpg"
					alt="Starry Night" width="400" height="301">
				</a>
				<div class="desc">
					Starry Night, c.1889 <br /> 빈센트 반 고흐
				</div>
			</div>
		</div>
		<div class="responsive">
			<div class="img">
				<a target="_blank"
					href="http://imgc.allpostersimages.com/images/P-473-488-90/27/2744/N2BTD00Z/posters/vincent-van-gogh-the-bedroom-at-arles-c-1887.jpg">
					<img
					src="http://imgc.allpostersimages.com/images/P-473-488-90/27/2744/N2BTD00Z/posters/vincent-van-gogh-the-bedroom-at-arles-c-1887.jpg"
					alt="The Bedroom at Arles" width="473" height="355">
				</a>
				<div class="desc">
					The Bedroom at Arles, c.1887 <br /> 빈센트 반 고흐
				</div>
			</div>
		</div>
		<div class="responsive">
			<div class="img">
				<a target="_blank"
					href="http://imgc.allpostersimages.com/images/P-473-488-90/64/6409/76Z9100Z/posters/vincent-van-gogh-the-mulberry-tree-c-1889.jpg">
					<img
					src="http://imgc.allpostersimages.com/images/P-473-488-90/64/6409/76Z9100Z/posters/vincent-van-gogh-the-mulberry-tree-c-1889.jpg"
					alt="The Mulberry Tree" width="473" height="405">
				</a>
				<div class="desc">
					The Mulberry Tree, <br /> c. 1889 <br /> 빈센트 반 고흐
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
</c:forEach>


