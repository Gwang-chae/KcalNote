<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/frame.jspf"%>
<script>
	$(function(){
		CKEDITOR.replace("content");
		
		$("#boardBtn").click(function(){
			// 제목 유무 확인
			if ($("#title").val() == ""){
				alert("제목을 입력하세요.");
				return;
			}	
			// 글 내용 유무 확인
			if (CKEDITOR.instances.content.getData() == ""){
				alert("글 내용을 입력하세요.");
				return;
			}
			// submit
			$("#frm").submit();
		});
		console.log("====")
		console.log("${date}");
		var date = '${date}';
		console.log(date);
		$("#navTitle").text("Our Diet");
		$("#navTitle").attr("href", "/myapp/main/boardList?date=" + date);
		
		$("#nav5").addClass("active");
	});
</script>

<div class="content">
	<div class="container-fluid">
		<div class="card">
			<div class="row">
				<div class="col-md-12">
					<div class="header">
                        <h4 class="title">글쓰기</h4>
                    	<p class="category">추천 식단을 공유해봅시다.</p>
                    </div>
					<div class="content">
						<div class="row">
							<div class="col-md-11">
								<form method="post" id="frm" action="/myapp/main/boardFormOk?date=${date}" class="form-group">
									<label>제목</label>
									<input class="form-control" type="text" name="title" id="title" size="80">
									<label>글내용</label>
									<textarea name="content" id="content"></textarea>
									<br/>
									<button type="submit" id="boardBtn" class="btn btn-info btn-fill pull-right" style="display:inline;">글 등록하기</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="/inc/frame_footer.jspf"%>