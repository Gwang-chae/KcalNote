<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/frame.jspf"%>

<style>
	#paging{
		position:relative;
		left:40%;
		padding:50px 0px 0px 0px;
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
	#searchArea{
		padding-top:5px;
		padding-bottom:15px;
		position:relative;
		left:36%;
	}
	#selectpicker{
		height:35px;
	}
	#searchBoardWord{
		height:35px;
		width:200px;
	}
</style>
<script>
	$(function(){
		$("#navTitle").text("Our Diet");
		$("#navTitle").attr("href", "/myapp/main/boardList?date=${date}");
		
		$("#nav5").addClass("active");
		
		console.log("${vo.writedate}");
	});
	
	//검색어 체크
	function searchWordCheck(){
		if(document.getElementById("searchBoardWord").value==""){
			alert("검색어를 입력후 검색하세요.");
			return false;
		}
		return true;
	}
</script>
<div class="content">
	<div class="container-fluid">
		<div class="col-md-12">
			<div class="card">
				<div class="header">
                   	<h4 class="title">게시판</h4>
                   	<p class="category">식단 & 건강 관련 유용한 정보를 올려봅시다.</p>
               	</div>
				<div class="content table-responsive table-full-width">
					<table class="table table-hover table-striped">
						<thead>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th>등록일</th>
						</thead>
						<tbody>
							<c:forEach var="vo" items="${lst}">
								<tr>
									<td>${vo.no}</td>
									<td><a href="/myapp/main/boardView?date=${date}&no=${vo.no}&pageNum=${pVo.pageNum}<c:if test='${pVo.searchBoardWord!=null}'>&searchKey=${pVo.searchKey}&searchBoardWord=${pVo.searchBoardWord}</c:if>">${vo.title}</a></td>
									<td>${vo.userid}</td>
									<td>${vo.hit}</td>
									<td>${vo.writedate}</td>
                            	</tr>
							</c:forEach>
						</tbody>
					</table>
					<a class="btn btn-success btn-fill pull-right" href="/myapp/main/boardFrm?date=${date}" style="display:inline;">글쓰기</a>
				</div>
				
				 <div id="paging">
					<ul>
						<!-- 이전 페이지 -->
						<c:if test="${pVo.pageNum==1}">
							<li><a href="#">prev</a></li>
						</c:if>
						<c:if test="${pVo.pageNum>1}">
							<li><a href="/myapp/main/boardList?pageNum=${pVo.pageNum-1}&date=${date}<c:if test='${pVo.searchBoardWord!=null}'>&searchKey=${pVo.searchKey}&searchBoardWord=${pVo.searchBoardWord}</c:if>">prev</a></li>
						</c:if>
						<!-- 페이지번호 	1				1		5-->
						<!-- 			6				6		10  end는 작거나 같다라는 뜻을 가지고 있음 -->
						<c:forEach var="p" begin="${pVo.startPageNum}" end="${pVo.startPageNum + pVo.onePageCount-1}">
							<c:if test="${pVo.totalPage>=p}">
							<c:if test="${p==pVo.pageNum}">	
								<li style="background:#1DC7EA; opacity: 0.5;"><a style="color:#fff;" href="/myapp/main/boardList?pageNum=${p}&date=${date}<c:if test='${pVo.searchBoardWord!=null}'>&searchKey=${pVo.searchKey}&searchBoardWord=${pVo.searchBoardWord}</c:if>">${p}</a></li>
							</c:if>
							<c:if test="${p!=pVo.pageNum}">
								<li><a href="/myapp/main/boardList?pageNum=${p}&date=${date}<c:if test='${pVo.searchBoardWord!=null}'>&searchKey=${pVo.searchKey}&searchBoardWord=${pVo.searchBoardWord}</c:if>">${p}</a></li>
							</c:if>
							</c:if>
						</c:forEach>
						<!-- 다음 페이지 -->
						<c:if test="${pVo.pageNum<pVo.totalPage}">
							<li><a href="/myapp/main/boardList?pageNum=${pVo.pageNum+1}&date=${date}<c:if test='${pVo.searchBoardWord!=null}'>&searchKey=${pVo.searchKey}&searchBoardWord=${pVo.searchBoardWord}</c:if>">next</a></li>
						</c:if>
						<c:if test="${pVo.pageNum>=pVo.totalPage}">
							<li><a href="#">next</a></li>
						</c:if>
					</ul>
				</div>
				
				<!-- 검색어 -->
				<div id="searchArea">
					<form action="/myapp/main/boardList" id="searchForm" onsubmit="return searchWordCheck()">
						<select name="searchKey" class="selectpicker" id="selectpicker">
							<option value="title">제목</option>
							<option value="userid">작성자</option>
							<option value="content">글내용</option>
						</select>
						<input type="text" name="searchBoardWord" id="searchBoardWord"/>
						<input type="hidden" name="date" id="date" value="${date}"/>
						<button type="submit" value="Search" class="btn btn-default"><i class="fa fa-search"></i></button>
					</form>
				</div>
				
			</div>		
		</div>
	</div>
</div>

<%@ include file="/inc/frame_footer.jspf"%>