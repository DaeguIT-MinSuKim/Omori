package com.dgit.persistence;

import java.util.List;

import com.dgit.domain.ImageVO;

public interface ImageDao {
	List<ImageVO> selectImageByTqNo(int tq_no) throws Exception;
	void insertImage(ImageVO vo) throws Exception;
	void updateImage(int tq_no, String imgsource) throws Exception;
	void deleteImage(int tq_no)throws Exception;
}
