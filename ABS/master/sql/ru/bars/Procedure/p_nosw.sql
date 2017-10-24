

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NOSW.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NOSW ***

  CREATE OR REPLACE PROCEDURE BARS.P_NOSW (
RefCvv_ NUMBER,
RefNos_ NUMBER,
NosBic_ VARCHAR2,
NosAcc_ NUMBER ) IS
--***************************************************************--
-- (C) BARS. P_NOSW - Заполнение доп.реквизитов на подборе КС.
-- Version 1.2 13/12/2007
--***************************************************************--
ern     CONSTANT POSITIVE := 101;
err     EXCEPTION;
erm     VARCHAR2(80);
BEGIN
  -- Для первичного документа заполняем Банк NOSTRO 'NOS_B'
  INSERT INTO OPERW(REF, tag, value) VALUES(RefCvv_, 'NOS_B', NosBic_);
  -- Для первичного документа заполняем Счет NOSTRO 'NOS_A'
  UPDATE OPERW SET value=NosAcc_ WHERE REF=RefCvv_ AND tag='NOS_A';
  -- Копируем доп. реквизиты документа в NOS
  INSERT INTO OPERW(REF, tag, value)
  SELECT RefNos_, tag, value FROM OPERW WHERE REF=RefCvv_;
  -- Для документа NOS сохраняем референс первичного документв
  INSERT INTO OPERW(ref, tag, value) VALUES(RefNos_, 'NOS_R', RefCvv_);
  -- Дополняем реквизиты для 1PB
  P_rekw_1pb(RefNos_, NosAcc_);
  -- удаляем из очереди
  delete from sw_nostro_que
   where ref = refcvv_;
EXCEPTION WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-(20000+ern),SQLERRM,TRUE);
END;
/
show err;

PROMPT *** Create  grants  P_NOSW ***
grant EXECUTE                                                                on P_NOSW          to BARS013;
grant EXECUTE                                                                on P_NOSW          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NOSW.sql =========*** End *** ==
PROMPT ===================================================================================== 
