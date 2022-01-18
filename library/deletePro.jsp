<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>library/deletePro.jsp</title>
</head>
<body>
<script type="text/javascript">
<%
request.setCharacterEncoding("utf-8");
String boardName = "library";
int idx = Integer.parseInt(request.getParameter("num"));
String password = request.getParameter("pass");

BoardBean bb=new BoardBean();
bb.setIdx(idx);
bb.setPassword(password);

boolean check = BoardDAO.getInstance().contentPassCheck(idx, password);

if (check) {
	boolean result = BoardDAO.getInstance().deleteContents(idx);
	if (result) {
		%>
		alert("게시물 삭제 완료");
		location.href="list.jsp?boardName=<%=boardName%>&pageNum=1";
		<%
	} else {
		%>
		alert("게시물이 존재하지 않음");
		location.href="list.jsp?boardName=<%=boardName%>&pageNum=1";
		<%
	}
} else {
	%>
	alert("비밀번호 불일치");
	history.back();
	<%
}
%>
</script>
</body>
</html>