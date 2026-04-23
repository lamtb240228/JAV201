package entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "videos")
public class Video {
    @Id
    @Column(name = "VideoId", length = 50)
    private String id;

    @Column(name = "Title", nullable = false, length = 100) // Tăng length nếu tiêu đề dài
    private String title;

    @Column(name = "Poster", nullable = false, length = 255) // Poster thường là URL nên cần dài hơn
    private String poster;

    @Column(name = "Description", nullable = false, columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "Active", nullable = false)
    private boolean active;

    @Column(name = "Views", nullable = false)
    private int views; // Đổi thành views (chữ v thường)

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL)
    private List<Favorite> favorites;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userID")
    private User owner;

    // Constructors
    public Video() {}

    public Video(String id, String title, String poster, String description, boolean active, int views) {
        this.id = id;
        this.title = title;
        this.poster = poster;
        this.description = description;
        this.active = active;
        this.views = views;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }

    public List<Favorite> getFavorites() { return favorites; }
    public void setFavorites(List<Favorite> favorites) { this.favorites = favorites; }

/*************  ✨ Windsurf Command ⭐  *************/
    /**
     * Get the owner of the video.
     *
     * @return the owner of the video.
     */
/*******  57b07bb0-e8a4-4271-ba4c-58f5e5952294  *******/

    public User getOwner() { return owner; }
    public void setOwner(User owner) { this.owner = owner; } // Đã thêm dấu đóng ngoặc ở đây



    // Logic định dạng view
    public String getViewsFormatted() {
        if (views >= 1_000_000)
            return Math.round(views / 100_000.0) / 10.0 + "M";
        if (views >= 1_000)
            return Math.round(views / 100.0) / 10.0 + "K";
        return String.valueOf(views);
    }
}