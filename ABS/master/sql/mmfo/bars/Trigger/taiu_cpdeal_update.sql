

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CPDEAL_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CPDEAL_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CPDEAL_UPDATE 
   AFTER INSERT OR
         UPDATE OR
         DELETE OF ACC,
                   ACCD,
                   ACCEXPN,
                   ACCEXPR,
                   ACCP,
                   ACCR,
                   ACCR2,
                   ACCS,
                   ACTIVE,
                   DAT_UG,
                   DAZS,
                   ERAT,
                   ERATE,
                   ID,
                   INITIAL_REF,
                   OP,
                   PF,
                   REF,
                   RYN,
                   ACCR3,
                   ACCUNREC
   ON CP_DEAL
   FOR EACH ROW
DECLARE
   l_rec   CP_DEAL_UPDATE%ROWTYPE;

   ---
   PROCEDURE SAVE_CHANGES
   IS
     l_old_key varchar2(38);
   BEGIN
      IF (l_rec.CHGACTION = 'D')
      THEN
         l_rec.ACC := :old.ACC;
         l_rec.ACCD := :old.ACCD;
         l_rec.ACCEXPN := :old.ACCEXPN;
         l_rec.ACCEXPR := :old.ACCEXPR;
         l_rec.ACCP := :old.ACCP;
         l_rec.ACCR := :old.ACCR;
         l_rec.ACCR2 := :old.ACCR2;
         l_rec.ACCS := :old.ACCS;
         l_rec.ACTIVE := :old.ACTIVE;
         l_rec.DAT_UG := :old.DAT_UG;
         l_rec.DAZS := :old.DAZS;
         l_rec.ERAT := :old.ERAT;
         l_rec.ERATE := :old.ERATE;
         l_rec.ID := :old.ID;
         l_rec.INITIAL_REF := :old.INITIAL_REF;
         l_rec.OP := :old.OP;
         l_rec.PF := :old.PF;
         l_rec.REF := :old.REF;
         l_rec.RYN := :old.RYN;
         l_rec.ACCR3 := :old.ACCR3;
         l_rec.ACCUNREC := :old.ACCUNREC;                  -- !!! нові колонки
         
      /*  далі поля, по яких ПОКИ ЩО, ПРИНАЙМНІ, не відслідковуємо змін значень
              l_rec.ACCS5 := :old.ACCS5;      l_rec.ACCS6 := :old.ACCS6;      l_rec.DAT_BAY := :old.DAT_BAY;
              l_rec.REF_NEW := :old.REF_NEW;  l_rec.REF_OLD := :old.REF_OLD;
      */
      ELSE
         l_rec.ACC := :new.ACC;
         l_rec.ACCD := :new.ACCD;
         l_rec.ACCEXPN := :new.ACCEXPN;
         l_rec.ACCEXPR := :new.ACCEXPR;
         l_rec.ACCP := :new.ACCP;
         l_rec.ACCR := :new.ACCR;
         l_rec.ACCR2 := :new.ACCR2;
         l_rec.ACCS := :new.ACCS;
         l_rec.ACTIVE := :new.ACTIVE;
         l_rec.DAT_UG := :new.DAT_UG;
         l_rec.DAZS := :new.DAZS;
         l_rec.ERAT := :new.ERAT;
         l_rec.ERATE := :new.ERATE;
         l_rec.ID := :new.ID;
         l_rec.INITIAL_REF := :new.INITIAL_REF;
         l_rec.OP := :new.OP;
         l_rec.PF := :new.PF;
         l_rec.REF := :new.REF;
         l_rec.RYN := :new.RYN;
         l_rec.ACCR3 := :new.ACCR3;
         l_rec.ACCUNREC := :new.ACCUNREC;                  -- !!! нові колонки
      /*  далі поля, по яких ПОКИ ЩО, ПРИНАЙМНІ, не відслідковуємо змін значень
              l_rec.ACCS5 := :new.ACCS5;      l_rec.ACCS6 := :new.ACCS6;      l_rec.DAT_BAY := :new.DAT_BAY;
              l_rec.REF_NEW := :new.REF_NEW;  l_rec.REF_OLD := :new.REF_OLD;
      */
      END IF;

	  bars_sqnc.split_key(l_rec.REF, l_old_key, l_rec.KF);
	  l_rec.IDUPD := bars_sqnc.get_nextval('S_CPDEAL_UPDATE', l_rec.KF);
      l_rec.EFFECTDATE := COALESCE (gl.bd, glb_bankdate);
      l_rec.CHGDATE := SYSDATE;
      l_rec.DONEBY := USER_ID;

      INSERT INTO BARS.cp_deal_update
           VALUES l_rec;
   END SAVE_CHANGES;
---

