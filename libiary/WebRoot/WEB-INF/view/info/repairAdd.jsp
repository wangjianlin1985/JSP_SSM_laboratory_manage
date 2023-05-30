<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>维护信息</title>
    
    <script type="text/javascript">
	
    var ue;
    $(function(){	
    	 ue = UE.getEditor('container');
    });
    

        function reserveLab(){
        	 $.ajax({
       			url:'${path}/mfr/addRepair.htm',
       			dataType:'json',
       			type:'post',
       			data: $('#fm').serialize(),
       			async:false,
       			success:function(result){
     				if(result.errorMsg){
     					alert(result.errorMsg);
     				}else{
     					alert('添加成功');
     					window.opener=null;window.close();
     				}
       			}
       		});
        }
        
        

    </script>
    </head>
 
 
<body  style="margin:5px">




 <form id="fm" method="post"><br/>
 	<input type="hidden" name="mfr.id" value="${mfrid }" />
 	<br/>
 	<div >
 		<label>维护信息详情  &nbsp;&nbsp;&nbsp;&nbsp;<button style="width:100px" onclick="reserveLab()">保存</button></label>
 		<script id="container" name="remarks" style="height:400px;margin-top:10px" type="text/plain" />
 	</div>
  		
 </form>


</body>
</html>
