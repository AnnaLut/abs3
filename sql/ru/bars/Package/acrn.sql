create or replace package ACRN
is

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'версия 5.13 22/06/2017';
G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := ''
    ||'    DPT - используется модуль DPT'||chr(10)
    ||'    HO  - начисление по календарным дням '||chr(10)
    ||'ACR_DAT - с возможностью СТОРНО начисленных процентов'||chr(10)
;

SumO  NUMBER := 0;  -- Сумма остатков
SumOP NUMBER := 0;  -- Сумма остатков на процент
SumOD NUMBER := 0;  -- Количество дней сумма остатков за
cOST  NUMBER;       -- Текущий остаток по САЛЬДО-ХО-ХО

function header_version return varchar2;
function body_version return varchar2;
function ver return varchar2;

cur_Basey  NUMBER;
cur_Nomin  number;
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE 	: p0_acr
%
% DESCRIPTION	: Start of day Interest acrual
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE p0_acr( dt_ DATE, acc_ INTEGER DEFAULT NULL );

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE 	: p_nbs
%
% DESCRIPTION	: Returns Base Rate AND SUM(amount*rate)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

procedure P_BNS
( rat_       out number                -- rate
, amnt_      out number                -- SUM(amount*rate)
, dat_    in     date                  -- efective date
, nb_     in     smallint              -- base rate code
, kv_     in     smallint              -- currency code
, ostf_   in     number                -- account balance
, op_     in     smallint default null -- rate amend op code
, amnd_   in     number   default null -- rate amend value
, kf_     in     varchar  default null -- 
);

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE 	: p_int
%
% DESCRIPTION	: Calculates interest for given amount at given account
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE p_int( acc_ INTEGER, -- Account number
                  id_ SMALLINT,-- Calc code
                 dt1_ DATE,    -- From date
                 dt2_ DATE,    -- To   date
                 int_ OUT NUMBER, -- Interest accrued
                 ost_ DECIMAL  DEFAULT NULL,
                mode_ SMALLINT DEFAULT 0); -- Mode   Play/Real


/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION 	: dlta
%
% DESCRIPTION	: Returns number of days for %% acrual between two dates
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

FUNCTION dlta(bas_ NUMBER,
             bdat_ DATE,
             tdat_ DATE) RETURN INTEGER;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE 	: p_cnds
%
% DESCRIPTION	: Condencing of rate history
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE p_cnds;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION 	: fproc
%
% DESCRIPTION	: Returns interest rate on given date
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

FUNCTION FPROC(acc_ INTEGER,
              datp_ DATE DEFAULT NULL) RETURN NUMBER;

-- (Inna) PRAGMA RESTRICT_REFERENCES (FPROC, WNDS );

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION 	: fprocN
%
% DESCRIPTION	: Returns interest rate on given date
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

FUNCTION FPROCN(acc_ INTEGER, id_ INTEGER,
              datp_ DATE DEFAULT NULL) RETURN NUMBER;

-- (Inna) PRAGMA RESTRICT_REFERENCES (FPROCN, WNDS );

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TYPE:    AccRecTyp, AccCurTyp
%
% DESCRIPTION: Типы записи и курсора для работы универсаных процедур
%              начисления процентов
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

   -- Даный тип записи подлежит расширению, в случае, если необходимо
   -- добавить доп. параметры в проводки начисления процентов
   TYPE AccRecTyp IS RECORD (
      -- Счет, по которому выполняется начисление
      acc           BARS.ACCOUNTS.ACC%TYPE,
      -- Дата по которую начисляются проценты
	  end_date      DATE,
	  -- Вид документа для проводки начисления и выплаты процентов
	  vob           BARS.VOB.VOB%TYPE,
	  -- Назначение платежа для конкретной проводки
	  nazn          BARS.OPER.NAZN%TYPE,
	  -- Ид. пользователя, от имени которого выполняется начисление и выплата
	  user_id       BARS.STAFF.ID%TYPE,
	  -- Поддерживать историю начисления, для формирования ведомости начисленых процентов (флаг 0/1)
	  history_flag  NUMBER,
	  -- Выполнять выплату процентов сразу после начисления (флаг 0/1)
	  pay_flag      NUMBER
	  );

   TYPE AccCurTyp IS REF CURSOR RETURN AccRecTyp;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION:    make_int
%
% DESCRIPTION: Универсальная процедура начисления процентов
%                 (проценты начисляются по подмножеству счетов,
%                  которое задается курсором)
% EXAMPLE:
%  DECLARE
%    cur acrN.AccCurTyp;
%  BEGIN
%    OPEN cur FOR
%      SELECT
%  	  acc,
%  	  GL.bDATE end_date,
%  	  6 vob,
%  	  'Начисление % для счета '||NLS||'('||KV||')' nazn,
%  	  user_id,
%  	  1 history_flag,
%  	  0 pay_flag
%  	FROM ACCOUNTS
%  	WHERE NBS = '2630';
%    acrN.MAKE_INT( cur, TRUE );
%  END;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE MAKE_INT(
  -- Курсор, по которому выполняется начисление %
  acc_cur IN AccCurTyp,
  -- Производить ли прогресс-индикацию процесса начисления процентов
  indicate_progress BOOLEAN DEFAULT FALSE  );

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION:    pay_int
%
% DESCRIPTION: Универсальная процедура выплаты процентов
%                 (проценты выплачиваются по подмножеству счетов,
%                  которое задается курсором)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE PAY_INT(
  -- Курсор, по которому выполняется выплата %
  acc_cur IN AccCurTyp,
  -- Производить ли прогресс-индикацию процесса начисления процентов
  indicate_progress BOOLEAN DEFAULT FALSE  );

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   PROCEDURE: acr_dati
%
% DESCRIPTION: Вставка записи-истории о начислении процентов,
%              если, в будущем будет необходимость
%               СТОРНО или персчета процентов.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
PROCEDURE acr_dati (acc_ INTEGER, id_ SMALLINT,
                    ref_ INTEGER, dat_ DATE, remi_ NUMBER);
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   PROCEDURE: acr_back
%
% DESCRIPTION: СТОРНО начисленных процентов на основе
%                истории о начислении процентов,
%               по счету, с заданной по текущую дату.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
PROCEDURE acr_back (acc_ INTEGER, id_ SMALLINT, dat_ DATE);
-- Для вычисления истории остатков по календарным дням
FUNCTION ho_ost ( acc_ NUMBER, fdat_ DATE, delt_ NUMBER, rw_ NUMBER)
RETURN NUMBER;

-- Процедура установки флага работы по накопительной таблице
procedure set_collect_salho(p_collected in number);

-- Функция получения флага работы по накопительной таблице
function get_collect_salho return number deterministic;

  ---
  -- Створення / редагування базової ставки
  ---
  procedure SET_BRATES
  ( p_br_id        in out brates.br_id%type
  , p_br_tp        in     brates.br_type%type default 1
  , p_br_nm        in     brates.name%type
  , p_br_frml      in     brates.formula%type default null
  , p_actv         in     brates.inuse%type   default 1
  , p_cmnt         in     brates.comm%type    default null
  , p_err_msg         out varchar2
  );

  ---
  -- Створення / редагування значення базової ставки
  ---
  procedure SET_BRATE_VAL
  ( p_br_id        in     br_tier_edit.br_id%type
  , p_ccy_id       in     br_tier_edit.kv%type
  , p_eff_dt       in     br_tier_edit.bdate%type
  , p_amnt         in     br_tier_edit.s%type
  , p_rate         in     br_tier_edit.rate%type
  , p_err_msg         out varchar2
  );

  ---
  -- Видалення значення базової ставки
  ---
  procedure DEL_BRATE_VAL
  ( p_br_id        in     br_tier_edit.br_id%type
  , p_ccy_id       in     br_tier_edit.kv%type
  , p_eff_dt       in     br_tier_edit.bdate%type
  , p_amnt         in     br_tier_edit.s%type
  , p_err_msg         out varchar2
  );

END acrN;
/

show errors

----------------------------------------------------------------------------------------------------

create or replace package body ACRN 
IS
  g_body_version constant varchar2(64) := 'версия 5.7 22/06/2017';
  acc_FORM int := null;

  g_acc       number; -- Текущий acc по котрому начисляют

  g_collected number; -- Признак использования накопительной таблицы

  G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := ''
 ||' DPT - используется модуль DPT'||chr(10)
 ||' HO - начисление по календарным дням '||chr(10)
 ||'ACR_DAT - с возможностью СТОРНО начисленных процентов'||chr(10)
;

function header_version return varchar2 is
begin
  return 'Заголовок пакета BARS.ACRN '||G_HEADER_VERSION||'.'||chr(13)||chr(10)
  ||'AWK definition: '||chr(10)
  ||G_AWK_HEADER_DEFS;
end header_version;

function body_version return varchar2 is
begin
  return 'Тело пакета ACRN '||G_BODY_VERSION||'.'||chr(13)||chr(10)
  ||'AWK definition: '||chr(10)
  ||G_AWK_BODY_DEFS;
end body_version;

function ver return varchar2 is
begin
  return 'Package header ACRN '||G_HEADER_VERSION||'.'||chr(10)
  ||'AWK definition: '||chr(10)
  ||G_AWK_HEADER_DEFS||chr(10)||chr(10)||
       'Package  body ACRN '||G_BODY_VERSION||'.'||chr(10)
  ||'AWK definition: '||chr(10)
  ||G_AWK_BODY_DEFS;
end ver;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE 	: p0_acr
%
% DESCRIPTION	: Start of day Interest acrual
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE p0_acr( dt_ DATE, acc_ INTEGER DEFAULT NULL ) IS

dat1_    DATE;
dat2_    DATE;
acrd_    NUMBER;

CURSOR C_ACC IS
   SELECT i.acc,i.id,i.freq,i.acr_dat+1 dat,i.stp_dat dat2,s.kv,s.daos,i.s
     FROM int_accN i,accounts s
     WHERE i.metr in (0,96) AND i.acc=s.acc;
