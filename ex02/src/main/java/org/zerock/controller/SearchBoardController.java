package org.zerock.controller;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.PageMaker;
import org.zerock.domain.SearchCriteria;
import org.zerock.service.BoardService;

@Controller
@RequestMapping("/sboard/*")
public class SearchBoardController {

  private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);

  @Inject
  private BoardService service;

  private boolean ipCheck() {
	  
		  HttpServletRequest request = getRequest();
		  HttpServletResponse response = getResponse();
		  
		  String ip = request.getHeader("X-Forwarded-For");
		
		  logger.info(">>>> X-FORWARDED-FOR : " + ip);
		
		  if (ip == null) {
		      ip = request.getHeader("Proxy-Client-IP");
		      logger.info(">>>> Proxy-Client-IP : " + ip);
		  }
		  if (ip == null) {
		      ip = request.getHeader("WL-Proxy-Client-IP"); // 웹로직
		      logger.info(">>>> WL-Proxy-Client-IP : " + ip);
		  }
		  if (ip == null) {
		      ip = request.getHeader("HTTP_CLIENT_IP");
		      logger.info(">>>> HTTP_CLIENT_IP : " + ip);
		  }
		  if (ip == null) {
		      ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		      logger.info(">>>> HTTP_X_FORWARDED_FOR : " + ip);
		  }
		  if (ip == null) {
		      ip = request.getRemoteAddr();
		  }
		  
		  logger.info(">>>> Result : IP Address : "+ip);
		
		  //  쿠키 확인
		  Cookie[] getCookie = request.getCookies();
		  Cookie c = null;
		  boolean registCk = true;
		if(getCookie != null){
		
			for(int i=0; i<getCookie.length; i++){
				
				c = getCookie[i];						
				if((c.getName() == ip) && (Integer.parseInt(c.getValue()) >= 5)) {
					registCk = false;
				}
			}
		}else {
			Cookie setCookie = new Cookie(ip, "0"); // 쿠키 생성	
			setCookie.setMaxAge(60*60); 				// 기간을 1시간으로 지정
			response.addCookie(setCookie);
			registCk = true;
		}
      
      return registCk;
  }  
  
  public static HttpServletRequest getRequest() {
      ServletRequestAttributes attr = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
      return attr.getRequest();
  }

  public static HttpServletResponse getResponse() {
      ServletRequestAttributes attr = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
      return attr.getResponse();
  }

  
  @RequestMapping(value = "/list", method = RequestMethod.GET)
  public void listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

    logger.info(cri.toString());
    
    // model.addAttribute("list", service.listCriteria(cri));
    model.addAttribute("list", service.listSearchCriteria(cri));

    PageMaker pageMaker = new PageMaker();
    pageMaker.setCri(cri);

    // pageMaker.setTotalCount(service.listCountCriteria(cri));
    pageMaker.setTotalCount(service.listSearchCount(cri));

    model.addAttribute("pageMaker", pageMaker);
  }

  @RequestMapping(value = "/readPage", method = RequestMethod.GET)
  public void read(@RequestParam("bno") int bno, @ModelAttribute("cri") SearchCriteria cri, Model model)
      throws Exception {
	
	  service.updateView(bno);
    model.addAttribute(service.read(bno));
  }

  @RequestMapping(value = "/removePage", method = RequestMethod.POST)
  public String remove(@RequestParam("bno") int bno, SearchCriteria cri, RedirectAttributes rttr) throws Exception {

    service.remove(bno);

    rttr.addAttribute("page", cri.getPage());
    rttr.addAttribute("perPageNum", cri.getPerPageNum());
    rttr.addAttribute("searchType", cri.getSearchType());
    rttr.addAttribute("keyword", cri.getKeyword());

    rttr.addFlashAttribute("msg", "SUCCESS");

    return "redirect:/sboard/list";
  }

  @RequestMapping(value = "/modifyPage", method = RequestMethod.GET)
  public void modifyPagingGET(int bno, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

    model.addAttribute(service.read(bno));
  }

  @RequestMapping(value = "/modifyPage", method = RequestMethod.POST)
  public String modifyPagingPOST(BoardVO board, SearchCriteria cri, RedirectAttributes rttr) throws Exception {

    logger.info(cri.toString());
    service.modify(board);

    rttr.addAttribute("page", cri.getPage());
    rttr.addAttribute("perPageNum", cri.getPerPageNum());
    rttr.addAttribute("searchType", cri.getSearchType());
    rttr.addAttribute("keyword", cri.getKeyword());

    rttr.addFlashAttribute("msg", "SUCCESS");

    logger.info(rttr.toString());

    return "redirect:/sboard/list";
  }

  @RequestMapping(value = "/register", method = RequestMethod.GET)
  public void registGET() throws Exception {

	  boolean registCk = this.ipCheck();  
	  if(registCk == false) {
		  
	  }else {}
	  
	  logger.info("regist get ...........");
  }

  @RequestMapping(value = "/register", method = RequestMethod.POST)
  public String registPOST(BoardVO board, RedirectAttributes rttr) throws Exception {

    logger.info("regist post ...........");
    logger.info(board.toString());

    service.regist(board);

    rttr.addFlashAttribute("msg", "SUCCESS");

    return "redirect:/sboard/list";
  }

  // @RequestMapping(value = "/list", method = RequestMethod.GET)
  // public void listPage(@ModelAttribute("cri") SearchCriteria cri,
  // Model model) throws Exception {
  //
  // logger.info(cri.toString());
  //
  // model.addAttribute("list", service.listCriteria(cri));
  //
  // PageMaker pageMaker = new PageMaker();
  // pageMaker.setCri(cri);
  //
  // pageMaker.setTotalCount(service.listCountCriteria(cri));
  //
  // model.addAttribute("pageMaker", pageMaker);
  // }
}
