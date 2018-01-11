

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_VISA.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_VISA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_VISA ("GRPID", "GRPID_HEX", "GRPNAME") AS 
  select a.idchk as grpid,
       a.idchk_hex as grpid_hex,
       a.name as grpname
from   chklist a
where  a.idchk in (select b.chkid
                   from   staff_chk b
                   where  b.id = sys_context('bars_global', 'user_id')) and
       a.idchk <> chk.get_selfvisa_grp_id();

PROMPT *** Create  grants  V_USER_VISA ***
grant SELECT                                                                 on V_USER_VISA     to BARSREADER_ROLE;
grant SELECT                                                                 on V_USER_VISA     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USER_VISA     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USER_VISA     to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_USER_VISA     to WR_CHCKINNR_ALL;
grant SELECT                                                                 on V_USER_VISA     to WR_CHCKINNR_CASH;
grant SELECT                                                                 on V_USER_VISA     to WR_CHCKINNR_SELF;
grant SELECT                                                                 on V_USER_VISA     to WR_CHCKINNR_SUBTOBO;
grant SELECT                                                                 on V_USER_VISA     to WR_CHCKINNR_TOBO;
grant SELECT                                                                 on V_USER_VISA     to WR_VERIFDOC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_VISA.sql =========*** End *** ==
PROMPT ===================================================================================== 
