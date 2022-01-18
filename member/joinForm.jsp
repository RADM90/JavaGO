<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinForm.jsp</title>
<% if (session.getAttribute("id")!=null) {
	session.invalidate();
}
%>

<script type="text/javascript">
var idReg = /^[a-z]+[a-z0-9]{3,15}$/g;
var passReg = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
var mailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

function duplicateCheck() {
	if (document.fr.id.value.length == 0) {
		alert("아이디를 입력하세요");
	} else {
		window.open("idCheck.jsp?checkId="+document.fr.id.value,"check","width=700, height=300");
	}
}


// function passMatch() {
// 	if (document.fr.pass.value!=document.fr.pass2.value) {
// 		alert("입력한 비밀번호가 서로 일치하지 않습니다");
// 		document.fr.pass2.value="";
// 		document.fr.pass2.focus();
// 		return;
// 	}
// }

// function mailMatch() {
// 	if (document.fr.email.value!=document.fr.email2.value) {
// 		alert("입력한 이메일이 서로 일치하지 않습니다");
// 		document.fr.email2.value="";
// 		document.fr.email2.focus();
// 		return;
// 	}
// }

function joinCheck() {
	if(document.fr.id.value.match(idReg) == null) {
	      alert("아이디는 영문자로 시작하는 4~16자 영문자, 숫자로 설정해주세요.");
	document.fr.id.focus();
	return;
	
	} else {
		if (document.fr.pass.value.match(passReg) == null) {
			alert("비밀번호는 특수문자/영문/숫자를 포함한 8~16자리로 설정해주세요.");
			document.fr.pass.focus();
			return;
		} else {
			if (document.fr.pass.value!=document.fr.pass2.value) {
		 		alert("입력한 비밀번호가 서로 일치하지 않습니다");
		 		document.fr.pass2.value="";
		 		document.fr.pass2.focus();
		 		return;
		 	} else {
				if (document.fr.email.value.match(mailReg) == null) {
					alert("이메일 양식이 올바르지 않습니다");
					document.fr.mail.focus();
					return;
				} else {
					if (document.fr.email.value!=document.fr.email2.value) {
				 		alert("입력한 이메일이 서로 일치하지 않습니다");
				 		document.fr.email2.value="";
				 		document.fr.email2.focus();
				 		return;
				 	}
				}
		 	}
		}
	 }
	document.fr.submit();
}
</script>
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
<form action="joinPro.jsp" method="post" id="join" name="fr">
	<fieldset style="width: 500px; position:absolute; left: 50%; margin-left: -250px">
		<legend>회원가입</legend>
			<table id="table02">
			<tr>
			<th>아이디</th><td><input type="text" name="id" style="width: 200px;" placeholder="4 ~ 16자리 영문, 숫자" required><input type="button" value="중복체크" class="dup" onclick="duplicateCheck()"><br></td>
			</tr>
			<tr>
			<th>비밀번호</th><td><input type="password" name="pass" style="width: 200px;" placeholder="8 ~ 16자리 영문, 숫자, 특수문자(! @ # $ % ^ & + =)" required></td>
			</tr>
			<tr>
			<th>비밀번호 확인</th><td><input type="password" style="width: 200px;" name="pass2" required></td>
			</tr>
			<tr>
			<th>이름</th><td><input type="text" name="name" style="width: 200px;" required></td>
			</tr>
			<tr>
			<th>이메일</th><td><input type="email" name="email" style="width: 200px;" required></td>
			</tr>
			<tr>
			<th>이메일 확인</th><td><input type="email" name="email2" style="width: 200px;" required></td>
			</tr>
			<tr>
			<th>연락처</th><td><input type="text" name="mobile" style="width: 200px;" required></td>
			</table>
		<table id="table02">
		<tr>
		<th>주소</th><td><input type="text" id="postcode" name="postcode" placeholder="우편번호" style="width: 90px;">
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="address" name="address" placeholder="주소" style="width: 200px;"><br>
					<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" style="width: 200px;">
					
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
		</table><br>
		<p style="text-align: center"><input type="button" value="회원가입" onclick="joinCheck()"> <input type="reset" value="초기화" class="cancel"></p>
	</fieldset>
</form>
</body>
</html>