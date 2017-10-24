

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_VV9819.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_VV9819 ***

  CREATE OR REPLACE TRIGGER BARS.TU_VV9819 
       INSTEAD OF UPDATE
       ON BARS.VV_9819 REFERENCING NEW AS NEW OLD AS OLD
       for each row
declare
  nTmp_ int;
BEGIN
  update ND_9819 set k_02 = :new.k_02,
                     k_03 = :new.k_03,
                     k_79 = :new.k_79,
                     k_83 = :new.k_83,
					 k_i3 = :new.k_i3,
					 k_b8 = :new.k_b8
  where nd = :NEW.ND
    and branch = :new.branch_cx;
  nTmp_  :=  SQL%rowcount;
  If nTmp_ = 0 then
     insert into ND_9819 (nd,     k_02,     k_03,     k_79,     k_83, k_i3, k_b8, branch) values
                    (:new.nd,:new.k_02,:new.k_03,:new.k_79,:new.k_83,:new.k_i3,:new.k_b8, :new.branch_cx);
  end if;
END TU_VV9819;


/
ALTER TRIGGER BARS.TU_VV9819 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_VV9819.sql =========*** End *** =
PROMPT ===================================================================================== 
