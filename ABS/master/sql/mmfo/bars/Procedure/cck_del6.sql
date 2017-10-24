

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CCK_DEL6.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CCK_DEL6 ***

  CREATE OR REPLACE PROCEDURE BARS.CCK_DEL6 ( BRANCH_ varchar2)  IS
 KF_ accounts.KF%type := substr(BRANCH_,2,6) ;

begin
  bc.subst_mfo( KF_ );

  for k in (select nd from cc_deal where branch=BRANCH_)
  loop
    delete from cc_lim  where nd=k.ND;
    delete from cc_many where nd=k.ND;
    delete from cc_sob  where nd=k.ND;
    delete from cc_add  where nd=k.ND;
    delete from nd_acc  where nd=k.ND;
    delete from nd_txt  where nd=k.ND;
    delete from cc_prol where nd=k.ND;
    delete from cc_deal where nd=k.ND;
  end loop;

  delete from TEST_PROT_CCK where branch=BRANCH_;

  update "S6_Credit_NLS"  s6
    set s6.bic=KF_
   where s6."Type"=1 and exists
     (select 1 from accounts
      where substr(NLS,1,4)||substr(NLS,6,9)=s6.nls and branch=BRANCH_);

  commit;
end CCK_del6;
/
show err;

PROMPT *** Create  grants  CCK_DEL6 ***
grant EXECUTE                                                                on CCK_DEL6        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_DEL6.sql =========*** End *** 
PROMPT ===================================================================================== 
