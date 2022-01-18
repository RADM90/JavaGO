<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePro.jsp</title>
</head>
<body>
<script type="text/javascript">
<%
String id = request.getParameter("id");
String pass= request.getParameter("pass");

boolean result = MemberDAO.getInstance().deleteMember(id, pass);
if (result==true) {%>
	alert("회원 탈퇴가 완료되었습니다");
<%
	session.invalidate();
	response.sendRedirect("../main/main.jsp");
} else {%>
	alert("진행 중 오류가 발생하였습니다");
	history.back();
<%
}
%>
</script>
</body>
</html>