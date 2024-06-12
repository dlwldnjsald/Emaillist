package himedia.controller;

import java.io.IOException;
import java.util.List;

import himedia.dao.EmaillistDao;
import himedia.dao.EmaillistDaoOracleImpl;
import himedia.vo.EmailVo;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// 컨트롤러 Controller: 요청처리와 내부 로직을 담당한다.
// -목록 (GET 방식으로 처리)
// -입력 폼 (GET 방식으로 처리) : ?a=form가 넘어오거나 안넘어오면 목록화면 보여주기
// -입력 액션 (POST 방식으로 처리)

// 어노테이션을 이용한 서블릿 매핑 
// 2번째 방법 서블릿 클래스에 서블릿 이름과 url 패턴을 매핑을 설정
// 서블릿이니 httpServlet을 상속받아야 함
@WebServlet(name="Emaillist", urlPatterns="/el")
public class EmaillistServlet extends BaseServlet { //BaseServlet 상속받기

	//doGet 메서드 오버라이드
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 파라미터 정보 a=form 이면 입력 폼으로 이동시킬것
		
		// req로부터 파라미터 a 받아오기 
		String actionName = req.getParameter("a");
		
			//a=form->입력창, or else ->목록창
			if ("form".equals(actionName) ) {
				
				//사용자 입력 페이지로 FORWARD
				RequestDispatcher rd = getServletContext()
										.getRequestDispatcher("/WEB-INF/views/form.jsp");
				
				rd.forward(req, resp); // 잊지말기 (forward)
				
			} else {
				//목록 받아오는 부분 -> /el
				
				//DAO 미리 만들어두었으니 dao 활용하기 + 파라미터도받아오기
				EmaillistDao dao = new EmaillistDaoOracleImpl(dbuser,dbpass);
				//dao의 메서드 호출 : List<EmailVo>호출
				List<EmailVo> list = dao.getList();
				//출력으로 list 목록확인 
				System.out.println("list:" + list);
				
				
				// list를 요청 객체에 추가하기
				req.setAttribute("list", list);
				
				//Todo: list객체를 jsp로 forward
				RequestDispatcher rd = getServletContext().
									getRequestDispatcher("/WEB-INF/views/index.jsp");
				
				rd.forward(req, resp);
				
			}
		}

	@Override
	protected void doPost(HttpServletRequest req, 
			HttpServletResponse resp) throws ServletException, IOException {
		//삽입 (insert), 수정(update), 삭제(delete)
		//a=insert / a=update/ a=delete
		
		String actionName = req.getParameter("a");
		
		if ("insert".equals(actionName)) {
			
			//Insert 기능 수행
			String firstName = req.getParameter("fn");
			String lastName= req.getParameter("ln");
			String email = req.getParameter("email");
			
			//Vo 호풀
			EmailVo vo = new EmailVo();
			vo.setFirstName(firstName);
			vo.setLastName(lastName);
			vo.setEmail(email);
			
			//DAO 호출
			EmaillistDao dao = new EmaillistDaoOracleImpl(dbuser, dbpass);
			boolean success = dao.insert(vo);
			
			if (success) {
				System.out.println("Insert SUCCESS");
			} else {
				System.out.println("Insert Failed");
			}
			
			resp.sendRedirect(req.getContextPath() + "/el");
		} else {
			super.doPost(req, resp);
		}
					
	}
}
