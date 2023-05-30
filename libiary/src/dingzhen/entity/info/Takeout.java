package dingzhen.entity.info;

import org.apache.ibatis.type.Alias;

import dingzhen.common.base.BaseEntity;
import dingzhen.entity.sys.User;

@Alias("takeout")
public class Takeout extends BaseEntity{

	private String id;
	private String starttime;
	private User user;
	private String title;
	private String applytime;
	private String returntime;
	private String approvetime;
	private String approveresult;
	private String jingbanren;
	private String reason;
	
	
	
	public String getJingbanren() {
		return jingbanren;
	}
	public void setJingbanren(String jingbanren) {
		this.jingbanren = jingbanren;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getApplytime() {
		return applytime;
	}
	public void setApplytime(String applytime) {
		this.applytime = applytime;
	}
	public String getReturntime() {
		return returntime;
	}
	public void setReturntime(String returntime) {
		this.returntime = returntime;
	}
	public String getApprovetime() {
		return approvetime;
	}
	public void setApprovetime(String approvetime) {
		this.approvetime = approvetime;
	}
	public String getApproveresult() {
		return approveresult;
	}
	public void setApproveresult(String approveresult) {
		this.approveresult = approveresult;
	}
	
}
