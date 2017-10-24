PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/tai_accounts_tax.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger tai_accounts_tax ***

CREATE OR REPLACE TRIGGER bars.tai_accounts_tax
  AFTER INSERT ON bars.accounts
  FOR EACH ROW
DECLARE
  -----------------------------------------------------------------------------
  -- version 2.11 07.06.17
  -----------------------------------------------------------------------------

  nbs_           VARCHAR2(4);
  mfo_           VARCHAR2(12);
  okpo_          VARCHAR2(14);
  tgr_           NUMBER(1);
  bank_date      DATE;
  acct_open_date DATE;
  nls_           VARCHAR2(15);
  pos_           NUMBER(1);
  kv_            NUMBER;
  rez_in         NUMBER;
  rez_out        NUMBER;
  nmk_           VARCHAR2(38);
  creg_          NUMBER(38);
  cdst_          NUMBER(38);
  ot_            NUMBER;
  acc_           NUMBER;
  l_adr          customer.adr%TYPE;
  l_custtype     customer.custtype%TYPE;
  l_passp        VARCHAR2(14);
BEGIN
  -- Account already closed, do nothing
  IF :new.dazs IS NOT NULL THEN
    RETURN;
  END IF;

  -- Account type don't interest Tax Police, do nothing...
  IF :new.vid = 0 OR :new.vid IS NULL THEN
    RETURN;
  END IF;

  -- балансовые счета только из табл. dpa_nbs
  SELECT UNIQUE nbs
    INTO nbs_
    FROM dpa_nbs
   WHERE TYPE IN ('DPA', 'DPK', 'DPP')
     AND nbs = :new.nbs;


  bank_date      := coalesce(nvl(gl.bd, glb_bankdate), trunc(SYSDATE));
  mfo_           := gl.amfo;
  nls_           := :new.nls;
  pos_           := :new.pos;
  kv_            := :new.kv;
  acc_           := :new.acc;
  ot_            := 1;
  acct_open_date := :new.daos;

  -- данные клиента
  SELECT okpo
        ,tgr
        ,nvl(nmkk, substr(nmk, 1, 38))
        ,c_reg
        ,c_dst
        ,codcagent
        ,adr
        ,custtype
    INTO okpo_
        ,tgr_
        ,nmk_
        ,creg_
        ,cdst_
        ,rez_in
        ,l_adr
        ,l_custtype
    FROM customer
   WHERE rnk = :new.rnk;

  -- резидентность
  SELECT rezid
    INTO rez_out
    FROM codcagent
   WHERE codcagent = rez_in;

  -- для религиозных берутся данные паспорта
  IF l_custtype = 3 AND substr(okpo_, 1, 5) IN ('99999', '00000') THEN
    BEGIN
      SELECT substr(TRIM(ser) || TRIM(numdoc), 1, 14)
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
    ,nvl(acct_open_date, trunc(SYSDATE))
    ,kv_
    ,rez_out
    ,nmk_
    ,nmk_
    ,creg_
    ,cdst_
    ,pos_);
EXCEPTION
  WHEN no_data_found THEN
    RETURN;
END;
/
ALTER TRIGGER BARS.tai_accounts_tax ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/tai_accounts_tax.sql =========*** En
PROMPT ===================================================================================== 
