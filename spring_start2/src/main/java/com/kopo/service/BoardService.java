package com.kopo.service;

import java.util.List;

import com.kopo.domain.BoardVO;

public interface BoardService {

	public void regist(BoardVO board)throws Exception;
	
	public void read(Integer bno)throws Exception;
	
	public void modify(BoardVO board) throws Exception;
	
	public void remove(Integer bno)throws Exception;
	
	public List<BoardVO> listAll() throws Exception;
}
