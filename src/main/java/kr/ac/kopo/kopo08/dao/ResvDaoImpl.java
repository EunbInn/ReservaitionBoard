package kr.ac.kopo.kopo08.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import kr.ac.kopo.kopo08.domain.Resv;

public class ResvDaoImpl implements ResvDao{
	private static ResvDaoImpl instance = new ResvDaoImpl();
	
	private ResvDaoImpl() {}

	public static ResvDaoImpl getInstance() {
		return instance;
	}
	
	@Override
	public void create(Resv resv) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			Statement stmt = con.createStatement();
			
			String query = String.format("insert into resv (name, resv_date, room, addr, tel, in_name, comment, write_date) "
								+ "values('%s', '%s', %d, '%s', '%s', '%s', '%s', now());"
								, resv.getName(), resv.getDate(), resv.getRoom(), resv.getAddr(), resv.getTel(), resv.getInName(),resv.getComment());
			stmt.execute(query);
			
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
			e.printStackTrace();
		} finally {}
	}

	@Override
	public List<Resv> selectAll() {
		List<Resv> retAll = new ArrayList<Resv>();
		Resv resv;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			Statement stmt = con.createStatement();
			
			//date 인자 받게되면 바꿔주기
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
			
			String query = String.format("select * from resv where resv_date like '%s%%';", sdf.format(cal.getTime()));
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				resv = new Resv();
				resv.setName(rs.getString(1));
				resv.setDate(rs.getString(2));
				resv.setRoom(rs.getInt(3));
				resv.setAddr(rs.getString(4));
				resv.setTel(rs.getString(5));
				resv.setInName(rs.getString(6));
				resv.setComment(rs.getString(7));
				resv.setWriteDate(rs.getString(8));
				resv.setProcess(rs.getInt(9));
				retAll.add(resv);
			}
			
			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
			e.printStackTrace();
		} finally {}
		
		return retAll;
	}

	@Override
	public Resv selectOne(String date,int room) {
		Resv resv = new Resv();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			Statement stmt = con.createStatement();
			ResultSet rs = null;
			
			String query = "select * from resv where resv_date='" + date +"' and room=" + room + ";";
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				resv.setName(rs.getString(1));
				resv.setDate(rs.getString(2));
				resv.setRoom(rs.getInt(3));
				resv.setAddr(rs.getString(4));
				resv.setTel(rs.getString(5));
				resv.setInName(rs.getString(6));
				resv.setComment(rs.getString(7).replaceAll("/r/n", "<br>")
								.replaceAll("<", "&lt;")
								.replaceAll(">", "&gt;"));
				resv.setWriteDate(rs.getString(8));
				resv.setProcess(rs.getInt(9));
			}
			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
		return resv;
	}

	@Override
	public void update(Resv resv) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			Statement stmt = con.createStatement();
			
			String query = String.format("update resv set Name='%s', Tel='%s', Comment='%s' where resv_date='%s' and room=%d;",
										resv.getName(), resv.getTel(), resv.getComment(), resv.getDate(), resv.getRoom());
			stmt.executeUpdate(query);
			
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
	}

	@Override
	public void delete(Resv resv) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			Statement stmt = con.createStatement();
			
			String query = String.format("delete from resv where resv_date='%s' and room=%d;", resv.getDate(), resv.getRoom());
			stmt.execute(query);
			
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
	}

	@Override
	public Resv selectOne(String date, String name, String tel) {
		Resv resv = new Resv();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			Statement stmt = con.createStatement();
			ResultSet rs = null;
			
			String query = "select * from resv where resv_date='" + date +"' and name='" + name + "' and tel='" + tel + "';";
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				resv.setName(rs.getString(1));
				resv.setDate(rs.getString(2));
				resv.setRoom(rs.getInt(3));
				resv.setAddr(rs.getString(4));
				resv.setTel(rs.getString(5));
				resv.setInName(rs.getString(6));
				resv.setComment(rs.getString(7).replaceAll("/r/n", "<br>")
								.replaceAll("<", "&lt;")
								.replaceAll(">", "&gt;"));
				resv.setWriteDate(rs.getString(8));
				resv.setProcess(rs.getInt(9));
			}
			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
		return resv;
	}

}
