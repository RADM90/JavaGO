<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updatePro.jsp</title>
</head>
<body>
<script type="text/javascript">
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String password = request.getParameter("newPassword");
String oldPassword = request.getParameter("password");
if (password.length()==0) {
	password=oldPassword;
}
String grade = MemberDAO.getInstance().getMemberInfo(id).getGrade();
String name = request.getParameter("name");
String email = request.getParameter("email");
String postalCode = request.getParameter("postcode");
String address = request.getParameter("address");
String detailAddress = request.getParameter("detailAddress");
if (detailAddress==null) {detailAddress="";}
String phone = request.getParameter("phone");

MemberBean mb = MemberDAO.getInstance().getMemberInfo(id);
mb.setGrade(grade);
mb.setName(name);
mb.setEmail(email);
mb.setPostalCode(postalCode);
mb.setAddress(address);
mb.setDetailAddress(detailAddress);
mb.setContact(phone);

if (mb.getPassword().equals(oldPassword)) {
	MemberDAO.getInstance().updateMember(mb, oldPassword, password);
	%> 
	alert("정보 변경 완료");
	location.href="info.jsp";
<%} else {%>
	alert("기존 비밀번호가 일치하지 않습니다");
	history.back();<%
}
%>
</script>
</body>
</html>