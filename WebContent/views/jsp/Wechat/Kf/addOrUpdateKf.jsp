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
    		window.location.href="wechatController.do?queryKfList";
    	}
    	function init(flag){
    		if(flag=="add"){
    			document.form0.kf_account_view.readOnly="";
    		}
    		if(flag=="update"){
    			var kf_account = document.form0.kf_account_view.value;
    			document.form0.kf_account_view.value = kf_account.replace("@crfchina001","");
    		}
    	}
    	/**
    	 *????????????
    	 */
    	function checkForm(){
    		var kf_account_view = trim(document.form0.kf_account_view.value);
    		if(kf_account_view==""){
    			alert("???????????????????????????");
    			return false;
    		}
    		if(/[\u4e00-\u9fa5]/g.test(kf_account_view)){
    			alert("????????????????????????");
    			return false;
    		}
    		if(kf_account_view.length>10){
    			alert("??????????????????10????????????");
    			return false;
    		}
    		var nickname = trim(document.form0.nickname.value);
    		if(nickname==""){
    			alert("???????????????????????????");
    			return false;
    		}
    		if(nickname.replace(/[^\x00-\xff]/g, 'xx').length>12){
    			alert("?????????????????????6????????????12??????????????????");
    			return false;
    		}
    		if(trim(document.form0.password.value)==""){
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
    				document.form0.kf_account.value = document.form0.kf_account_view.value+"@crfchina001";
    				document.form0.submit();
    			}
    		}
    	}
    </script>
</head>
<body onload="init('${flag }');">
<form name="form0" action="wechatController.do?saveKfAccount" method="post" class="definewidth m20">
<input type="hidden" name="flag" value="${flag}">
<input type="hidden" name="kfPId" value="${kf.kfPId}" />
<input type="hidden" name="kf_account" value="${kf.kf_account}" readonly="readonly"/>
    <table class="table table-bordered table-hover definewidth m10">
        <tr>
            <td style="width: 20%;" class="tableleft">????????????</td>
            <td>
            	<input type="text" name="kf_account_view" value="${kf.kf_account}" readonly="readonly"/>
            	<span style="color: gray;">@crfchina001</span>
            </td>
            
        </tr>
        <tr>
            <td class="tableleft">????????????</td>
            <td><input type="text" name="nickname" value="${kf.nickname }"/></td>
        </tr>
        <tr>
            <td class="tableleft">????????????</td>
            <td><input type="password" name="password" value="${kf.password }"/></td>
        </tr>
        <tr>
            <td class="tableleft"></td>
            <td>
                <button class="btn btn-primary" type="button" onclick="submitForm();">??????</button>
                &nbsp;&nbsp;
                <button type="button" onclick="returnList();" class="btn btn-success" name="backid" id="backid">????????????</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
