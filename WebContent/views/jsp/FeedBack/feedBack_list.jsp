<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="crf.util.PageUtil"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="/WEB-INF/tld/tyTag.tld" prefix="tyTag"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户列表Init</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/views/Css/bootstrap.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/views/Css/style.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/views/Css/page.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/views/Js/checkForm.js"></script>
<script language="javascript" type="text/javascript"
	src="<%=request.getContextPath()%>/views/97DatePicker/WdatePicker.js"></script>
</head>
<body>
	<form name="form0" class="form-inline definewidth m20"
		action="feedBack.do?queryFeedBackListTable" method="post">
		<table align="center" border="0" class="q-cls">
			<tr>
				<td width="6%" align="right">用户名:</td>
				<td width="10%" align="left"><input id="ackeyword"
					style="width: 150px;" type="text" name="acname">
				</td>
				<td width="7%" align="right">查询日期:</td>
				<td width="8%" align="left"><input id="stime" class="Wdate" type="text"
					onClick="WdatePicker()" name="startTime">
				</td>
				<td width="7%" align="right">至:</td>
				<td width="8%" align="left"><input id="etime" class="Wdate" type="text"
					onClick="WdatePicker()" name="endTime">
				</td>
				<td align="right" style="padding-right: 2%">
					<button type="button" onclick="query();" class="btn btn-primary">查询</button>
				</td>
			</tr>
		</table>
		<tyTag:page tarFrame="frame1"
			method="feedBack.do?queryFeedBackListTable"
			pageTurn="<%=PageUtil.TURN_YES %>"></tyTag:page>
	</form>
</body>
<script type="text/javascript">
	
	function query() {
		document.forms[0].action = "feedBack.do?queryFeedBackListTable";//&keyword="+document.getElementById("ackeyword").value
		document.forms[0].target = "frame1";
		document.forms[0].submit();
	}
	
</script>
</html>
