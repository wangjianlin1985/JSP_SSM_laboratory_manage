package dingzhen.controller.info;

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
import dingzhen.entity.info.Mfr;
import dingzhen.entity.info.Stock;
import dingzhen.service.info.StockService;

@RequestMapping("stock")
@Controller
public class StockController extends BaseController<Stock> {

	@Autowired
	private StockService stockService;
	
	@RequestMapping("stockIndex")
	public String stockIndex(){
		return "info/stock";
	}
	
	
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response){
		try {
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			Stock stock = new Stock();
			stock.setPage((page-1)*rows);
			stock.setRows(rows);
			String mfrid = request.getParameter("mfrid");
			if(StringUtil.isNotEmpty(mfrid)){
				Mfr mfr = new Mfr();
				mfr.setId(mfrid);
				stock.setMfr(mfr);
			}
			stock.setStart(request.getParameter("start"));
			stock.setEnd(request.getParameter("end"));
			stock.setName(request.getParameter("name"));
			stock.setType(request.getParameter("type"));
			List<Stock> list = stockService.findList(stock);
			int total = stockService.count(stock);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			o.put("total", total);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
}
