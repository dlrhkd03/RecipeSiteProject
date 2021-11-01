package admin;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import main.UserVO;
import mypage.MyrecipeVO;

@Controller
public class AdminController {
	
	@Autowired
	AdminService admin;
	
	@RequestMapping("/usermanager")
	public ModelAndView adminMain(HttpSession session) {
		
		UserVO user = (UserVO)session.getAttribute("login_info");
		user.getUser_no();
		
		ModelAndView mv = new ModelAndView();
		
		List<AdminVO> userlist = admin.getUserList();
		
		mv.addObject("userlist", userlist);
		mv.setViewName("/admin/usermanager");
		
		return mv;
	}
	
	@RequestMapping("/userdelete")
	public String userdelete(int user_no) {
		
		admin.deleteInfo(user_no);
		
		return "redirect:usermanager";
	}
	
	@RequestMapping(value ="/usermodify", method=RequestMethod.GET)
	public String usermodify(AdminVO vo) {
		System.out.println(vo.user_phone);
		admin.modifyInfo(vo);
		
		return "redirect:usermanager";
	}
	
	@RequestMapping(value ="/imsi", method=RequestMethod.GET)
	public String imsi(AdminVO vo) {
		
		
		return "/admin/imsi";
	}
	
	
	
}
