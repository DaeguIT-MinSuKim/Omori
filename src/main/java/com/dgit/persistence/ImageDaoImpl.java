package com.dgit.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public void updateImage(int tq_no, String imgsource) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("tq_no", tq_no);
		map.put("imgsource", imgsource);
		session.update(namespace + ".updateImage", map);
	}

	@Override
	public void deleteImage(int tq_no) throws Exception {
		session.delete(namespace+".deleteImage", tq_no);
	}

}
