package dingzhen.entity.info;

import org.apache.ibatis.type.Alias;

import dingzhen.common.base.BaseEntity;
import dingzhen.entity.sys.User;

@Alias("question")
public class Question extends BaseEntity{

	private String id;
	private String title;
	private String asktime;
	private User askuser;
	private String content;
	private User answeruser;
	private String answertime;
	private String answer;
	private String status;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAsktime() {
		return asktime;
	}
	public void setAsktime(String asktime) {
		this.asktime = asktime;
	}
	public User getAskuser() {
		return askuser;
	}
	public void setAskuser(User askuser) {
		this.askuser = askuser;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public User getAnsweruser() {
		return answeruser;
	}
	public void setAnsweruser(User answeruser) {
		this.answeruser = answeruser;
	}
	public String getAnswertime() {
		return answertime;
	}
	public void setAnswertime(String answertime) {
		this.answertime = answertime;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
