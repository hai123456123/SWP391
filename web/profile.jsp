<%-- 
    Document   : profile
    Created on : Jun 9, 2024, 10:42:38 PM
    Author     : ADMIN
--%>
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                background: #F8F8F8;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .form-control:focus {
                box-shadow: none;
                border-color: #BA68C8;
            }
            .profile-button {
                background: #cc0000;
                box-shadow: none;
                border: none;
            }
            .profile-button:hover,
            .profile-button:focus,
            .profile-button:active {
                background: #F44336;
                box-shadow: none;
            }
            .back:hover {
                color: #682773;
                cursor: pointer;
            }
            .labels {
                font-size: 11px;
            }
            .add-experience:hover {
                background: #BA68C8;
                color: #fff;
                cursor: pointer;
                border: solid 1px #BA68C8;
            }
            .edit-button {
                margin-top: 10px;
                width: 100%;
            }
            .container {
                border: 1px solid #ccc;
                padding: 20px;
                border-radius: 10px;
                max-width: 900px;
                background: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body>
        <div class="container rounded bg-white">
            <div class="row">
                <div class="col-md-5 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                        <p>${requestScope.mess}</p>
                        <img class="rounded-circle mt-5" width="150px" src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg" alt="Profile Picture">
                        <span class="font-weight-bold">${sessionScope.acc.fullName}</span>
                        <button class="btn btn-secondary profile-button edit-button" type="button" onclick="window.location.href='changepassword.jsp'">Thay đổi mật khẩu</button>
                        <button class="btn btn-secondary profile-button edit-button" type="button" onclick="window.location.href='home.jsp'">Quay về trang chủ</button>
                        <span> </span>
                    </div>
                </div>
                <div class="col-md-7 ">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-right">Profile Settings</h4>
                        </div>

                        <div class="row mt-3">
                            <form action="profile" method="post">
                                <div class="col-md-12 mb-3">
                                    <label class="labels">Email</label>
                                    <input type="text" class="form-control" placeholder="email" value="${sessionScope.user.email}" readonly >
                                </div>
                                <div class="col-md-12 mb-3">
                                    <label class="labels">Mật khẩu</label>
                                    <input type="password" class="form-control" placeholder="password" value="${requestScope.user.pass}" readonly>
                                </div>
                                <div class="col-md-12 mb-3">
                                    <label class="labels">Họ & Tên</label>
                                    <input required type="text" class="form-control" placeholder="full name" name="fullName" value="${requestScope.user.fullName}">
                                </div>
                                <div class="col-md-12 mb-3">
                                    <label class="labels">Số điện thoại</label>
                                    <input required type="text" class="form-control" placeholder="phone number" name="phone" value="${requestScope.user.phone}">
                                </div>
                                <div class="col-md-12 mb-3">
                                    <label class="labels">Địa chỉ</label>
                                    <input  required type="text" class="form-control" placeholder="address" name="address" value="${requestScope.user.address}">
                                </div>
                                <div class="mt-5 text-center">
                                    <button class="btn btn-primary profile-button" type="submit">Lưu Thông Tin</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
