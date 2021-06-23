package kr.ac.kopo.kopo08.dto;

import kr.ac.kopo.kopo08.domain.Resv;

public class GatherResv {
	private String date;
	Resv room1;
	Resv room2;
	Resv room3;

	public Resv getRoom1() {
		return room1;
	}

	public void setRoom1(Resv room1) {
		this.room1 = room1;
	}

	public Resv getRoom2() {
		return room2;
	}

	public void setRoom2(Resv room2) {
		this.room2 = room2;
	}

	public Resv getRoom3() {
		return room3;
	}

	public void setRoom3(Resv room3) {
		this.room3 = room3;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

}
