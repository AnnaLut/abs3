
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dr.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DR IS

-- Copyryight : UNITY-BARS
-- Author     : SERG
-- Created    : ?
-- Purpose    : Реестр должников

-- global consts
G_HEADER_VERSION constant varchar2(64)  := 'version 2.01 03/08/2010';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := ''
;

----
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2;

----
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2;

---------
/**
  Население временной таблицы нашими должниками за дату
*/
PROCEDURE dr_new(DAT_ date);
---------
/*
 * PROCEDURE in_headers_proc - обработка заголовков
 * SERG: 01-DEC-2001
 * Код процедуры: 201
 * Возможные коды возвращаемых ошибок:
 */
PROCEDURE in_headers_proc(
            ret_         OUT NUMBER,   -- Код ошибки
            retAux_      OUT NUMBER,   -- Дополнительный код ошибки
            reqId_       OUT VARCHAR2, -- Идентификатор запроса
            fName_           VARCHAR2, -- Имя файла
            fDate_           DATE,     -- Дата и время создания файла
            ilCount_         NUMBER,   -- Количество ИС в файле
            sumDebit_        NUMBER,   -- Число 0
            sumCredit_       NUMBER,   -- Число 0
            fileSign_        RAW,      -- ЭЦП файла
            signKey_         VARCHAR2, -- Идентификатор ключа ЭЦП
            reserve_         VARCHAR2, -- Резерв
            headSign_        RAW,      -- ЭЦП строки заголовка файла
            kFName_          VARCHAR2, -- Имя квитированного файла
            kFDate_          DATE,     -- Дата и время создания квитированного файла
            kILCount_        NUMBER,   -- Количество ИС в квитированном файле
            kFErrorCode_     SMALLINT, -- Код ошибки по квитированному файлу
            kSumDebit_       NUMBER,   -- Число 0
            kSumCredit_      NUMBER,   -- Число 0
            kFileSign_       RAW,      -- ЭЦП квитированного файла
            kSignKey_        VARCHAR2, -- Идентификатор ключа ЭЦП квитированного файла
            fType_           CHAR,               -- Идентификатор фазы
            entryNo_         SMALLINT  -- Порядковый номер вызова процедуры
  );
---------
PROCEDURE pf_name;
---------
--* PROCEDURE item_kwt - квитовка(блокировка) записей в debreg
--* SERG: 01-DEC-2001
--* Код процедуры: 203
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE item_kwt(p_szFName     CHAR,
                   p_dtDATE      DATE,
                   p_nLineNum    SMALLINT,
                   p_nErrorCode  SMALLINT);

---------
--/**
--* PROCEDURE file_kwt - квитовка файлов
--* SERG: 01-DEC-2001
--* Код процедуры: 204
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE file_kwt(p_szFName     CHAR,
                   p_dtDATE      DATE,
                   p_nLineNum    SMALLINT,
                   p_nErrorCode  SMALLINT,
                   p_nTicLines   SMALLINT);

---------
--/**
--* PROCEDURE find_request - поиск запроса
--* SERG: 11-DEC-2001
--* Код процедуры: 205
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE find_request(p_szReqId     OUT VARCHAR2,
                       p_szFName         CHAR,
                       p_dtDATE          DATE,
                       p_nLineNum        NUMBER);

---------
--/**
--* PROCEDURE update_request - квитовка запроса
--* SERG: 11-DEC-2001
--* Код процедуры: 206
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE update_request( p_szReqId     VARCHAR2,
                          p_nSOS        NUMBER,
                          p_nErrorCode  NUMBER);

PROCEDURE refresh_debreg
  (acc_        NUMBER,
   adr_        VARCHAR2,
   crdagrnum_  VARCHAR2,
   crddate_    DATE,
   custtype_   NUMBER,
   kv_         NUMBER,
   nmk_        VARCHAR2,
   okpo_       VARCHAR2,
   prinsider_  NUMBER,
   summ_       NUMBER,
   rezid_      NUMBER,
   debdate_    DATE,
   osn_        VARCHAR2);

---------
END dr;
-----
/
CREATE OR REPLACE PACKAGE BODY BARS.DR IS

-- Copyryight : UNITY-BARS
-- Author     : SERG
-- Created    : ?
-- Purpose    : Реестр должников

  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 2.04 31/05/2017';

  G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := ''
  ;  

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header DR '||G_HEADER_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_HEADER_DEFS;
  end header_version;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body DR '||G_BODY_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_BODY_DEFS;
  end body_version;

/**
  Население временной таблицы нашими должниками за дату
*/
PROCEDURE dr_new(DAT_ date) is
  cc_id_   varchar2(16);
  sdate_   date;
