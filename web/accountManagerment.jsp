<%-- 
    Document   : AccountManagermet
    Created on : Jun 6, 2024, 3:27:31 PM
    Author     : ADMIN
--%>
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Free Bootstrap Admin Template : Binary Admin</title>
        <!-- BOOTSTRAP STYLES-->
        <link href="assets/css/bootstrap.css" rel="stylesheet" />
        <!-- FONTAWESOME STYLES-->
        <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <!-- CUSTOM STYLES-->
        <link href="assets/css/custom.css" rel="stylesheet" />
        <!-- GOOGLE FONTS-->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
        <!-- TABLE STYLES-->
        <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
        <style>
            .delete-link {
                color: white;
            }
        </style>
    </head>
    <script type="text/javascript">
        function doDelete(uid) {
            if (confirm("Are you sure to delete Human with id =" + uid)) {
                window.location = "deleteac?uid=" + uid;
            }
        }
    </script>
    <div id="wrapper">
            <nav class="navbar navbar-default navbar-cls-top " role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="homeadmin.jsp">Trang Quản Lý</a> 
                </div>
                <div style="color: white;
                     padding: 15px 50px 5px 50px;
                     float: right;
                     font-size: 16px;"> Last access : 30 May 2014 &nbsp; <a href="logout" class="btn btn-danger square-btn-adjust">Logout</a> </div>
            </nav>   
            <!-- /. NAV TOP  -->
                        <nav class="navbar-default navbar-side" role="navigation">
                <div class="sidebar-collapse">
                    <ul class="nav" id="main-menu">
                        <li class="text-center">
                            <img src="assets/img/find_user.png" class="user-image img-responsive"/>
                        </li>
                        <li>
                            <a class="#" href="homeadmin.jsp"><i class="fa fa-dashboard fa-3x"></i> Trang chủ</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-desktop fa-3x"></i> Quản Lý Sản Phẩm</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-qrcode fa-3x"></i>Quản Lý Nhãn Hàng</a>
                        </li>
                        <li>
                            <a href="accountmanagerment"><i class="fa fa-table fa-3x"></i> Quản Lý Tài Khoản</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-bar-chart-o fa-3x"></i>Thống Kê</a>
                        </li>	
                        
                        <li>
                            <a href="#"><i class="fa fa-edit fa-3x"></i>Phân Quyền</a>
                        </li>				
                          	
                    </ul>
                </div>
            </nav> 
            <!-- /. NAV SIDE  -->
            <div id="page-wrapper">
                <div id="page-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <h2>Quản Lý Tài Khoản</h2>   
                            <h5>Welcome ${sessionScope.acc.fullName}, Love to see you back.</h5>
                        </div>
                    </div>
                    <!-- /. ROW  -->
                    <hr />
                    <div class="row">
                        <div class="col-md-12">
                            <!-- Advanced Tables -->
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    Advanced Tables
                                </div>
                                <div class="panel-body">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Email</th>
                                                    <th>Họ Tên</th>
                                                    <th>Họ Tên</th>
                                                    <th>Giới Tính</th>
                                                    <th>Ngày Sinh</th>
                                                    <th>Địa chỉ</th>
                                                    <th>Chức Năng</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${requestScope.data}" var="u">
                                                    <tr>
                                                        <td>${u.id}</td>
                                                        <td>${u.email}</td>
                                                        <td>${u.fullName}</td>
                                                        <td>${u.gender}</td>
                                                        <td>${u.dob}</td>
                                                        <td>${u.phone}</td>
                                                        <td>${u.address}</td>
                                                        <td>
                                                            <form action="updateaccount">
                                                                <input type="hidden" name="id" value="${u.id}" />
                                                                <button class="btn btn-primary btn-xs" type="submit">Edit</button>
                                                            </form>
                                                            <button class="btn btn-danger btn-xs">
                                                                <a href="#" class="delete-link" onclick="doDelete('${u.id}')">Delete</a>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!--End Advanced Tables -->
                        </div>
                    </div>
                </div>
                <!-- /. PAGE INNER  -->
            </div>
            <!-- /. PAGE WRAPPER  -->
        </div>
        <!-- /. WRAPPER  -->
        <!-- SCRIPTS AT THE BOTTOM TO REDUCE THE LOAD TIME -->
        <!-- JQUERY SCRIPTS -->
        <script src="assets/js/jquery-1.10.2.js"></script>
        <!-- BOOTSTRAP SCRIPTS -->
        <script src="assets/js/bootstrap.min.js"></script>
        <!-- METISMENU SCRIPTS -->
        <script src="assets/js/jquery.metisMenu.js"></script>
        <!-- DATA TABLE SCRIPTS -->
        <script src="assets/js/dataTables/jquery.dataTables.js"></script>
        <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
        <script>
            $(document).ready(function () {
                $('#dataTables-example').dataTable();
            });
        </script>
        <!-- CUSTOM SCRIPTS -->
        <script src="assets/js/custom.js"></script>
    </body>
</html>
