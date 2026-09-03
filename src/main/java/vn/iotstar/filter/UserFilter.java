package vn.iotstar.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.util.Constant;

import java.io.IOException;

@WebFilter("/user/*")
public class UserFilter implements Filter {

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

        /*
         * ============================
         * CHƯA ĐĂNG NHẬP
         * ============================
         */
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

        /*
         * ============================
         * KHÔNG CÓ USER
         * ============================
         */
        if (user == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }

        /*
         * ============================
         * KHÔNG PHẢI USER
         * ============================
         *
         * roleid:
         * 1 = Admin
         * 2 = User
         */
        if (user.getRoleid() != 2) {

            resp.sendRedirect(
                    req.getContextPath() + "/admin/home"
            );

            return;
        }

        /*
         * ============================
         * USER HỢP LỆ
         * ============================
         */
        chain.doFilter(request, response);
    }


}
