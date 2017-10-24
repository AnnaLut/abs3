
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dpzt_ks.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DPZT_KS 
  (p_idpdr branch.idpdr%type,
   p_kv    accounts.kv%type)
 RETURN VARCHAR2
IS
  -- ======================================================================= --
  --            Поиск коррсчета для указанного подразделения                 --
  -- ======================================================================= --
  l_branch branch.branch%type;
  l_nls    accounts.nls%type;
  l_dazs   accounts.dazs%type;
  ern      CONSTANT POSITIVE := 203;
  erm      VARCHAR2(80);
  err      EXCEPTION;
BEGIN

  BEGIN
    SELECT branch INTO l_branch FROM branch WHERE idpdr = p_idpdr;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      erm := 'Не найдено подразделение с кодом '||to_char(p_idpdr)||'!';
      RAISE err;
    WHEN TOO_MANY_ROWS THEN
      erm := 'Невозможно однозначно идентифицировать подразд.'||to_char(p_idpdr)||'!';
      RAISE err;
  END;

  BEGIN
    SELECT substr(trim(val),1,14) INTO l_nls
      FROM branch_parameters
     WHERE tag = 'CORRACC' AND branch = l_branch;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      erm := 'Не найден коррсчет для подразд.'||to_char(p_idpdr)||'!';
      RAISE err;
  END;

  BEGIN
    SELECT dazs INTO l_dazs FROM accounts WHERE kv = p_kv AND nls = l_nls;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      erm := 'Не открыт коррсчет для подразд.'||to_char(p_idpdr)||'!';
      RAISE err;
  END;

  IF l_dazs IS NOT NULL THEN
      erm := 'Коррсчет для подразд.'||to_char(p_idpdr)||' закрыт!';
      RAISE err;
  END IF;

  RETURN l_nls;

EXCEPTION
   WHEN err THEN
      raise_application_error(-(20000+ern),'\' ||erm,TRUE);
   WHEN OTHERS THEN
      raise_application_error(-(20000+ern),SQLERRM,TRUE);

END dpzt_ks;
 
/
 show err;
 
PROMPT *** Create  grants  DPZT_KS ***
grant EXECUTE                                                                on DPZT_KS         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dpzt_ks.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 