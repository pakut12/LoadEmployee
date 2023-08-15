/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.service;

import com.pg.lib.model.GT_User;
import com.pg.lib.utility.ConnectDB;
import com.pg.lib.utility.Utility;
import java.sql.*;
import java.util.*;
import java.util.ArrayList;

/**
 *
 * @author pakutsing
 */
public class UserService {

    private static Connection conn;
    private static PreparedStatement ps;
    private static ResultSet rs;

    public static int gettotaltableuserfromhr() throws SQLException {
        int total = 0;
        try {

            String sql = "";
            sql += "SELECT count(*) FROM(select rownum as rnum,e.* from ( ";
            sql += "select * from v_pwemployee where pwgroup in ('M','D') ";
            sql += "and pwstatwork <> 'Y'  and  pwemployee NOT IN ('190001','190037') and LENGTH(TRIM(pwemployee)) = 6 ";
            sql += " union ";
            sql += "select * from v_pwemployee where pwgroup in ('M','D') and pwstatwork = 'Y' and LENGTH(TRIM(pwemployee)) = 6 and ";
            sql += "trunc(sysdate - to_date(pwretrydate,'YYYY-MM-DD')) < 90   order by 1 ";
            sql += ") e )";

            conn = ConnectDB.getConnectionhr();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt("count(*)");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }

        return total;

    }

    public static int getfilteredtableuserfromhr(String searchValue) throws SQLException {
        List<GT_User> listuser = new ArrayList<GT_User>();
        int total = 0;
        try {

            String sql = "";
            sql += "SELECT count(*) FROM(select rownum as rnum,e.* from ( ";
            sql += "select * from v_pwemployee where pwgroup in ('M','D') ";
            sql += "and pwstatwork <> 'Y'  and  pwemployee NOT IN ('190001','190037') and LENGTH(TRIM(pwemployee)) = 6 ";
            sql += " union ";
            sql += "select * from v_pwemployee where pwgroup in ('M','D') and pwstatwork = 'Y' and LENGTH(TRIM(pwemployee)) = 6 and ";
            sql += "trunc(sysdate - to_date(pwretrydate,'YYYY-MM-DD')) < 90   order by 1 ";
            sql += ") e where (e.pwemployee like ? or  e.PWFNAME like ?  or  e.PWLNAME like ? ) )";

            conn = ConnectDB.getConnectionhr();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + searchValue + "%");
            ps.setString(2, "%" + searchValue + "%");
            ps.setString(3, "%" + searchValue + "%");

            rs = ps.executeQuery();

            while (rs.next()) {
                total = rs.getInt("count(*)");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }

        return total;

    }

