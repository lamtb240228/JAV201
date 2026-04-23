package entity;

import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "shares")
public class Share {
    @Id
    @Column(name = "Id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "VideoId")
    private Video video;

    @ManyToOne
    @JoinColumn(name = "UserId")
    private User user;

    @Column(name = "Emails")
    private String emails;

    @Column(name = "ShareDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date shareDate;

    public Share() {}


    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Video getVideo() { return video; }
    public void setVideo(Video video) { this.video = video; }

    public String getEmails() { return emails; }
    public void setEmails(String emails) { this.emails = emails; }

    public Date getShareDate() { return shareDate; }
    public void setShareDate(Date shareDate) { this.shareDate = shareDate; }
}
