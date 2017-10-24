prompt ####################################################################################
prompt ... Вюшки-гляделки  D:\K\MMFO\kwt_2924\Sql\View\ATM_vie.sql 
prompt ..........................................

create or replace view v_ATMREF2 as 
select pul.GET('ATM_NLS') nls, o2.ref REF2, o2.vdat vdat2, o2.nlsa, o2.nlsb, o2.tt, o2.tt||'*'||o2.nazn NAZN2, o2.s/100 s2, to_number(pul.GET('ATM_ACC')) ACC, r2.REF1 
from oper o2, atm_ref2 r2 
where o2.ref = r2.ref2 
  and r2.ref1 =  to_number(pul.GET('ATM_R1')) and o2.sos = 5 ;

grant select  on bars.v_ATMREF2  TO BARS_ACCESS_DEFROLE;
