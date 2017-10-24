

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SG_3739.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SG_3739 ***

  CREATE OR REPLACE PROCEDURE BARS.SG_3739 ( BRANCH_ varchar2, DAT_ date)
IS
-- Авто-открытие счетов гашения
  NLS_    accounts.NLS%type;
  ACC_    accounts.ACC%type;
  OSTC_   accounts.OSTC%type;
--  BRANCH_ accounts.BRANCH%type :='/333368/';
--  DAT_ date := to_date('03-02-2009','dd-mm-yyyy') ;
  SPN_GRP  accounts.NLS%type;
  COM_GRP  PARAMS$BASE.comm%type := 'КП: Гл.рах. для погаш кредиту готiвкою';

begin

  bars_context.subst_branch(branch_);

for k in (select d.branch, d.nd, a.KV, a.ISP, a.grp, a.nls, d.wdate, a.accc
          from cc_deal d, nd_acc n, accounts a
          where d.sos<15 and n.nd=d.nd and a.tip='SS ' and a.acc=n.acc
            and d.vidd in (11,12,13)
            --and d.vidd in (1,2,3,11,12,13)
            and a.accc is not null
            and a.daos < DAT_
          )
loop
   select ostc into OSTC_ from accounts where acc=k.ACCC;
   If OSTC_<0 then
      
      NLS_:= VKRZN(substr(gl.aMFO,1,5),'37390'||substr(k.nls,6,9) );
              --  r_s36.nls := vkrzn( substr(gl.amfo,1,5) , '36000'|| substr( r_sdi.nls,6,9) );
       --  select f_newnls2(k.ACC,'SG ',null,null,k.KV)  INTO NLS_ from dual;
       
      --NLS_:= f_newnls2(k.ACC,'SG ',null,null,null,k.KV);
                 
      cck.cc_op_nls( k.ND, k.KV, NLS_, 'SG ', k.ISP, k.GRP,'1',k.wdate, ACC_);
      If BRANCH_ <> k.BRANCH then
         update accounts set tobo=k.BRANCH where acc=ACC_;
      end if;
   end if;
end loop;
  commit;

  bc.set_context;

end SG_3739;
/
show err;

PROMPT *** Create  grants  SG_3739 ***
grant EXECUTE                                                                on SG_3739         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SG_3739.sql =========*** End *** =
PROMPT ===================================================================================== 
