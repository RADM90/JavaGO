<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/updatePro.jsp</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String boardName = request.getParameter("boardName");
int idx = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
String password = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
content = content.replace("\r\n","<br>");
String file = request.getParameter("file");

BoardBean bb = new BoardBean();
bb.setBoardName(boardName);
bb.setIdx(idx);
bb.setName(name);
bb.setPassword(password);
bb.setSubject(subject);
bb.setContent(content);
bb.setFile(file);

boolean check = BoardDAO.getInstance().contentPassCheck(idx, password);
// check==1  updateBoard(bb)  list.jsp 이동
// check==0  "비밀번호틀림" 뒤로이동
// check==-1  "num없음" 뒤로이동
if (request.getParameter("num")==null) {
	%><script type="text/javascript">
	alert("게시물이 존재하지 않습니다");
	history.back();</script>
	<%
} else {
	if (check==false) {
		%><script type="text/javascript">
		alert("비밀번호 틀림");
		history.back();</script>
		<%
	} else {
		boolean result = BoardDAO.getInstance().updateContents(bb);
		%><script type="text/javascript">
		alert("수정 완료");
		location.href = "list.jsp?boardName=<%=boardName %>&pageNum=1";</script>
		<%
	}
}
%>
</body>
</html>