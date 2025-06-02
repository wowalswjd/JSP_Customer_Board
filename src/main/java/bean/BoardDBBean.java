package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDBBean {

	private static BoardDBBean instance = new BoardDBBean();

	// .jsp페이지에서 DB연동빈인 BoardDBBean클래스의 메소드에 접근시 필요
	public static BoardDBBean getInstance() {
		return instance;
	}

	private BoardDBBean() {
	}

	// 커넥션풀로부터 Connection객체를 얻어냄
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/boarddb");
		return ds.getConnection();
	}

	// 영업점이름 조회하는 메서드
	public List<BranchBean> getBranchList() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<BranchBean> branchList = new ArrayList<>();

		try {

			// branch 테이블에서 branch_name select 한 다음에 list 형태로 내려받기
			// branch_name으로 구성된 list return
			// DB 연결
			conn = getConnection();

			// SQL 작성 및 실행
			String sql = "SELECT branch_id, branch_name FROM branch";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			// 결과를 리스트에 담기
			while (rs.next()) {
				BranchBean branch = new BranchBean();
				branch.setBranchId(rs.getInt("branch_id"));
				branch.setBranchName(rs.getString("branch_name"));
				branchList.add(branch);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return branchList;
	}

	// 영업점에 따른 고객 리스트 조회
	public List<CustomerBean> getCustomersByBranch(int branchId) throws Exception {
		// connection, SQL: SELECT * FROM customer WHERE branch_id = ?
		// rs.next() 돌면서 CustomerBean 채워서 List로 반환
		// return타입 List<CustomerBean>로 고치기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<CustomerBean> customerList = new ArrayList<>();

		try {
			// DB 연결
			conn = getConnection();

			// SQL 작성 및 실행
			String sql = "SELECT * FROM customer WHERE branch_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, branchId);
			rs = pstmt.executeQuery();

			// 결과를 리스트에 담기
			while (rs.next()) {
				CustomerBean customer = new CustomerBean();
				customer.setCustomerId(rs.getInt("customer_id"));
				customer.setName(rs.getString("name"));
				customer.setPhone(rs.getString("phone"));
				customer.setEmail(rs.getString("email"));
				customer.setAddress(rs.getString("address"));
				customer.setAddressDetail(rs.getString("address_detail")); // 컬럼명이 정확히 이 이름이어야 해
				customer.setRegisteredDate(rs.getTimestamp("registered_date"));
				customer.setRegisterId(rs.getString("register_id"));
				customer.setUpdatedDate(rs.getTimestamp("updated_date"));
				customer.setUpdaterId(rs.getString("updater_id"));
				customer.setBranchId(rs.getInt("branch_id"));

				customerList.add(customer);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}

		return customerList;

	}

	// 고객 정보 update
	public void updateCustomerInfo(int customerId, String name, String phone, String email, String address,
			String addressDetail) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// DB 연결
			conn = getConnection();

			// SQL 작성 및 실행
			String sql = "UPDATE customer SET name = ?, phone = ?, email = ?, address = ?, address_detail = ?, updated_date=NOW() WHERE customer_id = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			pstmt.setString(3, email);
			pstmt.setString(4, address);
			pstmt.setString(5, addressDetail);
			pstmt.setInt(6, customerId);

			pstmt.executeUpdate(); // 실행
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}

	}

	// 고객 정보 insert
	public void insertCustomerInfo(String name, String phone, String email, String address, String addressDetail,
			int branchId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// DB 연결
			conn = getConnection();

			// SQL 작성 및 실행
			String sql = "INSERT INTO customer(name, phone, email, address, address_detail, registered_date, register_id, updated_date, updater_id, branch_id)\r\n"
					+ "VALUES(?, ?, ?, ?, ?, NOW(), \"insert\",  NOW(), \"insert\", ?);";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			pstmt.setString(3, email);
			pstmt.setString(4, address);
			pstmt.setString(5, addressDetail);
			pstmt.setInt(6, branchId);

			pstmt.executeUpdate(); // 실행
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}

	}
	
	// 고객 정보 delete
	public void deleteCustomerInfo(int customerId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// DB 연결
			conn = getConnection();

			// SQL 작성 및 실행
			String sql = "DELETE FROM customer WHERE customer_id = ?;";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, customerId);

			pstmt.executeUpdate(); // 실행
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	};

}
