<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link href="../inc/top.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<header>
<nav id="nav">
 <ul>
  <li class="dropdown" ><a href="../main/main.jsp" class="dropbtn">HOME</a></li>
  <li class="dropdown"><a href="javascript:void(0)" class="dropbtn">SUMMARY</a>
   <div class="dropdown-content">
    <a href="../board/list.jsp?boardName=java&pageNum=1">JAVA</a>
    <a href="../board/list.jsp?boardName=jsp&pageNum=1">JSP</a>
    <a href="../board/list.jsp?boardName=oracle&pageNum=1">ORACLE DB</a>
    <a href="../board/list.jsp?boardName=css&pageNum=1">HTML5/CSS</a>
   </div>
  </li>
  <li class="dropdown" ><a href="../library/list.jsp?boardName=library&pageNum=1" class="dropbtn">LIBRARY</a></li>
  <li class="dropdown"><a href="javascript:void(0)" class="dropbtn">BOARD</a>
   <div class="dropdown-content">
    <a href="../board/list.jsp?boardName=freeboard&pageNum=1">FreeBoard</a>
    <a href="../gallery/list.jsp?boardName=gallery&pageNum=1">Gallery</a>
   </div>
  </li>
  <li class="dropdown"><a href="javascript:void(0)" class="dropbtn">CONTACT</a></li>
 <% if (session.getAttribute("id")==null) {%>
   <li class="dropdown" style="margin-left: 575px"><a href="../member/loginForm.jsp" class="dropbtn">LOGIN</a></li>
   <li class="dropdown" ><a href="../member/joinForm.jsp" class="dropbtn">JOIN</a></li>
 <%} else if (session.getAttribute("grade").equals("admin") || session.getAttribute("grade").equals("instructor")) {%>
   <li class="dropdown" style="margin-left: 500px"><a href="../member/logout.jsp" class="dropbtn">LOGOUT</a></li>
   <li class="dropdown" ><a href="../member/info.jsp" class="dropbtn">INFO</a></li>
   <li class="dropdown" ><a href="../member/list.jsp" class="dropbtn">LIST</a></li>
 <%} else { %>
   <li class="dropdown" style="margin-left: 555px"><a href="../member/logout.jsp" class="dropbtn">LOGOUT</a></li>
   <li class="dropdown" ><a href="../member/info.jsp" class="dropbtn">INFO</a></li>
 <%} %>
 </ul>
 </nav>
</header>
