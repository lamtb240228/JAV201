package entity;

import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "Logs")
public class Log {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String url;

    @Temporal(TemporalType.TIMESTAMP)
    private Date time;

    private String username;

    // getter setter

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    public Log() {
    }
    public Log(String url, Date time, String username) {
        this.url = url;
        this.time = time;
        this.username = username;
    }


}
