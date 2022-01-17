package com.hanwha.myapp.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.hanwha.myapp.service.MainService;
import com.hanwha.myapp.service.MemberService;
import com.hanwha.myapp.vo.BoardVO;
import com.hanwha.myapp.vo.InfoVO;
import com.hanwha.myapp.vo.MemberVO;
import com.hanwha.myapp.vo.PagingVO;

@Controller
public class MainController {
	@Inject
	MainService service;
	
	@Inject
	MemberService memberservice;
	
	LocalDate now = LocalDate.now();
	
	// 메인페이지
	@RequestMapping("/main/main")
	public ModelAndView main(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String userid = (String)session.getAttribute("logId");
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		
		// 음식을 고르고 넘어왔을 때
		String[] fid = request.getParameterValues("foodid");
		if (fid != null) {
			// checkbox 정보가 넘어온다.
			for (String foodid:fid) {
				// checkbox 정보를 DB에 저장
				service.foodInsert(userid, foodid, date);
			}
		}

		// 해당 유저가 최근 7일간 섭취한 칼로리를 보여준다.
		List<InfoVO> wKcal = service.weekKcal(userid, date);
		
		// 해당 유저가 (해당 날짜)에 먹은 음식을 보여준다.
		List<InfoVO> lst = service.noteList(userid, date);
		
		// 기초대사량, 권장섭취량 계산을 위해 유저정보 가져오기 (MemberService에서)
		MemberVO member = memberservice.getMember(userid);
		
		mav.addObject("wKcal", wKcal);
		mav.addObject("member", member);
		mav.addObject("date", date);
		mav.addObject("lst", lst);
		mav.setViewName("/main/main");
		return mav;
	}
	
	// 음식검색
	@RequestMapping("/main/search")
	public ModelAndView searchList(PagingVO pVo, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}

		// 페이징 처리를 위해 해당 키워드의 레코드 수 가져오기
		pVo.setTotalRecord(service.totalRecord(pVo));

		List<InfoVO> lst = service.infoList(pVo);
		
