package dto;

import java.util.Date;

public class ShareReport {

    private String title;
    private Long shareCount;
    private Date firstDate;
    private Date lastDate;

    public ShareReport(String title, Long shareCount, Date firstDate, Date lastDate) {
        this.title = title;
        this.shareCount = shareCount;
        this.firstDate = firstDate;
        this.lastDate = lastDate;
    }

    public String getTitle() {
        return title;
    }

    public Long getShareCount() {
        return shareCount;
    }

    public Date getFirstDate() {
        return firstDate;
    }

    public Date getLastDate() {
        return lastDate;
    }
}
