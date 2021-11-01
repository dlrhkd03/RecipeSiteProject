package admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface AdminDAO {
	
	public List<AdminVO> getUserList();
	
	public void modifyInfo(AdminVO vo);
	
	public void deleteInfo(int no);
	
}
