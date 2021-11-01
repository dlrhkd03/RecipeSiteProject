package recipe;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import ingredient.IngredientService;
import ingredient.IngredientVO;
import main.UserVO;
import mypage.MypageService;
import mypage.MyzzimVO;



@Controller
public class RecipeController {
	
	@Autowired
	@Qualifier("recipeservice")
	RecipeService service;
	
	@Autowired
	@Qualifier("ingred")
	IngredientService ingred;
	
	@Autowired
	RecipeDescService descservice;
	@Autowired
	RecipeImgService imgservice;
	@Autowired
	@Qualifier("mypage")
	MypageService mypage;
	
	//레시피 게시판 뷰
	@RequestMapping(value = "/recipelist", method=RequestMethod.GET)
	public ModelAndView recipelist(String emotion, String nation, String cate, String type, String search){
		if(emotion==null) {emotion="";}
		if(nation==null) {nation="";}
		if(cate==null) {cate="";}
		if(search==null) {search="";}
		List<RecipeVO> recipelist_search = new ArrayList<RecipeVO>();
		
		if(type==null) {
			recipelist_search = service.getCateRecipeList(6, nation, emotion, cate);
		}
		else if(type.equals("recipe_title")) {
			recipelist_search = service.SearchTitle(6, nation, emotion, cate, search);
		}
		else if(type.equals("recipe_name")) {
			recipelist_search = service.SearchName(6, nation, emotion, cate, search);
		}
		else if(type.equals("recipe_ingredient")) {
			recipelist_search = service.SearchIngredient(6, nation, emotion, cate, search);
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("recipelist_search", recipelist_search);
		mv.addObject("emotion", emotion);
		mv.addObject("search", search);
		mv.addObject("cate", cate);
		mv.addObject("nation", nation);
		mv.setViewName("/recipe/recipelist");
		return mv;
	}
	//레시피 게시판에서 더보기 버튼, 찜하기 버튼 구현
	@RequestMapping(value="/morerecipelist", method=RequestMethod.POST)
	@ResponseBody
	public List<RecipeVO> morerecipelist(int number, String emotion, String nation, String cate, String type, String search) {
		if(emotion==null) {emotion="";}
		if(nation==null) {nation="";}
		if(cate==null) {cate="";}
		if(search==null) {search="";}
		List<RecipeVO> recipelist = new ArrayList<RecipeVO>();
		
		
		if(type==null) {
			recipelist = service.getCateRecipeList(number, nation, emotion, cate);
		}
		else if(type.equals("recipe_title")) {
			recipelist = service.SearchTitle(number, nation, emotion, cate, search);
		}
		else if(type.equals("recipe_name")) {
			recipelist = service.SearchName(number, nation, emotion, cate, search);
		}
		else if(type.equals("recipe_ingredient")) {
			recipelist = service.SearchIngredient(number, nation, emotion, cate, search);
		}
		
		if(recipelist.size()!=0) {			
			return recipelist;
		}
		else {
			System.out.println(recipelist.size());
			return null;
		}
	}
	
	//레시피 글쓰기 뷰
	@RequestMapping(value="/recipewrite", method=RequestMethod.GET)
	public ModelAndView recipewriteview() {
		IngredientVO vo = ingred.getIngredient();
		ModelAndView mv = new ModelAndView();
		mv.addObject("vo", vo);
		mv.setViewName("/recipe/recipewrite");
		return mv;
	}
	//레시피 글 내용 저장
	@RequestMapping(value="/recipewrite", method=RequestMethod.POST)
	public String recipewrite(int user_no, String recipe_title, String recipe_name, MultipartFile[] recipe_img,
			String recipe_desc, String recipe_cate, String recipe_emotion, String ingredient, String recipe_nation ) throws IOException  {

		//파일명 추출
		List<String> filename = new ArrayList<String>();
		//서버 c:/kdigital2/upload 폴더에 사진 저장
		String savePath = "c:/kdigital2/upload/";
		List<String> ext = new ArrayList<String>();
		List<File> file = new ArrayList<File>();
		
		for(int i=0 ; i < recipe_img.length ; i++) {
			if(!recipe_img[i].isEmpty()) {
				filename.add(recipe_img[i].getOriginalFilename());
				//확장자
				ext.add(filename.get(i).substring(filename.get(i).lastIndexOf(".")));
				//파일명
				filename.set(i, filename.get(i).substring(0, filename.get(i).lastIndexOf("."))+getUuid()+ext.get(i));
				//파일 저장
				file.add(new File(savePath + filename.get(i)));
				//저장
				recipe_img[i].transferTo(file.get(i));
			}
		}
		
		//레시피 내용 db저장
		RecipeVO recipeVO = new RecipeVO();
		RecipeDescVO descVO = new RecipeDescVO();
		RecipeImgVO imgVO = new RecipeImgVO();
		//세션으로 유저넘버 받기 user_no
		recipeVO.setUser_no(user_no);
		recipeVO.setRecipe_title(recipe_title);
		recipeVO.setRecipe_name(recipe_name);
		recipeVO.setRecipe_emotion(recipe_emotion);
		
		//name=recipe_desc가 11개 있어서 분리
		String[] desc = recipe_desc.split(",");
		
		//음식 설명 vo에 저장
		descVO.setRecipe_desc(desc[0]);
		//재료, 카테고리, 음식종류 vo저장 현재 recipe_no 시퀀스 없음
		recipeVO.setRecipe_ingredient(ingredient);
		recipeVO.setRecipe_cate(recipe_cate);
		recipeVO.setRecipe_nation(recipe_nation);
		
		//썸네일 사진 저장
		recipeVO.setRecipe_img(filename.get(0));
		
		//레시피 사진, 레시피 내용 10개 저장
		if(!recipe_img[1].isEmpty() && !desc[1].isEmpty()) {
			imgVO.setRecipe_img1(filename.get(1));
			descVO.setRecipe_desc1(desc[1]);
		}
		if(!recipe_img[2].isEmpty() && !desc[2].isEmpty()) {
			imgVO.setRecipe_img2(filename.get(2));
			descVO.setRecipe_desc2(desc[2]);
		}
		if(!recipe_img[3].isEmpty() && !desc[3].isEmpty()) {
			imgVO.setRecipe_img3(filename.get(3));
			descVO.setRecipe_desc3(desc[3]);
		}
		if(!recipe_img[4].isEmpty() && !desc[4].isEmpty()) {
			imgVO.setRecipe_img4(filename.get(4));
			descVO.setRecipe_desc4(desc[4]);
		}
		if(!recipe_img[5].isEmpty() && !desc[5].isEmpty()) {
			imgVO.setRecipe_img5(filename.get(5));
			descVO.setRecipe_desc5(desc[5]);
		}
		if(!recipe_img[6].isEmpty() && !desc[6].isEmpty()) {
			imgVO.setRecipe_img6(filename.get(6));
			descVO.setRecipe_desc6(desc[6]);
		}
		if(!recipe_img[6].isEmpty() && !desc[7].isEmpty()) {
			imgVO.setRecipe_img7(filename.get(7));
			descVO.setRecipe_desc7(desc[7]);
		}
		if(!recipe_img[8].isEmpty() && !desc[8].isEmpty()) {
			imgVO.setRecipe_img8(filename.get(8));
			descVO.setRecipe_desc8(desc[8]);
		}
		if(!recipe_img[8].isEmpty() && !desc[9].isEmpty()) {
			imgVO.setRecipe_img9(filename.get(9));
			descVO.setRecipe_desc9(desc[9]);
		}
		if(!recipe_img[10].isEmpty() && !desc[10].isEmpty()) {
			imgVO.setRecipe_img10(filename.get(10));
			descVO.setRecipe_desc10(desc[10]);
		}
		service.addRecipe(recipeVO);
		descservice.addDesc(descVO);
		imgservice.addImg(imgVO);
		return "redirect:recipelist";
	}
	
	@RequestMapping("/recipedetail")
	public ModelAndView recipedetailview(int recipe_no, HttpSession session) {
		UserVO vo = (UserVO)session.getAttribute("login_info");
		
		RecipeImgVO img = imgservice.getImgOne(recipe_no);
		RecipeDescVO desc= descservice.getDescOne(recipe_no);
		RecipeVO recipe= service.getRecipeDetail(recipe_no);
		service.raiseRecipeHits(recipe_no);
		
		ModelAndView mv = new ModelAndView();
		
		// 로그인 정보 확인
		if(vo==null) {
			System.out.println("회원정보없음");
		}
		else { // 로그인o
			MyzzimVO zo = mypage.getZzimOne(recipe_no, vo.getUser_no());
			if(zo==null) { // zzim x
				mv.addObject("zzim", null);
			} else { // zzim o
				mv.addObject("zzim", zo.getZzim_no());
			}
		}
		
		mv.addObject("img", img);
		mv.addObject("desc", desc);
		mv.addObject("recipe", recipe);
		mv.setViewName("/recipe/recipedetail");
		return mv;
	}
	
	@RequestMapping("/recipedelete")
	public String recipedelete(int recipe_no, HttpSession session) {
		RecipeVO recipe = service.getRecipeDetail(recipe_no);
		//아이디 정보가 없으면 진입 불가
		UserVO vo = (UserVO)session.getAttribute("login_info");
		if(vo==null) {
			return "/recipe/usererror";
		}
		int user_no = vo.getUser_no();
		//아이디 정보가 있지만 관리자가 아니거나 다른 아이디확인 true면 수정페이지 진입 가능 false면 에러페이지로 이동
		if(user_no==1 || user_no==recipe.getUser_no()) {
			descservice.deleteDesc(recipe_no);
			imgservice.deleteImg(recipe_no);
			service.deleteRecipe(recipe_no);
			return "/recipe/recipelist";
		}
		return "/recipe/usernoerror";
	}
	@RequestMapping(value="/recipemodify", method=RequestMethod.GET )
	public ModelAndView recipemodifyview(int recipe_no, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		RecipeImgVO img = imgservice.getImgOne(recipe_no);
		RecipeDescVO desc= descservice.getDescOne(recipe_no);
		RecipeVO recipe= service.getRecipeDetail(recipe_no);
		
		//아이디 정보가 없으면 진입 불가
		UserVO vo = (UserVO)session.getAttribute("login_info");
		if(vo==null) {
			mv.setViewName("/recipe/usererror");
			return mv;
		}
		int user_no = vo.getUser_no();
		//아이디 정보가 있지만 관리자가 아니거나 다른 아이디확인 true면 수정페이지 진입 가능 false면 에러페이지로 이동
		if(user_no==1 || user_no==recipe.getUser_no()) {
		mv.addObject("img", img);
		mv.addObject("desc", desc);
		mv.addObject("recipe", recipe);
		IngredientVO ingredvo = ingred.getIngredient();
		mv.addObject("ingredvo", ingredvo);
		mv.setViewName("/recipe/recipemodify");
		return mv;
		}
		mv.setViewName("/recipe/usernoerror");
		return mv;
	}
	
	@RequestMapping(value="/recipemodify", method=RequestMethod.POST )
	public String recipemodify(int recipe_no, String recipe_title, String recipe_name, MultipartFile recipe_img, MultipartFile recipe_img1, MultipartFile recipe_img2, MultipartFile recipe_img3, MultipartFile recipe_img4, MultipartFile recipe_img5, MultipartFile recipe_img6, MultipartFile recipe_img7, MultipartFile recipe_img8, MultipartFile recipe_img9, MultipartFile recipe_img10,
			String img, String img1, String img2, String img3, String img4, String img5, String img6, String img7, String img8, String img9, String img10,
			String recipe_desc, String recipe_cate, String recipe_emotion, String ingredient, String recipe_nation ) throws IOException  {
		
		RecipeVO recipeVO = new RecipeVO();
		RecipeDescVO descVO = new RecipeDescVO();
		RecipeImgVO imgVO = new RecipeImgVO();
		//레시피 번호 get방식 받아서 사용
		recipeVO.setRecipe_no(recipe_no);
		imgVO.setRecipe_no(recipe_no);
		descVO.setRecipe_no(recipe_no);
		//제목, 음식이름, 감정, 분류, 종류 vo 저장
		recipeVO.setRecipe_title(recipe_title);
		recipeVO.setRecipe_name(recipe_name);
		recipeVO.setRecipe_emotion(recipe_emotion);
		recipeVO.setRecipe_ingredient(ingredient);
		recipeVO.setRecipe_cate(recipe_cate);
		recipeVO.setRecipe_nation(recipe_nation);
		
		//name=recipe_desc가 11개 있어서 분리
		String[] desc = recipe_desc.split(",");
		
		//음식 설명 vo에 저장
		descVO.setRecipe_desc(desc[0]);
		
		
		String filename;
		String ext;
		//서버 c:/kdigital2/upload 폴더에 사진 저장
		String savePath = "c:/kdigital2/upload/";
		File file;
		
		//썸네일 사진 저장
		if(!recipe_img.isEmpty()) {
			filename = recipe_img.getOriginalFilename();
			//확장자
			ext = (filename.substring(filename.lastIndexOf(".")));
			//파일명
			filename = filename.substring(0, filename.lastIndexOf("."))+getUuid()+ext;
			//파일 저장
			file = new File(savePath + filename);
			//저장
			recipe_img.transferTo(file);
			recipeVO.setRecipe_img(filename);
			
		}
		else {
			//2.1 수정 안하면 기존 이미지 그대로 사용하는데 기존이미지 있다면 그대로 사용
			if(img!=null) {
				recipeVO.setRecipe_img(img);
			}
			//2.2 수정 안하면 기존 이미지 그대로 사용하는데 기존 이미지도 없다 아무일도 없다.
		}
		
		//1. 레시피 사진 수정 하면 수정된 이미지 저장
		if(!recipe_img1.isEmpty() && !desc[1].isEmpty()) {
			filename = recipe_img1.getOriginalFilename();
			//확장자
			ext = (filename.substring(filename.lastIndexOf(".")));
			//파일명
			filename = filename.substring(0, filename.lastIndexOf("."))+getUuid()+ext;
			//파일 저장
			file = new File(savePath + filename);
			//저장
			recipe_img1.transferTo(file);
			
			//store(recipe_img1);
			imgVO.setRecipe_img1(filename);
			descVO.setRecipe_desc1(desc[1]);
		}
		else {
			//2.1 수정 안하면 기존 이미지 그대로 사용하는데 기존이미지 있다면 그대로 사용
			if(img1!=null && !desc[1].isEmpty()) {
				imgVO.setRecipe_img1(img1);
				descVO.setRecipe_desc1(desc[1]);
			}
			//2.2 수정 안하면 기존 이미지 그대로 사용하는데 기존 이미지도 없다 아무일도 없다.
		}
		
		if(!recipe_img2.isEmpty() && !desc[2].isEmpty()) {
			filename = recipe_img2.getOriginalFilename();
			//확장자
			ext = (filename.substring(filename.lastIndexOf(".")));
			//파일명
			filename = filename.substring(0, filename.lastIndexOf("."))+getUuid()+ext;
			//파일 저장
			file = new File(savePath + filename);
			//저장
			recipe_img2.transferTo(file);
			
			imgVO.setRecipe_img2(filename);
			descVO.setRecipe_desc2(desc[2]);
		}
		else {
			if(img2!=null && !desc[2].isEmpty()) {
				imgVO.setRecipe_img2(img2);
				descVO.setRecipe_desc2(desc[2]);
			}
		}
		if(!recipe_img3.isEmpty() && !desc[3].isEmpty()) {
			filename = recipe_img3.getOriginalFilename();
			//확장자
			ext = (filename.substring(filename.lastIndexOf(".")));
			//파일명
			filename = filename.substring(0, filename.lastIndexOf("."))+getUuid()+ext;
			//파일 저장
			file = new File(savePath + filename);
			//저장
			recipe_img3.transferTo(file);
			
			imgVO.setRecipe_img3(filename);
			descVO.setRecipe_desc3(desc[3]);
		}
		else {
			if(img3!=null && !desc[3].isEmpty()) {
				imgVO.setRecipe_img3(img3);
				descVO.setRecipe_desc3(desc[3]);
			}
		}
		if(!recipe_img4.isEmpty() && !desc[4].isEmpty()) {
			filename = recipe_img4.getOriginalFilename();
			//확장자
			ext = (filename.substring(filename.lastIndexOf(".")));
			//파일명
			filename = filename.substring(0, filename.lastIndexOf("."))+getUuid()+ext;
			//파일 저장
			file = new File(savePath + filename);
			//저장
			recipe_img4.transferTo(file);
			
			imgVO.setRecipe_img4(filename);
			descVO.setRecipe_desc4(desc[4]);
		}
		else {
			if(img4!=null && !desc[4].isEmpty()) {
				imgVO.setRecipe_img4(img4);
				descVO.setRecipe_desc4(desc[4]);
			}
		}
		if(!recipe_img5.isEmpty() && !desc[5].isEmpty()) {
			filename = recipe_img5.getOriginalFilename();
			//확장자
			ext = (filename.substring(filename.lastIndexOf(".")));
			//파일명
			filename = filename.substring(0, filename.lastIndexOf("."))+getUuid()+ext;
			//파일 저장
			file = new File(savePath + filename);
			//저장
			recipe_img5.transferTo(file);
			
			imgVO.setRecipe_img5(filename);
			descVO.setRecipe_desc5(desc[5]);
		}
		else {
			if(img5!=null && !desc[5].isEmpty()) {
				imgVO.setRecipe_img5(img5);
				descVO.setRecipe_desc5(desc[5]);
			}
		}
		if(!recipe_img6.isEmpty() && !desc[6].isEmpty()) {
			filename = recipe_img6.getOriginalFilename();
			//확장자
			ext = (filename.substring(filename.lastIndexOf(".")));
			//파일명
			filename = filename.substring(0, filename.lastIndexOf("."))+getUuid()+ext;
			//파일 저장
			file = new File(savePath + filename);
			//저장
			recipe_img6.transferTo(file);
			
			imgVO.setRecipe_img6(filename);
			descVO.setRecipe_desc6(desc[6]);
		}
		else {
			if(img6!=null && !desc[6].isEmpty()) {
				imgVO.setRecipe_img6(img6);
				descVO.setRecipe_desc6(desc[6]);
			}
		}
		if(!recipe_img7.isEmpty() && !desc[7].isEmpty()) {
			filename = recipe_img7.getOriginalFilename();
			//확장자
			ext = (filename.substring(filename.lastIndexOf(".")));
			//파일명
			filename = filename.substring(0, filename.lastIndexOf("."))+getUuid()+ext;
			//파일 저장
			file = new File(savePath + filename);
			//저장
			recipe_img7.transferTo(file);
			
			imgVO.setRecipe_img7(filename);
			descVO.setRecipe_desc7(desc[7]);
		}
		else {
			if(img7!=null && !desc[7].isEmpty()) {
				imgVO.setRecipe_img7(img7);
				descVO.setRecipe_desc7(desc[7]);
			}
		}
		if(!recipe_img8.isEmpty() && !desc[8].isEmpty()) {
			filename = recipe_img8.getOriginalFilename();
			//확장자
			ext = (filename.substring(filename.lastIndexOf(".")));
			//파일명
			filename = filename.substring(0, filename.lastIndexOf("."))+getUuid()+ext;
			//파일 저장
			file = new File(savePath + filename);
			//저장
			recipe_img8.transferTo(file);
			
			imgVO.setRecipe_img8(filename);
			descVO.setRecipe_desc8(desc[8]);
		}
		else {
			if(img8!=null && !desc[8].isEmpty()) {
				imgVO.setRecipe_img8(img8);
				descVO.setRecipe_desc8(desc[8]);
			}
		}
		if(!recipe_img9.isEmpty() && !desc[9].isEmpty()) {
			filename = recipe_img9.getOriginalFilename();
			//확장자
			ext = (filename.substring(filename.lastIndexOf(".")));
			//파일명
			filename = filename.substring(0, filename.lastIndexOf("."))+getUuid()+ext;
			//파일 저장
			file = new File(savePath + filename);
			//저장
			recipe_img9.transferTo(file);
			
			imgVO.setRecipe_img9(filename);
			descVO.setRecipe_desc9(desc[9]);
		}
		else {
			if(img9!=null && !desc[9].isEmpty()) {
				imgVO.setRecipe_img9(img9);
				descVO.setRecipe_desc9(desc[9]);
			}
		}
		if(!recipe_img10.isEmpty() && !desc[10].isEmpty()) {
			filename = recipe_img10.getOriginalFilename();
			//확장자
			ext = (filename.substring(filename.lastIndexOf(".")));
			//파일명
			filename = filename.substring(0, filename.lastIndexOf("."))+getUuid()+ext;
			//파일 저장
			file = new File(savePath + filename);
			//저장
			recipe_img10.transferTo(file);
			
			imgVO.setRecipe_img10(filename);
			descVO.setRecipe_desc10(desc[10]);
		}
		else {
			if(img10!=null && !desc[10].isEmpty()) {
				imgVO.setRecipe_img10(img10);
				descVO.setRecipe_desc10(desc[10]);
			}
		}
		service.modifyRecipe(recipeVO);
		descservice.modifyDesc(descVO);
		imgservice.modifyImg(imgVO);
		return "redirect:recipedetail?no=" + recipe_no;

	}
	
	public static String getUuid() {
		return UUID.randomUUID().toString().replaceAll("-", "").substring(0, 10);
	}
	
	public static void store(MultipartFile img) throws IOException {
		String savePath = "c:/kdigital2/upload/";
		String filename = img.getOriginalFilename();
		//확장자
		String ext = (filename.substring(filename.lastIndexOf(".")));
		//파일명
		filename = filename.substring(0, filename.lastIndexOf("."))+getUuid()+ext;
		//파일 저장
		File file = new File(savePath + filename);
		//저장
		img.transferTo(file);
	}
	
	@ResponseBody
	@RequestMapping("saveZzim.do")
	public void zzimAdd(String no, HttpSession session) {
		int recipe_no = Integer.parseInt(no);
		UserVO vo = (UserVO)session.getAttribute("login_info");
		
		MyzzimVO zo = new MyzzimVO();
		zo.setRecipe_no(recipe_no);
		zo.setUser_no(vo.getUser_no());
		mypage.addZzimRecipe(zo);
	}
	
	@ResponseBody
	@RequestMapping("removeZzim.do")
	public void zzimDelete(String no, HttpSession session) {
		int recipe_no = Integer.parseInt(no);
		UserVO vo = (UserVO)session.getAttribute("login_info");
		
		mypage.deleteZzimRecipeOne(recipe_no, vo.getUser_no());
	}

}