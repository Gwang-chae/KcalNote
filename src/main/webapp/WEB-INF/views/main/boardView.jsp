<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/frame.jspf"%>
<script>
	// 삭제여부 확인한 후 페이지 이동
	function delCheck(){
		// confirm() : yes, no를 선택할 수 있는 대화상자 (true, false 반환)
		if (confirm("삭제하시겠습니까?")){
			// 확인(yes) 버튼을 선택한 경우
			// JS에서 페이지 이동(GET 방식)
			var link = "/myapp/main/boardDel?date=${date}&no=${vo.no}&pageNum=${pVo.pageNum}";
			if ("${pVo.searchBoardWord}" != ""){
				link += "&searchKey=${pVo.searchKey}&searchBoardWord=${pVo.searchBoardWord}";
			}
			location.href = link;
		}
	}
</script>
<script>
	$(function(){
		// 해당 게시글의 모든 댓글 리스트를 선택하여 변경하는 함수
		function replyAllList(){
			// 비동기식으로 서버에 접속하여 레코드를 선택(List)받아
			// view 페이지의 목록을 변경하기
			var url = "/myapp/replyAllList";
			var params1 = "no=${vo.no}" // 해당 게시글 번호
			
			$.ajax({
				type:"GET",
				url:url,
				data:params1,
				success:function(result){
					var $result = $(result);
					
					var tag = "";
					$result.each(function(i, value){
						tag += "<div class='row'><div><div class='col-md-6'><p class='category'>" + value.userid + " ("  + value.writedate + ")</p><p class='category'>"
							 + value.coment + "</p><hr/></div>";
							 
						if (value.userid == "${logId}"){
							tag += "<div class='col-md-2'><input type='button' value='삭제' title='" + value.replyno + "' class='btn btn-danger btn-fill pull-right' style='display:inline;'>";
							tag += "<input type='button' value='수정' class='btn btn-success btn-fill pull-right'/></div></div>";
							tag += "<div style='display:none'><form method='post'>"
							tag += "<div class='col-md-6'><input type='hidden' name='replyno' value='" + value.replyno + "'/>";
							tag += "<input type='text' class='form-control' name='coment' id='coment' value='" + value.coment + "'/></div>";
							// tag += "<div clas='col-md-1'><button class='btn btn-default btn-fill pull-right'>댓글 수정</button></div></form>";
							tag += "<div clas='col-md-1'><input type='submit' class='btn btn-default btn-fill' value='댓글 수정'/></div></form>";
						}
							 
						tag += "</div></div>"
					});
					
					$("#replyList").html(tag);
					
				}, error:function(e){
					console.log(e.responseText);
				}
			});
		}
		
		// 댓글 쓰기
		$("#replyBtn").click(function(){
			if($("#coment").val == ""){
				alert("댓글을 작성 후 등록해주세요.");
				return false
			}else{
				var data = $("#replyFrm").serialize();
				var url = "/myapp/replyWrite";
				$.ajax({
					type:"POST",
					url:url,
					data:data,
					success:function(result){
						$("#coment").val("");
						replyAllList();
					}, error:function(e){
						console.log(e.responseText);
					}
				});
			}
		});
		
		// 댓글 수정하기(폼 보여주기)
		// ajax로 넣은 코드는 다음과 같이 이벤트 호출
		$(document).on("click", "#replyList input[value=수정]", function(){
			// 이벤트가 발생한 input버튼의 부모 div는 숨기고
			$(this).parent().parent().css("display", "none");
			// 부모 div 다음에 있는 div는 보여준다.
			$(this).parent().parent().next().css("display", "block");
		});
		
		// 댓글 수정하기(DB 작업)
		$(document).on("submit", "#replyList form", function(){
			// 데이터
			var params2 = $(this).serialize();
			var url = "/myapp/replyEditOk";
			
			$.ajax({
				type:"POST",
				url:url,
				data:params2,
				success:function(){
					replyAllList();
				}, error:function(e){
					console.log(e.responseText);
				}
			});
			return false;
		});
		
		// 댓글 삭제
		$(document).on("click", "#replyList input[value=삭제]", function(){
			if (confirm("댓글을 삭제하시겠습니까?")){
				// 예 버튼을 선택한 경우
				var replyData = "replyno=" + $(this).attr("title");
				var url = "/myapp/replyDelete";
				
				$.ajax({
					type:"GET",
					data:replyData,
					url:url,
					success:function(result){
						replyAllList();
					}, error:function(e){
						console.log(e.responseText);
					}
				});
			}
		});
		
		// 댓글 목록 호출
		replyAllList();
		
		$("#navTitle").text("Our Diet");
		$("#navTitle").attr("href", "/myapp/main/boardList?date=${date}");
		
		$("#nav5").addClass("active");
	});


