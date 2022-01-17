package com.hanwha.myapp.dao;

import java.util.List;

import com.hanwha.myapp.vo.ReplyVO;

public interface ReplyDAO {
	public int replyInsert(ReplyVO vo);
	public List<ReplyVO> replyAllSelect(int vo);	// 댓글 가져오기
	public int replyUpdate(ReplyVO vo);				// 댓글 수정하기
	public int replyDelete(int replyno);			// 댓글 삭제하기
}
