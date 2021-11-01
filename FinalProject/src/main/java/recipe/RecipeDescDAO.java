package recipe;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface RecipeDescDAO {
	public RecipeDescVO getDescOne(int recipe_no);
	public void addDesc(RecipeDescVO vo);
	public List<Integer> SearchDesc(String search);
	public void deleteDesc(int recipe_no);
	public void modifyDesc(RecipeDescVO vo);
}
