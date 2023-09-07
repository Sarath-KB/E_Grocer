<%-- 
    Document   : GenerateSlots
    Created on : May 6, 2021, 6:31:51 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet" %>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Generating Slots</title>
    </head>
    <body>
        <%
            if(request.getParameter("gen")!=null){
                
                String sel = "select * from tbl_slotbundle where sb_id='"+request.getParameter("gen")+"'";
                ResultSet rs = con.selectCommand(sel);
                
                int shh, ths, thc, chh, dhh, smm, tms,tmc, cmm, dmm, tmm, dur, brk;
                int slots, nos, flag;
            
                //Calculation of duration the shop remains open & number of such intervals needed
                if(rs.next()){
                String starting = rs.getString("sb_starttime");
                shh = Integer.parseInt(starting.substring(0,2));
                smm = Integer.parseInt(starting.substring(3,5));
                
                String end = rs.getString("sb_endtime");
                chh = Integer.parseInt(end.substring(0,2));
                cmm = Integer.parseInt(end.substring(3,5));
                
                dur = Integer.parseInt(rs.getString("sb_lifetime"));
                brk = Integer.parseInt(rs.getString("sb_break"));
                String date = rs.getString("sb_date");
                nos = Integer.parseInt(rs.getString("sb_totalslots"));
                dhh = chh - shh;
                
                if((cmm - smm) == 0){
                    dmm = 0;
                }else if((cmm - smm) > 0){
                    dmm = cmm - smm;
                }else{
                    dmm = 60 + (cmm - smm);
                    dhh = dhh - 1;
                }
                
                tmm = dhh * 60;
                dmm += tmm;
                slots = dmm / (dur + brk);
                flag = 0;
                if(dmm % (dur + brk) > 15){
                    flag = 1;
                }
                        
                //Setting up of intervals and slots within them
                ths = thc = shh;
                tms = tmc = smm;
                
                for(int i = 0; i<slots; i++){//setting up of individual interval with user-defined no: of slots within it
                    tmc += dur;
                    while(tmc >= 60){
                        thc += 1;
                        tmc -= 60;
                    }
                    String hs = String.valueOf(ths);
                    String ms = String.valueOf(tms);
                    if(ths<10){
                        hs='0'+hs;
                    }
                    if(tms<10){
                        ms='0'+ms;
                    }
                    String stime = hs+':'+ms;
                    String hc = String.valueOf(thc);
                    String mc = String.valueOf(tmc);
                    if(thc<10){
                        hc='0'+hc;
                    }
                    if(tmc<10){
                        mc='0'+mc;
                    }
                    String etime = hc+':'+mc;
                    out.println(date);
                    out.println(stime);
                    out.println(etime);
                    for(int j = 0; j < nos; j++){//setting up of individual slot upto user-defined nos within the current interval
                        String ins = "insert into tbl_slot (sb_id,slot_date,slot_starttime,slot_endtime) "
                                   + "values('" + request.getParameter("gen") + "',"
                                   + "'" +date + "',"
                                   + "'" + stime+ "',"
                                   + "'" + etime + "')";
                        out.println(ins);
                        con.executeCommand(ins);
                    }
                    ths = thc;
                    tms = tmc = (tmc + brk);
                    if(tmc >= 60){
                        ths = thc = (thc + 1);
                        tms = tmc = (tmc % 60);
                    }
                }
                if(flag==1){
                    String hs = String.valueOf(ths);
                    String ms = String.valueOf(tms);
                    if(ths<10){
                        hs='0'+hs;
                    }
                    if(tms<10){
                        ms='0'+ms;
                    }
                    String stime = hs+':'+ms;
                    out.println(date);
                    out.println(stime);
                    out.println(end);
                    for(int j = 0; j < nos; j++){//setting up of individual slot upto user-defined nos within the current interval
                        String ins1 = "insert into tbl_slot (sb_id,slot_date,slot_starttime,slot_endtime) "
                                   + "values('" + request.getParameter("gen") + "',"
                                   + "'" + date + "',"
                                   + "'" + stime + "',"
                                   + "'" + end + "')";
                        out.println(ins1);
                        con.executeCommand(ins1);
                    }
                }
                String upd = "update tbl_slotbundle set sb_generateslot = 1 where sb_id = '" + request.getParameter("gen") + "'";
                con.executeCommand(upd);
                out.println(upd);
                }
            }
            response.sendRedirect("SetSlotBundle.jsp");
        %>        
    </body>
</html>
