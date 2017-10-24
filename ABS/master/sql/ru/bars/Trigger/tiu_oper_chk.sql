

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_OPER_CHK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_OPER_CHK ***

  CREATE OR REPLACE TRIGGER BARS.TIU_OPER_CHK 
BEFORE INSERT OR UPDATE OF CHK ON OPER
FOR EACH ROW
/*
    -- KF     Ощадный банк(мульти-мфо)
*/

DECLARE
    CVISA_ VARCHAR2(2);
    NVISA_ VARCHAR2(2);
    DCOND_ VARCHAR2(4096);
    ISVAL_ INTEGER;

BEGIN
    IF LENGTH(RTRIM(:NEW.CHK)) > 0 THEN
        CVISA_ := SUBSTR(RTRIM(:NEW.CHK), -6, 2);
    ELSE
        CVISA_ := '';
    END IF;

    CHK.CurrRef_ := :NEW.REF;

    chk.doc.ref  := :NEW.REF;
    chk.doc.tt   := :NEW.TT;
    chk.doc.vob  := :NEW.VOB;
    chk.doc.nd   := :NEW.ND;
    chk.doc.pdat := :NEW.PDAT;
    chk.doc.vdat := :NEW.VDAT;
    chk.doc.dk   := :NEW.DK;
    chk.doc.s    := :NEW.S;
    chk.doc.kv   := :NEW.KV;
    chk.doc.s2   := :NEW.S2;
    chk.doc.kv2  := :NEW.KV2;
    chk.doc.sq   := :NEW.SQ;
    chk.doc.kvq  := :NEW.KVQ;
    chk.doc.sk   := :NEW.SK;
    chk.doc.datd := :NEW.DATD;
    chk.doc.datp := :NEW.DATP;
    chk.doc.nam_a:= :NEW.NAM_A;
    chk.doc.nlsa := :NEW.NLSA;
    chk.doc.mfoa := :NEW.MFOA;
    chk.doc.nam_b:= :NEW.NAM_B;
    chk.doc.nlsb := :NEW.NLSB;
    chk.doc.mfob := :NEW.MFOB;
    chk.doc.nazn := :NEW.NAZN;
    chk.doc.d_rec:= :NEW.D_REC;
    chk.doc.userid:=:NEW.USERID;
    chk.doc.id_a := :NEW.ID_A;
    chk.doc.id_b := :NEW.ID_B;
    chk.doc.id_o := :NEW.ID_O;
    chk.doc.sos  := :NEW.SOS;
    chk.doc.refl := :NEW.REFL;
    chk.doc.prty := :NEW.PRTY;
    chk.doc.ref_a:= :NEW.REF_A;

    -- вычисляем следующую визу
    NVISA_ := CHK.GetNextVisaGroup( :NEW.TT, CVISA_ );

    :NEW.CURRVISAGRP := CVISA_;
    :NEW.NEXTVISAGRP := NVISA_;

	chk.doc.currvisagrp := CVISA_;
    chk.doc.nextvisagrp := NVISA_;

    -- вычисляем список бранчей следующей визы(для оптимизации выборки документов на визировании)
	:new.next_visa_branches := chk.get_next_visa_branches();

END;
/
ALTER TRIGGER BARS.TIU_OPER_CHK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_OPER_CHK.sql =========*** End **
PROMPT ===================================================================================== 
