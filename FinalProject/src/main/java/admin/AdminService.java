package admin;

import java.util.List;

public interface AdminService {
	public List<AdminVO> getUserList();
	public void modifyInfo(AdminVO vo);
	public void deleteInfo(int no);
}
