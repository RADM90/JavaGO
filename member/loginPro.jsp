<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginPro.jsp</title>
</head>
<body>
<script type="text/javascript"><%
String id = request.getParameter("id");
String password = request.getParameter("pass");
// 로그인 성공 = 1, 아이디 없음 = 0, 비밀번호 틀림 = -1

int result = MemberDAO.getInstance().memberCheck(id, password);

if (result==1) {
	String grade = MemberDAO.getInstance().getMemberInfo(id).getGrade();
	session.setAttribute("id", id);
	session.setAttribute("grade", grade);%>
	alert("로그인 성공");
	location.href="../main/main.jsp";
	<%
} else if (result == 0) {%>
	alert("아이디가 존재하지 않습니다");
	history.back(); <%
} else {%>
alert("비밀번호가 일치하지 않습니다");
history.back(); <%
}
%>
</script>
</body>
</html>