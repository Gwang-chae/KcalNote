package com.hanwha.myapp.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanwha.myapp.service.ReplyService;
import com.hanwha.myapp.vo.ReplyVO;

@Controller
public class ReplyController {
	@Inject
	ReplyService service;
	
	// 댓글 쓰기
	@RequestMapping(value="/replyWrite", method=RequestMethod.POST)
	@ResponseBody
	public int replyWrite(ReplyVO vo, HttpServletRequest request, HttpSession session) {
		vo.setUserid((String)session.getAttribute("logId"));
		
		int result = service.replyInsert(vo);
		return result;
	}
	
	// 게시글의 댓글들 목록 가져오기
	@RequestMapping("/replyAllList")
	@ResponseBody
	public List<ReplyVO> replyAllSelect(int no) {
		return service.replyAllSelect(no);
	}
	
	// 댓글 수정
	@RequestMapping(value="/replyEditOk", method=RequestMethod.POST)
	@ResponseBody
	public int replyUpdate(ReplyVO vo) {
		return service.replyUpdate(vo);
	}
	
	// 댓글 삭제
	@RequestMapping("/replyDelete")
	@ResponseBody
	public int replyDelete(int replyno) {
		return service.replyDelete(replyno);
	}
}
