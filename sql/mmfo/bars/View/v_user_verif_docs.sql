

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_VERIF_DOCS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_VERIF_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_VERIF_DOCS ("CHK", "REF", "ND", "USERID", "NLSA", "MFOB", "NLSB", "SUM", "NAZN", "ID_B", "NEXTVISAGRP") AS 
  select chk, ref, nd, userid, nlsa, mfob, nlsb, s/100, nazn, id_b, nextvisagrp
from oper
where ref in (select ref from ref_que) and sos>=0 and userid<>user_id
order by vdat, ref
 ;

PROMPT *** Create  grants  V_USER_VERIF_DOCS ***
grant SELECT                                                                 on V_USER_VERIF_DOCS to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USER_VERIF_DOCS to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_USER_VERIF_DOCS to WR_VERIFDOC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_VERIF_DOCS.sql =========*** End 
PROMPT ===================================================================================== 
