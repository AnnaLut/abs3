
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/split.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SPLIT (in_str VARCHAR2) RETURN number_list PIPELINED
IS
    last_pos number;
BEGIN
   IF in_str IS NULL THEN RETURN; END IF;
   last_pos := 1;
   FOR i IN 1..(length(in_str) - length(replace(in_str,',',''))) LOOP
         PIPE ROW (SUBSTR(in_str,last_pos,instr(in_str,',',1,i)-last_pos));
         last_pos := instr(in_str,',',1,i) + 1;
   END LOOP;
   PIPE ROW (SUBSTR(in_str,last_pos,length(in_str)));
   RETURN;
END;
/
 show err;
 
PROMPT *** Create  grants  SPLIT ***
grant EXECUTE                                                                on SPLIT           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SPLIT           to PYOD001;
grant EXECUTE                                                                on SPLIT           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/split.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 