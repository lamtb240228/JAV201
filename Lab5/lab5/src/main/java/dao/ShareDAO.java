package dao;

import entity.Share;

import java.util.List;

public interface ShareDAO extends GenericDAO<Share, Long> {

    List<Share> findByYear(int year);

    List<Object[]> shareSummaryByVideo();
}
