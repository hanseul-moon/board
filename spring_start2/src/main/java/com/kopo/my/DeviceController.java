package com.kopo.my;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kopo.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class DeviceController {
	
	@Inject
	private BoardService service;
	
	// �Խ��� ����Ʈ ��ȸ ����̽� üũ
	@RequestMapping(value = "/list")
	public String ListDevice( HttpServletRequest request) {       
		
		Device device = DeviceUtils.getCurrentDevice(request);        

		String goList = "";
		if (device.isMobile()) {
			goList = "/board/listMobile";
		    
		} else {
			goList = "/board/listPage";
		}
				
		return "redirect: "+ goList;
    }
	
	// �Խù� ��� ����̽� üũ
	@RequestMapping(value = "/write")
	public String RegisterDevice( HttpServletRequest request) {       
		
		Device device = DeviceUtils.getCurrentDevice(request);        

		String goList = "";
		if (device.isMobile()) {
			goList = "/board/registerMobile";
		    
		} else {
			goList = "/board/register";
		}
				
		return "redirect: "+ goList;
    }
	
	// �Խù� ����ȸ ����̽� üũ
	@RequestMapping(value = "/post")
	public String ReadDevice( HttpServletRequest request) {       
		
		Device device = DeviceUtils.getCurrentDevice(request);        

		String goList = "";
		if (device.isMobile()) {
			goList = "/board/readMobile";
		    
		} else {
			goList = "/board/read";
		}
				
		return "redirect: "+ goList;
    }
	
	// �Խù� ���� ����̽� üũ
	@RequestMapping(value = "/change")
	public String ModifyDevice( HttpServletRequest request) {       
		
		Device device = DeviceUtils.getCurrentDevice(request);        

		String goList = "";
		if (device.isMobile()) {
			goList = "/board/modifyMobile";
		    
		} else {
			goList = "/board/modify";
		}
				
		return "redirect: "+ goList;
    }
}
