<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>idCheck.jsp</title>
</head>
<body>
<script type="text/javascript">
<% String checkId = request.getParameter("checkId");
boolean checker = MemberDAO.getInstance().duplicateCheck(checkId);

if (checker) {
	%> alert("이미 가입된 아이디입니다");
	window.close();<%
} else {
	%> alert("존재하지 않는 아이디입니다");
	window.close();<%
}
%>
</script>
</body>
</html>