begin
  logger.debug('dr.dr_new(): start');
  -- большие дебеторы
  DELETE from deb_reg_rnk;
  if newnbs.g_state = 1 THEN
     INSERT into deb_reg_rnk (rnk, sumd )
     SELECT a.rnk RNK, -sum(gl.p_icurval(a.kv, fost(a.acc, DAT_) , DAT_)) SUMD
     FROM accounts a, nbs_ob22_tip n
     WHERE n.tip in ('SP ','SPN','SK9') and a.nbs||nvl(a.ob22,'00')=n.nbs||N.OB22 and (a.dazs is null or a.dazs > DAT_) 
     GROUP BY a.rnk
     HAVING -sum(gl.p_icurval(a.kv, fost(a.acc, DAT_) , DAT_)) > 1000000;
  else
     INSERT into deb_reg_rnk (rnk, sumd )
     SELECT a.rnk RNK, -sum(gl.p_icurval(a.kv, fost(a.acc, DAT_) , DAT_)) SUMD
     FROM accounts a, deb_reg_nbs b
     WHERE a.nbs=b.nbs and (a.dazs is null or a.dazs > DAT_) 
     GROUP BY a.rnk
     HAVING -sum(gl.p_icurval(a.kv, fost(a.acc, DAT_) , DAT_)) > 1000000;
  end if;

  -- добавляем RNK контрагентов, которые уже должны < 10 тыс, но записи по ним еще есть в зеркале
  if newnbs.g_state = 1 THEN
     INSERT into deb_reg_rnk (rnk, sumd )
     SELECT a.rnk RNK, -sum(gl.p_icurval(a.kv, fost(a.acc, DAT_), DAT_)) SUMD
     FROM accounts a, nbs_ob22_tip n
     WHERE n.tip in ('SP ','SPN','SK9') and a.nbs||nvl(a.ob22,'00')=n.nbs||N.OB22
           and a.rnk not in (select rnk from deb_reg_rnk)
           and a.acc in (select unique debnum from debreg_res_s  )
     GROUP BY a.rnk;
  else
     INSERT into deb_reg_rnk (rnk, sumd )
     SELECT a.rnk RNK, -sum(gl.p_icurval(a.kv, fost(a.acc, DAT_), DAT_)) SUMD
     FROM accounts a, deb_reg_nbs b
     WHERE a.acc=a.acc and a.nbs=b.nbs  
           and a.rnk not in (select rnk from deb_reg_rnk)
           and a.acc in (select unique debnum from debreg_res_s  )
     GROUP BY a.rnk;
  end if;
  --обновление таблицы просмотра
  DELETE from deb_reg_tmp;

