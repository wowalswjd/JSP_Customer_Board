<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, bean.BoardDBBean, bean.BranchBean, bean.CustomerBean"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.io.*" %>

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

List<CustomerBean> customerList = new ArrayList<>();
if (branchId != null && !branchId.isEmpty()) {
	customerList = dao.getCustomersByBranch(Integer.parseInt(branchId));
}
%>

<%
	// POST 요청일 경우 JSON 받기
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;

        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        try {
            JSONParser parser = new JSONParser();
            JSONObject json = (JSONObject) parser.parse(sb.toString());

            String action = (String) json.get("action");

            if ("update".equals(action)) {
                int customerId = Integer.parseInt((String) json.get("customerId"));
                String name = (String) json.get("name");
                String phone = (String) json.get("phone");
                String email = (String) json.get("email");
                String address = (String) json.get("address");
                String addressDetail = (String) json.get("address_detail");

                dao.updateCustomerInfo(customerId, name, phone, email, address, addressDetail);

                // script.js (update 버튼 클릭 이벤트)에 결과 return해주기
                response.setContentType("application/json");
                out.print("{\"message\":\"success\"}");
                return;  // 더 이상 JSP 렌더링하지 않음
            } else if ("delete".equals(action)) {
            	int customerId = Integer.parseInt((String) json.get("customerId"));
            	
            	dao.deleteCustomerInfo(customerId);
            	
            	// script.js (delete 버튼 클릭 이벤트)에 결과 return해주기
                response.setContentType("application/json");
                out.print("{\"message\":\"success\"}");
                return; 
            	
            } else if ("insert".equals(action)) {
            	
                String name = (String) json.get("name");
                String phone = (String) json.get("phone");
                String email = (String) json.get("email");
                String address = (String) json.get("address");
                String addressDetail = (String) json.get("address_detail");
               
                
                String currentBranchId = (String) json.get("branch_id");
                
                dao.insertCustomerInfo(name, phone, email, address, addressDetail, Integer.parseInt(currentBranchId));
                
             // script.js (insert 버튼 클릭 이벤트)에 결과 return해주기
                response.setContentType("application/json");
                out.print("{\"message\":\"success\"}");
                return; 
            }

        } catch (ParseException e) {
            e.printStackTrace();
            response.setContentType("application/json");
            out.print("{\"message\":\"JSON 파싱 오류\"}");
            return;
        }
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
		<form action="mainpage.jsp" method="get">
			<div class="dropdown_div">
				<div>
					<strong>> 영업점</strong>
				</div>
				<select name="branchId">
					<%
					for (BranchBean branch : branchList) {
						String currentBranchId = Integer.toString(branch.getBranchId());
						boolean isSelected = currentBranchId.equals(branchId);
					%>

					<option value="<%=branch.getBranchId()%>"
						<%=isSelected ? "selected" : ""%>>
						<%=branch.getBranchName()%>
					</option>
					<%
					}
					%>
				</select>
				<button type="submit">조회</button>


			</div>
		</form>
	</header>

	<main class="main">
		<table id="main_table">
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
				<%
				for (CustomerBean customer : customerList) {
				%>
				<tr class="table_row" data-id="<%=customer.getCustomerId()%>"
					data-name="<%=customer.getName()%>"
					data-phone="<%=customer.getPhone()%>"
					data-email="<%=customer.getEmail()%>"
					data-address="<%=customer.getAddress()%>"
					data-address-detail="<%=customer.getAddressDetail()%>">
					<td><%=customer.getCustomerId()%></td>
					<td><%=customer.getName()%></td>
					<td><%=customer.getPhone()%></td>
					<td><%=customer.getEmail()%></td>
					<td><%=customer.getAddress()%></td>
					<td><%=customer.getAddressDetail()%></td>
					<td><%=customer.getRegisteredDate()%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</main>

	<footer>
		<div class="detail_div">
			<div>
				<strong>고객상세정보</strong>
			</div>
			<div>
				<button type="button" id="insertBtn">추가</button>
				<button type="button" id="updateBtn">수정</button>
				<button type="button" id="deleteBtn">삭제</button>
			</div>
		</div>
		<div class="detail_table">
			<input type="hidden" name="customerId" id="customerId">
			<table>
				<tr>
					<td class="table_label">성명</td>
					<td class="table_value"><input type="text" name="name"
						id="name"></td>
					<td class="table_label">전화번호</td>
					<td class="table_value"><input type="text" name="phone"
						id="phone"></td>
					<td class="table_label">이메일</td>
					<td class="table_value"><input type="text" name="email"
						id="email"></td>
				</tr>
				<tr>
					<td class="table_label">주소</td>
					<td class="table_value"><input type="text" name="address"
						id="address"></td>
					<td class="table_label">상세주소</td>
					<td class="table_value" colspan="3"><input type="text"
						name="address_detail" id="addressDetail"></td>
				</tr>
			</table>
		</div>
	</footer>
	<script src="script.js"></script>
</body>
</html>