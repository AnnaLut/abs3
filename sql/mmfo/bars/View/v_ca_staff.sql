

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CA_STAFF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CA_STAFF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CA_STAFF ("DEPT_ID", "DEPT_NAME", "UPR_ID", "UPR_NAME", "OTD_ID", "OTD_NAME", "SECT_ID", "SECT_NAME", "USERID", "FIO") AS 
  SELECT c1.id,
            c1.name,
            c2.id,
            c2.name,
            c3.id,
            c3.name,
            c4.id,
            c4.name,
            c0.userid,
            s.fio
       FROM ca_dept c1,
            ca_upr c2,
            ca_otd c3,
            ca_sect c4,
            ca_staff c0,
            staff$base s,
            dba_users d
      WHERE     d.account_status in ( 'OPEN', 'EXPIRED(GRACE)' )
            AND UPPER (d.username) = UPPER (s.logname)
            AND s.bax = 1
            AND UPPER (d.username) = UPPER (s.logname)
            AND c0.userid = s.id
            AND c0.dept = c1.id(+)
            AND c0.upr = c2.id(+)
            AND c0.otd = c3.id(+)
            AND c0.sect = c4.id(+)
   ORDER BY 1,
            3,
            5,
            7,
            10;

PROMPT *** Create  grants  V_CA_STAFF ***
grant SELECT                                                                 on V_CA_STAFF      to BARSREADER_ROLE;
grant SELECT                                                                 on V_CA_STAFF      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CA_STAFF.sql =========*** End *** ===
PROMPT ===================================================================================== 
