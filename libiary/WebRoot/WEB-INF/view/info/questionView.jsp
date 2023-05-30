<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>问答信息</title>
   </head>
 
 
<body  style="margin:5px">
	<br/><br/>
	<div style="margin-left:7%;width:80%;height:50px;line-height:50px;text-align:left;align:left">
	问题标题：${question.title }
	</div>
	<div style="height:300px;margin-top:50px;width:86%;margin-left:7%;border:1px solid black"> 
		提问人：${question.askuser.name }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提问时间：${question.asktime }<br/>
		${question.content }
	</div>
	<div style="height:300px;margin-top:50px;width:86%;margin-left:7%;border:1px solid black"> 
	回答人：${question.answeruser.name }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;回答时间：${question.answertime }<br/>
		${question.answer }
	</div>	

</body>
</html>
