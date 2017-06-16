package com.dgit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.ImageVO;
import com.dgit.persistence.ImageDao;

@Service
public class ImageServiceImpl implements ImageService{
	@Autowired
	private ImageDao dao;

	@Override
	public List<ImageVO> selectImageByTqNo(int tq_no) throws Exception {
		return dao.selectImageByTqNo(tq_no);
	}

	@Override
	public void insertImage(ImageVO vo) throws Exception {
		dao.insertImage(vo);
	}

	@Override
	public void updateImage(int tq_no, String imgsource) throws Exception {
		dao.updateImage(tq_no, imgsource);
	}

	@Override
	public void deleteImage(int tq_no) throws Exception {
		dao.deleteImage(tq_no);
	}

}
