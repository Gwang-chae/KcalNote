<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/frame.jspf"%>
<div class="content">
	<div class="container-fluid">
    	<div class="row">
    		<div class="col-md-12">
            	<div class="card">
                	<div class="header">
                    	<h4 class="title">검색 결과가 존재하지 않습니다.</h4>
                    	<p class="category">다른 검색어로 검색해주세요.</p>
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
                    	</form>
                    </div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/inc/frame_footer.jspf"%>