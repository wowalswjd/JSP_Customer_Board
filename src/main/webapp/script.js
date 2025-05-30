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
	const data = {
		action: "update",
		customerId: document.getElementById("customerId").value,
		name: document.getElementById("name").value,
		phone: document.getElementById("phone").value,
		email: document.getElementById("email").value,
		address: document.getElementById("address").value,
		address_detail: document.getElementById("addressDetail").value
	};

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
			alert("수정 완료!");
			location.reload();
		} else {
			alert("수정 실패!");
		}
	} catch (error) {
		console.error("Fetch 실패:", error);
		alert("에러 발생!");
	}
});



