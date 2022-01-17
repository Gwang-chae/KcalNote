<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/frame.jspf"%>
<script>
	$(function(){
		$("#aFrm").submit(function(){
			// 음식 이름 유효성 검사
			reg = /^[a-zA-Z0-9가-힣\(\)/\s]{1,25}$/;
			if (!reg.test($("#name").val())){
				alert("음식 이름을 잘못 입력하였습니다.");
				return false;
			}
			// 1회 제공량 유효성 검사
			reg = /^[0-9]{1,5}$/;
			if (!reg.test($("#servingwt").val())){
				alert("1회 제공량을 잘못 입력하였습니다.");
				return false;
			}
			// 칼로리 유효성 검사
			reg = /^[0-9]{1,5}$/;
			if (!reg.test($("#kcal").val())){
				alert("칼로리를 잘못 입력하였습니다.");
				return false;
			}
			// 탄수화물 유효성 검사
			reg = /^[0-9]{1,5}$/;
			if (!reg.test($("#carbo").val())){
				alert("탄수화물을 잘못 입력하였습니다.");
				return false;
			}
			// 단백질 유효성 검사
			reg = /^[0-9]{1,5}$/;
			if (!reg.test($("#protein").val())){
				alert("단백질을 잘못 입력하였습니다.");
				return false;
			}
			// 지방 유효성 검사
			reg = /^[0-9]{1,5}$/;
			if (!reg.test($("#fat").val())){
				alert("지방을 잘못 입력하였습니다.");
				return false;
			}
			return true;
		});
		
		$("#navTitle").text("Add Foodinfo");
		$("#navTitle").attr("href", "/myapp/main/addForm?date=${date}");
		
		$("#nav4").addClass("active");
	});
</script>

<div class="content">
    <div class="container-fluid">
	    <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="header">
                        <h4 class="title">음식정보 추가하기</h4>
                        <p class="category">추가할 음식정보를 입력해주세요.</p>
                    </div>
                    <div class="content">
                    	<form method="post" action="<%=request.getContextPath()%>/main/addOk" id="aFrm">
	                    	<div class="row">
	                    		<div class="col-md-6">
	                            	<div class="form-group">
	                            		<label>음식 이름</label>
	                                	<input type="text" class="form-control" maxlength="25" name="name" id="name">
	                            	</div>
	                            </div>
	                            <div class="col-md-6">
	                            	<div class="form-group">
	                            		<label>1회 제공량(g)</label>
	                                	<input type="text" class="form-control" maxlength="5" name="servingwt" id="servingwt">
	                            	</div>
	                            </div>
	                    	</div>
	                    	<div class="row">
	                    		<div class="col-md-3">
	                    			<div class="form-group">
	                            		<label>칼로리(kcal)</label>
	                                	<input type="text" class="form-control" maxlength="5" name="kcal" id="kcal">
	                            	</div>
	                    		</div>
	                    		<div class="col-md-3">
	                    			<div class="form-group">
	                            		<label>탄수화물(g)</label>
	                                	<input type="text" class="form-control" maxlength="5" name="carbo" id="carbo">
	                            	</div>
	                    		</div>
	                    		<div class="col-md-3">
	                    			<div class="form-group">
	                            		<label>단백질(g)</label>
	                                	<input type="text" class="form-control" maxlength="5" name="protein" id="protein">
	                            	</div>
	                    		</div>
	                    		<div class="col-md-3">
	                    			<div class="form-group">
	                            		<label>지방(g)</label>
	                                	<input type="text" class="form-control" maxlength="5" name="fat" id="fat">
	                            	</div>
	                    		</div>
	                    	</div>
	                    	<div class="row">
	                    		<div class="col-md-12">
	                    			<div class="form-group">
	                    				<label>회사명</label>
	                                	<input type="text" class="form-control" maxlength="25" name="company" id="company">
	                    			</div>
	                    		</div>
	                    	</div>
	                    	<input type="hidden" name="date" id="date" value="${date}"/>
	                    	<button type="submit" class="btn btn-success btn-fill pull-right">음식정보추가</button>
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