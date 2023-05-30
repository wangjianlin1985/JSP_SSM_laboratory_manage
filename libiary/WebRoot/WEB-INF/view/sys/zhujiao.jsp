<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>用户主页</title>
    <script type="text/javascript">
    function searchZhujiao(){
    	$('#dg').datagrid('load', {
    		roleId : $('#s_roleid').val()
		});
    }
   	 	
    function setZhujiao(){
    	var selectedRows = $("#dg").datagrid('getSelections');
    	if (selectedRows.length == 0) {
    		$.messager.alert('系统提示', '请选择要处理的数据！');
    		return;
    	}
    	var strIds = [];
    	for ( var i = 0; i < selectedRows.length; i++) {
    		strIds.push(selectedRows[i].id);
    	}
    	var ids = strIds.join(",");
    	$.messager.confirm("系统提示", "您确认吗？", function(r) {
    		if (r) {
    			$.post("setcancelZhujiao.htm?type=1", {
    				ids : ids
    			}, function(result) {
    				if (result.success) {
    					$.messager.alert('系统提示', "设置成功！");
    					$("#dg").datagrid("reload");
    				} else {
    					$.messager.alert('系统提示', result.errorMsg);
    				}
    			}, "json");
    		}
    	});
    }
    
    
    function cancelZhujiao(){
    	var selectedRows = $("#dg").datagrid('getSelections');
    	if (selectedRows.length == 0) {
    		$.messager.alert('系统提示', '请选择要处理的数据！');
    		return;
    	}
    	var strIds = [];
    	for ( var i = 0; i < selectedRows.length; i++) {
    		strIds.push(selectedRows[i].id);
    	}
    	var ids = strIds.join(",");
    	$.messager.confirm("系统提示", "您确认吗？", function(r) {
    		if (r) {
    			$.post("setcancelZhujiao.htm?type=0", {
    				ids : ids
    			}, function(result) {
    				if (result.success) {
    					$.messager.alert('系统提示', "取消成功！");
    					$("#dg").datagrid("reload");
    				} else {
    					$.messager.alert('系统提示', result.errorMsg);
    				}
    			}, "json");
    		}
    	});
    }
    
    </script>
    </head>
 
 
<body style="margin:1px">

<!-- 加载数据表格 -->
<table  id="dg" class="easyui-datagrid" fitColumns="true"
   				 pagination="true" rownumbers="true" url="zhujiaoList.htm" fit="true" toolbar="#tb">
        <thead>
            	<tr>
            		<th data-options="field:'ck',checkbox:true"></th>
            		<th data-options="fidel:'roleId',hidden:'true'">
                	<th data-options="fidel:'id',hidden:'true'">用户编号</th>
                	<th field="name" width="60" align="center">用户名</th>
                	<th field="password" width="60" align="center">密码</th>
                	<th field="roleName" width="60" align="center">用户角色</th>
                	<th field="description" width="60" align="center">备注</th>
            	</tr>
        </thead>
</table>
    	
<!-- 数据表格上的搜索和添加等操作按钮 -->
<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		<privilege:operation operationId="9f47fac434d4439093d30a528c436c" clazz="easyui-linkbutton" onClick="setZhujiao()" name="设置助教"  iconCls="icon-add" ></privilege:operation>
		<privilege:operation operationId="833e094bd4bc42e190cd29d26f6bf2" clazz="easyui-linkbutton" onClick="cancelZhujiao()" name="取消助教"  iconCls="icon-edit" ></privilege:operation>
	</div>
	<div class="updownInterval"> </div>
</div>


</body>
</html>