BEGIN


   FOR acc IN C_ACC LOOP

      IF acc.dat IS NULL THEN
         dat1_ := TRUNC(acc.daos);
      ELSE
         dat1_ := TRUNC(acc.dat);
      END IF;

      dat2_ := TRUNC (dt_);

      IF dat2_ > acc.dat2 THEN
         dat2_ := TRUNC(acc.dat2);
      END IF;

      IF acc.freq=1 OR
         acc.freq=3   AND dat2_-dat1_>=7 OR
         acc.freq=5   AND dat2_ >= ADD_MONTHS(dat1_,1) OR
         acc.freq=7   AND dat2_ >= ADD_MONTHS(dat1_,3) OR
         acc.freq=180 AND dat2_ >= ADD_MONTHS(dat1_,6) OR
         acc.freq=360 AND dat2_ >= ADD_MONTHS(dat1_,12) THEN

         p_int(acc.acc,acc.id,dat1_,dat2_,acrd_);

IF deb.debug THEN
   deb.trace(1,TO_CHAR(acc.acc),acrd_);
END IF;
      END IF;

   END LOOP;

END p0_acr;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE 	: p2_acr
%
% DESCRIPTION	: Нычне нарахування відсотків
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE p2_acr( mode_ SMALLINT, dat_ DATE, filt_ VARCHAR2) IS

acrd_    NUMBER;
acc_     NUMBER;
accc_    NUMBER;
acra_    NUMBER;
acrb_    NUMBER;
id_      NUMBER;
dat1_    DATE;
dat2_    DATE;
acr_dat_ DATE;
dapp_    DATE;
--ostc_    NUMBER;
remi_    NUMBER      DEFAULT 0;
nbs_     VARCHAR2(4);
nls_     VARCHAR2(14);
kv_      NUMBER;
--branch_  VARCHAR2(64);

x        SYS_REFCURSOR;
rowid_   UROWID      DEFAULT NULL;

t  NUMBER := dbms_utility.get_time;
i  NUMBER :=0;
q  NUMBER :=0;

BEGIN

