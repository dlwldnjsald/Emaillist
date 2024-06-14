package himedia.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;

//emaillist
// 어노테이션 방식으로 필터 등록하기 
//@WebFilter(filterName="EncodingFilter", urlPatterns = {"/*"})

//모든 URL 패턴에 대해 이 필터를 적용하도록 지정합니다
//이 필터 클래스를 작성한 후, 필터를 웹 애플리케이션에 등록할 필요가 없습니다. 
//어노테이션만으로 필터가 등록되고 URL 패턴에 매핑됩니다.
//필터 클래스가 알아서 필터체인에 등록되고 해당 URL 패턴에 적용됩니다.
@WebFilter("/*")
public class EncodingFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		
		//연결된 필터 요청, 응답객체 전달
		chain.doFilter(req, resp);
		
		
		
	}

}

