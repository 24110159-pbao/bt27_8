package vn.iotstar.filter;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.util.Constant;

import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;

        HttpServletResponse resp =
                (HttpServletResponse) response;

        HttpSession session =
                req.getSession(false);

        // Chưa đăng nhập
        if (session == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }

        User user =
                (User) session.getAttribute(
                        Constant.SESSION_ACCOUNT
                );

        // Không có user hoặc không phải Admin
        if (user == null || user.getRoleid() != 1) {

            resp.sendRedirect(
                    req.getContextPath() + "/home"
            );

            return;
        }

        // Là Admin → cho phép truy cập
        chain.doFilter(request, response);
    }
}