    public static List<GT_User> gettableuserfromhr(int start, int length, String searchValue) throws SQLException {
        List<GT_User> listuser = new ArrayList<GT_User>();
        try {

            String sql = "";
            sql += "SELECT * FROM(select rownum as rnum,e.* from ( ";
            sql += "select * from v_pwemployee where pwgroup in ('M','D') ";
            sql += "and pwstatwork <> 'Y'  and  pwemployee NOT IN ('190001','190037') and LENGTH(TRIM(pwemployee)) = 6 ";
            sql += " union ";
            sql += "select * from v_pwemployee where pwgroup in ('M','D') and pwstatwork = 'Y' and LENGTH(TRIM(pwemployee)) = 6 and ";
            sql += "trunc(sysdate - to_date(pwretrydate,'YYYY-MM-DD')) < 90   order by 1 ";
            sql += ") e where (e.pwemployee like ? or  e.PWFNAME like ?  or  e.PWLNAME like ? ) ) where rnum BETWEEN ? AND ?";

            conn = ConnectDB.getConnectionhr();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + searchValue + "%");
            ps.setString(2, "%" + searchValue + "%");
            ps.setString(3, "%" + searchValue + "%");
            ps.setInt(4, start);
            ps.setInt(5, start + length);

            rs = ps.executeQuery();

            while (rs.next()) {
                if (rs.getString("PWEMPLOYEE").length() == 6 && !rs.getString("PWEMPLOYEE").equals("")) {

                    GT_User user = new GT_User();
                    user.setPWEMPLOYEE(rs.getString("PWEMPLOYEE"));
                    user.setPREFIXDESC(rs.getString("PREFIXDESC"));
                    user.setPWFNAME(rs.getString("PWFNAME"));
                    user.setPWLNAME(rs.getString("PWLNAME"));
                    user.setPWDIVISION(rs.getString("PWDIVISION"));
                    user.setPWDIVDESC(rs.getString("PWDIVDESC"));
                    user.setPWSECTION(rs.getString("PWSECTION"));
                    user.setPWSECTDESC(rs.getString("PWSECTDESC"));
                    user.setPWDEPT(rs.getString("PWDEPT"));
                    user.setPWDEPTDESC(rs.getString("PWDEPTDESC"));
                    user.setPWUNIT(rs.getString("PWUNIT"));
                    user.setPWUNITDESC(rs.getString("PWUNITDESC"));
                    user.setPWSTATWORK(rs.getString("PWSTATWORK"));
                    user.setPWPOSIDESC(rs.getString("PWPOSIDESC"));
                    user.setPWGROUP(rs.getString("PWGROUP"));
                    user.setPWTIME0(rs.getString("PWTIME0"));
                    user.setPWTIME0DESC(rs.getString("PWTIME0DESC"));
                    user.setPWHOUR_D(rs.getString("PWHOUR_D"));
                    user.setPWSALATYPE(rs.getString("PWSALATYPE"));
                    user.setPWSALARYLST(rs.getString("PWSALARYLST"));
                    user.setPWCOMPANY(rs.getString("PWCOMPANY"));
                    user.setPWSTARTDATE(rs.getString("PWSTARTDATE"));
                    user.setPWCOST(rs.getString("PWCOST"));
                    user.setPWRETRYDATE(rs.getString("PWRETRYDATE"));
                    user.setPWVACATION0(rs.getString("PWVACATION0"));
                    user.setPWVACATION1(rs.getString("PWVACATION1"));
                    user.setPWIDCARD(rs.getString("PWIDCARD"));
                    user.setPWSEX(rs.getString("PWSEX"));
                    user.setPWPOSITION(rs.getString("PWPOSITION"));
                    user.setPWBIRTHDAY(rs.getString("PWBIRTHDAY"));
                    user.setPREFIXEDESC(rs.getString("PREFIXEDESC"));
                    user.setPWEFNAME(rs.getString("PWEFNAME"));
                    user.setPWELNAME(rs.getString("PWELNAME"));
                    user.setPWEMAIL(rs.getString("PWEMAIL"));
                    user.setPWTELNO(rs.getString("PWTELNO"));
                    user.setPWMOBILE(rs.getString("PWMOBILE"));
                    user.setPWJOB(rs.getString("PWJOB"));
                    listuser.add(user);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }

        return listuser;

    }

    public static List<GT_User> getuserfromhr() throws SQLException {
        List<GT_User> listuser = new ArrayList<GT_User>();
        try {

            String sql = "";
            sql += "select * from v_pwemployee where pwgroup in ('M','D') ";
            sql += "and pwstatwork <> 'Y'  and  pwemployee NOT IN ('190001','190037') and LENGTH(TRIM(pwemployee)) = 6 ";
            sql += " union ";
            sql += "select * from v_pwemployee where pwgroup in ('M','D') and pwstatwork = 'Y' and LENGTH(TRIM(pwemployee)) = 6 and ";
            sql += "trunc(sysdate - to_date(pwretrydate,'YYYY-MM-DD')) < 90   order by 1 ";

            conn = ConnectDB.getConnectionhr();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                if (rs.getString("PWEMPLOYEE").length() == 6 && !rs.getString("PWEMPLOYEE").equals("")) {
                    GT_User user = new GT_User();
                    user.setPWEMPLOYEE(rs.getString("PWEMPLOYEE"));
                    user.setPREFIXDESC(rs.getString("PREFIXDESC"));
                    user.setPWFNAME(rs.getString("PWFNAME"));
                    user.setPWLNAME(rs.getString("PWLNAME"));
                    user.setPWDIVISION(rs.getString("PWDIVISION"));
                    user.setPWDIVDESC(rs.getString("PWDIVDESC"));
                    user.setPWSECTION(rs.getString("PWSECTION"));
                    user.setPWSECTDESC(rs.getString("PWSECTDESC"));
                    user.setPWDEPT(rs.getString("PWDEPT"));
                    user.setPWDEPTDESC(rs.getString("PWDEPTDESC"));
                    user.setPWUNIT(rs.getString("PWUNIT"));
                    user.setPWUNITDESC(rs.getString("PWUNITDESC"));
                    user.setPWSTATWORK(rs.getString("PWSTATWORK"));
                    user.setPWPOSIDESC(rs.getString("PWPOSIDESC"));
                    user.setPWGROUP(rs.getString("PWGROUP"));
                    user.setPWTIME0(rs.getString("PWTIME0"));
                    user.setPWTIME0DESC(rs.getString("PWTIME0DESC"));
                    user.setPWHOUR_D(rs.getString("PWHOUR_D"));
                    user.setPWSALATYPE(rs.getString("PWSALATYPE"));
                    user.setPWSALARYLST(rs.getString("PWSALARYLST"));
                    user.setPWCOMPANY(rs.getString("PWCOMPANY"));
                    user.setPWSTARTDATE(rs.getString("PWSTARTDATE"));
                    user.setPWCOST(rs.getString("PWCOST"));
                    user.setPWRETRYDATE(rs.getString("PWRETRYDATE"));
                    user.setPWVACATION0(rs.getString("PWVACATION0"));
                    user.setPWVACATION1(rs.getString("PWVACATION1"));
                    user.setPWIDCARD(rs.getString("PWIDCARD"));
                    user.setPWSEX(rs.getString("PWSEX"));
                    user.setPWPOSITION(rs.getString("PWPOSITION"));
                    user.setPWBIRTHDAY(rs.getString("PWBIRTHDAY"));
                    user.setPREFIXEDESC(rs.getString("PREFIXEDESC"));
                    user.setPWEFNAME(rs.getString("PWEFNAME"));
                    user.setPWELNAME(rs.getString("PWELNAME"));
                    user.setPWEMAIL(rs.getString("PWEMAIL"));
                    user.setPWTELNO(rs.getString("PWTELNO"));
                    user.setPWMOBILE(rs.getString("PWMOBILE"));
                    user.setPWJOB(rs.getString("PWJOB"));
                    listuser.add(user);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }

        return listuser;

    }

    public static Boolean deleteuserallincut1() throws SQLException {
        Boolean status = false;
        try {

            String sql = "TRUNCATE TABLE V_PWEMPLOYEE";

            conn = ConnectDB.getConnectioncut1();
            ps = conn.prepareStatement(sql);

            if (ps.executeUpdate() > 0) {
                status = true;
            } else {
                status = false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
        }

        return status;

    }

    public static int getcountuserallincut1() throws SQLException {
        int total = 0;
        try {

            String sql = "select conut(*) as total FROM v_pwemployee";

            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                total = rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
        }

        return total;

    }

    public static Boolean delwf_boos1() throws SQLException {
        Boolean status = false;
        try {

            String sql = "delete from wf_boss where boss1 in(select distinct boss1 as userid from wf_boss  where  boss1 not in(select pwemployee from v_pwemployee))";

            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);

            if (ps.executeUpdate() > 0) {
                status = true;
            } else {
                status = false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
        }

        return status;

    }

    public static Boolean delwf_boos2() throws SQLException {
        Boolean status = false;
        try {

            String sql = "delete from wf_boss where boss2 in(select distinct boss2 as userid from wf_boss  where  boss2 not in(select pwemployee from v_pwemployee))";

            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);

            if (ps.executeUpdate() > 0) {
                status = true;
            } else {
                status = false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
        }

        return status;

    }

    public static Boolean delwf_boos3() throws SQLException {
        Boolean status = false;
        try {

            String sql = "delete from wf_boss where boss3 in(select distinct boss3 as userid from wf_boss  where  boss3 not in(select pwemployee from v_pwemployee))";

            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);

            if (ps.executeUpdate() > 0) {
                status = true;
            } else {
                status = false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
        }

        return status;

    }

    public static Boolean insertuserallincut1(List<GT_User> list) throws SQLException {
        Boolean status = false;
        try {
            String today = Utility.getdatetoday();

            String sql = "INSERT INTO V_PWEMPLOYEE (";
            sql += "PWEMPLOYEE, PREFIXDESC, PWFNAME,";
            sql += "PWLNAME, PWDIVISION, PWDIVDESC,";
            sql += "PWSECTION, PWSECTDESC, PWDEPT,";
            sql += "PWDEPTDESC, PWUNIT, PWUNITDESC,";
            sql += "PWSTATWORK, PWPOSIDESC, PWGROUP,";
            sql += "PWTIME0, PWTIME0DESC, PWHOUR_D,";
            sql += "PWSALATYPE, PWSALARYLST, PWCOMPANY,";
            sql += "PWSTARTDATE, PWCOST, PWRETRYDATE,";
            sql += "PWVACATION0, PWVACATION1, PWIDCARD,";
            sql += "PWSEX, PWPOSITION, CREATEDATE)";
            sql += "VALUES ( ?, ?, ?,";
            sql += "?, ?, ?,";
            sql += "?, ?, ?,";
            sql += "?, ?, ?,";
            sql += "?, ?, ?,";
            sql += "?, ?, ?,";
            sql += "?, ?, ?,";
            sql += "?, ?, ?,";
            sql += "?, ?, ?,";
            sql += "?, ?,TO_DATE(?, 'YYYY/MM/DD HH24:MI:SS'))";

            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);

            for (GT_User l : list) {

                ps.setString(1, l.getPWEMPLOYEE());
                ps.setString(2, l.getPREFIXDESC());
                ps.setString(3, l.getPWFNAME());

                ps.setString(4, l.getPWLNAME());
                ps.setString(5, l.getPWDIVISION());
                ps.setString(6, l.getPWDIVDESC());

                ps.setString(7, l.getPWSECTION());
                ps.setString(8, l.getPWSECTDESC());
                ps.setString(9, l.getPWDEPT());

                ps.setString(10, l.getPWDEPTDESC());
                ps.setString(11, l.getPWUNIT());
                ps.setString(12, l.getPWUNITDESC());

                ps.setString(13, l.getPWSTATWORK());
                ps.setString(14, l.getPWPOSIDESC());
                ps.setString(15, l.getPWGROUP());

                ps.setString(16, l.getPWTIME0());
                ps.setString(17, l.getPWTIME0DESC());
                ps.setString(18, l.getPWHOUR_D());

                ps.setString(19, l.getPWSALATYPE());
                ps.setString(20, l.getPWSALARYLST());
                ps.setString(21, l.getPWCOMPANY());

                ps.setString(22, l.getPWSTARTDATE());
                ps.setString(23, l.getPWCOST());
                ps.setString(24, l.getPWRETRYDATE());

                ps.setString(25, l.getPWVACATION0());
                ps.setString(26, l.getPWVACATION1());
                ps.setString(27, l.getPWIDCARD());

                ps.setString(28, l.getPWSEX());
                ps.setString(29, l.getPWPOSITION());
                ps.setString(30, today);


                ps.addBatch();
            }
            ps.executeBatch();
            status = true;
        } catch (Exception e) {
            status = false;
            e.printStackTrace();
        } finally {
            ps.close();
            ConnectDB.closeConnection(conn);
        }

        return status;

    }
}
