<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>KcalNote</title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link href="https://fonts.googleapis.com/css2?family=Tinos:ital,wght@0,400;0,700;1,400;1,700&amp;display=swap" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,700;1,400;1,500;1,700&amp;display=swap" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="/myapp/resources/css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script>
			function logChk(){
				if(document.getElementById("userid").value==""){
					document.getElementById("emptyId").style.display = "block";
					document.getElementById("emptyPwd").style.display = "none";
					return false;
				}
				if(document.getElementById("userpwd").value==""){
					document.getElementById("emptyId").style.display = "none";
					document.getElementById("emptyPwd").style.display = "block";
					return false;
				}
				return true;
			}
			
			$(function(){
				$("#logoTitle").click(function(){
					location.href = "/myapp/member/loginForm";
				});
			});
		</script>
		<style>
			#logo img{
				width:200px;
				height:200px;
			}
			#emptyId{
				display:none;
				color:red;
			}
			#emptyPwd{
				display:none;
				color:red;
			}
			#registerButton
		</style>
    </head>
    <body>
        <!-- Background Video-->
        <video class="bg-video" playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop"><source src="/myapp/resources/assets/mp4/bg5_qhd.mp4" type="video/mp4" /></video>
        <!-- Masthead-->
        <div class="masthead">
            <div class="masthead-content text-white">
                <div class="container-fluid px-4 px-lg-0">
					<h1 class="fst-italic lh-1 mb-4" id="logoTitle">KcalNote</h1>
					<form method="post" action="/myapp/member/loginCheck" onsubmit="return logChk()">
						<input class="form-control" name="userid" id="userid" type="text" placeholder="아이디" maxlength="15"/><br/>
						<input class="form-control" name="userpwd" id="userpwd" type="password" placeholder="비밀번호" maxlength="15"/><br/>
						<div>
							<input class="btn btn-primary" id="submitButton" type="submit" value="로그인"/>
							<a class="btn btn-primary" id="registerButton" href="/myapp/member/memberFrm">회원가입</a>
						</div>
					</form>
					<br/>
					<span id="emptyId">*** 아이디를 입력하세요. ***</span>
					<span id="emptyPwd">*** 비밀번호를 입력하세요. ***</span>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>