</script>
<div class="content">
	<div class="container-fluid">
    	<div class="card">
    		<div class="row">
	        	<div class="col-md-12">
	        		<div class="header">
	        			<h4 class="title"> ${vo.no}. ${vo.title}</h4>
		                <p class="category">${vo.userid} ${vo.writedate}</p>
		                <p class="category">조회수 : ${vo.hit}</p>
	        		</div>
	        		<hr/>
	        		<div class="content">
	        			<div class="row">
	        				<div class="col-md-12">
	        					<div class="card">
	        						<p>${vo.content}</p>
	        					</div>
	        				</div>
	        			</div>
	        			<c:if test="${vo.userid == logId}">
							<button class="btn btn-primary btn-danger pull-right" onclick="location.href = 'javascript:delCheck()'">삭제</button>
							<button id="boardBtn" class="btn btn-info btn-success pull-right" onclick="location.href = '/myapp/main/boardEdit?date=${date}&no=${vo.no}'"style="display:inline;">수정</button>
						</c:if>
						<br/>
	        		</div>
	        	</div>
	        </div>
    	</div>
    	
    	<!-- 댓글 영역 -->
    	<div class="card">
	        <div class="row">
	        	<div class="col-md-12">
	        		<div class="header">
	        			<p class="category">댓글</p>
	        		</div>
	        		<div class="content">
	        			<div class="row">
	        				<form method="post" id="replyFrm" class="form-group">
		        				<div class="col-md-6">
									<!-- 원글 글번호 -->
									<input type="hidden" name="no" value="${vo.no}"/>
									<input type="text" class="form-control" name="coment" id="coment"/>
								</div>
								<div class="col-md-1">
									<button id="replyBtn" class="btn btn-default btn-fill pull-right">댓글쓰기</button>
								</div>
							</form>
						</div>
						<br/>
						<br/>
						
						
						<div id="replyList">
							<div class="row">
								<div>
									<div class="col-md-6">
										<p class="category">아이디 (시간)</p>
										<p class="category">댓글내용</p>
										<hr/>
									</div>
									<div class="col-md-1">
										<button id="replyBtn" class="btn btn-primary btn-fill pull-right">수정</button>
									</div>
									<div class="col-md-1">
										<button id="replyBtn" class="btn btn-info btn-fill pull-right">삭제</button>
									</div>
								</div>
								
								<!-- 수정폼 눌렀을때 보여질 부분-->
								<div style='display:none'>
									<form method='post'>
										<div class="col-md-6">
											<input type='hidden' name='replyno' value='" + value.replyno + "'/>
											<input type="text" class="form-control" name="coment" id="coment" value='" + value.coment + "'/>
										</div>
										<div class="col-md-1">
											<button type="submit" class="btn btn-default btn-fill pull-right">댓글 수정</button>
										</div>
									</form>
								</div>
							</div>
							
							<div class="row">
								<div class="col-md-6">
									<p class="category">아이디 (시간)</p>
									<p class="category">댓글내용</p>
									<hr/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<p class="category">아이디 (시간)</p>
									<p class="category">댓글내용</p>
									<hr/>
								</div>
							</div>
						</div>
					</div>
	        	</div>
	        </div>
	    </div>
    </div>
</div>
<%@ include file="/inc/frame_footer.jspf"%>