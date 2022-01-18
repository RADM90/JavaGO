<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/list.jsp</title>
<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
String id = (String)session.getAttribute("id");
MemberBean mb = null;
if (id == null) {
%>
<script type="text/javascript">
	alert("로그인 후 이용해주세요");
	location.href="../member/loginForm.jsp";
</script>
<%
} else {
	mb = MemberDAO.getInstance().getMemberInfo(id);
}
%>
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
<%
request.setCharacterEncoding("utf-8");
String boardName = request.getParameter("boardName");
session.setAttribute("boardName", boardName);
int count = BoardDAO.getInstance().countBoard(boardName);
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}
int currentPage = Integer.parseInt(pageNum);
int pageSize = 15;
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;
int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);

int pageBlock = 10;
int startPage= (currentPage-1)/pageBlock*pageBlock+1;
int endPage = startPage + pageBlock - 1;
if (endPage > pageCount) {
	endPage = pageCount;
}

ArrayList<BoardBean> boardList = BoardDAO.getInstance().getBoardList(boardName, startRow, pageSize);
%>
<fieldset>
	<legend><%=boardName.toUpperCase() %></legend>
	<span>[전체 글개수 : <%=count %>] </span><br><br>
<table border="1"  id="table01">
<tr><th width="60px">글번호</th><th>제목</th><th width="140px">작성자</th><th width="100px">날짜</th><th width="60px">조회수</th></tr>
<%
for (int i = 0; i < boardList.size(); i++) {
	BoardBean bb = boardList.get(i);
%>
<tr>
	<td id="data"><%=bb.getIdx()%></td>
	<td><a href="content.jsp?boardName=<%=boardName %>&num=<%=bb.getIdx()%>" id="contentLink" style="text-decoration: none;"> <%=bb.getSubject()%></a></td>
	<td id="data"><%=bb.getName()%></td>
	<td id="data"><%=sdf.format(bb.getDateTime())%></td>
	<td id="data"><%=bb.getReadCount()%></td>
</tr>
<%
}
%>
</table>
<% if (id != null) {
	if (!mb.getGrade().equals("student")) {%>
		<span><input type="button" value="글쓰기" onclick="location.href='writeForm.jsp?boardName=<%=boardName %>'"></span>
	<%} else {
		if (boardName.equals("freeboard") && mb.getGrade().equals("student")) {
			%>
			<span><input type="button" value="글쓰기" onclick="location.href='writeForm.jsp?boardName=freeboard'"></span>
			<%
		}
	}
}
	%>
	<form action="listSearch.jsp?boardName=<%=boardName %>&pageNum=1" method="post"><select name="option"><option value="subject" selected>제목</option><option value="content">내용</option><option value="name">작성자</option></select><input type="text" name="search"> <input type="image" src="search.png" width="15px" height="15px"></form>
</fieldset>
<p style="float: right">
<%
if (startPage > pageBlock) {
%><a href="list.jsp?boardName=<%=boardName %>&pageNum=<%=startPage - pageBlock%>">[이전]</a>
<%
	}
for (int i = startPage; i <= endPage; i++) {
%>
<a href="list.jsp?boardName=<%=boardName %>&pageNum=<%=i%>"><%=i%></a>
<%
	}
if (endPage < pageCount) {
%><a href="list.jsp?boardName=<%=boardName %>&pageNum=<%=startPage + pageBlock%>">[다음]</a>
<%
}
%></p><br><br>


</body>
</html>