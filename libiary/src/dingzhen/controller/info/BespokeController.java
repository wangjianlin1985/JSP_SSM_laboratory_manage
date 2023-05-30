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
import dingzhen.entity.info.Bespoke;
import dingzhen.entity.info.Bespokemfr;
import dingzhen.entity.sys.User;
import dingzhen.service.info.BespokeService;
import dingzhen.service.info.BespokemfrService;

@Controller
@RequestMapping("bespoke")
public class BespokeController extends BaseController<Bespoke>{
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Autowired
	private BespokeService bespokeService;
	@Autowired
	private BespokemfrService bespokemfrService;

	@RequestMapping("index")
	public String index(){
		return "info/bespokeIndex";
	}
	
	
	@RequestMapping("myindex")
	public String myindex(HttpServletRequest request){
		User user = (User) request.getSession().getAttribute("currentUser");
		request.setAttribute("currentUser", user);
		return "info/bespokeMyindex";
	}
	
	
	
	
	
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response){
		try {
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			Bespoke bespoke = new Bespoke();
			bespoke.setPage((page-1)*rows);
			bespoke.setRows(rows);
			String userid = request.getParameter("userid");
			if(StringUtil.isNotEmpty(userid)){
				User user = new User();
				user.setId(userid);;
				bespoke.setUser(user);
			}
			bespoke.setKeyword(request.getParameter("keyword"));
			List<Bespoke> list = bespokeService.findList(bespoke);
			int total = bespokeService.count(bespoke);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			o.put("total", total);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	@RequestMapping("reserveBespoke")
	public void reserveBespoke(HttpServletRequest request,HttpServletResponse response,Bespoke bespoke){
		String id = request.getParameter("id");
		JSONObject o = new JSONObject();
		try {
			if(StringUtil.isEmpty(id)){
				bespoke.setId(get32UUID());
				User user = (User) request.getSession().getAttribute("currentUser");
				bespoke.setUser(user);
				bespoke.setApplytime(sdf.format(new Date()));
				bespokeService.add(bespoke);
			} else {
				bespoke.setId(id);
				bespokeService.update(bespoke);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg","保存失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	
	
	
	@RequestMapping("deleteBespoke")
	public void deleteBespoke(HttpServletRequest request,HttpServletResponse response){
		JSONObject o = new JSONObject();
		try {
			String ids[] = request.getParameter("ids").split(",");
			for(String id : ids){
				Bespoke bespoke = new Bespoke();
				bespoke.setId(id);
				bespokeService.delete(bespoke);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg", "删除失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	
	@RequestMapping("updateApprove")
	public void updateApprove(HttpServletRequest request,HttpServletResponse response,Bespoke bespoke){
		String id = request.getParameter("id");
		JSONObject o = new JSONObject();
		String result = request.getParameter("approveresult");
		try {
			bespoke.setId(id);
			if("1".equals(result)){
				bespoke.setApproveresult("同意");
			} else {
				bespoke.setApproveresult("不同意");
			}
			bespoke.setApprovetime(sdf.format(new Date()));
			bespokeService.updateApprove(bespoke);
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
			String bespokeid = request.getParameter("bespokeid");
			Bespoke bespoke = new Bespoke();
			bespoke.setId(bespokeid);
			Bespokemfr bm = new Bespokemfr();
			bm.setBespoke(bespoke);
			List<Bespokemfr> list = bespokemfrService.findList(bm);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping("reserveMfr")
	public void reserveMfr(HttpServletRequest request,HttpServletResponse response,Bespokemfr bespokemfr){
		String id = request.getParameter("id");
		JSONObject o = new JSONObject();
		try {
			if(StringUtil.isEmpty(id)){
				bespokemfr.setId(get32UUID());
				bespokemfrService.add(bespokemfr);
			} else {
				bespokemfr.setId(id);
				bespokemfrService.update(bespokemfr);
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
				Bespokemfr bespokemfr = new Bespokemfr();
				bespokemfr.setId(id);
				bespokemfrService.delete(bespokemfr);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg", "删除失败");
		}
		WriterUtil.write(response, o.toString());
	}
}
