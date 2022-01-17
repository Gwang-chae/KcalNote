package com.hanwha.myapp.dao;

import java.util.List;

import com.hanwha.myapp.vo.ReplyVO;

public interface ReplyDAO {
	public int replyInsert(ReplyVO vo);
	public List<ReplyVO> replyAllSelect(int vo);	// ��� ��������
	public int replyUpdate(ReplyVO vo);				// ��� �����ϱ�
	public int replyDelete(int replyno);			// ��� �����ϱ�
}
