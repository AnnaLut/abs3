

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TGR_V_ACR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TGR_V_ACR ***

  CREATE OR REPLACE TRIGGER BARS.TGR_V_ACR 
        INSTEAD OF UPDATE  ON V_ACR REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    KVA_ accounts.KV%type; acra_ accounts.ACC%type; NLSA_ accounts.NLS%type ;
    KVB_ accounts.KV%type; acrb_ accounts.ACC%type; NLSB_ accounts.NLS%type ;
    ir_  int_ratn.IR%type; br_   int_ratn.BR%type ; bdat_ int_ratn.bdat%type;
begin

   --Счет А
   NLSA_ := :new.NLSA;  KVA_  := Nvl(:new.KVA, :new.KV);
   If NLSA_ is not null then
      begin
        select acc into acra_ from accounts
        where kv=KVA_ and nls=NLSA_ and dazs is null;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
   end if;

   --Счет Б
   NLSB_ := :new.NLSB;  KVB_  := Nvl(:new.KVB, gl.baseval);
   If NLSB_ is not null then
      begin
        select acc into acrb_ from accounts
        where kv=KVB_ and nls=NLSB_ and dazs is null;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
   end if;

   update int_accn set acr_dat = :NEW.ACR_DAT,
                       acra    = acra_,
                       acrb    = acrb_,
                       nlsb    =:new.nlsp
          where acc=:new.acc and id=:new.id;

   -- % ставка
   IR_  := :new.IR;  BR_ := :new.BR;
   bdat_:= Nvl(:new.bdat, NVL( :NEW.ACR_DAT+1, :new.DAOS ) ) ;

   If IR_ is not null AND  IR_ <> NVL(:old.IR,-111) OR
      BR_ is not null AND  BR_ <> NVL(:old.BR,-111) then

      update int_ratn set ir=IR_, br=BR_
             where acc=:new.acc and id=:new.id and bdat= bdat_;

      if SQL%rowcount = 0 then
         insert into int_ratn(ACC,      ID,      BDAT,  IR , BR )
                       values(:new.acc, :new.id, bdat_, ir_, br_);
      end if;

   end if;
END tgr_V_ACR;
/
ALTER TRIGGER BARS.TGR_V_ACR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TGR_V_ACR.sql =========*** End *** =
PROMPT ===================================================================================== 
