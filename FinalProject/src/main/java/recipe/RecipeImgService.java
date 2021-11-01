package recipe;

import java.util.List;


public interface RecipeImgService {
	public RecipeImgVO getImgOne(int recipe_no);
	public void addImg(RecipeImgVO vo);
	public void deleteImg(int recipe_no);
	public void modifyImg(RecipeImgVO vo);
}
