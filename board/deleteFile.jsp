<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/deleteFile.jsp</title>
</head>
<body>
<script type="text/javascript">
<%
int idx = Integer.parseInt(request.getParameter("num"));
String fileName = request.getParameter("fileName");
boolean result = BoardDAO.getInstance().deleteFile(idx);

if (result) {
	%> alert("파일이 삭제되었습니다");
	window.close();<%
} else {
	%> alert("파일 삭제에 실패하였습니다");
	window.close();<%
}
%>
</script>
</body>
</html>