

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROV35.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view PROV35 ***

  CREATE OR REPLACE FORCE VIEW BARS.PROV35 ("FFF", "KK", "KOL", "OST", "PROC_NAC", "PROC_ZAR", "PROC_ALL") AS 
  select substr(pul.Get_Mas_Ini_Val('FFF'),1,3) FFF     ,
       a.kk                                           ,
       sum(decode(w.tag,'OST_D',1,0))                 ,
       sum(decode(w.tag,'OST_D',to_number(w.value),0)),
       sum(decode(w.tag,'NPR_D',to_number(w.value),0)),
       sum(decode(w.tag,'ZPR_D',to_number(w.value),0)),
       sum(decode(w.tag,'NPR_D',to_number(w.value),0))+
       sum(decode(w.tag,'ZPR_D',to_number(w.value),0))
from   accountsw w,
       (SELECT SUBSTR(nd,1,INSTR(nd,'_')-1) kk,
               acc
        from   dpt_deposit
        where  SUBSTR(nd,INSTR(nd,'_')+1,3)=
               substr(pul.Get_Mas_Ini_Val('FFF'),1,3) AND
               LENGTH(nd)-LENGTH(REPLACE(nd,'_'))>=4  AND
               comments LIKE 'Imported from ASVO6._') a
where  a.acc=w.acc and
       w.tag in ('OST_D','NPR_D','ZPR_D')
group  by a.kk
 ;

PROMPT *** Create  grants  PROV35 ***
grant SELECT                                                                 on PROV35          to BARSREADER_ROLE;
grant SELECT                                                                 on PROV35          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PROV35          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROV35.sql =========*** End *** =======
PROMPT ===================================================================================== 
