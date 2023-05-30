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

		var urlx = "";
		// 打开新增通知信息对话框
        function openBespokeAddDialog(){
			urlx = "reserveBespoke.htm";
        	$("#dlg").dialog("open").dialog("setTitle", "添加");
        }

		// 打开修改通知信息对话框
        function openBespokeUpdateDialog(){
    		var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length!=1){
    			$.messager.alert('系统提示','请选择一条要编辑的数据！');
    			return;
    		}
    		var row=selectedRows[0];
    		if(row.approveresult!='未审批'){
    			$.messager.alert('系统提示','已经提交的申请不能修改！');
    			return;
    		}
    		$("#fm").form("load", row);
    		urlx = "reserveBespoke.htm?id=" + row.id;
    		$("#labid").combobox("setValue",row.lab.id);
    		$("#librid").combobox("setValue",row.libr.id);
    		$("#dlg").dialog("open").dialog("setTitle", "修改");
    		
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
		
		
		var bespokeid = "";
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
		
		var url2;
		function openMfrAddDialog(){
			$("#mfrReserveDlg").dialog("open").dialog("setTitle", "添加材料");
			url2 = "reserveMfr.htm";
		}
		
		function openMfrUpdateDialog(){
			var selectedRows = $("#mfrTable").datagrid('getSelections');
			if (selectedRows.length != 1) {
				$.messager.alert('系统提示', '请选择一条要编辑的数据！');
				return;
			}
			var row = selectedRows[0];
			$("#fm2").form("load", row);
			url2 = "reserveMfr.htm?id=" + row.id;
			$("#mfrid").combobox("setValue",row.mfr.id);
			$("#mfrReserveDlg").dialog("open").dialog("setTitle", "添加材料");
		}
		
		function deleteMfr(){
			var selectedRows = $("#mfrTable").datagrid('getSelections');
			if (selectedRows.length == 0) {
				$.messager.alert('系统提示', '请选择要删除的数据！');
				return;
			}
			var strIds = [];
			for ( var i = 0; i < selectedRows.length; i++) {
				strIds.push(selectedRows[i].id);
			}
			var ids = strIds.join(",");
			$.messager.confirm("系统提示", "您确认要删除些数据吗？", function(r) {
				if (r) {
					$.post("deleteMfr.htm", {ids : ids}, 
						function(result) {
							if (result.success) {
								$.messager.alert('系统提示', "删除成功");
								$("#mfrTable").datagrid("reload");
							} else {
								$.messager.alert('系统提示', result.errorMsg);
						}
					}, "json");
				}
			});
		}
		
		
		function reserveMfr(){
			$("#fm2").form("submit",{
				url : url2,
				onSubmit : function() {
					return $(this).form("validate");
				},
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.errorMsg) {
						$.messager.alert('系统提示', "<font color=red>" + result.errorMsg + "</font>");
						return;
					} else {
						$.messager.alert('系统提示', '保存成功');
						$("#mfrTable").datagrid("reload");
						closeMfrReserveDialog();
					}
				}
			});
		}
		
		function closeMfrReserveDialog(){
			$("#mfrReserveDlg").dialog("close");
			// $("#fm2").form('clear');
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
		<privilege:operation operationId="3b34c2b565e74068b6afd9fe7c8fb4" clazz="easyui-linkbutton" onClick="openBespokeAddDialog()" name="申请"  iconCls="icon-add" ></privilege:operation>
		<privilege:operation operationId="1cd7accdd24d4177bb4e686daf5dac" clazz="easyui-linkbutton" onClick="openBespokeUpdateDialog()" name="修改"  iconCls="icon-edit" ></privilege:operation>
		<privilege:operation operationId="e7ce16fcd4ed464a82173c3be6036b" clazz="easyui-linkbutton" onClick="deleteBespoke()" name="删除"  iconCls="icon-remove" ></privilege:operation>
		&nbsp;&nbsp;&nbsp;
		<privilege:operation operationId="04af3a6c73e54a5790b58755177052" clazz="easyui-linkbutton" onClick="openBespokemfr()" name="实验耗材"  iconCls="icon-edit" ></privilege:operation>
	</div>
	<div class="updownInterval"> </div>
</div>




<!-- 新增和修改对话框 -->
<div id="dlg" class="easyui-dialog" style="text-align:right;width: 520px;height: 420px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">
 <form id="fm" method="post">
 	<table cellspacing="5px;">
 		<tr>
  			<td>选择实验室：</td>
  			<td><input type="text" id="librid" name="libr.id" class="easyui-combobox"  data-options="panelHeight:'auto',valueField:'id',textField:'name',url:'${path }/libr/combo.htm'" required="true"/></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		<tr>
  			<td>选择实验：</td>
  			<td><input type="text" id="labid" name="lab.id" class="easyui-combobox"  data-options="panelHeight:'auto',valueField:'id',textField:'title',url:'${path }/lab/combo.htm'" required="true"/></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		<tr>
  			<td>类型：</td>
  			<td><select name="type"><option value="基础">基础</option><option value="设计">设计</option></select>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		<tr>
  			<td>使用时间：</td>
  			<td><input type="text" id="usertime" name="usertime" /></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		<tr>
  			<td>备注：</td>
  			<td><input type="text" id="remarks" name="remarks"/></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  	</table>
 </form>
</div>
<div id="dlg-buttons" style="text-align:center">
	<a href="javascript:reserveBespoke()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeBespokeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>








<!-- 按钮展示列表 -->
<div id="mfrDlg" class="easyui-dialog" style="width: 450px;height: 300px;padding: 10px 20px" closed="true" >
<table  class="easyui-datagrid" id="mfrTable"   toolbar="#operationTb">
    <thead>
    	<tr>
    		<th field="cb2" checkbox="true" align="center"></th>
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
<div id="operationTb">
	<div>
		<a href="javascript:openMfrAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
		<a href="javascript:openMfrUpdateDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
		<a href="javascript:deleteMfr()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
	</div>
</div>




<!-- 按钮的新增/修改form -->
<div id="mfrReserveDlg" class="easyui-dialog" style="width: 350px;height: 200px;padding: 10px 20px"
  closed="true" buttons="#operationdlg-buttons" >
  <form id="fm2" method="post">
  	<table cellspacing="5px;">
  		<tr>
  			<td>材料名称：</td>
  			<td><input type="text" id="mfrid" name="mfr.id"  class="easyui-combobox"  data-options="panelHeight:'auto',valueField:'id',textField:'name',url:'${path }/mfr/combo.htm'" /></td>
  		</tr>
  		<tr>
  			<td>数量：</td>
  			<td><input type="number" id="num" name="num" class="easyui-validatebox" required="true"/></td>
  		</tr>
  		<input type="hidden" id="hidden_bespokeid" name="bespoke.id" />
  	</table>
  </form>
</div>

<div id="operationdlg-buttons"  style="text-align:center">
	<a href="javascript:reserveMfr()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closeMfrReserveDialog()" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div>





</body>
</html>
