package com.hanwha.myapp.dao;

import java.util.List;

import com.hanwha.myapp.vo.BoardVO;
import com.hanwha.myapp.vo.InfoVO;
import com.hanwha.myapp.vo.PagingVO;

public interface MainDAO {
	// 검색 결과의 총 레코드 수 (페이징 처리용)
	public int totalRecord(PagingVO pVo);
	// 검색 결과에 해당하는 레코드 리스트
	public List<InfoVO> infoList(PagingVO pVo);
	// 모든 검색 결과에 해당하는 레코드 리스트
	public List<InfoVO> infoAllList(PagingVO pVo);
	// 체크 표시한 결과를 DB에 저장
	public int foodInsert(String session, String foodid, String date);
	// 내가 해당 날짜에 먹은 음식들 리스트
	public List<InfoVO> noteList(String userid, String date);
	// 해당 날짜의 먹은 음식을 지우기
	public int noteDelete(int noteid);
	// 해당 날짜의 음식 섭취량 수정
	public int noteUpdate(int noteid, double quantity);
	// 해당 유저가 최근 7일간 섭취한 칼로리를 보여준다.
	public List<InfoVO> weekKcal(String userid, String date);
	// 음식정보 추가하기
	public int infoInsert(InfoVO vo);
	
	
	// 게시판
	// 게시판 리스트 보기
	public List<BoardVO> boardList(PagingVO pVo);
	// 게시글 작성
	public int boardWriteOk(BoardVO vo);
	// 게시글 조회수
	public int boardHitCount(int no);
	// 해당 게시글 정보 가져오기
	public BoardVO boardView(int no);
	// 게시글 수정
	public int boardEditOk(BoardVO vo);
	// 게시글 삭제
	public int boardDel(int no, String userid);
	
	// 게시글 페이징 처리
	public int totalReplyRecord(PagingVO pVo);
}
