package com.kopo.my;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.kopo.service.BoardService;

//@RestController // restó���� �Ǵµ� �Ϲ������� �ε��� �ȵȴ�.
@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardService service;
	
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
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, 
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
