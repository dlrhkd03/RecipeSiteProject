package admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("admin")
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	AdminDAO dao;
	
	@Override
	public List<AdminVO> getUserList() {
		return dao.getUserList();
	}

	@Override
	public void modifyInfo(AdminVO vo) {
		dao.modifyInfo(vo);
	}

	@Override
	public void deleteInfo(int no) {
		dao.deleteInfo(no);
	}
	
}
