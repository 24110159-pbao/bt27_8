package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.io.Serial;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet("/user/profile")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class UserProfileController extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final IUserService userService =
            new UserServiceImpl();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
                req.getSession(false);

        User sessionUser =
                (User) session.getAttribute(
                        Constant.SESSION_ACCOUNT
                );

        User user =
                userService.findById(
                        sessionUser.getId()
                );

        if (user == null) {

            session.invalidate();

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }

        // Cập nhật lại User mới nhất vào session
        session.setAttribute(
                Constant.SESSION_ACCOUNT,
                user
        );

        req.setAttribute(
                "currentUser",
                user
        );

        req.getRequestDispatcher(
                "/views/user/profile.jsp"
        ).forward(req, resp);
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session =
                req.getSession(false);

        User sessionUser =
                (User) session.getAttribute(
                        Constant.SESSION_ACCOUNT
                );

        User user =
                userService.findById(
                        sessionUser.getId()
                );

        if (user == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }

        String fullname =
                req.getParameter("fullname");

        String phone =
                req.getParameter("phone");

        if (fullname == null
                || fullname.trim().isEmpty()) {

            req.setAttribute(
                    "alert",
                    "Họ tên không được để trống."
            );

            req.setAttribute(
                    "currentUser",
                    user
            );

            req.getRequestDispatcher(
                    "/views/user/profile.jsp"
            ).forward(req, resp);

            return;
        }

        fullname = fullname.trim();

        if (phone != null) {
            phone = phone.trim();
        }

        /*
         * Kiểm tra phone.
         *
         * Chỉ báo lỗi nếu phone thuộc về
         * một User khác.
         */
        if (phone != null && !phone.isEmpty()) {

            User phoneUser =
                    userService.findByPhone(phone);

            if (phoneUser != null
                    && phoneUser.getId() != user.getId()) {

                req.setAttribute(
                        "alert",
                        "Số điện thoại đã được sử dụng."
                );

                req.setAttribute(
                        "currentUser",
                        user
                );

                req.getRequestDispatcher(
                        "/views/user/profile.jsp"
                ).forward(req, resp);

                return;
            }

            user.setPhone(phone);

        } else {

            user.setPhone(null);
        }

        user.setFullname(fullname);

        /*
         * ============================
         * UPLOAD AVATAR
         * ============================
         */

        Part avatarPart =
                req.getPart("avatar");

        if (avatarPart != null
                && avatarPart.getSize() > 0) {

            String submittedFileName =
                    avatarPart.getSubmittedFileName();

            if (submittedFileName == null
                    || submittedFileName.isBlank()) {

                req.setAttribute(
                        "alert",
                        "File ảnh không hợp lệ."
                );

                req.setAttribute(
                        "currentUser",
                        user
                );

                req.getRequestDispatcher(
                        "/views/user/profile.jsp"
                ).forward(req, resp);

                return;
            }

            String originalFileName =
                    Paths.get(
                            submittedFileName
                    ).getFileName().toString();

            String extension = "";

            int lastDot =
                    originalFileName.lastIndexOf('.');

            if (lastDot >= 0) {
                extension =
                        originalFileName
                                .substring(lastDot)
                                .toLowerCase();
            }

            /*
             * Chỉ cho phép các định dạng ảnh.
             */
            if (!extension.equals(".jpg")
                    && !extension.equals(".jpeg")
                    && !extension.equals(".png")
                    && !extension.equals(".gif")
                    && !extension.equals(".webp")) {

                req.setAttribute(
                        "alert",
                        "Chỉ được upload file ảnh JPG, JPEG, PNG, GIF hoặc WEBP."
                );

                req.setAttribute(
                        "currentUser",
                        user
                );

                req.getRequestDispatcher(
                        "/views/user/profile.jsp"
                ).forward(req, resp);

                return;
            }

            /*
             * Tạo tên file mới để tránh trùng.
             */
            String newFileName =
                    "avatar_"
                            + user.getId()
                            + "_"
                            + UUID.randomUUID()
                            + extension;

            Path uploadDirectory =
                    Paths.get(Constant.DIR);

            Files.createDirectories(
                    uploadDirectory
            );

            Path destination =
                    uploadDirectory.resolve(
                            newFileName
                    );

            avatarPart.write(
                    destination.toString()
            );

            /*
             * Xóa avatar cũ nếu có.
             */
            if (user.getAvatar() != null
                    && !user.getAvatar().isBlank()) {

                File oldFile =
                        new File(
                                Constant.DIR,
                                user.getAvatar()
                        );

                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }

            user.setAvatar(newFileName);
        }

        try {

            userService.update(user);

            /*
             * Cập nhật User mới vào session.
             */
            session.setAttribute(
                    Constant.SESSION_ACCOUNT,
                    user
            );

            resp.sendRedirect(
                    req.getContextPath()
                            + "/user/profile?success=true"
            );

        } catch (Exception e) {

            e.printStackTrace();

            req.setAttribute(
                    "alert",
                    "Cập nhật thông tin thất bại."
            );

            req.setAttribute(
                    "currentUser",
                    user
            );

            req.getRequestDispatcher(
                    "/views/user/profile.jsp"
            ).forward(req, resp);
        }
    }
}

