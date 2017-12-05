PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_TAX.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_TAX ***

CREATE OR REPLACE TRIGGER bars.tbu_accounts_tax
   BEFORE UPDATE OF dazs, vid
   ON bars.accounts
   FOR EACH ROW
DECLARE
  -----------------------------------------------------------------------------
  -- version 2.19 09.11.17
  -----------------------------------------------------------------------------

  l_nbs       VARCHAR2(4);
  mfo_        VARCHAR2(12);
  okpo_       VARCHAR2(14);
  tgr_        NUMBER(1);
  nls_        VARCHAR2(15);
  pos_        NUMBER(1);
  kv_         NUMBER;
  rez_in      NUMBER;
  rez_out     NUMBER;
  nmk_        VARCHAR2(38);
  creg_       NUMBER(38);
  cdst_       NUMBER(38);
  ot_         NUMBER;
  acc_        NUMBER;
  l_adress    customer.adr%TYPE;
  l_custtype  customer.custtype%TYPE;
  l_passp     VARCHAR2(14);
  l_bankdate  DATE;
  l_acc_blkid NUMBER;
  l_trace     VARCHAR2(1000) := 'IN_REE: ';
  l_check_nbs NUMBER(1);
BEGIN
  -- Account already closed, do nothing
  IF (:old.dazs IS NOT NULL) AND (:new.dazs IS NOT NULL) THEN
    RETURN;
  END IF;

  -- Nothing changes, do nothing
  IF ((:new.vid = :old.vid) OR (:new.vid IS NULL AND :old.vid IS NULL)) AND
     ((:new.dazs = :old.dazs) OR (:new.dazs IS NULL AND :old.dazs IS NULL)) THEN
    RETURN;
  END IF;

  -- Accounts type not interested TaxPolice
  IF (:new.vid = :old.vid AND :new.vid = 0) OR
     (:old.vid IS NULL AND :new.vid IS NULL) OR
     (:new.vid <> :old.vid AND :new.vid <> 0 AND :old.vid <> 0) THEN
    RETURN;
  END IF;

  -- Accounts nbs not interested TaxPolice
  l_check_nbs := bars_dpa.dpa_nbs(:new.nbs, :new.ob22);
  IF l_check_nbs = 0 THEN
    RETURN;
  END IF;
  
  /*BEGIN
    SELECT UNIQUE nbs
      INTO l_nbs
      FROM dpa_nbs
     WHERE TYPE IN ('DPA'
                   ,'DPK'
                   ,'DPP')
       AND nbs = :new.nbs;
  EXCEPTION
    WHEN no_data_found THEN
      RETURN;
  END;*/

  l_bankdate := :new.dazs; --- gl.bdate;

  -- Account resurected!
  IF (:old.dazs IS NOT NULL) AND (:new.dazs IS NULL) THEN
    DELETE FROM ree_tmp
     WHERE nls = :old.nls
       AND ot = 3
       AND odat = l_bankdate
       AND fn_o IS NULL;
  
    IF SQL%ROWCOUNT = 0 THEN
      NULL;
    ELSE
      RETURN;
    END IF;
  END IF;

  -- счета с кодом "Не введено в дию" в ДПА сразу не отпрвляются
  l_acc_blkid := nvl(to_number(getglobaloption('ACC_BLKID'))
                    ,0);

  IF l_acc_blkid > 0 AND :old.blkd = l_acc_blkid AND
     :new.blkd = l_acc_blkid THEN
    RETURN;
  ELSIF :old.blkd = l_acc_blkid AND :new.blkd <> l_acc_blkid THEN
    -- считаем как открытие счета
    ot_ := 1;
  ELSE
    IF (:old.dazs IS NULL) AND (:new.dazs IS NOT NULL) THEN
      SELECT nvl(MIN(VALUE)
                ,3)
        INTO ot_
        FROM accountsw
       WHERE acc = :old.acc
         AND tag = 'DPAOTYPE';
    ELSE
      IF (:new.vid <> :old.vid OR :old.vid IS NULL) THEN
        IF :new.vid = 0 THEN
          ot_ := 3;
        ELSE
          ot_ := 1;
        END IF;
      ELSE
        ot_ := 2;
      END IF;
    END IF;
  END IF;

  mfo_ := gl.amfo;
  nls_ := :new.nls;
  pos_ := :new.pos;
  kv_  := :new.kv;
  acc_ := :new.acc;

  -- данные клиента
  SELECT adr
        ,okpo
        ,tgr
        ,nvl(nmkk
            ,substr(nmk
                   ,1
                   ,38))
        ,c_reg
        ,c_dst
        ,codcagent
        ,custtype
    INTO l_adress
        ,okpo_
        ,tgr_
        ,nmk_
        ,creg_
        ,cdst_
        ,rez_in
        ,l_custtype
    FROM customer
   WHERE rnk = :new.rnk;

  -- резидентность
  SELECT rezid
    INTO rez_out
    FROM codcagent
   WHERE codcagent = rez_in;

  -- для религиозных берутся данные паспорта
  IF l_custtype = 3 AND
     substr(okpo_
           ,1
           ,5) IN ('99999'
                  ,'00000') THEN
    BEGIN
      SELECT substr(TRIM(ser) || TRIM(numdoc)
                   ,1
                   ,14)
        INTO l_passp
        FROM person
       WHERE rnk = :new.rnk
         AND passp = 1;
    EXCEPTION
      WHEN no_data_found THEN
        l_passp := NULL;
    END;
  
    IF l_passp IS NULL THEN
      RETURN;
    ELSE
      okpo_ := l_passp;
      tgr_  := 4;
      -- tgr = 4 - сер_я та номер паспорта ф_зичної особи, яка через свої
      -- рел_г_йн_ переконання в_дмовилась в_д прийняття реєстрац_йного
      -- номера обл_кової картки платника податк_в та пов_домила про це
      -- в_дпов_дний орган ДПС _ має в_дм_тку у паспорт_
    END IF;
  END IF;

  -- если счет откр и закр в один и тот же день - удалить запись на открытие
  IF ot_ = 3 THEN
    DELETE FROM ree_tmp
     WHERE nls = nls_
       AND kv = kv_
       AND ot = 1
       AND odat = l_bankdate
       AND fn_o IS NULL;
  
    IF SQL%ROWCOUNT > 0 THEN
      bars_audit.info(l_trace || 'Рахунок ' || nls_ || '(' || kv_ ||
                      ') було вiдкрито та закрито в один день (' ||
                      to_char(l_bankdate
                             ,'dd-mm-yyyy') ||
                      ') iнформацiя не пiде на ДПI');
      RETURN;
    END IF;
  END IF;
  
  -- счёт открываем - дата открытия
  IF ot_ = 1 THEN
    l_bankdate := :new.daos;
  -- счёт закрываем - дата дата закрытия
  ELSIF ot_ in (3, 5) THEN
    l_bankdate := :new.dazs;
  END IF;

  UPDATE ree_tmp
     SET mfo   = mfo_
        ,id_a  = okpo_
        ,rt    = tgr_
        ,ot    = ot_
        ,c_ag  = rez_out
        ,nmk   = nmk_
        ,nmkw  = nmk_
        ,c_reg = creg_
        ,c_dst = cdst_
        ,prz   = pos_
   WHERE nls = nls_
     AND kv = kv_
     AND ot = ot_
     AND odat = l_bankdate
     AND fn_o IS NULL;

  IF SQL%ROWCOUNT = 0 THEN
    -- если счет ранимировали  - проставим прихнак открытия счета (для налоговой)
    IF ot_ = 2 THEN
      ot_ := 1;
    END IF;
  
    -- временный залипон, для сделок, по которым квитанцию принимают вручную
    IF (ot_ = 1 AND (:old.dazs IS NULL) AND (:new.dazs IS NULL)) THEN
      l_bankdate := :new.daos;
      -- меняют счёт на статус "не используется налоговой" (vid = 0) при отсутствующих датах закрытия - не добавляем запись на закрытия счёта в налоговой
    ELSIF (:new.vid = 0 AND ot_ = 3 AND (:old.dazs IS NULL) AND
          (:new.dazs IS NULL)) THEN
      RETURN;
    END IF;
  
  bars_audit.info('DPA tbu_accounts_tax: :new.nls - ' || :new.nls ||
                  ' :new.nbs - ' || :new.nbs || ' ot - ' || ot_ ||
                  ' l_bankdate - ' || l_bankdate || ' :new.vid - ' ||
                  :new.vid);
  
    INSERT INTO ree_tmp
      (mfo
      ,id_a
      ,rt
      ,ot
      ,nls
      ,odat
      ,kv
      ,c_ag
      ,nmk
      ,nmkw
      ,c_reg
      ,c_dst
      ,prz)
    VALUES
      (mfo_
      ,okpo_
      ,tgr_
      ,ot_
      ,nls_
      ,coalesce(l_bankdate
               ,gl.bdate
               ,trunc(SYSDATE))
      ,kv_
      ,rez_out
      ,nmk_
      ,nmk_
      ,creg_
      ,cdst_
      ,pos_);
  END IF;
EXCEPTION
  WHEN no_data_found THEN
    RETURN;
END;

/
ALTER TRIGGER BARS.TBU_ACCOUNTS_TAX ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_TAX.sql =========*** En
PROMPT ===================================================================================== 
/
