<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteMemberForm.jsp</title>
<script type="text/javascript">
function signOutCheck() {
	var a = confirm("회원 삭제를 진행하시겠습니까");
	if (a == true) {
		document.fr.submit();
	} else {
		alert("회원 삭제가 취소되었습니다");
		location.href="list.jsp";
	}
}
</script>
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
<%
String id = request.getParameter("id");
%>
<fieldset>
	<legend>회원삭제</legend>
		<form action="deleteMemberPro.jsp" name="fr">
		<input type="hidden" name="id" value=<%=id %>>
			<table id="table02">
				<tr><th>관리자 비밀번호</th><td><input type="password" name="adminPass"></td></tr>
				<tr><td colspan="2"><input type="button" value="회원정보 삭제" onclick="signOutCheck()"></td></tr>
			</table>
		</form>
</fieldset>

</body>
</html>