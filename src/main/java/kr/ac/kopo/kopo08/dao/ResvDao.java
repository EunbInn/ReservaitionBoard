package kr.ac.kopo.kopo08.dao;

import java.util.List;

import kr.ac.kopo.kopo08.domain.Resv;

public interface ResvDao {
	void create(Resv resv);
	List<Resv> selectAll();
	Resv selectOne(String date,int room);
	void update(Resv resv);
	void delete(Resv resv);
}
