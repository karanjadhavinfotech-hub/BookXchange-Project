<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
</head>
<body>
	<h1 class="text-center my-4">Add Your Book</h1>
    <div class="container">
    <form action="addBook" method="post" enctype="multipart/form-data" class="p-4 border rounded shadow-sm bg-light">
    
        <div class="mb-3">
            <label for="bookName" class="form-label">Book Name</label>
            <input type="text" class="form-control" id="bookName" name="bookName" required>
        </div>
			
        <div class="mb-3">
            <label for="condition" class="form-label">Condition</label>
            <div>
                <input type="radio" name="condition" value="Good" required> Good
                <input type="radio" name="condition" value="Average"> Average
                <input type="radio" name="condition" value="Fair"> Fair
            </div>
        </div>

        <div class="mb-3">
            <label for="isbn" class="form-label">ISBN Number</label>
            <input type="number" class="form-control" id="isbn" name="isbn" required>
        </div>

        <div class="mb-3">
            <label for="price" class="form-label">Price</label>
            <input type="number" class="form-control" id="price" name="price" required>
        </div>

        <div class="mb-3">
            <label for="images" class="form-label">Book Image</label>
            <input class="form-control" type="file" id="images" name="images" required>
        </div>

        <div class="mb-3">
            <label for="sellerName" class="form-label">Seller Name</label>
            <input type="text" class="form-control" id="sellerName" name="sellerName" required>
        </div>

        <div class="mb-3">
            <label for="phoneNumber" class="form-label">Phone Number</label>
            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required>
        </div>

		<div class="d-grid">
                <button type="submit" class="btn btn-success">Submit</button>
        </div>    
       </form>
    </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
