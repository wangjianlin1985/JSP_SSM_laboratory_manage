package dingzhen.dao.info;

import org.springframework.stereotype.Repository;

import dingzhen.common.base.BaseDao;
import dingzhen.entity.info.Bespoke;

@Repository
public interface BespokeDao extends BaseDao<Bespoke> {

	public void updateApprove(Bespoke bespoke);
	
}
