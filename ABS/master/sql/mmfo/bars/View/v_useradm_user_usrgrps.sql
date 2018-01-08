

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_USER_USRGRPS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_USER_USRGRPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_USER_USRGRPS ("IDG", "NAME", "SEC_SEL", "SEC_DEB", "SEC_CRE", "APPROVED", "REVOKED", "DISABLED", "SUBSTED", "ADATE1", "ADATE2", "RDATE1", "RDATE2") AS 
  select a.id, a.name,
       sel   usrgrp_sel,
       deb   usrgrp_deb,
       cre   usrgrp_cre,
       c.approved, c.revoked, c.disabled, c.substed,
       c.adate1, c.adate2, c.rdate1, c.rdate2
  from (select b.idg,
               bitand(b.secg, 4)/4                                      sel,
               bitand(b.secg, 2)/2                                      deb,
               bitand(b.secg, 1)                                        cre,
               nvl(b.approve, 0)                                        approved,
               nvl(b.revoked, 0)                                        revoked,
               1-date_is_valid(b.adate1, b.adate2, b.rdate1, b.rdate2)  disabled,
               0                                                        substed,
               b.adate1, b.adate2, b.rdate1, b.rdate2
          from groups_staff b
         where b.idu = sys_context('bars_useradm', 'user_id')
        union all
        select b.idg,
               max(bitand(b.secg, 4)/4) sel,
               max(bitand(b.secg, 2)/2) deb,
               max(bitand(b.secg, 1))   cre,
               1 approved, 0 revoked, 0 disabled, 1 substed,
               null adate1, null adate2, null rdate1, null rdate2
          from groups_staff b, staff_substitute s
         where b.idu=s.id_whom
           and b.idg not in (select idg from groups_staff where idu = s.id_who and approve = 1)
           and s.id_who = sys_context('bars_useradm', 'user_id')
           and b.approve = 1
           and date_is_valid(b.adate1, b.adate2, b.rdate1, b.rdate2)  = 1
           and date_is_valid(s.date_start, s.date_finish, null, null) = 1
        group by b.idg
     ) c, groups a
where a.id=c.idg
 ;

PROMPT *** Create  grants  V_USERADM_USER_USRGRPS ***
grant SELECT                                                                 on V_USERADM_USER_USRGRPS to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_USER_USRGRPS to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USERADM_USER_USRGRPS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_USER_USRGRPS.sql =========***
PROMPT ===================================================================================== 
