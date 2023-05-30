<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>图书馆信息主页</title>
    
    <style type="text/css">
    	.datagrid-row-selected {
    		background:white;
    	}
    </style>
    
    <script type="text/javascript">

		var urlx = "";
		// 打开新增通知信息对话框
        function openLibrAddDialog(){
			urlx = "reserveLibr.htm";
        	$("#dlg").dialog("open").dialog("setTitle", "添加");
        }

		// 打开修改通知信息对话框
        function openLibrUpdateDialog(){
    		var selectedRows=$("#dg").datagrid('getSelections');
    		if(selectedRows.length!=1){
    			$.messager.alert('系统提示','请选择一条要编辑的数据！');
    			return;
    		}
    		var row=selectedRows[0];
    		$("#fm").form("load", row);
			$('#kebiao').attr("src","${path}/"+row.kebiao);
    		urlx = "reserveLibr.htm?id=" + row.id;
    		$("#dlg").dialog("open").dialog("setTitle", "修改");
    		
    	}

		
		

        function closeLibrDialog(){
        	$("#fm").form('clear');
        	$("#dlg").dialog("close");
        }


        function reserveLibr(){
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
        						closeLibrDialog();
        						$("#dg").datagrid("reload");
        					}
        				}
        	});
        }

		
		
		function deleteLibr(){
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
    				$.post("deleteLibr.htm",{ids:ids},function(result){
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
                	<th data-options="field:'id',width:80,hidden:'true'" align="center">通知编号</th>
                	<th field="name" width="60" align="center"    >名称</th>
                	<th field="location" width="60" align="center"    >地点</th>
                	<th field="kebiao" width="60" align="center" formatter="formatKebiao">查看图片</th>
            	</tr>
        </thead>
        <script>
        	function formatKebiao(value,row,index){
        		return "<a javascript:void(0) onclick='openKebiao(\""+row.kebiao+"\")'>打开课表</a>";
        	}
        	
        	
        	function openKebiao(cover){
        		window.open("${path}/"+cover);
        	}
        	
        </script>
</table>
<!-- 数据表格上的搜索和添加等操作按钮 -->
<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		<privilege:operation operationId="3734956ea23047358ded4f70dcc905" clazz="easyui-linkbutton" onClick="openLibrAddDialog()" name="添加"  iconCls="icon-add" ></privilege:operation>
		<privilege:operation operationId="874b9de0f893477abc38ce91f629c9" clazz="easyui-linkbutton" onClick="openLibrUpdateDialog()" name="修改"  iconCls="icon-edit" ></privilege:operation>
		<privilege:operation operationId="b1fa704302a94d798179681eb3119d" clazz="easyui-linkbutton" onClick="deleteLibr()" name="删除"  iconCls="icon-remove" ></privilege:operation>
	</div>
	<div class="updownInterval"> </div>
</div>




<!-- 新增和修改对话框 -->
<div id="dlg" class="easyui-dialog" style="text-align:right;width: 620px;height: 420px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">
 <form id="fm" method="post" enctype="multipart/form-data" >
 	<table cellspacing="5px;">
  		<tr>
  			<td>名称：</td>
  			<td><input type="text" id="name" name="name" class="easyui-validatebox" required="true"/></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		<tr>
  			<td>地点：</td>
  			<td><input type="text" id="location" name="location" class="easyui-validatebox" required="true"/></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		<tr>
  			<td>课表：</td>
  			<td><input type="file" name="file" id="ii" onchange="preImg(this.id,'kebiao');" /></td>
  		</tr>
  		<tr>
  			<td>预览：</td>
  			<td><img id="kebiao" src="" width="100px" height="100px" style="display: block;" /></td>
  		</tr>
  		<tr><td>&nbsp;</td></tr>
  		
  		
  	</table>
 </form>
</div>
<div id="dlg-buttons" style="text-align:center">
	<a href="javascript:reserveLibr()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeLibrDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>

<script type="text/javascript">
function getFileUrl(sourceId) {  
    var url;  
    if (navigator.userAgent.indexOf("MSIE")>=1) { // IE  
        url = document.getElementById(sourceId).value;  
    } else if(navigator.userAgent.indexOf("Firefox")>0) { // Firefox  
        url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0));  
    } else if(navigator.userAgent.indexOf("Chrome")>0) { // Chrome  
        url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0));  
    }  
    return url;  
}  
function preImg(sourceId, targetId) {   
    var url = getFileUrl(sourceId);   
    var imgPre = document.getElementById(targetId);   
    imgPre.src = url;   
}   
</script>




</body>
</html>
