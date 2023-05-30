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
import dingzhen.entity.info.Lab;
import dingzhen.entity.info.Lablog;
import dingzhen.entity.sys.User;
import dingzhen.service.info.LablogService;

@Controller
@RequestMapping("lablog")
public class LablogController extends BaseController<Lablog> {

	@Autowired
	private LablogService lablogService;
	@Autowired
	@RequestMapping("index")
	public String index(){
		return "info/lablogIndex";
	}
	
	
	@RequestMapping("myindex")
	public String myindex(HttpServletRequest request){
		User user = (User) request.getSession().getAttribute("currentUser");
		request.setAttribute("currentUser", user);
		return "info/lablogMyindex";
	}
	
	
	
	
	
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response){
		try {
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			Lablog lablog = new Lablog();
			lablog.setPage((page-1)*rows);
			lablog.setRows(rows);
			String userid = request.getParameter("userid");
			if(StringUtil.isNotEmpty(userid)){
				User user = new User();
				user.setId(userid);;
				lablog.setUser(user);
			}
			List<Lablog> list = lablogService.findList(lablog);
			int total = lablogService.count(lablog);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			o.put("total", total);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	@RequestMapping("reserveLablog")
	public void reserveLablog(HttpServletRequest request,HttpServletResponse response,Lablog lablog){
		String id = request.getParameter("id");
		JSONObject o = new JSONObject();
		try {
			if(StringUtil.isEmpty(id)){
				lablog.setId(get32UUID());
				User user = (User) request.getSession().getAttribute("currentUser");
				lablog.setUser(user);
				lablogService.add(lablog);
			} else {
				lablog.setId(id);
				lablogService.update(lablog);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg","保存失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	@RequestMapping("toAdd")
	public String toAdd(){
		return "info/lablogAdd";
	}
	
	@RequestMapping("toUpdate")
	public String toUpdate(HttpServletRequest request){
		try {
			String id = request.getParameter("id");
			Lablog lablog = new Lablog();
			lablog.setId(id);
			lablog = lablogService.findOne(lablog);
			request.setAttribute("lablog", lablog);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "info/lablogUpdate";
	}
	
	@RequestMapping("findOne")
	public String findOne(HttpServletRequest request){
		try {
			String id = request.getParameter("id");
			Lablog lablog = new Lablog();
			lablog.setId(id);
			lablog = lablogService.findOne(lablog);
			request.setAttribute("lablog", lablog);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "info/lablogView";
	}
	
	
	
	
	@RequestMapping("deleteLablog")
	public void deleteLablog(HttpServletRequest request,HttpServletResponse response){
		JSONObject o = new JSONObject();
		try {
			String ids[] = request.getParameter("ids").split(",");
			for(String id : ids){
				Lablog lablog = new Lablog();
				lablog.setId(id);
				lablogService.delete(lablog);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg", "删除失败");
		}
		WriterUtil.write(response, o.toString());
	}
}
