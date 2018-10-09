CREATE OR REPLACE FUNCTION BARS.F_NEWNLS2 
( acc2_       INT,                -- ACC счета
  descrname_  VARCHAR2,           -- тип счета
  nbs2_       VARCHAR2,           -- номер балансового счета
  rnk2_       INT,                -- регистрационный номер клиента
  idd2_       INT,                -- номер вклада
  kv_         NUMBER DEFAULT 0,   -- валюта
  inmask_     VARCHAR2 default ''
) RETURN NUMBER
IS
--версия 20 от 24-02-2012 (автор неизвестен)
  RNK_        int;
  ACC_        int;
  IDD_        int;
  NBS_        varchar2(4);
  CUR_        NUMBER;
  NLSNEW_     varchar2(15);
  NLSTMP_     varchar2(15);
  MASK_       varchar2(15);
  S1_         varchar2(15);
  S2_         varchar2(15);
  S3_         varchar2(15);
  NN_         int;
  LEN_        int;
  NMASK_      int;
  LEN2_       int;
  C           INTEGER;
  I           INTEGER;
  AMFO5_      varchar2(12);
  NPOS_       number;
  NLEN_       number;
  bpos_       int;
  pos_        integer;
  nlsnew1_    VARCHAR2(15);
  nlsfin_     VARCHAR2(15);
  i_          int;
  find_       int;
  numsimbol_  VARCHAR2(1);
  ern         CONSTANT POSITIVE := 208;
  err         EXCEPTION;
  erm         VARCHAR2(80);
  l_bind_nls  varchar2(30);
BEGIN
  AMFO5_ := substr(gl.aMFO,1,5);
  RNK_   := RNK2_;
  ACC_   := ACC2_;
  IDD_   := IDD2_;
  NBS_   := NBS2_;

  BEGIN
    IF ACC_    is not null and RNK_ is null   then
      SELECT rnk INTO RNK_ FROM cust_acc WHERE acc=ACC_    and rownum=1;
    ELSIF RNK_ is not null  then
      SELECT rnk INTO RNK_ FROM customer WHERE rnk=RNK_    and rownum=1;
    ELSIF RNK_ is null and IDD_ is not null then
      SELECT RNK INTO RNK_ FROM dpu_deal WHERE dpu_id=IDD_ and rownum=1
     union
      SELECT RNK FROM dpt_deposit WHERE deposit_id=IDD_    and rownum=1;
    ELSE
      RETURN to_number(null);
    END IF;

    IF trim(inmask_) IS NOT NULL THEN
      mask_ := inmask_;
    ELSE

      SELECT UPPER(NVL(nbs_,SUBSTR(MASK,1,4))||SUBSTR(MASK,5,10))
      INTO   mask_
      FROM   nlsmask
      WHERE  maskid = descrname_;

    END IF;

  EXCEPTION
    WHEN OTHERS THEN
      RETURN TO_NUMBER(NULL);
  END;

  -- расчертить цифрами счет BBBB1000000000
  len2_   := LENGTH(mask_);
  nlsnew_ := SUBSTR(mask_,1,4)||'1'||SUBSTR(mask_,6,9);
  npos_   := 0;

--замены из динамического селекта
  FOR k IN ( SELECT UPPER(typeid) typeid, sqlval
               FROM newnlsdescr )
  LOOP
    BEGIN
--    находим вхождение
      bpos_ := INSTR(mask_,k.typeid);

      IF bpos_>0 THEN
        pos_ := bpos_;
        len_ := 0;

        WHILE SUBSTR(mask_,pos_,1)=k.typeid
        LOOP
          pos_ := pos_ + 1;
          len_ := len_ + 1;
        END LOOP;

        s1_ := SUBSTR(nlsnew_, 1, bpos_ -1 );
        s3_ := SUBSTR(nlsnew_,bpos_ + len_, len2_ - bpos_ - len_ + 1);

        IF k.typeid='N' OR k.typeid='№' THEN  -- порядковый номер
          npos_      := bpos_;
          nlen_      := len_;
          numsimbol_ := k.typeid;
        ELSE                          -- динамический SQL
          c := DBMS_SQL.open_cursor;  -- открыть курсор
          DBMS_SQL.parse(c,k.sqlval,DBMS_SQL.native);

          -- приготовить дин.SQL
          IF    SUBSTR(k.sqlval,-4)=':RNK' THEN
                DBMS_SQL.bind_variable(c,':RNK',rnk_);
          ELSIF SUBSTR(k.sqlval,-4)=':ACC' THEN
                DBMS_SQL.bind_variable(c,':ACC',acc_);
          ELSIF SUBSTR(k.sqlval,-4)=':IDD' THEN
                DBMS_SQL.bind_variable(c,':IDD',idd_);
          ELSIF SUBSTR(k.sqlval,-4)=':NBS' THEN
                DBMS_SQL.bind_variable(c,':NBS',nbs_);
          ELSIF SUBSTR(k.sqlval,-4)=':CUR' THEN
                DBMS_SQL.bind_variable(c,':CUR',kv_);
          END IF;

          DBMS_SQL.define_column(c,1,s2_,15);
          -- установить знач. колонки в SELECT
          i := DBMS_SQL.EXECUTE(c);  --выполнить приготовленный SQL
--        DBMS_OUTPUT.put_line (k.sqlval);

          IF DBMS_SQL.fetch_rows(c)>0 THEN  -- прочитать
             DBMS_SQL.column_value(c,1,s2_);
          -- снять результирующую переменную
          END IF;

