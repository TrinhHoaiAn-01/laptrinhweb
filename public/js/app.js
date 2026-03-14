const USER_PAGES = [
    [
        { id: 1, username: "UPVH", email: "ATJW@gmail.com" },
        { id: 2, username: "IFUK", email: "KULB@gmail.com" },
        { id: 3, username: "DZZQ", email: "ERNB@gmail.com" },
        { id: 4, username: "NJYY", email: "ROIF@gmail.com" },
        { id: 5, username: "YUMG", email: "KITN@gmail.com" },
        { id: 6, username: "WZSU", email: "CVTL@gmail.com" },
        { id: 7, username: "WXFQ", email: "MIUZ@gmail.com" },
        { id: 8, username: "XZOR", email: "YZLV@gmail.com" },
        { id: 9, username: "HGGO", email: "OYYX@gmail.com" },
        { id: 10, username: "PXZX", email: "YSML@gmail.com" }
    ],
    [
        { id: 11, username: "test1", email: "test1@gmail.com" },
        { id: 12, username: "test2", email: "test2@gmail.com" },
        { id: 13, username: "test3", email: "test3@gmail.com" },
        { id: 14, username: "haian", email: "haian@gmail.com" },
        { id: 15, username: "phuong", email: "phuong@gmail.com" },
        { id: 16, username: "minhvu", email: "minhvu@gmail.com" },
        { id: 17, username: "hoang", email: "hoang@gmail.com" },
        { id: 18, username: "linhchi", email: "linhchi@gmail.com" },
        { id: 19, username: "trungkien", email: "trungkien@gmail.com" },
        { id: 20, username: "thanhha", email: "thanhha@gmail.com" }
    ],
    [
        { id: 21, username: "alpha", email: "alpha@gmail.com" },
        { id: 22, username: "beta", email: "beta@gmail.com" },
        { id: 23, username: "gamma", email: "gamma@gmail.com" },
        { id: 24, username: "delta", email: "delta@gmail.com" },
        { id: 25, username: "omega", email: "omega@gmail.com" }
    ]
];

function showMessage(form, message, color) {
    const box = form.querySelector(".form-message");
    if (!box) {
        return;
    }

    box.textContent = message;
    box.style.color = color || "#b42318";
}

function setupForms() {
    const forms = document.querySelectorAll("[data-form-type]");

    forms.forEach((form) => {
        form.addEventListener("submit", (event) => {
            event.preventDefault();
            const type = form.dataset.formType;
            const username = form.querySelector("[name='username']");
            const password = form.querySelector("[name='password']");
            const confirmPassword = form.querySelector("[name='confirm_password']");
            const email = form.querySelector("[name='email']");

            if (username && username.value.trim() === "") {
                showMessage(form, "Vui lòng nhập tên đăng nhập.");
                username.focus();
                return;
            }

            if (password && password.value.trim() === "") {
                showMessage(form, "Vui lòng nhập mật khẩu.");
                password.focus();
                return;
            }

            if (confirmPassword && confirmPassword.value.trim() !== password.value.trim()) {
                showMessage(form, "Mật khẩu nhập lại không khớp.");
                confirmPassword.focus();
                return;
            }

            if (email) {
                const validEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!validEmail.test(email.value.trim())) {
                    showMessage(form, "Email không đúng định dạng.");
                    email.focus();
                    return;
                }
            }

            const success =
                type === "login"
                    ? "Đăng nhập thành công (mô phỏng giao diện tĩnh)."
                    : type === "register"
                        ? "Đăng ký thành công (mô phỏng giao diện tĩnh)."
                        : "Cập nhật thông tin thành công (mô phỏng giao diện tĩnh).";

            showMessage(form, success, "#117a37");
        });
    });
}

function renderListPage() {
    const tableBody = document.querySelector("[data-user-table]");
    const pager = document.querySelector("[data-pagination]");

    if (!tableBody || !pager) {
        return;
    }

    let currentPage = 1;

    const render = () => {
        const users = USER_PAGES[currentPage - 1] || [];

        tableBody.innerHTML = users
            .map(
                (user) => `
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.username}</td>
                        <td>${user.email}</td>
                        <td>
                            <a href="update.html?id=${user.id}">Edit</a> |
                            <a href="view.html?id=${user.id}">View</a> |
                            <a href="#" data-delete-id="${user.id}">Delete</a>
                        </td>
                    </tr>
                `
            )
            .join("");

        pager.innerHTML = "";

        const prevButton = document.createElement("button");
        prevButton.className = "page-btn";
        prevButton.textContent = "Previous";
        prevButton.disabled = currentPage === 1;
        prevButton.addEventListener("click", () => {
            if (currentPage > 1) {
                currentPage -= 1;
                render();
            }
        });
        pager.appendChild(prevButton);

        USER_PAGES.forEach((_, index) => {
            const pageButton = document.createElement("button");
            pageButton.className = `page-btn${currentPage === index + 1 ? " is-active" : ""}`;
            pageButton.textContent = String(index + 1);
            pageButton.addEventListener("click", () => {
                currentPage = index + 1;
                render();
            });
            pager.appendChild(pageButton);
        });

        const nextButton = document.createElement("button");
        nextButton.className = "page-btn";
        nextButton.textContent = "Next";
        nextButton.disabled = currentPage === USER_PAGES.length;
        nextButton.addEventListener("click", () => {
            if (currentPage < USER_PAGES.length) {
                currentPage += 1;
                render();
            }
        });
        pager.appendChild(nextButton);

        tableBody.querySelectorAll("[data-delete-id]").forEach((link) => {
            link.addEventListener("click", (event) => {
                event.preventDefault();
                window.alert(`Đây là giao diện tĩnh. Chưa xóa người dùng có mã ${link.dataset.deleteId}.`);
            });
        });
    };

    render();
}

function fillUserDetail() {
    const usernameNode = document.querySelector("[data-detail='username']");
    const emailNode = document.querySelector("[data-detail='email']");
    const editButton = document.querySelector("[data-edit-link]");
    const form = document.querySelector("[data-prefill-form]");

    if (!usernameNode && !form) {
        return;
    }

    const params = new URLSearchParams(window.location.search);
    const userId = Number(params.get("id")) || 11;
    const user = USER_PAGES.flat().find((item) => item.id === userId) || USER_PAGES[1][0];

    if (usernameNode) {
        usernameNode.textContent = user.username;
    }

    if (emailNode) {
        emailNode.textContent = user.email;
    }

    if (editButton) {
        editButton.href = `update.html?id=${user.id}`;
    }

    if (form) {
        form.querySelector("[name='username']").value = user.username;
        form.querySelector("[name='password']").value = "123456";
        form.querySelector("[name='confirm_password']").value = "123456";
        form.querySelector("[name='email']").value = user.email;
    }
}

document.addEventListener("DOMContentLoaded", () => {
    setupForms();
    renderListPage();
    fillUserDetail();
});
