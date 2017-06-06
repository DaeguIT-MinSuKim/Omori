package com.dgit.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.ImageVO;

@Repository
public class ImageDaoImpl implements ImageDao{
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.dgit.mapper.ImageMapper";

	@Override
	public List<ImageVO> selectImageByTqNo(int tq_no) throws Exception {
		return session.selectList(namespace+".selectImageByTqNo", tq_no);
	}

	@Override
	public void insertImage(ImageVO vo) throws Exception {
		session.insert(namespace+".insertImage", vo);
	}

}
