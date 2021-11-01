package recipe;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface RecipeImgDAO {
	public RecipeImgVO getImgOne(int recipe_no);
	public void addImg(RecipeImgVO vo);
	public void deleteImg(int recipe_no);
	public void modifyImg(RecipeImgVO vo);
}
