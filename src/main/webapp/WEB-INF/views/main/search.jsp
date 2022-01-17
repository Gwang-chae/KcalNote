<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/frame.jspf"%>
<style>
	#paging{
		position:relative;
		left:40%;
		padding:50px 0px 20px 0px;
		margin: 0 auto;
	}
	#paging>ul{
		overflow:auto;
	}
	#paging li{
		float:left;
		width:30px;
		text-align:center;
		margin:0;
		padding:0;
		list-style-type:none;
	}
	form{display:inline;}
	button{display:inline;}
</style>
<script>
	$(function(){
		$("#navTitle").text("Table List");
		$("#navTitle").attr("href", "/myapp/main/searchAll?date=${date}");
		
		$("#nav3").addClass("active");
	});
</script>
<div class="content">
	<div class="container-fluid">
    	<div class="row">
    		<div class="col-md-12">
            	<div class="card">
                	<div class="header">
                    	<h4 class="title">${date}일 ${pVo.searchWord}에 대한 검색 결과</h4>
                    	<p class="category">총 ${pVo.totalRecord}건이 검색되었습니다.</p>
                	</div>
                 	<div class="content table-responsive table-full-width">
                    	<form method="get" action="/myapp/main/main">
	                    	<table class="table table-hover table-striped">
	                        	<thead>
	                        		<th></th>
	                            	<th>음식 이름</th>
	                         		<th>1회 제공량(g)</th>
	                         		<th>칼로리(kcal)</th>
	                         		<th>탄수화물(g)</th>
	                         		<th>단백질(g)</th>
	                         		<th>지방(g)</th>
	                         		<th>회사명</th>
	                        	</thead>
	                        	<tbody>
	                        		<c:forEach var="vo" items="${lst}">
		                            	<tr>
		                             		<td><input type="checkbox" name="foodid" value="${vo.foodid}"></td>
											<td>${vo.name}</td>
											<td>${vo.servingwt}</td>
											<td>${vo.kcal}</td>
											<td>${vo.carbo}</td>
											<td>${vo.protein}</td>
											<td>${vo.fat}</td>
											<td>${vo.company}</td>
		                            	</tr>
	                            	</c:forEach>
	                        	</tbody>
	                    	</table>
	                    	<input type="hidden" name="date" id="date" value="${date}"/>
	                    	<button type="submit" class="btn btn-success btn-fill pull-right" style="display:inline;">선택</button>
	                    	<button type="reset"  class="btn btn-warning btn-fill pull-right">다시선택</button>
                    	</form>
                    </div>
                    
                    <div id="paging">
						<ul>
							<!-- 이전 페이지 -->
							<c:if test="${pVo.pageNum==1}">
								<li><a href="#">prev</a></li>
							</c:if>
							<c:if test="${pVo.pageNum>1}">
								<li><a href="/myapp/main/search?pageNum=${pVo.pageNum-1}&date=${date}<c:if test='${pVo.searchWord!=null}'>&searchWord=${pVo.searchWord}</c:if>">prev</a></li>
							</c:if>
							<!-- 페이지번호 	1				1		5-->
							<!-- 			6				6		10  end는 작거나 같다라는 뜻을 가지고 있음 -->
							<c:forEach var="p" begin="${pVo.startPageNum}" end="${pVo.startPageNum + pVo.onePageCount-1}">
								<c:if test="${pVo.totalPage>=p}">
								<c:if test="${p==pVo.pageNum}">	
									<li style="background:#1DC7EA; opacity: 0.5;"><a style="color:#fff;" href="/myapp/main/search?pageNum=${p}&date=${date}<c:if test='${pVo.searchWord!=null}'>&searchWord=${pVo.searchWord}</c:if>">${p}</a></li>
								</c:if>
								<c:if test="${p!=pVo.pageNum}">
									<li><a href="/myapp/main/search?pageNum=${p}&date=${date}<c:if test='${pVo.searchWord!=null}'>&searchWord=${pVo.searchWord}</c:if>">${p}</a></li>
								</c:if>
								</c:if>
							</c:forEach>
							<!-- 다음 페이지 -->
							<c:if test="${pVo.pageNum<pVo.totalPage}">
								<li><a href="/myapp/main/search?pageNum=${pVo.pageNum+1}&date=${date}<c:if test='${pVo.searchWord!=null}'>&searchWord=${pVo.searchWord}</c:if>">next</a></li>
							</c:if>
							<c:if test="${pVo.pageNum>=pVo.totalPage}">
								<li><a href="#">next</a></li>
							</c:if>
						</ul>
					</div>
                    
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/inc/frame_footer.jspf"%>