package vn.iotstar.controller;

import java.io.IOException;
import java.io.Serial;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Video;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IVideoService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.VideoServiceImpl;

@WebServlet({
        "/admin/videos",
        "/admin/video/add",
        "/admin/video/insert",
        "/admin/video/edit",
        "/admin/video/update",
        "/admin/video/delete"
})
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

        if (url.contains("/admin/videos")) {

            req.setAttribute(
                    "listVideo",
                    videoService.findAll()
            );

            req.getRequestDispatcher(
                    "/views/admin/video-list.jsp"
            ).forward(req, resp);

        } else if (url.contains("/admin/video/add")) {

            req.setAttribute(
                    "listCategory",
                    categoryService.findAll()
            );

            req.getRequestDispatcher(
                    "/views/admin/video-add.jsp"
            ).forward(req, resp);

        } else if (url.contains("/admin/video/edit")) {

            String videoId =
                    req.getParameter("id");

            Video video =
                    videoService.findById(videoId);

            if (video == null) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/videos"
                );

                return;
            }

            req.setAttribute("video", video);

            req.setAttribute(
                    "listCategory",
                    categoryService.findAll()
            );

            req.getRequestDispatcher(
                    "/views/admin/video-edit.jsp"
            ).forward(req, resp);

        } else if (url.contains("/admin/video/delete")) {

            String videoId =
                    req.getParameter("id");

            try {

                videoService.delete(videoId);

            } catch (Exception e) {

                e.printStackTrace();
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

        String url = req.getRequestURI();

        if (url.contains("/admin/video/insert")) {

            String videoId =
                    req.getParameter("videoId");

            String title =
                    req.getParameter("title");

            String description =
                    req.getParameter("description");

            String poster =
                    req.getParameter("poster");

            int views =
                    Integer.parseInt(
                            req.getParameter("views")
                    );

            boolean active =
                    Boolean.parseBoolean(
                            req.getParameter("active")
                    );

            int categoryId =
                    Integer.parseInt(
                            req.getParameter("categoryId")
                    );

            Category category =
                    categoryService.findById(categoryId);

            Video video = new Video();

            video.setVideoId(videoId);
            video.setTitle(title);
            video.setDescription(description);
            video.setPoster(poster);
            video.setViews(views);
            video.setActive(active);
            video.setCategory(category);

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

                req.setAttribute(
                        "listCategory",
                        categoryService.findAll()
                );

                req.getRequestDispatcher(
                        "/views/admin/video-add.jsp"
                ).forward(req, resp);
            }

        } else if (url.contains("/admin/video/update")) {

            String videoId =
                    req.getParameter("videoId");

            String title =
                    req.getParameter("title");

            String description =
                    req.getParameter("description");

            String poster =
                    req.getParameter("poster");

            int views =
                    Integer.parseInt(
                            req.getParameter("views")
                    );

            boolean active =
                    Boolean.parseBoolean(
                            req.getParameter("active")
                    );

            int categoryId =
                    Integer.parseInt(
                            req.getParameter("categoryId")
                    );

            Video video =
                    videoService.findById(videoId);

            if (video == null) {

                resp.sendRedirect(
                        req.getContextPath()
                                + "/admin/videos"
                );

                return;
            }

            Category category =
                    categoryService.findById(categoryId);

            video.setTitle(title);
            video.setDescription(description);
            video.setPoster(poster);
            video.setViews(views);
            video.setActive(active);
            video.setCategory(category);

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

                req.setAttribute(
                        "listCategory",
                        categoryService.findAll()
                );

                req.getRequestDispatcher(
                        "/views/admin/video-edit.jsp"
                ).forward(req, resp);
            }
        }
    }
}
