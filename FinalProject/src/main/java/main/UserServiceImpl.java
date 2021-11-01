package main;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userservice")
public class UserServiceImpl implements UserService {
	@Autowired
	UserDAO dao;
	
	@Override
	public UserVO getUserOne(HashMap<String, String> map) {
		return dao.getUserOne(map);
	}
	public String checkUser(String email) {
		UserVO vo =dao.checkUser(email);
		
		if(vo!=null) {
			return "true";			
		}else {
			return "false";
		}
	}

	@Override
	public void insertUser(UserVO vo) {
		dao.insertUser(vo);
		
	}

	@Override
	public void updateUser(UserVO vo) {
		dao.updateUser(vo);
		
	}

	@Override
	public void deleteUser(UserVO vo) {
		dao.deleteUser(vo);
		
	}
	
}
