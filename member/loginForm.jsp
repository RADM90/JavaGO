<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm.jsp</title>
</head>
<body onload="document.fr.id.focus();">
<jsp:include page="../inc/top.jsp"></jsp:include>
<form action="loginPro.jsp" id="join" method="post" name="fr">
	<fieldset style="width: 500px; position:absolute; left: 50%; margin-left: -250px">
		<legend>Login</legend>
			<table id="table02">
			<tr>
			<th width="100px">아이디</th><td width="100px"><input type="text" name="id"></td></tr>
			<tr><th>비밀번호</th><td><input type="password" name="pass"><br></td></tr>
			<tr>
			<td colspan="2" style="text-align: center"><input type="submit" value="로그인" class="submit"> <input type="reset" value="초기화" class="cancel"></td>
			</tr>
			</table>
	</fieldset>
</form>
</body>
</html>