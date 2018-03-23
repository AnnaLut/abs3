create or replace trigger TIU_CUSB
before insert or update on CUSTOMER
-- Clears temp variables aiming next tiu_cus fires
BEGIN
  kl.cus_rec.rnk := NULL;
END tiu_cusb;
/

show err
