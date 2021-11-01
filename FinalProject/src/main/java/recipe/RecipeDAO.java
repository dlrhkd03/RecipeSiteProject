package recipe;

import java.util.HashMap;
import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface RecipeDAO {
	public List<RecipeVO> getRecipeList();
	public List<RecipeVO> moreRecipeList(int number, String emotion, String nation, String cate, String type, String search);
	public List<RecipeVO> getCateRecipeList(int number, String nation, String emotion, String cate);
	public List<RecipeVO> SearchTitle(int number, String nation, String emotion, String cate ,String search);
	public List<RecipeVO> SearchName(int number, String nation, String emotion, String cate, String search);
	public List<RecipeVO> SearchIngredient(int number, String nation, String emotion, String cate, String search);
	public void addRecipe(RecipeVO vo);
	public RecipeVO getRecipeDetail(int no);
	public void raiseRecipeHits(int no);
	public void deleteRecipe(int recipe_no);
	public void modifyRecipe(RecipeVO vo);
	public List<RecipeVO> findRecipe(String emotion, String nation, String cate);
}
