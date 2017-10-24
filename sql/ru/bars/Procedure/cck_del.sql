

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CCK_DEL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CCK_DEL ***

  CREATE OR REPLACE PROCEDURE BARS.CCK_DEL ( BRANCH_ varchar2)  IS
begin
  bc.subst_mfo( substr(BRANCH_,2,6) );

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

  update test_D5 set ls_alt=null ;
  delete from TEST_PROT_CCK where branch=BRANCH_;
  commit;
end CCK_del;
/
show err;

PROMPT *** Create  grants  CCK_DEL ***
grant EXECUTE                                                                on CCK_DEL         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_DEL.sql =========*** End *** =
PROMPT ===================================================================================== 
