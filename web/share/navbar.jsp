<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
            String status = (String) request.getSession().getAttribute("statuslogin");
            String name = (String) request.getSession().getAttribute("name");
            String statususer = (String) request.getSession().getAttribute("statususer");
            if (status == null || status.equals("0")) {
                getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
            }

%> 
<div class="wrapper">

<!-- Preloader -->
<div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="img/logo.png" alt="AdminLTELogo" height="100" width="100">
</div>

<!-- Navbar -->
<nav class="main-header navbar navbar-expand navbar-white navbar-light  ">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
        <li class="nav-item d-none d-sm-inline-block">
            <a href="index.jsp" class="nav-link">
                <i class="fas fa-home"></i>
                
                หน้าเเรก
            </a>
        </li>
        <li class="nav-item d-none d-sm-inline-block">
            <a href="contact.jsp" class="nav-link">
                <i class="fas fa-phone-alt"></i>
                
                ติดต่อ
            </a>
        </li>
    </ul>
    
    <ul class="navbar-nav ml-auto">
        <div class="btn-group">
            <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                คุณ : <%=name%>
            </button>
            <div class="dropdown-menu dropdown-menu-right ">
                
                
                <div class="text-center pt-2 pl-3 pr-3 pb-3">
                    <div class="mb-3"><strong>ยินดีต้อนรับ</strong>  </div>
                    <div class="mb-3"><strong>  คุณ : </strong> <%=name%></div>
                    <div class="text-uppercase"><strong>  สถานะ : </strong> <%=statususer%></div>
                </div>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item text-center text-danger " href="Chkauthen?type=logout"> <i class="fas fa-door-open"></i> ออกจากระบบ</a>
            </div>
        </div>
        
    </ul>
    
</nav>
<!-- /.navbar -->

<!-- Main Sidebar Container -->
<aside class="main-sidebar elevation-4 sidebar-light-olive ">
    <!-- Brand Logo -->
    
    <a href="index.jsp" class="brand-link text-md">
        <img src="img/logo.png" alt="AdminLTE Logo" class="brand-image  img-fluid m-0" >
        <span class="brand-text p-1 fw-bold text-uppercase" style="color:#3d9970" >Employee Training</span>
    </a>
    <!-- Sidebar -->
    <div class="sidebar">
        
        <!-- Sidebar Menu -->
        <nav class="mt-2 ">
            
            <ul class="nav nav-pills nav-sidebar flex-column  nav-flat nav-legacy" data-widget="treeview" role="menu" data-accordion="false">
                <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
              <%

            if (statususer != null && statususer.equalsIgnoreCase("admin")) {
            %>
                
                
                <li class="nav-header font-weight-bold  bg-success text-center">จัดการผู้ใช้งาน</li>
                <li class="nav-item menu-is-opening menu-open" id="listuser">
                    <a href="#" class="nav-link active" id="pageuser">
                        <i class="fas fa-users nav-icon" ></i>
                        <p>
                            
                            ผู้ใช้งาน
                            <i class="right fas fa-angle-left"></i>
                        </p>
                        
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="manageuser.jsp" class="nav-link " id="datauser">
                                <i class="far fa-circle nav-icon"></i>
                                <p>ข้อมูลผู้ใช้งาน</p>
                            </a>
                        </li>
                        
                        
                    </ul>
                </li>
                <%            }
                %>
                <li class="nav-header font-weight-bold  bg-success text-center">จัดการข้อมูล</li>
                <li class="nav-item menu-is-opening menu-open" id="listdata">
                    <a href="#" class="nav-link active" id="pagedata">
                        <i class="nav-icon fas fa-database"></i>
                        <p>
                            ข้อมูล
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="managetopic1.jsp" class="nav-link " id="datatopic1">
                                <i class="far fa-circle nav-icon"></i>
                                <p>ข้อมูลหมวดหลัก</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="managetopic2.jsp" class="nav-link" id="datatopic2">
                                <i class="far fa-circle nav-icon"></i>
                                <p>ข้อมูลหมวดย่อย</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="managecourse.jsp" class="nav-link"  id="datacourse">
                                <i class="far fa-circle nav-icon"></i>
                                <p>ข้อมูลหลักสูตร</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="manageaddress.jsp" class="nav-link"  id="dataaddress">
                                <i class="far fa-circle nav-icon"></i>
                                <p>ข้อมูลสาขา</p>
                            </a>
                        </li>
                        
                    </ul>
                </li>
                <li class="nav-header font-weight-bold  bg-success text-center">จัดการการฝึกอบรม</li>
                <li class="nav-item menu-is-opening menu-open" id="listtraining">
                    <a href="#" class="nav-link active" id="pagetraining">
                        <i class="nav-icon fas fa-running"></i>
                        <p>
                            ฝึกอบรม
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="managetraining.jsp" class="nav-link" id="datatraining">
                                <i class="far fa-circle nav-icon"></i>
                                <p>ข้อมูลฝึกอบรม</p>
                            </a>
                        </li>
                        <!--
                        <li class="nav-item">
                            <a href="manageevaluation.jsp" class="nav-link" id="dataevaluation">
                                <i class="far fa-circle nav-icon"></i>
                                <p>ประเมินผลผู้เข้าอบรม</p>
                            </a>
                        </li>
                        -->
                    </ul>
                </li>
                <li class="nav-header font-weight-bold bg-success text-center">ออกรายงาน</li>
                <li class="nav-item menu-is-opening menu-open" id="listreport">
                    <a href="#" class="nav-link active" id="pagereport">
                        <i class="nav-icon fas fa fa-file"></i>
                        <p>
                            รายงาน
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="managereporttopic.jsp" class="nav-link " id="datareporttopic">
                                <div class="row">
                                    <div class="col-2 mt-1 "><i class="far fa-circle nav-icon"></i></div>
                                    <div class="col-10 px-3"><p class="">แสดงการฝึกอบรมตามหมวด</p></div>
                                </div>
                            </a>
                        </li>
                        <!--
                        <li class="nav-item">
                            <a href="managereportcourse.jsp" class="nav-link " id="datareportcourse">
                                <div class="row">
                                    <div class="col-2 mt-1 "><i class="far fa-circle nav-icon"></i></div>
                                    <div class="col-10 px-3"><p class="">แสดงการฝึกอบรมตามหลักสูตร</p></div>
                                </div>
                            </a>
                        </li>
                        -->
                        <li class="nav-item">
                            <a href="managereportemployee.jsp" class="nav-link " id="datareportemployee">
                                <div class="row">
                                    <div class="col-2 mt-1"><i class="far fa-circle nav-icon"></i></div>
                                    <div class="col-10 px-3"><p class="">แสดงการฝึกอบรมตามรหัสพนักงาน</p></div>
                                </div>
                            </a>
                        </li>
                        
                    </ul>
                </li>
            </ul>
            
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>

