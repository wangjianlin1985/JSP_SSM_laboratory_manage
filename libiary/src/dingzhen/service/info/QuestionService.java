package dingzhen.service.info;

import dingzhen.common.base.BaseService;
import dingzhen.entity.info.Question;

public interface QuestionService extends BaseService<Question>{
	public void updateAnswer(Question question);
}
