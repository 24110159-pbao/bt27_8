package vn.iotstar.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotEmpty;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Entity
@Table(name = "Category")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Category implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cate_id")
    private int categoryid;

    @NotEmpty(message = "Tên danh mục không được để trống")
    @Column(name = "cate_name", nullable = false, length = 255)
    private String categoryname;

    @Column(name = "icons", length = 255)
    private String images;
}