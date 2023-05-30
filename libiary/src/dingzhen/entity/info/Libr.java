package dingzhen.entity.info;

import org.apache.ibatis.type.Alias;

import dingzhen.common.base.BaseEntity;

@Alias("libr")
public class Libr  extends BaseEntity{

	private String id;
	private String name;
	private String kebiao;
	private String location;
	
	
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getKebiao() {
		return kebiao;
	}
	public void setKebiao(String kebiao) {
		this.kebiao = kebiao;
	}
	
}
