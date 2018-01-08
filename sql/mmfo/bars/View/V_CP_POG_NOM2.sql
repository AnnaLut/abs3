create or replace view V_CP_POG_NOM2 as 
select pp.*,    CASE  WHEN pp.OSTC <> pp.OSTB  THEN 'план.зал НОМ НЕ=факт.зал'
                      WHEN pp.OSTR <> 0        THEN 'зал купона НЕ=0'      
                      WHEN pp.NLSG is null     THEN 'Відсут.сист.рах.номиналу'      
                      ELSE                           NULL
                END   ERR ,
       div0( pp.OSTC, pp.CENA)  KOL, 
       to_number (pul.GEt('CP_NOM'))/100 * div0( pp.OSTC, pp.CENA)       SUM_NOM
from ( select (select -nvl(sum(ostb),0) from accounts where acc in (d.accR,d.accR2)) OSTR, 
             (select nls from accounts where acc = a.accc)                          NLSG,  
             (select substr(nms,1,38) from accounts where acc = a.accc)             NMSG,
              d.REF, a.NLS,  -a.ostc/100 OSTC, -a.ostb/100 OSTB,  o.ND, o.DATD, x.STR_REF,
              k.CENA
        -- Into :FA8.OSTR, :FA8.NLSG, :FA8.NMSG,:FA8.REF,  :FA8.NLS,       :FA8.OSTC, :FA8.OSTB, :FA8.ND,  :FA8.DATD, :FA8.STR_REF 
       from cp_kod k, cp_deal d, accounts a, oper o, CP_ARCH x 
       where k.id = to_number (pul.GEt('CP_ID')) and k.id = d.id and d.acc  =  a.acc and d.ref = o.ref (+) and d.DAZS is null  and a.ostc<0   and d.ref = x.ref (+)
) pp ;

grant select  on bars.V_CP_POG_NOM2   TO BARS_ACCESS_DEFROLE;
-----------------------------------

