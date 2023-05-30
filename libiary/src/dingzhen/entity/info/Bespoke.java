package dingzhen.entity.info;

import org.apache.ibatis.type.Alias;

import dingzhen.common.base.BaseEntity;
import dingzhen.entity.sys.User;

@Alias("bespoke")
public class Bespoke extends BaseEntity{
	
	private String id;
	private Lab lab;
	private Libr libr;
	private String type;
	private String applytime;
	private String usertime;
	private User user;
	private String remarks;
	private String approveresult;
	private String approvetime;
	
	
	public Libr getLibr() {
		return libr;
	}
	public void setLibr(Libr libr) {
		this.libr = libr;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Lab getLab() {
		return lab;
	}
	public void setLab(Lab lab) {
		this.lab = lab;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getApplytime() {
		return applytime;
	}
	public void setApplytime(String applytime) {
		this.applytime = applytime;
	}
	public String getUsertime() {
		return usertime;
	}
	public void setUsertime(String usertime) {
		this.usertime = usertime;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getApproveresult() {
		return approveresult;
	}
	public void setApproveresult(String approveresult) {
		this.approveresult = approveresult;
	}
	public String getApprovetime() {
		return approvetime;
	}
	public void setApprovetime(String approvetime) {
		this.approvetime = approvetime;
	}
	

}
