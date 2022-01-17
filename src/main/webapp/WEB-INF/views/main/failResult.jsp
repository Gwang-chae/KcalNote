<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	alert("${msg}에 실패하였습니다.");
	// history.forward() : 다음 페이지
	// history.go() : -1:이전 페이지, 1:다음 페이지
	history.back(); // 이전페이지
</script>