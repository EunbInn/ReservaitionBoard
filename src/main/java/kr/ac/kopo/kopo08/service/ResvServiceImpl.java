package kr.ac.kopo.kopo08.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import kr.ac.kopo.kopo08.dao.ResvDao;
import kr.ac.kopo.kopo08.dao.ResvDaoImpl;
import kr.ac.kopo.kopo08.domain.Resv;
import kr.ac.kopo.kopo08.dto.GatherResv;

public class ResvServiceImpl implements ResvService{
	private static ResvServiceImpl instance = new ResvServiceImpl(); 
	ResvDao resvDao = ResvDaoImpl.getInstance();

	private ResvServiceImpl() {
	}
	
	public static ResvServiceImpl getInstance() {
		return instance;
	}
	
	@Override
	public void create(Resv resv) {
		resvDao.create(resv);
	}

	@Override
	public List<Resv> selectAll() {
		List<Resv> resvList = resvDao.selectAll();
		return resvList;
	}

	@Override
	public Resv selectOne(String date, int room) {
		
		return resvDao.selectOne(date, room);
	}

	@Override
	public void update(Resv resv) {
		resvDao.update(resv);
	}

	@Override
	public void delete(Resv resv) {
		resvDao.delete(resv);
	}
	
	@Override
	public List<GatherResv> monthReservation (String selectMonth) {
		List<GatherResv> resvList = new ArrayList<GatherResv>();

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if (selectMonth != null && !sdf.format(cal.getTime()).contains(selectMonth)) {
			int year = Integer.parseInt(selectMonth.split("-")[0]);
			int month = Integer.parseInt(selectMonth.split("-")[1]);
			cal.set(year, (month - 1), 1); //첫날로 셋팅
		}
	
		int lastDayOfMonth = cal.getActualMaximum(5); // 5번이 month에 해당하는 필드번호
		for (int i = cal.get(cal.DATE); i <= lastDayOfMonth; i++) {
			String date = sdf.format(cal.getTime());
			
			GatherResv gResv = gatherResv(date);
			resvList.add(gResv);
			cal.add(cal.DAY_OF_MONTH, +1);
		}
		
		return resvList;
	}
	
	
	public GatherResv gatherResv(String date) {
		GatherResv gResv = new GatherResv();
		
		gResv.setDate(date);
		Resv resv1 = resvDao.selectOne(date, 1);
		Resv resv2 = resvDao.selectOne(date, 2);
		Resv resv3 = resvDao.selectOne(date, 3);
		if (resv1.getName() == null) {
			resv1.setName("예약가능");
		}
		if (resv2.getName() == null) {
			resv2.setName("예약가능");
		}
		if (resv3.getName() == null) {
			resv3.setName("예약가능");
		}
		gResv.setRoom1(resv1);
		gResv.setRoom2(resv2);
		gResv.setRoom3(resv3);
		
		return gResv;
	}
	
	@Override
	public String currentMonth() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		String currentMonth = "";
		
		currentMonth = sdf.format(cal.getTime());
	
		return currentMonth;
	}

	@Override
	public Resv selectOne(String date, String name, String tel) {
		return resvDao.selectOne(date, name, tel);
	}

}