--из оперативной все параметры       |Все параметры те же, кроме суммы
-------------------------------------|-------- из DEBREG
--EVENTTYPE -тип записи: 1-новая     | 2-обновление,3-погашение
--acc      - счет просроченного долга| DEBNUM
--OKPO     - ОКПО должника           | OKPO
--NMK,     - наименование должника   | NMK
--ADR,     - адрес должника          | ADR
--CUSTTYPE - тип должника            | CUSTTYPE (1-Юр,0-Физ)
--PRINSIDER- инсайдер                | PRINSIDER 
--KV       - вал долга               | KV
--SUM      - сумма просрочки по сч   | --SUMM
--DEBDATE, - дата возникнов просрочки| DEBDATE
--          (открытие счета просрочки)
--day      - количество просроч дней |
--rezid    - резидентность           | REZID  
--CRDAGRNUM-номер договора/счета     | CRDAGRNUM
--sumd     - общая сумма долга по кл |
--CRDDATE  - дата договора           | CRDDATE
--OSN      - Данi про керiвникiв та засновникiв
-----------------------------------------------------------
  if newnbs.g_state = 1 THEN
     INSERT INTO deb_reg_tmp (EVENTTYPE, acc, nls, OKPO, NMK, ADR, CUSTTYPE,
            PRINSIDER, KV, SUM, DEBDATE, day, rezid, CRDAGRNUM, CRDDATE, sumd,
            OSN,EVENTDATE)
     --новые
     SELECT 1, a.acc, a.nls, c.okpo, c.nmk, c.ADR, decode(c.CUSTTYPE,3,0,1), nvl(c.PRINSIDER,99), a.kv, -(fost(a.acc, DAT_)), 
            nvl(to_date(cck_app.Get_ND_TXT (n.nd, 'DATSP'),'dd/mm/yyyy'),sd.fdat), DAT_ - sd.fdat, g.rezid, a.nls, to_date(null), r.sumd,
            substr(nvl2(k.ruk,'Директор: '||k.ruk,NULL)|| nvl2(w.value,'. Засновник: '||w.value,NULL), 1,250), sd.fdat
     FROM  customer  C, accounts A, deb_reg_rnk R, nbs_ob22_tip n, codcagent G, corps K, customerw W, saldoa sd,
           nd_acc n
     WHERE C.rnk=R.rnk and C.rnk=a.rnk and fost(a.acc, DAT_) <0 and    
           n.tip in ('SP ','SPN','SK9') and a.nbs||nvl(a.ob22,'00')=n.nbs||N.OB22 and 
           A.acc not in (select debnum from debreg_res_s where eventtype in (1,2,3)) and 
           a.acc=n.acc (+) and G.codcagent=C.codcagent and 
           nvl(c.okpo,0)<>nvl(F_OUROKPO,0) and  -- исключаем со своим ОКПО
           a.daos <= DAT_ 
           -- ищем основателя и директора
           and c.rnk=k.rnk(+) and c.rnk=w.rnk(+) and w.tag(+)='OSN'
           -- определяем дату возникновения просрочки
           and a.acc=sd.acc
           and (exists(select acc,max(fdat) mfdat from saldoa where acc=A.acc and fdat<=DAT_ and ostf=0 and dos>0 group by acc) 
           and (sd.acc,sd.fdat)=(select acc,max(fdat) mfdat from saldoa 
                                 where acc=A.acc and fdat<=DAT_ and ostf=0 and dos>0
                                 group by acc) 
           or   not exists(select acc,max(fdat) mfdat from saldoa where acc=A.acc and fdat<=DAT_ and ostf=0 and dos>0 group by acc) 
           and (sd.acc,sd.fdat)=(select acc,min(fdat) mfdat from saldoa where acc=A.acc group by acc));
  else
     INSERT INTO deb_reg_tmp (EVENTTYPE, acc, nls, OKPO, NMK, ADR, CUSTTYPE,
            PRINSIDER, KV, SUM, DEBDATE, day, rezid, CRDAGRNUM, CRDDATE, sumd,
            OSN,EVENTDATE)
     --новые
     SELECT 1, a.acc, a.nls, c.okpo, c.nmk, c.ADR, decode(c.CUSTTYPE,3,0,1), nvl(c.PRINSIDER,99), a.kv, -(fost(a.acc, DAT_)), 
            nvl(to_date(cck_app.Get_ND_TXT (n.nd, 'DATSP'),'dd/mm/yyyy'),sd.fdat), DAT_ - sd.fdat, g.rezid, a.nls, to_date(null), r.sumd,
            substr(nvl2(k.ruk,'Директор: '||k.ruk,NULL)|| nvl2(w.value,'. Засновник: '||w.value,NULL), 1,250), sd.fdat
     FROM  customer  C, accounts A, deb_reg_rnk R, deb_reg_nbs B, codcagent G, corps K, customerw W, saldoa sd,
           nd_acc n
     WHERE C.rnk=R.rnk and C.rnk=a.rnk and fost(a.acc, DAT_) <0 and    
           A.nbs=B.nbs and A.acc not in (select debnum from debreg_res_s where eventtype in (1,2,3)) and 
           a.acc=n.acc (+) and G.codcagent=C.codcagent and 
           nvl(c.okpo,0)<>nvl(F_OUROKPO,0) and  -- исключаем со своим ОКПО
           a.daos <= DAT_ 
           -- ищем основателя и директора
           and c.rnk=k.rnk(+) and c.rnk=w.rnk(+) and w.tag(+)='OSN'
           -- определяем дату возникновения просрочки
           and a.acc=sd.acc
           and (exists(select acc,max(fdat) mfdat from saldoa where acc=A.acc and fdat<=DAT_
                    and ostf=0 and dos>0
                    group by acc) 
		       and (sd.acc,sd.fdat)=(select acc,max(fdat) mfdat from saldoa where acc=A.acc and fdat<=DAT_
                    and ostf=0 and dos>0
                    group by acc) 
		  or   not exists(select acc,max(fdat) mfdat from saldoa where acc=A.acc and fdat<=DAT_
                    and ostf=0 and dos>0
                    group by acc) 
		       and (sd.acc,sd.fdat)=(select acc,min(fdat) mfdat from saldoa where acc=A.acc group by acc)
		 );
  end if;
   --UNION
-- повторные должники=1( RNK есть в deb_reg_rnk)
INSERT INTO deb_reg_tmp (EVENTTYPE, acc, nls, OKPO, NMK, ADR, CUSTTYPE,
         PRINSIDER, KV, SUM, DEBDATE, day, rezid, CRDAGRNUM, CRDDATE, sumd,
         OSN,EVENTDATE)
   SELECT 1, D.debnum, a.nls, d.okpo, d.nmk,  d.ADR, d.CUSTTYPE, d.PRINSIDER,  D.kv, -(fost(a.acc, DAT_)), d.DEBDATE, DAT_ - D.DEBDATE, 
          D.rezid, D.CRDAGRNUM, D.CRDDATE, r.sumd, d.osn, null
   FROM   debreg_res_s D, deb_reg_rnk R, accounts A
   WHERE d.eventtype=3 AND fost(a.acc, DAT_) <0 AND D.debnum=a.acc and a.rnk=R.rnk AND  D.DEBDATE < DAT_ 
         and a.acc not in (select acc from deb_reg_tmp)
         and a.acc not in (select debnum from  debreg_res_s where eventtype in  (1,2)) ;
          
  --UNION   
