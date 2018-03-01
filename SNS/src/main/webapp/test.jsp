 
  <head>
    <meta charset="utf-8">
    <title></title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <style media="screen">
      /*
        버튼은 화면 스크롤이 아무리 내려가도 절대위치로 항상 같은 위치에 있도록 하기 위해
        스타일을 지정해 준다.
      */
      #moveBtn{
        position: fixed;
        left: 10px;
        top:10px;
      }
    </style>
  </head>
   
 
    <button type="button" id="moveBtn">이동</button>
 
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
 
    <pre id="preId">
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      글이 무수히 길게 써서 스크롤이 있다고 생각하자...
    </pre>
 
    <script type="text/javascript">
      $(document).ready(function(){
        $("#moveBtn").on("click",function(event){
          // 이동 버튼을 클릭시 pre 태그로 스크롤의 위치가 이동되도록 한다.
 
          // 1. pre태그의 위치를 가지고 있는 객체를 얻어온다. => offset 객체
          var offset = $("#preId").offset();
 
          // offset은 절대 위치를 가져온다. offset.top을 통해 상단의 좌표를 가져온다.
          // position은 부모를 기준으로한 상대위치를 가져온다.
          $("html body").animate({scrollTop:offset.top},2000);
 
        });
      }); // end of ready()
    </script>