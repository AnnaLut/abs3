

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BLOCK_RRP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BLOCK_RRP ***

  CREATE OR REPLACE PROCEDURE BARS.P_BLOCK_RRP (par_ INTEGER, par2_ VARCHAR2) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура блокировки РРЦ ( 1- входное направление )
% COPYRIGHT   : Макаренко И.В.
% VERSION     : 05/03/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  Flag_ NUMBER := 0;
BEGIN

  BEGIN
    SELECT 1
      INTO Flag_
      FROM dual
     WHERE trim(substr(to_char(trunc(sysdate),'DD/MM/YYYY'),4,2)||substr(to_char(trunc(sysdate),'DD/MM/YYYY'),1,2))=par2_;  
  EXCEPTION 
       WHEN no_data_found THEN
        raise_application_error(-20000, 'Введено невірний пароль !', TRUE);
  END;

  BEGIN
    SELECT 1
      INTO Flag_
      FROM dual 
     WHERE sysdate >= to_date(to_char(trunc(sysdate),'DD/MM/YYYY')||' 19:45:00','DD/MM/YYYY HH24:MI:SS');
  EXCEPTION 
       WHEN no_data_found THEN
        raise_application_error(-20000, 'Заборонено блокування РРЦ до 19:45 !', TRUE);
  END;
      
  FOR i IN ( SELECT l.mfo, l.kv, b.ru_name 
               FROM lkl_rrp l, v_banks_ru b
              WHERE l.mfo NOT IN ('300465','321024','999984','999999')
                AND l.blk < 1
                AND l.mfo = b.mfo 
              ORDER by l.mfo, l.kv )
  LOOP

     UPDATE lkl_rrp SET blk=par_ WHERE mfo=i.mfo AND kv=i.kv;
     COMMIT;

     bars_audit.info('TECH-GRC. ' || i.mfo || '/' || i.kv ||
                     ' - ' || trim(i.ru_name) || ' => вхідний напрямок заблоковано.');

  END LOOP;

END;
/
show err;

PROMPT *** Create  grants  P_BLOCK_RRP ***
grant EXECUTE                                                                on P_BLOCK_RRP     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_BLOCK_RRP     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BLOCK_RRP.sql =========*** End *
PROMPT ===================================================================================== 
