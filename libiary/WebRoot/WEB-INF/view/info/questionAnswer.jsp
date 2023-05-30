<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>回答问题</title>
    
    <script type="text/javascript">
	
    	var ue;
    	$(function(){	
    		ue = UE.getEditor('container');
    	});
    

        
        function reserveQuestion(){
        	 $.ajax({
       			url:'${path}/question/updateAnswer.htm',
       			dataType:'json',
       			type:'post',
       			data: $('#fm').serialize(),
       			async:false,
       			success:function(result){
     				if(result.errorMsg){
     					alert(result.errorMsg);
     				}else{
     					alert('回答成功');
     					window.opener=null;window.close();
     				}
       			}
       		});
        }
        
        

    </script>
    </head>
 
 
<body  style="margin:5px">




 <form id="fm" method="post"><br/>
 	<div style="margin-left:7%;width:80%;height:50px;line-height:50px;text-align:left;align:left">
 		<input name="id" value="${question.id }" type="hidden" />
 		标题：${question.title }
 	</div>
 	<br/>
  	<div style="height:200px;margin-top:50px;width:86%;margin-left:7%;border-top:1px solid black"> 
		问题<br/>${question.content }
	</div>	
 	<br/>
 	<div  style="margin-left:7%;width:80%;">
 		<questionel>回答  &nbsp;&nbsp;&nbsp;&nbsp;<button style="width:100px" onclick="reserveQuestion()">保存</button></questionel>
 		<script id="container" name="answer" style="height:300px;margin-top:10px" type="text/plain" />
 	</div>
 
 </form>


</body>
</html>
