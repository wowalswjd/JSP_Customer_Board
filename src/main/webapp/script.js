document.addEventListener("DOMContentLoaded", function () {
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