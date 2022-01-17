package com.hanwha.myapp.service;

import java.util.List;

import com.hanwha.myapp.vo.BoardVO;
import com.hanwha.myapp.vo.InfoVO;
import com.hanwha.myapp.vo.PagingVO;

public interface MainService {
	public int totalRecord(PagingVO pVo);
	public List<InfoVO> infoList(PagingVO pVo);
	public List<InfoVO> infoAllList(PagingVO pVo);
	public int foodInsert(String session, String foodid, String date);
	public List<InfoVO> noteList(String userid, String date);
	public int noteDelete(int noteid);
	public int noteUpdate(int noteid, double quantity);
	public List<InfoVO> weekKcal(String userid, String date);
	public int infoInsert(InfoVO vo);
	
	public List<BoardVO> boardList(PagingVO pVo);
	public int boardWriteOk(BoardVO vo);
	public int boardHitCount(int no);
	public BoardVO boardView(int no);
	public int boardEditOk(BoardVO vo);
	public int boardDel(int no, String userid);
	
	public int totalReplyRecord(PagingVO pVo);
}
