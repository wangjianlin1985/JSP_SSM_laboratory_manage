package dingzhen.controller.info;

import java.text.SimpleDateFormat;
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
import dingzhen.entity.info.Takeout;
import dingzhen.entity.info.Takeoutmfr;
import dingzhen.entity.sys.User;
import dingzhen.service.info.TakeoutService;
import dingzhen.service.info.TakeoutmfrService;

@Controller
@RequestMapping("takeout")
public class TakeoutController extends BaseController<Takeout>{
private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Autowired
	private TakeoutService takeoutService;
	@Autowired
	private TakeoutmfrService takeoutmfrService;

	@RequestMapping("index")
	public String index(){
		return "info/takeoutIndex";
	}
	
	
	@RequestMapping("myindex")
	public String myindex(HttpServletRequest request){
		User user = (User) request.getSession().getAttribute("currentUser");
		request.setAttribute("currentUser", user);
		return "info/takeoutMyindex";
	}
	
	
	
	
	
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response){
		try {
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			Takeout takeout = new Takeout();
			takeout.setPage((page-1)*rows);
			takeout.setRows(rows);
			String userid = request.getParameter("userid");
			if(StringUtil.isNotEmpty(userid)){
				User user = new User();
				user.setId(userid);;
				takeout.setUser(user);
			}
			takeout.setTitle(request.getParameter("title"));
			List<Takeout> list = takeoutService.findList(takeout);
			int total = takeoutService.count(takeout);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			o.put("total", total);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	@RequestMapping("reserveTakeout")
	public void reserveTakeout(HttpServletRequest request,HttpServletResponse response,Takeout takeout){
		String id = request.getParameter("id");
		JSONObject o = new JSONObject();
		try {
			if(StringUtil.isEmpty(id)){
				takeout.setId(get32UUID());
				User user = (User) request.getSession().getAttribute("currentUser");
				takeout.setUser(user);
				takeout.setApplytime(sdf.format(new Date()));
				takeoutService.add(takeout);
			} else {
				takeout.setId(id);
				takeoutService.update(takeout);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg","保存失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	
	
	
	@RequestMapping("deleteTakeout")
	public void deleteTakeout(HttpServletRequest request,HttpServletResponse response){
		JSONObject o = new JSONObject();
		try {
			String ids[] = request.getParameter("ids").split(",");
			for(String id : ids){
				Takeout takeout = new Takeout();
				takeout.setId(id);
				takeoutService.delete(takeout);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg", "删除失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	
	@RequestMapping("updateApprove")
	public void updateApprove(HttpServletRequest request,HttpServletResponse response,Takeout takeout){
		String id = request.getParameter("id");
		JSONObject o = new JSONObject();
		String result = request.getParameter("approveresult");
		try {
			takeout.setId(id);
			takeout.setApplytime(sdf.format(new Date()));
			if("1".equals(result)){
				takeout.setApproveresult("同意");
			} else {
				takeout.setApproveresult("不同意");
			}
			takeout.setApprovetime(sdf.format(new Date()));
			takeoutService.updateApprover(takeout);
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg","保存失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	
	@RequestMapping("mfrList")
	public void mfrList(HttpServletRequest request,HttpServletResponse response){
		try {
			String takeoutid = request.getParameter("takeoutid");
			Takeout takeout = new Takeout();
			takeout.setId(takeoutid);
			Takeoutmfr bm = new Takeoutmfr();
			bm.setTakeout(takeout);
			List<Takeoutmfr> list = takeoutmfrService.findList(bm);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping("reserveMfr")
	public void reserveMfr(HttpServletRequest request,HttpServletResponse response,Takeoutmfr takeoutmfr){
		String id = request.getParameter("id");
		JSONObject o = new JSONObject();
		try {
			if(StringUtil.isEmpty(id)){
				takeoutmfr.setId(get32UUID());
				takeoutmfrService.add(takeoutmfr);
			} else {
				takeoutmfr.setId(id);
				takeoutmfrService.update(takeoutmfr);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg","保存失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	
	@RequestMapping("deleteMfr")
	public void deleteMfr(HttpServletRequest request,HttpServletResponse response){
		JSONObject o = new JSONObject();
		try {
			String ids[] = request.getParameter("ids").split(",");
			for(String id : ids){
				Takeoutmfr takeoutmfr = new Takeoutmfr();
				takeoutmfr.setId(id);
				takeoutmfrService.delete(takeoutmfr);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg", "删除失败");
		}
		WriterUtil.write(response, o.toString());
	}
}
