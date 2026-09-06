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

        if (session == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }


        User sessionUser =
                (User) session.getAttribute(
                        Constant.SESSION_ACCOUNT
                );


        if (sessionUser == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }


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


        if (session == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }


        User sessionUser =
                (User) session.getAttribute(
                        Constant.SESSION_ACCOUNT
                );


        if (sessionUser == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );

            return;
        }


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


        String fullname =
                req.getParameter("fullname");


        String phone =
                req.getParameter("phone");


        /*
         * ==========================================
         * VALIDATE FULLNAME
         * ==========================================
         */

        if (fullname == null
                || fullname.trim().isEmpty()) {

            showError(
                    req,
                    resp,
                    user,
                    "Họ tên không được để trống."
            );

            return;
        }


        fullname = fullname.trim();


        if (fullname.length() < 2
                || fullname.length() > 100) {

            showError(
                    req,
                    resp,
                    user,
                    "Họ tên phải từ 2 đến 100 ký tự."
            );

            return;
        }


        /*
         * ==========================================
         * VALIDATE PHONE
         * ==========================================
         */

        if (phone != null) {

            phone = phone.trim();

        }


        if (phone == null || phone.isEmpty()) {

            showError(
                    req,
                    resp,
                    user,
                    "Số điện thoại không được để trống."
            );

            return;
        }


        if (!phone.matches(
                "^(0|\\+84)[0-9]{9,10}$")) {

            showError(
                    req,
                    resp,
                    user,
                    "Số điện thoại không hợp lệ."
            );

            return;
        }


        /*
         * ==========================================
         * CHECK PHONE UNIQUE
         * ==========================================
         */

        User phoneUser =
                userService.findByPhone(phone);


        if (phoneUser != null
                && phoneUser.getId() != user.getId()) {

            showError(
                    req,
                    resp,
                    user,
                    "Số điện thoại đã được sử dụng."
            );

            return;
        }


        user.setFullname(fullname);
        user.setPhone(phone);


        /*
         * ==========================================
         * UPLOAD AVATAR
         * ==========================================
         */

        String oldAvatar =
                user.getAvatar();


        String newAvatar =
                null;


        Part avatarPart =
                req.getPart("avatar");


        if (avatarPart != null
                && avatarPart.getSize() > 0) {

            String submittedFileName =
                    avatarPart.getSubmittedFileName();


            if (submittedFileName == null
                    || submittedFileName.isBlank()) {

                showError(
                        req,
                        resp,
                        user,
                        "File ảnh không hợp lệ."
                );

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


            if (!extension.equals(".jpg")
                    && !extension.equals(".jpeg")
                    && !extension.equals(".png")
                    && !extension.equals(".gif")
                    && !extension.equals(".webp")) {

                showError(
                        req,
                        resp,
                        user,
                        "Chỉ được upload file ảnh JPG, JPEG, PNG, GIF hoặc WEBP."
                );

                return;
            }


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


            newAvatar = newFileName;

            user.setAvatar(newAvatar);
        }


        /*
         * ==========================================
         * UPDATE DATABASE
         * ==========================================
         */

        try {

            userService.update(user);


            /*
             * Xóa avatar cũ sau khi DB update
             * thành công.
             */

            if (newAvatar != null
                    && oldAvatar != null
                    && !oldAvatar.isBlank()
                    && !oldAvatar.equals(newAvatar)) {

                File oldFile =
                        new File(
                                Constant.DIR,
                                oldAvatar
                        );


                if (oldFile.exists()) {

                    oldFile.delete();

                }

            }


            /*
             * Update session.
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


            /*
             * Nếu DB update thất bại nhưng file mới
             * đã được ghi thì xóa file mới.
             */

            if (newAvatar != null) {

                File newFile =
                        new File(
                                Constant.DIR,
                                newAvatar
                        );


                if (newFile.exists()) {

                    newFile.delete();

                }

            }


            /*
             * Khôi phục avatar cũ trong object.
             */

            user.setAvatar(oldAvatar);


            showError(
                    req,
                    resp,
                    user,
                    "Cập nhật thông tin thất bại."
            );
        }
    }


    /*
     * ==============================================
     * SHOW ERROR
     * ==============================================
     */

    private void showError(
            HttpServletRequest req,
            HttpServletResponse resp,
            User user,
            String message)
            throws ServletException, IOException {

        req.setAttribute(
                "alert",
                message
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
