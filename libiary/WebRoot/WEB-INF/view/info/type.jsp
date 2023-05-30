<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>设备类型主页</title>
    
    <style type="text/css">
    	.datagrid-row-selected {
    		background:white;
    	}
    </style>
    
    <script type="text/javascript">

		var urlx = "";
		// 打开新增通知信息对话框
        function openTypeAddDialog(){
			urlx = "reserveType.htm";
        	$("#dlg").dialog("open").dialog("setTitle", "添加");
        }

		// 打开修改通知信息对话框
        function openTypeUpdateDialog(){
    		var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length!=1){
    			$.messager.alert('系统提示','请选择一条要编辑的数据！');
    			return;
    		}
    		var row=selectedRows[0];
    		$("#fm").form("load", row);
    		urlx = "reserveType.htm?id=" + row.id;
    		$("#dlg").dialog("open").dialog("setTitle", "修改");
    	}

		
		

        function closeTypeDialog(){
        	$("#fm").form('clear');
        	$("#dlg").dialog("close");
        }


        function reserveType(){
        	$("#fm").form("submit",
        			{
        				url : urlx,
        				onSubmit : function() {
        					return $(this).form("validate");
        				},
        				success : function(result) {
        					var result = eval('(' + result + ')');
        					if (result.errorMsg) {
        						$.messager.alert('系统提示', "<font color=red>"+ result.errorMsg + "</font>");
        						return;
        					} else {
        						$.messager.alert('系统提示', '保存成功');
        						closeTypeDialog();
        						$("#dg").datagrid("reload");
        					}
        				}
        	});
        }

		
		
		function deleteType(){
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
    				$.post("deleteType.htm",{ids:ids},function(result){
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
   				 pagination="true" rownumbers="true" url="list.htm" fit="true" toolbar="#tb">
        <thead>
            	<tr>
            		<th data-options="field:'ck',checkbox:true"></th>
                	<th data-options="field:'id',width:80,hidden:'true'" align="center">编号</th>
                	<th field="name" width="60" align="center"    >名称</th>
            	</tr>
        </thead>
</table>
<!-- 数据表格上的搜索和添加等操作按钮 -->
<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		<privilege:operation operationId="867680786c01456f80b4d57e8d03c4" clazz="easyui-linkbutton" onClick="openTypeAddDialog()" name="添加"  iconCls="icon-add" ></privilege:operation>
		<privilege:operation operationId="5673710690c8427cbf7050cc7c3b55" clazz="easyui-linkbutton" onClick="openTypeUpdateDialog()" name="修改"  iconCls="icon-edit" ></privilege:operation>
		<privilege:operation operationId="d07801335eae462fafa9ad3e517e24" clazz="easyui-linkbutton" onClick="deleteType()" name="删除"  iconCls="icon-remove" ></privilege:operation>
	</div>
	<div class="updownInterval"> </div>
</div>




<!-- 新增和修改对话框 -->
<div id="dlg" class="easyui-dialog" style="text-align:right;width: 320px;height: 220px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">
 <form id="fm" method="post" enctype="multipart/form-data" >
 	<table cellspacing="5px;">
  		<tr>
  			<td>名称：</td>
  			<td><input type="text" id="name" name="name" class="easyui-validatebox" required="true"/></td>
  		</tr>
  	</table>
 </form>
</div>
<div id="dlg-buttons" style="text-align:center">
	<a href="javascript:reserveType()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeTypeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>




</body>
</html>
