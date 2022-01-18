<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteForm.jsp</title>
<script type="text/javascript">
function signOutCheck() {
	var a = confirm("회원 탈퇴를 진행하시겠습니까");
	if (a == true) {
		document.fr.submit();
	} else {
		alert("회원 탈퇴가 취소되었습니다");
		location.href="info.jsp";
	}
}
</script>
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
<%
String id = (String)session.getAttribute("id");
%>
<fieldset>
	<legend>회원탈퇴</legend>
		<form action="deletePro.jsp" name="fr">
		<input type="hidden" name="id" value=<%=id %>>
			<table>
				<tr><th>비밀번호 확인</th><td><input type="password" name="pass"></td></tr>
				<tr><th colspan="2"><input type="button" value="탈퇴" onclick="signOutCheck()"></th></tr>
			</table>
		</form>
</fieldset>

</body>
</html>