-- старые, но еще должники=2( RNK есть в deb_reg_rnk) и не повторно (eventtype<>3)
INSERT INTO deb_reg_tmp (EVENTTYPE, acc, nls, OKPO, NMK, ADR, CUSTTYPE,
         PRINSIDER, KV, SUM, DEBDATE, day, rezid, CRDAGRNUM, CRDDATE, sumd,
         OSN,EVENTDATE)
   SELECT 2, D.debnum, a.nls, d.okpo, d.nmk,  d.ADR, d.CUSTTYPE, d.PRINSIDER, 
          D.kv, -(fost(a.acc, DAT_)), d.DEBDATE, DAT_ - D.DEBDATE, 
          D.rezid, D.CRDAGRNUM, D.CRDDATE, r.sumd, d.osn, null
   FROM   debreg_res_s D, deb_reg_rnk R, accounts A
   WHERE d.eventtype<3 AND fost(a.acc, DAT_) <0 AND  D.debnum=a.acc and a.rnk=R.rnk AND
         D.DEBDATE < DAT_  and a.acc not in (select acc from deb_reg_tmp);                                      
--  UNION
-- старые, но уже не должн=3
INSERT INTO deb_reg_tmp (EVENTTYPE, acc, nls, OKPO, NMK, ADR, CUSTTYPE,
         PRINSIDER, KV, SUM, DEBDATE, day, rezid, CRDAGRNUM, CRDDATE, sumd,
         OSN,EVENTDATE)
   SELECT 3, D.debnum, a.nls, d.okpo, d.nmk,  d.ADR, d.CUSTTYPE, d.PRINSIDER,
          D.kv, 0, d.DEBDATE, DAT_ - D.DEBDATE,
          D.rezid, D.CRDAGRNUM, D.CRDDATE, 0, d.osn, null
   FROM   debreg_res_s D, accounts A
   WHERE  D.debnum=A.acc and A.ostc=0 
          and D.DEBDATE < DAT_  and D.debnum not in (select acc from deb_reg_man)
          and d.eventtype<3     and a.acc    not in (select acc from deb_reg_tmp);
--UNION
--левые
INSERT INTO deb_reg_tmp (EVENTTYPE, acc, nls, OKPO, NMK, ADR, CUSTTYPE,
         PRINSIDER, KV, SUM, DEBDATE, day, rezid, CRDAGRNUM, CRDDATE, sumd,
         OSN,EVENTDATE)
   SELECT 2, D.debnum, null, d.okpo, d.nmk,  d.ADR, d.CUSTTYPE, d.PRINSIDER, 
          D.kv, d.summ, d.DEBDATE, DAT_ - D.DEBDATE, 
          D.rezid, D.CRDAGRNUM, D.CRDDATE, 0, d.osn, null
   FROM   debreg_res_s D 
   WHERE  D.debnum<0 and D.DEBDATE < DAT_
             and D.debnum not in (select acc from deb_reg_tmp);

   for k in (select rowid ri, acc from deb_reg_tmp where EVENTTYPE=1 and acc>0 )
   loop
      sdate_ := null;
      --кредиты
      BEGIN
         select substr(cc_id,1,16), sdate INTO CC_ID_, SDATE_
         from cc_deal d, nd_acc n
         where n.acc=k.acc and n.nd=d.nd and rownum=1 order by d.nd desc;
      EXCEPTION WHEN NO_DATA_FOUND THEN 
         begin
            select substr(nvl(ndoc,nd),1,16), datd INTO CC_ID_, SDATE_
            from acc_over where acc=k.acc and rownum=1 order by datd desc;
         EXCEPTION WHEN NO_DATA_FOUND THEN 
            begin              
              select substr(nvl(ndoc,nd),1,16), datd into cc_id_, sdate_
              from acc_over where (acc_2067=k.acc or acc_2069=k.acc) and rownum=1;
            exception when no_data_found then
               begin
                  select nd, sdate into cc_id_, sdate_ from rez_w4_bpk where acc= k.acc and  TIP_KART = 42; -- COBUMMFO-3871
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  cc_id_:= null; sdate_ :=null;
               end; 
            end;
         end;
      END;

      if sdate_ is null THEN
         begin
            select daos into sdate_ from accounts where acc= k.acc;
         end;
      end if;

      update deb_reg_tmp set CRDAGRNUM = nvl(cc_id_,CRDAGRNUM), CRDDATE = nvl(sdate_, CRDDATE) where rowid=k.ri;
   end loop;
   logger.debug('dr.dr_new(): after loop on deb_reg_tmp');

   logger.debug('dr.dr_new(): finish');
-- commit;
end dr_new ;
-------
--* PROCEDURE in_headers_proc - обработка заголовков
--* SERG: 01-DEC-2001
--* Код процедуры: 201
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE in_headers_proc(
            ret_         OUT NUMBER,   -- Код ошибки
            retAux_      OUT NUMBER,   -- Дополнительный код ошибки
            reqId_       OUT VARCHAR2, -- Идентификатор запроса
            fName_           VARCHAR2, -- Имя файла
            fDate_           DATE,     -- Дата и время создания файла
            ilCount_         NUMBER,   -- Количество ИС в файле
            sumDebit_        NUMBER,   -- Число 0
            sumCredit_       NUMBER,   -- Число 0
            fileSign_        RAW,      -- ЭЦП файла
            signKey_         VARCHAR2, -- Идентификатор ключа ЭЦП
            reserve_         VARCHAR2, -- Резерв
            headSign_        RAW,      -- ЭЦП строки заголовка файла
            kFName_          VARCHAR2, -- Имя квитированного файла
            kFDate_          DATE,     -- Дата и время создания квитированного файла
            kILCount_        NUMBER,   -- Количество ИС в квитированном файле
            kFErrorCode_     SMALLINT, -- Код ошибки по квитированному файлу
            kSumDebit_       NUMBER,   -- Число 0
            kSumCredit_      NUMBER,   -- Число 0
            kFileSign_       RAW,      -- ЭЦП квитированного файла
            kSignKey_        VARCHAR2, -- Идентификатор ключа ЭЦП квитированного файла
            fType_           CHAR,               -- Идентификатор фазы
            entryNo_         SMALLINT  -- Порядковый номер вызова процедуры
  ) IS

