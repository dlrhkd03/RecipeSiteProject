package notice;

import java.io.File;
import java.io.IOError;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import main.UserVO;
import mypage.MyrecipeVO;

@Controller
public class NoticeController{
	
	@Autowired
	@Qualifier("n")
	NoticeService noticeservice;
	
	// 공지사항 클릭시,
	@RequestMapping(value="/noticelist", method=RequestMethod.GET)
	public ModelAndView getNoticeList() {
		ModelAndView mv = new ModelAndView();
		List<NoticeVO> notice_list = noticeservice.getNoticeList();
		mv.addObject("notice_list", notice_list);
		mv.setViewName("/notice/noticelist");
			
		return mv;
	}
	
	// 공지사항 상세보기
	@RequestMapping("/noticedetail")
	public ModelAndView getNoticeOne(String no) {
		
		ModelAndView mv = new ModelAndView();
		int number = Integer.parseInt(no);
		NoticeVO vo = noticeservice.getNoticeOne(number);
		noticeservice.clickNotice(number);
		List<NoticeVO> notice_list = noticeservice.getNoticeList();

		
		mv.addObject("notice_list", notice_list);
		mv.addObject("notice_one", vo);
		mv.setViewName("/notice/noticedetail");
		System.out.println(vo.getNotice_file());
		System.out.println("공지 자세히보기");
		return mv;
	}
	
	// 공지사항 수정 페이지 - 해당 게시물 불러오기
	@RequestMapping(value="/noticemodify", method=RequestMethod.GET)
	public ModelAndView modifyFoam(String no, HttpSession session) {
		
		UserVO user = (UserVO)session.getAttribute("login_info");
		user.getUser_no();
		
		int number = Integer.parseInt(no);
		ModelAndView mv = new ModelAndView();
		NoticeVO vo = noticeservice.getNoticeOne(number);
		
		mv.addObject("modifynotice", vo);
		mv.setViewName("/notice/noticemodify");		
		return mv;
	}
	
	// 공지사항 수정 완료 ---> 상세페이지 이동
	@RequestMapping(value="/noticemodify", method=RequestMethod.POST)
	public ModelAndView modifyNotice(NoticeVO vo) throws IOException {
		
		if(!vo.getUploadfile().isEmpty()) {
			
			MultipartFile uploadfile = vo.getUploadfile();
			// 파일명
			String filename = uploadfile.getOriginalFilename();
			// 저장소
			String savePath = "c:/kdigital2/notice/";
			// 저장
			File file_result = new File(savePath + filename);
			uploadfile.transferTo(file_result);
			
			vo.setNotice_file(filename);
		}
		
		ModelAndView mv = new ModelAndView();
		String mod_no = String.valueOf(noticeservice.modifyNotice(vo));
		mv.addObject("no", mod_no);
		mv.setViewName("redirect:/noticedetail");
		System.out.println("공지 수정 완료");
		return mv;
	}
	
    // 공지사항 작성 폼
	@RequestMapping(value="/noticewrite", method=RequestMethod.GET)
	public String writeNoticeForm(HttpSession session) {
		
		UserVO user = (UserVO)session.getAttribute("login_info");
		user.getUser_no();
		
		return "/notice/noticewrite";
	}
	
	// 공지사항 작성완료
	@RequestMapping(value="/noticewrite", method=RequestMethod.POST)
	public ModelAndView writeNotice(NoticeVO vo, HttpSession session) throws IOException {
		if(!vo.getUploadfile().isEmpty()) {
			// 파일 1개
			MultipartFile uploadfile = vo.getUploadfile();
			// 파일명
			String filename = uploadfile.getOriginalFilename();
			// 저장소
			String savePath = "c:/kdigital2/notice/";
			// 저장
			File file_result = new File(savePath + filename);
			uploadfile.transferTo(file_result);
			
			vo.setNotice_file(filename);
		}
		UserVO vo2 = (UserVO)session.getAttribute("login_info");
		vo.setUser_no(vo2.getUser_no());
		noticeservice.writeNoitce(vo); 
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/noticelist");
		
		return mv;
	}
	
	/*
	// 공지사항 검색
	@RequestMapping(value="/noticelist", method=RequestMethod.POST)
	@ResponseBody
	public List<NoticeVO> searchNoticeList(String search) {
		List<NoticeVO> searchlist = noticeservice.searchNoticeList(search);
		System.out.println("검색");
		return searchlist;
	}
	*/
	
	@RequestMapping(value="/noticedelete", method=RequestMethod.GET)
	public ModelAndView deleteNotice(String no) {
		int number = Integer.parseInt(no);
		noticeservice.deleteNotice(number);
		System.out.println("공지 삭제 완료");
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/noticelist");
		return mv;
	}
	
	

	
	// @ResponseBody ---> 보던 view에 데이터 전달
}
