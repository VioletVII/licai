<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/views/Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/views/Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/views/Css/style.css" />
    <script type="text/javascript" src="<%=request.getContextPath() %>/views/Js/jquery.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/views/Js/jquery.sorted.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/views/Js/bootstrap.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/views/Js/ckform.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/views/Js/common.js"></script>
    <style type="text/css">
        body {
            padding-bottom: 40px;
        }
        .sidebar-nav {
            padding: 9px 0;
        }

        @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
                float: none;
                padding-left: 5px;
                padding-right: 5px;
            }
        }
    </style>
    <script type="text/javascript">
    	function returnList(){
    		window.location.href="pc_SystemController.do?getActorList";
    	}
    	function init(is_enable,flag){
    		if(is_enable=="1"){
    			document.getElementsByName("is_enable")[0].checked="checked";
    		}else if(is_enable=="0"){
    			document.getElementsByName("is_enable")[1].checked="checked";
    		}
    		if(flag=="add"){
    			document.form0.actor_no.readOnly="";
    		}
    	}
    	/**
    	 *????????????
    	 */
    	function checkForm(){
    		if(trim(document.form0.actor_no.value)==""){
    			alert("???????????????????????????");
    			return false;
    		}
    		if(trim(document.form0.actor_name.value)==""){
    			alert("???????????????????????????");
    			return false;
    		}
    		if(trim(document.form0.actor_desc.value)==""){
    			alert("???????????????????????????");
    			return false;
    		}
    		return true;
    	}
    	/**
    	 *????????????
    	 */
    	function submitForm(){
    		if(checkForm()){
    			if(confirm("????????????????")){
    				document.form0.submit();
    			}
    		}
    	}
    </script>
</head>
<body onload="init('${user.is_enable}','${flag }');">
<form name="form0" action="pc_SystemController.do?saveActor" method="post" class="definewidth m20">
<input type="hidden" name="flag" value="${flag}">
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td style="width: 20%;" class="tableleft">????????????</td>
            <td><input type="text" name="actor_no" value="${user.actor_no}" readonly="readonly"/></td>
        </tr>
        <tr>
            <td class="tableleft">????????????</td>
            <td><input type="text" name="actor_name" value="${user.actor_name }"/></td>
        </tr>
        <tr>
            <td class="tableleft">????????????</td>
            <td><input type="text" name="actor_desc" value="${user.actor_desc }"/></td>
        </tr>
        <tr>
	        <td class="tableleft">??????</td>
	        <td>
	            <input type="radio" name="is_enable" value="1" checked="checked"/> ??????
	            <input type="radio" name="is_enable" value="0" /> ??????
	        </td>
    	</tr>
        <tr>
            <td class="tableleft"></td>
            <td>
                <button class="btn btn-primary" type="button" onclick="submitForm();">??????</button>
                &nbsp;&nbsp;<button type="button" onclick="returnList();" class="btn btn-success" name="backid" id="backid">????????????</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
