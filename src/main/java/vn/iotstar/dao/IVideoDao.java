package vn.iotstar.dao;

import java.util.List;

import vn.iotstar.entity.Video;

public interface IVideoDao {

    void insert(Video video);

    void update(Video video);

    void delete(String videoId) throws Exception;

    Video findById(String videoId);

    List<Video> findAll();

    List<Video> findAll(int page, int pageSize);

    List<Video> searchByTitle(String title);

    List<Video> findByCategory(int categoryId);

    int count();
}
