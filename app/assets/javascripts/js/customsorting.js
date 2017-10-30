function customTableSorting() {

				 $('.custom-table-sorting').tablesorter({
					 headers : {

									0: { sorter: "text" },
									1: { sorter: "digit" },
									2: { sorter: "text" },
									3: { sorter: "digit" }
							}
					});

		}
