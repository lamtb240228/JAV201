package entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "favorites")
public class Favorite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "VideoId")
    private Video video;

    @ManyToOne
    @JoinColumn(name = "UserId")
    private User user;

    @Temporal(TemporalType.DATE)
    @Column(name = "LikeDate", nullable = false, length = 50)
    private Date likeDate;

    public Favorite(Long id, Video video, User user, Date likeDate) {
        this.id = id;
        this.video = video;
        this.user = user;
        this.likeDate = likeDate;
    }

    public Favorite() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getLikeDate() {
        return likeDate;
    }

    public void setLikeDate(Date likeDate) {
        this.likeDate = likeDate;
    }
}