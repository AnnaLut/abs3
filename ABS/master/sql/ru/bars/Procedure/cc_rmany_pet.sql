

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_RMANY_PET.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_RMANY_PET ***

  CREATE OR REPLACE PROCEDURE BARS.CC_RMANY_PET 
(ND_   int,
  DAT_ date,
  MODE_ int
) is
  DAT_A date;
begin

  DAT_A:=DAT_;
  begin
  while true
  loop
    select holiday
      into DAT_A
      from holiday
     where kv=980 and  holiday=(DAT_A+1) and
           to_number(to_char((DAT_A+1),'dd'))>to_number(to_char((DAT_A),'dd'));
  end loop;
  exception when no_data_found then
  null;
  end;
  --dbms_output.put_line (DAT_A);
  cc_rmany (nd_,DAT_A,mode_);
end;
/
show err;

PROMPT *** Create  grants  CC_RMANY_PET ***
grant EXECUTE                                                                on CC_RMANY_PET    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_RMANY_PET    to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_RMANY_PET.sql =========*** End 
PROMPT ===================================================================================== 
