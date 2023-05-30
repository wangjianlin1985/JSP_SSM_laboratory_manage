package dingzhen.dao.info;

import org.springframework.stereotype.Repository;

import dingzhen.common.base.BaseDao;
import dingzhen.entity.info.Mfr;

@Repository
public interface MfrDao extends BaseDao<Mfr>{

	public void updateNum(Mfr mfr);
	
}
