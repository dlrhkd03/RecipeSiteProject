package main;

import java.util.HashMap;

public interface UserService {
	public UserVO getUserOne(HashMap<String, String> map);
	public String checkUser(String email);
	public void insertUser(UserVO vo);
	public void updateUser(UserVO vo);
	public void deleteUser(UserVO vo);
}
