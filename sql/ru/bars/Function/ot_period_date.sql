
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/ot_period_date.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.OT_PERIOD_DATE 
  (dat_  DATE,
   type_ NUMBER,
   dat2_ DATE   DEFAULT NULL,
   vidd_ NUMBER DEFAULT 0)
  RETURN DATE deterministic
IS
/******************************************************************************
 Название  : ot_period_date
 Назначение: Функция дял определения даты
 Версия    : 1 от 03.10.2006

 Параметры :
 type_ = 0 - поточний період (при vidd_ = 0 - календарна, інакше - банківська)
         1 - попередній період (по default-у - тиждень)
         2 - аналогічна дата минулого місяця
         3 - аналогіча дата минулого року
 vidd_ = 0 - календарні дати
         1 - банківські (робочі) дні

 Изменения и дополнения:
 Дата      Автор  Описание
 --------  ------ -------------------------------------------------------------
 03.10.06  VIRKO  1. Создание функции
******************************************************************************/
  rdat_   DATE := dat_;
  period_ NUMBER;
BEGIN
  CASE type_
     WHEN 0 THEN
 	  rdat_ := dat_;
     WHEN 1 THEN
          rdat_ := dat_ - 7;
     WHEN 2 THEN
          IF dat2_ IS NULL OR dat_ = dat2_ THEN
             rdat_ := add_months(dat_, -1);
          ELSE
             period_ := dat2_ - dat_;
             rdat_ := add_months(dat2_, -1) - period_;
          END IF;
     WHEN 3 THEN
          IF dat2_ IS NULL OR dat_ = dat2_ THEN
             rdat_ := add_months(dat_, -12);
          ELSE
             period_ := dat2_ - dat_;
             rdat_ := add_months(dat2_, -12) - period_;
          END IF;
     ELSE
          rdat_ := dat_;
  END CASE;

  IF vidd_ = 1 THEN
     SELECT max(fdat) INTO rdat_ FROM fdat WHERE fdat <= rdat_;
  END IF;

  RETURN rdat_;

END;
/
 show err;
 
PROMPT *** Create  grants  OT_PERIOD_DATE ***
grant EXECUTE                                                                on OT_PERIOD_DATE  to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/ot_period_date.sql =========*** End
 PROMPT ===================================================================================== 
 