package kr.ac.kopo.kopo08.service;

import java.util.List;

import kr.ac.kopo.kopo08.domain.Resv;
import kr.ac.kopo.kopo08.dto.GatherResv;

public interface ResvService {
	void create(Resv resv);
	List<Resv> selectAll();
	Resv selectOne(String date, int room);
	Resv selectOne(String date, String name, String tel);
	void update(Resv resv);
	void delete(Resv resv);
	List<GatherResv> monthReservation(String selectMonth);
	String currentMonth();
}
