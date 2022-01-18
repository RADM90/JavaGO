package member;

import java.sql.Connection;
//import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class MemberDAO {
	private MemberDAO() {}
	
	private static MemberDAO instance = new MemberDAO();

	public static MemberDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() throws Exception {
//		Connection con = null;
//		String url = "jdbc:mysql://localhost:3306/jspdb5";
//		String user = "jspid";
//		String password = "jsppass";
//		String driver = "com.mysql.jdbc.Driver";
//		
//		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, user, password);
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
//		}
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		
		return con;
	}

	public ArrayList<MemberBean> getMemberList(String grade) {
		ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		
		try {
			con = getConnection();
			if (grade.equals("admin")) {
				sql = "select * from member order by id";
			} else if (grade.equals("instructor")) {
				sql = "select * from member where grade in('instructor', 'student') order by id";
			}
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MemberBean mb = new MemberBean();
				mb.setGrade(rs.getString("grade"));
				mb.setId(rs.getString("id"));
				mb.setPassword(rs.getString("password"));
				mb.setName(rs.getString("name"));
				mb.setContact(rs.getString("contact"));
				mb.setJoinDate(rs.getTimestamp("join_date"));
				mb.setEmail(rs.getString("email"));
				try {
					String[] add = rs.getString("address").split("__");
					mb.setPostalCode(add[0]);
					mb.setAddress(add[1]);
					mb.setDetailAddress(add[2]);
				} catch (Exception e) {}
				memberList.add(mb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs!=null) {try {rs.close();} catch (SQLException e) {}}
			if (pstmt!=null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return memberList;
	}
	
	public ArrayList<MemberBean> getMemberList(int startRow, int listSize) {
		ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			String sql = "select * from member order by id limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listSize);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MemberBean mb = new MemberBean();
				mb.setGrade(rs.getString("grade"));
				mb.setId(rs.getString("id"));
				mb.setPassword(rs.getString("password"));
				mb.setName(rs.getString("name"));
				mb.setContact(rs.getString("contact"));
				mb.setJoinDate(rs.getTimestamp("join_date"));
				try {
					String[] add = rs.getString("address").split("__");
					mb.setPostalCode(add[0]);
					mb.setAddress(add[1]);
					mb.setDetailAddress(add[2]);
				} catch (Exception e) {}
				memberList.add(mb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs!=null) {try {rs.close();} catch (SQLException e) {}}
			if (pstmt!=null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return memberList;
	}
	
	public MemberBean getMemberInfo(String id) {
		MemberBean mb = new MemberBean();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				mb.setGrade(rs.getString("grade"));
				mb.setId(rs.getString("id"));
				mb.setPassword(rs.getString("password"));
				mb.setName(rs.getString("name"));
				mb.setContact(rs.getString("contact"));
				mb.setJoinDate(rs.getTimestamp("join_date"));
				mb.setEmail(rs.getString("email"));
				try {
					String[] add = rs.getString("address").split("__");
					mb.setPostalCode(add[0]);
					mb.setAddress(add[1]);
					mb.setDetailAddress(add[2]);
				} catch (Exception e) {}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs!=null) {try {rs.close();} catch (SQLException e) {}}
			if (pstmt!=null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {}}
		}
		
		return mb;
	}
	
	public boolean insertMember(MemberBean mb) {
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			String sql = "insert into member(grade, id, password, name, email, address, contact, join_date) values(?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "student");
			pstmt.setString(2, mb.getId());
			pstmt.setString(3, mb.getPassword());
			pstmt.setString(4, mb.getName());
			pstmt.setString(5, mb.getEmail());
			pstmt.setString(6, mb.getPostalCode()+"__"+mb.getAddress()+"__"+mb.getDetailAddress());
			pstmt.setString(7, mb.getContact());
			pstmt.setTimestamp(8, mb.getJoinDate());
			pstmt.executeUpdate();
			result = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt!=null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {}}
		}
		return result;
	}
	
	public boolean updateMember(MemberBean mb, String oldPassword, String newPassword) {
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			if (oldPassword.equals(getInstance().getMemberInfo(mb.getId()).getPassword())) {
				con = getConnection();
				String sql = "update member set grade=?, password=?, email=?, address=?, contact=? where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mb.getGrade());
				pstmt.setString(2, newPassword);
				pstmt.setString(3, mb.getEmail());
				pstmt.setString(4, mb.getPostalCode()+"__"+mb.getAddress()+"__"+mb.getDetailAddress());
				pstmt.setString(5, mb.getContact());
				pstmt.setString(6, mb.getId());
				int checker = pstmt.executeUpdate();
				if (checker==1) {result = true;}
					
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
				if (pstmt!=null) {try {pstmt.close();} catch (SQLException e) {}}
				if (con!=null) {try {con.close();} catch (SQLException e) {}}
		}
		return result;
	}
	
	public boolean deleteMember(String id, String pass) {
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		if (pass.equals(getInstance().getMemberInfo(id).getPassword())) {
			try {
				con = getConnection();
				String sql = "delete from member where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (NamingException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (pstmt!=null) {try {pstmt.close();} catch (SQLException e) {}}
				if (con!=null) {try {con.close();} catch (SQLException e) {}}
			}
			result = true;
		}
		return result;
		}
	
	public boolean gradeUpdate(MemberBean mb, String grade) {
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			String sql = "update member set grade=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, grade);
			pstmt.setString(2, mb.getId());
			pstmt.executeUpdate();
			result = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt!=null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {}}
		}
		return result;
	}
	
	public boolean duplicateCheck(String id) {
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			String sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs!=null) {try {rs.close();} catch (SQLException e) {}}
			if (pstmt!=null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {}}
		}
		return result;
	}
	
	public int memberCheck(String id, String password) {
		int result = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			String sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if (rs.getString("password").equals(password)) {
					result = 1;
				} else {
					result = -1;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs!=null) {try {rs.close();} catch (SQLException e) {}}
			if (pstmt!=null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {}}
		}
		return result;
	}
}
