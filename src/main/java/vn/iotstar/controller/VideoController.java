package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.io.Serial;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Video;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IVideoService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.VideoServiceImpl;
import vn.iotstar.util.Constant;

@WebServlet({
        "/admin/videos",
        "/admin/video/add",
        "/admin/video/insert",
        "/admin/video/edit",
        "/admin/video/update",
        "/admin/video/delete"
})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class VideoController extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    private final IVideoService videoService =
            new VideoServiceImpl();

    private final ICategoryService categoryService =
            new CategoryServiceImpl();


    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String url = req.getRequestURI();


        // ==================================================
        // DANH SÁCH VIDEO
        // ==================================================

        if (url.contains("/admin/videos")) {

            String keyword = req.getParameter("keyword");

            List<Video> listVideo;

            if (keyword != null && !keyword.trim().isEmpty()) {

                listVideo =
                        videoService.searchByTitle(
                                keyword.trim()
                        );

            } else {

                listVideo =
                        videoService.findAll();
            }


            req.setAttribute(
                    "listVideo",
                    listVideo
            );


            req.setAttribute(
                    "keyword",
                    keyword
            );


            req.getRequestDispatcher(
                    "/views/admin/video-list.jsp"
            ).forward(req, resp);

        }


        // ==================================================
        // TRANG THÊM VIDEO
        // ==================================================

        else if (url.contains("/admin/video/add")) {

            req.setAttribute(
                    "listCategory",
                    categoryService.findAll()
            );


            req.getRequestDispatcher(
                    "/views/admin/video-add.jsp"
            ).forward(req, resp);

        }


        // ==================================================
        // TRANG SỬA VIDEO
        // ==================================================

        else if (url.contains("/admin/video/edit")) {

            String videoId =
                    req.getParameter("id");


            if (videoId == null
                    || videoId.trim().isEmpty()) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/videos"
                );

                return;
            }


            Video video =
                    videoService.findById(
                            videoId.trim()
                    );


            if (video == null) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/videos"
                );

                return;
            }


            req.setAttribute(
                    "video",
                    video
            );


            req.setAttribute(
                    "listCategory",
                    categoryService.findAll()
            );


            req.getRequestDispatcher(
                    "/views/admin/video-edit.jsp"
            ).forward(req, resp);

        }


        // ==================================================
        // DELETE VIDEO
        // ==================================================

        else if (url.contains("/admin/video/delete")) {

            String videoId =
                    req.getParameter("id");


            if (videoId != null
                    && !videoId.trim().isEmpty()) {

                try {

                    videoService.delete(
                            videoId.trim()
                    );

                } catch (Exception e) {

                    e.printStackTrace();
                }
            }


            resp.sendRedirect(
                    req.getContextPath()
                            + "/admin/videos"
            );
        }
    }


    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");


        String url =
                req.getRequestURI();


        // ==================================================
        // INSERT
        // ==================================================

        if (url.contains("/admin/video/insert")) {

            String videoId =
                    req.getParameter("videoId");

            String title =
                    req.getParameter("title");

            String description =
                    req.getParameter("description");

            String viewsParam =
                    req.getParameter("views");

            String categoryIdParam =
                    req.getParameter("categoryId");

            String activeParam =
                    req.getParameter("active");


            // =========================
            // VALIDATE
            // =========================

            if (isEmpty(videoId)
                    || isEmpty(title)
                    || isEmpty(categoryIdParam)) {

                req.setAttribute(
                        "error",
                        "Vui lòng nhập đầy đủ thông tin bắt buộc!"
                );

                loadCategories(req);

                req.getRequestDispatcher(
                        "/views/admin/video-add.jsp"
                ).forward(req, resp);

                return;
            }


            int categoryId;

            try {

                categoryId =
                        Integer.parseInt(
                                categoryIdParam
                        );

            } catch (NumberFormatException e) {

                req.setAttribute(
                        "error",
                        "Danh mục không hợp lệ!"
                );

                loadCategories(req);

                req.getRequestDispatcher(
                        "/views/admin/video-add.jsp"
                ).forward(req, resp);

                return;
            }


            int views = 0;

            if (viewsParam != null
                    && !viewsParam.trim().isEmpty()) {

                try {

                    views =
                            Integer.parseInt(
                                    viewsParam
                            );

                } catch (NumberFormatException e) {

                    views = 0;
                }
            }


            Category category =
                    categoryService.findById(
                            categoryId
                    );


            if (category == null) {

                req.setAttribute(
                        "error",
                        "Danh mục không tồn tại!"
                );

                loadCategories(req);

                req.getRequestDispatcher(
                        "/views/admin/video-add.jsp"
                ).forward(req, resp);

                return;
            }


            // =========================
            // UPLOAD POSTER
            // =========================

            Part posterPart =
                    req.getPart("poster");


            String posterName =
                    uploadImage(posterPart);


            // =========================
            // CREATE VIDEO
            // =========================

            Video video =
                    new Video();


            video.setVideoId(
                    videoId.trim()
            );


            video.setTitle(
                    title.trim()
            );


            video.setDescription(
                    description != null
                            ? description.trim()
                            : null
            );


            video.setPoster(
                    posterName
            );


            video.setViews(
                    views
            );


            video.setActive(
                    "1".equals(activeParam)
                            || "true".equalsIgnoreCase(activeParam)
            );


            video.setCategory(
                    category
            );


            // =========================
            // INSERT DATABASE
            // =========================

            try {

                videoService.insert(video);


                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/videos"
                );

            } catch (Exception e) {

                e.printStackTrace();


                req.setAttribute(
                        "error",
                        e.getMessage()
                );


                req.setAttribute(
                        "video",
                        video
                );


                loadCategories(req);


                req.getRequestDispatcher(
                        "/views/admin/video-add.jsp"
                ).forward(req, resp);
            }
        }


        // ==================================================
        // UPDATE
        // ==================================================

        else if (url.contains("/admin/video/update")) {

            String videoId =
                    req.getParameter("videoId");

            String title =
                    req.getParameter("title");

            String description =
                    req.getParameter("description");

            String viewsParam =
                    req.getParameter("views");

            String categoryIdParam =
                    req.getParameter("categoryId");

            String activeParam =
                    req.getParameter("active");


            // =========================
            // VALIDATE
            // =========================

            if (isEmpty(videoId)
                    || isEmpty(title)
                    || isEmpty(categoryIdParam)) {

                req.setAttribute(
                        "error",
                        "Vui lòng nhập đầy đủ thông tin bắt buộc!"
                );

                Video video =
                        videoService.findById(videoId);

                req.setAttribute(
                        "video",
                        video
                );

                loadCategories(req);

                req.getRequestDispatcher(
                        "/views/admin/video-edit.jsp"
                ).forward(req, resp);

                return;
            }


            int categoryId;

            try {

                categoryId =
                        Integer.parseInt(
                                categoryIdParam
                        );

            } catch (NumberFormatException e) {

                req.setAttribute(
                        "error",
                        "Danh mục không hợp lệ!"
                );

                Video video =
                        videoService.findById(videoId);

                req.setAttribute(
                        "video",
                        video
                );

                loadCategories(req);

                req.getRequestDispatcher(
                        "/views/admin/video-edit.jsp"
                ).forward(req, resp);

                return;
            }


            int views = 0;

            if (viewsParam != null
                    && !viewsParam.trim().isEmpty()) {

                try {

                    views =
                            Integer.parseInt(
                                    viewsParam
                            );

                } catch (NumberFormatException e) {

                    views = 0;
                }
            }


            Video video =
                    videoService.findById(
                            videoId.trim()
                    );


            if (video == null) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/videos"
                );

                return;
            }


            Category category =
                    categoryService.findById(
                            categoryId
                    );


            if (category == null) {

                req.setAttribute(
                        "error",
                        "Danh mục không tồn tại!"
                );

                req.setAttribute(
                        "video",
                        video
                );

                loadCategories(req);

                req.getRequestDispatcher(
                        "/views/admin/video-edit.jsp"
                ).forward(req, resp);

                return;
            }


            // =========================
            // GIỮ POSTER CŨ
            // =========================

            String oldPoster =
                    video.getPoster();


            Part posterPart =
                    req.getPart("poster");


            if (posterPart != null
                    && posterPart.getSize() > 0) {

                String newPoster =
                        uploadImage(
                                posterPart
                        );

                video.setPoster(
                        newPoster
                );

            } else {

                video.setPoster(
                        oldPoster
                );
            }


            // =========================
            // UPDATE DATA
            // =========================

            video.setTitle(
                    title.trim()
            );


            video.setDescription(
                    description != null
                            ? description.trim()
                            : null
            );


            video.setViews(
                    views
            );


            video.setActive(
                    "1".equals(activeParam)
                            || "true".equalsIgnoreCase(activeParam)
            );


            video.setCategory(
                    category
            );


            // =========================
            // UPDATE DATABASE
            // =========================

            try {

                videoService.update(video);


                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/videos"
                );

            } catch (Exception e) {

                e.printStackTrace();


                req.setAttribute(
                        "error",
                        e.getMessage()
                );


                req.setAttribute(
                        "video",
                        video
                );


                loadCategories(req);


                req.getRequestDispatcher(
                        "/views/admin/video-edit.jsp"
                ).forward(req, resp);
            }
        }
    }


    // ==================================================
    // LOAD CATEGORY
    // ==================================================

    private void loadCategories(
            HttpServletRequest req) {

        req.setAttribute(
                "listCategory",
                categoryService.findAll()
        );
    }


    // ==================================================
    // CHECK EMPTY
    // ==================================================

    private boolean isEmpty(
            String value) {

        return value == null
                || value.trim().isEmpty();
    }


    // ==================================================
    // UPLOAD IMAGE
    // ==================================================

    private String uploadImage(
            Part part)
            throws IOException {

        if (part == null
                || part.getSize() == 0) {

            return null;
        }


        String submittedFileName =
                part.getSubmittedFileName();


        if (submittedFileName == null
                || submittedFileName.isEmpty()) {

            return null;
        }


        String originalName =
                Paths.get(
                                submittedFileName
                        )
                        .getFileName()
                        .toString();


        String extension = "";


        int dotIndex =
                originalName.lastIndexOf(".");


        if (dotIndex >= 0) {

            extension =
                    originalName.substring(
                            dotIndex
                    );
        }


        String fileName =
                System.currentTimeMillis()
                        + extension;


        File uploadDir =
                new File(
                        Constant.DIR
                );


        if (!uploadDir.exists()) {

            uploadDir.mkdirs();
        }


        File file =
                new File(
                        uploadDir,
                        fileName
                );


        part.write(
                file.getAbsolutePath()
        );


        return fileName;
    }
}
