<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>修改问题</title>
    
    <script type="text/javascript">
	
    	var ue;
    	$(function(){	
    		ue = UE.getEditor('container');
    	 	ue.ready(function() {
			    ue.setContent('${question.content}');
		 	});
    	});
    

        
        function reserveQuestion(){
        	 $.ajax({
       			url:'${path}/question/reserveQuestion.htm',
       			dataType:'json',
       			type:'post',
       			data: $('#fm').serialize(),
       			async:false,
       			success:function(result){
     				if(result.errorMsg){
     					alert(result.errorMsg);
     				}else{
     					alert('修改成功');
     					window.opener=null;window.close();
     				}
       			}
       		});
        }
        
        

    </script>
    </head>
 
 
<body  style="margin:5px">




 <form id="fm" method="post"><br/>
 	<div >
 		<questionel>标题</questionel>
 		<input name="id" value="${question.id }" type="hidden" />
 		<input type="text" id="title" name="title" value="${question.title }" class="easyui-validatebox" style="width:300px" required="true"/>
 	</div>
 	<br/>
 	<div >
 		<questionel>内容  &nbsp;&nbsp;&nbsp;&nbsp;<button style="width:100px" onclick="reserveQuestion()">保存</button></questionel>
 		<script id="container" name="content" style="height:400px;margin-top:10px" type="text/plain" />
 	</div>
  		
 </form>


</body>
</html>