mod_num                         CONSTANT POSITIVE := 1;    -- номер процедуры

ern               CONSTANT POSITIVE := 201;  -- indoc_elpay error code
err             EXCEPTION;
erm             VARCHAR2(80);

BEGIN
        IF deb.debug THEN
           deb.trace(mod_num,'Start dr.in_headers_proc()', 0);
        END IF;

EXCEPTION
    WHEN err THEN
                IF deb.debug THEN
                   deb.trace(mod_num,'Application error in dr.in_headers_proc',ern);
                END IF;
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    WHEN OTHERS THEN
                IF deb.debug THEN
                   deb.trace(mod_num,'General error in dr.in_headers_proc',ern);
                END IF;
        raise_application_error(-(20000+ern),SQLERRM,TRUE);
END in_headers_proc;
-------
--* PROCEDURE pf_name - назначение имен файлов PF
--* SERG: 01-DEC-2001
--* Код процедуры: 202
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE pf_name IS
mod_num                 CONSTANT POSITIVE := 2;    -- номер процедуры

ern             CONSTANT POSITIVE := 202;  -- error code
err             EXCEPTION;
erm             VARCHAR2(80);
dtCurDate               DATE;
dtDR_DATE               DATE;
szMFO                   VARCHAR2(14);
szMFOP                  VARCHAR2(14);
nPFN                    NUMBER;
nPCN                    NUMBER;
nPQN                    NUMBER;
nPRN                    NUMBER;
ownMD32                 CHAR(2)     DEFAULT NULL;  -- Sep data code
ownSAB                  CHAR(4);
chLastYearDig   CHAR(1);
nRowCount               NUMBER(6);
szFileName              CHAR(12);
dtFileDate              DATE;
szSeance                CHAR(2);
nRepeat                 NUMBER;
nRequestID              NUMBER;
nDebnum                 NUMBER;
nIterator               NUMBER;
chCurrentFType  CHAR(1);
l_dpa_sab               params.val%type;
-- курсор для назначения номера строки в файле
CURSOR RecCursor IS
   SELECT requestid, debnum FROM debreg_query
   WHERE phaseid='F' AND sos=0 AND (errorcode IS NULL OR errorcode=0)
                 AND filename=szFileName AND filedate=dtFileDate
   FOR UPDATE OF ilnum;
-- курсор для назначения имен фалов PC, PQ, PR
CURSOR CQR_Cursor IS
   SELECT requestid, debnum FROM debreg_query
   WHERE phaseid=chCurrentFType AND sos=0 AND (errorcode IS NULL OR errorcode=0)
                 AND filename IS NULL AND filedate IS NULL
   FOR UPDATE OF filename, filedate, ilnum;