		mav.addObject("date", date);
		mav.addObject("lst", lst);
		mav.addObject("pVo", pVo);
		if (lst.size() == 0) {
			mav.setViewName("/main/searchFail");
		}else {
			mav.setViewName("/main/search");
		}
		return mav;
	}
	
	// 음식검색
	@RequestMapping("/main/searchAll")
	public ModelAndView searchAllList(PagingVO pVo, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}

		// 페이징 처리를 위해 해당 키워드의 레코드 수 가져오기
		pVo.setTotalRecord(service.totalRecord(pVo));
		
		List<InfoVO> lst = service.infoAllList(pVo);
		mav.addObject("date", date);
		mav.addObject("lst", lst);
		mav.addObject("pVo", pVo);
		if (lst.size() == 0) {
			mav.setViewName("/main/searchFail");
		}else {
			mav.setViewName("/main/searchAll");
		}
		return mav;
	}
	
	// 음식삭제
	@RequestMapping("/main/delete")
	public ModelAndView foodDelete(int noteid, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		// 보고있는 페이지의 날짜
		String date = request.getParameter("date");
		
		// 삭제버튼을 누른 record 삭제
		service.noteDelete(noteid);
		
		if (date.length() > 0) {
			mav.setViewName("redirect:main?date=" + date);
		}else { // date가 ""인 경우는 현재 날짜의 main페이지를 보고 있을 때
			mav.setViewName("redirect:main?date=" + now);
		}
		return mav;
	}
	
	// 음식 섭취량 수정
	@RequestMapping("/main/update")
	public ModelAndView foodUpdate(int noteid, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		// 보고있는 페이지의 날짜
		String date = request.getParameter("date");
		
		// 섭취량 정보 받기
		String q = request.getParameter("quantity");
		double quantity = Double.valueOf(q);

		// DB에서 섭취량 정보 수정
		service.noteUpdate(noteid, quantity);
		
		if (date.length() > 0) {
			mav.setViewName("redirect:main?date=" + date);
		}else { // date가 ""인 경우는 현재 날짜의 main페이지를 보고 있을 때
			mav.setViewName("redirect:main?date=" + now);
		}
		return mav;
	}
	
	// 음식 추가 폼
	@RequestMapping("/main/addForm")
	public ModelAndView addForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		mav.addObject("date", date);
		mav.setViewName( "/main/addForm");
		return mav;
	}
	
	// 음식 추가
	@RequestMapping("/main/addOk")
	public ModelAndView infoInsert(InfoVO vo, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		mav.addObject("date", date);
		
		try {
			int result = service.infoInsert(vo);
			if (result > 0) {
				mav.setViewName("redirect:main");
			}else {
				mav.addObject("msg", "회원등록");
				mav.setViewName("/main/failResult");
			}
			
		}catch(Exception e) {
			mav.setViewName("/member/addResult");
		}
		return mav;
	}
	
	// 게시판 리스트
	@RequestMapping("/main/boardList")
	public ModelAndView boardList(PagingVO pVo, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		pVo.setTotalRecord(service.totalReplyRecord(pVo));
		
		List<BoardVO> lst = service.boardList(pVo);
		
		mav.addObject("date", date);
		mav.addObject("lst", lst);
		mav.addObject("pVo", pVo);
		mav.setViewName("main/boardList");
		return mav;
	}
	
	// 게시글 작성 폼
	@RequestMapping("/main/boardFrm")
	public ModelAndView boardForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		
		mav.addObject("date", date);
		mav.setViewName("/main/boardForm");
		return mav;
	}
	
	// 게시글 작성
	@RequestMapping(value="/main/boardFormOk", method=RequestMethod.POST)
	public ModelAndView boardWriteOk(HttpServletRequest request) {
		BoardVO vo = new BoardVO();
		vo.setTitle(request.getParameter("title"));
		vo.setContent(request.getParameter("content"));
		
		HttpSession session = request.getSession(); // session ��ü �� �α��� ���̵� get
		vo.setUserid((String)session.getAttribute("logId"));
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		
		int result = 0;
		try {
			result = service.boardWriteOk(vo);
		}catch(Exception e){}
				
		ModelAndView mav = new ModelAndView();
		mav.addObject("date", date);
		
		if (result > 0) {
			mav.setViewName("redirect:boardList");
		}else {
			mav.addObject("msg", "글 작성");
			mav.setViewName("main/failResult");
		}
		return mav;
	}
	
	// 게시글 보기
	@RequestMapping("/main/boardView")
	public String boardView(Model model, int no, PagingVO pVo, HttpServletRequest request) {
		// 해당 게시글의 조회수 올리기
		service.boardHitCount(no);
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		
		// 해당 게시글 정보 가져오기
		BoardVO vo = service.boardView(no);
		model.addAttribute("date", date);
		model.addAttribute("vo", vo);
		model.addAttribute("pVo", pVo);
		
		return "main/boardView";
	}
	
	// 게시글 수정 폼
	@RequestMapping("/main/boardEdit")
	public ModelAndView boardEdit(int no, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		
		BoardVO vo = service.boardView(no);
		mav.addObject("date", date);
		mav.addObject("vo", vo);
		mav.setViewName("/main/boardEdit");
		
		return mav;
	}
	
	// 게시글 수정
	@RequestMapping(value="/main/boardEditOk", method=RequestMethod.POST)
	public ModelAndView boardEditOk(BoardVO vo, HttpSession session, HttpServletRequest request) {
		vo.setUserid((String)session.getAttribute("logId"));
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		
		int result = 0;
		try {
			result = service.boardEditOk(vo);
		}catch(Exception e) {}
		
		ModelAndView mav = new ModelAndView();	
		mav.addObject("date", date);
		if (result > 0) {
			mav.addObject("no", vo.getNo());
			mav.setViewName("redirect:boardView");
		}else {
			mav.addObject("msg", "글 수정");
			mav.setViewName("main/failResult");
		}
		return mav;
	}
	
	// 게시글 삭제
	@RequestMapping("/main/boardDel")
	public ModelAndView boardDel(int no, PagingVO pVo, HttpSession session, HttpServletRequest request) {
		String userid = (String)session.getAttribute("logId");
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		
		int result = service.boardDel(no, userid);
		ModelAndView mav = new ModelAndView();
		mav.addObject("date", date);
		// mav.addObject("pVo", pVo);
		if (pVo.getSearchWord() != null) {
			mav.addObject("searchKey", pVo.getSearchKey());
			mav.addObject("searchWord", pVo.getSearchWord());
		}
		
		if (result > 0) {
			mav.setViewName("redirect:boardList");
		}else {
			mav.addObject("no", no);
			mav.setViewName("redirect:boardView");
		}
		return mav;
	}
}
