

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_SWIMTICURR.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_SWIMTICURR ***

  CREATE OR REPLACE TRIGGER BARS.TAI_SWIMTICURR after insert ON BARS.SWI_MTI_CURR for each row
declare
   u_branch staff.branch%type;
   ll SWI_MTI_LIST%rowtype;
begin
   u_branch := sys_context('bars_context','user_branch');
   If u_branch ='/' then    TUDA;  end if;

   select * into ll from SWI_MTI_LIST where num =:new.num;

   for k in (select p.branch from BRANCH_PARAMETERS p inner join BRANCH b on b.BRANCH = p.BRANCH where p.tag ='SWI' and p.val='1' and b.DATE_CLOSED is null)
   loop
      --grishkovmv@oschadbank.ua (Mastercard Moneysend не предусмотрено открытие ОБ22 для 2809)
      if ll.OB22_2809 is not null then
      MONEX_RU.op_NLSM ( p_nbs =>'2809',  p_ob22 => ll.OB22_2809,  p_branch => k.branch, p_kv => :new.kv );
      end if;
      MONEX_RU.op_NLSM ( p_nbs =>'2909',  p_ob22 => ll.OB22_2909,  p_branch => k.branch, p_kv => :new.kv );
   end loop;

   If u_branch ='/' then   SUDA;   end if;
end TAI_SWIMTICURR;
/
ALTER TRIGGER BARS.TAI_SWIMTICURR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_SWIMTICURR.sql =========*** End 
PROMPT ===================================================================================== 
