package dingzhen.entity.info;

import org.apache.ibatis.type.Alias;

import dingzhen.common.base.BaseEntity;

// 库存
@Alias("stock")
public class Stock extends BaseEntity {

	private String id;
	private Mfr mfr;
	private Integer thisnum;
	private Integer totalnum;
	private String type;
	private String time;
	private String remarks;
	private String name;
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Mfr getMfr() {
		return mfr;
	}
	public void setMfr(Mfr mfr) {
		this.mfr = mfr;
	}
	public Integer getThisnum() {
		return thisnum;
	}
	public void setThisnum(Integer thisnum) {
		this.thisnum = thisnum;
	}
	public Integer getTotalnum() {
		return totalnum;
	}
	public void setTotalnum(Integer totalnum) {
		this.totalnum = totalnum;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
}
