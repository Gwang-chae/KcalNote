<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/frame.jspf"%>

<script>
	$(function(){
		CKEDITOR.replace("content");
		
		$("#editFrm").submit(function(){
			if ($("#title").val() == ""){
				alert("제목을 입력 후 수정하세요.");
				return false;
			}
			if (CKEDITOR.instances.content.getData() == ""){
				alert("글 내용을 입력 후 수정하세요.");
				return false;
			}
			return true;
		});
		
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
	        			<h4 class="title">글 수정하기</h4>
	        		</div>
	        		<div class="content">
						<div class="row">
							<div class="col-md-11">
								<form id="editFrm" method="post" action="/myapp/main/boardEditOk?date=${date}" class="form-group">
									<input type="hidden" name="no" value="${vo.no}"/>
									<label>제목</label>
									<input class="form-control" type="text" name="title" id="title" value="${vo.title}" size="80">
									<label>글내용</label>
									<textarea name="content" id="content">${vo.content}</textarea>
									<br/>
									<button type="submit" id="boardBtn" class="btn btn-info btn-fill pull-right" style="display:inline;">글 수정하기</button>
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