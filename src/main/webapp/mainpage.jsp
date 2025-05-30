<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, bean.BoardDBBean, bean.BranchBean, bean.CustomerBean" %>
<%
    // DAO 객체 얻기
    BoardDBBean dao = BoardDBBean.getInstance();

    // 영업점 리스트 조회
    List<BranchBean> branchList = dao.getBranchList();
%>

<%
	request.setCharacterEncoding("utf-8");
	// select 태그를 통해 받은 데이터 저장
	String branchId = request.getParameter("branchId");
	
	List<CustomerBean> customerList = new ArrayList<>(); // ← 먼저 선언
	if (branchId != null && !branchId.isEmpty()) {
		customerList = dao.getCustomersByBranch(Integer.parseInt(branchId));
	} 
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<h2>영업점별 고객정보</h2>
	<header class="branch">
		<div class="dropdown_div">
			<div><strong>> 영업점</strong></div>
			<form action="mainpage.jsp" method="get">
				<select name="branchId">
					<% for (BranchBean branch : branchList) { 
						String currentBranchId = Integer.toString(branch.getBranchId());
						boolean isSelected = currentBranchId.equals(branchId);
					%>
						
			            <option value="<%= branch.getBranchId() %>" <%= isSelected ? "selected" : ""%>>
			                <%= branch.getBranchName() %>
			            </option>
			        <% } %>
				</select>
				<button type="submit">조회</button>
			</frm>
			
		</div>
		
	</header>
	
	<main class="main">
		<table>
			<thead>
				<tr>
					<th>고객번호</th>
					<th>성명</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>주소</th>
					<th>상세주소</th>
					<th>등록일자</th>
				</tr>
			</thead>
			<tbody>
			<% for (CustomerBean customer : customerList) { %>
				<tr class="table_row">
					<td><%= customer.getCustomerId() %></td>
					<td><%= customer.getName() %></td>
					<td><%= customer.getPhone() %></td>
					<td><%= customer.getEmail() %></td>
					<td><%= customer.getAddress() %></td>
					<td><%= customer.getAddressDetail() %></td>
					<td><%= customer.getRegisteredDate() %></td>
				</tr>
			<% } %>
			</tbody>
		</table>
	</main>
	                                               
	<footer>
		<div class="detail_div">
			<div><strong>고객상세정보</strong></div>
			<div>
				<button>추가</button>
				<button>수정</button>
				<button>삭제</button>
			</div>
		</div>
		<div class="detail_table">
			<table>
				<tr>
					<td class="table_label">지점번호</td>
					<td class="table_value"><input type="text" value="<%= branchId == null ? 1 : branchId %>" readonly></td>
					<td class="table_label">성명</td>
					<td class="table_value"><input type="text"></td>
					<td class="table_label">전화번호</td>
					<td class="table_value"><input type="text"></td>
				</tr>
				<tr>
					<td class="table_label">주소</td>
					<td class="table_value"><input type="text"></td>
					<td class="table_label">상세주소</td>
					<td class="table_value" colspan="3"><input type="text"></td>
				</tr>
			</table>
		</div>
	</footer>
</body>
</html>