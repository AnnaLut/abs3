

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SYNC_OPEN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SYNC_OPEN ***

  CREATE OR REPLACE PROCEDURE BARS.SYNC_OPEN 
 (p_idpdr IN  branch.idpdr%type,      --  код подразделения (алтернат.)
  p_nls   IN  accounts.nls%type,      --  номер лицевого счета
  p_kv    IN  accounts.kv%type,       --  код валюты
  p_nms   IN  accounts.nms%type,      --  наименование счета
  p_okpo  IN  customer.okpo%type,     --  идентиф.код
  p_grp   IN  accounts.grp%type,      --  код группы доступа
  p_acc   OUT accounts.acc%type)
IS
  -- ======================================================================= --
  --            Открытие счетов при синхронизации с ОДБ-ORACLE               --
  -- ======================================================================= --
  l_branch branch.branch%type;
  l_brnch  accounts.branch%type;
  l_dazs   accounts.dazs%type;
  l_rnk    customer.rnk%type;
  l_mfo    accounts.kf%type;
  l_acc    accounts.acc%type;
  l_tip    accounts.tip%type;
  l_isp    accounts.isp%type;
  l_tmp    NUMBER;
  -------------------------------
  ern   number;
  par1  VARCHAR2(80);
  par2  VARCHAR2(80);
  err   EXCEPTION;
BEGIN

  BARS_CONTEXT.subst_branch('/');

  BEGIN
    SELECT branch, bars_context.extract_mfo(branch)
      INTO l_branch, l_mfo
      FROM branch
     WHERE idpdr = p_idpdr;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- 'Не найдено подразделение с кодом '||to_char(p_idpdr)||'!';
      ern  := 17;
      par1 := to_char(p_idpdr);
      RAISE err;
    WHEN TOO_MANY_ROWS THEN
      -- 'Невозможно однозначно идентифицировать подразд.'||to_char(p_idpdr)||'!';
      ern  := 18;
      par1 := to_char(p_idpdr);
      RAISE err;
  END;

  BEGIN
    SELECT acc,   branch,  dazs
      INTO l_acc, l_brnch, l_dazs
      FROM accounts
     WHERE nls = p_nls AND kv = p_kv AND kf = l_mfo;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_acc := 0;
  END;

  IF l_acc > 0 THEN
    IF l_dazs IS NOT NULL THEN
      -- 'SYNC_OPEN: счёт закрыт '||p_nls||'!';
      ern  := 19;
      par1 := p_nls;
      RAISE err;
    ELSIF l_brnch <> l_branch THEN
      -- 'SYNC_OPEN: счёт '||p_nls||' зарегистрирован за др.подразд.!';
      ern  := 20;
      par1 := p_nls;
      RAISE err;
    ELSE
      p_acc := l_acc;
      RETURN;
    END IF;
  END IF;

  BEGIN
    SELECT to_number(val) INTO l_rnk
      FROM branch_parameters
     WHERE tag = 'RNK' AND branch = l_branch;
  EXCEPTION
    WHEN INVALID_NUMBER THEN
      -- 'Некорректно заполнен спр-к параметров для подразд.'||to_char(p_idpdr)||'!';
      ern  := 21;
      par1 := to_char(p_idpdr);
      RAISE err;
    WHEN NO_DATA_FOUND THEN
      BEGIN
        SELECT rnk INTO l_rnk
          FROM customer
         WHERE date_off IS NULL AND custtype = 1 AND okpo = p_okpo;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          -- 'Не найден контрагент для подразд.'||to_char(p_idpdr)||'!';
          ern  := 22;
          par1 := to_char(p_idpdr);
          RAISE err;
        WHEN TOO_MANY_ROWS THEN
          -- 'Невозможно однозначно идентифицировать контрагента для подразд.'||to_char(p_idpdr)||'!';
          ern  := 23;
          par1 := to_char(p_idpdr);
          RAISE err;
      END;
  END;

  IF p_nls <> VKRZN(substr(l_mfo,1,5), p_nls) THEN
     -- 'Ошибка в контр.разряде счета '||p_nls||' МФО: '||l_mfo||'!';
     ern  :=  24;
     par1 := p_nls;
     par2 := l_mfo;
     RAISE err;
  END IF;

  BEGIN
    SELECT kv INTO l_tmp FROM tabval WHERE kv = p_kv AND d_close IS NULL;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- 'Указанная валюта ('||to_char(p_kv)||') не найдена или закрыта!';
      ern  := 25;
      par1 := to_char(p_kv);
      RAISE err;
  END;

  IF substr(p_nls,1,4) IN ('1001','1002') AND p_kv = gl.baseval THEN
     l_tip := 'KAS';
  ELSE
     l_tip := 'ODB';
  END IF;

  l_isp := USER_ID;

  gl.aMFO := l_mfo;

  op_reg_ex
     (99, 0, 0, p_grp, l_tmp, l_rnk, p_nls, p_kv, p_nms, l_tip, l_isp, l_acc,
     '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
      l_branch, NULL);

  p_acc := l_acc;
  logger.financial('SYNC: открыт лицевой счет '||p_nls||'/'||p_kv||
                   ' для подразд.№'||l_branch||' ('||to_char(p_idpdr)||')');

  BARS_CONTEXT.set_context;
  GL.aMFO := F_OURMFO_G;

EXCEPTION
   WHEN err THEN
      bars_error.raise_error('CAC', ern, par1, par2);
   ROLLBACK;
END sync_open;
 
/
show err;

PROMPT *** Create  grants  SYNC_OPEN ***
grant EXECUTE                                                                on SYNC_OPEN       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SYNC_OPEN.sql =========*** End ***
PROMPT ===================================================================================== 
