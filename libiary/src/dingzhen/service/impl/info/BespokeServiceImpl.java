package dingzhen.service.impl.info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dingzhen.common.base.BaseServiceImpl;
import dingzhen.dao.info.BespokeDao;
import dingzhen.entity.info.Bespoke;
import dingzhen.service.info.BespokeService;

@Service("bespokeService")
public class BespokeServiceImpl extends BaseServiceImpl<Bespoke> implements BespokeService{

	@Autowired
	private BespokeDao dao;
	
	public void updateApprove(Bespoke bespoke) {
		dao.updateApprove(bespoke);
	}

}
