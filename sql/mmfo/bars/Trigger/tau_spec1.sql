

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_SPEC1.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_SPEC1 ***

CREATE OR REPLACE TRIGGER BARS.TAU_SPEC1
  INSTEAD OF UPDATE ON "BARS"."SPEC1"
  REFERENCING FOR EACH ROW
BEGIN

  IF (:new.r011 is not null and (:old.r011 is null or :new.r011<>:old.r011))
     or
     (:new.r011 is null and (:old.r011 is not null or :new.r011<>:old.r011))
     
     or
    
   (:new.R013 is not null and (:old.R013 is null or :new.R013<>:old.R013))
     or
     (:new.R013 is null and (:old.R013 is not null or :new.R013<>:old.R013))
     
     or
    
    (:new.R016 is not null and (:old.R016 is null or :new.R016<>:old.R016))
     or
     (:new.R016 is null and (:old.R016 is not null or :new.R016<>:old.R016))

     or
     
       (:new.S080 is not null and (:old.S080 is null or :new.S080<>:old.S080))
     or
     (:new.S080 is null and (:old.S080 is not null or :new.S080<>:old.S080))
     
     or
     
       (:new.S180 is not null and (:old.S180 is null or :new.S180<>:old.S180))
     or
     (:new.S180 is null and (:old.S180 is not null or :new.S180<>:old.S180))
     
     or
     
     (:new.S181 is not null and (:old.S181 is null or :new.S181<>:old.S181))
     or
     (:new.S181 is null and (:old.S181 is not null or :new.S181<>:old.S181))
     
     or
     
        (:new.s190 is not null and (:old.s190 is null or :new.s190<>:old.s190))
     or
     (:new.s190 is null and (:old.s190 is not null or :new.s190<>:old.s190))
     
     or 
     
      (:new.s240 is not null and (:old.s240 is null or :new.s240<>:old.s240))
     or
     (:new.s240 is null and (:old.s240 is not null or :new.s240<>:old.s240))
     
     or
     
      (:new.s260 is not null and (:old.s260 is null or :new.s260<>:old.s260))
     or
     (:new.s260 is null and (:old.s260 is not null or :new.s260<>:old.s260))
     
     or
     
       (:new.s270 is not null and (:old.s270 is null or :new.s270<>:old.s270))
     or
     (:new.s270 is null and (:old.s270 is not null or :new.s270<>:old.s270))

      or
     
       (:new.s580 is not null and (:old.s580 is null or :new.s580<>:old.s580))
     or
     (:new.s580 is null and (:old.s580 is not null or :new.s580<>:old.s580))

     or
     
       (:new.idg is not null and (:old.idg is null or :new.idg<>:old.idg))
     or
     (:new.idg is null and (:old.idg is not null or :new.idg<>:old.idg))

      or
     
       (:new.ids is not null and (:old.ids is null or :new.ids<>:old.ids))
     or
     (:new.ids is null and (:old.ids is not null or :new.ids<>:old.ids))
     
  THEN
    update SPECPARAM set R011  = :new.r011,
                                       R013 = :new.r013,    
                                       R016 = :new.r016,    
                                       S080 = :new.s080,   
                                       S180 = :new.s180,  
                                       S181 = :new.s181,   
                                       S190 = :new.s190,   
                                       S240 = :new.s240,   
                                       S260 = :new.s260,   
                                       S270 = :new.s270,   
                                       S120 = :new.s120,
                                       S580 = :new.s580,
                                       IDG  = :new.idg,
                                       IDS  = :new.ids
                                        where acc=:old.acc;
    IF SQL%rowcount = 0 THEN
       insert into SPECPARAM (acc,    
                                                R011,
                                                R013, 
                                                R016,
                                                S080,    
                                                S180,    
                                                S181,    
                                                S190,    
                                                S240,    
                                                S260,    
                                                S270,    
                                                S120,
                                                S580,
                                                IDG,
                                                IDS
)
                                                 values (:old.acc, :new.r011, :new.r013, :new.r016, :new.s080, :new.s180, :new.s181, :new.s190, :new.s240, :new.s260, :new.s270, :new.s120, :new.s580, :new.idg, :new.ids);
    END IF;
  END IF;
    IF :new.nms <> :old.nms then
    update ACCOUNTS set nms=:new.nms where acc=:old.acc;
  end if;
end TAU_SPEC1;
/
ALTER TRIGGER BARS.TAU_SPEC1 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_SPEC1.sql =========*** End *** =
PROMPT ===================================================================================== 
