package recipe;


import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("imgservice")
public class RecipeImgServiceImpl implements RecipeImgService {
	@Autowired
	RecipeImgDAO dao;

	@Override
	public RecipeImgVO getImgOne(int recipe_no) {
		return dao.getImgOne(recipe_no);
	}

	@Override
	public void addImg(RecipeImgVO vo) {
		dao.addImg(vo);
	}
	public void deleteImg(int recipe_no) {
		dao.deleteImg(recipe_no);
	}
	public void modifyImg(RecipeImgVO vo) {
		dao.modifyImg(vo);
	}
	
}
