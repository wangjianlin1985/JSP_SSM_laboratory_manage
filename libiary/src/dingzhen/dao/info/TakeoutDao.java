package dingzhen.dao.info;

import org.springframework.stereotype.Repository;

import dingzhen.common.base.BaseDao;
import dingzhen.entity.info.Takeout;

@Repository
public interface TakeoutDao extends BaseDao<Takeout>{
	public void updateApprover(Takeout takeout);
}
