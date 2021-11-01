package main;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class UserController {

	@Autowired
	@Qualifier("userservice")
	UserService service;
	
	//헤더 뷰
	@RequestMapping(value = "/header", method=RequestMethod.GET)
	public String main_view() {
		return "main/header";
	}
	
	//헤더에서 로그인
	@RequestMapping(value = "/header", method=RequestMethod.POST)
	@ResponseBody
	public String header_login(String email, String pw, HttpSession session) {
		//아이디 비밀번호 일치하는지 DB 요청
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("email", email);
		map.put("pw", pw);
		UserVO vo = service.getUserOne(map);
		
		//일치하는 회원 정보가 있다면 세션에 담기
		session.setMaxInactiveInterval(99999999);
		session.setAttribute("login_info", vo);
		
		
		//일치하는 회원 정보가 있으면 ajax 데이터 값 true
		if(vo == null) {
			return "false";
		}
		else {
			return "true";
		}
	}
	
	//로그아웃(세션 제거하기)
	@RequestMapping("/logout")
	@ResponseBody
	public void header_logout(HttpSession session) {
		session.removeAttribute("login_info");
		
		
	}
	
	//회원가입 사이트
			@RequestMapping("/join")
			public String joinPage(HttpSession session){
				String mail = (String)session.getAttribute("email");
				if (mail == null) {
					return "/joinerror";
				}else {
					return "/join/join";				
				}
				
			}

		
		
		//회원가입 과정 및 결과사이트
		@RequestMapping(value = "/join", method = RequestMethod.POST)
		public String insertUser(UserVO vo, HttpSession session) {
			
			service.insertUser(vo);
			session.removeAttribute("email");
			
			return "/join/joinresult";
		}
		
		
		//회원수정 전 확인
		
		@RequestMapping("/check")
		public String check() {
			return "/mypage/updatecheck";
		}
		
		@RequestMapping(value = "/check" , method = RequestMethod.POST) 
		public ModelAndView checkOK(UserVO vo, HttpSession session) {
			UserVO user = (UserVO) session.getAttribute("login_info");
			
			String oldPw = user.getUser_pw();
			String newPw = vo.getUser_pw();
			
			
			ModelAndView mv = new ModelAndView();
			if(!(oldPw.equals(newPw))) {
				mv.addObject("result", "false");
				mv.setViewName("/mypage/updatecheck");
				return mv;
			}
			
			mv.addObject("result", true);
			mv.setViewName("/mypage/myinform");
			return mv;
		}
		
		
		
		//회원수정사이트
		@RequestMapping("/myinform")
		public String updatePage() {
			 
			return "/mypage/myinform";
			
		}
		
		//회원 수정 후 
		@RequestMapping(value = "/myinform" , method = RequestMethod.POST)
		public String updateUser(UserVO vo, HttpSession session) {
			service.updateUser(vo);
			session.setAttribute("login_info", vo);
			
			return "/mypage/myinformresult";
		}
		
		//회원탈퇴 사이트
		@RequestMapping("/delete")
		public String deletePage() {
			return "/delete/delete";
		}
		
		
		//회원탈퇴 과정 및 결과 사이트
			@RequestMapping(value = "/delete", method = RequestMethod.POST)
			public ModelAndView deleteUser(UserVO vo, HttpSession session) {
				UserVO user = (UserVO) session.getAttribute("login_info");
				
				String oldPw = user.getUser_pw();
				String newPw = vo.getUser_pw();
				
				String oldEm = user.getUser_email();
				String newEm = vo.getUser_email();
				
				ModelAndView mv = new ModelAndView();
				
				if(!(oldPw.equals(newPw)) || !(oldEm.equals(newEm))) {
					
					mv.addObject("result", "false");
					mv.setViewName("/delete/delete");
					return mv;
				}
				
				
				
				mv.addObject("result", true);
				service.deleteUser(user);
				session.invalidate();
				
				mv.setViewName("/delete/deleteresult");
				return mv;
			}
}
