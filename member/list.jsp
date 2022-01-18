<%@page import="member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list.jsp</title>
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
<fieldset>
<legend>회원관리</legend>
<%
String id = (String)session.getAttribute("id");

if (id == null) {
	response.sendRedirect("login.jsp");
} else {
ArrayList<MemberBean> selectedMember = new ArrayList<MemberBean>();
String grade = MemberDAO.getInstance().getMemberInfo(id).getGrade();
session.setAttribute("grade", grade);
	if (grade.equals("admin") || grade.equals("instructor")) {%>
		<table id="table01" border="1" style="text-align: center">
		<tr>
			<th>회원등급</th>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
			<th>주소</th>
			<th>연락처</th>
			<th>가입날짜</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%
		ArrayList<MemberBean> memberList = MemberDAO.getInstance().getMemberList(grade);
		for (MemberBean mb : memberList) {
			%>
			<tr>
				<td><%=mb.getGrade() %></td>
				<td><%=mb.getId() %></td>
				<td><%=mb.getName() %></td>
				<td><%=mb.getEmail() %></td>
				<td>&#40;<%=mb.getPostalCode()%>&#41; <%=mb.getAddress() %>&#44; <%=mb.getDetailAddress() %></td>
				<td><%=mb.getContact() %></td>
				<td><%=mb.getJoinDate() %></td>
				<td><form action="modifyMemberForm.jsp" method="post"><input type="hidden" name="id" value="<%=mb.getId() %>"><input type="button" name="modifyMember" value="수정" onclick="submit()"></form></td>
				<td><form action="deleteMemberForm.jsp" method="post"><input type="hidden" name="id" value="<%=mb.getId() %>"><input type="button" name="deleteMember" value="삭제" onclick="submit()"></form></td>
			</tr>
			<%}
	} else {
		response.sendRedirect("../main/main.jsp");
	}
}
%>
</table>
</fieldset>
</body>
</html>