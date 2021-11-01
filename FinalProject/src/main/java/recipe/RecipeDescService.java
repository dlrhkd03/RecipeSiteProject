package recipe;

import java.util.List;


public interface RecipeDescService {
	public RecipeDescVO getDescOne(int recipe_no);
	public void addDesc(RecipeDescVO vo);
	public void deleteDesc(int recipe_no);
	public void modifyDesc(RecipeDescVO vo);
}
