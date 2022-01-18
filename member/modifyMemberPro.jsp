<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyMemberPro.jsp</title>
</head>
<body>
<script type="text/javascript">
<%
request.setCharacterEncoding("utf-8");
String sessionId = (String)session.getAttribute("id");
String sessionGrade = (String)session.getAttribute("grade");
String grade = request.getParameter("grade");
String id = request.getParameter("id");
String password = request.getParameter("password");
if (password.length()==0) {password = MemberDAO.getInstance().getMemberInfo(id).getPassword();}
String name = request.getParameter("name");
String email = request.getParameter("email");
String postalCode = request.getParameter("postcode");
String address = request.getParameter("address");
String detailAddress = request.getParameter("detailAddress");
if (detailAddress==null) {detailAddress="";}
String phone = request.getParameter("phone");

String oldPassword = MemberDAO.getInstance().getMemberInfo(id).getPassword();
MemberBean mb = MemberDAO.getInstance().getMemberInfo(id);
mb.setPostalCode(postalCode);
mb.setAddress(address);
mb.setDetailAddress(detailAddress);
mb.setContact(phone);
mb.setGrade(grade);


boolean result = MemberDAO.getInstance().updateMember(mb, oldPassword, password);
if (result) {
	%> 
	alert("정보 변경 완료");
	location.href="list.jsp";
<%} else {%>
	alert("비밀번호 불일치");
	history.back();<%
}
%>
</script>
</body>
</html>