BEGIN
        dbms_output.put_line('Start dr.pf_name()');
        -- получаем банковскую дату
        dtCurDate := gl.bDATE;
        dbms_output.put_line('dtCurDate = '|| dtCurDate);
        szMFO := gl.aMFO;
        dbms_output.put_line('szMFO = '|| szMFO);
        -- получим MFOP
        SELECT val INTO szMFOP FROM params WHERE par='MFOP';
        dbms_output.put_line('szMFOP = ' || szMFOP);
        -- MD32
        ownMD32 := sep.h2_rrp(TO_NUMBER(TO_CHAR(gl.bDATE,'MM')))||
                   sep.h2_rrp(TO_NUMBER(TO_CHAR(gl.bDATE,'DD')));
        dbms_output.put_line('ownMD32 = '|| ownMD32);
        -- SAB банка
        BEGIN
          SELECT sab INTO ownSAB FROM  banks WHERE  mfo = gl.aMFO ;
        EXCEPTION WHEN NO_DATA_FOUND THEN
          ownSAB := 'XXXX';
        END;
        -- если задан параметр DEB_SAB, используем его для формирования имен файлов
        begin
            select val 
              into l_dpa_sab
              from params
             where par='DEB_SAB'; 
            --
            ownSAB := substr(ownSAB,1,1)||l_dpa_sab;
        exception when no_data_found then
            null;
        end;
        dbms_output.put_line('ownSAB = '|| ownSAB);
        -- последняя цыфра года
        chLastYearDig := TO_CHAR(gl.bDATE,'Y');
        dbms_output.put_line('chLastYearDig = '|| chLastYearDig);
        -- получаем параметр dr_date и знач. счетчика
        SELECT dr_date, pfn, pcn, pqn, prn INTO dtDR_DATE, nPFN, nPCN, nPQN, nPRN
        FROM lkl_rrp WHERE mfo=szMFOP and kv=gl.baseval;
        -- выставляем счетчик PF-файлов
        IF dtDR_DATE IS NULL OR TRUNC(dtDR_DATE)<>TRUNC(dtCurDate) THEN
          dtDR_DATE:=dtCurDate;
          nPFN:=0; nPCN:=0; nPQN:=0; nPRN:=0;
          UPDATE lkl_rrp SET dr_date=dtDR_DATE, pfn=0,pcn=0,pqn=0,prn=0
          WHERE mfo=szMFOP and kv=gl.baseval;
        END IF;
        dbms_output.put_line('dtDR_DATE = '|| dtDR_DATE);
        dbms_output.put_line('nPFN = '|| nPFN);

        dtFileDate := TO_DATE (TO_CHAR(gl.bDATE,'MM-DD-YYYY')||' '||
                  TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');

        -- BEGIN: назначение имен файлов PF
        -- узнаем кол-во строк на отправку
        SELECT count(*) INTO nRowCount FROM DEBREG_QUERY
        WHERE phaseid='F' AND sos=0  AND (errorcode IS NULL OR errorcode=0)
                  AND filename IS NULL AND filedate IS NULL;
        dbms_output.put_line('nRowCount = '|| nRowCount);
        IF nRowCount>0 THEN  -- есть претенденты на поездку в НБУ
          -- формируем новое имя
          nPFN       := nPFN + 1;
          szSeance   := sep.h2_rrp(TRUNC(nPFN/36))||sep.h2_rrp(MOD(nPFN,36));
          szFileName := 'PF0'||SUBSTR(ownSAB,2,3)||ownMD32||'.'||chLastYearDig||szSeance;
          dbms_output.put_line('szFileName = '|| szFileName);
          dbms_output.put_line('dtFileDate = '|| dtFileDate);
          -- вставить запись в zag_pf
          -- предварительно - проверка
          SELECT COUNT(*) INTO nRepeat FROM zag_pf
          WHERE fn=szFileName AND TRUNC(dat)=TRUNC(dtFileDate);
          IF nRepeat>0 THEN
                 erm := '1 - File '||szFileName||' already exist';
         RAISE err;
          END IF;
          INSERT INTO zag_pf(fn,dat,n,sde,skr,otm)
          VALUES(szFileName, dtFileDate, nRowCount, 0, 0, 1);
          -- модифицировать соотв. строки в debreg_query
          UPDATE debreg_query SET filename=szFileName, filedate=dtFileDate
          WHERE phaseid='F' AND sos=0  AND (errorcode IS NULL OR errorcode=0)
                        AND filename IS NULL AND filedate IS NULL;
          -- назначить номера строк в debreg_query
          nIterator := 0;
          OPEN RecCursor;
          LOOP
                FETCH RecCursor INTO nRequestID, nDebnum;
                EXIT WHEN RecCursor%NOTFOUND;
                nIterator := nIterator+1;
            UPDATE debreg_query SET ilnum=nIterator WHERE CURRENT OF RecCursor;
          END LOOP;
          CLOSE RecCursor;
          -- увеличить счетчик
          UPDATE lkl_rrp SET pfn=nPFN WHERE mfo=szMFOP and kv=gl.baseval;
        END IF;
        -- END: назначение имен файлов PF

        -- BEGIN: назначение имен файлов PC
        chCurrentFType := 'C';
        OPEN CQR_Cursor;
        LOOP
          FETCH CQR_Cursor INTO nRequestID, nDebnum;
          EXIT WHEN CQR_Cursor%NOTFOUND;
          nPCN := nPCN + 1;
          szSeance   := sep.h2_rrp(TRUNC(nPCN/36))||sep.h2_rrp(MOD(nPCN,36));
          szFileName := 'PC0'||SUBSTR(ownSAB,2,3)||ownMD32||'.'||chLastYearDig||szSeance;
          UPDATE debreg_query SET filename=szFileName, filedate=dtFileDate, ilnum=1
          WHERE CURRENT OF CQR_Cursor;
        END LOOP;
        CLOSE CQR_Cursor;
        -- увеличить счетчик
        UPDATE lkl_rrp SET pcn=nPCN WHERE mfo=szMFOP and kv=gl.baseval;
        -- END: назначение имен файлов PC

        -- BEGIN: назначение имен файлов PQ
        chCurrentFType := 'Q';
        OPEN CQR_Cursor;
        LOOP
          FETCH CQR_Cursor INTO nRequestID, nDebnum;
          EXIT WHEN CQR_Cursor%NOTFOUND;
          nPQN := nPQN + 1;
          szSeance   := sep.h2_rrp(TRUNC(nPQN/36))||sep.h2_rrp(MOD(nPQN,36));
          szFileName := 'PQ0'||SUBSTR(ownSAB,2,3)||ownMD32||'.'||chLastYearDig||szSeance;
          UPDATE debreg_query SET filename=szFileName, filedate=dtFileDate, ilnum=1
          WHERE CURRENT OF CQR_Cursor;
        END LOOP;
        CLOSE CQR_Cursor;
        -- увеличить счетчик
        UPDATE lkl_rrp SET pqn=nPQN WHERE mfo=szMFOP and kv=gl.baseval;
        -- END: назначение имен файлов PQ

        -- BEGIN: назначение имен файлов PR
        chCurrentFType := 'R';
        OPEN CQR_Cursor;
        LOOP
          FETCH CQR_Cursor INTO nRequestID, nDebnum;
          EXIT WHEN CQR_Cursor%NOTFOUND;
          nPRN := nPRN + 1;
          szSeance   := sep.h2_rrp(TRUNC(nPRN/36))||sep.h2_rrp(MOD(nPRN,36));
          szFileName := 'PR0'||SUBSTR(ownSAB,2,3)||ownMD32||'.'||chLastYearDig||szSeance;
          UPDATE debreg_query SET filename=szFileName, filedate=dtFileDate, ilnum=1
          WHERE CURRENT OF CQR_Cursor;
        END LOOP;
        CLOSE CQR_Cursor;
        -- увеличить счетчик
        UPDATE lkl_rrp SET prn=nPRN WHERE mfo=szMFOP and kv=gl.baseval;
        -- END: назначение имен файлов PR

        dbms_output.put_line('Finish dr.pf_name()'|| NULL);
EXCEPTION
    WHEN err THEN
                dbms_output.put_line('Application error in dr.pf_name '|| ern);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    WHEN OTHERS THEN
                dbms_output.put_line('General error in dr.pf_name '|| ern);
        raise_application_error(-(20000+ern),SQLERRM,TRUE);
END pf_name;
-----
--* PROCEDURE item_kwt - квитовка(блокировка) записей в debreg
--* SERG: 01-DEC-2001
--* Код процедуры: 203
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE item_kwt(  p_szFName     CHAR,
                         p_dtDATE      DATE,
                         p_nLineNum    SMALLINT,
                         p_nErrorCode  SMALLINT) IS

mod_num                 CONSTANT POSITIVE := 3;    -- номер процедуры

ern         CONSTANT POSITIVE := 203;  -- error code
err         EXCEPTION;
erm         VARCHAR2(80);

szBuf           VARCHAR2(80);

BEGIN
  IF p_nLineNum=0 THEN
    UPDATE debreg_query SET errorcode=p_nErrorCode
        WHERE filename=p_szFName AND TRUNC(filedate)=TRUNC(p_dtDATE);
  ELSE
        UPDATE debreg_query SET errorcode=p_nErrorCode
        WHERE filename=p_szFName AND TRUNC(filedate)=TRUNC(p_dtDATE)
                  AND ilnum=p_nLineNum;
  END IF;

EXCEPTION
    WHEN err THEN
                dbms_output.put_line('Application error in dr.item_kwt' || ern);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    WHEN OTHERS THEN
                dbms_output.put_line('General error in dr.item_kwt' || ern);
        raise_application_error(-(20000+ern),SQLERRM,TRUE);

END item_kwt;
----------
--* PROCEDURE file_kwt - квитовка файлов
--* SERG: 01-DEC-2001
--* Код процедуры: 204
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE file_kwt(p_szFName       CHAR,
                         p_dtDATE      DATE,
                         p_nLineNum    SMALLINT,
                         p_nErrorCode  SMALLINT,
                                         p_nTicLines   SMALLINT) IS

mod_num                 CONSTANT POSITIVE := 4;    -- номер процедуры

ern         CONSTANT POSITIVE := 204;  -- error code
err         EXCEPTION;
erm         VARCHAR2(80);

szFName         CHAR(12);
dtDATE          DATE;
nOTM            SMALLINT;
dtDATK          DATE;
BEGIN
  -- ищем квитуемый файл
  BEGIN
        SELECT fn,dat,otm INTO szFName,dtDATE,nOTM
        FROM zag_pf WHERE fn=p_szFName AND TRUNC(dat)=TRUNC(p_dtDATE);
  EXCEPTION WHEN NO_DATA_FOUND THEN
        erm := '1103 - receipt on nonexisting file';
    RAISE err;
  END;
  IF nOTM=5 THEN  --  файл был уже сквитован?
    erm := '1104 - duplicate receipt on file '||p_szFName;
    RAISE err;
  END IF;
  IF p_nTicLines=0 AND p_nErrorCode<>0 THEN -- в квитанции нет строк  код ошибки != 0
    -- ставим отметку для переформирования
    UPDATE zag_pf SET otm=1 WHERE fn=p_szFName AND TRUNC(dat)=TRUNC(p_dtDATE);
        RETURN;
  END IF;
  -- дата квитовки
  dtDATK := TO_DATE (TO_CHAR(gl.bDATE,'MM-DD-YYYY')||' '||
                  TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');
  IF p_nErrorCode=0 THEN  -- т.е. "хорошая" квитанция
    -- квитуем
        UPDATE zag_pf SET otm=5,datk=dtDATK
        WHERE fn=p_szFName AND TRUNC(dat)=TRUNC(p_dtDATE);
  ELSE
    -- рассыпаем файл (строки файла должны быть предвварительно помечены с помощью ITEM_KWT)
        UPDATE debreg_query SET filename=NULL, filedate=NULL, ilnum=NULL
        WHERE  filename=p_szFName AND TRUNC(filedate)=TRUNC(p_dtDATE);
        DELETE FROM zag_pf WHERE fn=p_szFName AND TRUNC(dat)=TRUNC(p_dtDATE);
  END IF;
EXCEPTION
    WHEN err THEN
                dbms_output.put_line('Application error in dr.file_kwt ' || ern);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    WHEN OTHERS THEN
                dbms_output.put_line('General error in dr.file_kwt ' || ern);
        raise_application_error(-(20000+ern),SQLERRM,TRUE);
END file_kwt;
-------
--* PROCEDURE find_request - поиск запроса
--* SERG: 11-DEC-2001
--* Код процедуры: 205
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE find_request(  p_szReqId     OUT VARCHAR2,
                     p_szFName         CHAR,
                       p_dtDATE          DATE,
                       p_nLineNum        NUMBER) IS
mod_num     CONSTANT POSITIVE := 5;    -- номер процедуры
ern         CONSTANT POSITIVE := 205;  -- error code
err         EXCEPTION;
erm         VARCHAR2(80);
v_sos       number;

BEGIN
   SELECT
      TO_CHAR(requestid),sos
   INTO
      p_szReqId,v_sos
   FROM debreg_query
   WHERE
      filename=p_szFName AND
     TRUNC(filedate)=TRUNC(p_dtDATE) AND
     ilnum=p_nLineNum;
   if v_sos<>3 then
     erm := '701 - Duplicate ticket for '||p_szFName||', sos='||v_sos;
     raise err;
   end if;
   EXCEPTION
    WHEN err THEN
      dbms_output.put_line('Application error in dr.find_request ' ||ern);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    WHEN OTHERS THEN
      dbms_output.put_line('General error in dr.find_request ' ||ern);
        raise_application_error(-(20000+ern),SQLERRM,TRUE);
END find_request;
-----
--* PROCEDURE update_request - квитовка запроса
--* SERG: 11-DEC-2001
--* Код процедуры: 206
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE update_request(  p_szReqId     VARCHAR2,
                            p_nSOS        NUMBER,
                     p_nErrorCode  NUMBER) IS
mod_num     CONSTANT POSITIVE := 6;    -- номер процедуры
ern         CONSTANT POSITIVE := 206;  -- error code
err         EXCEPTION;
erm         VARCHAR2(80);
BEGIN
   UPDATE
      debreg_query
   SET
      sos       = p_nSOS,
      errorcode = p_nErrorCode
   WHERE
      requestid = p_szReqId;
EXCEPTION
    WHEN err THEN
      dbms_output.put_line('Application error in dr.updaete_request ' ||ern);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    WHEN OTHERS THEN
      dbms_output.put_line('General error in dr.updaete_request '||ern);
        raise_application_error(-(20000+ern),SQLERRM,TRUE);
END update_request;
-----

PROCEDURE refresh_debreg 
  (acc_        NUMBER,
   adr_        VARCHAR2,
   crdagrnum_  VARCHAR2,
   crddate_    DATE,
   custtype_   NUMBER,
   kv_         NUMBER,
   nmk_        VARCHAR2,
   okpo_       VARCHAR2,
   prinsider_  NUMBER,
   summ_       NUMBER,
   rezid_      NUMBER,
   debdate_    DATE,
   osn_        VARCHAR2) 
IS
BEGIN
  BEGIN
    INSERT INTO debreg 
     (debnum, adr, crdagrnum, crddate, custtype, kv, 
      nmk, okpo, prinsider, summ, rezid, debdate, osn)
    VALUES 
     (acc_, substr(adr_,1,70), substr(crdagrnum_,1,16), 
      crddate_, custtype_, kv_,
      substr(nmk_,1,70), substr(okpo_,1,14), prinsider_, 
      summ_, rezid_, debdate_, substr(osn_,1,250));
  EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN
         UPDATE debreg SET
                adr  = substr(adr_,1,70),
				crdagrnum = substr(crdagrnum_,1,16),
				crddate = crddate_,
				custtype = custtype_,
				kv = kv_,
				nmk = substr(nmk_,1,70),
				okpo = substr(okpo_,1,14),                
				prinsider = prinsider_,
				summ = summ_,
				rezid = rezid_,                       
                debdate = debdate_,
                osn = substr(osn_,1,250)
          WHERE debnum=acc_;
  END;
END refresh_debreg;

END dr;
/
 show err;
 
PROMPT *** Create  grants  DR ***
grant EXECUTE                                                                on DR              to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DR              to DEB_REG;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dr.sql =========*** End *** ========
 PROMPT ===================================================================================== 
 