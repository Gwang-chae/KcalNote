<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/frame.jspf"%>
<script>
	$(function(){
		$("#mFrm").submit(function(){
			console.log("${vo.userpwd}");
			//아이디-> 문자, 숫자, 8~15글자까지
			if($("#userpwd").val()==""){ // true: 조건에 맞을 때, false:조건에 맞지 않을 때
				alert("비밀번호를 입력하세요.")
				return false;
			}
			// 성별 유효성 검사
			reg = /^[MF]$/;
			if (!reg.test($("#gender").val())){
				alert("성별은 대문자 M 또는 F로 입력해주세요.");
				return false;
			}
			return true;
		});
		
		$("#navTitle").text("User Profile");
		$("#navTitle").attr("href", "/myapp/member/memberEdit?date=${date}");
		
		$("#nav2").addClass("active");
	});
</script>
<div class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="header">
                        <h4 class="title">회원정보수정</h4>
                        <p class="category">수정 후 현재 비밀번호를 입력해주세요.</p>
                    </div>
                    <div class="content">
                        <form method="post" action="<%=request.getContextPath()%>/member/memberEditOk" id="mFrm">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>아이디</label>
                                        <input type="text" class="form-control" disabled id="userid" name="userid" maxlength="15" value="${vo.userid}">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>비밀번호</label>
                                        <input type="password" class="form-control" name="userpwd" id="userpwd" maxlength="15"/>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>이름</label>
                                        <input type="text" class="form-control" name="username" id="username" value="${vo.username}" readonly/>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>나이</label>
                                        <input type="text" class="form-control" name="age" id="age" value="${vo.age}"/>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>성별</label>
                                        <input type="text" class="form-control" name="gender" id="gender" value="${vo.gender}" readonly/>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>키(cm)</label>
                                        <input type="text" class="form-control" name="height" id="height" value="${vo.height}"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>몸무게(kg)</label>
                                        <input type="text" class="form-control" name="weight" id="weight" value="${vo.weight}"/>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>이메일</label>
                                        <input type="text" class="form-control" name="email" id="email" value="${vo.email}"/>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="date" id="date" value="${date}"/>
                            <button type="submit" class="btn btn-success btn-fill pull-right">회원정보수정</button>
                            <button type="reset"  class="btn btn-warning btn-fill pull-right">다시쓰기</button>
                            <div class="clearfix"></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/inc/frame_footer.jspf"%>