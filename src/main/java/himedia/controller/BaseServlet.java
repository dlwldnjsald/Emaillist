package himedia.controller;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;

// Context Parameter를 받아와서 자식들에게 물려주는 역할 담당해보기
// HttpServlet 상속받기
// abstract 물려줘야하니 protected 로 설정
public abstract class BaseServlet extends HttpServlet{

	//물려줘야하니 protected 로 설정
	protected String dbuser = null;
	protected String dbpass = null;
		
	//초기화 메서드 override : init()
	@Override
	public void init(ServletConfig config) throws ServletException {
		
		super.init(config);//이부분 지우지않도록 주의
		
		//Context parameter 받아오기 :모든 서블릿이 공유하는 파라미터
		ServletContext context = getServletContext();
		//받아왔으니 context 로부터 초기화 파라미터 불러올수 있을것 총 2개 >dbuser, dbpass
		dbuser = context.getInitParameter("dbuser");
		dbpass = context.getInitParameter("dbpass");
		
		
		
		
		
	}
}
