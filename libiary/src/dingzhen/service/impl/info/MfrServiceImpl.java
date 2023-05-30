package dingzhen.service.impl.info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dingzhen.common.base.BaseServiceImpl;
import dingzhen.dao.info.MfrDao;
import dingzhen.entity.info.Mfr;
import dingzhen.service.info.MfrService;

@Service("mfrService")
public class MfrServiceImpl extends BaseServiceImpl<Mfr> implements MfrService{

	@Autowired
	private MfrDao dao;

	public void updateNum(Mfr mfr) {
		dao.updateNum(mfr);
	}
	
}
