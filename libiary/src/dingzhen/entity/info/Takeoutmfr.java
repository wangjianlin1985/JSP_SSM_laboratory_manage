package dingzhen.entity.info;

import org.apache.ibatis.type.Alias;

import dingzhen.common.base.BaseEntity;

@Alias("takeoutmfr")
public class Takeoutmfr extends BaseEntity{
	private String id;
	private Mfr mfr;
	private Takeout takeout;
	private Integer num;
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
	public Takeout getTakeout() {
		return takeout;
	}
	public void setTakeout(Takeout takeout) {
		this.takeout = takeout;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	
}
