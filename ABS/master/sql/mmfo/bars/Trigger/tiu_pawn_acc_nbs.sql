

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_PAWN_ACC_NBS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_PAWN_ACC_NBS ***

  CREATE OR REPLACE TRIGGER BARS.TIU_PAWN_ACC_NBS 
before insert or update of pawn ON BARS.PAWN_ACC for each row
DECLARE
    nbs_   accounts.nbs%TYPE;
    nbsa_  accounts.nbs%TYPE;
    l_msg  varchar2(4000);

begin

  begin
    select nbsz into nbs_ from cc_pawn where pawn=:new.pawn;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    l_msg := 'Ќет такого вида залога '||chr(10)||dbms_utility.format_call_stack;
    bars_audit.error(l_msg);
    raise_application_error(-20000, l_msg, true);
  end;

  begin
    select nbs into nbsa_ from accounts where acc=:new.acc;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    l_msg := 'Ќет такого счета залога '||chr(10)||dbms_utility.format_call_stack;
    bars_audit.error(l_msg);
    raise_application_error(-20000, l_msg, true);
  end;

  if ( nbs_<>nbsa_ and substr(nbsa_,1,3) <>'207' ) then -- кроме финансового лизинга
     begin
       l_msg := 'Ќе соответствие вида залога и бал.счета'
       ||chr(10)||dbms_utility.format_call_stack;
       bars_audit.error(l_msg);
       raise_application_error(-20000, l_msg, true);
     end;
  end if;

end tiu_pawn_acc_nbs;



/
ALTER TRIGGER BARS.TIU_PAWN_ACC_NBS DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_PAWN_ACC_NBS.sql =========*** En
PROMPT ===================================================================================== 
