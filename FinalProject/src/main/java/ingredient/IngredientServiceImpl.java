package ingredient;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("ingred")
public class IngredientServiceImpl implements IngredientService {
	@Autowired
	IngredientDAO dao;

	@Override
	public IngredientVO getIngredient() {
		System.out.println("hi");
		return dao.getIngredient();
	}
	
	
}
