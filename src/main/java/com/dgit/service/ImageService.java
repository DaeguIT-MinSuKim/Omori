package com.dgit.service;

import java.util.List;

import com.dgit.domain.ImageVO;

public interface ImageService {
	List<ImageVO> selectImageByTqNo(int tq_no) throws Exception;
	void insertImage(ImageVO vo) throws Exception;
}
