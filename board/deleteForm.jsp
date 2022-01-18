<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/deleteForm.jsp</title>
<%
String boardName = (String)session.getAttribute("boardName");
int idx = Integer.parseInt(request.getParameter("num"));
%>
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
<form action="deletePro.jsp?num=<%=idx%>" method="post">
	<input type="hidden" name="boardName" value="<%=boardName%>">
	<input type="hidden" name="num" value="<%=idx%>">
	<fieldset style="width: 500px; position:absolute; left: 50%; margin-left: -250px">
	<legend>게시물 삭제</legend>
		<table id="table02">
			<tr><th>비밀번호</th><td><input type="password" name="pass"></td><td><input type="submit" value="글삭제"></td></tr>
		</table>
	</fieldset>
</form>	
</body>
</html>