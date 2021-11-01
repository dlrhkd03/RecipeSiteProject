package recipe;


import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("descservice")
public class RecipeDescServiceImpl implements RecipeDescService {
	@Autowired
	RecipeDescDAO dao;

	public RecipeDescVO getDescOne(int recipe_no){
		return dao.getDescOne(recipe_no);
	}
	public void addDesc(RecipeDescVO vo) {
		dao.addDesc(vo);
	}
	public void deleteDesc(int recipe_no) {
		dao.deleteDesc(recipe_no);
	}
	public void modifyDesc(RecipeDescVO vo) {
		dao.modifyDesc(vo);
	}
}
