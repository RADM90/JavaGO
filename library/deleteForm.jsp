<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>library/deleteForm.jsp</title>
<%
String boardName = "library";
int num = Integer.parseInt(request.getParameter("num"));
%>
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
<form action="deletePro.jsp?boardName=<%=boardName%>?num=<%=num%>" method="post">
	<input type="hidden" name="pageName" value="<%=boardName%>">
	<input type="hidden" name="num" value="<%=num%>">
	<fieldset>
	<legend>게시물 삭제</legend>
		<table>
			<tr><td>비밀번호</td><td><input type="password" name="pass"></td></tr>
			<tr><td colspan="2"><input type="submit" value="글삭제"></td></tr>
		</table>
	</fieldset>
</form>	
</body>
</html>