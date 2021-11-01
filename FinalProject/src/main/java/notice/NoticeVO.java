package notice;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class NoticeVO {
	int notice_no;
	int user_no;
	Date notice_date;
	String notice_title;
	String notice_desc;
	MultipartFile uploadfile;
	String notice_file;
	String notice_hits;
	
	@Override
	public String toString() {
		return super.toString();
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_desc() {
		return notice_desc;
	}
	public void setNotice_desc(String notice_desc) {
		this.notice_desc = notice_desc;
	}

	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}
	public String getNotice_date() {
		return  new SimpleDateFormat("yyyy/MM/dd", Locale.KOREA).format(this.notice_date);
	}

	public MultipartFile getUploadfile() {
		return uploadfile; 
	} 
	public void
	 setUploadfile(MultipartFile uploadfile) { 
		this.uploadfile = uploadfile;
	}
	
	public String getNotice_file() {
		return notice_file;
	}
	public void setNotice_file(String notice_file) {
		this.notice_file = notice_file;
	}
	public String getNotice_hits() {
		return notice_hits;
	}
	public void setNotice_hits(String notice_hits) {
		this.notice_hits = notice_hits;
	}
	
	
}
