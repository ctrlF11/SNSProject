<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> -->
<style>

.fileDrop {
	width: 100%;
	height: 50px;
	background: gray;
	border: 1px dotted black;
}

</style>
<script>
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

</script>
</head>
<body>


<div id="modifyForm">
	<div id='save'>저장</div>
	<div class='story'>
		<form class='storyForm'>
			<select name='storyBox' id='storyBox'>
				<option>스토리 선택</option>
				<c:forEach items="${story}" var="story">
					<option value='${story.story_seq}'>${story.story_title}</option>
				</c:forEach>
				<option value="스토리추가">스토리추가</option>
			</select>
		</form>
	</div>
	<hr>
	
	
	<div class='board'>
		<div class="btitle">
			<input type="text" id='title' placeholder='글 제목'/>
		</div>
		<hr>
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


</body>
</html>