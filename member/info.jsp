<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>info.jsp</title>
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>

<%
String id = (String)session.getAttribute("id");
MemberBean mb = MemberDAO.getInstance().getMemberInfo(id);
%>
<fieldset style="width: 700px; position:absolute; left: 50%; margin-left: -350px">
<legend>회원 정보</legend>
<table id="table02">
	<tr><th>아이디</th><td><%=mb.getId() %></td></tr>
	<tr><th>이름</th><td><%=mb.getName() %></td></tr>
	<tr><th>가입일시</th><td><%=mb.getJoinDate() %></td></tr>
	<tr><th>이메일</th><td><%=mb.getEmail() %></td></tr>
	<tr><th>주소</th><td>&#40;<%=mb.getPostalCode()%>&#41; <%=mb.getAddress() %>&#44; <%=mb.getDetailAddress() %></td></tr>
	<tr><th>연락처</th><td><%=mb.getContact() %></td></tr>
	<tr><td colspan="2"><input type="button" value="회원정보수정" onclick="location.href='updateForm.jsp'">
<input type="button" value="회원탈퇴" onclick="location.href='deleteForm.jsp'">
<input type="button" value="돌아가기" onclick="history.back()"></td>
</table>
</fieldset>
</body>
</html>