document.getElementById("loginForm").addEventListener("submit", function(event) {
    event.preventDefault(); // Ngăn không cho form tự động submit

    // Lấy thông tin người dùng nhập vào
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;

    // Kiểm tra thông tin đăng nhập
    if (username === "nbt" && password === "123456") {
        // Nếu đúng, chuyển hướng đến index.html
        window.location.href = "index.html";
    } else {
        // Nếu sai, hiển thị thông báo lỗi
        alert("Tài khoản hoặc mật khẩu không đúng!");
    }
});