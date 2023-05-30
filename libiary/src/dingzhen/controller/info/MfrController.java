package dingzhen.controller.info;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.sun.org.apache.bcel.internal.generic.NEW;

import dingzhen.common.base.BaseController;
import dingzhen.common.util.StringUtil;
import dingzhen.common.util.WriterUtil;
import dingzhen.entity.info.Libr;
import dingzhen.entity.info.Mfr;
import dingzhen.entity.info.Repair;
import dingzhen.entity.info.Stock;
import dingzhen.entity.info.Type;
import dingzhen.service.info.MfrService;
import dingzhen.service.info.RepairService;
import dingzhen.service.info.StockService;

@Controller
@RequestMapping("mfr")
public class MfrController extends BaseController<Mfr> {

	@Autowired
	private MfrService mfrService;
	@Autowired
	private StockService stockService;
	@Autowired
	private RepairService repairService;
	
	
	@RequestMapping("index")
	public String index(){
		return "info/mfr";
	}
	
	
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response){
		try {
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			Mfr mfr = new Mfr();
			mfr.setPage((page-1)*rows);
			mfr.setRows(rows);
			String typeid = request.getParameter("typeid");
			if(StringUtil.isNotEmpty(typeid)){
				Type type = new Type();
				type.setId(typeid);
				mfr.setType(type);
			}
			String librid = request.getParameter("librid");
			if(StringUtil.isNotEmpty(librid)){
				Libr libr = new Libr();
				libr.setId(librid);
				mfr.setLibr(libr);
			}
			mfr.setKeyword(request.getParameter("keyword"));
			List<Mfr> list = mfrService.findList(mfr);
			int total = mfrService.count(mfr);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			o.put("total", total);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	@RequestMapping("reserveMfr")
	public void reserveMfr(HttpServletRequest request,HttpServletResponse response,Mfr mfr){
		String id = request.getParameter("id");
		JSONObject o = new JSONObject();
		try {
			if(StringUtil.isEmpty(id)){
				mfr.setId(get32UUID());
				mfrService.add(mfr);
			} else {
				mfr.setId(id);
				mfrService.update(mfr);
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
				Mfr mfr = new Mfr();
				mfr.setId(id);
				mfrService.delete(mfr);
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
			Mfr mfr = new Mfr();
			mfr.setPage((page-1)*rows);
			mfr.setRows(rows);
			String typeid = request.getParameter("typeid");
			if(StringUtil.isNotEmpty(typeid)){
				Type type = new Type();
				type.setId(typeid);
				mfr.setType(type);
			}
			String librid = request.getParameter("librid");
			if(StringUtil.isNotEmpty(librid)){
				Libr libr = new Libr();
				libr.setId(librid);
				mfr.setLibr(libr);
			}
			List<Mfr> list = mfrService.findList(mfr);
			JSONArray array = new JSONArray();
			array.addAll(list);
			WriterUtil.write(response, array.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@RequestMapping("addStock")
	public void addStock(HttpServletRequest request,HttpServletResponse response,Stock stock){
		String mfrid = request.getParameter("mfrid");
		String io = request.getParameter("t");  // in/out
		stock.setId(get32UUID());
		stock.setTime(sdf.format(new Date()));
		JSONObject o = new JSONObject();
		try {
			Mfr mfr = new Mfr();
			mfr.setId(mfrid);
			mfr = mfrService.findOne(mfr);
			stock.setMfr(mfr);
			int lastnum = mfr.getNum();    // 原始库存
			if("in".equals(io)){  // 入库
				int totalnum = lastnum + stock.getThisnum();
				stock.setTotalnum(totalnum);
				stockService.add(stock); 
				
				mfr.setNum(totalnum); // 更新库存
				mfrService.updateNum(mfr); 
				o.put("success", true);
			} else {  // 出库
				int totalnum = lastnum - stock.getThisnum();
				if(totalnum < 0){
					o.put("errorMsg", "库存不够");
				} else {
					stock.setTotalnum(totalnum);
					stockService.add(stock); 
					
					mfr.setNum(totalnum); // 更新库存
					mfrService.updateNum(mfr);
					o.put("success", true);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg","保存失败");
		}
		WriterUtil.write(response, o.toString());
	}
	

	
	
	
	@RequestMapping("toRepairAdd")
	public String toAdd(HttpServletRequest request){
		String mfrid = request.getParameter("mfrid");
		request.setAttribute("mfrid",mfrid);
		return "info/repairAdd";
	}
	
	
	

	@RequestMapping("addRepair")
	public void addRepair(HttpServletRequest request,HttpServletResponse response,Repair repair){
		JSONObject o = new JSONObject();
		try {
			repair.setId(get32UUID());
			repair.setTime(sdf.format(new Date()));
			repairService.add(repair);
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg","保存失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	
}
