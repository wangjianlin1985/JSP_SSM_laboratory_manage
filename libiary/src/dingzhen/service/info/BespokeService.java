package dingzhen.service.info;

import dingzhen.common.base.BaseService;
import dingzhen.entity.info.Bespoke;

public interface BespokeService extends BaseService<Bespoke>{
	public void updateApprove(Bespoke bespoke);
}
