<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
String id = (String)session.getAttribute("id");
String boardName = request.getParameter("boardName");
%>
<title>board/writeForm.jsp</title>
</head>
<body onload="document.fr.subject.focus()">
<jsp:include page="../inc/top.jsp"></jsp:include>
<fieldset>
	<legend><%=boardName.toUpperCase() %></legend>
	<form action="writePro.jsp?boardName=<%=boardName%>" method="post" name="fr">
	<input type="hidden" name="name" value="<%=id %>">
	<input type="hidden" name="boardName" value="<%=boardName %>">
	<table border="1" id="table02">
		<tr>
			<th>글제목</th><td id="data"><input type="text" name="subject" style="width: 880px;"></td>
		</tr>
		<tr>
			<th>비밀번호</th><td id="data"><input type="password" name="pass" style="width: 880px;"></td>
		</tr>
		<tr>
			<th>글내용</th><td id="content"><textarea rows="30" cols="125" name="content"></textarea></td>
		</tr>
		<tr>
			<th colspan="2" style="text-align: center"><input type="submit" value="글쓰기"><input type="button" value="뒤로 가기" onclick="history.back()"></th>
		</tr>
	</table>
	</form>	
</fieldset>
</body>
</html>