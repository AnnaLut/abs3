
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/pul.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PUL IS
--***************************************************************************--
--                      BARS Global Variables Pool
--                   (C) Unity-BARS Version 2000-2006
--***************************************************************************--
G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := '2.4 04/12/2012';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';


     sal_rec saldoa%ROWTYPE;         -- Transit record of saldoa  (TRIG)
     acc_rec accounts%ROWTYPE;       -- Transit record of accounts update(TRIG)
     acc_otm SMALLINT;               -- Flag of kind changing for Accounts_Update
     cus_rec customer%ROWTYPE;       -- Transit record of customer update(TRIG)
     cus_otm SMALLINT;               -- Flag of kind changing for Customer_Update

     FL_2099 SMALLINT;               -- STA Для перехвата oоперации по вып.гарантий в PAYTT
     strLimNarrative VARCHAR2(160);  -- Часть назначения платежа для установки
     rck_hq NUMBER;                  -- Рег.номер клиента - корпорации для РЦК (Петрокоммерц)

     NEXT_BDATE date;                -- ближайшая банковская дата (или она же)
                                     -- от текущей gl.BDATE согласно календарю

--процедура загрузки одного ini-параметра в массив
procedure Set_Mas_Ini(tag_ varchar2, val_ varchar2, comm_ varchar2);
--функция получения значения одного ini-параметра из загруженного массива
function Get_Mas_Ini_Val(tag_ varchar2) return varchar2;
--функция получения коментария одного ini-параметра из загруженного массиваprocedure Set_Mas_Ini(tag_ varchar2, val_ varchar2, comm_ varchar2 );
function Get_Mas_Ini_Comm(tag_ varchar2) return varchar2;
--функция превращения бранча-2 в бранч-3 (ОПЧ).
function Branch3 (Brahch2_ varchar2) return varchar2;
-- установить значение переменной strLimNarrative
procedure SetLimNarrative(par_value varchar2);
-- вернуть значение переменной strLimNarrative
function GetLimNarrative return varchar2;
-- вернуть значение переменной rck_hq
function GetRckHQ return number;
-- 1(да)/0(нет) - является/нет филиал участником мультивал ВПС
function mvps_fil(p_mfo varchar2, p_kv int) return int;
-- установить значение
procedure put(tag_ varchar2, val_ varchar2);
-- получить значение
function  get(tag_ varchar2) return varchar2;
-- получить версию пакета
function ver return varchar2;
END pul;
/
CREATE OR REPLACE PACKAGE BODY BARS.PUL AS

G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 2.4 04/12/2012';
G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := '';

procedure Set_Mas_Ini(tag_ varchar2, val_ varchar2, comm_ varchar2 ) is
--процедура загрузки одного ini-параметра в массив
begin
   sys.dbms_session.set_context('bars_pul', tag_, val_,null, sys_context('userenv','client_identifier'));
end Set_Mas_Ini;
----------------

function Get_Mas_Ini_Val(tag_ varchar2) return varchar2 IS
--функция получения значения одного ini-параметра из загруженного массива
begin
   RETURN sys_context('bars_pul',tag_);
end Get_Mas_Ini_Val;
--------------------

function Get_Mas_Ini_Comm(tag_ varchar2) return varchar2 IS
--функция получения коментария одного ini-параметра из загруженного массива
begin
   RETURN 'Параметр '||tag_;
end Get_Mas_Ini_Comm;
---------------------

function Branch3 (Brahch2_ varchar2) return varchar2 is
  --функция превращения бранча-2 в бранч-3 (ОПЧ).
  --Раборает с пул-переменными.
  Branch_ varchar2(30);
  Len_ int;
begin
  Branch_ := Nvl( Brahch2_, pul.Get_Mas_Ini_Val('sPar1') );

  len_    := length(Branch_);

