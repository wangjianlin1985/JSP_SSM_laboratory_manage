package dingzhen.dao.info;

import org.springframework.stereotype.Repository;

import dingzhen.common.base.BaseDao;
import dingzhen.entity.info.Question;

@Repository
public interface QuestionDao extends BaseDao<Question>{

	public void updateAnswer(Question question);
	
}