BEGIN
   CASE
      WHEN INSERTING
      THEN
         l_rec.CHGACTION := 'I';
         SAVE_CHANGES;
      WHEN DELETING
      THEN
         l_rec.CHGACTION := 'D';
         SAVE_CHANGES;
      WHEN UPDATING
      THEN
         CASE
            WHEN (:old.ACC <> :new.ACC)
            THEN -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
               -- породжуємо в історії запис про видалення
               l_rec.CHGACTION := 'D';
               SAVE_CHANGES;

               -- породжуємо в історії запис про вставку
               l_rec.CHGACTION := 'I';
               SAVE_CHANGES;
            WHEN (   :old.ACCD <> :new.ACCD
                  OR (:old.ACCD IS NULL AND :new.ACCD IS NOT NULL)
                  OR (:old.ACCD IS NOT NULL AND :new.ACCD IS NULL)
                  OR :old.ACCEXPN <> :new.ACCEXPN
                  OR (:old.ACCEXPN IS NULL AND :new.ACCEXPN IS NOT NULL)
                  OR (:old.ACCEXPN IS NOT NULL AND :new.ACCEXPN IS NULL)
                  OR :old.ACCEXPR <> :new.ACCEXPR
                  OR (:old.ACCEXPR IS NULL AND :new.ACCEXPR IS NOT NULL)
                  OR (:old.ACCEXPR IS NOT NULL AND :new.ACCEXPR IS NULL)
                  OR :old.ACCP <> :new.ACCP
                  OR (:old.ACCP IS NULL AND :new.ACCP IS NOT NULL)
                  OR (:old.ACCP IS NOT NULL AND :new.ACCP IS NULL)
                  OR :old.ACCR <> :new.ACCR
                  OR (:old.ACCR IS NULL AND :new.ACCR IS NOT NULL)
                  OR (:old.ACCR IS NOT NULL AND :new.ACCR IS NULL)
                  OR :old.ACCR2 <> :new.ACCR2
                  OR (:old.ACCR2 IS NULL AND :new.ACCR2 IS NOT NULL)
                  OR (:old.ACCR2 IS NOT NULL AND :new.ACCR2 IS NULL)
                  OR :old.ACCS <> :new.ACCS
                  OR (:old.ACCS IS NULL AND :new.ACCS IS NOT NULL)
                  OR (:old.ACCS IS NOT NULL AND :new.ACCS IS NULL)
                  OR :old.ACTIVE <> :new.ACTIVE
                  OR (:old.ACTIVE IS NULL AND :new.ACTIVE IS NOT NULL)
                  OR (:old.ACTIVE IS NOT NULL AND :new.ACTIVE IS NULL)
                  OR :old.DAT_UG <> :new.DAT_UG
                  OR (:old.DAT_UG IS NULL AND :new.DAT_UG IS NOT NULL)
                  OR (:old.DAT_UG IS NOT NULL AND :new.DAT_UG IS NULL)
                  OR :old.DAZS <> :new.DAZS
                  OR (:old.DAZS IS NULL AND :new.DAZS IS NOT NULL)
                  OR (:old.DAZS IS NOT NULL AND :new.DAZS IS NULL)
                  OR :old.ERAT <> :new.ERAT
                  OR (:old.ERAT IS NULL AND :new.ERAT IS NOT NULL)
                  OR (:old.ERAT IS NOT NULL AND :new.ERAT IS NULL)
                  OR :old.ERATE <> :new.ERATE
                  OR (:old.ERATE IS NULL AND :new.ERATE IS NOT NULL)
                  OR (:old.ERATE IS NOT NULL AND :new.ERATE IS NULL)
                  OR :old.ID <> :new.ID
                  OR (:old.ID IS NULL AND :new.ID IS NOT NULL)
                  OR (:old.ID IS NOT NULL AND :new.ID IS NULL)
                  OR :old.INITIAL_REF <> :new.INITIAL_REF
                  OR (    :old.INITIAL_REF IS NULL
                      AND :new.INITIAL_REF IS NOT NULL)
                  OR (    :old.INITIAL_REF IS NOT NULL
                      AND :new.INITIAL_REF IS NULL)
                  OR :old.OP <> :new.OP
                  OR (:old.OP IS NULL AND :new.OP IS NOT NULL)
                  OR (:old.OP IS NOT NULL AND :new.OP IS NULL)
                  OR :old.PF <> :new.PF
                  OR (:old.PF IS NULL AND :new.PF IS NOT NULL)
                  OR (:old.PF IS NOT NULL AND :new.PF IS NULL)
                  OR :old.REF <> :new.REF
                  OR (:old.REF IS NULL AND :new.REF IS NOT NULL)
                  OR (:old.REF IS NOT NULL AND :new.REF IS NULL)
                  OR :old.RYN <> :new.RYN
                  OR (:old.RYN IS NULL AND :new.RYN IS NOT NULL)
                  OR (:old.RYN IS NOT NULL AND :new.RYN IS NULL)
                  OR :old.ACCR3 <> :new.ACCR3
                  OR (:old.ACCR3 IS NULL AND :new.ACCR3 IS NOT NULL)
                  OR (:old.ACCR3 IS NOT NULL AND :new.ACCR3 IS NULL)
                  OR :old.ACCUNREC <> :new.ACCUNREC
                  OR (:old.ACCUNREC IS NULL AND :new.ACCUNREC IS NOT NULL)
                  OR (:old.ACCUNREC IS NOT NULL AND :new.ACCUNREC IS NULL))
            THEN      -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY
               -- протоколюємо внесені зміни
               l_rec.CHGACTION := 'U';
               SAVE_CHANGES;
            ELSE
               NULL;
         END CASE;
      ELSE
         NULL;
   END CASE;
END TAIU_CPDEAL_UPDATE;
/
ALTER TRIGGER BARS.TAIU_CPDEAL_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CPDEAL_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
