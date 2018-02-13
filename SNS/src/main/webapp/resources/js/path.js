



 

  
 //추천경로순으로 뿌리기
 function plusPath(a){
 	var contentid = a.contentId;
 	var contenttypeid = a.contentTypeId;
	 $.ajax({        
         url: 'callDetail.do',
         type: 'get',
         data : {"contentId" : contentid, "contentTypeId" : contenttypeid},
         dataType: 'json',
         success: function(data){
              var myItem = data.response.body.items.item;
                 var output = '<div class="pin ' + contentid + '" id="' + contentid + '" text-align:left>';
                 output += '<h4 id="title"><div class="glyphicon glyphicon-remove" id="d' + contentid + '" onclick="deletePin(this)"></div>' + a.title + '</h4>';
                 output += '</div>';
                 
                 $('#path').append(output);
         },
       error: function(XMLHttpRequest, textStatus, errorThrown) { 
           alert("Status: " + textStatus); alert("Error: " + errorThrown); 
       } 
	});
}
   
 
   //추천경로 구하기
   function getpath(){
		if(arr.length < 3){
			alert("3개 이상의 장소를 입력하시오.");
			return false;
		}
	   //마커 재배치
	   if(array!=null){
			setMarkers(null);
			setMarkersArr(map);
			}
	   $.ajaxSettings.traditional = true;
	   $.ajax({
		   url: 'getpath.do',
		   type: 'POST',
		   data: JSON.stringify(arr),
		   dataType: 'json',
		   contentType: 'application/json',
		   success: function(data){
			   console.log(data);
			   $('#path').empty();
			   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!afterpath
			   //var arra = new Array();
			   //arra = data;
			   afterpath = data;
			   var linePath = [];
			   var bounds = new daum.maps.LatLngBounds();
				   $.each(afterpath, function(i, val){
					   linePath.push(new daum.maps.LatLng(val.mapy, val.mapx));
					   console.log(val);
					   plusPath(val);
					   
					   var latlng = new daum.maps.LatLng(val.mapy,val.mapx);
					   bounds.extend(latlng);
					   addMarker(latlng, val.title, val.contentId, val.contentTypeId, val.mapy, val.mapx);
				   });
				   console.log(linePath);

				   var polyline = new daum.maps.Polyline({
					   path: linePath, // 선을 구성하는 좌표배열 입니다
					   strokeWeight: 5, // 선의 두께 입니다
					   strokeColor: '#FFAE00', // 선의 색깔입니다
					   strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
					   strokeStyle: 'solid' // 선의 스타일입니다
					   });
				   polyline.setMap(null);
				   polyline.setMap(map);
				   map.setBounds(bounds);
				   }
	   });
   }
 
