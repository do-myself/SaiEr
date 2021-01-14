package com.demo.interceptor;

import com.demo.entity.User;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("userInfo");

        //初次登录或注销登录时放行
        if(request.getRequestURI().contains("toLogin") || request.getRequestURI().contains("login.action")){
            return true;
        }

        if(user==null){
            response.sendRedirect(request.getContextPath()+"/401.jsp");
            return false;
        }
        return true;
    }
}
