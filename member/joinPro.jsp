<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinPro.jsp</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
Timestamp join_date = new Timestamp(System.currentTimeMillis());
String email = request.getParameter("email");
String postalCode = request.getParameter("postcode");
String address = request.getParameter("address");
String detailAddress = request.getParameter("detailAddress");
if (detailAddress==null) {detailAddress="";}
String mobile = request.getParameter("mobile");

MemberBean mb = new MemberBean();
mb.setId(id);
mb.setPassword(pass);
mb.setName(name);
mb.setJoinDate(join_date);
mb.setEmail(email);
mb.setPostalCode(postalCode);
mb.setAddress(address);
mb.setDetailAddress(detailAddress);
mb.setContact(mobile);

boolean result = MemberDAO.getInstance().insertMember(mb);

if (result) {%>
	<script type="text/javascript">
	alert("회원가입이 완료되었습니다");
	location.href="loginForm.jsp";
	</script><%
} else {%>
	<script type="text/javascript">
	alert("오류 발생");
	history.back();
	</script><%
}
%>
</body>
</html>