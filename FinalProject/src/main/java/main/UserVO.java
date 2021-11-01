package main;

public class UserVO {
	int user_no;
	String user_name, user_email, user_pw;
	String user_phone;
	String user_address;
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	
	public int getUser_no() {
		return user_no;
	}
	public String getUser_name() {
		return user_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public String getUser_pw() {
		return user_pw;
	}
	
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_address() {
		return user_address;
	}
	@Override
	public String toString() {
		
		return "아이디 : " + user_email;
	}
	
}
