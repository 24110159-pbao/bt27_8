package vn.iotstar.entity;

import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Column;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "Category")
public class Category implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cate_id")
    private int cateId;

    @Column(name = "cate_name", nullable = false, length = 255)
    private String cateName;

    @Column(name = "icons", length = 255)
    private String icons;

    @OneToMany(
            mappedBy = "category",
            cascade = CascadeType.ALL,
            orphanRemoval = false
    )
    private List<Video> videos = new ArrayList<>();

    @OneToMany(mappedBy = "category")
    private List<Product> products = new ArrayList<>();

    public Category() {
    }

    public Category(String cateName, String icons) {
        this.cateName = cateName;
        this.icons = icons;
    }

    public Video addVideo(Video video) {
        getVideos().add(video);
        video.setCategory(this);
        return video;
    }

    public Video removeVideo(Video video) {
        getVideos().remove(video);
        video.setCategory(null);
        return video;
    }

    public Product addProduct(Product product) {
        getProducts().add(product);
        product.setCategory(this);
        return product;
    }

    public Product removeProduct(Product product) {
        getProducts().remove(product);
        product.setCategory(null);
        return product;
    }
}
