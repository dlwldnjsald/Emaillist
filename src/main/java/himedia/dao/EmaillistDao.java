package himedia.dao;
//interface 생성

import java.util.List;

public interface EmaillistDao {
	public List<EmailVo> getList(); 	// emailllist table SELECT
	public boolean insert(EmailVo vo);  // emaillist table INSERT
	public boolean delete(Long no); 	//emaillist table DELETE
		
}
