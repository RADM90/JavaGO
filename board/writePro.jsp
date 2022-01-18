<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/writePro.jsp</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String boardName = (String)session.getAttribute("boardName");
String name = request.getParameter("name");
String password = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
content = content.replace("\r\n","<br>");
int readCount = 0;
Timestamp dateTime = new Timestamp(System.currentTimeMillis());

BoardBean bb = new BoardBean();

bb.setBoardName(boardName);
bb.setName(name);
bb.setPassword(password);
bb.setSubject(subject);
bb.setContent(content);
bb.setReadCount(readCount);
bb.setDateTime(dateTime);

boolean result = BoardDAO.getInstance().insertContents(bb);

if (result) {
	response.sendRedirect("list.jsp?boardName="+boardName);
} else {
%>	
	<script type="text/javascript">alert("오류가 발생하였습니다"); history.back();</script>
<%	
}
%>


</body>
</html>