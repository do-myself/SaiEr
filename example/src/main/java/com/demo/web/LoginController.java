package com.demo.web;

import com.demo.entity.User;
import com.demo.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/*
 * 验证用户账号、密码，登录跳转
 */
@Controller
public class LoginController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private UserService userService;
	
	@RequestMapping(value="login.action")
	public String login(@Param("userCode") String userCode, @Param("password") String password, HttpSession session, HttpServletRequest req) {

//		System.out.println(userCode+","+password);
		User user = userService.queryUserByCode(userCode);
		if(user!=null && user.getPassword().equals(password)){
			session.setAttribute("userInfo",user);
			System.out.println("Hello,admin");
			//跳转到主界面
			return "main";
		}else{
			req.setAttribute("error","用户名或密码错误");
			return "login";
		}
	}
	
	/*
	 * 返回登录页面
	 */
	@RequestMapping(value="toLogin")
	public String toLogin() {
		return "login";
	}

	//用户注销
	@RequestMapping("/loginOut")
	public String loginOut(HttpSession session){
		session.removeAttribute("userInfo");
		return "login";
	}

	//跳到管理员信息界面
	@RequestMapping("/toAdmin")
	public String toAdmin(){
		return "adminInfo";
	}

	//跳转到主界面
	@RequestMapping("/toMain")
	public String toMain(){
		return "main";
	}
}