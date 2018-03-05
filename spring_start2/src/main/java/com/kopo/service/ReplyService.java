package com.kopo.service;

import java.util.List;

import com.kopo.domain.Criteria;
import com.kopo.domain.ReplyVO;

public interface ReplyService {

	public void addReply(ReplyVO vo) throws Exception;
	
	public List<ReplyVO> listReply(Integer bno) throws Exception;
	
	public void modifyReply(ReplyVO vo) throws Exception;
	
	public void removeReply(Integer rno) throws Exception;
	
	public List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception;

	public int count(Integer bno) throws Exception;
}
