
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_stop_zo.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_STOP_ZO (p_ref oper.ref%type)
   RETURN NUMERIC
IS
   --------------------------------------
   ern   CONSTANT POSITIVE := 803;
   err            EXCEPTION;
   erm            VARCHAR2 (250);
   --------------------------------------
   current_day    NUMBER;
   day_zo         NUMBER;
   par_zo         NUMBER;
   l_nlsa        oper.nlsa%type;
   l_nlsb        oper.nlsb%type;
   l_cnt_a       number :=0;
   l_cnt_b       number :=0;

--------------------------------------
BEGIN
   current_day := to_number(TO_CHAR((TRUNC (gl.bd)),'DD'));

   par_zo := to_number(f_get_params('DAY_ZO'));

   if to_char(trunc(sysdate, 'MM'),'DD/MM') = '01/01' then
     par_zo := 10;
   end if;

   DAY_ZO := to_number(to_char(dat_next_u(trunc(sysdate, 'MM'),0),'DD')) + par_zo;

  select nlsa, nlsb
    into l_nlsa, l_nlsb
    from oper where ref=p_ref;

   select count(*) into l_cnt_a from srezerv_ob22 where nbs=substr(l_nlsa,1,4) and nbs not in ('3510','3519','3559', '3552', '3550', '3551');
   select count(*) into l_cnt_b from srezerv_ob22 where nbs=substr(l_nlsb,1,4) and nbs not in ('3510','3519','3559', '3552', '3550', '3551');



   IF (current_day > day_zo and l_cnt_a>0)
   or (current_day > day_zo and l_cnt_b>0)
   THEN
      erm :=
         'Увага!!! Корегуючі проводки заборонено вводити пізніше  '
         || day_zo
         || '   числа!!!';
      RAISE err;
   END IF;

   RETURN 0;
EXCEPTION
   WHEN err
   THEN
      raise_application_error (- (20000 + ern), '\' || erm, TRUE);
   WHEN OTHERS
   THEN
      raise_application_error (
         - (20000 + ern),
            DBMS_UTILITY.format_error_stack ()
         || CHR (10)
         || DBMS_UTILITY.format_error_backtrace (),
         TRUE);
END;
/
 show err;
 
PROMPT *** Create  grants  F_STOP_ZO ***
grant EXECUTE                                                                on F_STOP_ZO       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_STOP_ZO       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_stop_zo.sql =========*** End *** 
 PROMPT ===================================================================================== 
 