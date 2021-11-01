package mypage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import admin.AdminService;
import main.UserVO;


@Controller
public class MypageController {
	
	@Autowired
	MypageService mypage;
	
	@RequestMapping("/myzzimrecipelist")
	public ModelAndView myzzimrecipeList(HttpSession session) {
		
		ModelAndView mv = new ModelAndView();
		UserVO vo = (UserVO)session.getAttribute("login_info");
		List<MyrecipeVO> myzzimrecipelist = mypage.getMyZzimRecipeList(vo.getUser_no());
		
		mv.addObject("myzzimrecipelist", myzzimrecipelist);
		mv.setViewName("/mypage/myzzimrecipelist");
		
		return mv;
	}
	
	@RequestMapping(value ="/myzzimnation", method=RequestMethod.POST, produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public List<MyrecipeVO> myzzimnation(String recipe_nation, HttpSession session) {
		
		List<MyrecipeVO> myzzimnation;
		
		UserVO vo = (UserVO)session.getAttribute("login_info");
		
		if(recipe_nation.equals("전체")) {
			myzzimnation = mypage.getMyZzimRecipeList(vo.getUser_no());
		}else {
			myzzimnation = mypage.getMyZzimRecipeListDesc(vo.getUser_no(), recipe_nation);
		}
		
		
		
		return myzzimnation;
	}
	
	@RequestMapping("/myzzimdelete")
	public String zzimdelete(int recipe_no, HttpSession session) {
		
		UserVO vo = (UserVO)session.getAttribute("login_info");
		
		mypage.deleteZzimRecipeOne(recipe_no, vo.getUser_no());
		
		return "redirect:myzzimrecipelist";
	}
	
	@RequestMapping("/myrecipelist")
	public ModelAndView myrecipeList(HttpSession session) {
		
		UserVO vo = (UserVO)session.getAttribute("login_info");
		
		ModelAndView mv = new ModelAndView();
		List<MyrecipeVO> myrecipelist = mypage.getMyRecipeList(vo.getUser_no());
		
		mv.addObject("myrecipelist", myrecipelist);
		mv.setViewName("/mypage/myrecipelist");
		
		return mv;
	}
	
	@RequestMapping(value ="/myrecipenation", method=RequestMethod.POST, produces = {"application/json;charset=utf-8"})
	@ResponseBody
	public List<MyrecipeVO> myrecipenation(String recipe_nation, HttpSession session) {
		
		List<MyrecipeVO> myrecipenation;
		
		UserVO vo = (UserVO)session.getAttribute("login_info");
		
		if(recipe_nation.equals("전체")) {
			myrecipenation = mypage.getMyRecipeList(vo.getUser_no());
		}else {
			myrecipenation = mypage.getMyRecipeListDesc(vo.getUser_no(), recipe_nation);
		}
		
		return myrecipenation;
	}
	
	 
}
