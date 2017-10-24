

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FOR_2909_66.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FOR_2909_66 ***

  CREATE OR REPLACE PROCEDURE BARS.FOR_2909_66 
( NBS_  accounts.nbs%type ,
  OB22_ accounts.ob22%type,
  tip_  accounts.tip%type ,
  name_ tips.name%type )
  is
/*
 NBS_  := '2909';
 OB22_ := '66'  ;
 tip_  tips.tip%type       := 'NLR';
 name_ tips.name%type      := 'NLR Родовiд 2909/66';
 -- D:\_rodovid\sql\3_ru.sql   Исп. Сухова Т.А.  - Откр.счетов 2909/66 для Бранч-3
*/
 nTmp_ int;
 l_branch accounts.branch%type;
 l_dazs   accounts.dazs%type  ;
 l_ob22   accounts.ob22%type  ;
 l_acc    accounts.acc%type   ;
 l_rnk    accounts.rnk%type   ;
 l_isp    accounts.isp%type   ;
 l_grp    accounts.grp%type   ;
 l_nls    accounts.nls%type   ;
 l_tip    accounts.tip%type   ;
 l_nms    accounts.nms%type   := 'кошти на виплату По Родовiд банку';
begin

  suda;
  update TIPS set name = name_ where tip = tip_;
  if SQL%rowcount = 0 then
     Insert into TIPS (TIP, NAME, ORD) Values (tip_, name_, 701);
  end if;
  ------
  tuda;
  for k in ( select * from branch where length(branch) = 22
  -- and substr( branch,1,15) in ( '/MMMMMM/BBBBBB/' , '/MMMMMM/BBBBBB/' )
  )
  loop
     -- найти РНК бранча
     begin
        select to_number(val) into L_RNK from BRANCH_PARAMETERS
        where tag='RNK' and branch=k.BRANCH;
     EXCEPTION WHEN NO_DATA_FOUND THEN  L_RNK := 1 ;
     end;
     -- найти исполнителя для сч
     begin
        select to_number(val) into L_ISP from BRANCH_PARAMETERS
        where tag='AVTO_ISP' and branch=k.BRANCH;
     EXCEPTION WHEN NO_DATA_FOUND THEN     L_ISP := 20094;
     end;

     l_GRP := 15;
     l_nls := '2909006600'|| substr(substr(k.branch,-4),1,3)  ;
     l_NLS  := vkrzn ( substr(gl.aMFO,1,5), l_NLS );

     for v in (select kv from tabval where kv in (980,840,978))
     loop
        begin
          select acc, dazs, branch, ob22, tip into l_acc, l_dazs, l_branch, l_ob22, l_tip
          from accounts
          where  kv=v.kv and nls = l_nls;

          If l_dazs is null or l_branch <> k.branch or l_tip <> TIP_ then
             update accounts set dazs = null, tobo =k.branch, tip= TIP_ where acc= l_ACC;
          end if;

          If l_ob22 <> ob22_ then
             update specparam_int set ob22= OB22_ where acc = l_ACC;
             if SQL%rowcount = 0 then
                Insert into specparam_int (acc, ob22) Values (l_acc, ob22_);
             end if;
          end if;
        EXCEPTION WHEN NO_DATA_FOUND THEN
          op_reg (99,0,0,L_GRP,nTmp_,L_RNK, l_NLS,v.kv,l_NMS,TIP_,L_isp,l_ACC);
          update accounts set tobo = k.branch where acc=l_ACC;
          insert into specparam_int (acc, ob22) values (l_ACC,OB22_);
        end;
    end loop; -- v
  end loop; -- k

  commit;

end for_2909_66;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FOR_2909_66.sql =========*** End *
PROMPT ===================================================================================== 
