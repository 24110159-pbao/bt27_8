package vn.iotstar.entity;

import java.io.Serial;
import java.io.Serializable;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "videos")
@NamedQuery(name = "Video.findAll", query = "SELECT v FROM Video v")
public class Video implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "videoId", length = 50)
    private String videoId;

    @Column(name = "active", nullable = false)
    private boolean active;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "poster", length = 500)
    private String poster;

    @Column(name = "title", length = 255)
    private String title;

    @Column(name = "views", nullable = false)
    private int views;

    @ManyToOne
    @JoinColumn(name = "categoryId")
    private Category category;

    public Video() {
    }

}
