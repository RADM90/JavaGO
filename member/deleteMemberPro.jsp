<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteMemberPro.jsp</title>
</head>
<body>
<script type="text/javascript">
<%
String id = request.getParameter("id");
String pass= MemberDAO.getInstance().getMemberInfo(id).getPassword();

String adminId = (String)session.getAttribute("id");
String adminGrade = MemberDAO.getInstance().getMemberInfo(adminId).getGrade();
String adminPass = request.getParameter("adminPass");

if (adminGrade.equals("admin") || adminGrade.equals("instructor")) {
	if (MemberDAO.getInstance().getMemberInfo(adminId).getPassword().equals(adminPass)) {
		boolean result = MemberDAO.getInstance().deleteMember(id, pass);
		if (result==true) {%>
			alert("회원 삭제가 완료되었습니다");
			location.href="list.jsp";
		<%
		} else {%>
			alert("진행 중 오류가 발생하였습니다");
			history.back();
		<%
		}
	} else {%>
		alert("관리자 비밀번호가 일치하지 않습니다");
		history.back();<%
	}
} else {%>
	alert("권한이 없습니다");
	history.back();
<%}%>
</script>
</body>
</html>