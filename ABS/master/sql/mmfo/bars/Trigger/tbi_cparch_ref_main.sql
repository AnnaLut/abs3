

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CPARCH_REF_MAIN.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CPARCH_REF_MAIN ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CPARCH_REF_MAIN before insert
  on cp_ARCH  for each row
begin
  begin
      select d.ref, k.cena 
      into  :new.ref_main, :new.nom
      from  opldok o, cp_deal d, cp_kod k
      where d.id  = :new.id and d.id = k.id  and o.ref = :new.ref 
        and  o.acc in ( d.acc, nvl(d.accd, d.acc) , nvl(d.accp, d.acc) , nvl(d.accs, d.acc) ,     
                               nvl(d.accr, d.acc) , nvl(d.accr2, d.acc)
                       )    and rownum=1;                  
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end ;

end tbi_cpARCH_REF_MAIN ;


/
ALTER TRIGGER BARS.TBI_CPARCH_REF_MAIN DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CPARCH_REF_MAIN.sql =========***
PROMPT ===================================================================================== 
