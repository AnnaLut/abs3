

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_SWIMTICURR.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_SWIMTICURR ***

  CREATE OR REPLACE TRIGGER BARS.TAI_SWIMTICURR after insert ON BARS.SWI_MTI_CURR for each row
declare   ll SWI_MTI_LIST%rowtype;
begin
   select * into ll from SWI_MTI_LIST where num =:new.num;
   FOR  M IN ( SELECT * FROM MV_KF)
   LOOP BC.GO (M.kf) ;
        for k in (select p.branch from BRANCH_PARAMETERS p inner join BRANCH b on b.BRANCH = p.BRANCH where p.tag ='SWI' and p.val='1' and b.DATE_CLOSED is null)
        loop       --grishkovmv@oschadbank.ua (Mastercard Moneysend не предусмотрено открытие ОБ22 для 2809)
           if ll.OB22_2809 is not null then
              MONEX_RU.op_NLSM ( p_nbs =>'2809',  p_ob22 => ll.OB22_2809,  p_branch => k.branch, p_kv => :new.kv );
           end if;
           MONEX_RU.op_NLSM ( p_nbs =>'2909',  p_ob22 => ll.OB22_2909,  p_branch => k.branch, p_kv => :new.kv );
        end loop ; -- K
   END LOOP ; -- M
   BC.GO ( '/') ;
end TAI_SWIMTICURR;
/
ALTER TRIGGER BARS.TAI_SWIMTICURR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_SWIMTICURR.sql =========*** End 
PROMPT ===================================================================================== 
