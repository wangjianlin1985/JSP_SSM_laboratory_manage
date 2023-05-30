package dingzhen.controller.info;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;

import dingzhen.common.base.BaseController;
import dingzhen.common.util.StringUtil;
import dingzhen.common.util.WriterUtil;
import dingzhen.entity.info.Repair;
import dingzhen.entity.info.Mfr;
import dingzhen.service.info.RepairService;

@Controller
@RequestMapping("repair")
public class RepairController extends BaseController<Repair> {

	@Autowired
	private RepairService repairService;
	
	@RequestMapping("index")
	public String index(){
		return "info/repairIndex";
	}
	
	
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response){
		try {
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			Repair repair = new Repair();
			repair.setPage((page-1)*rows);
			repair.setRows(rows);
			String mfrid = request.getParameter("mfrid");
			if(StringUtil.isNotEmpty(mfrid)){
				Mfr type = new Mfr();
				type.setId(mfrid);
				repair.setMfr(type);
			}
			List<Repair> list = repairService.findList(repair);
			int total = repairService.count(repair);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			o.put("total", total);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping("findOne")
	public String findOne(HttpServletRequest request){
		try {
			String id = request.getParameter("id");
			Repair repair = new Repair();
			repair.setId(id);
			repair = repairService.findOne(repair);
			request.setAttribute("repair", repair);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "info/repairView";
	}
	
	

	
	@RequestMapping("toUpdate")
	public String toUpdate(HttpServletRequest request){
		try {
			String id = request.getParameter("id");
			Repair repair = new Repair();
			repair.setId(id);
			repair = repairService.findOne(repair);
			request.setAttribute("repair", repair);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "info/repairUpdate";
	}
	
	
	@RequestMapping("deleteRepair")
	public void deleteRepair(HttpServletRequest request,HttpServletResponse response){
		JSONObject o = new JSONObject();
		try {
			String ids[] = request.getParameter("ids").split(",");
			for(String id : ids){
				Repair repair = new Repair();
				repair.setId(id);
				repairService.delete(repair);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg", "删除失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	@RequestMapping("updateRepair")
	public void updateRepair(HttpServletRequest request,HttpServletResponse response,Repair repair){
		JSONObject o = new JSONObject();
		try {
			repairService.update(repair);
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg","保存失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
}
