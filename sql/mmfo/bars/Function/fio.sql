prompt function bars.fio
  CREATE OR REPLACE FUNCTION BARS.FIO (p_nmk VARCHAR, p_par NUMBER) RETURN VARCHAR2
IS
  l_1space NUMBER;
  l_2space NUMBER;
  l_int    INTEGER;
  l_nmk    VARCHAR2(70);
  l_result VARCHAR2(70);
BEGIN
  l_int := 0;
  l_nmk := p_nmk;

  -- удаляем лишние пробелы
  WHILE l_int < LENGTH(p_nmk)
  LOOP
     l_nmk := replace (l_nmk, '  ', ' ');
     l_int := l_int + 1;
  END LOOP;

  -- позиция первого пробела
  l_1space := INSTR(l_nmk, ' ');
  IF l_1space = 0  THEN
     IF p_par = 1  THEN l_result := l_nmk;
     ELSE               l_result := '';
     END IF;
     RETURN l_result;
  END IF;

  -- позиция второго пробела
  l_2space := INSTR(SUBSTR(l_nmk, l_1space + 1), ' ');
  IF l_2space = 0 THEN
     IF    p_par = 1 THEN
        SELECT SUBSTR(l_nmk, 1, l_1space - 1) INTO l_result FROM dual;
     ELSIF p_par = 2 THEN
        SELECT substr(l_nmk, l_1space + 1)    INTO l_result FROM  dual;
     ELSIF p_par = 3 THEN
        l_result := '';
     END IF;
     RETURN l_result;
  END IF;

  IF    p_par = 1 THEN
        SELECT SUBSTR(l_nmk, 1, l_1space-1) INTO l_result FROM dual;
  ELSIF p_par = 2 THEN
        SELECT SUBSTR(SUBSTR(l_nmk, l_1space+1), 1, l_2space-1) INTO l_result FROM dual;
  ELSIF p_par = 3 THEN
        SELECT SUBSTR(l_nmk, l_1space + l_2space + 1) INTO l_result FROM dual;
  END IF;
  RETURN l_result;

END FIO;
 
/
 show err;
 
PROMPT *** Create  grants  FIO ***
grant EXECUTE                                                                on FIO             to BARSUPL;
grant EXECUTE                                                                on FIO             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FIO             to BARS_DM;
grant EXECUTE                                                                on FIO             to DPT_ROLE;
grant EXECUTE                                                                on FIO             to START1;
grant EXECUTE                                                                on FIO             to UPLD;
grant EXECUTE                                                                on FIO             to WR_ALL_RIGHTS;
grant EXECUTE                                                                on FIO             to BARS_INTGR;
