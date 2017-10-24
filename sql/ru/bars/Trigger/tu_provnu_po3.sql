

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_PROVNU_PO3.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_PROVNU_PO3 ***

  CREATE OR REPLACE TRIGGER BARS.TU_PROVNU_PO3 
   instead of update
   on bars.provnu_po3
   for each row
declare
    c_bak_ref  constant number := -to_number(gl.kf);
begin
   if :old.otm = bitand (nvl (:old.otm, 0), 253) + 2 and :new.otm = 0
   then
      update opldok
         set otm = 0                                    --bitand(otm,15*16+12)
       where ref = :old.ref and stmt = :old.stmt;
   elsif :old.otm = bitand (nvl (:old.otm, 0), 254) + 1 and :new.otm = 0
   then
      begin

         update opldok
            set otm = 0
          where ref = :old.ref and stmt = :old.stmt and tt <> 'PO3';

         delete from oper_visa
               where groupid in (80, 81) and ref = :old.ref;

         update opldok
            set ref = c_bak_ref
          where ref = :old.ref
                and stmt in (select stmt
                               from opldok
                              where ref = :old.ref and tt = 'PO3');

         --delete from oper_ext
         -- where ref=c_bak_ref;
         update oper
            set sos = 5
          where ref = c_bak_ref;

         --delete from oper_ext
         -- where ref=c_bak_ref;
         ful_bak (c_bak_ref);
      end;
   end if;
end;
/
ALTER TRIGGER BARS.TU_PROVNU_PO3 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_PROVNU_PO3.sql =========*** End *
PROMPT ===================================================================================== 
