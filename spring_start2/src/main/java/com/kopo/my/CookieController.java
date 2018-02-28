package com.kopo.my;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CookieController {

	@RequestMapping("/cookie/make.do")
	public String make(HttpServletResponse response) {
		response.addCookie(new Cookie("auth", "1"));
		return "cookie/made";
	}
	
	@RequestMapping("/cookie/view.do")
	public String view(@CookieValue(value = "auth", defaultValue = "0") String auth) {
		System.out.println("auth 쿠키: " + auth);
		return "cookie/view";
	}
	
	@RequestMapping(value = "/check/cookie", method = RequestMethod.GET)
	protected String cookieCheck(@CookieValue(value="testCookie", required=false, defaultValue="") String testCookie) {            
	    System.out.println("testCookie=="+testCookie);
	    return "home";
	}
	
	// 쿠키 생성
	@RequestMapping(value="/setC", method=RequestMethod.GET)
	public String testCookie(HttpServletResponse response){

		Cookie setCookie = new Cookie("name", "1"); // 쿠키 생성	
		setCookie.setMaxAge(60*60); // 기간을 1시간으로 지정
		response.addCookie(setCookie);
		
		return "board/listAll";
	}
	
	// 쿠키 가져오기
	@RequestMapping(value="/getC", method=RequestMethod.GET)
	public String testCookie(HttpServletRequest request){
	
		Cookie[] getCookie = request.getCookies();
	
		if(getCookie != null){
	
			for(int i=0; i<getCookie.length; i++){
		
				Cookie c = getCookie[i];		
				String name = c.getName();	// 쿠키 이름 가져오기		
				String value = c.getValue();// 쿠키 값 가져오기
				System.out.println("name: " + name + " value : " + value);	
			}
		}		
		return "board/listAll";
	}
	
	@RequestMapping(value="/co", method=RequestMethod.GET)
	public String cookie(){
	
		return "cookie";
	}
	
	@RequestMapping(value="/co", method=RequestMethod.POST)
	public String cookieP(){
	
		return "cookie";
	}
}
