

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_INTACCN_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_INTACCN_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_INTACCN_UPDATE 
AFTER INSERT OR UPDATE OR DELETE ON BARS.INT_ACCN
  FOR EACH ROW
-- ======================================================================================
-- Author : ???
-- Date   : ???
-- Update:  VKharin
-- Date:    10.12.2015
-- Version: 1.1
-- ======================================================================================
-- Recreate trigger TAIU_INTACCN_UPDATE
-- ======================================================================================
DECLARE
  l_rec      int_accn_update%rowtype;
  l_chg_typ  number := 0; -- 1-inserting, 2-updating, 3-deleting, 4-updating primary key
                          -- якщо зм≥нюЇтьс€ поле, що входить в PRIMARY KEY породжуЇмо записи про видаленн€ ≥з старим PK
                          -- та про вставку з новим PK дл€ правильного в≥дображенн€ при вивантаженн≥ даних до DWH
begin
  if inserting then
     l_chg_typ := 1;
  elsif updating AND (:old.ACC != :new.ACC OR :old.ID != :new.ID) then -- €кщо зм≥нивс€ PK
     l_chg_typ := 4;
  elsif updating and ( (:old.ACC != :new.ACC)                          -- перев≥рка чи щось зм≥нилос€ кр≥м PK
                        OR
                        (:old.ID != :new.ID)
                        OR
                        (:old.METR != :new.METR)
                        OR
                        (:old.BASEM          != :new.BASEM) or
                        (:old.BASEM is Null AND :new.BASEM is Not Null) or
                        (:new.BASEM is Null AND :old.BASEM is Not Null)
                        OR
                        (:old.BASEY != :new.BASEY)
                        OR
                        (:old.FREQ != :new.FREQ)
                        OR
                        (:old.STP_DAT          != :new.STP_DAT) or
                        (:old.STP_DAT is Null AND :new.STP_DAT is Not Null) or
                        (:new.STP_DAT is Null AND :old.STP_DAT is Not Null)
                        OR
                        (:old.ACR_DAT != :new.ACR_DAT)
                        OR
                        (:old.APL_DAT          != :new.APL_DAT) or
                        (:old.APL_DAT is Null AND :new.APL_DAT is Not Null) or
                        (:new.APL_DAT is Null AND :old.APL_DAT is Not Null)
                        OR
                        (:old.TT != :new.TT)
                        OR
                        (:old.ACRA          != :new.ACRA) or
                        (:old.ACRA is Null AND :new.ACRA is Not Null) or
                        (:new.ACRA is Null AND :old.ACRA is Not Null)
                        OR
                        (:old.ACRB          != :new.ACRB) or
                        (:old.ACRB is Null AND :new.ACRB is Not Null) or
                        (:new.ACRB is Null AND :old.ACRB is Not Null)
                        OR
                        (:old.S != :new.S)
                        OR
                        (:old.TTB          != :new.TTB) or
                        (:old.TTB is Null AND :new.TTB is Not Null) or
                        (:new.TTB is Null AND :old.TTB is Not Null)
                        OR
                        (:old.KVB          != :new.KVB) or
                        (:old.KVB is Null AND :new.KVB is Not Null) or
                        (:new.KVB is Null AND :old.KVB is Not Null)
                        OR
                        (:old.NLSB          != :new.NLSB) or
                        (:old.NLSB is Null AND :new.NLSB is Not Null) or
                        (:new.NLSB is Null AND :old.NLSB is Not Null)
                        OR
                        (:old.MFOB          != :new.MFOB) or
                        (:old.MFOB is Null AND :new.MFOB is Not Null) or
                        (:new.MFOB is Null AND :old.MFOB is Not Null)
                        OR
                        (:old.NAMB          != :new.NAMB) or
                        (:old.NAMB is Null AND :new.NAMB is Not Null) or
                        (:new.NAMB is Null AND :old.NAMB is Not Null)
                        OR
                        (:old.NAZN          != :new.NAZN) or
                        (:old.NAZN is Null AND :new.NAZN is Not Null) or
                        (:new.NAZN is Null AND :old.NAZN is Not Null)
                        OR
                        (:old.IO != :new.IO)
                        OR
                        (:old.IDU          != :new.IDU) or
                        (:old.IDU is Null AND :new.IDU is Not Null) or
                        (:new.IDU is Null AND :old.IDU is Not Null)
                        OR
                        (:old.IDR          != :new.IDR) or
                        (:old.IDR is Null AND :new.IDR is Not Null) or
                        (:new.IDR is Null AND :old.IDR is Not Null)
                        OR
                        (:old.KF != :new.KF)
                        OR
                        (:old.OKPO          != :new.OKPO) or
                        (:old.OKPO is Null AND :new.OKPO is Not Null) or
                        (:new.OKPO is Null AND :old.OKPO is Not Null)
                      )   then
     l_chg_typ := 2;
  elsif deleting then
     l_chg_typ := 3;
  else
     l_chg_typ := 0; --пустой стакан
  end if;

  while (l_chg_typ > 0) loop
      case
          when (l_chg_typ = 1 or l_chg_typ = 2) then
               l_rec.ACC       := :new.ACC;
               l_rec.ID        := :new.ID;
               l_rec.METR      := :new.METR;
               l_rec.BASEM     := :new.BASEM;
               l_rec.BASEY     := :new.BASEY;
               l_rec.FREQ      := :new.FREQ;
               l_rec.STP_DAT   := :new.STP_DAT;
               l_rec.ACR_DAT   := :new.ACR_DAT;
               l_rec.APL_DAT   := :new.APL_DAT;
               l_rec.TT        := :new.TT;
               l_rec.ACRA      := :new.ACRA;
               l_rec.ACRB      := :new.ACRB;
               l_rec.S         := :new.S;
               l_rec.TTB       := :new.TTB;
               l_rec.KVB       := :new.KVB;
               l_rec.NLSB      := :new.NLSB;
               l_rec.MFOB      := :new.MFOB;
               l_rec.NAMB      := :new.NAMB;
               l_rec.NAZN      := :new.NAZN;
               l_rec.IO        := :new.IO;
               l_rec.IDU       := :new.IDU;
               l_rec.IDR       := :new.IDR;
               l_rec.KF        := :new.KF;
               l_rec.OKPO      := :new.OKPO;

               case when l_chg_typ = 1 then   l_rec.CHGACTION := 'I';
               else                           l_rec.CHGACTION := 'U';
               end case;

               l_chg_typ       := 0;

          when l_chg_typ = 3 or l_chg_typ = 4 then
               l_rec.ACC       := :old.ACC;
               l_rec.ID        := :old.ID;
               l_rec.METR      := :old.METR;
               l_rec.BASEM     := :old.BASEM;
               l_rec.BASEY     := :old.BASEY;
               l_rec.FREQ      := :old.FREQ;
               l_rec.STP_DAT   := :old.STP_DAT;
               l_rec.ACR_DAT   := :old.ACR_DAT;
               l_rec.APL_DAT   := :old.APL_DAT;
               l_rec.TT        := :old.TT;
               l_rec.ACRA      := :old.ACRA;
               l_rec.ACRB      := :old.ACRB;
               l_rec.S         := :old.S;
               l_rec.TTB       := :old.TTB;
               l_rec.KVB       := :old.KVB;
               l_rec.NLSB      := :old.NLSB;
               l_rec.MFOB      := :old.MFOB;
               l_rec.NAMB      := :old.NAMB;
               l_rec.NAZN      := :old.NAZN;
               l_rec.IO        := :old.IO;
               l_rec.IDU       := :old.IDU;
               l_rec.IDR       := :old.IDR;
               l_rec.KF        := :old.KF;
               l_rec.OKPO      := :old.OKPO;
               l_rec.CHGACTION := 'D';

               case when l_chg_typ = 4 then   l_chg_typ := 1; -- порождаем запись с 'D' и отправл€ем на повторный loop дл€ 'I'
               else                           l_chg_typ := 0;
               end case;
      end case;

      l_rec.IDUPD        := S_INTACCN_UPDATE.NextVal;
      l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
      l_rec.GLOBAL_BDATE := glb_bankdate;
      l_rec.CHGDATE      := sysdate;
      l_rec.DONEBY       := gl.aUID;

      insert into BARS.INT_ACCN_UPDATE
      values l_rec;

  end loop;

END;
/
ALTER TRIGGER BARS.TAIU_INTACCN_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_INTACCN_UPDATE.sql =========***
PROMPT ===================================================================================== 
