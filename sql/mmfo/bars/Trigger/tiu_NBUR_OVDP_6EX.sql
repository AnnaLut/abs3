CREATE OR REPLACE TRIGGER tiu_NBUR_OVDP_6EX
AFTER INSERT OR UPDATE
ON NBUR_OVDP_6EX for each row
declare
 l_CHGACTION varchar2(1):='I';
begin
  if updating then
   l_CHGACTION:='U';
  end if;
    INSERT
    INTO   NBUR_OVDP_6EX_UPDATE (DATE_FV,
                          ISIN,
                          KV,
                          FV_CP,
                          YIELD,
                          KURS,
                          KOEF,
                          DATE_MATURITY,
                          CHGDATE,
                          CHGACTION,
                          DONEBY   
                          )
                    VALUES (:old.DATE_FV,
                          :old.ISIN,
                          :old.KV,
                          :old.FV_CP,
                          :old.YIELD,
                          :old.KURS,
                          :old.KOEF,
                          :old.DATE_MATURITY,
                          sysdate,
                          l_CHGACTION,
                          user_name  );
END tiu_NBUR_OVDP_6EX;
/
