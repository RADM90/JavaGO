<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateForm.jsp</title>
<script type="text/javascript">
function passCheck() {
	if (document.fr.newPassword.value != document.fr.newPassword2.value) {
		alert("새 비밀번호가 일치하지 않습니다");
		document.fr.newPassword2.focus();
		return;
	} 
}
</script>
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
<%
String id = (String)session.getAttribute("id");
MemberBean mb = MemberDAO.getInstance().getMemberInfo(id);
%>
	<form action="updatePro.jsp" method="post" name="fr">
	<input type="hidden" name="grade" value="<%=mb.getGrade() %>">
	<fieldset style="width: 500px; position:absolute; left: 50%; margin-left: -250px">
		<legend>회원정보 수정</legend>
			<table id="table02">
			<tr>
			<th>아이디</th><td><input type="text" name="id" value="<%=mb.getId() %>" style="width: 250px;" readonly></td>
			</tr>
			<tr>
			<th>새 비밀번호</th><td><input type="password" name="newPassword" style="width: 250px;" ></td>
			</tr>
			<tr>
			<th>비밀번호 확인</th><td><input type="password" name="newPassword2" style="width: 250px;" onblur="passCheck()"></td>
			</tr>
			<tr>
			<th>이름</th><td><input type="text" name="name" value="<%=mb.getName() %>" style="width: 250px;" ></td>
			</tr>
			<tr>
			<th>이메일</th><td><input type="email" name="email" value="<%=mb.getEmail() %>" style="width: 250px;" ></td>
			</tr>
			<tr>
			<th>연락처</th><td><input type="text" name="phone" value="<%=mb.getContact() %>" style="width: 250px;" ></td>
			</tr>
			<tr>
			<th>주소</th>
				<td><input type="text" id="postcode" value="<%=mb.getPostalCode() %>" name="postcode" style="width: 140px;">
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="address" name="address" value="<%=mb.getAddress() %>" style="width: 250px;"><br>
					<input type="text" id="detailAddress" name="detailAddress" value="<%=mb.getDetailAddress() %>" style="width: 250px;">
					
					<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script>
					    function execDaumPostcode() {
					        new daum.Postcode({
					            oncomplete: function(data) {
					                var addr = '';
					                var extraAddr = '';
					                if (data.userSelectedType === 'R') {
					                    addr = data.roadAddress;
					                } else {
					                    addr = data.jibunAddress;
					                }
					                document.getElementById('postcode').value = data.zonecode;
					                document.getElementById("address").value = addr;
					                document.getElementById("detailAddress").focus();
					            }
					        }).open();
					    }
					</script>
				</td>
			</tr>
			<tr><th>기존 비밀번호</th><td><input type="password" name="password" style="width: 250px;" required></td></tr>
			<tr><td colspan="2" style="text-align: center"><input type="button" value="정보수정" onclick="submit()">
			<input type="button" value="뒤로가기" onclick="history.back()"></td>
			</tr>
			</table>
	</fieldset>
</form>
</body>
</html>