/* якщо бранч = /ММММММ/00РРРР/, то домальовуємо до нього його ОПЧ  = '06РРРР/'
   маємо   /ММММММ/00РРРР/06РРРР/ Tут РРРР - код ТВБВ 2-го р_вня.
*/
  if len_ =  8 then
     Branch_ := Branch_ ||'000000/'; len_ := 15;
  end if;

  If len_ = 15 then
     Branch_ := Branch_ || '06'|| substr(Branch_,-5);
  end if;

  Return Branch_;

end Branch3;

/**
  установить значение переменной strLimNarrative
*/
procedure SetLimNarrative(par_value varchar2) is
begin
   strLimNarrative := par_value;
end;

/**
  вернуть значение переменной strLimNarrative
*/
function GetLimNarrative return varchar2 is
begin
   return strLimNarrative;
end;

/**
  вернуть значение переменной RCK_HQ
*/
function GetRckHQ return number is
begin
   return rck_hq;
end;

/**
-- 1(да)/0(нет) - является/нет филиал участником мультивал ВПС
*/
FUNCTION mvps_fil (p_mfo VARCHAR2, p_kv INT)
   RETURN INT
IS
   l_ret   INT;
BEGIN
   bars_audit.info('pul.mvps' || chr(10) || 'mfo: '||p_mfo || 'p_kv: ' || p_kv);
   IF p_mfo = gl.amfo
   THEN
      RETURN 0;
   END IF;

   IF p_kv = gl.baseval
   THEN
      RETURN 1;
   END IF;

   BEGIN
      SELECT 1
        INTO l_ret
        FROM lkl_rrp
       WHERE mfo = p_mfo AND kv = p_kv;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         BEGIN
            SELECT 1
              INTO l_ret
              FROM banks b, lkl_rrp r
             WHERE r.kv = p_kv AND r.mfo = b.mfop AND b.mfo = p_mfo AND b.blk = 0;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_ret := 0;
         END;
   END;

   RETURN l_ret;
END mvps_fil;

/**
 * встановити значення змінної
 */
procedure put(tag_ varchar2, val_ varchar2) is
begin
   sys.dbms_session.set_context('bars_pul', tag_, val_,null, sys_context('userenv','client_identifier'));
end;
/**
 * отримати  значення змінної
 */
function get(tag_ varchar2) return varchar2 is
begin
   RETURN sys_context('bars_pul',tag_);
end;
/**
 * вернути версію пакета
 */
function ver return varchar2 is
begin
  return 'Package header PUL '||G_HEADER_VERSION||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||G_AWK_HEADER_DEFS||chr(10)||chr(10)||
         'Package body PUL '||G_BODY_VERSION||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||G_AWK_BODY_DEFS;
end ver;

--анонимный блок--анонимный блок--анонимный блок--анонимный блок--анонимный блок

/*BEGIN
BEGIN
   IF sys_context('userenv', 'proxy_user') = 'APPSERVER' THEN
      FOR k  IN (SELECT tag,val FROM tobo_params WHERE tobo=tobopack.gettobo and tag not like '%/%')
      LOOP
         sys.dbms_session.set_context('bars_pul', k.tag, k.val);
      END LOOP;
   END IF;
END;

BEGIN
   SELECT TO_NUMBER(VAL)
     INTO rck_hq
     FROM PARAMS
    WHERE PAR='RCK_HQ';
EXCEPTION WHEN NO_DATA_FOUND THEN
   rck_hq := 1;
END;

declare
  dTmp_ date := gl.BDATE;
  nTmp_ int;
begin
  While 1<2 loop
    begin
      SELECT kv
        INTO nTmp_
        FROM holiday
       WHERE kv = gl.baseval
         and holiday=dTmp_;
      dTmp_:= dTmp_ + 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NEXT_BDATE := dTmp_;
        exit;
    end;
  end loop;
end;*/
------
END pul;
/
 show err;
 
PROMPT *** Create  grants  PUL ***
grant EXECUTE                                                                on PUL             to ABS_ADMIN;
grant EXECUTE                                                                on PUL             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PUL             to FINMON01;
grant EXECUTE                                                                on PUL             to RCC_DEAL;
grant EXECUTE                                                                on PUL             to START1;
grant EXECUTE                                                                on PUL             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/pul.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 