--        DBMS_OUTPUT.put_line('s2_='||s2_);
--        DBMS_OUTPUT.put_line('len_='||TO_CHAR(len_));
          DBMS_SQL.close_cursor(c);  -- закрыть курсор
          nlsnew_ := s1_||SUBSTR('0000000000'||s2_,-len_)||s3_;
--        DBMS_OUTPUT.put_line(nlsnew_);

        END IF;

      END IF;

    END;

  END LOOP;

--замена нецифровых символов на '0'
  DECLARE
    nls1_  VARCHAR2(15);
    c_     CHAR(1);
  BEGIN
    FOR k IN 1..len2_
    LOOP
      c_ := SUBSTR(nlsnew_, k, 1);

      IF c_ < '0' OR c_ > '9' THEN
        c_ := '0';
      END IF;

      nls1_ := nls1_||c_;
    END LOOP;

    nlsnew_ := nls1_;
  END;

  nlsfin_ := vkrzn(amfo5_,nlsnew_);

--обрабатываем порядковый номер
  IF npos_ > 0 THEN

--  if numsimbol_ in ('N', '№') then
--    оптимизация: выражение для сравнения лицевого сохраняем в переменной
--    l_bind_nls := SUBSTR(nlsnew_,1,4)      ||
--                  '_'                      ||
--                  SUBSTR(nlsnew_,6,npos_-6)||
--                  LPAD('0',nlen_,'0')      ||
--                  SUBSTR(nlsnew_,npos_+nlen_);
--  end if;

    find_ := 0;
    for i_ in 0..power(10,nlen_)-1
    loop
      nlsfin_ := vkrzn(amfo5_,
                 SUBSTR(nlsnew_,1,4)        ||
                 '0'                        ||
                 SUBSTR(nlsnew_,6,npos_-6)  ||
                 LPAD(to_char(i_),nlen_,'0')||
                 SUBSTR(nlsnew_,npos_+nlen_));
      IF    numsimbol_='N' THEN
        begin
          select t.EXST
            into find_
            from ( select 1 as EXST
                     from ACCOUNTS
                    where NLS = nlsfin_
                    union
                   select 1
                     from ACCOUNTS_RSRV
                    where NLS = nlsfin_
                    union  -- COBUMMFO-7501
                   select 1
                     from transform_2017_forecast
                    where new_nls = nlsfin_
                 ) t;
        exception
          when no_data_found then
            find_ := 2;
            exit;
        end;
      ELSIF numsimbol_ = '№' THEN
        -- Этот блок предназаначен для обработки маски нумерации для мультивал.
        -- счетов (если определен параметр функции KV_ и маска нумерации №№)
        begin
          select t.EXST
            into find_
            from ( select 1 as EXST
                     from ACCOUNTS
                    where NLS = nlsfin_
                      and KV  = kv_
                    union
                   select 1
                     from ACCOUNTS_RSRV
                    where NLS = nlsfin_
                      and KV  = kv_
                    union  -- COBUMMFO-7501
                   select 1
                     from transform_2017_forecast
                    where new_nls = nlsfin_
                      and KV  = kv_
                 ) t;
        exception when no_data_found then
          find_ := 2;
          exit;
        end;
      END IF;
    end loop;

    if find_<>2 then
      find_ := 0;
      for i_ in 0..power(10,14-npos_)-1
      loop
        nlsfin_ := vkrzn(amfo5_,
                   SUBSTR(nlsnew_,1,4)      ||
                   '0'                      ||
                   SUBSTR(nlsnew_,6,npos_-6)||
                   to_char(i_));
        IF    numsimbol_='N' THEN
          begin
            select t.EXST
              into find_
              from ( select 1 as EXST
                       from ACCOUNTS
                      where nls = nlsfin_
                      union
                     select 1
                       from ACCOUNTS_RSRV
                      where nls = nlsfin_
                      union  -- COBUMMFO-7501
                     select 1
                       from transform_2017_forecast
                      where new_nls = nlsfin_
                   ) t;
          exception
            when no_data_found then
              find_ := 2;
              exit;
          end;
        ELSIF numsimbol_ = '№' THEN
          begin
            select t.EXST
              into find_
              from ( select 1 as EXST
                       from ACCOUNTS
                      where NLS = nlsfin_
                        and KV  = kv_
                      union
                     select 1
                       from ACCOUNTS_RSRV
                      where NLS = nlsfin_
                        and KV  = kv_
                      union  -- COBUMMFO-7501
                     select 1
                       from transform_2017_forecast
                      where new_nls = nlsfin_
                        and KV  = kv_
                   ) t;
          exception
            when no_data_found then
              find_ := 2;
              exit;
          end;
        END IF;
      end loop;
    end if;

  END IF;

  RETURN TO_NUMBER(nlsfin_);

END f_newnls2;
/

show err;

grant EXECUTE on F_NEWNLS2 to ABS_ADMIN;
grant EXECUTE on F_NEWNLS2 to BARS_ACCESS_DEFROLE;
grant EXECUTE on F_NEWNLS2 to CUST001;
grant EXECUTE on F_NEWNLS2 to RCC_DEAL;
grant EXECUTE on F_NEWNLS2 to START1;
grant EXECUTE on F_NEWNLS2 to WR_ALL_RIGHTS;
grant EXECUTE on F_NEWNLS2 to WR_VIEWACC;
