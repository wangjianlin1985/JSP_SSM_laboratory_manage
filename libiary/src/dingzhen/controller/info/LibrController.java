package dingzhen.controller.info;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import dingzhen.common.base.BaseController;
import dingzhen.common.util.StringUtil;
import dingzhen.common.util.WriterUtil;
import dingzhen.entity.info.Libr;
import dingzhen.entity.info.Type;
import dingzhen.service.info.LibrService;

@Controller
@RequestMapping("libr")
public class LibrController extends BaseController<Libr>{

	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	
	@Autowired
	private LibrService librService;
	
	@RequestMapping("index")
	public String index(){
		return "info/libr";
	}
	
	
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response){
		try {
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			Libr libr = new Libr();
			libr.setPage((page-1)*rows);
			libr.setRows(rows);
			List<Libr> list = librService.findList(libr);
			int total = librService.count(libr);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			o.put("total", total);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	@RequestMapping("reserveLibr")
	public void reserveLibr(@RequestParam(value = "file",required = false) MultipartFile file,HttpServletRequest request,HttpServletResponse response,Libr libr){
		String id = request.getParameter("id");
		JSONObject o = new JSONObject();
		String date = sdf.format(new Date());
		String filePath = request.getSession().getServletContext().getRealPath("/")+ "upload/"+date+".JPG";
		try {
			if(file!=null && !file.isEmpty()){
				file.transferTo(new File(filePath));
				libr.setKebiao("upload/"+date + ".JPG");
			}
			if(StringUtil.isEmpty(id)){
				libr.setId(get32UUID());
				librService.add(libr);
			} else {
				libr.setId(id);
				librService.update(libr);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg","保存失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	
	
	
	@RequestMapping("deleteLibr")
	public void deleteLibr(HttpServletRequest request,HttpServletResponse response){
		JSONObject o = new JSONObject();
		try {
			String ids[] = request.getParameter("ids").split(",");
			for(String id : ids){
				Libr libr = new Libr();
				libr.setId(id);
				librService.delete(libr);
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
			List<Libr> list = librService.findList(new Libr());
			JSONArray array = new JSONArray();
			array.addAll(list);
			WriterUtil.write(response, array.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
