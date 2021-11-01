package notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface NoticeDAO {
	public List<NoticeVO> noticelist();
	public NoticeVO noticeone(int notice_no);
	public void modifynotice(NoticeVO vo);
	public void clicknotice(int notice_no);
	public void writenotice(NoticeVO vo);
	public List<NoticeVO> searchnoticelist(String search);
	public void deletenotice(int notice_no);
}