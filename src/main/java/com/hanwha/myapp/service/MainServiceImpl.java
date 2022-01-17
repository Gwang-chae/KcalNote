package com.hanwha.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.hanwha.myapp.dao.MainDAO;
import com.hanwha.myapp.vo.BoardVO;
import com.hanwha.myapp.vo.InfoVO;
import com.hanwha.myapp.vo.PagingVO;

@Service
public class MainServiceImpl implements MainService {
	@Inject
	MainDAO dao;

	@Override
	public int totalRecord(PagingVO pVo) {
		return dao.totalRecord(pVo);
	}

	@Override
	public List<InfoVO> infoList(PagingVO pVo) {
		return dao.infoList(pVo);
	}
	
	@Override
	public int foodInsert(String session, String foodid, String date) {
		return dao.foodInsert(session, foodid, date);
	}
	
	@Override
	public List<InfoVO> noteList(String userid, String date) {
		return dao.noteList(userid, date);
	}

	@Override
	public int noteDelete(int noteid) {
		return dao.noteDelete(noteid);
	}

	@Override
	public int noteUpdate(int noteid, double quantity) {
		return dao.noteUpdate(noteid, quantity);
	}

	@Override
	public List<InfoVO> weekKcal(String userid, String date) {
		return dao.weekKcal(userid, date);
	}

	@Override
	public List<InfoVO> infoAllList(PagingVO pVo) {
		return dao.infoAllList(pVo);
	}

	@Override
	public int infoInsert(InfoVO vo) {
		return dao.infoInsert(vo);
	}

	@Override
	public List<BoardVO> boardList(PagingVO pVo) {
		return dao.boardList(pVo);
	}

	@Override
	public int boardWriteOk(BoardVO vo) {
		return dao.boardWriteOk(vo);
	}

	@Override
	public int boardHitCount(int no) {
		return dao.boardHitCount(no);
	}

	@Override
	public BoardVO boardView(int no) {
		return dao.boardView(no);
	}

	@Override
	public int boardEditOk(BoardVO vo) {
		return dao.boardEditOk(vo);
	}

	@Override
	public int boardDel(int no, String userid) {
		return dao.boardDel(no, userid);
	}

	@Override
	public int totalReplyRecord(PagingVO pVo) {
		return dao.totalReplyRecord(pVo);
	}

}
