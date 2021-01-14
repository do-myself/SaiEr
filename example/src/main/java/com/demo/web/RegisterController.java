package com.demo.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/*
 * 忘记密码的业务逻辑
 */
@Controller
public class RegisterController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="forget",method=RequestMethod.GET)
	public String forget(){
		return "request1";
	}
	
	@RequestMapping(value="register",method=RequestMethod.GET)
	public String forgetpwd(@RequestParam("firstname")String firstname) {
		logger.info("forgetpwd method is processing");
		if(firstname=="admin") {
			logger.info("password is..... ");
		}
		return "pwd";
	}
	
	@RequestMapping(value="lkup",method=RequestMethod.POST)
	public String forgetpassword() {
		logger.info("forgetpwd method is processing");
		logger.info("password is..... ");
        //跳转页面
		return "pwd";
	}
}

