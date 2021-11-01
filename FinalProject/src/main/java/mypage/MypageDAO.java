package mypage;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface MypageDAO {
	
	public List<MyrecipeVO> getMyZzimRecipeList(int user_no);
	public List<MyrecipeVO> getMyZzimRecipeListDesc(int user_no, String recipe_nation);
	public List<MyrecipeVO> getMyRecipeList(int user_no);
	public List<MyrecipeVO> getMyRecipeListDesc(int user_no, String recipe_nation);
	public void deleteZzimRecipeOne(int recipe_no, int user_no);
	public List<MyrecipeVO> getMainRecipeSearch(String keyword);
	public List<MyrecipeVO> getMainRecipePopular();
	public void addZzimRecipe(MyzzimVO vo);
	public MyzzimVO getZzimOne(int recipe_no, int user_no);
}
