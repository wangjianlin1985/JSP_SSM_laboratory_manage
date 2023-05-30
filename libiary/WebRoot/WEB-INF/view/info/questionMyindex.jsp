<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>布主页</title>
    
    <style type="text/css">
    	.datagrid-row-selected {
    		background:white;
    	}
    </style>
    
    <script type="text/javascript">
		var url;
		// 条件搜索通知信息
		function searchQuestion(){
    		$('#dg').datagrid('load',{
    			title:$("#s_title").val()
    		});
        }

		// 打开
        function openQuestionAddDialog(){
			window.open("${path}/question/toAdd.htm");
        }

		// 打开修改通知信息对话框
        function openQuestionUpdateDialog(){
    		var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length!=1){
    			$.messager.alert('系统提示','请选择一条要编辑的数据！');
    			return;
    		}
    		var row=selectedRows[0];
    		window.open("${path}/question/toUpdate.htm?id="+row.id);
    	}

		
		

		
		
		function deleteQuestion(){
			var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length == 0){
    			$.messager.alert('系统提示','请选择一条要编辑的数据！');
    			return;
    		}
    		var strIds=[];
    		for(var i=0;i<selectedRows.length;i++){
    			strIds.push(selectedRows[i].id);
    		}
    		var ids=strIds.join(","); 
    		$.messager.confirm("系统提示","您确认要删除这些数据吗？",function(r){
    			if(r){
    				$.post("deleteQuestion.htm",{ids:ids},function(result){
    					if(result.success){
    						$.messager.alert('系统提示',"您已成功删除数据！");
    						$("#dg").datagrid("reload");
    					}else{
    						$.messager.alert('系统提示',result.errorMsg);
    					}
    				},"json");
    			}
    		});
    		
		}
		
		
	
		
		
    </script>
    </head>
 
 
<body  style="margin:1px">


<!-- 加载数据表格 -->
<table  id="dg" class="easyui-datagrid" fitColumns="true"
   				 pagination="true" rownumbers="true" url="list.htm?userid=${currentUser.id }" fit="true" toolbar="#tb">
        <thead>
            	<tr>
            		<th data-options="field:'ck',checkbox:true"></th>
                	<th data-options="field:'id',width:80,hidden:'true'" align="center">编号</th>
                	<th field="title" width="60" align="center"   formatter="formatTitle" >标题</th>
                	<th field="asktime" width="60" align="center">提问时间</th>
                	<th field="status" width="60" align="center" formatter="formatStatus">状态</th>
            	</tr>
        </thead>
        <script>
        	function formatTitle(value,row,index){
        		return "<a javascript:void(0) onclick='openQuestion(\""+row.id+"\")'>"+value+"</a>";
        	}
        	
        	
        	function openQuestion(id){
        		window.open("findOne.htm?id="+id);
        	}
        	
        	function formatStatus(value,row,index){
        		if(row.status=="1"){
        			return "已回答";
        		} else {
        			return "未回答";
        		}
        		
        	}
        	
        	
        </script>
</table>
<!-- 数据表格上的搜索和添加等操作按钮 -->
<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		<privilege:operation operationId="698649f24d7940aeaa66877a72609b" clazz="easyui-linkbutton" onClick="openQuestionAddDialog()" name="提问"  iconCls="icon-add" ></privilege:operation>
		<privilege:operation operationId="d9fdad817ce742338df528624eccf4" clazz="easyui-linkbutton" onClick="openQuestionUpdateDialog()" name="修改"  iconCls="icon-edit" ></privilege:operation>
		<privilege:operation operationId="103d173ba45c4632ac574777dfc43f" clazz="easyui-linkbutton" onClick="deleteQuestion()" name="删除"  iconCls="icon-remove" ></privilege:operation>
	</div>
	<div class="updownInterval"> </div>
	<div>
		&nbsp;关键字：&nbsp;<input type="text" name="s_title" id="s_title" size="20" onkeydown="if(event.keyCode==13) searchQuestion()"/>
		<a href="javascript:searchQuestion()" class="easyui-linkbutton" iconCls="icon-search" >搜索</a>
	</div>
	<div class="updownInterval"> </div>
</div>











</body>
</html>
