package dingzhen.controller.info;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import dingzhen.common.base.BaseController;
import dingzhen.common.util.StringUtil;
import dingzhen.common.util.WriterUtil;
import dingzhen.entity.info.Lab;
import dingzhen.entity.info.Libr;
import dingzhen.entity.info.Mfr;
import dingzhen.entity.info.Type;
import dingzhen.service.info.LabService;

@Controller
@RequestMapping("lab")
public class LabController extends BaseController<Lab> {

	@Autowired
	private LabService labService;
	
	@RequestMapping("labIndex")
	public String index(){
		return "info/labIndex";
	}
	
	
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response){
		try {
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			Lab lab = new Lab();
			lab.setTitle(request.getParameter("title"));
			lab.setPage((page-1)*rows);
			lab.setRows(rows);
			List<Lab> list = labService.findList(lab);
			int total = labService.count(lab);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			o.put("total", total);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	@RequestMapping("toAdd")
	public String toAdd(){
		return "info/labAdd";
	}
	
	@RequestMapping("toUpdate")
	public String toUpdate(HttpServletRequest request){
		try {
			String id = request.getParameter("id");
			Lab lab = new Lab();
			lab.setId(id);
			lab = labService.findOne(lab);
			request.setAttribute("lab", lab);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "info/labUpdate";
	}
	
	
	@RequestMapping("reserveLab")
	public void reserveLab(HttpServletRequest request,HttpServletResponse response,Lab lab){
		String id = request.getParameter("id");
		JSONObject o = new JSONObject();
		try {
			if(StringUtil.isEmpty(id)){
				lab.setId(get32UUID());
				labService.add(lab);
			} else {
				lab.setId(id);
				labService.update(lab);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("success", true);
			o.put("errorMsg","保存失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	
	@RequestMapping("findOne")
	public String findOne(HttpServletRequest request){
		try {
			String id = request.getParameter("id");
			Lab lab = new Lab();
			lab.setId(id);
			lab = labService.findOne(lab);
			request.setAttribute("lab", lab);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "info/labView";
	}
	
	
	
	
	@RequestMapping("deleteLab")
	public void deleteLab(HttpServletRequest request,HttpServletResponse response){
		JSONObject o = new JSONObject();
		try {
			String ids[] = request.getParameter("ids").split(",");
			for(String id : ids){
				Lab lab = new Lab();
				lab.setId(id);
				labService.delete(lab);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg", "删除失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	@RequestMapping("combo")
	public void combo(HttpServletRequest request,HttpServletResponse response){
		try {
			List<Lab> list = labService.findList(new Lab());
			JSONArray array = new JSONArray();
			array.addAll(list);
			WriterUtil.write(response, array.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
