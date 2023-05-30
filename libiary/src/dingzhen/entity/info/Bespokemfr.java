package dingzhen.entity.info;

import org.apache.ibatis.type.Alias;

import dingzhen.common.base.BaseEntity;

@Alias("bespokemfr")
public class Bespokemfr extends BaseEntity{

	private String id;
	private Mfr mfr;
	private Bespoke bespoke;
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
	public Bespoke getBespoke() {
		return bespoke;
	}
	public void setBespoke(Bespoke bespoke) {
		this.bespoke = bespoke;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	
}
