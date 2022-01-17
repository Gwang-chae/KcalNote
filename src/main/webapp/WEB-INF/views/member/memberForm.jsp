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
			$(function(){
				$("#mFrm").submit(function(){
					// 아이디, 문자, 숫자, 9~15글자까지
					var userid = $("#userid").val();
					// 정규표현식 패턴
					// ^:처음부터, $:끝까지
					var reg = /^[a-zA-Z]{1}[a-zA-Z0-9_$]{7,14}$/;
					if (!reg.test(userid)){ // true:정규식을 만족, false:불만족
						alert("아이디는 첫번째 글자가 문자여야 하며 영어대소문자, 숫자, _, $만 허용됩니다.\n또한 아이디 길이는 8~15글자여야 합니다.");
						return false;
					}
					if (!reg.test($("#userpwd").val())){ // true:정규식을 만족, false:불만족
						alert("비밀번호는 첫번째 글자가 문자여야 하며 영어대소문자, 숫자, _, $만 허용됩니다.\n또한 비밀번호 길이는 8~15글자여야 합니다.");
						return false;
					}
					if ($("#userpwd").val() != $("#userpwd2").val()){
						alert("비밀번호가 일치하지 않습니다.")
						return false;
					}
					// 이름 유효성 검사
					reg = /^[가-힣]{2,7}$/;
					if (!reg.test($("#username").val())){
						alert("이름을 잘못 입력하였습니다.");
						return false;
					}
					// 나이 유효성 검사
					reg = /^[0-9]{1,2}$/;
					if (!reg.test($("#age").val())){
						alert("나이를 잘못 입력하였습니다.");
						return false;
					}
					// 성별 유효성 검사
					reg = /^[MF]$/;
					if (!reg.test($("#gender").val())){
						alert("성별은 대문자 M 또는 F로 입력해주세요.");
						return false;
					}
					// 키 유효성 검사
					reg = /^[0-9]{2,3}$/;
					if (!reg.test($("#height").val())){
						alert("키를 잘못 입력하였습니다.");
						return false;
					}
					// 몸무게 유효성 검사
					reg = /^[0-9]{1,3}$/;
					if (!reg.test($("#weight").val())){
						alert("몸무게를 잘못 입력하였습니다.");
						return false;
					}
					return true;
				});
				
				$("#logoTitle").click(function(){
					location.href = "/myapp/member/loginForm";
				});
			});
		</script>
        <style>
        	.mb-4{
        		margin-bottom:0.5rem !important;
        	}
        	.form-control{
        		margin-bottom:0.3rem;
        	}
        </style>
    </head>
    <body>
        <!-- Background Video-->
        <video class="bg-video" playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop"><source src="/myapp/resources/assets/mp4/bg2.mp4" type="video/mp4" /></video>
        <!-- Masthead-->
        <div class="masthead">
            <div class="masthead-content text-white">
                <div class="container-fluid px-4 px-lg-0">
					<h1 class="fst-italic lh-1 mb-4" id="logoTitle">KcalNote</h1>
					<p class="mb-3">회원가입</p>
					<form method="post" action="<%=request.getContextPath()%>/member/memWrite" id="mFrm">
						<input class="form-control" type="text" id="userid" name="userid" placeholder="아이디" maxlength="15"/>
						<input class="form-control" type="password" name="userpwd" id="userpwd" placeholder="비밀번호" maxlength="15"/>
						<input class="form-control" type="password" name="userpwd2" id="userpwd2" placeholder="비밀번호 확인" maxlength="15"/>
						<input class="form-control" type="text" name="username" id="username" placeholder="이름"/>
						<input class="form-control" type="text" name="age" id="age" placeholder="나이"/>
						<input class="form-control" type="text" name="gender" id="gender" placeholder="성별"/>
						<input class="form-control" type="text" name="height" id="height" placeholder="키"/>
						<input class="form-control" type="text" name="weight" id="weight" placeholder="몸무게"/>
						<input class="form-control" type="text" name="email" id="email" placeholder="이메일"/><br/>
						<div>
							<input class="btn btn-primary" id="submitButton" type="submit" value="회원등록"/>
							<input class="btn btn-primary" type="reset" value="다시쓰기"/>
						</div>
					</form>
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