bars_audit.trace(
  'SELECT s.acc, i.id, s.nls, s.kv,
      NVL(i.acr_dat+1,s.daos) dat1,
      NVL(i.stp_dat,:1)       dat2, i.rowid
     FROM int_accn i,accounts s
    WHERE s.acc = i.acc
      AND (i.stp_dat < :1 OR i.stp_dat IS NULL)
      AND NVL(i.acr_dat+1,s.daos) <= :1 AND '||filt_);

bars_audit.info('ПЕНІ - Старт нарахування');

   OPEN x FOR
  'SELECT s.acc, i.id, s.nls, s.kv,
          NVL(i.acr_dat+1,s.daos) dat1,
          NVL(i.stp_dat,:1)       dat2,
--        s.branch,
--        i.acra, i.acrb
          i.rowid
     FROM int_accn i,accounts s
    WHERE s.acc = i.acc
      AND (i.stp_dat < :1 OR i.stp_dat IS NULL)
      AND NVL(i.acr_dat+1,s.daos) <= :1 AND '||filt_
--  ' ORDER BY s.branch,s.kv,s.nls '
    USING dat_,dat_,dat_;

   LOOP  -- Нарахувати відстоки по фільтру

   FETCH x INTO acc_,id_,nls_,kv_,dat1_,dat2_,rowid_;
    EXIT WHEN x%NOTFOUND;

      SELECT acr_dat,acra INTO acr_dat_,acra_ FROM int_accN
       WHERE acc=acc_ and id=id_ FOR UPDATE OF acc NOWAIT;

      IF acra_ IS NOT NULL THEN

         BEGIN
            SELECT nls,kv,nbs,dapp,accc INTO nls_,kv_,nbs_,dapp_,accc_
              FROM accounts WHERE acc=acra_
               FOR UPDATE OF ostc NOWAIT;
         EXCEPTION WHEN OTHERS THEN GOTO next_acc;
         END;
--  В моді2 тільки змінюємо залишки
         IF mode_=2 AND nbs_ LIKE '8%' AND accc_ IS NULL THEN

            acrn.p_int(acc_,id_,dat1_,dat2_,acrd_,NULL,0);

            remi_ := acrd_-ROUND(acrd_);
            acrd_ := ROUND(acrd_);

   bars_audit.trace(nls_||'('||kv_||') з '||
   TO_CHAR(dat1_,'dd/mm/yyyy')||' по '|| TO_CHAR(dat2_,'dd/mm/yyyy') ||' %%:'||acrd_);

            UPDATE int_accN SET acr_dat = dat_, s=remi_
             WHERE rowid=rowid_;

            IF acrd_<>0 THEN


               gl.fRCVR := 0; -- PreLoad Trig's value

               IF TRUNC(dapp_) = TRUNC(gl.bDATE) THEN

                  UPDATE accounts
                     SET trcn = trcn + 1,
                         dapp = gl.bDATE,
                         ostB = ostB + acrd_,
                         ostC = ostC + acrd_,
                         dos  = dos  + CASE WHEN acrd_<0 THEN 0-acrd_ ELSE 0 END,
                         kos  = kos  + CASE WHEN acrd_>0 THEN   acrd_ ELSE 0 END
                   WHERE acc=acra_;

               ELSIF TRUNC(dapp_) > TRUNC(gl.bDATE) THEN  -- Back-Valued-Payment

                  UPDATE accounts
                     SET trcn = trcn + 1,
                         ostB = ostB + acrd_,
                         ostC = ostC + acrd_
                   WHERE acc=acra_;

               ELSE

                  UPDATE accounts
                     SET trcn = trcn + 1,
                         dapp = gl.bDATE,
                         ostB = ostB + acrd_,
                         ostC = ostC + acrd_,
                         dos  = CASE WHEN acrd_<0 THEN 0-acrd_ ELSE 0 END,
                         kos  = CASE WHEN acrd_>0 THEN   acrd_ ELSE 0 END
                   WHERE acc=acra_;

               END IF; -- dapp
            END IF; -- acrd
            i := i + 1;
            q := q + gl.p_icurval(kv_,acrd_,gl.bDATE);
         END IF;   -- mode-2
      END IF;     -- acra
      <<next_acc>>
      NULL;
      IF MOD(i,1000)=0 THEN COMMIT; END IF;
   END LOOP;

   dbms_output.put_line('Нараховано по '||TRIM(TO_CHAR(i,'999,999,999,999'))||' рах.');
   dbms_output.put_line('Сума '||TRIM(TO_CHAR(q/100,'999,999,999,999.99'))  ||' грн.');

   bars_audit.info('ПЕНІ - Кінець нарахування. Оброблено '||i||' рах'||
                    ' за '|| to_char(dbms_utility.get_time-t) ||' ms');


/*
            ELSE --  ПРОВОДКi.acra=i1.acc (+) AND i.acrb=i2.acc (+)

               gl.ref (ref_);
               gl.in_doc2(ref_,
               tt_,
               6,
               ref_,
               SYSDATE,
               gl.bDATE, --c.data,
               1,
               980,
               s_,
               980,
               s_,NULL,NULL,   -- eqv - sk
               gl.bDATE, --c.data,
               gl.bDATE,
               nmsa_,
               nlsa_,
               gl.aMFO,
               nmsd_,
               nlsd_,
               gl.aMFO,
              'Нараховані відсотки з '||dat1||' по '||dat2_,
               NULL,    --d_rec_
               gl.aOKPO,
               gl.aOKPO,
               NULL,    --id_o_
               NULL,    --sign_
               0,       --sos_
               0,       --prty_
               NULL);   --uid_

               gl.payv(0,ref_,gl.bDATE,tt_,1, 980,nlsa_,s_,
                                              980,nlsd_,s_);
--             chk.put_visa (ref_, tt_, 05, 2, NULL, NULL,NULL);

               gl.pay2(2,ref_,gl.bDATE);
*/

END p2_acr;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE 	: p_nbs
%
% DESCRIPTION	: Returns Base Rate AND SUM(amount*rate)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

procedure P_BNS
( rat_       out number                -- rate
, amnt_      out number                -- SUM(amount*rate)
, dat_    in     date                  -- efective date
, nb_     in     smallint              -- base rate code
, kv_     in     smallint              -- currency code
, ostf_   in     number                -- account balance
, op_     in     smallint default null -- rate amend op code
, amnd_   in     number   default null -- rate amend value
, kf_     in     varchar  default null -- 
) IS
  br_    NUMBER;
  ostp_  NUMBER;
  osts_  NUMBER;
  tmps_  NUMBER;
  --
  rato_  NUMBER;
  ratb_  NUMBER;
  rats_  NUMBER;
  --
  kvs_   SMALLINT;
  --
  type_  int;
  FORM_  varchar2(25);
  l_kf   varchar2(6);
  --
  CURSOR C0 IS
  SELECT t.rate, t.s
    FROM br_tier t
   WHERE t.br_id=nb_ AND t.kv=kv_ AND
         t.bdate=(SELECT MAX(bdate) FROM br_tier
                   WHERE bdate<=dat_ AND br_id=nb_ AND kv=kv_)
   ORDER BY s;

BEGIN
  
  br_  := 0;
  ostp_:= 0;
  osts_:= ostf_;
  
  if ( kf_ Is Null )
  then l_kf := sys_context('bars_context','user_mfo');
  else l_kf := kf_;
  end if;
  
  if ( l_kf Is Null )
  then
    raise_application_error( -20666, 'Не вказано МФО для розрахунку значення базової ставки!' );
  end if;

  select BR_TYPE ,FORMULA 
    into type_, form_
    from BRATES
   where br_id=nb_;

  if type_ in (1,4) 
  then
    declare
      c_CURSOR int;
      i_CURSOR int;
      dyn_SQL_ varchar2(250);
    begin
      if type_ = 4 and FORM_ is not null 
      then -- 4 - По внешней формуле (Этот блок добавила Сухова)
        
        c_CURSOR:=DBMS_SQL.OPEN_CURSOR;
        --приготовить дин.SQL с предполагаемыми параметрами ДАТА и АСС
        dyn_SQL_:=
        'SELECT '||FORM_||'(to_date('''||to_char(dat_)||'''),'||acc_FORM||','||to_char(nb_)||') from dual';
        DBMS_SQL.PARSE(c_CURSOR, dyn_SQL_, DBMS_SQL.NATIVE);
        --установить знач колонки в SELECT
        DBMS_SQL.DEFINE_COLUMN(c_CURSOR, 1, br_ );
        --выполнить приготовленный SQL
        i_CURSOR:=DBMS_SQL.EXECUTE(c_CURSOR);
        --прочитать
        IF DBMS_SQL.FETCH_ROWS(c_CURSOR)>0 THEN
           --снять результирующую переменную
           DBMS_SQL.COLUMN_VALUE(c_CURSOR,1, br_ );
        end if;
        
      else -- 1 - Простая процентная ставка
        
        -- ищем явное значение БАЗ % ставки, действующее на нужную дату
        select RATE
          into br_
          from BR_NORMAL_EDIT
         where ( BR_ID, KV, BDATE ) in ( select BR_ID, KV, max(BDATE)
                                           from BR_NORMAL_EDIT
                                          where BR_ID = nb_
                                            and KV    = kv_
                                            and BDATE <=dat_
                                          group by BR_ID, KV );
         
       end if;
       
       IF    op_ = 1 THEN  br_ := br_ + amnd_;
       ELSIF op_ = 2 THEN  br_ := br_ - amnd_;
       ELSIF op_ = 3 THEN  br_ := br_ * amnd_;
       ELSIF op_ = 4 THEN  br_ := br_ / amnd_;
       END IF;
       
     exception
       when others then br_:=0;
     end;
/**************************************************************************/
/***      2-Ступ., 3-Ступ.,пропорциаонльная, 7-Ступ.,с формулой порога  ***/
/**************************************************************************/
  elsif type_ in (2,3,7) 
  then
    
    tmps_ := 0;
    FOR tie IN ( select RATE
                      , case 
                        when t.S = 0 and type_=7
                        then GET_DPTAMOUNT(G_acc)
                        else t.S
                        end as S
                   from BR_TIER_EDIT t
                  where ( BR_ID, KV, BDATE ) in ( select BR_ID, KV, max(BDATE)
                                                    from BR_TIER_EDIT
                                                   where BR_ID = nb_
                                                     and KV    = kv_
                                                     and BDATE <=dat_
                                                   group by BR_ID, KV )
                  order by S )
    LOOP
      br_ := tie.RATE;
      IF    op_ = 1 THEN  br_ := br_ + amnd_;
      ELSIF op_ = 2 THEN  br_ := br_ - amnd_;
      ELSIF op_ = 3 THEN  br_ := br_ * amnd_;
      ELSIF op_ = 4 THEN  br_ := br_ / amnd_;
      END IF;
      EXIT WHEN tie.s >= ostf_;
      IF type_ IN (3,7) 
      THEN
        ostp_ := ostp_ + br_ * (tie.s - tmps_);
        osts_ := osts_ - tie.s + tmps_;
        IF deb.debug
        THEN
          deb.trace(1,TO_CHAR(tie.s-tmps_)||' at '||TO_CHAR(br_)||'%',nb_);
        END IF;
        tmps_   := tie.s;
      END IF;
     END LOOP;

/**************************************************************************/
/***      5-Ступенчатая в другой валюте, 6-Ступенчатая, пропорциональная **/
/**************************************************************************/
  ELSIF type_ IN (5,6) 
  THEN

    BEGIN
      SELECT UNIQUE kv 
        INTO kvs_
        FROM br_tier
       WHERE br_id=nb_;
    EXCEPTION
       WHEN NO_DATA_FOUND THEN kvs_:=kv_;
       WHEN TOO_MANY_ROWS THEN kvs_:=kv_;
    END;

    tmps_ := 0;

    FOR tie IN ( SELECT t.RATE
                      , t.S
                   FROM br_tier t
                  WHERE t.br_id=nb_
                    AND t.kv=kvs_
                    AND t.bdate=(SELECT MAX(bdate) FROM br_tier
                                  WHERE bdate<=dat_ AND br_id=nb_ AND kv=kvs_)
                  ORDER BY s)
    LOOP
      br_ := tie.rate;
      IF    op_ = 1 THEN  br_ := br_ + amnd_;
      ELSIF op_ = 2 THEN  br_ := br_ - amnd_;
      ELSIF op_ = 3 THEN  br_ := br_ * amnd_;
      ELSIF op_ = 4 THEN  br_ := br_ / amnd_;
      END IF;

      gl.x_rat( rato_,ratb_,rats_,kvs_,kv_,dat_ );
      
      IF deb.debug 
      THEN
        deb.trace(1,'rat_o '||kvs_||','||kv_,rato_);
        deb.trace(1,tie.rate||'%',tie.s);
        deb.trace(1,br_||' % scale on '||kv_,tie.s*rato_);
      END IF;

      IF tie.s * rato_ >= ostf_ THEN EXIT; END IF;

      IF type_=6 
      THEN
        ostp_ := ostp_ + br_ * (tie.s * rato_ - tmps_);
        osts_ := osts_ - tie.s * rato_ + tmps_;
        IF deb.debug
        THEN
          deb.trace(1,TO_CHAR(tie.s * rato_-tmps_)||' at '||TO_CHAR(br_)||'%',nb_);
        END IF;
        tmps_   := tie.s * rato_;
      END IF;
    END LOOP;
     
  end if;
  
  IF deb.debug 
  THEN
    deb.trace(1,TO_CHAR(osts_)||' at '||TO_CHAR(br_)||'%',nb_);
  END IF;

  rat_  := br_;
  amnt_ := osts_ * br_ + ostp_;

end P_BNS;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE 	: p_int
%
% DESCRIPTION	: Calculates interest for given amount at given account
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE p_int( acc_ INTEGER, -- Account number
                  id_ SMALLINT,-- Calc code
                 dt1_ DATE,    -- From date
                 dt2_ DATE,    -- To   date
                 int_ OUT NUMBER, -- Interest accrued
                 ost_ DECIMAL  DEFAULT NULL,
                mode_ SMALLINT DEFAULT 0) -- Mode   Play(0)/Real(1), Play(2)

/*
mode_ = 0  моделирование
mode_ = 1  реальное начисление
mode_ = 2  моделирование без ХО-ХО
*/

IS
        dTmp_  date;
        dat_   DATE;
	dat0_  DATE;
	dat1_  DATE;
	dat2_  DATE;
	b_yea  NUMBER;
	ostf_  NUMBER;
	ir0_   NUMBER;
	nb0_   NUMBER;
        sdat_  DATE;
       	adat_  DATE;
	bdat_  DATE;
	tdat_  DATE;
	ir_    NUMBER;
	br_    NUMBER;
	osts_  NUMBER;
	ostp_  NUMBER;
	osta_  NUMBER;


	acrd_  NUMBER;
	acr_   NUMBER;
--sess_  NUMBER;
        dlta_  NUMBER;
        kv_    SMALLINT;
        op_    SMALLINT;
        pap_   SMALLINT;
        remi_  NUMBER      DEFAULT 0;
        aROW   UROWID      DEFAULT NULL;


        KOL_ int; -- кол-во ЦБ
        ACC_ALT_PK_ INT := CASE WHEN mode_ <= 1 THEN acc_ ELSE mode_ END;

  -- поиск % карточки - зависит от счета
  CURSOR C_ACC
  IS
  SELECT i.ACC, i.basey, i.basem, nvl(i.io, 0) io, i.ACR_DAT + 1 dat,
         a.KF, a.KV, decode(i.metr, 96, 0, i.metr) metr, a.PAP, i.S, i.STP_DAT
    FROM int_accn i
       , accounts a
   WHERE a.acc = i.acc
     AND i.acc = acc_alt_pk_
     AND i.id  = id_
     AND i.metr IN (0, 1, 2, 3, 4, 5, 96);

        --поиск % ставки индивидуальной  - зависит от счета
	CURSOR C_RATI IS
             SELECT bdat, NVL(ir,0) ir, op, NVL(br,0) br
               FROM INT_RATN i
              WHERE acc = ACC_ALT_PK_ AND id=id_ AND
              ( i.bdat<= dat2_ AND i.bdat>dat1_ OR
                i.bdat = (SELECT MAX(bdat)
                          FROM INT_RATN
                          WHERE bdat<=dat1_ AND acc=ACC_ALT_PK_ AND id=id_ )
               )
              ORDER BY i.bdat;

        --поиск % ставки базовой  - зависит от счета
	CURSOR C_RATB IS
             SELECT br, bdat
               FROM INT_RATN i
              WHERE acc = ACC_ALT_PK_ AND id=id_ AND
              ( i.bdat<= dat2_ AND i.bdat>dat1_ OR
                i.bdat = (SELECT MAX(bdat)
                          FROM INT_RATN
                          WHERE bdat<=dat1_ AND acc=ACC_ALT_PK_ AND id=i.id)
               )
              GROUP BY bdat, br;

        --поиск значения ставки базовой  - НЕ зависит от счета
	CURSOR C_BNO(bri_ NUMBER,kv_ NUMBER, start_dat_ DATE, end_dat_ DATE) IS
             SELECT bdate
               FROM br_normal b
              WHERE br_id=bri_ AND kv=kv_ AND
                   (b.bdate <= end_dat_ AND b.bdate > start_dat_ OR
                    b.bdate=
                    (SELECT MAX(bdate)
                     FROM  br_normal
                     WHERE bdate<=start_dat_ AND br_id=bri_ AND kv=kv_))
           GROUP BY bdate;

        --поиск значения ставки базовой  - НЕ зависит от счета
	CURSOR C_BTI(bri_ NUMBER,kv_ NUMBER, start_dat_ DATE, end_dat_ DATE) IS
             SELECT bdate
               FROM br_tier b
              WHERE br_id=bri_ AND kv=kv_ AND
                   (b.bdate <= end_dat_ AND b.bdate > start_dat_ OR
                    b.bdate=
                    (SELECT MAX(bdate)
                     FROM  br_tier
                     WHERE bdate<=start_dat_ AND br_id=bri_ AND kv=kv_))
             GROUP BY bdate;

        --поиск остатков - зависит от счета
	CURSOR C_SALO IS
             SELECT fdat,ostf-dos+kos ostf
               FROM saldoa
              WHERE acc=acc_ AND (fdat<=dat2_ AND fdat>dat1_ OR
                    fdat=(SELECT MAX(fdat)
                    FROM saldoa WHERE fdat<=dat1_ AND acc=acc_));

        --поиск остатков - зависит от счета
	CURSOR C_SALI IS
            SELECT fdat,ostf,SUM(dos) dos FROM (
             SELECT fdat,ostf,dos
               FROM saldoa
              WHERE acc=acc_ AND fdat<=dat2_ AND fdat>=dat1_
              UNION ALL
             SELECT dat1_ fdat, ostf-dos+kos ostf,0 dos
               FROM saldoa
              WHERE acc=acc_ AND
                    fdat=(SELECT MAX(fdat)
                    FROM saldoa WHERE fdat<dat1_ AND acc=acc_)
              UNION ALL
             SELECT fdat+1 fdat,ostf-dos+kos ostf,0 dos
               FROM saldoa
              WHERE acc=acc_ AND fdat<dat2_ AND fdat>=dat1_ )
              GROUP BY fdat,ostf;
        --поиск остатков - зависит от счета
	CURSOR C_SALH2 IS
             SELECT fdat,ostf-dos+kos ostf
               FROM saldoho
              WHERE fdat<=dat2_ AND fdat>dat1_ OR
                    fdat=(SELECT MAX(fdat)
                    FROM saldoa WHERE fdat<=dat1_ AND acc=acc_);

        --поиск остатков - зависит от счета (Хо-хо!)
	CURSOR C_SALH3 IS
            SELECT fdat,ostf,SUM(dos) dos FROM (
             SELECT fdat,ostf,dos
               FROM saldoho
              WHERE fdat<=dat2_ AND fdat>=dat1_
              UNION ALL
             SELECT dat1_ fdat, ostf-dos+kos ostf,0 dos
               FROM saldoho
              WHERE fdat=
            (SELECT MAX(fdat) FROM saldoho WHERE fdat<dat1_ )
              UNION ALL
             SELECT fdat+1 fdat,ostf-dos+kos ostf,0 dos
               FROM saldoho
              WHERE fdat<dat2_ AND fdat>=dat1_ )
              GROUP BY fdat,ostf;
        -- для метода амортизации
	CURSOR c_amo IS
             SELECT a.mdate, (s.ostf - s.dos + s.kos) + a.ostf ostf
               FROM accounts a,
                    saldoa   s
              WHERE a.acc    = acc_
                AND a.acc    = s.acc
                AND s.fdat   = (SELECT max(fdat)
                                  FROM saldoa
                                 WHERE acc   = acc_
                                   AND fdat <= dat2_ );

        -- врем табл на один счет
--	CURSOR C_TMP IS
--             SELECT UNIQUE dat,otm,ir,ostf,brn,op
--               FROM tmp_intN WHERE id=sess_
--              ORDER BY dat,otm;

	prev_rat    C_RATB%ROWTYPE;
	rat         C_RATB%ROWTYPE;
	dat_end     DATE;

	c_label	    constant varchar2(128)  := 'acrn.p_int';

TYPE xxx IS RECORD (
       dat  DATE,
       ostf NUMBER,
       ir   NUMBER,
       op   NUMBER,
       br   NUMBER,
       brn  NUMBER );

--dat, otm, ir, op, br, brn
key VARCHAR2(9);
TYPE x IS TABLE OF xxx INDEX BY VARCHAR2(9);
tmp x;


BEGIN

  dat1_   := TRUNC(dt1_);

  acr_    := 0;

  G_acc   := acc_;

  acrn.SumO  := 0;  -- Сумма остатков
  acrn.SumOP := 0;  -- Сумма остатков на процент
  acrn.SumOD := 0;  -- Количество дней сумма остатков

  IF mode_ = 1 THEN
     DELETE FROM acr_intN WHERE acc=acc_ AND id=id_;
  END IF;

  WHILE dat1_<=TRUNC(dt2_) LOOP

    IF TRUNC(dat1_,'YEAR')<>TRUNC(dt2_,'YEAR') THEN
       dat2_:=TO_DATE('3112'||TO_CHAR(dat1_,'YYYY'),'DDMMYYYY');
    ELSE
       dat2_:=TRUNC(dt2_);
    END IF;

    FOR acc IN C_ACC
    LOOP

       if mode_ = 2 then  -- 06.08.2012  Для игрового режима без ХО-ХО
          acc.IO := 0;
       end if;

        IF acr_ = 0 AND mode_ = 1 THEN
           remi_ := acc.s;
        END IF; -- Previous unpaid reminder

        IF acc.basey=0 or
          (acc.basey=4 and acrN.cur_Basey is null) THEN  -- факт/факт ГОДОВАЯ % ставка
           b_yea := TO_DATE('3112'||TO_CHAR(dat1_,'YYYY'),'DDMMYYYY')-TRUNC(dat1_,'YEAR')+1;
        ELSIF acc.basey=1 THEN
           b_yea := 365;
        ELSIF acc.basey IN (2,12) THEN
           b_yea := 360;
        ELSIF acc.basey=3 THEN
           b_yea := 360;
        ELSIF acc.basey=4 THEN
           b_yea := acrN.cur_Basey;
        ELSIF acc.basey=5 THEN          -- факт/факт МЕСЯЧНАЯ % ставка
           dTmp_:= TO_DATE('01'||TO_CHAR(dat1_-1,'MMYYYY'),'DDMMYYYY');
           b_yea := add_months(dTmp_,1) - dTmp_ ;
        ELSIF acc.basey IN (6,16) THEN          -- 30/30 МЕСЯЧНАЯ % ставка
           b_yea := 30;
           If to_char(dat1_,'YYYYMM')<>to_char(dt2_,'YYYYMM') then
              dat2_:= LAST_DAY(dat1_);  -- разрыв цикла на послдень мес. (для месячной и год. % ставки)
           END IF;
        ELSIF acc.basey=7 THEN
           b_yea := 364;
        ELSE
           GOTO end_acc;
        END IF;

        -- амортизация по дате начисления процентов по основному счету ("Вклады населения")
        IF acc.metr = 3 THEN
           bars_audit.trace ('acrn.p_int: metr = 3, acc = %s, %s - %s', to_char(acc_),
                      to_char(dat1_,'dd.mm.yyyy'), to_char(dat2_,'dd.mm.yyyy'));
           DECLARE
             l_datend date;
             l_datacr date;
           BEGIN
             SELECT acr_dat INTO l_datacr FROM int_accn WHERE acrb = acc_ AND id = 1;
             bars_audit.trace ('acrn.p_int: дата посл.начисления = %s', to_char(l_datacr,'dd.mm.yyyy'));
             l_datend := least (dat2_, l_datacr);
             bars_audit.trace ('acrn.p_int: дата по* = %s', to_char(l_datend,'dd.mm.yyyy'));
             FOR sal IN c_amo LOOP
                 acrd_ := 0;
                 IF (id_ = 0 AND sal.ostf < 0 AND l_datacr >= dat1_) THEN
                     osts_ := sal.ostf - acr_;
                     dlta_ := l_datend - dat1_ + 1;
                     acrd_ := osts_ * dlta_ / (l_datacr - dat1_ + 1);
                     bars_audit.trace ('acrn.p_int: ost = %s, delta = %s, acrd = %s, cnt = %s',
                                       to_char(osts_), to_char(dlta_), to_char(acrd_),
                                       to_char(l_datacr - dat1_ + 1));
                     IF acrd_ <> 0 THEN
                        IF mode_ = 1 THEN
                           INSERT INTO acr_intN (acc,  id,  fdat,  tdat,     ir, br, osts,  acrd)
                           VALUES               (acc_, id_, dat1_, l_datend, 0,  0,  osts_, acrd_);
                        END IF;
                        acr_ := acr_ + acrd_;
                     END IF;
                 END IF;
             END LOOP;
             GOTO end_acc;
           EXCEPTION
             WHEN NO_DATA_FOUND THEN NULL;
           END;

        --
        -- амортизация равными долями
        --
        elsif acc.metr = 4 then

          bars_audit.trace ('acrn.p_int(4): acc/id => %s/%s, saltype => %s, term => %s-%s',
                            to_char(acc_), to_char(id_), to_char(acc.io),
                            to_char(dat1_,'dd.mm.yyyy'), to_char(dat2_,'dd.mm.yyyy'));

          for sal in c_amo
          loop

              bars_audit.trace ('acrn.p_int(4): saldo = %s, mdate=>%s',
                                to_char(sal.ostf), to_char(sal.mdate,  'dd.mm.yyyy'));

              if acc.io = 0 then  kol_ := 0;
              else                kol_ := 1;
              end if;
              dat2_ := least (dat2_, sal.mdate - kol_);
              bars_audit.trace ('acrn.p_int(4): "till" date = %s', to_char(dat2_,'dd.mm.yyyy'));

              acrd_ := 0;

              if (id_ in (0, 2) and sal.ostf < 0) or
                 (id_ in (1, 3) and sal.ostf > 0) then

                 osts_ := sal.ostf - acr_;
                 dlta_ := dat2_ - dat1_ + 1;
                 acrd_ := osts_ * dlta_/  ((sal.mdate - kol_) - dat1_ + 1);
                 if id_ in (0, 2) then acrd_ := least(acrd_,    0); end if;
                 if id_ in (1, 3) then acrd_ := greatest(acrd_, 0); end if;
             end if;
             bars_audit.trace ('acrn.p_int(4): intamount(sal %s, %s/%s days) = %s',
                               to_char(osts_), to_char(dlta_),
                               to_char(sal.mdate - kol_ - dat1_ + 1), to_char(acrd_));

             if acrd_ != 0 then
                if mode_ = 1 then
                   insert into acr_intn (acc, id, fdat, tdat, ir, br, osts, acrd, remi)
                   values (acc_, id_, dat1_, dat2_, 0, 0, osts_, acrd_, remi_);
                end if;
                acr_ := acr_ + acrd_;
             end if;
             if sal.ostf - acr_ = 0 then dat2_ := trunc(dt2_); end if;
          end loop;
          goto end_acc;


 ELSIF acc.metr = 5 THEN

    -- Используется только в ПЕТРОКОМЕРЦ
    -- амортизация по методу эф.% ставки
    -- Существует 2 проц.карточки по осн.счету номинала
    -- id=0 - номинальная стака купона:  acc 3114, acra 3118
    -- id=2 - эф.стака амортизации диск: acc 3114, acra 3116
    --                       или премии: acc 3114, acra 3116
    -- эф.ставка запоминается как дневной коеф.,
    -- т.е = ГОД эф.ставка/36500
    -- проверено и исправлено после проверки в ПЕРТОКОМЕРЦ

    declare
      N_    number; -- оттаток номинал
      IR_   number; -- ном % ставка годовая
      ACCDP_ int  ; -- ACC дисконта/премии
      DP_   number; -- остаток дисконт/премия
      ERAT_ number; -- эф.% ставка - дневная
      KUP1_ number;
      DP1_  number; -- дисконт/премия 1-го дня
      MDATE_ date ; -- дата погашения сч
      DAOS_  date ; -- дата открытия  сч

      DAT_n_ date ; -- дата последненго изменения номинала
      DAT_i_ date ; -- дата последней установки ном % ставки
      DAT_e_ date ; -- дата последней установки еф. % ставки

    begin
      --сумма номинала + номинальная % ставка + ACC счета ДИСКОНТА/ПРЕМИИ
      select sN.fdat, sN.ostf-sN.dos+sN.kos,
             a.MDATE, a.DAOS, i.acrA, r.ir, r.bdat
      into   DAT_n_, N_,
             MDATE_, DAOS_, ACCDP_, IR_, DAT_i_
      from saldoa sN, accounts a , int_ratn r, int_accn i
      where a.acc=ACC_ and sN.acc=a.ACC
       and (sN.ACC,sN.fdat) =
           (select acc, max(fdat) from saldoa
            where acc=sN.ACC and fdat<=DAT2_
            group by acc)
        and r.acc=a.ACC and r.id=i.id- 2
        and (r.ACC,r.id,r.bdat)=
               (select acc,id,MAX(bdat) from int_ratn
                where acc=r.ACC and id=r.id and bdat<=DAT2_
                group by acc,id)
        and i.acc=a.acc and i.id=ID_ and
            i.acra is not null and i.acrb is not null;

      -- сумма ДИСКОНТА/ПРЕМИИ
      select s.ostf-s.dos+s.kos
      into DP_
      from saldoa s
      where s.acc=ACCDP_ and s.ostf-s.dos+s.kos<>0 and
           (s.ACC,fdat) = (select acc, max(fdat)
                            from saldoa
                            where acc=s.ACC and fdat<=DAT2_
                            group by acc);
      --есть что амортизировать
      if N_ = 0 or DAT2_>= MDATE_ or abs(DP_) <= 100 then
         --остаточная аммортизация
         DP1_ := DP_;
      else
         -- эф.% ставка
         BEGIN
           SELECT r.ir, r.bdat
           INTO ERAT_, DAT_e_
           FROM int_ratn r
           WHERE r.acc=ACC_ AND r.ID=ID_ AND (r.ACC,r.ID,r.bdat) =
               (SELECT acc,ID,MAX(bdat) FROM int_ratn
                WHERE acc=r.ACC AND ID=r.ID AND bdat<=DAT1_ GROUP BY acc,ID);
         EXCEPTION WHEN NO_DATA_FOUND THEN DAT_e_ := null;
         end;

         If    DAT_e_  is NULL
            OR DAT_e_ < DAT_i_
            OR DAT_e_ < DAT_n_ then
            -- раньше расчитывалась при отсутствии
            -- теперь - в случаях:
            -- 1) Изменения номинала даты
            -- 2) Изменен. ном % стаавки даты

            KUP1_ := N_* IR_/36500;
            DP1_  := DP_ / (MDATE_ - DAT_n_ );
            ERAT_ := (KUP1_-DP1_) / (( N_+DP_ + N_)/2) ;
            insert into int_ratn (acc,id,bdat,ir) values (ACC_,ID_,DAT2_,erat_);
         end if;

---**********************

         If DAT2_ >= DAT_n_  then
            dlta_ := dat2_- GREATEST(DAT_n_,DAT1_) + 1 ;
            DP1_  := ROUND( ((N_+DP_)*ERAT_ - N_*IR_/36500 ) * dlta_, 0);
         else
            DP1_  := 0;
         end if;
      end if;

      IF DP1_ <> 0 THEN
         IF mode_ = 1 THEN
            INSERT INTO acr_intN (acc, id, fdat, tdat,ir,br,osts,acrd)
                         VALUES (acc_,id_, GREATEST(DAT_n_,DAT1_),dat2_,0,0,DP_,DP1_ );
         END IF;
         acr_ := acr_ + DP1_;
      END IF;

    EXCEPTION WHEN NO_DATA_FOUND THEN GOTO end_acc;
    end;
    GOTO end_acc;

 END IF;

-- Collect balance history

        IF ost_ IS NULL THEN
           IF acc.io = 1 THEN
              FOR sal IN C_SALI LOOP
                  IF sal.fdat <  dat1_ THEN
                     sal.fdat := dat1_;
                  END IF;

                  tmp(TO_CHAR(sal.fdat,'yyyymmdd')||'0').dat :=sal.fdat;
                  tmp(TO_CHAR(sal.fdat,'yyyymmdd')||'0').ostf:=sal.ostf-sal.dos;

              END LOOP;

           ELSIF acc.io IN (2,3) THEN

              DELETE FROM saldoho;

              dat0_ := dat1_-10; -- выбираем с запасом 10 выходных подряд

              INSERT INTO saldoho (fdat,ostf,dos,kos)
              SELECT fdat, acrn.ho_ost(acc_,fdat,-dos+kos,rownum),dos,kos
                FROM (
              SELECT fdat,SUM(dos) dos,SUM(kos) kos
                FROM (
              SELECT fdat, dos, kos
                FROM saldoa
               WHERE acc=acc_ AND
                     fdat=(SELECT MAX(fdat)
                     FROM saldoa WHERE acc=acc_ AND fdat < dat0_ AND acc=acc_)
               UNION ALL
              SELECT fdat, dos, kos
                FROM saldoa
               WHERE acc = acc_ AND fdat BETWEEN dat0_ AND dat2_
               UNION ALL
              SELECT cdat, NVL(dos,0), NVL(kos,0)
                FROM v_saldo_holiday v
               WHERE acc = acc_ AND cdat BETWEEN dat0_ AND dat2_
               UNION ALL
              SELECT (SELECT MIN(fdat) FROM saldoa
                       WHERE acc=acc_ and fdat > v.cdat),  NVL(-v.dos,0), NVL(-v.kos,0)
                FROM v_saldo_holiday v
               WHERE acc = acc_ AND cdat BETWEEN dat0_ AND dat2_
                     )
               GROUP BY fdat ORDER BY fdat );

              IF acc.io = 2 THEN
                 FOR sal IN C_SALH2 LOOP
                     IF sal.fdat <  dat1_ THEN
                        sal.fdat := dat1_;
                     END IF;

                     tmp(TO_CHAR(sal.fdat,'yyyymmdd')||'0').dat :=sal.fdat;
                     tmp(TO_CHAR(sal.fdat,'yyyymmdd')||'0').ostf:=sal.ostf;

                 END LOOP;
              ELSE -- acc.io = 3
                 FOR sal IN C_SALH3 LOOP
                     IF sal.fdat <  dat1_ THEN
                        sal.fdat := dat1_;
                     END IF;

                     tmp(TO_CHAR(sal.fdat,'yyyymmdd')||'0').dat :=sal.fdat;
                     tmp(TO_CHAR(sal.fdat,'yyyymmdd')||'0').ostf:=sal.ostf-sal.dos;

                 END LOOP;
              END IF;
           ELSE
              FOR sal IN C_SALO LOOP
                  IF sal.fdat <  dat1_ THEN
                     sal.fdat := dat1_;
                  END IF;

                  tmp(TO_CHAR(sal.fdat,'yyyymmdd')||'0').dat :=sal.fdat;
                  tmp(TO_CHAR(sal.fdat,'yyyymmdd')||'0').ostf:=sal.ostf;

              END LOOP;
           END IF;
        ELSE

           tmp(TO_CHAR(dat1_,'yyyymmdd')||'0').dat :=dat1_;
           tmp(TO_CHAR(dat1_,'yyyymmdd')||'0').ostf:=ost_;

        END IF;

-- Collect individual rate history

        FOR rat IN C_RATI LOOP

            IF rat.bdat <  dat1_ THEN
               rat.bdat := dat1_;
            END IF;

            tmp(TO_CHAR(rat.bdat,'yyyymmdd')||'3').dat :=rat.bdat;
            tmp(TO_CHAR(rat.bdat,'yyyymmdd')||'3').ir  :=rat.ir;
            tmp(TO_CHAR(rat.bdat,'yyyymmdd')||'3').op  :=rat.op;
            tmp(TO_CHAR(rat.bdat,'yyyymmdd')||'3').brn :=rat.br;

        END LOOP;

-- Collect base rate history

        prev_rat.br:=NULL;
        prev_rat.bdat:=NULL;
        rat.br:=NULL;
        rat.bdat:=NULL;

        OPEN C_RATB;   --История % ставок на счетах

	LOOP
           FETCH C_RATB INTO rat;

           IF prev_rat.br IS NOT NULL THEN  --Начинаем со второй строки

              IF C_RATB%NOTFOUND THEN
                 dat_end := dat2_;     --Считаем датой окончания тек. ставки - конец периода начисления
              ELSE
                 dat_end := rat.bdat;  --Считаем датой окончания тек. ставки - начало действия след. ставки
              END IF;

              FOR bas IN C_BNO(prev_rat.br,acc.kv, prev_rat.bdat, dat_end) LOOP --История нормальной изменения ставки

                  IF bas.bdate <  prev_rat.bdat THEN      --Если значение ставки установлено раньше
                     bas.bdate := prev_rat.bdat;          --Началом действия является ее уст. на счете
                  END IF;

                  tmp(TO_CHAR(bas.bdate,'yyyymmdd')||'2').dat :=bas.bdate;
                  tmp(TO_CHAR(bas.bdate,'yyyymmdd')||'2').brn:=prev_rat.br;

              END LOOP;

              FOR tie IN C_BTI(prev_rat.br,acc.kv, prev_rat.bdat, dat_end) LOOP  --История ступенчатой изменения ставки

                  IF tie.bdate <  prev_rat.bdat THEN
                     tie.bdate := prev_rat.bdat;
                  END IF;

                  tmp(TO_CHAR(tie.bdate,'yyyymmdd')||'1').dat :=tie.bdate;
                  tmp(TO_CHAR(tie.bdate,'yyyymmdd')||'1').brn:=prev_rat.br;

              END LOOP;
           END IF;
           prev_rat:=rat;

           EXIT WHEN C_RATB%NOTFOUND;

        END LOOP;

	CLOSE C_RATB;

        tmp(TO_CHAR(dat2_+1,'yyyymmdd')||'4').dat:=dat2_+1;

-- End of collection

        ostf_ := NULL;
        bdat_ := NULL;
        ir0_  := 0;
        op_   := NULL;
        nb0_  := NULL;

        osta_ := 0;
        sdat_ := NULL;


        key := tmp.FIRST;
        WHILE key IS NOT NULL LOOP

            tmp(key).ostf := NVL(tmp(key).ostf,ostf_);
            tmp(key).ir   := NVL(tmp(key).ir, ir0_);
            tmp(key).op   := NVL(tmp(key).op, op_);
            tmp(key).brn  := NVL(tmp(key).brn, nb0_);

            IF deb.debug THEN
               deb.trace(1,'----','key='||key);
            END IF;

            IF bdat_ <> tmp(key).dat        --tmp.dat
            AND ostf_ IS NOT NULL THEN

               IF deb.debug THEN
                  deb.trace(1,'*****',' '||bdat_||' '||ostf_);
               END IF;

               IF acc.metr=2 THEN

                  sdat_ := NVL(sdat_, bdat_);

                  IF tmp(key).ir=ir0_ AND tmp(key).brn=nb0_ THEN

                     IF acc.pap = 1 AND ostf_ <= tmp(key).ostf OR
                        acc.pap = 2 AND ostf_ >= tmp(key).ostf THEN
                        ostf_ := tmp(key).ostf;
                     END IF;

                     IF SUBSTR(key,-1)<>'4' THEN
                        GOTO int_333;
                     END IF;

                  END IF;

               END IF;

               IF acc.metr=1 THEN    -- по середньому

                  sdat_ := NVL(sdat_, bdat_);

                  IF tmp(key).ir=ir0_ AND tmp(key).brn=nb0_ THEN

                     dlta_ := dlta(acc.basey,bdat_,tmp(key).dat);
                     osta_ := osta_ + ostf_ * dlta_;

                     IF deb.debug THEN
                        deb.trace(1,'bdat_:',bdat_);
                        deb.trace(1,'dlta_:',dlta_);
                        deb.trace(1,'osta_:',osta_);
                        deb.trace(1,'ostf_:',ostf_);
                     END IF;

                     IF SUBSTR(key,-1)<>'4' THEN
                        GOTO int_222;
                     END IF;
                  END IF;

                  ostf_ := osta_ / dlta(acc.basey,sdat_,tmp(key).dat);
                  osta_ := 0;
               END IF;

               IF acc.metr=0 THEN      -- нормальний
                  sdat_ := bdat_;
               END IF;

               tdat_ := tmp(key).dat-1;
               ostp_ := 0;

               IF MOD(id_,2)=0 AND ostf_ < 0 OR
                  MOD(id_,2)=1 AND ostf_ > 0 THEN
                  ir_ := ir0_;
                  IF nb0_ > 0 THEN

                     ACC_FORM:=acc.ACC;
                     p_bns( br_, ostp_, sdat_, nb0_, acc.KV, ABS(ostf_), op_, ir_, acc.KF );
                     IF ostf_<0 THEN ostp_ := -ostp_; END IF;
                     ir_ := 0;
                  ELSE
                     br_ := 0;
                  END IF;
               ELSE
                  ir_ := 0;
                  br_ := 0;
               END IF;

               dlta_ := dlta(acc.basey,sdat_,tmp(key).dat);

---------------acrN.cur_Nomin
               If Nvl(acrN.cur_Nomin,0) > 0 then
                  KOL_  := Abs(ostf_) / acrN.cur_Nomin;
                  acrd_ :=
                   ( ir_ * Sign(ostf_)*acrN.cur_Nomin + ostp_ )
                         * dlta_/b_yea/100;
               else
                  KOL_  := 1;
                  acrd_ := ( ir_ * ostf_ + ostp_ ) * dlta_/b_yea/100;
               end if;

               osts_ := ostf_ * dlta_;

               IF deb.debug THEN
                 IF ir_>0 THEN
                   deb.trace(1,TO_CHAR(ABS(ostf_))||' at '||TO_CHAR(ir_)||'%',0);
                 END IF;
                 deb.trace(1,'Date:('||sdat_||','||TO_CHAR(tmp(key).dat-1)||'),days:',dlta_);
                 deb.trace(1,'Base year: ',b_yea);
                 deb.trace(1,'Interest accrued:', acrd_);
               END IF;

               IF acrd_ <> 0 or acc.metr IN (1,2) THEN

                  acrd_:= acrd_ + remi_; -- нарах %% +- частка копійки з минулого разу
                  remi_:= acrd_ - ROUND(acrd_);

                  IF mode_ = 1 THEN

                     If KOL_ > 1 then
                        acrd_ := round(acrd_,0) * KOL_;
                     end if;

                     INSERT INTO acr_intN
                                (acc, id, fdat, tdat, ir, br, osts, acrd,        remi)
                         VALUES (acc_,id_,sdat_,tdat_,ir_,br_,osts_,ROUND(acrd_),remi_)
                          RETURNING rowid INTO aROW;

                  END IF;

                  acrn.SumO  := acrn.SumO  + osts_;
                  acrn.SumOP := acrn.SumOP + osts_ * (ir_ + br_);
                  acrn.SumOD := acrn.SumOD + dlta_;
                  acr_ := acr_ + acrd_;
               END IF;
            END IF;

            IF acc.metr=2 THEN sdat_ := NULL; END IF;

            IF acc.metr=1 THEN
               sdat_ := NULL;
               osta_ := 0;
            END IF;
<<int_222>>
--Эти параметры мы проставляем в конце текущего цикла потому, что
--для завершения периода нам необходимо знать: когда начинается следующий
            ostf_ := tmp(key).ostf;
<<int_333>>
            bdat_ := tmp(key).dat;
            ir0_  := tmp(key).ir;
            op_   := tmp(key).op;
            nb0_  := tmp(key).brn;

            key := tmp.NEXT(key);

        END LOOP;

        tmp.DELETE;

<<end_acc>>
        NULL;
    END LOOP;
    dat1_ := dat2_ + 1;
  END LOOP;
  IF aROW IS NOT NULL AND mode_ = 1 THEN
     UPDATE acr_intN SET tdat=dt2_ WHERE rowid=aROW;
  END IF;
  int_ := acr_;

END p_int;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION 	: dlta
%
% DESCRIPTION	: Returns number of days for %% acrual between two dates
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
FUNCTION dlta(bas_ NUMBER,
             bdat_ DATE,
             tdat_ DATE) RETURN INTEGER
-- Для Basey = 2,6 (SIA 360/30);  12,16 (ISMA 360/30)
IS
dat_   DATE;
dlta_  SMALLINT :=0;
n      SMALLINT;
m      SMALLINT;
BEGIN
   dat_ := bdat_;

   WHILE dat_ < tdat_ LOOP

      n := TO_CHAR(dat_,'DD');
      m := TO_CHAR(dat_,'MM');

      IF    bas_ IN (2,6)   AND n=31 THEN NULL;
      ELSIF bas_ IN (12,16) AND n=30 AND m IN (1,3,5,7,8,10,12) THEN NULL;
      ELSIF bas_ IN (2,6,12,16) AND dat_=LAST_DAY(dat_) AND m=2 THEN
         dlta_:=dlta_+30-TO_NUMBER(TO_CHAR(dat_-1,'DD'));
      ELSE
         dlta_:=dlta_+1;
      END IF;
      dat_:=dat_+1;
   END LOOP;

   RETURN dlta_;

END dlta;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE 	: p_cnds
%
% DESCRIPTION	: Condencing of rate history

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE p_cnds -- accounts number
IS

acc_     NUMBER;
fdat_    DATE;
tdat_    DATE;
id_      SMALLINT;
ir_      NUMBER;
br_      NUMBER;
osts_    NUMBER;
acrd_    NUMBER;
remi_    NUMBER;

BEGIN

DELETE FROM tmp_intcN;

acc_ := NULL;

FOR c IN (SELECT acc,id,fdat,tdat,ir,br,osts,acrd,remi
            FROM acr_intN
           ORDER BY acc,id,fdat,tdat)
LOOP
  IF c.acc=acc_ AND c.id=id_ AND c.ir=ir_ AND c.br=br_ THEN
     tdat_ := c.tdat;
     osts_ := osts_ + c.osts;
     acrd_ := acrd_ + c.acrd;
  ELSE
    IF acc_ IS NOT NULL THEN
      INSERT INTO tmp_intcN (acc,id,fdat,tdat,ir,br,osts,acrd,remi)
              VALUES(acc_,id_,fdat_,tdat_,ir_,br_,osts_,acrd_,remi_);
    END IF;

    acc_  := c.acc;
    id_   := c.id;
    ir_   := c.ir;
    br_   := c.br;
    fdat_ := c.fdat;
    tdat_ := c.tdat;
    osts_ := c.osts;
    acrd_ := c.acrd;
    remi_ := c.remi;

  END IF;

END LOOP;

IF acc_ IS NOT NULL THEN
   INSERT INTO tmp_intcN (acc,id,fdat,tdat,ir,br,osts,acrd,remi)
           VALUES(acc_,id_,fdat_,tdat_,ir_,br_,osts_,acrd_,remi_);
END IF;

DELETE FROM acr_intN;
INSERT INTO acr_intN (acc,id,fdat,tdat,ir,br,osts,acrd,remi)
  SELECT acc,id,fdat,tdat,ir,br,osts,acrd,remi FROM tmp_intcN;

END p_cnds;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION 	: fproc
%
% DESCRIPTION	: Returns interest rate on given date
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

FUNCTION FPROC(acc_ INTEGER,
              datp_ DATE DEFAULT NULL) RETURN NUMBER
IS
BEGIN
   RETURN acrn.FPROCN(acc_,NULL,datp_);
END FPROC;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION 	: fprocN
%
% DESCRIPTION	: Returns interest rate on given date
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

function FPROCN(acc_ INTEGER,
                 id_ INTEGER,
               datp_ DATE DEFAULT NULL) RETURN NUMBER
is
  kf_     varchar2(6);
  kv_     SMALLINT;
  i_      SMALLINT;
  apap_   SMALLINT;
  ppap_   SMALLINT;
  ostc_   NUMBER(24);
  ostp_   NUMBER(24);
  dat_    DATE;
  ir_     NUMBER;
  br_     NUMBER;
  op_     NUMBER(2);
  type_   NUMBER;
  rato_   NUMBER;
  ratb_   NUMBER;
  rats_   NUMBER;
  kvr_    NUMBER;  -- код валюты базовой ставки
BEGIN

   IF datp_ IS NULL THEN
      dat_ := gl.bDATE;
   ELSE
      dat_ := datp_;
   END IF;

   G_acc   := acc_;

   BEGIN
      IF id_ IS NULL THEN
         SELECT a.KF, a.KV, s.OSTF-s.DOS+s.KOS, p.PAP, a.PAP
           INTO kf_, kv_, ostc_, ppap_, apap_
           FROM accounts a
              , saldoa s
              , ps p
          WHERE a.acc=s.acc
            AND a.nbs=p.nbs
            AND a.acc=acc_ 
            AND s.fdat =( SELECT MAX(fdat) FROM saldoa WHERE acc=acc_ AND fdat<=dat_ );

         IF    ostc_<0 OR  ostc_=0 AND ppap_=1 OR
               ostc_=0 AND ppap_=3 AND apap_=1    THEN i_ := 0;
         ELSIF ostc_>0 OR  ostc_=0 AND ppap_=2 OR
               ostc_=0 AND ppap_=3 AND apap_=2    THEN i_ := 1;
         ELSE
               RETURN 0;
         END IF;
      ELSE
/*       SELECT a.kv,s.ostf-s.dos+s.kos
           INTO kv_, ostc_
           FROM accounts a, saldoa s
          WHERE a.acc=s.acc AND a.acc=acc_ AND
                s.fdat =
               (SELECT MAX(fdat) FROM saldoa WHERE acc=acc_ AND fdat<=dat_); */

         SELECT a.KF, a.KV, nvl(s.OSTF-s.DOS+s.KOS,0)
           INTO kf_, kv_, ostc_
           FROM accounts a
              , ( SELECT x.* 
                    FROM saldoa x
                   WHERE x.acc=acc_ 
                     AND x.fdat = ( SELECT MAX(fdat) FROM saldoa WHERE acc=acc_ AND fdat<=dat_ )
                ) s
          WHERE a.acc = s.acc(+) 
            and a.acc = acc_;
         i_:= id_;
      END IF;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN RETURN 0;
   END;

   BEGIN
      SELECT ir, br, op
        INTO ir_,br_,op_
        FROM int_ratn 
       WHERE acc=acc_ 
         AND id=i_
         AND bdat = ( SELECT MAX(bdat) FROM int_ratn
                       WHERE acc=acc_ AND id=i_ AND bdat<=dat_);
   EXCEPTION
     WHEN NO_DATA_FOUND THEN RETURN 0;
   END;

  -- Учитываем шкалы процентных ставок
  IF br_>0 
  THEN
    P_BNS( br_, ostp_, dat_, br_, kv_, ABS(ostc_), op_, ir_, kf_ );
    RETURN br_;
  ELSE
    RETURN ir_;
  END IF;
  
END FPROCN;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION:    make_int
%
% DESCRIPTION: Универсальная процедура начисления процентов
%                 (проценты начисляются по подмножеству счетов,
%                  которое задается курсором)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE MAKE_INT(
  -- Курсор, по которому выполняется начисление %
  acc_cur IN AccCurTyp,
  -- Производить ли прогресс-индикацию процесса начисления процентов
  indicate_progress BOOLEAN DEFAULT FALSE  ) IS
BEGIN
  NULL;
END;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION:    pay_int
%
% DESCRIPTION: Универсальная процедура выплаты процентов
%                 (проценты выплачиваются по подмножеству счетов,
%                  которое задается курсором)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE PAY_INT(
  -- Курсор, по которому выполняется выплата %
  acc_cur IN AccCurTyp,
  -- Производить ли прогресс-индикацию процесса начисления процентов
  indicate_progress BOOLEAN DEFAULT FALSE  ) IS
BEGIN
  NULL;
END;
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   PROCEDURE: acr_dati
%
% DESCRIPTION: Вставка записи-истории о начислении процентов,
%              если, в будущем будет необходимость
%               СТОРНО или персчета процентов.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
PROCEDURE acr_dati (acc_ INTEGER, id_ SMALLINT,
                    ref_ INTEGER, dat_ DATE, remi_ NUMBER) IS
-- Вставка даты начисления %%
acr_dat_  DATE;
BEGIN

   acr_dat_:=dat_;

   insert into acr_docs(acc, id, int_date, int_ref, int_rest)
   values (acc_, id_, acr_dat_, ref_, remi_);
exception when others then
   if (sqlcode = -0001) then raise_application_error(-20001,
    '\9566 - По цьому рах. вже було виконано нарахування за дату # '||acr_dat_|| ',РЕФ = '||ref_,TRUE);
   else raise;
   end if;
END acr_dati;
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   PROCEDURE: acr_back
%
% DESCRIPTION: СТОРНО начисленных процентов на основе
%                истории о начислении процентов,
%               по счету, с заданной по текущую дату.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
PROCEDURE acr_back (acc_ INTEGER, id_ SMALLINT, dat_ DATE) IS
l_ref  oper.ref%type;
BEGIN

    for c in (select p.int_ref, p.int_date, p.int_rest
                from int_accn e, acr_docs p
               where e.acc       = acc_
                 and e.id        = id_
                 and e.acc       = p.acc
                 and e.id        = p.id
                 and p.int_date >= dat_
              order by p.int_date desc nulls last)
    loop
      -- удаляем документ
      gl.pay_bck(c.int_ref);

      -- формируем сторно документ
      gl.ref(l_ref);

      insert into oper (ref,tt,vob,nd,pdat,vdat,kv,dk,s,datd,datp,
      nam_a,nlsa,mfoa,nam_b,nlsb,mfob,nazn,userid,id_a,id_b,s2,kv2,sos)
      select l_ref, 'BAK', 6, substr(l_ref,-10), SYSDATE, gl.bDATE, kv, 1-dk, s, gl.bDATE, gl.bDATE,
             nam_a, nlsa, mfoa, nam_b, nlsb, mfob,
             'СТОРНО помилково нарахованих %% по док. '||TRIM(nd)||' за '||datd,
             gl.aUID, id_a, id_b, s2, kv2, sos
        from oper
       where ref = c.int_ref;

      update opldok
         set ref = l_ref
       where ref  = c.int_ref
         and fdat = gl.bDATE;

/*
      if (sql%rowcount = 0) then
          delete from oper where ref = l_ref;
      end if;
*/

      update int_accn
         set acr_dat = c.int_date,
             s       = c.int_rest
       where acc = acc_
         and id  = id_;

      delete from acr_docs
       where acc     = acc_
         and id      = id_
         and int_ref = c.int_ref;
   end loop;

end acr_back;

-- Для вычисления истории остатков по календарным дням
FUNCTION ho_ost ( acc_ NUMBER, fdat_ DATE, delt_ NUMBER, rw_ NUMBER)
RETURN NUMBER IS
x NUMBER;
BEGIN
   IF rw_=1 THEN
      BEGIN
         SELECT ostf INTO cOST FROM saldoa WHERE acc=acc_ AND fdat=fdat_;
      EXCEPTION WHEN NO_DATA_FOUND THEN cOST := 0;
      END;
   END IF;
   x:=cOST;
   cOST := cOST + delt_;
   RETURN x;
END;

-- Процедура установки флага работы по накопительной таблице
procedure set_collect_salho(p_collected in number)
is
begin
    g_collected := (case when (p_collected=1) then 1 else 0 end);
end set_collect_salho;

-- Функция получения флага работы по накопительной таблице
function get_collect_salho return number deterministic
is
begin
    return nvl(g_collected, 0);
end get_collect_salho;

----------------------------------------------------------------------------------------------------

  ---
  -- SET_BRATES
  ---
  procedure SET_BRATES
  ( p_br_id        in out brates.br_id%type
  , p_br_tp        in     brates.br_type%type default 1
  , p_br_nm        in     brates.name%type
  , p_br_frml      in     brates.formula%type default null
  , p_actv         in     brates.inuse%type   default 1
  , p_cmnt         in     brates.comm%type    default null
  , p_err_msg         out varchar2
  ) is
  /**
  <b>SET_BRATES</b> - Створення / редагування параметрів базової ставки
  %param p_br_id   - Ід базової ставки
  %param p_br_tp   - Тип базової ставки
  %param p_br_nm   - Назва базової ставки
  %param p_br_frml - SQL-формула для ставки з типом = 4
  %param p_actv    - Ознака активності (1 - діюча, 0 - недіюча)
  %param p_cmnt    - Коментар
  %param p_err_msg - Текст помилки

  %version 1.0 (21.12.2016)
  %usage   Створення / редагування базової ставки
  */
    title    constant     varchar2(60) := $$PLSQL_UNIT||'.SET_BRATES';
    type r_brates_type is record ( br_type   brates.br_type%type
                                 , name      brates.name%type
                                 , formula   brates.formula%type
                                 , inuse     brates.inuse%type
                                 , comm      brates.comm%type
                                 );
    r_brates              r_brates_type;
    e_brates              exception;
  begin

    bars_audit.trace( '%s: Entry with ( p_br_id=%s, p_br_tp=%s, p_br_nm=%s, p_br_frml=%s, p_actv=%s, p_cmnt ).'
                    , title, to_char(p_br_id), to_char(p_br_tp), p_br_nm, p_br_frml, to_char(p_actv), p_cmnt );

    begin

      if ( p_br_id > 0 )
      then

        begin
          select BR_TYPE, NAME, FORMULA, INUSE, COMM
            into r_brates
            from BARS.BRATES
           where BR_ID = p_br_id;
        exception
          when NO_DATA_FOUND then
--          raise_application_error( -20666, 'Not found record with id='||to_char(p_br_id), true );
            p_err_msg := 'Not found record with id='||to_char(p_br_id);
            raise e_brates;
        end;

        case
          when ( p_br_tp Is Not Null and r_brates.br_type != p_br_tp )
          then -- зміна типу базової ставки
--          raise_application_error( -20666, 'Зміна типу базової ставки заборонена', true );
            p_err_msg := 'Changing type of base rate is not allowed';
            raise e_brates;
          when ( p_br_frml Is Not Null and r_brates.br_type != 4 )
          then -- первіка на допустипу комбінацію параметрів
--          raise_application_error( -20666, 'Формула допустима лише для базової ставки з типом = 4', true );
            p_err_msg := 'Value for parameter [p_br_frml] permitted only for base rate with type = 4';
            raise e_brates;
          else
            null;
        end case;

        update BARS.BRATES
           set NAME    = nvl(p_br_nm,  r_brates.name   )
             , FORMULA = nvl(p_br_frml,r_brates.formula)
             , INUSE   = nvl(p_actv,   r_brates.inuse  )
             , COMM    = nvl(p_cmnt,   r_brates.comm   )
         where BR_ID   = p_br_id;

      else

        if ( p_br_nm Is Null )
        then
--        raise_application_error( -20666, 'Value fo parameter [p_br_nm] must be specified', true );
          p_err_msg := 'Value fo parameter [p_br_nm] must be specified';
          raise e_brates;
        end if;

        r_brates.br_type := nvl(p_br_tp,1);
        r_brates.name    := p_br_nm;
        r_brates.formula := case when p_br_tp = 4 then p_br_frml else null end;
        r_brates.inuse   := nvl(p_actv,1);
        r_brates.comm    := p_cmnt;

        insert
          into BARS.BRATES
             ( BR_TYPE, NAME, FORMULA, INUSE, COMM )
        values
             ( r_brates.BR_TYPE, r_brates.NAME, r_brates.FORMULA, r_brates.INUSE, r_brates.COMM )
        returning BR_ID into p_br_id;

      end if;

    exception
      when e_brates then
        null;
      when OTHERS then
        p_err_msg := dbms_utility.format_error_stack();
        bars_audit.error( title ||': '|| p_err_msg || CHR(10) || dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit with ( p_br_id=%s, p_err_msg=%s ).'
                    , title, to_char(p_br_id), p_err_msg );

  end SET_BRATES;

  ---
  -- SET_BRATE_VAL
  ---
  procedure SET_BRATE_VAL
  ( p_br_id        in     br_tier_edit.br_id%type
  , p_ccy_id       in     br_tier_edit.kv%type
  , p_eff_dt       in     br_tier_edit.bdate%type
  , p_amnt         in     br_tier_edit.s%type
  , p_rate         in     br_tier_edit.rate%type
  , p_err_msg         out varchar2
  ) is
  /**
  <b>SET_BRATE_VAL</b> - Створення / редагування значення базової ставки
  %param p_br_id   - Ід базової ставки
  %param p_ccy_id  - Код валюти
  %param p_eff_dt  - Дата початку дії ставки
  %param p_rate    - Значення ставки
  %param p_amnt    - Сума ( для br_type >= 2 )
  %param p_err_msg - Текст помилки

  %version 1.1 (13.03.2017)
  %usage   Створення / редагування значення базової ставки
  */
    title    constant     varchar2(60) := $$PLSQL_UNIT||'.SET_BRATE_VAL';
    l_br_tp               br_types.br_type%type;
  begin

    bars_audit.trace( '%s: Entry with ( p_br_id=%s, p_ccy_id=%s, p_eff_dt=%s, p_rate=%s ).'
                    , title, to_char(p_br_id), to_char(p_ccy_id), to_char(p_eff_dt,'dd.mm.yyyy'), to_char(p_rate) );

    begin

      -- checks
      case
        when ( p_br_id Is Null )
        then p_err_msg := 'Value fo parameter [p_br_id] must be specified';
        when ( p_ccy_id Is Null )
        then p_err_msg := 'Value fo parameter [p_ccy_id] must be specified';
        when ( p_eff_dt Is Null )
        then p_err_msg := 'Value fo parameter [p_eff_dt] must be specified';
        when ( p_rate Is Null or p_rate < 0 )
        then p_err_msg := 'Value fo parameter [p_rate] must be greater than or equal to 0';
        else
          begin

            select BR_TYPE
              into l_br_tp
              from BRATES
             where BR_ID = p_br_id;

            bars_audit.trace( '%s: l_br_tp=%s.', title, to_char(l_br_tp) );

            if ( l_br_tp > 1 and p_amnt Is Null )
            then
              p_err_msg := 'Value fo parameter [p_amnt] must be specified for base rate with type = '||to_char(l_br_tp);
            end if;

          exception
            when NO_DATA_FOUND then
              p_err_msg := 'Not found base rate with id='||to_char(p_br_id);
          end;

      end case;

      if ( p_err_msg Is Null )
      then

        if ( sys_context('bars_context','policy_group') = 'CENTER' )
        then -- для всіх РУ (тіль вставка - існуючі значення не перетираємо)

          bars_audit.trace( '%s: policy_group="CENTER" (run by all KF).', title, to_char(l_br_tp) );

--        for c in ( select KF
--                     from MV_KF )
--        loop
--
--          begin
--
--            if ( l_br_tp = 1 )
--            then
--
--              insert
--                into BR_NORMAL_EDIT
--                   ( KF, BR_ID, BDATE, KV, RATE )
--              values
--                   ( c.KF, p_br_id, p_eff_dt, p_ccy_id, p_rate );
--
--            else
--
--              insert
--                into BR_TIER_EDIT
--                   ( KF, BR_ID, BDATE, KV, S, RATE )
--              values
--                   ( c.KF, p_br_id, p_eff_dt, p_ccy_id, p_amnt, p_rate );
--
--            end if;
--
--          exception
--            when DUP_VAL_ON_INDEX then
--              null;
--          end;
--
--        end loop;

        else -- для поточного РУ користувача

          begin

            if ( l_br_tp = 1 )
            then

              update BR_NORMAL_EDIT
                 set RATE  = p_rate
               where BR_ID = p_br_id
                 and KV    = p_ccy_id
                 and BDATE = p_eff_dt;

              if ( sql%rowcount = 0 )
              then

                insert
                  into BARS.BR_NORMAL_EDIT
                     ( BR_ID, BDATE, KV, RATE )
                values
                     ( p_br_id, p_eff_dt, p_ccy_id, p_rate );

              end if;

            else

              update BR_TIER_EDIT
                 set RATE  = p_rate
               where BR_ID = p_br_id
                 and KV    = p_ccy_id
                 and BDATE = p_eff_dt
                 and S     = p_amnt;

              if ( sql%rowcount = 0 )
              then

                if ( l_br_tp = 5 or l_br_tp = 6 )
                then -- логіка тригера TIU_TIER
                  
                  select case
                         when exists ( select 1 from BR_TIER_EDIT where BR_ID = p_br_id and KV <> p_ccy_id )
                         then 'No more then one currency for the scale alowed'
                         else Null
                         end
                    into p_err_msg
                    from dual;
                  
                end if;
                
                if ( p_err_msg Is Null )
                then
                  insert 
                    into BR_TIER_EDIT
                       ( BR_ID, BDATE, KV, S, RATE )
                  values
                       ( p_br_id, p_eff_dt, p_ccy_id, p_amnt, p_rate );
                end if;

              end if;

            end if;

          end;

        end if;

      end if;

    exception
      when OTHERS then
        p_err_msg := dbms_utility.format_error_stack();
        bars_audit.error( title ||': '|| p_err_msg || CHR(10) || dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit with ( p_err_msg=%s )', title, p_err_msg );

  end SET_BRATE_VAL;

  ---
  -- DEL_BRATE_VAL
  ---
  procedure DEL_BRATE_VAL
  ( p_br_id        in     br_tier_edit.br_id%type
  , p_ccy_id       in     br_tier_edit.kv%type
  , p_eff_dt       in     br_tier_edit.bdate%type
  , p_amnt         in     br_tier_edit.s%type
  , p_err_msg         out varchar2
  ) is
  /**
  <b>DEL_BRATE_VAL</b> - Видалення значення базової ставки
  %param p_br_id   - Ід базової ставки
  %param p_ccy_id  - Код валюти
  %param p_eff_dt  - Дата початку дії ставки
  %param p_amnt    - Сума ( для br_type >= 2 )
  %param p_err_msg - Текст помилки

  %version 1.0 (22.12.2016)
  %usage   Видалення значення базової ставки
  */
    title    constant     varchar2(60) := $$PLSQL_UNIT||'.DEL_BRATE_VAL';
    l_br_tp               br_types.br_type%type;
  begin

    bars_audit.trace( '%s: Entry with ( p_br_id=%s, p_ccy_id=%s, p_eff_dt=%s, p_amnt=%s ).'
                    , title, to_char(p_br_id), to_char(p_ccy_id), to_char(p_eff_dt,'dd.mm.yyyy'), to_char(p_amnt) );

    begin

      begin

        select BR_TYPE
          into l_br_tp
          from BRATES
         where BR_ID = p_br_id;

        if ( l_br_tp = 1 )
        then
          delete BR_NORMAL_EDIT
           where BR_ID = p_br_id
             and KV    = p_ccy_id
             and BDATE = p_eff_dt;
        else
          if ( p_amnt Is Null )
          then
             p_err_msg := 'Value fo parameter [p_amnt] must be specified for base rate with type = '||to_char(l_br_tp);
          else
            delete BR_TIER_EDIT
             where BR_ID = p_br_id
               and KV    = p_ccy_id
               and BDATE = p_eff_dt
               and S     = p_amnt;
          end if;
        end if;

        if ( sql%rowcount > 0 )
        then
          bars_audit.trace( '%s: base rate #%s deleted.', title, to_char(p_br_id) );
        end if;

      exception
        when NO_DATA_FOUND then
          p_err_msg := 'Not found base rate with id='||to_char(p_br_id);
      end;

    exception
      when OTHERS then
        p_err_msg := dbms_utility.format_error_stack();
        bars_audit.error( title ||': '|| p_err_msg || CHR(10) || dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit with ( p_err_msg=%s )', title, p_err_msg );

  end DEL_BRATE_VAL;



begin
  null;
END acrN;
/

show errors;

grant EXECUTE on ACRN to BARS_ACCESS_DEFROLE; 
grant EXECUTE on ACRN to BARSUPL;
grant EXECUTE on ACRN to BARS_DM;
grant EXECUTE on ACRN to DPT_ROLE;
grant EXECUTE on ACRN to FOREX;
grant EXECUTE on ACRN to RCC_DEAL;
grant EXECUTE on ACRN to START1;
grant EXECUTE on ACRN to WR_ACRINT;
grant EXECUTE on ACRN to WR_ALL_RIGHTS;
