<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>我的实验申请主页</title>
    
    <style type="text/css">
    	.datagrid-row-selected {
    		background:white;
    	}
    </style>
    
    <script type="text/javascript">

		var urlx;
		// 打开修改通知信息对话框
        function tongyi(){
    		var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length!=1){
    			$.messager.alert('系统提示','请选择一条要审批的数据！');
    			return;
    		}
    		var row=selectedRows[0];
    		if(row.approveresult!='未审批'){
    			$.messager.alert('系统提示','已经审批过的申请不能修改！');
    			return;
    		}
    		urlx = "updateApprove.htm?id="+row.id+"&approveresult=1";
    		shenpi();
    	}

		
        function butongyi(){
    		var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length!=1){
    			$.messager.alert('系统提示','请选择一条要审批的数据！');
    			return;
    		}
    		var row=selectedRows[0];
    		if(row.approveresult!='未审批'){
    			$.messager.alert('系统提示','已经审批过的申请不能修改！');
    			return;
    		}
    		urlx = "updateApprove.htm?id="+row.id+"&approveresult=0";
    		shenpi();
    	}

		
		
		
		
		function shenpi(){
			$.messager.confirm("系统提示","您确认吗？",function(r){
    			if(r){
    				$.post(urlx,{ids:1},function(result){
    					if(result.success){
    						$.messager.alert('系统提示',"操作成功！");
    						$("#dg").datagrid("reload");
    					}else{
    						$.messager.alert('系统提示',result.errorMsg);
    					}
    				},"json");
    			}
    		});
		}
		

        function closeBespokeDialog(){
        	$("#fm").form('clear');
        	$("#dlg").dialog("close");
        }


        function reserveBespoke(){
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
        						closeBespokeDialog();
        						$("#dg").datagrid("reload");
        					}
        				}
        	});
        }

		
		
		function deleteBespoke(){
			var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length == 0){
    			$.messager.alert('系统提示','请选择一条要删除的数据！');
    			return;
    		}
    		var strIds=[];
    		for(var i=0;i<selectedRows.length;i++){
    			strIds.push(selectedRows[i].id);
    		}
    		var ids=strIds.join(","); 
    		$.messager.confirm("系统提示","您确认要删除这些数据吗？",function(r){
    			if(r){
    				$.post("deleteBespoke.htm",{ids:ids},function(result){
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
		
		
	
		function searchBespoke(){
			$('#dg').datagrid('load', {
				keyword : $("#s_keyword").val()
			});
		}
		
		
		function openBespokemfr(){
			var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length!=1){
    			$.messager.alert('系统提示','请选择一条要编辑的数据！');
    			return;
    		}
    		var row=selectedRows[0];
    		$("#fm").form("load", row);
    		$("#mfrDlg").dialog("open").dialog("setTitle", "材料管理");
    		$("#hidden_bespokeid").val(row.id);
    		$('#mfrTable').datagrid({
    			nowrap : false,// 设置为true，当数据长度超出列宽时将会自动截取
    			striped : true,// 设置为true将交替显示行背景。
    			collapsible : true,// 显示可折叠按钮
    			url : "mfrList.htm?bespokeid=" + row.id,// url调用Action方法
    			singleSelect : false,// 为true时只能选择单行
    			fitColumns : true,// 允许表格自动缩放，以适应父容器
    			remoteSort : false,
    			rownumbers : true
    		// 行数
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
                	<th field="userid" width="60" align="center"  formatter="formatUser" >申请人</th>
                	<th field="librid" width="60" align="center"   formatter="formatlibr"  >实验室</th>
                	<th field="title" width="60" align="center"  formatter="formatTitle" >实验名称</th>
                	<th field="type" width="60" align="center"    >实验类型</th>
                	<th field="usertime" width="60" align="center" >使用时间</th>
                	<th field="applytime" width="60" align="center"  >申请时间</th>
                	<th field="approveresult" width="60" align="center"    >审批结果</th>
                	<th field="approvetime" width="60" align="center"    >审批时间</th>
            	</tr>
        </thead>
</table>
<script type="text/javascript">
	function formatUser(value,row,index){
		return row.user.name;
	}
	
	function formatlibr(value,row,index){
		if(row.libr!=null){
			return row.libr.name;
		}
	}
	
	function formatTitle(value,row,index){
		if(row.lab!=null){
			return row.lab.title;
		}
	}
</script>
<!-- 数据表格上的搜索和添加等操作按钮 -->
<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		<privilege:operation operationId="f66cabb173e04fec98853ab3569cb4" clazz="easyui-linkbutton" onClick="tongyi()" name="同意申请"  iconCls="icon-edit" ></privilege:operation>
		<privilege:operation operationId="e7bc36ebe3c5441eb3d2617ef4cc73" clazz="easyui-linkbutton" onClick="butongyi()" name="不同意申请"  iconCls="icon-edit" ></privilege:operation>
		<privilege:operation operationId="eee4882ce11f4589a338518231390e" clazz="easyui-linkbutton" onClick="deleteBespoke()" name="删除"  iconCls="icon-remove" ></privilege:operation>
		&nbsp;&nbsp;&nbsp;
		<privilege:operation operationId="54b8d31e6b5a43f2895f4a6851bd0b" clazz="easyui-linkbutton" onClick="openBespokemfr()" name="实验耗材"  iconCls="icon-edit" ></privilege:operation>
	</div>
	<div class="updownInterval"> </div>
	<div>
		&nbsp;关键字：&nbsp;<input type="text" name="s_keyword" id="s_keyword" size="20" onkeydown="if(event.keyCode==13) searchBespoke()"/>
		<a href="javascript:searchBespoke()" class="easyui-linkbutton" iconCls="icon-search" >搜索</a>
	</div>
	<div class="updownInterval"> </div>
</div>


<!-- 按钮展示列表 -->
<div id="mfrDlg" class="easyui-dialog" style="width: 450px;height: 300px;padding: 10px 20px" closed="true" >
<table  class="easyui-datagrid" id="mfrTable"   toolbar="#operationTb">
    <thead>
    	<tr>
    		<th field="id" width="30" align="center" data-options="hidden:true"></th>
    		<th field="name" width="100" align="center" formatter="formatName">名称</th>
    		<th field="num" width="100" align="center" >数量</th>
    	</tr>
    </thead>
</table>
<script type="text/javascript">
	function formatName(value,row,index){
		return row.mfr.name;
	}
</script>
</div>

</body>
</html>
