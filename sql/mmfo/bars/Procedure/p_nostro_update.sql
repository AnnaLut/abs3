

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NOSTRO_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NOSTRO_UPDATE ***

  CREATE OR REPLACE PROCEDURE BARS.P_NOSTRO_UPDATE 
( P_Nd number, 
  P_FIN23 integer default null, 
  P_OBS23 integer default null, 
  P_KAT23 integer default null, 
  P_K23 number  default null, 
  P_BRANCH varchar2  default null
)
  is
 l_FIN23 cc_deal.FIN23%type;
 l_OBS23 cc_deal.OBS23%type;
 l_KAT23 cc_deal.KAT23%type;
 l_K23 cc_deal.K23%type; 
 l_BRANCH cc_deal.BRANCH%type; 
 
begin

     if P_FIN23 is not null then
     update cc_deal set FIN23 = P_FIN23 where nd = P_Nd;
     end if;
     
     if P_OBS23 is not null then
     update cc_deal set OBS23 = P_OBS23 where nd = P_Nd;
     end if;
     
     if P_KAT23 is not null then
     update cc_deal set KAT23 = P_KAT23 where nd = P_Nd;
     end if;
     
          
     if P_K23 is not null then
     update cc_deal set K23 = P_K23 where nd = P_Nd;
     end if;
     
     if P_BRANCH is not null then
     update cc_deal set BRANCH = P_BRANCH where nd = P_Nd;
     end if;     
end;
/
show err;

PROMPT *** Create  grants  P_NOSTRO_UPDATE ***
grant EXECUTE                                                                on P_NOSTRO_UPDATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NOSTRO_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
