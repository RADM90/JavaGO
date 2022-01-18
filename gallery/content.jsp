<%@page import="member.MemberDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gallery/content.jsp</title>
<%
String id = (String)session.getAttribute("id");
String boardName = (String)session.getAttribute("boardName");
int idx = Integer.parseInt(request.getParameter("num"));
BoardDAO.getInstance().updateReadCount(idx);
BoardBean bb = BoardDAO.getInstance().getBoardContent(idx);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
String content = bb.getContent().replace("\r\n","<br>");
%>
<link href="content.css" rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
<fieldset>
	<legend><%=bb.getBoardName().toUpperCase() %></legend>
	<table border="1" id="table02">
		<tr>
			<th width="100px" >글쓴이</th><td id="data" width="130px" style="text-align: center;"><%=bb.getName() %></td>
			<th width="100px" >글번호</th><td id="data" width="130px" style="text-align: center;"><%=bb.getIdx() %></td>
			<th width="100px" >조회수</th><td id="data" width="130px" style="text-align: center;"><%=bb.getReadCount() %></td>
			<th width="100px" >작성일</th><td id="data" style="text-align: right;"><%=sdf.format(bb.getDateTime())%></td>
		</tr>
		<tr>
			<th>글제목</th><td id="data" colspan="7"><%=bb.getSubject() %></td>
		</tr>
		<tr>
			<th>파일</th><td id="data" colspan="7"><img src="../board/attachmentIcon.png" alt="첨부파일" width="10px" height="10px"><a href="file_down.jsp?file_name=<%=bb.getFile() %>"><%=bb.getFile() %></a></td>
		</tr>
		<tr>
			<th>글내용</th><td id="content" colspan="7"><img src="../gallery_upload/<%=bb.getFile() %>" style="max-width: 800px"><br><br><%=content %></td>
		</tr>
		<tr>
			<th colspan="8" style="text-align: center">
				<%if (MemberDAO.getInstance().getMemberInfo(id).getId().equals(bb.getName()) || !(MemberDAO.getInstance().getMemberInfo(id).getGrade().equals("student"))) {%>
				<input type="button" value="글삭제" onclick="location.href='deleteForm.jsp?boardName=<%=bb.getBoardName() %>&num=<%=bb.getIdx()%>'">
				<%} %>
				<input type="button" value="글목록" onclick="location.href='list.jsp?boardName=<%=bb.getBoardName() %>&pageNum=1'">
			</th>
		</tr>
	</table>
</fieldset>
</body>
</html>