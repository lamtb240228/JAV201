package entity;

import jakarta.persistence.*;


import java.util.Date;

@Entity
@Table(
        name = "Favorite",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"UserId", "VideoId"})
        }
)
public class Favorite {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @Temporal(TemporalType.DATE)
    @Column(name = "LikeDate")
    private Date likeDate;

    @ManyToOne
    @JoinColumn(name = "UserId")
    private User user;

    @ManyToOne
    @JoinColumn(name = "VideoId")
    private Video video;

    // getter setter

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getLikeDate() {
        return likeDate;
    }

    public void setLikeDate(Date likeDate) {
        this.likeDate = likeDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }
}
