
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_newnls2old.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NEWNLS2OLD 
 ( acc2_        INT,             -- ACC счета
   descrname_   VARCHAR2,        -- тип счета
   nbs2_        VARCHAR2,        -- номер балансового счета
   rnk2_        INT,             -- регистрационный номер клиента
   idd2_        INT,             -- номер вклада
   kv_          NUMBER DEFAULT 0, -- валюта
   inmask_      VARCHAR2 default '' --
 )
RETURN NUMBER
IS
  -- ******************** версия 16 от 04-07-06 *****************************
  RNK_    int;
  ACC_    int;
  IDD_    int;
  NBS_    varchar2(4);
  CUR_    NUMBER;
  NLSNEW_ varchar2(15) ;  NLSTMP_ varchar2(15) ;  MASK_   varchar2(15) ;
  S1_     varchar2(15) ;  S2_     varchar2(15) ;  S3_     varchar2(15) ;
  NN_     int          ;  LEN_    int          ;  NMASK_  int          ;
  LEN2_   int          ;  C       INTEGER      ;  I       INTEGER      ;
  AMFO5_  varchar2(12) ;  NPOS_   number       ;  NLEN_   number       ;
  bpos_   int          ;  pos_    integer      ;  nlsnew1_       VARCHAR2 (15);
  numsimbol_     VARCHAR2 (1);
  ern CONSTANT POSITIVE   := 208;
  err EXCEPTION;
  erm VARCHAR2(80);
  l_bind_nls  varchar2(30);
