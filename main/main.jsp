<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
window.onload = function(){
	var background_img = "background/img_"; 
	var number = Math.floor(Math.random() * 16) + 1;
	var container = document.getElementById("container");

	background_img += number + ".jpg";
	container.style.backgroundImage = "url('" + background_img + "')";
}

</script> 
<style type="text/css">
#container {
	width: 1200px;
	height: 600px;
	object-fit:cover;
	overflow: hidden;
	background-size: cover;
	background-image:url("background/img_1.jpg");
}
</style>
<meta charset="UTF-8">
<title>main/main.jsp</title>
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
<div id="container">

</div>
</body>
</html>