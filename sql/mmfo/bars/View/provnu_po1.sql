

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROVNU_PO1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view PROVNU_PO1 ***

  CREATE OR REPLACE FORCE VIEW BARS.PROVNU_PO1 ("REF", "FDAT", "SOS", "NLSD", "NLSK", "S", "NAZN", "USERID") AS 
  select p.ref,l.fdat,p.sos,p.nlsa,p.nlsb,p.s,p.nazn,p.userid
from (select o.ref,o.sos,o.nlsa,o.nlsb,o.s,o.nazn,o.userid
      from oper o
      where o.tt='PO1' and o.sos =5 and  exists
           (select ref  from opldok
                   where ref=o.ref  and fdat>=gl.bd-10
                    and tt='PO1' and sos =5)) p,
           (select ref,fdat from opldok
                   where tt='PO1' and sos =5 and fdat>=gl.bd-10) l
where l.ref=p.ref
union all        -- для того чтобы работал триггер instead...
select null,null,null,null,null, null,null,null from dk where dk=0
minus
select null,null,null,null,null, null,null,null from dk where dk=0
 ;

PROMPT *** Create  grants  PROVNU_PO1 ***
grant SELECT,UPDATE                                                          on PROVNU_PO1      to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on PROVNU_PO1      to NALOG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROVNU_PO1.sql =========*** End *** ===
PROMPT ===================================================================================== 
