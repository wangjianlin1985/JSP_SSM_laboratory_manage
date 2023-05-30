package dingzhen.service.info;

import dingzhen.common.base.BaseService;
import dingzhen.entity.info.Takeout;

public interface TakeoutService extends BaseService<Takeout> {
	public void updateApprover(Takeout takeout);
	
}
