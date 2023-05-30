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
import dingzhen.entity.info.Question;
import dingzhen.entity.info.Question;
import dingzhen.entity.sys.User;
import dingzhen.service.info.QuestionService;

@Controller
@RequestMapping("question")
public class QuestionController extends BaseController<Question>{

private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	@Autowired
	private QuestionService questionService;

	@RequestMapping("index")
	public String index(){
		return "info/questionIndex";
	}
	
	
	@RequestMapping("myindex")
	public String myindex(HttpServletRequest request){
		User user = (User) request.getSession().getAttribute("currentUser");
		request.setAttribute("currentUser", user);
		return "info/questionMyindex";
	}
	
	@RequestMapping("toAdd")
	public String toAdd(){
		return "info/questionAdd";
	}
	
	@RequestMapping("toUpdate")
	public String toUpdate(HttpServletRequest request){
		try {
			String id = request.getParameter("id");
			Question question = new Question();
			question.setId(id);
			question = questionService.findOne(question);
			request.setAttribute("question", question);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "info/questionUpdate";
	}
	
	
	@RequestMapping("toAnswer")
	public String toAnswer(HttpServletRequest request){
		try {
			String id = request.getParameter("id");
			Question question = new Question();
			question.setId(id);
			question = questionService.findOne(question);
			request.setAttribute("question", question);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "info/questionAnswer";
	}
	
	@RequestMapping("findOne")
	public String findOne(HttpServletRequest request){
		try {
			String id = request.getParameter("id");
			Question question = new Question();
			question.setId(id);
			question = questionService.findOne(question);
			request.setAttribute("question", question);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "info/questionView";
	}
	
	
	
	
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response){
		try {
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			Question question = new Question();
			question.setPage((page-1)*rows);
			question.setRows(rows);
			String userid = request.getParameter("userid");
			if(StringUtil.isNotEmpty(userid)){
				User user = new User();
				user.setId(userid);;
				question.setAskuser(user);
			}
			question.setTitle(request.getParameter("title"));
			List<Question> list = questionService.findList(question);
			int total = questionService.count(question);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			o.put("total", total);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	@RequestMapping("reserveQuestion")
	public void reserveQuestion(HttpServletRequest request,HttpServletResponse response,Question question){
		String id = request.getParameter("id");
		JSONObject o = new JSONObject();
		try {
			if(StringUtil.isEmpty(id)){
				question.setId(get32UUID());
				User user = (User) request.getSession().getAttribute("currentUser");
				question.setAskuser(user);
				question.setAsktime(sdf.format(new Date()));
				questionService.add(question);
			} else {
				question.setId(id);
				questionService.update(question);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg","保存失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	
	
	
	@RequestMapping("deleteQuestion")
	public void deleteQuestion(HttpServletRequest request,HttpServletResponse response){
		JSONObject o = new JSONObject();
		try {
			String ids[] = request.getParameter("ids").split(",");
			for(String id : ids){
				Question question = new Question();
				question.setId(id);
				questionService.delete(question);
			}
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg", "删除失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
	
	@RequestMapping("updateAnswer")
	public void updateAnswer(HttpServletRequest request,HttpServletResponse response,Question question){
		String id = request.getParameter("id");
		JSONObject o = new JSONObject();
		try {
			question.setId(id);
			User user = (User) request.getSession().getAttribute("currentUser");
			question.setAnsweruser(user);
			question.setAnswertime(sdf.format(new Date()));
			questionService.updateAnswer(question);
			o.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			o.put("errorMsg","保存失败");
		}
		WriterUtil.write(response, o.toString());
	}
	
	
}