BEGIN
  AMFO5_ :=substr(gl.aMFO,1,5);
  RNK_   :=RNK2_;
  ACC_   :=ACC2_;
  IDD_   :=IDD2_;
  NBS_   :=NBS2_;

  BEGIN
    IF ACC_    is not null and RNK_ is null   then
       SELECT rnk INTO RNK_ FROM cust_acc    WHERE acc=ACC_  and rownum=1 ;
    ELSIF RNK_ is not null  then
       SELECT rnk INTO RNK_ FROM customer    WHERE rnk=RNK_  and rownum=1 ;
    ELSIF RNK_ is null and IDD_ is not null then
       SELECT RNK INTO RNK_ FROM dpu_deal WHERE dpu_id=IDD_  and rownum=1
       union
       SELECT RNK FROM dpt_deposit WHERE deposit_id=IDD_     and rownum=1;
    ELSE
       RETURN to_number(null) ;
    END IF;

    IF trim(inmask_) IS NOT NULL THEN
      mask_:=inmask_;
    ELSE

      SELECT UPPER (NVL (nbs_, SUBSTR (MASK, 1, 4)) || SUBSTR (MASK, 5, 10))
       INTO mask_
       FROM nlsmask
      WHERE maskid = descrname_;

    END IF;


  EXCEPTION
    WHEN OTHERS THEN
      RETURN TO_NUMBER (NULL);
  END;

   -- расчертить цифрами счет BBBB1000000000
   len2_ := LENGTH (mask_);
   nlsnew_ := SUBSTR (mask_, 1, 4) || '1' || SUBSTR (mask_, 6, 9);
   npos_ := 0;

   -- замены из динамического селекта
   FOR k IN (SELECT UPPER (typeid) typeid, sqlval FROM newnlsdescr)
   LOOP
     BEGIN
       -- находим вхождение
       bpos_ := INSTR (mask_, k.typeid);

       IF bpos_ > 0 THEN
          pos_ := bpos_;
          len_ := 0;

          WHILE SUBSTR (mask_, pos_, 1) = k.typeid
          LOOP
            pos_ := pos_ + 1;
            len_ := len_ + 1;
          END LOOP;

          s1_ := SUBSTR (nlsnew_, 1, bpos_ - 1);
          s3_ := SUBSTR (nlsnew_, bpos_ + len_, len2_ - bpos_ - len_ + 1);

          IF k.typeid = 'N' OR k.typeid = '№' THEN    -- порядковый номер
             npos_ := bpos_;
             nlen_ := len_;
             numsimbol_ := k.typeid;
          ELSE                                        -- динамический SQL
             c := DBMS_SQL.open_cursor;                    --открыть курсор
             DBMS_SQL.parse (c, k.sqlval, DBMS_SQL.native);

             --приготовить дин.SQL
             IF    SUBSTR (k.sqlval, -4) = ':RNK'  THEN
                   DBMS_SQL.bind_variable (c, ':RNK', rnk_);
             ELSIF SUBSTR (k.sqlval, -4) = ':ACC'  THEN
                   DBMS_SQL.bind_variable (c, ':ACC', acc_);
             ELSIF SUBSTR (k.sqlval, -4) = ':IDD'  THEN
                   DBMS_SQL.bind_variable (c, ':IDD', idd_);
             ELSIF SUBSTR (k.sqlval, -4) = ':NBS'  THEN
                   DBMS_SQL.bind_variable (c, ':NBS', nbs_);
             ELSIF SUBSTR (k.sqlval, -4) = ':CUR'  THEN
                   DBMS_SQL.bind_variable (c, ':CUR', kv_);
             END IF;

             DBMS_SQL.define_column (c, 1, s2_, 15);
             --установить знач колонки в SELECT
             i := DBMS_SQL.EXECUTE (c);       --выполнить приготовленный SQL
             --DBMS_OUTPUT.put_line (k.sqlval);

             IF DBMS_SQL.fetch_rows (c) > 0 THEN   --прочитать
                DBMS_SQL.column_value (c, 1, s2_);
                --снять результирующую переменную
             END IF;

             --DBMS_OUTPUT.put_line ('s2_=' || s2_);
             --DBMS_OUTPUT.put_line ('len_=' || TO_CHAR (len_));
             DBMS_SQL.close_cursor (c);                    -- закрыть курсор
             nlsnew_ := s1_ || SUBSTR ('0000000000' || s2_, -len_) || s3_;
             --DBMS_OUTPUT.put_line (nlsnew_);

          END IF;

         END IF;

     END;

   END LOOP;

   -- замена нецифровых символов на '0'
   DECLARE
      nls1_   VARCHAR2 (15);
      c_      CHAR (1);
   BEGIN
     FOR k IN 1 .. len2_
     LOOP
       c_ := SUBSTR (nlsnew_, k, 1);

       IF c_ < '0' OR c_ > '9' THEN
          c_ := '0';
       END IF;

       nls1_ := nls1_ || c_;
     END LOOP;

     nlsnew_ := nls1_;
   END;

   --обрабатываем порядковый номер
   IF npos_ > 0 THEN
      --
      if numsimbol_ in ('N', '№') then
        -- оптимизация: выражение для сравнения лицевого сохраняем в переменной
        l_bind_nls := SUBSTR (nlsnew_, 1, 4)
           || '_'
           || SUBSTR (nlsnew_, 6, npos_ - 6)
           || LPAD ('_', nlen_, '_')
           || SUBSTR (nlsnew_, npos_ + nlen_);
      end if;
      --
      IF numsimbol_ = 'N' THEN
         SELECT MAX (TO_NUMBER(NVL(LTRIM(SUBSTR(nls,npos_,nlen_),'0'),'0')))+1
           INTO nn_
         FROM accounts WHERE nls LIKE l_bind_nls;
      ELSIF numsimbol_ = '№' THEN
        -- Этот блок предназаначен для обработки маски нумерации для мультивал.
        -- счетов (если определен параметр функции KV_ и маска нумерации №№)
        SELECT MAX(TO_NUMBER(NVL(LTRIM(SUBSTR(nls,npos_,nlen_),'0'),'0')))+1
          INTO nn_
        FROM accounts WHERE kv = kv_ AND nls LIKE l_bind_nls;
      END IF;

      -- Этот блок предназаначен для обработки ситуации переполнения счетчика,
      -- т.е. типа NN = '99'. Обработка предусмотрена если NN последний в маске.
      -- R.A.

      IF nn_ = TO_NUMBER(SUBSTR('99999999999999',-nlen_))+1 AND
         len2_ = npos_ + nlen_ - 1
      THEN
        l_bind_nls := SUBSTR (nlsnew_, 1, 4)
                       || '_'
                       || SUBSTR (nlsnew_, 6, npos_ - 6)
                       || '%';
        SELECT MAX(TO_NUMBER(NVL(LTRIM(SUBSTR(nls,npos_),'0'),'0')))
          INTO nn_
        FROM accounts WHERE nls LIKE l_bind_nls;
        --
        nlen_ := LENGTH (TO_CHAR (nn_));
      END IF;

      IF nn_ IS NULL OR nn_ = 0 THEN
         nn_ := 0; -- 1
      END IF;

      nlsnew_ := SUBSTR (nlsnew_, 1, npos_ - 1)
              || SUBSTR ('0000000000' || TO_CHAR (nn_), -nlen_)
              || SUBSTR (nlsnew_,
                         npos_ + nlen_,
                         LENGTH (nlsnew_) - npos_ - nlen_ + 1 );
   END IF;

   RETURN TO_NUMBER (vkrzn (amfo5_, nlsnew_));

END f_newnls2old;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_newnls2old.sql =========*** End *
 PROMPT ===================================================================================== 
 