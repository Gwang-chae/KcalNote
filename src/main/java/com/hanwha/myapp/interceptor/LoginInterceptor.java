package com.hanwha.myapp.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) 
			throws Exception {
		HttpSession session = request.getSession();
		String logStatus = (String)session.getAttribute("logStatus");
		
		if (logStatus != null && logStatus.equals("Y")) { // 로그인 유지 시
			return true;
		}else { // 로그인 정보가 없으면 loginForm으로
			response.sendRedirect(request.getContextPath() + "/member/loginForm");
			return false; // �α��� ������ �̵��� ���
		}
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable Exception ex) throws Exception {}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, 
			@Nullable ModelAndView modelAndView) throws Exception {}
}
