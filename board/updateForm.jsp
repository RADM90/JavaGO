<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
int idx = Integer.parseInt(request.getParameter("num"));
BoardBean bb = BoardDAO.getInstance().getBoardContent(idx);
String content = bb.getContent().replace("<br>","\r\n");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
%>
<!-- <script type="text/javascript"> -->
<!-- // function deleteFile() { -->
<%-- 	window.open("deleteFile.jsp?num=<%=idx %>&fileName=<%=bb.getFile() %>", "deleteFile", "width=700, height=300"); --%>
<!-- // } -->
<!-- </script> -->

<title>board/updateForm.jsp</title>
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>

<fieldset>
	<legend><%=bb.getBoardName().toUpperCase() %></legend>
	<form action="updatePro.jsp" method="post">
	<input type="hidden" name="boardName" value="<%=bb.getBoardName() %>">
	<table border="1" id="table02">
		<tr>
			<th width="100px" >글쓴이</th><td id="data" width="130px" style="text-align: center;"><%=bb.getName() %><input type="hidden" name="name" value="<%=bb.getName() %>"></td>
			<th width="100px" >글번호</th><td id="data" width="130px" style="text-align: center;"><%=bb.getIdx() %><input type="hidden" name="num" value="<%=bb.getIdx() %>"></td>
			<th width="100px" >조회수</th><td id="data" width="130px" style="text-align: center;"><%=bb.getReadCount() %></td>
			<th width="100px" >작성일</th><td id="data" style="text-align: right;"><%=sdf.format(bb.getDateTime())%></td>
		</tr>
		<tr>
			<th>글제목</th><td id="data" colspan="7"><input type="text" name="subject" value="<%=bb.getSubject()%>" style="width: 880px;"></td>
		</tr>
		<tr>
			<th>비밀번호</th><td id="data" colspan="7"><input type="password" name="pass" style="width: 880px;"></td>
		</tr>
		<%if (bb.getFile()!=null) { %>
		<tr>
			<th>파일</th><td id="data" colspan="7"><img src="../board/attachmentIcon.png" alt="첨부파일" width="10px" height="10px"><a href="file_down.jsp?file_name=<%=bb.getFile() %>"><%=bb.getFile() %></a></td>
		</tr>
		<%} %>
		<tr>
			<th>글내용</th><td id="content" colspan="7"><textarea rows="30" cols="125" name="content"><%=content%></textarea><input type="hidden" name="content" value="<%=content %>"></td>
		</tr>
		<tr>
			<th colspan="8" style="text-align: center">
				<input type="button" value="수정" onclick="submit()">
				<input type="button" value="뒤로가기" onclick="history.back()">
				<input type="button" value="글목록" onclick="location.href='list.jsp?boardName=<%=bb.getBoardName() %>&pageNum=1'">
			</th>
		</tr>
	</table>
	</form>	
</fieldset>
</body>
</html>