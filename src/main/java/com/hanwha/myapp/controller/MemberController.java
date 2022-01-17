package com.hanwha.myapp.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.hanwha.myapp.service.MemberService;
import com.hanwha.myapp.vo.MemberVO;

@Controller
public class MemberController {
	@Inject
	MemberService service;
	
	LocalDate now = LocalDate.now();
	
	// 로그인 폼 이동
	@RequestMapping("/member/loginForm")
	public String login() {
		return "member/loginForm";
	}
	
	// 회원가입 폼 이동
	@RequestMapping("/member/memberFrm")
	public String memberFrm() {
		return "member/memberForm";
	}
	
	// 회원가입 (post)
	@RequestMapping(value="/member/memWrite", method=RequestMethod.POST)
	public ModelAndView memberWrite(MemberVO vo) {
		
		ModelAndView mav = new ModelAndView();
		
		// DB에 회원가입이 완료되면(result>0) 로그인 페이지로,
		// 회원가입에 실패하면 실패 메세지와 함께 다시 회원가입 폼 페이지로
		try {
			int result = service.memberInsert(vo);
			System.out.println(result);
			if (result > 0) {
				mav.setViewName("member/loginForm");
			}else {
				mav.setViewName("member/memberResult");
			}
			
		}catch(Exception e) {
			mav.setViewName("member/memberResult");
		}
		return mav;
	}
	
	// 로그인 확인(Session)
	@RequestMapping(value="/member/loginCheck", method=RequestMethod.POST)
	public ModelAndView loginCheck(MemberVO vo, HttpSession session) {
		System.out.println(session.getId());
		ModelAndView mav = new ModelAndView();
		// DB조회 (select)
		// logVO가 null이면 로그인 실패 -> loginForm으로
		MemberVO logVO = service.memberLogin(vo);
		if (logVO == null) {
			mav.setViewName("redirect:loginForm");
		}else {
			// 로그인에 성공하면 session 값 저장
			// setAttribute(변수명, 값)
			session.setAttribute("logId", logVO.getUserid());
			session.setAttribute("logName", logVO.getUsername());
			session.setAttribute("logStatus", "Y");
			
			// 로그인했으니 redirect -> main 페이지로
			mav.setViewName("redirect:../main/main");
		}
		return mav;	
	}
	
	// 로그아웃
	@RequestMapping("/member/logout")
	public ModelAndView logout(HttpSession session) {
		// session ����� : �α��� ������ ������, ���ο� session�� �Ҵ��
		session.invalidate();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
	}
	
	// 회원정보 수정 폼
	@RequestMapping("/member/memberEdit")
	public ModelAndView memberEdit(HttpSession session, HttpServletRequest request) {
		
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		
		ModelAndView mav = new ModelAndView();
		String userid = (String)session.getAttribute("logId");
		MemberVO vo = service.getMember(userid);
		
		mav.addObject("date", date);
		mav.addObject("vo", vo);
		mav.setViewName("member/memberEdit");
		
		return mav;
	};
	
	// 회원정보 수정
	@RequestMapping(value="/member/memberEditOk", method=RequestMethod.POST)
	public ModelAndView memberEditOk(MemberVO vo, HttpSession session, HttpServletRequest request) {
		// session�� �α��� ���̵�� ���� �Է��� ��й�ȣ�� ��ġ�� ���� ����
		vo.setUserid((String)session.getAttribute("logId"));
		
		service.memberUpdate(vo);
		ModelAndView mav = new ModelAndView();
		
		// 날짜
		String date = request.getParameter("date");
		if (date == null || date.length() == 0) {
			date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		mav.addObject("date", date);
		mav.setViewName("redirect:/main/main");
		
		return mav;
		
	}
}
