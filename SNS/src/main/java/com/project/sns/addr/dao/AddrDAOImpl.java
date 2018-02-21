package com.project.sns.addr.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.sns.addr.vo.AddrVO;
import com.project.sns.board.vo.BoardVO;

@Repository
public class AddrDAOImpl implements AddrDAO {
	@Autowired
	private SqlSession sqlSession;

	private static final String namespace = "com.project.sns.mapper.addrMapper";

	@Override
	public int inputAddr(List<AddrVO> vo) {
		return sqlSession.insert(namespace + ".inputAddr", vo);
	}

	@Override
	public int inputAddrCat(List<AddrVO> vo) {
		return sqlSession.insert(namespace + ".inputAddrCat", vo);
	}

	@Override
	public List<AddrVO> getAddress() throws Exception {
		return sqlSession.selectList(namespace + ".getAddress");
	}

	@Override
	public List<AddrVO> getAddrByWeather(String sigungucode, String inside) throws Exception {
		HashMap params = new HashMap();
		params.put("sigungucode", sigungucode);
		params.put("inside", inside);
		return sqlSession.selectList(namespace + ".getAddrByWeather", params);
	}

	@Override
	public List<AddrVO> getAddrWithCode(String sigungucode) throws Exception {
		return sqlSession.selectList(namespace + ".getAddrWithCode", sigungucode);
	}

	@Override
	public List<BoardVO> getHeart() throws Exception {
		return sqlSession.selectList(namespace + ".getHeart");
	}

	@Override
	public void insertPath(BoardVO vo) {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace + ".insertPath", vo);
	}

	@Override
	public int getCount(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".getCount", id);
	}
}
