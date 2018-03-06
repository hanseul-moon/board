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

@Controller
@RequestMapping("/board/*")
public class MobileController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardService service;
	
	@RequestMapping(value="/listMobile", method=RequestMethod.GET)
	public void listMobile(@ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		
		model.addAttribute("list", service.listCriteria(cri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.countPaging(cri));
		
		model.addAttribute("pageMaker",pageMaker);
		
		logger.info("start listMobile method!");
	}
	
	@RequestMapping(value="/registerMobile", method=RequestMethod.GET)
	public void registerGET(BoardVO board,
							@ModelAttribute("cri") Criteria cri,
							Model model) throws Exception{
		
		logger.info("regist get ok");
		model.addAttribute("page", cri.getPage());				// jsp로 값 전달
		model.addAttribute("perPageNum", cri.getPerPageNum());	// jsp로 값 전달
	}
	
	@RequestMapping(value="/registerMobile", method=RequestMethod.POST)
	public String registerPOST(BoardVO board, 
							   @ModelAttribute("cri") Criteria cri,
							   RedirectAttributes rttr) throws Exception{
		
		logger.info("regist post ok");
		
		service.regist(board);
		rttr.addFlashAttribute("msg", "SUCCESS");		
		
		return "redirect:/board/listMobile";
	}
	
	// 게시물 상세 조회 화면
	@RequestMapping(value = "/readMobile", method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, 
					 @ModelAttribute("cri") Criteria cri,
					Model model) throws Exception {
	
		model.addAttribute("boardVO", service.read(bno));
	}
	
	@RequestMapping(value = "/modifyMobile", method = RequestMethod.GET)
	public void modifyGET(@RequestParam("bno") int bno,
						  @ModelAttribute("cri") Criteria cri,	// jsp로 객체 값 전달
					      Model model) throws Exception{
		
		model.addAttribute("page", cri.getPage());				// jsp로 값 전달
		model.addAttribute("perPageNum", cri.getPerPageNum());	// jsp로 값 전달
		model.addAttribute("boardVO", service.read(bno));
	}
	
	// 게시물 수정 동작
	@RequestMapping(value = "/modifyMobile", method = RequestMethod.POST)
	public String modifyPOST(BoardVO board, 
			 @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) throws Exception{
		
		logger.info("mod post start");
		
		service.modify(board);
		
		rttr.addAttribute("page", cri.getPage());				// jsp로 값 전달
		rttr.addAttribute("perPageNum", cri.getPerPageNum());	// jsp로 값 전달
		rttr.addFlashAttribute("msg", "MODIFY SUCCESS");
		return "redirect: /board/listMobile";
	}
}
