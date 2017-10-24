

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CUSB.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CUSB ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CUSB 
BEFORE INSERT OR UPDATE OF tgr, custtype, country,nmk, nmkv, nmkk, codcagent,
    prinsider, okpo, adr, sab, taxf, c_reg, c_dst, rgtax, datet, adm, datea,
    stmt, date_on, date_off, notes, notesec, crisk, pincode, nd, rnkp,
    ise, fs, oe, ved, sed, k050, lim, nompdv, mb, rgadm, bc, tobo, isp ON customer
-- Clears temp variables aiming next tiu_cus fires
BEGIN
   pul.cus_rec.rnk := NULL;
END tiu_cusb;
/
ALTER TRIGGER BARS.TIU_CUSB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CUSB.sql =========*** End *** ==
PROMPT ===================================================================================== 
