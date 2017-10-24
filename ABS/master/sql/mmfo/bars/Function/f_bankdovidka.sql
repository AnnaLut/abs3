
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_bankdovidka.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BANKDOVIDKA (MODE_ VARCHAR2, ACC_ VARCHAR2) RETURN VARCHAR2 IS
MonthYear VARCHAR2(20);
Period    VARCHAR2(32);
dd_       VARCHAR2(2);
mm_       VARCHAR2(2);
yyyy_     VARCHAR2(4);
DebOB     VARCHAR2(20);
KreOB     VARCHAR2(20);
-- Макаренко И.В. 07/2009 v1,01 --
-- в зависимости от переданного значения MODE функция возвращает
-- необходимые данные для заполнения банковской справки о состоянии карт.счета
--
-- режимы работы функции :
--     1М ... 6М - возвращием назавание месяца и год за последние полгода
--     1DT ... 6DT - дебетовые обороты за последние полгода (помесячно)
--     1KT ... 6KT - дебетовые обороты за последние полгода (помесячно)
BEGIN

  IF MODE_ LIKE 'PERIOD%' THEN

    SELECT to_char(to_date(CURRENT_DATE),'dd'),
           to_number(to_char(to_date(CURRENT_DATE),'mm')),
           to_char(to_date(CURRENT_DATE),'yyyy' )
    INTO dd_, mm_, yyyy_ FROM dual;

    IF    mm_ = 1 THEN
      mm_ := 7;  yyyy_ := to_number(yyyy_)-1;
    ELSIF mm_ = 2 THEN
      mm_ := 8;  yyyy_ := to_number(yyyy_)-1;
    ELSIF mm_ = 3 THEN
      mm_ := 9;  yyyy_ := to_number(yyyy_)-1;
    ELSIF mm_ = 4 THEN
      mm_ := 10; yyyy_ := to_number(yyyy_)-1;
    ELSIF mm_ = 5 THEN
      mm_ := 11; yyyy_ := to_number(yyyy_)-1;
    ELSIF mm_ = 6 THEN
      mm_ := 12; yyyy_ := to_number(yyyy_)-1;
    ELSE
      mm_ := to_number(mm_)-6;
    END IF;

    Period := 'з '||to_char(to_date('01/'||mm_||'/'||yyyy_,'DD/MM/YYYY'),'DD/MM/YYYY')||' p. по ';

    SELECT to_char(to_date(CURRENT_DATE),'dd'),
           to_number(to_char(to_date(CURRENT_DATE),'mm')),
           to_char(to_date(CURRENT_DATE),'yyyy' )
    INTO dd_, mm_, yyyy_ FROM dual;

    IF mm_ = 1 THEN
      mm_ := 12; yyyy_ := to_number(yyyy_)-1;
    ELSE
      mm_ := to_number(mm_)-1;
    END IF;

    -- dd_ замінено на 01 оскільки виникала проблема з 29 лютого у НЕ високосному році
    --Period := Period||to_char(LAST_DAY(to_date(dd_||'/'||mm_||'/'||yyyy_,'DD/MM/YYYY')),'DD/MM/YYYY')||' p.';
    Period := Period||to_char(LAST_DAY(to_date('01/'||mm_||'/'||yyyy_,'DD/MM/YYYY')),'DD/MM/YYYY')||' p.';

  END IF;

  IF MODE_ IN ('1M', '2M', '3M', '4M', '5M', '6M',
               '1DT','2DT','3DT','4DT','5DT','6DT',
               '1KT','2KT','3KT','4KT','5KT','6KT') THEN

    SELECT to_char(to_date(CURRENT_DATE),'dd'),
           to_number(to_char(to_date(CURRENT_DATE),'mm')),
           to_char(to_date(CURRENT_DATE),'yyyy' )
    INTO dd_, mm_, yyyy_ FROM dual;

    IF MODE_ IN ('1M','1DT','1KT') THEN
      CASE
        WHEN mm_ = 1 THEN
             mm_ := 7;  yyyy_ := to_number(yyyy_)-1;
        WHEN mm_ = 2 THEN
             mm_ := 8;  yyyy_ := to_number(yyyy_)-1;
        WHEN mm_ = 3 THEN
             mm_ := 9;  yyyy_ := to_number(yyyy_)-1;
        WHEN mm_ = 4 THEN
             mm_ := 10; yyyy_ := to_number(yyyy_)-1;
        WHEN mm_ = 5 THEN
             mm_ := 11; yyyy_ := to_number(yyyy_)-1;
        WHEN mm_ = 6 THEN
             mm_ := 12; yyyy_ := to_number(yyyy_)-1;
        ELSE mm_ := mm_-6;
      END CASE;
    END IF;

    IF MODE_ IN ('2M','2DT','2KT') THEN
      CASE
        WHEN to_number(mm_) = 1 THEN
             mm_ := 8;   yyyy_ := to_number(yyyy_)-1;
        WHEN to_number(mm_) = 2 THEN
             mm_ := 9;   yyyy_ := to_number(yyyy_)-1;
        WHEN to_number(mm_) = 3 THEN
             mm_ := 10;  yyyy_ := to_number(yyyy_)-1;
        WHEN to_number(mm_) = 4 THEN
             mm_ := 11; yyyy_ := to_number(yyyy_)-1;
        WHEN to_number(mm_) = 5 THEN
             mm_ := 12; yyyy_ := to_number(yyyy_)-1;
        ELSE mm_ := mm_-5;
      END CASE;
    END IF;

    IF MODE_ IN ('3M','3DT','3KT') THEN
      CASE
        WHEN to_number(mm_) = 1 THEN
             mm_ := 9;   yyyy_ := to_number(yyyy_)-1;
        WHEN to_number(mm_) = 2 THEN
             mm_ := 10;  yyyy_ := to_number(yyyy_)-1;
        WHEN to_number(mm_) = 3 THEN
             mm_ := 11;  yyyy_ := to_number(yyyy_)-1;
        WHEN to_number(mm_) = 4 THEN
             mm_ := 12; yyyy_ := to_number(yyyy_)-1;
        ELSE mm_ := mm_-4;
      END CASE;
    END IF;

    IF MODE_ IN ('4M','4DT','4KT') THEN
      CASE
        WHEN to_number(mm_) = 1 THEN
             mm_ := 10;  yyyy_ := to_number(yyyy_)-1;
        WHEN to_number(mm_) = 2 THEN
             mm_ := 11;  yyyy_ := to_number(yyyy_)-1;
        WHEN to_number(mm_) = 3 THEN
             mm_ := 12;  yyyy_ := to_number(yyyy_)-1;
        ELSE mm_ := mm_-3;
      END CASE;
    END IF;

    IF MODE_ IN ('5M','5DT','5KT') THEN
      CASE
        WHEN to_number(mm_) = 1 THEN
             mm_ := 11;  yyyy_ := to_number(yyyy_)-1;
        WHEN to_number(mm_) = 2 THEN
             mm_ := 12;  yyyy_ := to_number(yyyy_)-1;
        ELSE mm_ := mm_-2;
      END CASE;
    END IF;

    IF MODE_ IN ('6M','6DT','6KT') THEN
      CASE
        WHEN to_number(mm_) = 1 THEN
             mm_ := 12;  yyyy_ := to_number(yyyy_)-1;
        ELSE mm_ := mm_-1;
      END CASE;
    END IF;

    SELECT substr(upper(name_plain),1,1)||substr(name_plain,2,100)||' '||yyyy_||' p.'
      INTO MonthYear FROM meta_month WHERE n=mm_;

    SELECT to_char(FDOS(ACC_,to_date('01/'||mm_||'/'||yyyy_,'DD/MM/YYYY'),
                             LAST_DAY(to_date('01/'||mm_||'/'||yyyy_,'DD/MM/YYYY')))/100,
                   '999G999G999G990D99')
      INTO DebOB FROM DUAL;

    SELECT to_char(FKOS(ACC_,to_date('01/'||mm_||'/'||yyyy_,'DD/MM/YYYY'),
                             LAST_DAY(to_date('01/'||mm_||'/'||yyyy_,'DD/MM/YYYY')))/100,
                   '999G999G999G990D99')
      INTO KreOB FROM DUAL;

  END IF;

  IF MODE_ LIKE 'PERIOD%' THEN
    RETURN Period;
  ELSE
    IF MODE_ IN ('1DT','2DT','3DT','4DT','5DT','6DT') THEN
      RETURN DebOB;
    ELSE
      IF MODE_ IN ('1KT','2KT','3KT','4KT','5KT','6KT') THEN
        RETURN KreOB;
      ELSE
        RETURN MonthYear;
      END IF;
    END IF;
  END IF;

END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_bankdovidka.sql =========*** End 
 PROMPT ===================================================================================== 
 