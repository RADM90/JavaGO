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
<title>gallery/list.jsp</title>
<link href="list_gallery.css" rel="stylesheet" type="text/css">
<%
String id = (String)session.getAttribute("id");
MemberBean mb = null;
if (id == null) {
%>
<script type="text/javascript">
	alert("로그인 후 이용해주세요");
	location.href="../member/loginForm.jsp";
</script>
<%
}
%>
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
<%
String boardName = request.getParameter("boardName");
session.setAttribute("boardName", boardName);
int count = BoardDAO.getInstance().countBoard(boardName);
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}
int currentPage = Integer.parseInt(pageNum);
int pageSize = 12;
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
int rowSize = ((boardList.size()-1)/4) +1;
int colSize = boardList.size()%4; if (colSize==0) {colSize=4;}
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
%>
<fieldset>
<legend>GALLERY</legend>
<span>[전체 글개수 : <%=count %>]</span><br>
<ul id="photo_list">
<%
for (BoardBean bb : boardList) {
%>
<li>
<a href="content.jsp?boardName=gallery&num=<%=bb.getIdx() %>"><img src="../gallery_upload/<%=bb.getFile() %>" width="170" height="112">
<span class="subject"><%=bb.getSubject() %></span>
<span class="num"><%=bb.getIdx() %></span>
<span class="readCount">hit: <%=bb.getReadCount() %></span>
<span class="writer"><%=bb.getName() %></span>
<span class="date"><%=sdf.format(bb.getDateTime()) %></span></a>
</li><%
}
%>
</ul>
</fieldset>
<p><input type="button" value="글쓰기" onclick="location.href='writeForm.jsp?boardName=gallery'"></p>
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