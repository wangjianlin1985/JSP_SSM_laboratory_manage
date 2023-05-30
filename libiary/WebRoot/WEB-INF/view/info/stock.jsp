<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/common.jsp"%>

<!DOCTYPE html>
<html>
  <head>
    <title>库存明细</title>
    
    <style type="text/css">
    	.datagrid-row-selected {
    		background:white;
    	}
    </style>
    
    <script type="text/javascript">

		
		function searchStock(){
			$('#dg').datagrid('load', {
				type : $("#s_type").val(),
				mfrid:$("#s_mfrid").combobox("getValue"),
				start:$("#s_start").datetimebox("getValue"),
				end:$("#s_end").datetimebox("getValue")
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
                	<th field="mfrid" width="60" align="center"   formatter="formatMfr" >名称</th>
                	<th field="time" width="60" align="center"    >操作时间</th>
                	<th field="type" width="60" align="center"    >类型</th>
                	<th field="thisnum" width="60" align="center"   >操作数</th>
                	<th field="totalnum" width="60" align="center"    >总数</th>
                	<th field="name" width="60" align="center"    >姓名</th>
                	<th field="remarks" width="160" align="center"    >备注</th>
            	</tr>
        </thead>
</table>
<script type="text/javascript">
	function formatMfr(value,row,index){
		if(row.mfr!=null){
			return row.mfr.name;
		}
	}
	
	
</script>
<!-- 数据表格上的搜索和添加等操作按钮 -->
<div id="tb" >
	<div class="updownInterval"> </div>
	<div>
		&nbsp;名称：&nbsp;<input id="s_mfrid" class="easyui-combobox"  data-options="panelHeight:'auto',valueField:'id',textField:'name',url:'${path }/mfr/combo.htm'" />
		&nbsp;类型：&nbsp;      <select id="s_type">
									<option value=''>全部</option>
									<option value="购买">购买</option>
  									<option value="借出">借出</option>
  									<option value="归还">归还</option>
  									<option value="损毁">损毁</option>
								</select>
		&nbsp;开始时间：&nbsp; <input class="easyui-datetimebox" id="s_start"  />
		&nbsp;结束时间：&nbsp; <input class="easyui-datetimebox" id="s_end"  />
		<a href="javascript:searchStock()" class="easyui-linkbutton" iconCls="icon-search" >搜索</a>
	</div>
	<div class="updownInterval"> </div>
</div>



</body>
</html>
