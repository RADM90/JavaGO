package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDAO {
	private BoardDAO() {}
	
	private static BoardDAO instance = new BoardDAO();

	public static BoardDAO getInstance() {
		return instance;
	}
	
	public Connection getConnection() {
		Connection con = null;
		String url = "jdbc:mysql://localhost:3306/jspdb5";
		String user = "jspid";
		String password = "jsppass";
		String driver = "com.mysql.jdbc.Driver";
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return con;
	}

	public ArrayList<BoardBean> getBoardList(String boardName, int startRow, int pageSize) {
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = getConnection();
		String sql = "select * from board where board_name=? order by idx desc limit ?,?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardName);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setBoardName(rs.getString("board_name"));
				bb.setIdx(rs.getInt("idx"));
				bb.setName(rs.getString("name"));
				bb.setPassword(rs.getString("password"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setFile(rs.getString("file"));
				bb.setDateTime(rs.getTimestamp("date_time"));
				bb.setReadCount(rs.getInt("read_count"));
				boardList.add(bb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs!=null) {try {rs.close();} catch (Exception e) {}}
			if (pstmt!=null) {try {pstmt.close();} catch (Exception e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return boardList;
	}
	
	public ArrayList<BoardBean> getBoardList(String boardName, int startRow, int pageSize, String option, String search) {
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = getConnection();
		String sql = "select * from board where board_name=? and "+option+" like ? order by idx desc limit ?,?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardName);
			pstmt.setString(2, "%"+search+"%");
			pstmt.setInt(3, startRow-1);
			pstmt.setInt(4, pageSize);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setBoardName(rs.getString("board_name"));
				bb.setIdx(rs.getInt("idx"));
				bb.setName(rs.getString("name"));
				bb.setPassword(rs.getString("password"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setFile(rs.getString("file"));
				bb.setDateTime(rs.getTimestamp("date_time"));
				bb.setReadCount(rs.getInt("read_count"));
				boardList.add(bb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs!=null) {try {rs.close();} catch (Exception e) {}}
			if (pstmt!=null) {try {pstmt.close();} catch (Exception e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return boardList;
	}
	
	public BoardBean getBoardContent(int idx) {
		BoardBean bb = new BoardBean();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			String sql = "select * from board where idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				bb.setIdx(rs.getInt("idx"));
				bb.setBoardName(rs.getString("board_name"));
				bb.setName(rs.getString("name"));
				bb.setPassword(rs.getString("password"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setFile(rs.getString("file"));
				bb.setDateTime(rs.getTimestamp("date_time"));
				bb.setReadCount(rs.getInt("read_count"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs!=null) {try {rs.close();} catch (Exception e) {}}
			if (pstmt!=null) {try {pstmt.close();} catch (Exception e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return bb;
	}
	
	public void updateReadCount(int idx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			String sql = "update board set read_count = read_count+1 where idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
	}
	
	public boolean insertContents(BoardBean bb) {
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
//		String sql = "insert into board(idx, board_name, name, password, subject, content, date_time, file, read_count) values(null, ?, ?, ?, ?, ?, ?, ?, 0)";
			String sql = "insert into board values(null, ?, ?, ?, ?, ?, ?, ?, 0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bb.getBoardName());
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPassword());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setTimestamp(6, bb.getDateTime());
			pstmt.setString(7, bb.getFile());
			pstmt.executeUpdate();
			result=true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		return result;
	}
	
	public boolean updateContents(BoardBean bb) {
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			String sql = "update board set board_name=?, name=?, subject=?, content=?, file=? where idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bb.getBoardName());
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getSubject());
			pstmt.setString(4, bb.getContent());
			pstmt.setString(5, bb.getFile());
			pstmt.setInt(6, bb.getIdx());
			pstmt.executeUpdate();
			result=true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		return result;
	}
	
	public boolean deleteContents(int idx) {
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			String sql = "delete from board where idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			result = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return result;
	}
	
	public boolean deleteFile(int idx) {
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConnection();
			String sql = "update board set file is null where idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			result=true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		return result;
	}
	
	public boolean contentPassCheck(int idx, String password) {
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			String sql = "select * from board where idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if (rs.getString("password").equals(password)) {
					result=true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs!=null) {try {rs.close();} catch (Exception e) {}}
			if (pstmt!=null) {try {pstmt.close();} catch (Exception e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		return result;
	}
	
	public int countBoard(String boardName) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			String sql = "select count(*) from board where board_name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardName);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		return count;
	}

	public int countBoard(String boardName, String option, String search) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			String sql = "select count(*) from board where board_name=? and "+option+" like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardName);
			pstmt.setString(2, "%"+search+"%");
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {try {rs.close();} catch (SQLException e) {}}
			if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
			if (con!=null) {try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		return count;
	}
	
}
