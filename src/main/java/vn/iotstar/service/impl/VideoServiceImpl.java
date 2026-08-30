package vn.iotstar.service.impl;

import java.util.List;

import vn.iotstar.dao.IVideoDao;
import vn.iotstar.dao.impl.VideoDaoImpl;
import vn.iotstar.entity.Video;
import vn.iotstar.service.IVideoService;

public class VideoServiceImpl implements IVideoService {

    private final IVideoDao videoDao = new VideoDaoImpl();

    @Override
    public void insert(Video video) {

        if (videoDao.findById(video.getVideoId()) != null) {
            throw new RuntimeException("Video ID đã tồn tại");
        }

        videoDao.insert(video);
    }

    @Override
    public void update(Video video) {

        Video oldVideo =
                videoDao.findById(video.getVideoId());

        if (oldVideo == null) {
            throw new RuntimeException("Không tìm thấy Video");
        }

        videoDao.update(video);
    }

    @Override
    public void delete(String videoId) throws Exception {
        videoDao.delete(videoId);
    }

    @Override
    public Video findById(String videoId) {
        return videoDao.findById(videoId);
    }

    @Override
    public List<Video> findAll() {
        return videoDao.findAll();
    }

    @Override
    public List<Video> findAll(int page, int pageSize) {
        return videoDao.findAll(page, pageSize);
    }

    @Override
    public List<Video> searchByTitle(String title) {
        return videoDao.searchByTitle(title);
    }

    @Override
    public List<Video> findByCategory(int categoryId) {
        return videoDao.findByCategory(categoryId);
    }

    @Override
    public int count() {
        return videoDao.count();
    }
}
