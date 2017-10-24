

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/UPD_OB22.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure UPD_OB22 ***

  CREATE OR REPLACE PROCEDURE BARS.UPD_OB22 ( p_otm int,  p_nd number)  is

/*
ЗАЯВКА АТ "Ощадбанк"  Департамент інформатизації
27.11.2014 р. № 14/1-537     ID:2380
Генеральному директору ТОВ "УНІТІ-БАРС"           Кондакову В.М.
*/

  like2_ varchar2(7) := '220256%' ; like3_ varchar2(7) := '220346%' ;
  dd cc_deal%rowtype ;  oo cck_ob22%rowtype ;  o6 accounts%rowtype  ;  n6 accounts%rowtype ;
  l_nbs char(4)      ;  l_ob  char(2)       ;  l_sob varchar2(100)  ;
begin
  if nvl(p_otm,0) <> 1 then return; end if  ;
  -------------------------------------------
  begin select * into dd from cc_deal   where nd = p_nd and sos < 14  and ( prod like like2_ or prod like like3_);
        If dd.prod like like2_ then l_nbs := '2202' ;   l_ob := '57';
        else                        l_nbs := '2203' ;   l_ob := '47';
        end if;
        update cc_deal set prod = l_nbs|| l_ob || substr (dd.prod,7,25) where nd = p_nd ;
        select * into oo from cck_ob22  where nbs = l_nbs and ob22= l_ob ;
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN ;
  end;
  --------------------------------
  for k in (select * from accounts where acc in (select acc from nd_acc where nd=p_nd) and rnk=dd.rnk and tip in ('SS ','SPI','SDI','SP ','SN ','SPN' )  )
  loop     l_ob := null;
       If  k.tip = 'SPI' then l_ob := oo.spi ;
    elsIf  k.tip = 'SDI' then l_ob := oo.sdi ;
    elsIf  k.tip = 'SP ' then l_ob := oo.sp  ;
    elsIf  k.tip = 'SN ' then l_ob := oo.sn  ;
    elsIf  k.tip = 'SPN' then l_ob := oo.spn ;
    elsIf  k.tip = 'SS ' then l_ob := oo.ob22;
       begin select * into o6 from accounts where acc = (select acrb from int_accn where acc=k.acc and id=0);
             OP_BS_OB1 (PP_BRANCH  => o6.branch,  P_BBBOO => o6.nbs || oo.SD_N );
             select * into n6 from accounts where nls = nbs_ob22_null( o6.nbs, oo.SD_N, o6.branch) and kv = 980;
             update int_accn set acrb = n6.acc where acc in (select acc from nd_acc where nd = p_nd ) and acrb = o6.acc;
             --Бухгалтерія сказала що не потрібно перекидати кошти з рахунків доходів старої аналітики!
       EXCEPTION WHEN NO_DATA_FOUND THEN n6.acc := null ;
       end;
--  elsIf  k.tip = 'CR9' then l_ob := oo.cr9 ;
--  elsIf  k.tip = 'SK0' then l_ob := oo.sk0 ;
--  elsIf  k.tip = 'SK9' then l_ob := oo.sk9 ;
--  elsIf  k.tip = 'SG ' then l_ob := oo.sg  ;
    end if;
    If l_ob is not null then update specparam_int set ob22 = l_ob where acc = k.acc ; end if;
  end loop;

/*
'2202', '57', '71', '71', 'E1', 'F5', 'H1', 'G1', 'G1', *'03', '05', '08', '01'
'2203', '47', '72', '72', 'E2', 'F6', 'H2', 'G2', 'G2', *'03', '05', '08', '01'

 NBS  , OB22,  SPI,  SDI,  SP ,  SN , SPN , SD_N, SD_M, * CR9,  SG , S260, ISG
'2202', '56', '69', '69', 'D9', 'F3', 'G9', 'F9', 'F9', *'03', '05', '08', '01'
'2203', '46', '70', '70', 'E0', 'F4', 'H0', 'G0', 'G0',* '03', '05', '08', '01'

*/
end upd_ob22;
/
show err;

PROMPT *** Create  grants  UPD_OB22 ***
grant EXECUTE                                                                on UPD_OB22        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on UPD_OB22        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/UPD_OB22.sql =========*** End *** 
PROMPT ===================================================================================== 
