package com.kopo.dao;

import java.util.List;

import com.kopo.domain.Criteria;
import com.kopo.domain.ReplyVO;

public interface ReplyDAO {

	public List<ReplyVO> list(Integer bno) throws Exception;
	
	public void create(ReplyVO vo) throws Exception;
	
	public void update(ReplyVO vo) throws Exception;
	
	public void delete(Integer rno) throws Exception;
	
	// ´ñ±Û ÆäÀÌÂ¡ °ü·Ã
	public List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception;
	
	public int count(Integer bno) throws Exception;
}
