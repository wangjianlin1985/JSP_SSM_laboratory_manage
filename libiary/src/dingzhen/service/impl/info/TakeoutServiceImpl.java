package dingzhen.service.impl.info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dingzhen.common.base.BaseServiceImpl;
import dingzhen.dao.info.TakeoutDao;
import dingzhen.entity.info.Takeout;
import dingzhen.service.info.TakeoutService;

@Service
public class TakeoutServiceImpl extends BaseServiceImpl<Takeout> implements TakeoutService{

	@Autowired
	private TakeoutDao dao;

	public void updateApprover(Takeout takeout) {
		dao.updateApprover(takeout);
	}
	
}
