<%-- 
    Document   : index
    Created on : 6 มิ.ย. 2566, 16:14:02
    Author     : pakutsing
--%>

<%@page import="com.pg.lib.utility.Utility"  %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <%@ include file="share/header.jsp" %>
        
    </head>
    <body>
        <div class="container">
            <div class="h1 text-center mt-3">
                LoadEmployee
            </div>
            
            <div class="card mt-3 shadow-lg">
                <div class="card-header">
                    LoadEmployee
                </div>
                <div class="card-body ">
                    <div class="text-center">
                        <p id="page_total" class="h2"></p>
                    </div>
                    <table class="table text-nowrap text-center table-bordered table-sm w-100" id="table_training" >
                        
                    </table>
                    <div class="text-center">
                        <button class="btn btn-primary btn-sm" type="button" onclick="gettableuser()">ดึงรายชื่อ</button>
                        &nbsp; 
                        <button class="btn btn-success btn-sm" type="button" id="save_data" onclick="updatedata()" disabled>บันทึก</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="text-center mt-3">
            <%@ include file="share/footer.jsp" %>
        </div>
    </body>
    <script>
        
        function chknull(txt){
            if(txt == "" || txt == null){
                txt = "";
            }
            return txt
        }
        
    
    
        function updatedata(){
            $("#save_data").attr("disabled",true)
            
            $.ajax({
                type:"post",
                url:"User",
                data:{
                    type:"saveuser"
                },
                success:function(msg){
                    if(msg == 'true'){
                        Swal.fire({
                            title:"บันทึก",
                            icon:"success",
                            text:"บันทึกสำเร็จ"
                        })
                    }else if(msg == 'false'){
                        Swal.fire({
                            title:"บันทึก",
                            icon:"error",
                            text:"บันทึกไม่สำเร็จ"
                        })
                    }
                    $("save_data").attr("disabled","true")
                }
            })
            
             
            
        }
        
        function newexportaction(e, dt, button, config) {
            var self = this;
            var oldStart = dt.settings()[0]._iDisplayStart;
            dt.one('preXhr', function (e, s, data) {
                // Just this once, load all data from the server...
                data.start = 0;
                data.length = 2147483647;
                dt.one('preDraw', function (e, settings) {
                    // Call the original action function
                    if (button[0].className.indexOf('buttons-copy') >= 0) {
                        $.fn.dataTable.ext.buttons.copyHtml5.action.call(self, e, dt, button, config);
                    } else if (button[0].className.indexOf('buttons-excel') >= 0) {
                        $.fn.dataTable.ext.buttons.excelHtml5.available(dt, config) ?
                            $.fn.dataTable.ext.buttons.excelHtml5.action.call(self, e, dt, button, config) :
                            $.fn.dataTable.ext.buttons.excelFlash.action.call(self, e, dt, button, config);
                    } else if (button[0].className.indexOf('buttons-csv') >= 0) {
                        $.fn.dataTable.ext.buttons.csvHtml5.available(dt, config) ?
                            $.fn.dataTable.ext.buttons.csvHtml5.action.call(self, e, dt, button, config) :
                            $.fn.dataTable.ext.buttons.csvFlash.action.call(self, e, dt, button, config);
                    } else if (button[0].className.indexOf('buttons-pdf') >= 0) {
                        $.fn.dataTable.ext.buttons.pdfHtml5.available(dt, config) ?
                            $.fn.dataTable.ext.buttons.pdfHtml5.action.call(self, e, dt, button, config) :
                            $.fn.dataTable.ext.buttons.pdfFlash.action.call(self, e, dt, button, config);
                    } else if (button[0].className.indexOf('buttons-print') >= 0) {
                        $.fn.dataTable.ext.buttons.print.action(e, dt, button, config);
                    }
                    dt.one('preXhr', function (e, s, data) {
                        // DataTables thinks the first item displayed is index 0, but we're not drawing that.
                        // Set the property to what it was before exporting.
                        settings._iDisplayStart = oldStart;
                        data.start = oldStart;
                    });
                    // Reload the grid with the original page. Otherwise, API functions like table.cell(this) don't work properly.
                    setTimeout(dt.ajax.reload, 0);
                    // Prevent rendering of the full data to the DOM
                    return false;
                });
            });
            // Requery the server with the new one-time export settings
            dt.ajax.reload();
        }
        
        function gettableuser(){
            $("#save_data").attr("disabled",false)
            var table = $("#table_training").DataTable({
                
                processing: true,
                serverSide: true,
                ajax: {
                    type:"post",
                    url:"User",
                    data:{
                        type:"gettableuser"
                    },
                    dataSrc:function(json){
                      
                        $("#page_total").text("พนักงานทั้งหมด : "+json.recordsTotal+" คน")
                        
                        var data = JSON.parse(json.data)
                        
                        console.log(data)
                        
                        var arr = []
                                       
                        $.each(data,function(k,v){
                            var result = {
                                emmployee_PREFIXDESC : chknull(v.PREFIXDESC),
                                emmployee_PREFIXEDESC : chknull(v.PREFIXEDESC),
                                emmployee_PWBIRTHDAY : chknull(v.PWBIRTHDAY),
                                emmployee_PWCOMPANY : chknull(v.PWCOMPANY),
                                emmployee_PWCOST : chknull(v.PWCOST),
                                emmployee_PWDEPT : chknull(v.PWDEPT),
                                emmployee_PWDEPTDESC : chknull(v.PWDEPTDESC),
                                emmployee_PWDIVDESC : chknull(v.PWDIVDESC),
                                emmployee_PWDIVISION : chknull(v.PWDIVISION),
                                emmployee_PWEFNAME : chknull(v.PWEFNAME),
                                emmployee_PWELNAME : chknull(v.PWELNAME),
                                emmployee_PWEMAIL : chknull(v.PWEMAIL),
                                emmployee_PWEMPLOYEE : chknull(v.PWEMPLOYEE),
                                emmployee_PWFNAME : chknull(v.PWFNAME),
                                emmployee_PWGROUP : chknull(v.PWGROUP),
                                emmployee_PWHOUR_D : chknull(v.PWHOUR_D),
                                emmployee_PWIDCARD : chknull(v.PWIDCARD),
                                emmployee_PWJOB : chknull(v.PWJOB),
                                emmployee_PWLNAME : chknull(v.PWLNAME),
                                emmployee_PWMOBILE : chknull(v.PWMOBILE),
                                emmployee_PWPOSIDESC : chknull(v.PWPOSIDESC),
                                emmployee_PWPOSITION : chknull(v.PWPOSITION),
                                emmployee_PWRETRYDATE : chknull(v.PWRETRYDATE),
                                emmployee_PWSALARYLST : chknull(v.PWSALARYLST),
                                emmployee_PWSALATYPE : chknull(v.PWSALATYPE),
                                emmployee_PWSECTDESC : chknull(v.PWSECTDESC),
                                emmployee_PWSECTION : chknull(v.PWSECTION),
                                emmployee_PWSEX : chknull(v.PWSEX),
                                emmployee_PWSTARTDATE : chknull(v.PWSTARTDATE),
                                emmployee_PWSTATWORK : chknull(v.PWSTATWORK),
                                emmployee_PWTELNO : chknull(v.PWTELNO),
                                emmployee_PWTIME0 : chknull(v.PWTIME0),
                                emmployee_PWTIME0DESC : chknull(v.PWTIME0DESC),
                                emmployee_PWUNIT : chknull(v.PWUNIT),
                                emmployee_PWUNITDESC : chknull(v.PWUNITDESC),
                                emmployee_PWVACATION0 : chknull(v.PWVACATION0),
                                emmployee_PWVACATION1 : chknull(v.PWVACATION1)
                            }
                            arr.push(result);
                        })
                        
                        return arr
                    }
                },
                dom: 'Bfrtip',
                lengthMenu: [[10, 25, 50,100,9999999], [10, 25, 50,100 ,"All"]],
                buttons: [
                    'pageLength',
                    {
                        extend: 'excelHtml5',
                        title: 'รายชื่อพนักงานทั้งหมด',
                        titleAttr: 'Excel',
                        action: newexportaction
                    },
                ],
                columns: [
                    { 
                        title: 'PWEMPLOYEE',
                        data: "emmployee_PWEMPLOYEE"
                    },
                    { 
                        title: 'PREFIXDESC',
                        data: "emmployee_PREFIXDESC"
                    },
                    { 
                        title: 'PWFNAME',
                        data: "emmployee_PWFNAME"
                    },
                    { 
                        title: 'PWLNAME',
                        data: "emmployee_PWLNAME"
                    },
                    { 
                        title: 'PWDIVISION',
                        data: "emmployee_PWDIVISION"
                    },
                    { 
                        title: 'PWDIVDESC',
                        data: "emmployee_PWDIVDESC"
                    },
                    { 
                        title: 'PWSECTION',
                        data: "emmployee_PWSECTION"
                    },
                    { 
                        title: 'PWSECTDESC',
                        data: "emmployee_PWSECTDESC"
                    },
                    { 
                        title: 'PWDEPT',
                        data: "emmployee_PWDEPT"
                    },
                    { 
                        title: 'PWDEPTDESC',
                        data: "emmployee_PWDEPTDESC"
                    },
                    { 
                        title: 'PWUNIT',
                        data: "emmployee_PWUNIT"
                    },
                    { 
                        title: 'PWUNITDESC',
                        data: "emmployee_PWUNITDESC"
                    },
                    { 
                        title: 'PWSTATWORK',
                        data: "emmployee_PWSTATWORK"
                    },
                    { 
                        title: 'PWPOSIDESC',
                        data: "emmployee_PWPOSIDESC"
                    },
                    { 
                        title: 'PWGROUP',
                        data: "emmployee_PWGROUP"
                    },
                    { 
                        title: 'PWTIME0',
                        data: "emmployee_PWTIME0"
                    },
                    { 
                        title: 'PWTIME0DESC',
                        data: "emmployee_PWTIME0DESC"
                    },
                    { 
                        title: 'PWSALATYPE',
                        data: "emmployee_PWSALATYPE"
                    },
                    { 
                        title: 'PWSALARYLST',
                        data: "emmployee_PWSALARYLST"
                    },
                    { 
                        title: 'PWHOUR_D',
                        data: "emmployee_PWHOUR_D"
                    },
                    { 
                        title: 'PWCOMPANY',
                        data: "emmployee_PWCOMPANY"
                    },
                    { 
                        title: 'PWSTARTDATE',
                        data: "emmployee_PWSTARTDATE"
                    },
                    { 
                        title: 'PWCOST',
                        data: "emmployee_PWCOST"
                    },
                    { 
                        title: 'PWRETRYDATE',
                        data: "emmployee_PWRETRYDATE"
                    },
                    { 
                        title: 'PWVACATION0',
                        data: "emmployee_PWVACATION0"
                    },
                    { 
                        title: 'PWVACATION1',
                        data: "emmployee_PWVACATION1"
                    },
                    { 
                        title: 'PWIDCARD',
                        data: "emmployee_PWIDCARD"
                    },
                    { 
                        title: 'PWSEX',
                        data: "emmployee_PWSEX"
                    },
                    { 
                        title: 'PWPOSITION',
                        data: "emmployee_PWPOSITION"
                    },
                    { 
                        title: 'PWBIRTHDAY',
                        data: "emmployee_PWBIRTHDAY"
                    },
                    { 
                        title: 'PREFIXEDESC',
                        data: "emmployee_PREFIXEDESC"
                    },
                    { 
                        title: 'PWEFNAME',
                        data: "emmployee_PWEFNAME"
                    },
                    { 
                        title: 'PWELNAME',
                        data: "emmployee_PWELNAME"
                    },
                    { 
                        title: 'PWEMAIL',
                        data: "emmployee_PWEMAIL"
                    },
                    { 
                        title: 'PWTELNO',
                        data: "emmployee_PWTELNO"
                    },
                    { 
                        title: 'PWMOBILE',
                        data: "emmployee_PWMOBILE"
                    },
                    { 
                        title: 'PWJOB',
                        data: "emmployee_PWJOB"
                    }                  
                ],
                scrollCollapse: true,
                scrollX:true, 
                bDestroy: true
                                  
            })
           
        }


        $(document).ready(function(){
            
        });
        


    </script>
    
    
</html>
