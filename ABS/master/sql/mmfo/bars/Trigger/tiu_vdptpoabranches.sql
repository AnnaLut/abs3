

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_VDPTPOABRANCHES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_VDPTPOABRANCHES ***

  CREATE OR REPLACE TRIGGER BARS.TIU_VDPTPOABRANCHES 
   INSTEAD OF UPDATE
   ON BARS.V_DPT_POA_BRANCHES
   FOR EACH ROW
DECLARE
   ord_   NUMBER;
BEGIN
   SELECT MAX (ord) + 1
     INTO ord_
     FROM dpt_poa_branches
    WHERE branch = :new.branch;

   UPDATE dpt_poa_branches pb
      SET pb.active = :new.active,
          pb.kred = :new.kred,
          pb.branch = :new.branch,
          ord = ord_
    WHERE pb.poa_id = :old.id;
END tiu_vdptpoabranches;


/
ALTER TRIGGER BARS.TIU_VDPTPOABRANCHES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_VDPTPOABRANCHES.sql =========***
PROMPT ===================================================================================== 
