package dingzhen.service.impl.info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dingzhen.common.base.BaseServiceImpl;
import dingzhen.dao.info.QuestionDao;
import dingzhen.entity.info.Question;
import dingzhen.service.info.QuestionService;

@Service("questionService")
public class QuestionServiceImpl extends BaseServiceImpl<Question> implements QuestionService{
	
	@Autowired
	private QuestionDao dao;

	public void updateAnswer(Question question) {
		dao.updateAnswer(question);
	}

}
