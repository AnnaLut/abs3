

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_MMFO_APPO_PSYCHO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_MMFO_APPO_PSYCHO ***

  CREATE OR REPLACE PROCEDURE BARS.P_MMFO_APPO_PSYCHO is
begin

 bc.go('300465');
 update sw_journal set id=null where vdate>=trunc(sysdate)-5 and id=0;
 
 commit;
    /*
   bc.go('300465');
     
    UPDATE ree_tmp r
       SET r.odat =
              (SELECT a.daos
                 FROM accounts a
                WHERE r.nls = a.nls AND a.nbs IS NOT NULL and r.kv = a.kv)
     WHERE r.odat IS NULL;

 
 commit;
 
  bc.go('322669');
     
    UPDATE ree_tmp r
       SET r.odat =
              (SELECT a.daos
                 FROM accounts a
                WHERE r.nls = a.nls AND a.nbs IS NOT NULL and r.kv = a.kv)
     WHERE r.odat IS NULL;


 commit; */
end;
/
show err;

PROMPT *** Create  grants  P_MMFO_APPO_PSYCHO ***
grant EXECUTE                                                                on P_MMFO_APPO_PSYCHO to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_MMFO_APPO_PSYCHO.sql =========**
PROMPT ===================================================================================== 
