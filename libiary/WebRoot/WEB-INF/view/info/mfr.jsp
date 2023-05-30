<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>设备主页</title>
    
    <style type="text/css">
    	.datagrid-row-selected {
    		background:white;
    	}
    </style>
    
    <script type="text/javascript">

		var urlx = "";
		// 打开新增通知信息对话框
        function openMfrAddDialog(){
			urlx = "reserveMfr.htm";
        	$("#dlg").dialog("open").dialog("setTitle", "添加");
        }

		// 打开修改通知信息对话框
        function openMfrUpdateDialog(){
    		var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length!=1){
    			$.messager.alert('系统提示','请选择一条要编辑的数据！');
    			return;
    		}
    		var row=selectedRows[0];
    		$("#fm").form("load", row);
    		urlx = "reserveMfr.htm?id=" + row.id;
    		$("#typeid").combobox("setValue",row.type.id);
    		$("#librid").combobox("setValue",row.libr.id);
    		$("#dlg").dialog("open").dialog("setTitle", "修改");
    		
    	}

		
		

        function closeMfrDialog(){
        	$("#fm").form('clear');
        	$("#dlg").dialog("close");
        }


        function reserveMfr(){
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
        						closeMfrDialog();
        						$("#dg").datagrid("reload");
        					}
        				}
        	});
        }

		
		
		function deleteMfr(){
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
    				$.post("deleteMfr.htm",{ids:ids},function(result){
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
		
		$(function(){
			$.ajax({
				url:'${path}/type/combo.htm',
				dataType:'json',
				type:'post',
				success:function(data){
					var str = "<option value=''>全部</option>";
					for(var i=0;i<data.length;i++){
						str += "<option value='"+data[i].id+"'>" + data[i].name+"</option>";
					}
					$("#s_typeid").html(str);
				}
			});
			
			$.ajax({
				url:'${path}/libr/combo.htm',
				dataType:'json',
				type:'post',
				success:function(data){
					var str = "<option value=''>全部</option>";
					for(var i=0;i<data.length;i++){
						str += "<option value='"+data[i].id+"'>" + data[i].name+"</option>";
					}
					$("#s_librid").html(str);
				}
			});
		});
		
		
		function searchBespoke(){
			$('#dg').datagrid('load', {
				keyword : $("#s_keyword").val(),
				typeid:$("#s_typeid").val(),
				librid:$("#s_librid").val()
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
                	<th field="code" width="60" align="center"    >编号</th>
                	<th field="name" width="60" align="center"    >名称</th>
                	<th field="typeid" width="60" align="center"   formatter="formatType" >分类</th>
                	<th field="librid" width="60" align="center"    formatter="formatLibr" >实验室</th>
                	<th field="num" width="60" align="center"    >数量</th>
            	</tr>
        </thead>
</table>
<script type="text/javascript">
	function formatType(value,row,index){
		if(row.type!=null){
			return row.type.name;
		}
	}
	
	function formatLibr(value,row,index){
		if(row.libr!=null){
			return row.libr.name;
		}
	}
	
	
</script>
<!-- 数据表格上的搜索和添加等操作按钮 -->
<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		<privilege:operation operationId="261c91fed4aa4dd19f06341b8b6de9" clazz="easyui-linkbutton" onClick="openMfrAddDialog()" name="添加"  iconCls="icon-add" ></privilege:operation>
		<privilege:operation operationId="58d8ef3ba8c94bc892b3acee54aa16" clazz="easyui-linkbutton" onClick="openMfrUpdateDialog()" name="修改"  iconCls="icon-edit" ></privilege:operation>
		<privilege:operation operationId="8a0c7db085ca46328dfcbf8ae8e82b" clazz="easyui-linkbutton" onClick="deleteMfr()" name="删除"  iconCls="icon-remove" ></privilege:operation>
		&nbsp;&nbsp;
		<privilege:operation operationId="68b3ef20be634bd7b2527488eb94fc" clazz="easyui-linkbutton" onClick="inStock()" name="入库"  iconCls="icon-edit" ></privilege:operation>
		<privilege:operation operationId="aefe144fc5584ef3a0719de5b7c54f" clazz="easyui-linkbutton" onClick="outStock()" name="出库"  iconCls="icon-edit" ></privilege:operation>
		&nbsp;&nbsp;
		<privilege:operation operationId="32dfafc36c794580b8c93f5f28da48" clazz="easyui-linkbutton" onClick="addRepair()" name="添加维护信息"  iconCls="icon-edit" ></privilege:operation>
	</div>
	<div class="updownInterval"> </div>
	<div>
		&nbsp;关键字：&nbsp;<input type="text" name="s_keyword" id="s_keyword" size="20" onkeydown="if(event.keyCode==13) searchBespoke()"/>
		&nbsp;类型：&nbsp;      <select id="s_typeid"></select>
		&nbsp;所属实验室：&nbsp; <select id="s_librid"></select>
		<a href="javascript:searchBespoke()" class="easyui-linkbutton" iconCls="icon-search" >搜索</a>
	</div>
	<div class="updownInterval"> </div>
</div>




<!-- 新增和修改对话框 -->
<div id="dlg" class="easyui-dialog" style="text-align:right;width: 520px;height: 420px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">
 <form id="fm" method="post" enctype="multipart/form-data" >
 	<table cellspacing="5px;">
  		<tr>
  			<td>名称：</td>
  			<td><input type="text" id="name" name="name" class="easyui-validatebox" required="true"/></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		<tr>
  			<td>编号：</td>
  			<td><input type="text" id="code" name="code" class="easyui-validatebox" required="true"/></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		<tr>
  			<td>分类：</td>
  			<td><input type="text" id="typeid" name="type.id" class="easyui-combobox"  data-options="panelHeight:'auto',valueField:'id',textField:'name',url:'${path }/type/combo.htm'" required="true"/></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		<tr>
  			<td>所属实验室：</td>
  			<td><input type="text" id="librid" name="libr.id" class="easyui-combobox" data-options="panelHeight:'auto',valueField:'id',textField:'name',url:'${path }/libr/combo.htm'" required="true"/></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  	</table>
 </form>
</div>
<div id="dlg-buttons" style="text-align:center">
	<a href="javascript:reserveMfr()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeMfrDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>





<script type="text/javascript">
	var stockurl;
	function inStock(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert('系统提示','请选择一条要编辑的数据！');
			return;
		}
		var row=selectedRows[0];
		stockurl = "addStock.htm?mfrid=" + row.id+"&t=in";
		$("#dlg2").dialog("open").dialog("setTitle", "添加库存");
	}
	
	function outStock(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert('系统提示','请选择一条要编辑的数据！');
			return;
		}
		var row=selectedRows[0];
		stockurl = "addStock.htm?mfrid=" + row.id+"&t=out";
		$("#dlg2").dialog("open").dialog("setTitle", "添加库存");
	}
	
	 function closeStockDialog(){
     	$("#fm2").form('clear');
     	$("#dlg2").dialog("close");
     }


     function reserveStock(){
     	$("#fm2").form("submit",
     			{
     				url : stockurl,
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
     						closeStockDialog();
     						$("#dg").datagrid("reload");
     					}
     				}
     	});
     }
     
     
     
     
     function addRepair(){
    	var selectedRows=$("#dg").datagrid('getSelections');
 		if(selectedRows.length!=1){
 			$.messager.alert('系统提示','请选择一条要编辑的数据！');
 			return;
 		}
 		var row=selectedRows[0];
 		window.open("${path}/mfr/toRepairAdd.htm?mfrid="+row.id);
     }
     
</script>






<div id="dlg2" class="easyui-dialog" style="text-align:right;width: 520px;height: 420px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">
 <form id="fm2" method="post"  >
 	<table cellspacing="5px;">
  		<tr>
  			<td>类型：</td>
  			<td><select name="type">
  				<option value="购买">购买</option>
  				<option value="借出">借出</option>
  				<option value="归还">归还</option>
  				<option value="损毁">损毁</option>
  			</select></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		<tr>
  			<td>数量：</td>
  			<td><input type="number" id="thisnum" name="thisnum" class="easyui-validatebox" required="true"/></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		<tr>
  			<td>姓名：</td>
  			<td><input type="text" name="name"  class="easyui-validatebox" required="true"/></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		<tr>
  			<td>备注：</td>
  			<td><input name="remarks" class="easyui-validatebox"  required="true"/></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  	</table>
 </form>
</div>
<div id="dlg-buttons" style="text-align:center">
	<a href="javascript:reserveStock()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeStockDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>


</body>
</html>
