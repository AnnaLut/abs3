

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_W4_ARC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_W4_ARC ***

  CREATE OR REPLACE PROCEDURE BARS.P_W4_ARC IS
begin
   z23.to_log_rez (user_id , 40 , trunc(sysdate,'MM') ,'НАЧАЛО - Архив по карточкам (BPK_ACC, W4_ACC)');

   begin
      execute immediate 'create table tmp_w4_ACC_ARC as select * from W4_acc where NOT_USE_REZ23 is null';
   exception when others then
      if sqlcode in (-00955) then --name is already used by an existing object
         execute immediate 'truncate table bars.tmp_w4_ACC_ARC drop storage';
         execute immediate 'insert into tmp_w4_ACC_ARC select * from W4_acc where NOT_USE_REZ23 is null';
         commit;
         null;
      else
         raise;
      end if;
   end ;

   begin
      execute immediate 'create table tmp_bpk_ACC_ARC as select * from bpk_acc WHERE dat_end IS NULL';
   exception when others then
      if sqlcode in (-00955) then --name is already used by an existing object
         execute immediate 'truncate table bars.tmp_bpk_ACC_ARC drop storage';
         execute immediate ' insert into tmp_bpk_ACC_ARC select * from bpk_acc WHERE dat_end IS NULL';
         commit;
         null;
      else
         raise;
      end if;
   end;

   begin
      execute immediate 'CREATE OR REPLACE FORCE VIEW BARS.V_W4_acc as select * from tmp_w4_ACC_ARC';
      execute immediate 'GRANT SELECT ON BARS.V_W4_acc TO BARS_ACCESS_DEFROLE';
      execute immediate 'GRANT SELECT ON BARS.V_W4_acc TO START1';
   exception when others then null;
   end;

   begin
      execute immediate 'CREATE OR REPLACE FORCE VIEW BARS.V_bbpk_acc as select * from tmp_bpk_ACC_ARC';
      execute immediate 'GRANT SELECT ON BARS.V_bbpk_acc TO BARS_ACCESS_DEFROLE';
      execute immediate 'GRANT SELECT ON BARS.V_bbpk_acc TO START1';
   exception when others then null;
   end;
   z23.to_log_rez (user_id ,-40 , trunc(sysdate,'MM') ,'КОНЕЦ - Архив по карточкам (BPK_ACC, W4_ACC)');
end;
/
show err;

PROMPT *** Create  grants  P_W4_ARC ***
grant EXECUTE                                                                on P_W4_ARC        to BARSUPL;
grant EXECUTE                                                                on P_W4_ARC        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_W4_ARC        to START1;
grant EXECUTE                                                                on P_W4_ARC        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_W4_ARC.sql =========*** End *** 
PROMPT ===================================================================================== 
