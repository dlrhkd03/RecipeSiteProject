package notice;

import java.util.List;

public interface NoticeService {
	// 공지사항 조회
	public List<NoticeVO> getNoticeList();
	// 공지사항 한개 불러오기
	public NoticeVO getNoticeOne(int no);
	// 공지사항 수정
	public int modifyNotice(NoticeVO vo);
	// 조회수 증가
	public void clickNotice(int no);
	// 공지사항 작성
	public int writeNoitce(NoticeVO vo);
	// 공지사항 제목으로 검색
	public List<NoticeVO> searchNoticeList(String search);
	// 공지사항 삭제
	public void deleteNotice(int no);
}
