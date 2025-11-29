let isEditMode = false; // 편집 모드

/* 고객 목록 테이블 행 클릭 시 하단 테이블 input에 값을 띄우는 이벤트 */
document.addEventListener("DOMContentLoaded", function() {
	const rows = document.querySelectorAll(".table_row");

	console.log(rows);

	rows.forEach(row => {
		row.addEventListener("click", () => {
			document.getElementById("customerId").value = row.dataset.id;
			document.getElementById("name").value = row.dataset.name;
			document.getElementById("phone").value = row.dataset.phone;
			document.getElementById("email").value = row.dataset.email;
			document.getElementById("address").value = row.dataset.address;
			document.getElementById("addressDetail").value = row.dataset.addressDetail;
		});
	});
});

/* 하단 테이블 수정 버튼 클릭 시 mainpage.jsp로 fetch POST 요청*/
const updateBtn = document.getElementById("updateBtn");
updateBtn.addEventListener("click", async function() {
	console.log("updateBtn click!");
	const customerIdValue = document.getElementById("customerId").value;

	console.log(customerIdValue);

	if (customerIdValue) {
		// 선택한 고객 정보가 있는 경우 (update)
		const data = {
			action: "update",
			customerId: document.getElementById("customerId").value,
			name: document.getElementById("name").value,
			phone: document.getElementById("phone").value,
			email: document.getElementById("email").value,
			address: document.getElementById("address").value,
			address_detail: document.getElementById("addressDetail").value
		};

		console.log(data);

		try {
			const response = await fetch("mainpage.jsp", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(data)
			});

			// DB update 결과 받아오기
			const result = await response.json();

			if (result.message == "success") {
				location.reload();
				alert("수정 완료!");
			} else {
				alert("수정 실패!");
			}
		} catch (error) {
			console.error("Fetch 실패:", error);
			alert("에러 발생!");
		}
	} else {
		// 선택한 고객 정보가 없는 경우 (insert)
		console.log("추가 로직 시작");
		
		const currentUrl = new URL(window.location.href);
		const currentParams = currentUrl.searchParams;
		let branchIdParam = currentParams.get("branchId");
		
		const data = {
			action: "insert",
			name: document.getElementById("name").value,
			phone: document.getElementById("phone").value,
			email: document.getElementById("email").value,
			address: document.getElementById("address").value,
			address_detail: document.getElementById("addressDetail").value,
			branch_id: branchIdParam,
		};
		
		console.log(data);

		try {
			const response = await fetch("mainpage.jsp", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(data)
			});

			// DB update 결과 받아오기
			const result = await response.json();

			if (result.message == "success") {
				location.reload();
				alert("추가 완료!");
			} else {
				alert("추가 실패!");
			}
		} catch (error) {
			console.error("Fetch 실패:", error);
			alert("에러 발생!");
		}
	}

});


/* 하단 테이블 추가 버튼 클릭 시 실행되는 이벤트 */
const insertBtn = document.getElementById("insertBtn");
insertBtn.addEventListener("click", function() {
	// table element 찾기
	const table = document.getElementById('main_table');

	// 새 행(Row) 추가
	const newRow = table.insertRow();
	newRow.style.height = "18.5px";
	newRow.classList.add('table_row');

	// 열(column) 수에 맞춰 빈 셀(td) 7개 생성
	for (let i = 0; i < 7; i++) {
		const newCell = newRow.insertCell(i);
		newCell.textContent = " ";  // 빈 셀
		newCell.style.height = "18.5px";
	}
	
	// 기존 선택된 행 있으면 선택 해제
	const selectedRow = document.querySelector('.table_row.selected');
	if (selectedRow) selectedRow.classList.remove('selected');

	// 새로 추가한 행에 selected 클래스 추가 (파란색 효과)
	newRow.classList.add('selected');

	// input 모두 비우기
	document.getElementById("customerId").value = "";
	document.getElementById("name").value = "";
	document.getElementById("phone").value = "";
	document.getElementById("email").value = "";
	document.getElementById("address").value = "";
	document.getElementById("addressDetail").value = "";
});

/* 하단 테이블 추가 버튼 클릭 시 실행되는 이벤트 */
const deleteBtn = document.getElementById("deleteBtn");
deleteBtn.addEventListener("click", async function() {
	const customerIdValue = document.getElementById("customerId").value;
	if (customerIdValue == "") {
		alert("삭제할 고객 정보를 선택해주세요.");
		return;
	}
	if (confirm("삭제하시겠습니까?")) {
		const data = {
			action: "delete",
			customerId: customerIdValue
		};

		try {
			const response = await fetch("mainpage.jsp", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(data)
			});

			const result = await response.json();

			if (result.message == "success") {
				location.reload();
				alert("삭제 완료!");
			} else {
				alert("삭제 실패!");
			}
		} catch (error) {
			console.error("삭제 요청 실패:", error);
			alert("에러 발생!");
		}
	}
});

/* 행 클릭 시 클릭된 행 파란색으로 띄우는 이벤트 */
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.table_row').forEach(row => {
    row.addEventListener('click', () => {
      const selectedRow = document.querySelector('.table_row.selected');
      if (selectedRow && selectedRow !== row) {
        selectedRow.classList.remove('selected');
      }
      row.classList.toggle('selected');
    });
  });
});




