<%@page import="board.*"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>library/writePro.jsp</title>
</head>
<body>
<%
String uploadPath = request.getRealPath("/library_upload");
System.out.println(uploadPath);
int maxSize = 20 * 1024 * 1024;
// MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new LibrayFileNamePolicy());
MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
String boardName = multi.getParameter("boardName");
String name = multi.getParameter("name");
String password = multi.getParameter("pass");
String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
content = content.replace("\r\n","<br>");

int readCount = 0;
Timestamp dateTime = new Timestamp(System.currentTimeMillis());
String file = multi.getFilesystemName("file");

BoardBean bb = new BoardBean();

bb.setBoardName(boardName);
bb.setName(name);
bb.setPassword(password);
bb.setSubject(subject);
bb.setContent(content);
bb.setReadCount(readCount);
bb.setDateTime(dateTime);
bb.setFile(file);

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