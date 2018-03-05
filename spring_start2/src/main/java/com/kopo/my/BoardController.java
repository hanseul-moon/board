package com.kopo.my;

import java.awt.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kopo.domain.BoardVO;
import com.kopo.domain.Criteria;
import com.kopo.domain.PageMaker;
import com.kopo.domain.ReplyVO;
import com.kopo.service.BoardService;
import com.kopo.service.ReplyService;

//@RestController // restó���� �Ǵµ� �Ϲ������� �ε��� �ȵȴ�.
@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardService service;
	
	@Inject
	ReplyService replyservice;

	@RequestMapping("/makeData")
	public void makeData(BoardVO board, ReplyVO vo) throws Exception{
		
		/*for(int i = 1; i < 245; i++) {
			board.setTitle("����" + i);
			board.setContent("����" + i);
			board.setWriter("�ۼ���" + i);
			service.regist(board);	
		}*/
		
		for(int i = 1; i < 140; i++) {
			vo.setBno(244);
			vo.setReplyer("����ۼ���" + i);
			vo.setReplytext("��۳���" +i);
			replyservice.addReply(vo);
		}
	}
	
	@RequestMapping("/restErrorList")
	public ResponseEntity restList() throws Exception{
		
		ArrayList<Criteria> criList = new ArrayList<Criteria>();
		for(int i = 0; i < 5; i++) {
			Criteria cri = new Criteria();
			cri.setPage(i);
			cri.setPerPageNum(i * 10);
			criList.add(cri);
		}
		return new ResponseEntity<>(criList, HttpStatus.NOT_FOUND);
	}
	
	@RequestMapping("/restMap")
	public Map restMap() throws Exception{
		
		Map<Integer, Criteria> criMap = new HashMap<Integer, Criteria>();
		for(int i = 0; i < 5; i++) {
			Criteria cri = new Criteria();
			cri.setPage(i);
			cri.setPerPageNum(i * 10);
			criMap.put(i, cri);
		}
		return criMap;
	}
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public void registerGET(BoardVO board, Model model) throws Exception{
		logger.info("regist get ok");
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registerPOST(BoardVO board, 
							   @ModelAttribute("cri") Criteria cri,
							   RedirectAttributes rttr) throws Exception{
		
		logger.info("regist post ok");
		logger.info(board.toString());
		
		service.regist(board);
		
		rttr.addAttribute("page", cri.getPage());				// jsp�� �� ����
		rttr.addAttribute("perPageNum", cri.getPerPageNum());	// jsp�� �� ����
		rttr.addFlashAttribute("msg", "SUCCESS");		
		
		return "redirect:/board/listPage";
	}
	
	@RequestMapping(value="/listPage", method=RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		
		model.addAttribute("list", service.listCriteria(cri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.countPaging(cri));
		
		model.addAttribute("pageMaker",pageMaker);
		
		logger.info("start listPage method!");
	}
	
	
	@RequestMapping(value="/listCri", method=RequestMethod.GET)
	public void listCri(Criteria cri, Model model) throws Exception{
		
		model.addAttribute("list", service.listCriteria(cri));
		logger.info("show all paging list!");
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, 
					 @ModelAttribute("cri") Criteria cri,
					Model model) throws Exception {
	
		model.addAttribute("boardVO", service.read(bno));
	}
	
	@RequestMapping(value = "/readPage", method = RequestMethod.GET)
	public void readPage(@RequestParam("bno") int bno, 
					 @ModelAttribute("cri") Criteria cri,
					Model model) throws Exception {
	
		model.addAttribute("boardVO", service.read(bno));
	}
	  
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, 
						 @ModelAttribute("cri") Criteria cri,
						 RedirectAttributes rttr) throws Exception{
		
		service.remove(bno);
		
		rttr.addAttribute("page", cri.getPage());				// jsp�� �� ����
		rttr.addAttribute("perPageNum", cri.getPerPageNum());	// jsp�� �� ����
		rttr.addFlashAttribute("msg", "REMOVE SUCCESS");		
		
		return "redirect: /board/listPage";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void modifyGET(@RequestParam("bno") int bno,
						  @ModelAttribute("cri") Criteria cri,	// jsp�� ��ü �� ����
					      Model model) throws Exception{
		
		model.addAttribute("page", cri.getPage());				// jsp�� �� ����
		model.addAttribute("perPageNum", cri.getPerPageNum());	// jsp�� �� ����
		model.addAttribute("boardVO", service.read(bno));
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyPOST(BoardVO board, 
			 @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) throws Exception{
		
		logger.info("mod post start");
		
		service.modify(board);
		
		rttr.addAttribute("page", cri.getPage());				// jsp�� �� ����
		rttr.addAttribute("perPageNum", cri.getPerPageNum());	// jsp�� �� ����
		rttr.addFlashAttribute("msg", "MODIFY SUCCESS");
		return "redirect: /board/listPage";
	}
}
