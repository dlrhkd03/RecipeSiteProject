package notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("n")
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeDAO dao;

	@Override
	public List<NoticeVO> getNoticeList() {
		List<NoticeVO> noticelist = dao.noticelist();
		return noticelist;
	}

	@Override
	public NoticeVO getNoticeOne(int no) {
		NoticeVO vo = dao.noticeone(no);
		return vo;
	}

	@Override
	public int modifyNotice(NoticeVO vo) {
		dao.modifynotice(vo);
		return vo.notice_no;
	}

	@Override
	public void clickNotice(int no) {
		dao.clicknotice(no);
	}

	@Override
	public int writeNoitce(NoticeVO vo) {
		dao.writenotice(vo);
		List<NoticeVO> noticelist = dao.noticelist();
		int number = noticelist.get(0).notice_no;
		return number;
	}

	@Override
	public List<NoticeVO> searchNoticeList(String search) {
		List<NoticeVO> searchlist = dao.searchnoticelist(search);
		return searchlist;
	}

	@Override
	public void deleteNotice(int no) {
		dao.deletenotice(no);
	}
	
	
	

}
