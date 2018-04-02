
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/tic.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.TIC IS

  --***************************************************************--
  -- (C) BARS. Documents Print
  -- Version 1.12 20/07/2006
  --***************************************************************--

  G_HEADER_VERSION  CONSTANT VARCHAR2(64) := 'Version 1.3 23/04/2013';
  G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

  --****** header_version - возвращает версию заголовка пакета ****************--
  function header_version return varchar2;

  --****** body_version - возвращает версию тела пакета ***********************--
  function body_version return varchar2;

  -- Необходимые типы для хранения масива значений типа параметр-значение
  type t_list_attrs is table of varchar2(4000) index by varchar2(100);

  -- Список статически загруженых атрибутов и вх. параметры по которым они были загружены
  g_static_attrs t_list_attrs;

  g_static_recid   oper.ref%type := null; -- Реф. документа
  g_static_tabname varchar2(30) := null; -- Имя таблицы (OPER-внутр.док., ARC_RRP)
  g_static_mode    number := null; -- пока не исп.

  g_static_ticname varchar2(100); -- полное имя тикета (напр., memord_d)
  g_static_tt      varchar2(3); -- код операции tts
  g_static_ext_ref number; -- arc_rrp.ref

  --***************************************************************--
  -- PROCEDURE  : getListAttr
  -- DESCRIPTION  : Процедура формирования списка переменных и
  --                списка значений для документа
  --***************************************************************--

  PROCEDURE getListAttr(nRecID    NUMBER, -- Реф. документа
                        szTabName VARCHAR2, -- Имя таблицы (OPER-внутр.док., ARC_RRP)
                        nMode     NUMBER, -- пока не исп.
                        sTicName  OUT VARCHAR2, -- полное имя тикета (напр., memord_d)
                        lszVars   OUT VARCHAR2, -- список переменных
                        lszVals   OUT VARCHAR2, -- список значений
                        l_tt      OUT VARCHAR2, -- код операции
                        l_ext_ref OUT NUMBER -- arc_rrp.ref
                        );

  --***************************************************************--
  -- PROCEDURE  : init_static
  -- DESCRIPTION  : Инициализация статических значений атрибутов
  --***************************************************************--
  procedure init_static(nRecID    number, -- Реф. документа
                        szTabName varchar2 default 'OPER', -- Имя таблицы (OPER-внутр.док., ARC_RRP)
                        nMode     number default 0 -- пока не исп.
                        );

  --***************************************************************--
  -- PROCEDURE  : get_static_attr
  -- DESCRIPTION  : Получение значения атрибута из статического масива
  --***************************************************************--
  function get_static_attr(p_var     in varchar2, -- Имя атрибута
                           p_recid   in number,
                           p_tabname in varchar2 default 'OPER', -- Имя таблицы (OPER-внутр.док., ARC_RRP)
                           p_mode    in number default 0 -- пока не исп.
                           ) return varchar2;

END TIC;
/
CREATE OR REPLACE PACKAGE BODY BARS.TIC is

--***************************************************************--
-- (C) BARS. Documents Print
--***************************************************************--

G_BODY_VERSION  CONSTANT varchar2(64)  := 'version 1.37 01/04/2018';
G_AWK_BODY_DEFS CONSTANT varchar2(512) := ''
  || 'BRANCH - для мультимфо' || chr(13) || chr(10)
;

-- разделитель строковых значений
g_str_separator constant varchar2(5) := '~';

--****** header_version - возвращает версию заголовка пакета ****************--
function header_version return varchar2 is
begin
  return 'Package header TIC ' || G_HEADER_VERSION || '.' || chr(10)
      || 'AWK definition: ' || chr(10) || G_AWK_HEADER_DEFS;
end header_version;

--****** body_version - возвращает версию тела пакета ***********************--
function body_version return varchar2 is
begin
  return 'Package body TIC ' || G_BODY_VERSION || '.' || chr(10)
      || 'AWK definition: ' || chr(10) || G_AWK_BODY_DEFS;
end body_version;
--***************************************************************--


--***************************************************************--
-- PROCEDURE    : getListAttr
-- DESCRIPTION  : Процедура формирования списка переменных и
--                списка значений для документа
--***************************************************************--

procedure getListAttr (
  nRecID        number,     -- Реф. документа
  szTabName     varchar2,   -- Имя таблицы (OPER-внутр.док., ARC_RRP)
  nMode         number,     -- пока не исп.
  sTicName  out varchar2,   -- полное имя тикета (напр., memord_d)
  lszVars   out varchar2,   -- список переменных
  lszVals   out varchar2,   -- список значений
  l_tt      out varchar2,   -- код операции
  l_ext_ref out number      -- arc_rrp.ref
) is

  ern       number;
  err       exception;
  par1      varchar2(25);

  l_cursor integer;
  l_tmpnum integer;
  szMyBankName      varchar2(70);
  szMyBankMFO       varchar2(70);
  szMyBankAdres     varchar2(70);
  szPrintTimeStamp  varchar2(70);
  l_data        date;	-- дата документа
  l_datp        date;	-- банковская дата ввода документа
  l_vdat        date;	-- дата валютирования
  l_vdat_rate   date;	-- дата для расчета курса (if l_vdat>l_data and l_data>=l_datp)
  l_pdat        date;
  l_dk          number;
  l_s           number;
  l_sq          number;
  l_sqv         number;
  l_s2          number;
  l_sq2         number;
  l_sqv2        number;
  nVob          number;
  l_mfoa        varchar2(12);
  l_mfob        varchar2(12);
  l_nam_a       varchar2(38);
  l_nam_b       varchar2(38);
  l_id_a        varchar2(14);
  l_id_b        varchar2(14);
  l_nazn        varchar2(480); -- расчитано на 2 строки БИС-ов
  l_nd          varchar2(40);
  l_nlsa        varchar2(15);
  l_nlsb        varchar2(15);
  l_bank_a      varchar2(38);
  l_bank_b      varchar2(38);
  l_kv          number;
  l_kv2         number;
  l_sk          number;
  l_crnt_tt     varchar2(3);
  l_d_rec       varchar2(60);
  l_user_id     number;
  l_nlsa_a      varchar2(15);
  l_nlsb_a      varchar2(15);
  l_nmsa_a      varchar2(70);
  l_nmsb_a      varchar2(70);
  l_stmt        number;
  l_curschem    varchar2(100);
  l_ord         number;
  l_okpo        varchar2(10);
  szISOCCode    varchar2(3);
  szCcyName     varchar2(3);
  szCUnit       varchar2(3);
  szISOCCode2   varchar2(3);
  szCcyName2    varchar2(3);
  szCUnit2      varchar2(3);
  szPayer       varchar2(200);
  szPayer2      varchar2(200);
  szPayerOKPO   varchar2(200);
  szPayerAdres  varchar2(200);
  szPayerBD     varchar2(200);
  szDoc         varchar2(200);
  szDocProp     varchar2(200);
  szCashSymb    varchar2(38);
  szCashSComis  varchar2(38);
  szBoss        varchar2(70);
  szAccMan      varchar2(70);
  szUserName    varchar2(60);
  szS3800       varchar2(15);
  szS3801       varchar2(15);
  szS3801B      varchar2(15);
  szPFUNlsA     varchar2(15);
  szPFUNmsA     varchar2(70);
  szPFUNlsB     varchar2(15);
  szPFUNmsB     varchar2(70);
  szPFUNlsC     varchar2(15);
  szPFUNmsC     varchar2(70);
  szPFUNlsD     varchar2(15);
  szPFUNmsD     varchar2(70);
  szCashNls     varchar2(15);
  szCashNms     varchar2(70);
  szTransitNls  varchar2(15);
  szTransitNms  varchar2(70);
  szComisNls    varchar2(15);
  szComisNms    varchar2(70);
  szComisNazn   varchar2(160);
  szZvitDate    varchar2(200);
  szPmtDet      varchar2(200);
  nDig          number;
  nDig2         number;
  l_prv         number;
  l_prv2        number;
  nFSummPcnt    number;
  nFSummPcnt2   number;
  nFSummB       number;
  nFSummC       number;
  nFSummD       number;
  nSummComis    number;
  szRndNlsA     varchar2(15);
  szRndNlsB     varchar2(15);
  szRndNmsA     varchar2(70);
  szRndNmsB     varchar2(70);
  nRndMod       number;
  nRndSum1      number;
  nFRndSum1     number;
  nRndSum2      number;
  nRndCcy1      number;
  nRndCcy2      number;
  szRndCcy1     varchar2(3);
  szRndCcy2     varchar2(3);
  szRndSumPr    varchar2(254);
  szRndSumPr2   varchar2(254);
  szSubTrnNls   varchar2(15);
  szSubTrnNms   varchar2(70);
  nSubTrnSum    number;
  szTemplPrefix varchar2(8);
  szTemplSuffix varchar2(1);
  szTmpMName    varchar2(10);
  szTmpMNameV   varchar2(10);
  szTmpKMName   varchar2(10);
  szTmpKYear    varchar2(10);
  szSql         varchar2(2000);
  szAddTag      varchar2(5);
  szAddTagVal   operw.value%type;
  fExtDocuments number;     -- ! 1-OPER 2-D_HIST 3-ARC_RRO   (MIK)
  nOffOkpo      number;
  l_s_bs        number;
  nOverride4InfoPMT number;
  i             number;
  nSummA        number;
  nSummB        number;
  nKVA          number;
  nKVB          number;
  sISOA         varchar2(3);
  sISOB         varchar2(3);
  sISOName      varchar2(3);
  sISOName2     varchar2(3);
  nDigA         number;
  nDigB         number;
  sUnitA        varchar2(3);
  sUnitB        varchar2(3);
  nSummAQ       number;
  nSummBQ       number;
  LomExp        varchar2(200);
  LomKas        varchar2(200);
  LomFio        varchar2(200);
  szRndNlsAa    varchar2(15);
  szRndNmsAa    varchar2(70);
  szRndNlsBa    varchar2(15);
  szRndNmsBa    varchar2(70);
  szPFUNlsAa    varchar2(15);
  szPFUNmsAa    varchar2(70);
  szPFUNlsBa    varchar2(15);
  szPFUNmsBa    varchar2(70);
  szPFUNlsCa    varchar2(15);
  szPFUNmsCa    varchar2(70);
  szPFUNlsDa    varchar2(15);
  szPFUNmsDa    varchar2(70);
  nRatO         number;
  nRatB         number;
  nRatS         number;
  nRatOV        number;
  nRatBV        number;
  nRatSV        number;
  nRat1         number;
  nRat2         number;
  nRatOA        number;
  nRatBA        number;
  nRatSA        number;
  nRatOVA       number;
  nRatBVA       number;
  nRatSVA       number;
  nRatOB        number;
  nRatBB        number;
  nRatSB        number;
  nRatOVB       number;
  nRatBVB       number;
  nRatSVB       number;
  -- курс kv и kv2 к 980
  nRatO980A     number;
  nRatB980A     number;
  nRatS980A     number;
  nRatOV980A    number;
  nRatBV980A    number;
  nRatSV980A    number;
  nRatO980B     number;
  nRatB980B     number;
  nRatS980B     number;
  nRatOV980B    number;
  nRatBV980B    number;
  nRatSV980B    number;
  sDocIdName    varchar2(30);
  sTPar         varchar2(12);
  sTSql         varchar2(2000);
  sTmp          varchar2(2000);
  sXRatFun      varchar2(50);
  l_nbs_a       accounts.nbs%type;
  l_nbs_b       accounts.nbs%type;


function to_charD(nVal_ number, sVal_ varchar2) return varchar2 IS
begin
  Return Replace(to_char( nVal_, sVal_ ), '.', ',') ;
end;

begin
  szMyBankMFO  := gl.aMFO ;
  begin
     select max(decode(par,'NAME',val,'')),
            max(decode(par,'ADDRESS',val,'')),
            nvl(max(decode(par,'XRATFUN',val,'')),'gl.x_rat')
       into szMyBankName, szMyBankAdres, sXRatFun
       from params
      where par in ('NAME', 'ADDRESS', 'XRATFUN') ;
  exception when no_data_found then
     szMyBankName  := '';
     szMyBankAdres := '';
     sXRatFun      := 'gl.x_rat';
  end;
  szPrintTimeStamp := to_char(sysdate,'dd/MM/yyyy hh24:mi:ss') ;

  -- внутренний документ OPER
  if    UPPER(szTabName) = 'OPER' then
     fExtDocuments := 1 ;
     sDocIdName := 'ref';
  -- внутренний документ D_HIST
  elsif UPPER(szTabName) = 'HIST' then
     fExtDocuments := 2 ;
  -- внешний    документ ARC_RRP
  else
     fExtDocuments := 3 ;
     sDocIdName := 'rec';
  end if;

  -- для архивной схемы всегда смотрим oper
  l_curschem := sys_context('userenv', 'current_schema');

  if l_curschem = 'HIST' then
     fExtDocuments := 1 ;
     sDocIdName    := 'ref';
  end if;

  if fExtDocuments = 1 then
     begin
        select tt, vob, dk, datd, s, s2, sq, mfoa,
               decode(id_a,'','99999',id_a), mfob,
               decode(id_b,'','99999',id_b), nam_a, nam_b, nazn, nd,
               nlsa, nlsb, kv, kv2, sk, vdat, userid, d_rec, pdat, datp
          into l_tt, nVob, l_dk, l_data, l_s, l_s2, l_sq, l_mfoa,
               l_id_a, l_mfob, l_id_b, l_nam_a, l_nam_b, l_nazn, l_nd,
               l_nlsa, l_nlsb, l_kv, l_kv2, l_sk, l_vdat, l_user_id, l_d_rec, l_pdat, l_datp
          from oper
         where ref = nRecID ;
     exception when others then
        -- '9260 - Не удалось прочитать данные для Реф #'||nRecID ;
        ern  := 1;
        par1 := to_char(nRecID);
        raise err;
     end;
  elsif fExtDocuments = 2 then
--    begin
--      select tt, vob, dk, datd, s, s2, sq, mfoa,
--             decode(id_a,'','99999',id_a), mfob,
--             decode(id_b,'','99999',id_b), nam_a, nam_b, nazn, nd,
--             nlsa, nlsb, kv, kv2, '', vdat, isp, drec, pdat
--      into l_tt, nVob, l_dk, l_data, l_s, l_s2, l_sq, l_mfoa,
--           l_id_a, l_mfob, l_id_b, l_nam_a, l_nam_b, l_nazn, l_nd,
--           l_nlsa, l_nlsb, l_kv, l_kv2, l_sk, l_vdat, l_user_id, l_d_rec, l_pdat
--      from hist
--      where ref=nRecID ;
--    exception when others then
--     erm :='9260 - Не удалось прочитать данные для Реф #'||nRecID ;
--      RAISE err;
--    end;
     null;
  else
     begin
        select ref, vob, dk, datd, s, mfoa,
               decode(id_a,'','99999',id_a), mfob,
               decode(id_b,'','99999',id_b), nam_a, nam_b, nazn, nd,
               nlsa, nlsb, kv, d_rec, datp, datp
          into l_ext_ref, nVob, l_dk, l_data, l_s, l_mfoa,
               l_id_a, l_mfob, l_id_b, l_nam_a, l_nam_b, l_nazn, l_nd,
               l_nlsa, l_nlsb, l_kv, l_d_rec, l_vdat, l_datp
          from arc_rrp
         where rec = nRecID ;
     exception when others then
        -- '9260 - Не удалось прочитать данные для Реф #'||nRecID ;
        ern  := 1;
        par1 := to_char(nRecID);
        raise err;
     end;
     l_user_id  := 0 ;
     szUserName := '' ;
  end if;

  -- Проверим наличие счета А в справочнике
    begin
      select nbs into l_nbs_a
		from nbs_print_bank
	  where nbs = substr(l_nlsa,1,4);
	 exception when no_data_found then null;
	end;

  -- Проверим наличие счета Б в справочнике
    begin
      select nbs into l_nbs_b
		from nbs_print_bank
	  where nbs = substr(l_nlsb,1,4);
	 exception when no_data_found then null;
	end;
  --
     if l_nbs_a is not null and l_mfoa=gl.aMFO then
	  l_id_a:=f_ourokpo;
	  l_nam_a:=substr(f_ourname_g,1,38);
     end if;

     if l_nbs_b is not null and l_mfob=gl.aMFO then
	  l_id_b:=f_ourokpo;
	  l_nam_b:=substr(f_ourname_g,1,38);
     end if;

  if l_vdat > l_data and l_data >= l_datp then
     l_vdat_rate := l_data;
  else
     l_vdat_rate := l_vdat;
  end if;

  if fExtDocuments = 3 then    -- !---arc_rrp---
     if sep.version<>2 then
        l_nam_a := TRANSLATE(l_nam_a, sep.DOS_, sep.WIN_) ;
        l_nam_b := TRANSLATE(l_nam_b, sep.DOS_, sep.WIN_) ;
        l_nazn  := TRANSLATE(l_nazn,  sep.DOS_, sep.WIN_) ;
     end if;
     l_nd := l_nd || ' (#' || to_char(l_ext_ref) || ')' ;
     nOffOkpo := InStr( l_d_rec, '#o' ) ;
     if nOffOkpo > 0 then
        l_id_b := Substr( l_d_rec, nOffOkpo+2, 10 ) ;
        l_id_b := Trim( Substr( l_id_b, 0, Instr( l_id_b, '#' ))) ;
     end if;
  else -- !---oper---d_hist---
     l_nd := l_nd || ' (#' || to_char(nRecID) || ')' ;
  end if;

  begin
     select nb into l_bank_a from Banks where trim(mfo)=l_mfoa ;
  exception when others then
     l_bank_a := '' ;
  end;
  begin
     select nb into l_bank_b from Banks where trim(mfo)=l_mfob ;
  exception when others then
     l_bank_b := '' ;
  end;

  begin
     select rep_prefix, nvl(ovrd4ipmt, 0)
       into szTemplPrefix, nOverride4InfoPMT
       from Vob
      where vob = nVob ;
  exception when others then
     szTemplPrefix := '' ;
     nOverride4InfoPMT := 0 ;
  end;

  -- Коментарим так как должно печататся по VOB из документа
  -- Музика О. по просьбі Сошко Е.
  -- 02/07/2013 11:35
  --! Отлавливаем информационные и переназначаем тикет, если позволено
  -- 10/07/2013 10:00
  --  Знову поправка так як не коректно друкуються ынформ запити
  -- Якщо запит з ARC_RRP і він інформаційний то друкуемо inford
  -- інакше ще перевіряємо по d_rec(OPER)

  if (fExtDocuments = 3 and l_dk >= 2 AND nOverride4InfoPMT = 0) or
     (l_dk >= 2 AND nOverride4InfoPMT = 0  and l_d_rec like '#_$A%')
	then szTemplPrefix := 'inford' ;
  end if;

  begin
     select lcv, unit, dig, prv into szISOCCode, szCUnit, nDig, l_prv
       from tabval where kv = l_kv ;
  exception when others then
     szISOCCode := '' ;
     szCUnit := '' ;
     nDig := 0 ;
     l_prv := 0;
  end;
  begin
     select s3800 into szS3800 from tts where tt=l_tt;
  exception when others then
     szS3800 := '' ;
  end;
  begin
     select nls into szS3801 from accounts
     where acc = ( select acc3801 from VP_LIST
                   where acc3800 = ( select acc from accounts
                                     where nls=szS3800 AND kv=l_kv)) ;
  exception when others then
     szS3801 := '' ;
  end;

  if Trim(Upper(szISOCCode)) = 'UAH' then
     szCcyName := 'грн';
  else
     szCcyName := szISOCCode ;
  end if;

  if fExtDocuments = 1 or fExtDocuments = 2 then  -- !---oper---d_hist---
     begin
        select lcv, unit, dig, prv into szISOCCode2, szCUnit2, nDig2, l_prv2
          from tabval where kv = l_kv2 ;
     exception when others then
        szISOCCode2 := '' ;
        szCUnit2 := '' ;
        nDig2 := 0 ;
        l_prv2 := 0;
     end;
     begin
        select nls into szS3801B from accounts
        where acc = ( select acc3801 from VP_LIST
                      where acc3800 = ( select acc from accounts
                                        where nls=szS3800 AND kv=l_kv2)) ;
     exception when others then
        szS3801B := '' ;
     end;
     if Trim(Upper(szISOCCode2)) = 'UAH' then
        szCcyName2 := 'грн' ;
     else
        szCcyName2 := szISOCCode2 ;
     end if;
  else -- !---arc_rrp---
     l_s2 := l_s ;
     szISOCCode2 := szISOCCode ;
     szCUnit2 := szCUnit ;
     szCcyName2 := szCcyName ;
     nDig2 := nDig ;
     l_prv2 := 0;
  end if;

  -- Символ кассплана
  if nvl(l_sk,0) <> 0 then
     szCashSymb := to_char(l_sk) ;
  end if;

  -- ФИО пользователя
  if nvl(l_user_id,0) <> 0 then
     begin
        select fio into szUserName from staff where id=l_user_id ;
     exception when no_data_found then
        szUserName := '' ;
     end;
  end if;

  l_sqv  := l_sq ;
  l_sqv2 := l_sq2 ;

  if nvl(l_sq,0) = 0 then
     if l_kv <> gl.baseval and nvl(l_kv,0) <> 0 then
        begin
           select gl.p_icurval(l_kv, l_s, l_data),
                  gl.p_icurval(l_kv, l_s, l_vdat_rate)
             into l_sq, l_sqv from dual ;
        exception when no_data_found then
           l_sq  := 0 ;
           l_sqv := 0 ;
        end;
     else
        l_sq  := l_s ;
        l_sqv := l_s ;
     end if;
  end if;

  if nvl(l_sq2,0) = 0 then
     if l_kv2 <> gl.baseval and nvl(l_kv2,0) <> 0 then
        begin
           select gl.p_icurval(l_kv2, l_s2, l_data),
                  gl.p_icurval(l_kv2, l_s2, l_vdat_rate)
            into l_sq2, l_sqv2 from dual ;
        exception when no_data_found then
            l_sq2  := 0 ;
            l_sqv2 := 0 ;
        end;
     else
        l_sq2  := l_s2 ;
        l_sqv2 := l_s2 ;
     end if;
  end if;

  -- для металлов курс не берем
  if l_prv = 0 and l_prv2 = 0 then
     -- ! курс VAL_A к VAL_B
     if l_kv <> l_kv2 and nvl(l_kv,0) <> 0 and nvl(l_kv2,0) <> 0 then
        EXECUTE IMMEDIATE
          'begin ' ||
          'GetXRateTic' ||
          '(:nRatO, :nRatB, :nRatS, :l_kv, :l_kv2, :l_data); ' ||
          'end; '
        USING OUT nRatO, OUT nRatB, OUT nRatS, IN l_kv, IN l_kv2, IN l_data ;

        EXECUTE IMMEDIATE
          'begin ' ||
          'GetXRateTic' ||
          '(:nRatOV, :nRatBV, :nRatSV, :l_kv, :l_kv2, :l_vdat); ' ||
          'end; '
        USING OUT nRatOV, OUT nRatBV, OUT nRatSV, IN l_kv, IN l_kv2, IN l_vdat_rate ;
        nRat1 := l_s2/l_s;
        nRat2 := l_s/l_s2;
     else
        nRatO  := 1;
        nRatB  := 1;
        nRatS  := 1;
        nRatOV := 1;
        nRatBV := 1;
        nRatSV := 1;
        nRat1  := 1;
        nRat2  := 1;
     end if;

     -- ! курс VAL_A к VAL_980
     if l_kv <> gl.baseval and nvl(l_kv,0) <> 0 then
        begin
        EXECUTE IMMEDIATE
          'begin ' ||
          'GetXRateTic' ||
          '(:nRatO980A, :nRatB980A, :nRatS980A, :l_kv, gl.baseval, :l_data); ' ||
          'end; '
        USING OUT nRatO980A, OUT nRatB980A, OUT nRatS980A, IN l_kv, IN l_data ;
        exception when others then
           if sqlcode = -20103 then
              nRatO980A  := 1;
              nRatB980A  := 1;
              nRatS980A  := 1;
           end if;
        end;

        begin
        EXECUTE IMMEDIATE
          'begin ' ||
          'GetXRateTic' ||
          '(:nRatOV980A, :nRatBV980A, :nRatSV980A, :l_kv, gl.baseval, :l_vdat); ' ||
          'end; '
        USING OUT nRatOV980A, OUT nRatBV980A, OUT nRatSV980A, IN l_kv, IN l_vdat_rate ;
        exception when others then
           if sqlcode = -20103 then
              nRatOV980A := 1;
              nRatBV980A := 1;
              nRatSV980A := 1;
           end if;
        end;
     else
        nRatO980A  := 1;
        nRatB980A  := 1;
        nRatS980A  := 1;
        nRatOV980A := 1;
        nRatBV980A := 1;
        nRatSV980A := 1;
     end if;

     -- ! курс VAL_B к VAL_980
     if l_kv2 <> gl.baseval and nvl(l_kv2,0) <> 0 then
        begin
        EXECUTE IMMEDIATE
          'begin ' ||
          'GetXRateTic' ||
          '(:nRatO980B, :nRatB980B, :nRatS980B, :l_kv2, gl.baseval, :l_data); ' ||
          'end; '
        USING OUT nRatO980B, OUT nRatB980B, OUT nRatS980B, IN l_kv2, IN l_data ;
        exception when others then
           if sqlcode = -20103 then
              nRatO980B  := 1;
              nRatB980B  := 1;
              nRatS980B  := 1;
           end if;
        end;

        begin
        EXECUTE IMMEDIATE
          'begin ' ||
          'GetXRateTic' ||
          '(:nRatOV980B, :nRatBV980B, :nRatSV980B, :l_kv2, gl.baseval, :l_vdat); ' ||
          'end; '
        USING OUT nRatOV980B, OUT nRatBV980B, OUT nRatSV980B, IN l_kv2, IN l_vdat_rate ;
        exception when others then
           if sqlcode = -20103 then
              nRatOV980B := 1;
              nRatBV980B := 1;
              nRatSV980B := 1;
           end if;
        end;
     else
        nRatO980B  := 1;
        nRatB980B  := 1;
        nRatS980B  := 1;
        nRatOV980B := 1;
        nRatBV980B := 1;
        nRatSV980B := 1;
     end if;
  else
    nRatO  := 1;
    nRatB  := 1;
    nRatS  := 1;
    nRatOV := 1;
    nRatBV := 1;
    nRatSV := 1;
    nRat1  := 1;
    nRat2  := 1;
    nRatO980A  := 1;
    nRatB980A  := 1;
    nRatS980A  := 1;
    nRatOV980A := 1;
    nRatBV980A := 1;
    nRatSV980A := 1;
    nRatO980B  := 1;
    nRatB980B  := 1;
    nRatS980B  := 1;
    nRatOV980B := 1;
    nRatBV980B := 1;
    nRatSV980B := 1;
  end if;

  if szTemplPrefix = '' or szTemplPrefix is null then
     szTemplPrefix := 'memord' ;
  end if;
  if nVob = 96 then
     if l_kv = l_kv2 and l_kv <> gl.baseval then
        szTemplPrefix := 'memzm1' ;
     elsif l_kv <> l_kv2 then
        szTemplPrefix := 'memzm2' ;
     end if;
  end if;

  begin
     select b.nls, b.nms into l_nlsa_a, l_nmsa_a
       from accounts a, accounts b
      where b.acc = a.accc and a.nls = l_nlsa and a.kv = l_kv
        and substr(b.nls,1,1) <> '8' ;
  exception when no_data_found then
     l_nlsa_a := '' ;
     l_nmsa_a := '' ;
  end;
  if l_nlsa_a is null then
     l_nlsa_a := l_nlsa ;
  end if;
  if l_nmsa_a is null then
     l_nmsa_a := l_nam_a ;
  end if;

  begin
     select b.nls, b.nms into l_nlsb_a, l_nmsb_a
       from accounts a, accounts b
      where b.acc = a.accc and a.nls = l_nlsb and a.kv = l_kv2
        and substr(b.nls,1,1) <> '8' ;
  exception when no_data_found then
     l_nlsb_a := '' ;
     l_nmsb_a := '' ;
  end;
  if l_nlsb_a is null then
     l_nlsb_a := l_nlsb ;
  end if;
  if l_nmsb_a is null then
     l_nmsb_a := l_nam_b ;
  end if;

  -- ! Ручная домазка для сложных документов
  -- ! все уйдет, когда переделаю функцию печати документов. (ABYSS)
  szTemplPrefix := Upper( szTemplPrefix ) ;

  -- ! Тикет на выдачу валюты с выкупанием центов -----------------------------
  if szTemplPrefix = 'CCYSXC' then
     begin
        select o.s into l_sq from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND a.nls=szS3801 ;
     exception when no_data_found then
        l_sq := 0 ;
     end;
     begin
        select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nFSummPcnt
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE 'A0_'
           and o.dk=0 AND kv=980 ;
     exception when no_data_found then
        szPFUNlsA  := '' ;
        szPFUNmsA  := '' ;
        nFSummPcnt := 0 ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OSumm1p~OSumm1pLit~' ;
     lszVals := szPFUNlsA  || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        trim(to_charD(nFSummPcnt/100, '99999999999990D99'))  || '~' ||
        F_SumPr(nFSummPcnt, 980,'F') || '~' ;
     begin
        select o.s into nFSummPcnt from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE 'A0_' AND kv<>980 ;
     exception when no_data_found then
        nFSummPcnt := 0 ;
     end;
     lszVars := lszVars || '~OSumm1p~OSumm1pLit~' ;
     lszVals := lszVars ||
        Trim( to_charD( nFSummPcnt/ Power(10,nDig), '99999999999990D'||rpad('9',nDig,'9'))) || '~' ||
        F_SumPr(nFSummPcnt, szISOCCode, 'F') || '~' ;
     begin
        select a.nls, a.nms, o.s into szSubTrnNls, szSubTrnNms, nSubTrnSum
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE 'A0_'
           and o.dk=1 AND kv=980 ;
     exception when no_data_found then
        szSubTrnNls := '' ;
        szSubTrnNms := '' ;
        nSubTrnSum  := 0 ;
     end;
     lszVars := lszVars || '~OPFU-B~OPFUN-B~OFSummB~OFSummBLit~' ;
     lszVals := lszVals || szSubTrnNls || '~' ||
        Replace( szSubTrnNms, '~', '`' ) || '~' ||
        Trim( to_charD( nSubTrnSum/100, '99999999999990D99')) || '~' ||
        F_SumPr(nSubTrnSum, 980, 'F') || '~' ;
     lszVars := lszVars || '~OPFU-C~OPFUN-C~OFSummC~OFSummCLit~' ;
     lszVals := lszVals || szSubTrnNls || '~' ||
        Replace( szSubTrnNms, '~', '`' ) || '~' ||
        Trim( to_charD( nSubTrnSum/100, '99999999999990D99')) || '~' ||
        F_SumPr(nSubTrnSum, 980, 'F') || '~' ;

  -- ! Тикет на видачу ВАЛЮТА с округлением (СБ) ------------------------------
  elsif szTemplPrefix = 'CCYKSX' then
    l_s := l_s - mod(l_s,100) ;
    begin
       select gl.p_icurval(l_kv, l_s, l_data) into l_sq from dual ;
    exception when no_data_found then
       l_sq := 0 ;
    end;
    begin
       select a.nls, a.nms, o.s into szRndNlsB, szRndNmsB, nRndSum2
         from opldok o, accounts a
        where a.acc=o.acc AND o.ref=nRecID AND o.dk=1
          and a.kv=980 AND a.tip='KAS' ;
    exception when no_data_found then
       szRndNlsB := '' ;
       szRndNmsB := '' ;
       nRndSum2  := 0  ;
    end;
    begin
       select a.nls, a.nms, o.s into szPFUNlsB, szPFUNmsB, nRndSum1
         from opldok o, accounts a
        where a.acc=o.acc AND o.ref=nRecID
          and o.dk=1 AND a.kv<>980 AND o.s<100 ;
    exception when no_data_found then
       szPFUNlsB := '' ;
       szPFUNmsB := '' ;
       nRndSum1  := 0  ;
    end;
    szRndNlsA := l_nlsa ;
    szRndNmsA := l_nam_a ;
    nRndCcy1  := l_kv ;
    szRndCcy1 := szISOCCode ;
    nRndCcy2  := 980 ;
    szRndCcy2 := 'UAH' ;
    szRndSumPr  := F_SumPr( nRndSum1, l_kv,  'F' ) ;
    szRndSumPr2 := F_SumPr( nRndSum2, 980, 'F' ) ;

    lszVars := 'ORndNLS-A~ORndNMS-A~ORndNLS-B~ORndNMS-B~ORndCcy-A~ORndCcy-B~' ||
       'ORndCcyISO-A~ORndCcyISO-B~ORndSum1~ORndSum2~ORndSumLit~ORndSumLit2~' ||
       'OPFU-A~OPFUN-A~OPFU-B~OPFUN-B~' ;
    lszVals := szRndNlsA || '~' ||
       Replace( szRndNmsA, '~', '`' ) || '~' ||
       szRndNlsB || '~' ||
       Replace( szRndNmsB, '~', '`' ) || '~' ||
       to_char( nRndCcy1 ) || '~' ||
       to_char( nRndCcy2 ) || '~' ||
       szRndCcy1 || '~' ||
       szRndCcy2 || '~' ||
       Trim( to_charD( nRndSum1/Power(10,nDig), '9999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
       Trim( to_charD( nRndSum2/100, '99999999999990D99' )) || '~' ||
       szRndSumPr  || '~' ||
       szRndSumPr2 || '~' ||
       szPFUNlsA   || '~' ||
       Replace( szPFUNmsA, '~', '`' ) || '~' ||
       szPFUNlsB   || '~' ||
       Replace( szPFUNmsB, '~', '`' ) || '~' ;

  -- ! Тикет на видачу ВАЛЮТА с округлением -----------------------------------
  elsif szTemplPrefix = 'CCYKSR' then
     nRndMod := Mod( l_s, 100 ) ;
     l_s := Round( l_s / 100 )*100 ;
     begin
        select gl.p_icurval(l_kv, l_s, l_data) into l_sq from dual ;
     exception when no_data_found then
        l_sq := 0 ;
     end;
     if nRndMod < 50 then    -- ! Округление в меньшую сторону.
        begin
           select a.nls, a.nms, o.s, b.nls, b.nms
             into szRndNlsB, szRndNmsB, nRndSum2, szRndNlsBa, szRndNmsBa
             from opldok o, accounts a, accounts b
            where a.acc=o.acc AND o.ref=nRecID AND o.dk=1 AND a.kv=980
              and b.acc(+)=a.accc ;
        exception when no_data_found then
           szRndNlsB  := '' ;
           szRndNmsB  := '' ;
           nRndSum2   := 0  ;
           szRndNlsBa := '' ;
           szRndNmsBa := '' ;
        end;
        if szRndNlsBa = '' then
           szRndNlsBa := szRndNlsB ;
        end if;
        if szRndNmsBa = '' then
           szRndNmsBa := szRndNmsB ;
        end if;
        begin
           select a.nls, a.nms, o.s, b.nls, b.nms
             into szPFUNlsB, szPFUNmsB, nRndSum1, szPFUNlsBa, szPFUNmsBa
             from opldok o, accounts a, accounts b
            where a.acc=o.acc AND o.ref=nRecID AND o.dk=1 AND a.kv<>980
              and o.s<100 AND b.acc(+)=a.accc ;
        exception when no_data_found then
           szPFUNlsB  := '' ;
           szPFUNmsB  := '' ;
           nRndSum1   := 0  ;
           szPFUNlsBa := '' ;
           szPFUNmsBa := '' ;
        end;
        if szPFUNlsBa = '' then
           szPFUNlsBa := szPFUNlsB ;
        end if;
        if szPFUNmsBa = '' then
           szPFUNmsBa := szPFUNmsB ;
        end if;
        szRndNlsA := l_nlsa ;
        szRndNmsA := l_nam_a ;
        nRndCcy1  := l_kv ;
        szRndCcy1 := szISOCCode ;
        nRndCcy2  := 980 ;
        szRndCcy2 := 'UAH' ;
        szRndSumPr  := F_SumPr( nRndSum1, l_kv, 'F' ) ;
        szRndSumPr2 := F_SumPr( nRndSum2, 980,  'F' ) ;
     else
        begin
           select a.nls, a.nms, o.s, b.nls, b.nms
             into szRndNlsA, szRndNmsA, nRndSum1, szRndNlsAa, szRndNmsAa
             from opldok o, accounts a, accounts b
            where a.acc=o.acc AND o.ref=nRecID AND o.dk=0 AND a.kv=980
              and b.acc(+)=a.accc ;
        exception when no_data_found then
           szRndNlsA  := '' ;
           szRndNmsA  := '' ;
           nRndSum1   := 0  ;
           szRndNlsAa := '' ;
           szRndNmsAa := '' ;
        end;
        if szRndNlsAa = '' then
           szRndNlsAa := szRndNlsA ;
        end if;
        if szRndNmsAa = '' then
           szRndNmsAa := szRndNmsA ;
        end if;
        begin
           select a.nls, a.nms, o.s, b.nls, b.nms
             into szPFUNlsA, szPFUNmsA, nRndSum2, szPFUNlsAa, szPFUNmsAa
             from opldok o, accounts a, accounts b
            where a.acc=o.acc AND o.ref=nRecID AND o.dk=0 AND a.kv<>980
              and o.s<100 AND b.acc(+)=a.accc ;
        exception when no_data_found then
           szPFUNlsA  := '' ;
           szPFUNmsA  := '' ;
           nRndSum2   := 0  ;
           szPFUNlsAa := '' ;
           szPFUNmsAa := '' ;
        end;
        if szPFUNlsAa = '' then
           szPFUNlsAa := szPFUNlsA ;
        end if;
        if szPFUNmsAa = '' then
           szPFUNmsAa := szPFUNmsA ;
        end if;
        szRndNlsB := l_nlsa ;
        szRndNmsB := l_nam_a ;
        nRndCcy2  := l_kv ;
        szRndCcy2 := szISOCCode ;
        nRndCcy1  := 980 ;
        szRndCcy1 := 'UAH' ;
        szRndSumPr  := F_SumPr( nRndSum1, 980,  'F' ) ;
        szRndSumPr2 := F_SumPr( nRndSum2, l_kv, 'F' ) ;
     end if;
     lszVars := 'ORndNLS-A~ORndNMS-A~ORndNLS-B~ORndNMS-B~ORndCcy-A~ORndCcy-B~' ||
        'ORndCcyISO-A~ORndCcyISO-B~ORndSum1~ORndSum2~ORndSumLit~ORndSumLit2~' ||
        'OPFU-A~OPFUN-A~OPFU-B~OPFUN-B~' ||
        'ORndNLS-Aa~ORndNMS-Aa~OPFU-Aa~OPFUN-Aa~' ||
        'ORndNLS-Ba~ORndNMS-Ba~OPFU-Ba~OPFUN-Ba~' ;
     lszVals := szRndNlsA || '~' ||
        Replace( szRndNmsA, '~', '`' ) || '~' ||
        szRndNlsB || '~' ||
        Replace( szRndNmsB, '~', '`' ) || '~' ||
        to_char( nRndCcy1 ) || '~' ||
        to_char( nRndCcy2 ) || '~' ||
        szRndCcy1 || '~' ||
        szRndCcy2 || '~' ||
        Trim( to_charD( nRndSum1/Power(10,nDig),  '99999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        Trim( to_charD( nRndSum2/Power(10,nDig2), '99999999999990D'||rpad('9',nDig2,'9') )) || '~' ||
        szRndSumPr  || '~' ||
        szRndSumPr2 || '~' ||
        szPFUNlsA   || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        szPFUNlsB   || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        szRndNlsAa  || '~' ||
        Replace( szRndNmsAa, '~', '`' ) || '~' ||
        szPFUNlsAa  || '~' ||
        Replace( szPFUNmsAa, '~', '`' ) || '~' ||
        szRndNlsBa  || '~' ||
        Replace( szRndNmsBa, '~', '`' ) || '~' ||
        szPFUNlsBa  || '~' ||
        Replace( szPFUNmsBa, '~', '`' ) || '~' ;

  -- ! Тикет на видачу ВАЛЮТА с округлением. for Inna -------------------------
  elsif szTemplPrefix = 'CCYKSI' then
     l_s := l_s - Mod( l_s, 100 ) ;
     begin
        select gl.p_icurval(l_kv, l_s, l_data) into l_sq from dual ;
     exception when no_data_found then
        l_sq := 0 ;
     end;
     begin
        select a.nls, a.nms, o.s into szRndNlsB, szRndNmsB, nRndSum2
          from opldok o, accounts a
         where a.acc=o.acc and o.ref=nRecID and o.dk=1 and a.kv=980
           and a.nls not like '8%' ;
     exception when no_data_found then
        szRndNlsB := '' ;
        szRndNmsB := '' ;
        nRndSum2  := 0  ;
     end;
     begin
        select a.nls, a.nms, o.s into szPFUNlsB, szPFUNmsB, nRndSum1
          from opldok o, accounts a
         where a.acc=o.acc and o.ref=nRecID and o.dk=1 and a.kv<>980
           and o.s<100
           and a.nls not like '8%'  ;
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
        nRndSum1  := 0  ;
     end;
     szRndNlsA := l_nlsa ;
     szRndNmsA := l_nam_a ;
     nRndCcy1  := l_kv ;
     szRndCcy1 := szISOCCode ;
     nRndCcy2  := 980 ;
     szRndCcy2 := 'UAH' ;
     szRndSumPr  := F_SumPr( nRndSum1, l_kv, 'F' ) ;
     szRndSumPr2 := F_SumPr( nRndSum2, 980,  'F' ) ;
     lszVars := 'ORndNLS-A~ORndNMS-A~ORndNLS-B~ORndNMS-B~ORndCcy-A~ORndCcy-B~' ||
        'ORndCcyISO-A~ORndCcyISO-B~ORndSum1~ORndSum2~ORndSumLit~ORndSumLit2~' ||
        'OPFU-A~OPFUN-A~OPFU-B~OPFUN-B~' ;
     lszVals := szRndNlsA || '~' ||
        Replace( szRndNmsA, '~', '`' ) || '~' ||
        szRndNlsB || '~' ||
        Replace( szRndNmsB, '~', '`' ) || '~' ||
        to_char( nRndCcy1 ) || '~' ||
        to_char( nRndCcy2 ) || '~' ||
        szRndCcy1 || '~' ||
        szRndCcy2 || '~' ||
        Trim( to_charD( nRndSum1/Power(10,nDig),  '99999999999990D'||rpad('9',nDig,'9') ))  || '~' ||
        Trim( to_charD( nRndSum2/Power(10,nDig2), '99999999999990D'||rpad('9',nDig2,'9') )) || '~' ||
        szRndSumPr  || '~' ||
        szRndSumPr2 || '~' ||
        szPFUNlsA   || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        szPFUNlsB   || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ;
     begin
        select a1.nls, a1.nms, o1.s, a2.nls, a2.nms
          into szComisNls, szComisNms, nSummComis, szPFUNlsC, szPFUNmsC
          from opldok o1, opldok o2, accounts a1, accounts a2
         where a1.acc=o1.acc and o1.ref=nRecID and a1.nls like '7%'
           and a2.acc=o2.acc and o2.ref=o1.ref and o2.dk<>o1.dk AND o2.tt=o1.tt ;
     exception when no_data_found then
        szComisNls := '' ;
        szComisNms := '' ;
        nSummComis := 0  ;
        szPFUNlsC  := '' ;
        szPFUNmsC  := '' ;
     end;
     lszVars := lszVars || 'OPFU-Comis~OPFUN-Comis~OSummComis~OSummComisLit~OPFU-C~OPFUN-C' ;
     lszVals := lszVals ||
        szComisNls || '~' ||
        Replace( szComisNms, '~', '`' ) || '~' ||
        Trim( to_charD( nSummComis/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nSummComis, 980, 'F' ) || '~' ||
        szPFUNlsC  || '~' ||
        Replace( szPFUNmsC, '~', '`' ) ;

  -- ! Тикет на видачу ВАЛЮТА . for Inna --------------------------------------
  elsif szTemplPrefix = 'CCYKSV' OR
        szTemplPrefix = 'CCYKSW' then
     begin
        select a.nls, a.nms, o.s, gl.p_icurval(l_kv, o.s, l_data), b.nls, b.nms
          into szPFUNlsA, szPFUNmsA, nFSummPcnt, nFSummPcnt2, szPFUNlsAa, szPFUNmsAa
          from opldok o, accounts a, accounts b
         where a.acc=o.acc AND o.ref=nRecID AND o.tt<>l_tt AND a.kv=l_kv
           AND o.dk=1 AND b.acc(+)=a.accc
           AND a.nls not like '8%' AND a.nls<>l_nlsb
            -- для сложной бухмодели, при печати тикета которой не используются эти переменные, но запрос выполняется
           and rownum = 1;
     exception when no_data_found then
        szPFUNlsA   := '' ;
        szPFUNmsA   := '' ;
        nFSummPcnt  := 0  ;
        nFSummPcnt2 := 0  ;
        szPFUNlsAa  := '' ;
        szPFUNmsAa  := '' ;
     end;
     if szPFUNlsAa = '' then
        szPFUNlsAa := szPFUNlsA ;
     end if;
     if szPFUNmsAa = '' then
        szPFUNmsAa := szPFUNmsA ;
     end if;
     begin
        select a.nls, a.nms, o2.s, b.nls, b.nms
          into szPFUNlsD, szPFUNmsD, nFSummD, szPFUNlsDa, szPFUNmsDa
          from opldok o, accounts a , opldok o2, accounts a2, accounts b
         where a.acc=o.acc AND o.ref=nRecID AND o.tt<>l_tt AND a.kv<>l_kv
           and o.dk=0 AND o.ref=o2.ref AND o.stmt=o2.stmt AND o2.acc=a2.acc
           and a.nls<>l_nlsb AND a2.nls=l_nlsb AND o2.dk<>o.dk
           and a.nls like '3%' AND b.acc(+)=a.accc ;
     exception when no_data_found then
        szPFUNlsD  := '' ;
        szPFUNmsD  := '' ;
        nFSummD    := 0  ;
        szPFUNlsDa := '' ;
        szPFUNmsDa := '' ;
     end;
     if szPFUNlsDa = '' then
        szPFUNlsDa := szPFUNlsD ;
     end if;
     if szPFUNmsDa = '' then
        szPFUNmsDa := szPFUNmsD ;
     end if;
     begin
        select decode(o2.dk,0,a2.nls,a.nls), decode(o2.dk,0,a2.nms,a.nms), o2.s,
               decode(o2.dk,0,a.nls,a2.nls), decode(o2.dk,0,a.nms,a2.nms),
               decode(o2.dk,0,b2.nls,b.nls), decode(o2.dk,0,b2.nms,b.nms),
               decode(o2.dk,0,b.nls,b2.nls), decode(o2.dk,0,b.nms,b2.nms)
          into szPFUNlsB, szPFUNmsB, nFSummB, szPFUNlsC, szPFUNmsC,
               szPFUNlsBa, szPFUNmsBa,  szPFUNlsCa, szPFUNmsCa
          from opldok o, accounts a , opldok o2, accounts a2, accounts b, accounts b2
         where a.acc=o.acc AND o.ref=nRecID AND o.tt<>l_tt AND a.kv<>l_kv
           and o.ref=o2.ref AND o.stmt=o2.stmt AND o2.acc=a2.acc
           and a.nls like '3%' AND a2.nls like '6%'
           and b.acc(+)=a.accc AND b2.acc(+)=a2.accc ;
     exception when no_data_found then
        szPFUNlsB  := '' ;
        szPFUNmsB  := '' ;
        nFSummB    := 0  ;
        szPFUNlsC  := '' ;
        szPFUNmsC  := '' ;
        szPFUNlsBa := '' ;
        szPFUNmsBa := '' ;
        szPFUNlsCa := '' ;
        szPFUNmsCa := '' ;
     end;
     if szPFUNlsBa is null then
        szPFUNlsBa := szPFUNlsB ;
     end if;
     if szPFUNmsBa is null then
        szPFUNmsBa := szPFUNmsB ;
     end if;
     if szPFUNlsCa is null then
        szPFUNlsCa := szPFUNlsC ;
     end if;
     if szPFUNmsCa is null then
        szPFUNmsCa := szPFUNmsC ;
     end if;
     lszVars := 'OPFU-A~OPFUN-A~OSummDo~OSummDoLit~OSummDo2~OSummDoLit2~' ||
        'ORndNLS-D~ORndNMS-D~ORndSumD~ORndSumLitD~' ||
        'ORndNLS-A~ORndNMS-A~ORndSum1~ORndSumLit~ORndNLS-B~ORndNMS-B~' ||
        'OPFU-Aa~OPFUN-Aa~ORndNLS-Da~ORndNMS-Da~ORndNLS-Aa~ORndNMS-Aa~ORndNLS-Ba~ORndNMS-Ba~' ;
     lszVals := szPFUNlsA || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummPcnt/Power(10,nDig), '9999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nFSummPcnt, l_kv, 'F' ) || '~' ||
        Trim( to_charD( nFSummPcnt2/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nFSummPcnt2, 980, 'F' ) || '~' ||
        szPFUNlsD  || '~' ||
        Replace( szPFUNmsD, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummD/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nFSummD, 980, 'F' ) || '~' ||
        szPFUNlsB  || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummB/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nFSummB, 980, 'F' ) || '~' ||
        szPFUNlsC  || '~' ||
        Replace( szPFUNmsC, '~', '`' ) || '~' ||
        szPFUNlsAa || '~' ||
        Replace( szPFUNmsAa, '~', '`' )|| '~' ||
        szPFUNlsDa || '~' ||
        Replace( szPFUNmsDa, '~', '`' )|| '~' ||
        szPFUNlsBa || '~' ||
        Replace( szPFUNmsBa, '~', '`' )|| '~' ||
        szPFUNlsCa || '~' ||
        Replace( szPFUNmsCa, '~', '`' )|| '~' ;

  -- ! Тикет на замену валюты с комиссией -------------------------------------
  elsif szTemplPrefix = 'CCYKS3' OR
        szTemplPrefix = 'CCYKSF' then
     begin
        select a.nls, a.nms, o.s into szPFUNlsB, szPFUNmsB, nSummComis
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt AND o.dk=1 AND kv=980 ;
     exception when no_data_found then
        szPFUNlsB  := '' ;
        szPFUNmsB  := '' ;
        nSummComis := 0  ;
     end;
     lszVars := 'OPFU-B~OPFUN-B~OSummComis~OSummComisLit~' ;
     lszVals :=
        szPFUNlsB  || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nSummComis/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nSummComis, 980, 'F') || '~' ;

  -- ! Тикет валютной операции с ПФ (АЖИО) ------------------------------------
  elsif szTemplPrefix = 'CCYKS1' then
    begin
       select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nFSummPcnt
         from opldok o, accounts a
        where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE 'A0_' AND o.dk=0 ;
    exception when no_data_found then
       szPFUNlsA  := '' ;
       szPFUNmsA  := '' ;
       nFSummPcnt := 0  ;
    end;
    begin
       select a.nls, a.nms into szPFUNlsB, szPFUNmsB
         from opldok o, accounts a
        where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE 'A0_' AND o.dk=1 ;
    exception when no_data_found then
       szPFUNlsB := '' ;
       szPFUNmsB := '' ;
    end;
    lszVars := 'OPFU-A~OPFUN-A~OPFU-B~OPFUN-B~OSumm1p~OSumm1pLit~' ;
    lszVals := szPFUNlsA || '~' ||
       Replace( szPFUNmsA, '~', '`' ) || '~' ||
       szPFUNlsB  || '~' ||
       Replace( szPFUNmsB, '~', '`' ) || '~' ||
       Trim( to_charD( nFSummPcnt/100, '99999999999990D99' )) || '~' ||
       F_SumPr( nFSummPcnt, 980, 'F' ) || '~' ;

  -- ! Тикет на конверсию ВАЛЮТА-ВАЛЮТА. --------------------------------------
  elsif szTemplPrefix = 'CCYCCY' then
     begin
        select a.nls, a.nms, o.s into szPFUNlsB, szPFUNmsB, nSummComis
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt not in (l_tt,'SPM')
           AND o.dk=1      AND kv=l_kv2 ;
     exception when no_data_found then
        szPFUNlsB  := '' ;
        szPFUNmsB  := '' ;
        nSummComis := 0  ;
     end;
     lszVars := 'OPFU-B~OPFUN-B~OSummComis~OSummComisLit~' ;
     lszVals :=  szPFUNlsB || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nSummComis/Power(10,nDig2), '9999999999999990D'||rpad('9',nDig2,'9') )) || '~' ||
        F_SumPr( nSummComis, l_kv2, 'F' ) || '~' ;
     begin
        select gl.p_icurval(l_kv2, nSummComis, l_data) into nFSummB from dual ;
     exception when no_data_found then
        nFSummB := 0 ;
     end;
     lszVars := lszVars || 'OFSummComis~' ;
     lszVals := lszVals || Trim( to_charD( nFSummB/100, '99999999999990D99' )) || '~' ;
     begin
        select a.nls, a.nms, o.s into szPFUNlsC, szPFUNmsC, nFSummC
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt not in (l_tt,'SPM')
           AND o.dk=1      AND  kv=gl.baseval ;
     exception when no_data_found then
        szPFUNlsC := '' ;
        szPFUNmsC := '' ;
        nFSummC   := 0  ;
     end;
     lszVars := 'OPFU-C~OPFUN-C~OSummComisC~OSummComisCLit~' ;
     lszVals := szPFUNlsC || '~' ||
        Replace( szPFUNmsC, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummC/Power(10,nDig2), '9999999999999990D'||rpad('9',nDig2,'9') )) || '~' ||
        F_SumPr( nFSummC, 980, 'F' ) || '~'  ;

  -- ! Тикет на конверсию ФЛ ВАЛЮТА-ВАЛЮТА (АЖИО). ----------------------------
  elsif szTemplPrefix = 'MUL119' then
     begin
        select o.s into nFSummB from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt='K20' AND o.dk=0 AND kv=l_kv ;
     exception when no_data_found then
        nFSummB := 0 ;
     end;
     lszVars := 'OFSummB~OFSummBLit~' ;
     lszVals :=
        Trim( to_charD( nFSummB/Power(10,nDig), '9999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nFSummB, l_kv, 'F' ) || '~' ;
     begin
        select o.s into nFSummC from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt='K20' AND o.dk=0 AND kv=l_kv2 ;
     exception when no_data_found then
        nFSummC := 0 ;
     end;
     lszVars := lszVars || 'OFSummC~OFSummCLit~' ;
     lszVals := lszVals ||
        Trim( to_charD( nFSummC/Power(10,nDig2), '9999999999999990D'||rpad('9',nDig2,'9') )) || '~' ||
        F_SumPr( nFSummC, l_kv, 'F' ) || '~' ;
     begin
        select o.s into nRndSum1 from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt='K19' AND o.dk=0 AND kv=l_kv ;
     exception when no_data_found then
        nRndSum1 := 0 ;
     end;
     lszVars := lszVars || 'ORndSum1~ORndSumLit~' ;
     lszVals := lszVals ||
        Trim( to_charD( nRndSum1/Power(10,nDig), '9999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nRndSum1, l_kv, 'F' ) || '~' ;
     begin
        select o.s into nRndSum2 from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt='K19' AND o.dk=0 AND kv=980 ;
     exception when no_data_found then
        nRndSum2 := 0 ;
     end;
     lszVars := lszVars || 'ORndSum2~ORndSumLit2~' ;
     lszVals := lszVals ||
        Trim( to_charD( nRndSum2/100, '99999999999990D99' ))   || '~' ||
        F_SumPr( nRndSum2, 980, 'F' ) || '~' ;

  -- ! Тикет на выдачу валютного перевода с комиссией -------------------------
  elsif szTemplPrefix = 'CCYXFR' then
     begin
        select o.s into nSummComis from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt AND o.dk=1 AND kv=l_kv
           and o.tt <> 'PO3';
     exception when no_data_found then
        nSummComis := 0 ;
     end;
     lszVars := 'OSummComis~OSummComisLit~' ;
     lszVals :=
        Trim( to_charD( nSummComis/Power(10,nDig), '9999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nSummComis, l_kv, 'F' ) || '~' ;
     begin
        select a.nls, a.nms, o.s into szPFUNlsB, szPFUNmsB, nSummComis
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt AND o.dk=1 AND kv=980 ;
     exception when no_data_found then
        szPFUNlsB  := '' ;
        szPFUNmsB  := '' ;
        nSummComis := 0  ;
     end;
     lszVars := lszVars || 'OPFU-B~OPFUN-B~OFSummComis~OFSummComisLit~' ;
     lszVals := lszVals ||
        szPFUNlsB  || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nSummComis/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nSummComis, 980, 'F' ) || '~' ;

  -- ! Тикет на конверсию валюты - этап 1. (АЖИО) -----------------------------
  elsif szTemplPrefix = 'CCYCN1' then
     begin
        select o.s into nRndSum1 from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.dk=0 AND o.tt='FFC' and a.kv=l_kv ;
     exception when no_data_found then
        nRndSum1 := 0 ;
     end;
     begin
        select o.s into nRndSum2
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.dk=0 AND o.tt='FFC' and a.kv=l_kv2 ;
     exception when no_data_found then
        nRndSum2 := 0 ;
     end;
     lszVars := 'ORndSum1~ORndSum2~ORndSumLit~ORndSumLit2~' ;
     lszVals :=
        Trim( to_charD( nRndSum1/Power(10,nDig),  '9999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        Trim( to_charD( nRndSum2/Power(10,nDig2), '9999999999999990D'||rpad('9',nDig2,'9') )) || '~' ||
        F_SumPr( nRndSum1, l_kv,  'F' ) || '~' ||
        F_SumPr( nRndSum1, l_kv2, 'F' ) || '~' ;

  -- ! Тикет на конверсию валюты - этап 2. (АЖИО) -----------------------------
  elsif szTemplPrefix = 'CCYCN2' OR
        szTemplPrefix = 'CCYCN3' then
     begin
        select o.s, o.sq into nRndSum1, nFRndSum1
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.dk=0
           and (o.tt='FFA' OR o.tt='FFB') and a.kv=l_kv ;
     exception when no_data_found then
        nRndSum1  := 0 ;
        nFRndSum1 := 0 ;
     end;
     begin
        select o.s into nRndSum2 from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND (o.tt='FFG' OR o.tt='FFF')
           and o.dk=0 AND a.kv=l_kv ;
     exception when no_data_found then
        nRndSum2 := 0 ;
     end;
     begin
        select o.s into nSummComis from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND (o.tt='FFG' OR o.tt='FFF')
           and o.dk=1 AND a.kv=980 AND a.tip='KAS' ;
     exception when no_data_found then
        nSummComis := 0 ;
     end;
     begin
        select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nFSummPcnt
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND (o.tt = 'KFE' OR o.tt = 'KFP') AND o.dk=0 ;
     exception when no_data_found then
        szPFUNlsA  := '' ;
        szPFUNmsA  := '' ;
        nFSummPcnt := 0  ;
     end;
     begin
        select a.nls, a.nms into szPFUNlsB, szPFUNmsB
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND (o.tt = 'KFE' OR o.tt = 'KFP') AND o.dk=1 ;
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
     end;
     lszVars := 'ORndSum1~ORndSumLit~OFRndSum1~OFRndSumLit~ORndSum2~ORndSumLit2~OSummComis~OSummComisLit~OPFU-A~OPFUN-A~OPFU-B~OPFUN-B~OSumm1p~OSumm1pLit~' ;
     lszVals :=
        Trim( to_charD( nFRndSum1/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nFRndSum1, 980, 'F' ) || '~' ||
        Trim( to_charD( nRndSum1/Power(10,nDig), '9999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nRndSum1, l_kv, 'F' ) || '~' ||
        Trim( to_charD( nRndSum2/Power(10,nDig), '9999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nRndSum2, l_kv, 'F' ) || '~' ||
        Trim( to_charD( nSummComis/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nSummComis, 980, 'F' ) || '~' ||
        szPFUNlsA  || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        szPFUNlsB  || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummPcnt/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nFSummPcnt, 980, 'F' ) || '~' ;

  -- ! Тикет на видачу подотчета ВАЛЮТА. --------------------------------------
  elsif szTemplPrefix = 'ZV_OUT' then
    begin
       select a.nls into szPFUNlsB from opldok o, accounts a
        where a.acc=o.acc AND o.ref=nRecID AND o.tt = 'A16' AND o.dk=1 ;
    exception when no_data_found then
       szPFUNlsB := '' ;
    end;
    lszVars := 'OPFU-B~' ;
    lszVals := szPFUNlsB || '~'  ;

  -- ! Тикет на возврат подотчета ВАЛЮТА. -------------------------------------
  elsif szTemplPrefix = 'ZV_IN' then
     begin
        select a.nls into szPFUNlsA from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt = 'A17' AND o.dk=0 ;
     exception when no_data_found then
        szPFUNlsA := '' ;
     end;
     lszVars := 'OPFU-A~' ;
     lszVals := szPFUNlsA || '~' ;

  -- ! Тикет на видачу подотчета ГРИВНА. --------------------------------------
  elsif szTemplPrefix = 'ZVHOUT' then
     begin
        select a.nls, a.nms into szPFUNlsB, szPFUNmsB
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt = 'A18' AND o.dk=1 ;
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
     end;
     begin
        select sk into szCashSComis from tts where tt='A18' ;
     exception when no_data_found then
        szCashSComis := '' ;
     end;
     lszVars := 'OPFU-B~OPFUN-B~OCashSymbComis~' ;
     lszVals := szPFUNlsB    || '~' ||
        Replace( szPFUNmsB, '~', '`' )    || '~' ||
        szCashSComis || '~' ;

  -- ! Тикет на возврат подотчета ГРИВНА. -------------------------------------
  elsif szTemplPrefix = 'ZVHIN' then
     begin
        select a.nls, a.nms into szPFUNlsA, szPFUNmsA
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt = 'A19' AND o.dk=0 ;
     exception when no_data_found then
        szPFUNlsA := '' ;
        szPFUNmsA := '' ;
     end;
     begin
        select sk into szCashSComis from tts where tt='A19' ;
     exception when no_data_found then
        szCashSComis := '' ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OCashSymbComis~' ;
     lszVals := szPFUNlsA    || '~' ||
        Replace( szPFUNmsA, '~', '`' )    || '~' ||
        szCashSComis || '~' ;

  -- ! Тикет на инкассацию банкомата ГРИВНА. ----------------------------------
  elsif szTemplPrefix = 'ATBOUT' then
     begin
        select a.nls, a.nms into szPFUNlsB, szPFUNmsB
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt = '088' AND o.dk=0 ;
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
     end;
     begin
        select sk into szCashSComis from tts where tt='088' ;
     exception when no_data_found then
        szCashSComis := '' ;
     end;
     lszVars := 'OPFU-B~OPFUN-B~OCashSymbComis~' ;
     lszVals := szPFUNlsB    || '~' ||
        Replace( szPFUNmsB, '~', '`' )    || '~' ||
        szCashSComis || '~' ;

  -- ! Тикет на поплнение банкомата ГРИВНА. -----------------------------------
  elsif szTemplPrefix = 'ATBIN' then
     begin
        select a.nls, a.nms into szPFUNlsA, szPFUNmsA
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt = '087' AND o.dk=1 ;
     exception when no_data_found then
        szPFUNlsA := '' ;
        szPFUNmsA := '' ;
     end;
     begin
        select sk into szCashSComis from tts where tt='087' ;
     exception when no_data_found then
        szCashSComis := 0 ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OCashSymbComis~' ;
     lszVals := szPFUNlsA || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        szCashSComis || '~' ;

  -- ! Тикет на видачу подотчета ЧЕКИ. ----------------------------------------
  elsif szTemplPrefix = 'ZVCOUT' then
     begin
        select a.nls into szPFUNlsB from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt = 'C27' AND o.dk=1 ;
     exception when no_data_found then
        szPFUNlsB := '' ;
     end;
     lszVars := 'OPFU-B~' ;
     lszVals := szPFUNlsB || '~' ;

  -- ! Тикет на возврат подотчета ЧЕКИ. ---------------------------------------
  elsif szTemplPrefix = 'ZVC_IN' then
     begin
        select a.nls into szPFUNlsA from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt = 'C27' AND o.dk=0 ;
     exception when no_data_found then
        szPFUNlsA := '' ;
     end;
     lszVars := 'OPFU-A~' ;
     lszVals := szPFUNlsA || '~' ;

  -- ! Тикет на взнос валюты из филиала. --------------------------------------
  elsif szTemplPrefix = 'CSH_IN' then
     begin
        select a.nls, a.nms into szTransitNls, szTransitNms
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt = 'ZKF' AND o.dk=1 ;
     exception when no_data_found then
        szTransitNls := '' ;
        szTransitNms := '' ;
     end;
     lszVars := 'OTransitNls~OTransitNms~' ;
     lszVals := szTransitNls || '~' ||
        Replace( szTransitNms, '~', '`' ) || '~' ;

  -- ! Тикет на выдачу валюты филиалу. ----------------------------------------
  elsif szTemplPrefix = 'CSHOUT' then
     begin
        select a.nls, a.nms into szTransitNls, szTransitNms
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt = 'ZSG' AND o.dk=1 ;
     exception when no_data_found then
        szTransitNls := '' ;
        szTransitNms := '' ;
     end;
     lszVars := 'OTransitNls~OTransitNms~' ;
     lszVals := szTransitNls || '~' ||
        Replace( szTransitNms, '~', '`' ) || '~' ;

  -- ! Тикет на продажу/покупку валюты с ПФ. ----------------------------------
  elsif szTemplPrefix = 'MLCYPF' then
     begin
        select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nFSummPcnt
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE 'A0_' AND o.dk=0 ;
     exception when no_data_found then
        szPFUNlsA  := '' ;
        szPFUNmsA  := '' ;
        nFSummPcnt := 0  ;
     end;
     begin
        select a.nls, a.nms into szPFUNlsB, szPFUNmsB
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE 'A0_' AND o.dk=1 ;
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OPFU-B~OPFUN-B~OSumm1p~OSumm1pLit~' ;
     lszVals := szPFUNlsA || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        szPFUNlsB || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummPcnt/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nFSummPcnt, 980, 'F' ) || '~' ;

  -- ! Тикет на моментальное инкассо ------------------------------------------
  elsif szTemplPrefix = 'INSTKS' then
     begin
        select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nFSummPcnt
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE '316'
           and o.dk=1 AND a.kv=980 ;
     exception when no_data_found then
        szPFUNlsA  := '' ;
        szPFUNmsA  := '' ;
        nFSummPcnt := 0  ;
     end;
     begin
        select o.s into l_s2 from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE '317'
           and o.dk=1 AND a.kv=980 AND a.tip='KAS' ;
     exception when no_data_found then
        l_s2 := 0 ;
     end;
     begin
        select sk into szCashSymb from tts where tt='317' ;
     exception when no_data_found then
        szCashSymb := 0 ;
     end;
     begin
        select sk into szCashSComis from tts where tt='316' ;
     exception when no_data_found then
        szCashSComis := 0 ;
     END ;
     l_kv2 := 980 ;
     szISOCCode2 := 'UAH' ;
     szCcyName2  := 'грн' ;
     szCUnit2    := 'коп' ;

     lszVars := 'OPFU-A~OPFUN-A~OSumm1p~OSumm1pLit~OCashSymb~OCashSymbComis~' ;
     lszVals := szPFUNlsA || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummPcnt/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nFSummPcnt, 980, 'F' ) || '~' ||
        szCashSymb   || '~' ||
        szCashSComis || '~' ;

  -- ! Тикет на покупку дор. чеков (АЖИО) -------------------------------------
  elsif szTemplPrefix = 'CHDTIC' then
     begin
        select o.s into l_s from opldok o
         where o.ref=nRecID AND o.dk=0 AND o.tt='K41' ;
     exception when no_data_found then
        l_s := 0 ;
     end;

  -- ! Тикет на выдачу налички по дор. чеков (АЖИО) ---------------------------
  elsif szTemplPrefix = 'CHKTIC' then
    begin
      select o.s into l_s from opldok o
      where o.ref=nRecID AND o.dk=0 AND o.tt='K45' ;
    exception when no_data_found then
      l_s := 0 ;
    end;

  -- ! Тикет на продажу дор. чеков (АЖИО) -------------------------------------
  elsif szTemplPrefix = 'CHPTIC' then
     begin
        select a.nls, o.s into szPFUNlsB, nSummComis
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt='K43' AND o.dk=0 ;
     exception when no_data_found then
        szPFUNlsB  := '' ;
        nSummComis := 0  ;
     end;
     lszVars := 'OPFU-B~OSummComis~OSummComisLit~' ;
     lszVals :=  szPFUNlsB || '~' ||
        Trim( to_charD( nSummComis/Power(10,nDig), '9999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nSummComis, l_kv, 'F' ) || '~' ;

  -- ! Тикет на начисление оплаты по Клиент-Банку (АЖИО) ----------------------
  elsif szTemplPrefix = 'ELKTIC' then
     begin
        select a.nls, a.nms, o.s into szPFUNlsB, szPFUNmsB, nSummComis
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt='S21' AND o.dk=1 ;
     exception when no_data_found then
        szPFUNlsB  := '' ;
        szPFUNmsB  := '' ;
        nSummComis := 0  ;
     end;
     lszVars := 'ONLS-B1~ORcvr1~OSumm1~OSumm1Lit~' ;
     lszVals :=
        szPFUNlsB || '~' ||
        szPFUNmsB || '~' ||
        Trim( to_charD( nSummComis/Power(10,nDig), '999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nSummComis, l_kv, 'F' ) || '~' ;
     begin
        select a.nls, a.nms, o.s into szPFUNlsB, szPFUNmsB, nSummComis
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt='S22' AND o.dk=1 ;
     exception when no_data_found then
        szPFUNlsB  := '' ;
        szPFUNmsB  := '' ;
        nSummComis := 0  ;
     end;
     lszVars := lszVars || 'ONLS-B2~ORcvr2~OSumm2~OSumm2Lit~' ;
     lszVals := lszVals ||
        szPFUNlsB || '~' ||
        szPFUNmsB || '~' ||
        Trim( to_charD( nSummComis/Power(10,nDig), '999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nSummComis, l_kv, 'F' ) || '~' ;
     begin
        select a.nls, a.nms, o.s into szPFUNlsB, szPFUNmsB, nSummComis
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt='S23' AND o.dk=1 ;
     end;
     lszVars := lszVars || 'ONLS-B3~ORcvr3~OSumm3~OSumm3Lit~' ;
     lszVals := lszVals ||
        szPFUNlsB || '~' ||
        szPFUNmsB || '~' ||
        Trim( to_charD( nSummComis/Power(10,nDig), '999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nSummComis, l_kv, 'F' ) || '~' ;

  -- ! Тикет кассовый (?) с подменой валюты (АЖИО) ----------------------------
  elsif szTemplPrefix = 'KAS_KR' then
     begin
        select o.s into nSubTrnSum from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND kv = 980 AND a.tip='KAS' ;
     exception when no_data_found then
        nSubTrnSum := 0 ;
     end;
     begin
        select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nFSummPcnt
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE 'A0_' AND o.dk=0 ;
     exception when no_data_found then
        szPFUNlsA  := '' ;
        szPFUNmsA  := '' ;
        nFSummPcnt := 0  ;
     end;
     begin
        select a.nls, a.nms into szPFUNlsB, szPFUNmsB
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE 'A0_' AND o.dk=1 ;
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
     end;
     lszVars := 'OFSummB~OFSummBLit~OPFU-A~OPFUN-A~OPFU-B~OPFUN-B~OSumm1p~OSumm1pLit~' ;
     lszVals :=
        Trim( to_charD( nSubTrnSum/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nSubTrnSum, 980, 'F' ) || '~' ||
        szPFUNlsA || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        szPFUNlsB || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummPcnt/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nFSummPcnt, 980, 'F' ) || '~' ;

  -- ! Тикет на кассовый ордес для операций 1*С (Ажио) ------------------------
  elsif szTemplPrefix = 'KAS_KP' then
     begin
        select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nSummComis
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt AND o.dk=0 ;
     exception when no_data_found then
        szPFUNlsA  := '' ;
        szPFUNmsA  := '' ;
        nSummComis := 0  ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OSummComis~OSummComisLit~' ;
     lszVals :=
        szPFUNlsA  || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        Trim( to_charD( nSummComis/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nSummComis, 980, 'F' ) || '~' ;
     begin
        select a.nls, a.nms into szPFUNlsB, szPFUNmsB
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt AND o.dk=1 ;
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
     end;
     lszVars := lszVars || 'OPFU-B~OPFUN-B~' ;
     lszVals := lszVals ||
        szPFUNlsB || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ;
     begin
        select sk into szCashSComis from tts
         where tt=(select tt from opldok where ref=nRecID AND tt <> l_tt AND dk=0) ;
     exception when no_data_found then
        szCashSComis := 0 ;
     end;
     lszVars := lszVars || 'OCashSymbComis~' ;
     lszVals := lszVals || szCashSComis || '~' ;

  -- ! Тикет на приход Вал для перевода по Анелик(АЖИО) -----------------------
  elsif Substr(szTemplPrefix,1,4) = 'C17T' then
     begin
        select o.s into l_s from opldok o
         where o.ref=nRecID AND o.dk=0 AND o.tt='KC1' ;
     exception when no_data_found then
        l_s := 0 ;
     end;
     begin
        select gl.p_icurval(l_kv, l_s, l_data) into l_sq from dual ;
     exception when no_data_found then
        l_sq := 0 ;
     end;
     begin
        select a.nls, a.nms, o.s into szRndNlsB, szRndNmsB, nRndSum2
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.dk=1 AND o.tt='KC3' ;
     exception when no_data_found then
        szRndNlsB := '' ;
        szRndNmsB := '' ;
        nRndSum2  := 0  ;
     end;
     begin
        select a.nls, a.nms, o.s into szPFUNlsB, szPFUNmsB, nSummComis
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.dk=1
           and o.tt in ('KC2','KC6','KC8','KCA') ;
     exception when no_data_found then
        szPFUNlsB  := '' ;
        szPFUNmsB  := '' ;
        nSummComis := 0  ;
     end;
     EXECUTE IMMEDIATE
       'begin ' ||
          'GetXRateTic' ||
           '(:nRatO, :nRatB, :nRatS, :l_kv, 980, :l_data); ' ||
       'end; '
     USING OUT nRatO, OUT nRatB, OUT nRatS, IN l_kv, IN l_data ;
     EXECUTE IMMEDIATE
       'begin ' ||
          'GetXRateTic' ||
           '(:nRatOV, :nRatBV, :nRatSV, :l_kv, 980, :l_vdat); ' ||
       'end; '
     USING OUT nRatOV, OUT nRatBV, OUT nRatSV, IN l_kv, IN l_vdat_rate ;
     lszVars := 'ORndNLS-B~ORndNMS-B~ORndSum2~ORndSumLit2~OPFU-B~OPFUN-B~OSummComis~OSummComisLit~' ;
     lszVals :=  szRndNlsB || '~' ||
        Replace( szRndNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nRndSum2/Power(10,nDig), '999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nRndSum2, l_kv, 'F' ) || '~' ||
        szPFUNlsB || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nSummComis/100, '99999999999990D99' )) || '~' ||
        F_SumPr(nSummComis, 980, 'F' ) || '~' ;

  -- ! Тикет на "Внесення гот_вки на 1001 з зарах на рах" (НБУ Подол) ---------
  elsif Substr(szTemplPrefix,1,4) = 'KAS1' then
     begin
        select a.nls, a.nms into szPFUNlsA, szPFUNmsA
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt<>l_tt
           and o.dk=0 AND a.nbs is not null ;
     exception when no_data_found then
        szPFUNlsA := '' ;
        szPFUNmsA := '' ;
     end;
     begin
        select a.nls, a.nms into szPFUNlsB, szPFUNmsB
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt<>l_tt
           and o.dk=1 AND a.nbs is not null ;
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OPFU-B~OPFUN-B~' ;
     lszVals := szPFUNlsA || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        szPFUNlsB || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ;

  -- ! Тикет С ОДНОЙ ДОЧЕРНЕЙ ОПЕРАЦИЕЙ ---------------------------------------
  elsif Substr(szTemplPrefix,1,5) = 'ROBOR' then
     begin
        select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nSummComis
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt AND o.dk=0
           AND a.nls not like '8%' and rownum=1 ; -- Не знаю кто делал, было в РУ, думаю сами делали
     exception when no_data_found then
        szPFUNlsA  := '' ;
        szPFUNmsA  := '' ;
        nSummComis := 0  ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OSummComis~OSummComisLit~' ;
     lszVals := szPFUNlsA || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        Trim( to_charD( nSummComis/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nSummComis, 980, 'F' ) || '~' ;
     begin
        select a.nls, a.nms into szPFUNlsB, szPFUNmsB
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt AND o.dk=1
           AND a.nls not like '8%' and rownum=1 ; -- Не знаю кто делал, было в РУ, думаю сами делали
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
     end;
     lszVars := lszVars || 'OPFU-B~OPFUN-B~' ;
     lszVals := lszVals ||
        szPFUNlsB  || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ;

  -- ! Тикет c доч. операциями ------------------------------------------------
  elsif Substr(szTemplPrefix,1,5) = 'ORDER' then
    -- ! осн.
    begin
       select o1.stmt, a1.nls, a1.nms, a2.nls, a2.nms, o1.s
         into l_stmt, szPFUNlsA, szPFUNmsA, szPFUNlsB, szPFUNmsB, nFSummB
         from opldok o1, accounts a1, opldok o2, accounts a2
        where o1.ref=nRecID AND o1.tt=l_tt AND a1.kv=l_kv
          and o1.acc=a1.acc AND o1.dk=0 AND o2.acc=a2.acc AND o2.dk=1
          and o1.ref=o2.ref AND o1.stmt=o2.stmt
          and a1.nbs <> '6204' and a2.nbs <> '6204'
		  and a1.nls not like '8%' and a2.nls not like '8%' ;
     exception when others then
       if sqlcode = -01403 then
           szPFUNlsA := '' ;
           szPFUNmsA := '' ;
           szPFUNlsB := '' ;
           szPFUNmsB := '' ;
           nFSummB   := 0  ;
       elsif sqlcode = -01422 then
         begin
           select  o1.stmt, a1.nls, a1.nms, a2.nls, a2.nms, o1.s
              into l_stmt, szPFUNlsA, szPFUNmsA, szPFUNlsB, szPFUNmsB, nFSummB
              from opldok o1, accounts a1, opldok o2, accounts a2
            where o1.ref=nRecID AND o1.tt=l_tt AND a1.kv=l_kv
              and o1.acc=a1.acc AND o1.dk=0 AND o2.acc=a2.acc AND o2.dk=1
              and o1.ref=o2.ref-- AND o1.stmt=o2.stmt
              and a1.nbs <> '6204' and a2.nbs <> '6204'
              and a1.nls not like '8%' and a2.nls not like '8%'
              and  o1.stmt<>o2.stmt 
              and o1.acc <>o2.acc;
         exception when no_data_found then
            szPFUNlsA := '' ;
            szPFUNmsA := '' ;
            szPFUNlsB := '' ;
            szPFUNmsB := '' ;
            nFSummB   := 0  ;
         end;
       end if;
    end;
    lszVars := 'OPFU-A~OPFUN-A~OPFU-B~OPFUN-B~OSummDo~OSummDoLit~' ;
    lszVals :=  szPFUNlsA || '~' ||
       Replace( szPFUNmsA, '~', '`' ) || '~' ||
       szPFUNlsB || '~' ||
       Replace( szPFUNmsB, '~', '`' ) || '~' ||
       Trim( to_charD( nFSummB/100, '99999999999990D99' )) || '~' ||
       F_SumPr( nFSummB, 980, 'F' ) || '~' ;
    -- ! доч. оп.
    l_ord := 1;
    i := 1 ;
    For k in (select a1.nls nls1, a1.nms nms1, a1.kv kv1, t1.lcv lcv1, t1.dig dig1, t1.unit unit1,
                     a2.nls nls2, a2.nms nms2, a2.kv kv2, t2.lcv lcv2, t2.dig dig2, t2.unit unit2,
                     o1.s s1, o2.s s2,
                     gl.p_icurval(a1.kv, o1.s, o1.fdat) sq1,
                     gl.p_icurval(a2.kv, o2.s, o2.fdat) sq2
                from opldok o1, accounts a1, tabval t1,
                     opldok o2, accounts a2, tabval t2
               where o1.ref=nRecID AND o1.stmt<>nvl(l_stmt,0)
                 and o1.acc=a1.acc AND o1.dk=0 AND a1.kv=t1.kv
                 and o2.acc=a2.acc AND o2.dk=1 AND a2.kv=t2.kv
                 and o1.ref=o2.ref AND o1.stmt=o2.stmt
				 and a1.nls not like '8%' and a2.nls not like '8%'
               ORDER BY
                     CASE WHEN l_ord =-1  THEN o1.tt END DESC,
                     CASE WHEN l_ord <>-1 THEN o1.tt END ASC )
    Loop
       szPFUNlsA := k.nls1 ; szPFUNmsA := k.nms1 ; nKVA := k.kv1;
       sISOA := k.lcv1 ; nDigA := k.dig1 ; sUnitA := k.unit1 ;
       szPFUNlsB := k.nls2 ; szPFUNmsB := k.nms2 ; nKVB := k.kv2 ;
       sISOB := k.lcv2 ; nDigB := k.dig2 ; sUnitB := k.unit2 ;
       nSummA := k.s1 ; nSummB := k.s2 ; nSummAQ := k.sq1; nSummBQ := k.sq2 ;

       if l_prv = 0 and l_prv2 = 0 then
          EXECUTE IMMEDIATE
            'begin ' ||
          'GetXRateTic' ||
            '(:nRatOA, :nRatBA, :nRatSA, :l_kv, :nKVA, :l_data); ' ||
            'end; '
          USING OUT nRatOA, OUT nRatBA, OUT nRatSA, IN l_kv, IN nKVA, IN l_data ;
          EXECUTE IMMEDIATE
            'begin ' ||
          'GetXRateTic' ||
            '(:nRatOVA, :nRatBVA, :nRatSVA, :l_kv, :nKVA, :l_vdat); ' ||
            'end; '
          USING OUT nRatOVA, OUT nRatBVA, OUT nRatSVA, IN l_kv, IN nKVA, IN l_vdat_rate ;
          EXECUTE IMMEDIATE
            'begin ' ||
          'GetXRateTic' ||
            '(:nRatOB, :nRatBB, :nRatSB, :nKVA, :l_kv, :l_data); ' ||
            'end; '
          USING OUT nRatOB, OUT nRatBB, OUT nRatSB, IN nKVA, IN l_kv, IN l_data ;
          EXECUTE IMMEDIATE
            'begin ' ||
          'GetXRateTic' ||
            '(:nRatOVB, :nRatBVB, :nRatSVB, :nKVA, :l_kv, :l_vdat); ' ||
            'end; '
          USING OUT nRatOVB, OUT nRatBVB, OUT nRatSVB, IN nKVA, IN l_kv, IN l_vdat_rate ;
       else
          nRatOA  := 0;
          nRatBA  := 0;
          nRatSA  := 0;
          nRatOVA := 0;
          nRatBVA := 0;
          nRatSVA := 0;
          nRatOB  := 0;
          nRatBB  := 0;
          nRatSB  := 0;
          nRatOVB := 0;
          nRatBVB := 0;
          nRatSVB := 0;
       end if;

       if Trim(Upper(sISOA)) = 'UAH' then
          sISOName := 'грн' ;
       else
          sISOName := sISOA ;
       end if;

       if Trim(Upper(sISOB)) = 'UAH' then
          sISOName2 := 'грн' ;
       else
          sISOName2 := sISOB ;
       end if;

       lszVars := lszVars ||
          'ONLSD'   ||to_char(i)||'~ONMSD'     ||to_char(i)||'~OKVD'||to_char(i)||'~OISOD'||to_char(i)||
          '~ONLSK'  ||to_char(i)||'~ONMSK'     ||to_char(i)||'~OKVK'||to_char(i)||'~OISOK'||to_char(i)||
          '~OSummD' ||to_char(i)||'~OSummDLit' ||to_char(i)||
          '~OSummK' ||to_char(i)||'~OSummKLit' ||to_char(i)||
          '~OSummDQ'||to_char(i)||'~OSummDQLit'||to_char(i)||
          '~OSummKQ'||to_char(i)||'~OSummKQLit'||to_char(i)||
          '~ORat1O' ||to_char(i)||'~ORat1B'    ||to_char(i)||'~ORat1S' ||to_char(i)||
          '~ORat1OV'||to_char(i)||'~ORat1BV'   ||to_char(i)||'~ORat1SV'||to_char(i)||
          '~ORat2O' ||to_char(i)||'~ORat2B'    ||to_char(i)||'~ORat2S' ||to_char(i)||
          '~ORat2OV'||to_char(i)||'~ORat2BV'   ||to_char(i)||'~ORat2SV'||to_char(i)||'~' ;
       lszVals := lszVals ||
          szPFUNlsA || '~' ||
          Replace( szPFUNmsA, '~', '`' ) || '~' ||
          to_char( nKVA ) || '~' ||
          sISOA || '~' ||
          szPFUNlsB || '~' ||
          Replace( szPFUNmsB, '~', '`' ) || '~' ||
          to_char( nKVB ) || '~' ||
          sISOB || '~' ||
          Trim( to_charD( nSummA/Power(10,nDigA), '999999999999990D'||rpad('9',nDigA,'9') )) || '~' ||
          F_SumPr( nSummA, nKVA, 'F' )  || '~' ||
          Trim( to_charD( nSummB/Power(10,nDigB), '999999999999990D'||rpad('9',nDigB,'9') )) || '~' ||
          F_SumPr( nSummB, nKVB, 'F' ) || '~' ||
          Trim( to_charD( nSummAQ/100, '99999999999990D99' )) || '~' ||
          F_SumPr( nSummAQ, 980, 'F' ) || '~' ||
          Trim( to_charD( nSummAQ/100, '99999999999990D99' )) || '~' ||
          F_SumPr( nSummAQ, 980, 'F' ) || '~' ||
          Trim( to_char( nRatOA, '999999999990D9999' )) || '~' ||
          Trim( to_char( nRatBA, '999999999990D9999' )) || '~' ||
          Trim( to_char( nRatSA, '999999999990D9999' )) || '~' ||
          Trim( to_char( nRatOVA,'999999999990D9999' )) || '~' ||
          Trim( to_char( nRatBVA,'999999999990D9999' )) || '~' ||
          Trim( to_char( nRatSVA,'999999999990D9999' )) || '~' ||
          Trim( to_char( nRatOB, '999999999990D9999' )) || '~' ||
          Trim( to_char( nRatBB, '999999999990D9999' )) || '~' ||
          Trim( to_char( nRatSB, '999999999990D9999' )) || '~' ||
          Trim( to_char( nRatOVB,'999999999990D9999' )) || '~' ||
          Trim( to_char( nRatBVB,'999999999990D9999' )) || '~' ||
          Trim( to_char( nRatSVB,'999999999990D9999' )) || '~' ;
       i := i + 1 ;
    End Loop ;

  -- ! Тикет на продажу/покупку валюты ----------------------------------------
  elsif Substr(szTemplPrefix,1,5) = 'CCYEX' then
     begin
        select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nFSummPcnt
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE 'A__'
           and o.tt <> l_tt AND o.dk=0 ;
     exception when no_data_found then
        szPFUNlsA  := '' ;
        szPFUNmsA  := '' ;
        nFSummPcnt := 0  ;
     end;
     begin
        select a.nls, a.nms into szPFUNlsB, szPFUNmsB
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE 'A__'
           and o.tt <> l_tt AND o.dk=1 ;
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OPFU-B~OPFUN-B~OSumm1p~OSumm1pLit~' ;
     lszVals := szPFUNlsA || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        szPFUNlsB || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummPcnt/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nFSummPcnt, 980, 'F' ) || '~' ;

  -- ! Тикет на продажу/покупку ПЧ, ДЧ VISA -----------------------------------
  elsif Substr(szTemplPrefix,1,5) = 'CCYCK' then
     begin
        select a.nls, a.nms, o.s into szPFUNlsB, szPFUNmsB, nSummComis
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt
           and o.dk=1 AND kv=980 ;
     exception when no_data_found then
        szPFUNlsB  := '' ;
        szPFUNmsB  := '' ;
        nSummComis := 0  ;
     end;
     lszVars := 'OPFU-B~OPFUN-B~OSummComis~OSummComisLit~' ;
     lszVals :=  szPFUNlsB || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nSummComis/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nSummComis, 980, 'F' ) || '~' ;
     begin
        select a.nls, a.nms, o.s into szPFUNlsB, szPFUNmsB, nSummComis
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt
           and o.dk=1 AND kv=l_kv ;
     exception when no_data_found then
        szPFUNlsB  := '' ;
        szPFUNmsB  := '' ;
        nSummComis := 0  ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OSumm1p~OSumm1pLit~' ;
     lszVals := szPFUNlsB || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nSummComis/Power(10,nDig), '999999999999990D'||rpad('9',nDigB,'9')  )) || '~' ||
        F_SumPr( nSummComis, l_kv, 'F' ) || '~' ;

  -- ! Тикет на перечисление от физлиц в пользу юр-лиц ------------------------
  elsif Substr(szTemplPrefix,1,3) = 'PP2' then
     begin
        select o.tt, a.nls, a.nms into l_crnt_tt, szCashNls, szCashNms
          from opldok o, accounts a
         where o.dk=0 AND a.acc=o.acc AND o.ref=nRecID AND o.tt LIKE 'F=_'
           AND a.nls not like '8%';
     exception when no_data_found then
        l_crnt_tt := '' ;
        szCashNls := '' ;
        szCashNms := '' ;
     end;
     begin
        select sk into szCashSymb from tts where tt = l_crnt_tt ;
     exception when no_data_found then
        szCashSymb := 0 ;
     end;
     begin
        select a.nls, a.nms into szTransitNls, szTransitNms
          from opldok o, accounts a
         where o.dk=1 AND a.acc=o.acc AND o.ref=nRecID AND o.tt=l_tt
          AND a.nls not like '8%' AND a.nls not like '3%' AND a.nls not like '6%';
     exception when no_data_found then
        szTransitNls := '' ;
        szTransitNms := '' ;
     end;
     begin
        select o.tt, o.s, o.txt, a.nls, a.nms
          into l_crnt_tt, nSummComis, szComisNazn, szComisNls, szComisNms
          from opldok o, accounts a
         where o.dk=1 AND a.acc=o.acc AND ref=nRecID AND tt LIKE 'K__'
           AND a.nls not like '8%' ;
     exception when no_data_found then
        l_crnt_tt   := '' ;
        nSummComis  := 0  ;
        szComisNazn := '' ;
        szComisNls  := '' ;
        szComisNms  := '' ;
     end;
     begin
        select sk into szCashSComis from tts where tt = l_crnt_tt ;
     exception when no_data_found then
        szCashSComis := 0 ;
     end;
     lszVars := 'OCashNls~OCashNms~OTransitNls~OTransitNms~OComisNls~OComisNms~OCashSymbComis~OComisNazn~OSummComis~OSummLitComis~' ;
     lszVals := szCashNls || '~' ||
        Replace( szCashNms, '~', '`' )    || '~' ||
        szTransitNls || '~' ||
        Replace( szTransitNms, '~', '`' ) || '~' ||
        szComisNls   || '~' ||
        Replace( szComisNms, '~', '`' )   || '~' ||
        szCashSComis || '~' ||
        Replace( szComisNazn, '~', '`' )  || '~' ||
        Trim( to_charD( nSummComis/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nSummComis, 980, 'F' ) || '~' ;

  -- ! Тикет на выдачу нала с комиссией ГРИВНА и ВАЛЮТА. ----------------------
  elsif Substr(szTemplPrefix,1,5) = 'NLOUT' then
     begin
        select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nFSummPcnt
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt AND o.dk=0
           AND a.nls not like '8%' ;
     exception when no_data_found then
        szPFUNlsA  := '' ;
        szPFUNmsA  := '' ;
        nFSummPcnt := 0  ;
     end;
     begin
        select a.nls, a.nms into szPFUNlsB, szPFUNmsB
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt AND o.dk=1
           AND a.nls not like '8%' ;
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OPFU-B~OPFUN-B~OSummDo~OSummDoLit~' ;
     lszVals := szPFUNlsA || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        szPFUNlsB || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummPcnt/Power(10,nDig), '999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nFSummPcnt, l_kv, 'F' ) || '~'  ;

  -- ! Тикет для GCF,GPF (Ажио) -----------------------------------------------
  elsif Substr(szTemplPrefix,1,5) = 'KA_PE' then
     -- ! Счет кассы, сумма = сум.перевода + сум.комис
     begin
        select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nFSummPcnt
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt
           and o.dk=0 AND a.nls like '1001%' ;
     exception when no_data_found then
        szPFUNlsA  := '' ;
        szPFUNmsA  := '' ;
        nFSummPcnt := 0  ;
     end;
     -- ! сум.комис
     begin
        select o.s into nSummComis from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt <> l_tt
           and o.dk<>l_dk AND a.nls=l_nlsa AND o.s<>l_s ;
     exception when no_data_found then
        nSummComis := 0 ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OSummDo~OSummDoLit~OFSummComis~OFSummComisLit~' ;
     lszVals := szPFUNlsA || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummPcnt/Power(10,nDig), '999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nFSummPcnt, l_kv, 'F' ) || '~' ||
        Trim( to_charD( nSummComis/Power(10,nDig), '999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nSummComis, l_kv, 'F' ) || '~' ;

  -- ! Тикет для CH3,CH4(доч. KH1,KH2,KH3,KH4) (Ажио) -------------------------
  elsif Substr(szTemplPrefix,1,5) = 'MEMCH' then
     begin
        select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nFSummPcnt
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt='KH1' AND o.dk=0 ;
     exception when no_data_found then
        szPFUNlsA  := '' ;
        szPFUNmsA  := '' ;
        nFSummPcnt := 0  ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OSummDo~OSummDoLit~' ;
     lszVals := szPFUNlsA || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummPcnt/Power(10,nDig), '999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nFSummPcnt, l_kv, 'F' ) || '~' ;
     begin
        select a.nls, a.nms, o.s, a2.nls, a2.nms, o2.s
          into szPFUNlsB, szPFUNmsB, nFSummB, szPFUNlsC, szPFUNmsC, nRndSum2
          from opldok o, accounts a, opldok o2, accounts a2
         where a.acc=o.acc AND o.ref=nRecID AND o.tt in ('KH2','KH4')
           and o.dk=1 AND a.kv=l_kv AND a2.acc=o2.acc AND o.ref=o2.ref
           and o.tt=o2.tt AND o2.dk=1 AND a2.kv<>l_kv ;
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
        nFSummB   := 0  ;
        szPFUNlsC := '' ;
        szPFUNmsC := '' ;
        nRndSum2  := 0  ;
     end;
     lszVars := lszVars ||
        'ORndNLS-A~ORndNMS-A~ORndSum1~ORndSumLit~' ||
        'ORndNLS-B~ORndNMS-B~ORndSum2~ORndSumLit2~' ;
     lszVals := lszVals ||
        szPFUNlsB || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummB/Power(10,nDig), '999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nFSummB, l_kv, 'F' ) || '~' ||
        szPFUNlsC || '~' ||
        Replace( szPFUNmsC, '~', '`' ) || '~' ||
        Trim( to_charD( nRndSum2/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nRndSum2, 980, 'F' ) || '~' ;
     begin
        select o.s, o.sq into nFSummC, nFSummD from opldok o
         where o.ref=nRecID AND o.tt='KH3' AND o.dk=0 ;
     exception when no_data_found then
        nFSummC := 0 ;
        nFSummD := 0 ;
     end;
     lszVars := lszVars || 'OSummDo2~OSummDoLit2~OSummDo3~OSummDoLit3~' ;
     lszVals := lszVals ||
        Trim( to_charD( nFSummC/Power(10,nDig), '999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
        F_SumPr( nFSummC, l_kv, 'F' ) || '~' ||
        Trim( to_charD( nFSummD/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nFSummD, 980, 'F' ) || '~';

  -- ! Тикет на прих/расх кас.ордер БАНКОМАТ (НБУ Подол) ----------------------
  elsif Substr(szTemplPrefix,1,5) = 'KASBK' then
     begin
        select a.nls, a.nms, to_char(t.sk)
          into szPFUNlsA, szPFUNmsA, szCashSComis
          from opldok o, accounts a, tts t
         where a.acc=o.acc AND o.ref=nRecID AND o.tt<>l_tt
           and o.dk=0 AND a.nbs is not null AND o.tt=t.tt ;
     exception when no_data_found then
        szPFUNlsA    := '' ;
        szPFUNmsA    := '' ;
        szCashSComis := 0  ;
     end;
     begin
        select a.nls, a.nms into szPFUNlsB, szPFUNmsB
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt<>l_tt
           and o.dk=1 AND a.nbs is not null ;
     exception when no_data_found then
        szPFUNlsB := '' ;
        szPFUNmsB := '' ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OPFU-B~OPFUN-B~OCashSymbComis~' ;
     lszVals := szPFUNlsA || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        szPFUNlsB || '~' ||
        Replace( szPFUNmsB, '~', '`' ) || '~' ||
        szCashSComis || '~' ;

  -- ! Тикет (Ажио) -----------------------------------------------------------
  elsif szTemplPrefix = 'KASSAP' then
     begin
        select a.nls, a.nms, o.s into szPFUNlsA, szPFUNmsA, nFSummB
          from opldok o, accounts a
         where a.acc=o.acc AND o.ref=nRecID AND o.tt='FO1' AND o.dk=0 ;
     exception when no_data_found then
        szPFUNlsA := '' ;
        szPFUNmsA := '' ;
        nFSummB   := 0  ;
     end;
     lszVars := 'OPFU-A~OPFUN-A~OFSummComis~OFSummComisLit~' ;
     lszVals := szPFUNlsA || '~' ||
        Replace( szPFUNmsA, '~', '`' ) || '~' ||
        Trim( to_charD( nFSummB/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nFSummB, 980, 'F' ) || '~' ;
     begin
        select o.s into nSummComis from opldok o
         where o.ref=nRecID AND o.tt='FO2' AND o.dk=1 ;
     exception when no_data_found then
        nSummComis := 0 ;
     end;
     lszVars := lszVars||'OSummComis~OSummComisLit~' ;
     lszVals := lszVals||
        Trim( to_charD( nSummComis/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nSummComis, 980, 'F' ) || '~' ;

  -- ! Тикет (Ажио) -----------------------------------------------------------
  elsif szTemplPrefix = 'SBERFV' then
     begin
        select o.s into nFSummB from opldok o
         where o.ref=nRecID AND o.tt='FO4' AND o.dk=0 ;
     exception when no_data_found then
        nFSummB := 0 ;
     end;
     lszVars := 'OFSummComis~OFSummComisLit~' ;
     lszVals :=
        Trim( to_charD( nFSummB/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nFSummB, 980, 'F' ) || '~' ;
     begin
        select o.s into nSummComis from opldok o
         where o.ref=nRecID AND o.tt='FO5' AND o.dk=1 ;
     exception when no_data_found then
        nSummComis := 0 ;
     end;
     lszVars := lszVars||'OSummComis~OSummComisLit~' ;
     lszVals := lszVals||
        Trim( to_charD( nSummComis/100, '99999999999990D99' )) || '~' ||
        F_SumPr( nSummComis, 980, 'F' ) || '~' ;

  end if;

  for k in ( select b.par, b.txt
               from ( select a.par, nvl(b.rep_prefix,'DEFAULT') rep_prefix
                        from ( select par from tickets_par
                                where upper(rep_prefix) = upper(szTemplPrefix)
                                  and mod_code = 'TIC'
                                union
                               select par from tickets_par
                                where upper(rep_prefix) = upper('DEFAULT')
                                  and mod_code = 'TIC' ) a, tickets_par b
                       where a.par = b.par(+)
                         and upper(b.rep_prefix(+)) = upper(szTemplPrefix)
                         and b.mod_code(+) = 'TIC') a, tickets_par b
              where upper(a.rep_prefix) = upper(b.rep_prefix) and a.par = b.par
                and mod_code = 'TIC' )
  loop
     sTPar := k.par ;
     sTSql := k.txt ;
     -- в SQL-строке заменяем имя таблицы (oper/arc_rrp)
     sTSql := Replace( sTSql, ':TabName', szTabName ) ;
     -- в SQL-строке заменяем имя колонки-ид.документа (ref/rec)
     sTSql := Replace( sTSql, ':DocIdName',  sDocIdName ) ;
     -- в SQL-строке заменяем обращение к центурным переменным
     -- sTSql := Replace( sTSql, ':nRecID', to_char(nRecId) ) ;
     -- sTSql := Replace( sTSql, ':nVob',   to_char(nVob) ) ;
     sTSql := Replace( sTSql, ':_tt',      ':l_tt' ) ;
     sTSql := Replace( sTSql, ':_data',    ':l_data') ;
     sTSql := Replace( sTSql, ':_vdat',    ':l_vdat' ) ;
     sTSql := Replace( sTSql, ':_pdat',    ':l_pdat' ) ;
     sTSql := Replace( sTSql, ':_dk',      ':l_dk' ) ;
     sTSql := Replace( sTSql, ':_s',       ':l_s' ) ;
     sTSql := Replace( sTSql, ':_sq',      ':l_sq' ) ;
     sTSql := Replace( sTSql, ':_sqv',     ':l_sqv' ) ;
     sTSql := Replace( sTSql, ':_s2',      ':l_s2' ) ;
     sTSql := Replace( sTSql, ':_sq2',     ':l_sq2' ) ;
     sTSql := Replace( sTSql, ':_sqv2',    ':l_sqv2' ) ;
     sTSql := Replace( sTSql, ':_mfoa',    ':l_mfoa' ) ;
     sTSql := Replace( sTSql, ':_mfob',    ':l_mfob' ) ;
     sTSql := Replace( sTSql, ':_nam_a',   ':l_nam_a' ) ;
     sTSql := Replace( sTSql, ':_nam_b',   ':l_nam_b' ) ;
     sTSql := Replace( sTSql, ':_id_a',    ':l_id_a' ) ;
     sTSql := Replace( sTSql, ':_id_b',    ':l_id_b' ) ;
     sTSql := Replace( sTSql, ':_nazn',    ':l_nazn' ) ;
     sTSql := Replace( sTSql, ':_nd',      ':l_nd' ) ;
     sTSql := Replace( sTSql, ':_nlsa',    ':l_nlsa' ) ;
     sTSql := Replace( sTSql, ':_nlsb',    ':l_nlsb' ) ;
     sTSql := Replace( sTSql, ':_bank_a',  ':l_bank_a' ) ;
     sTSql := Replace( sTSql, ':_bank_b',  ':l_bank_b' ) ;
     sTSql := Replace( sTSql, ':_kv',      ':l_kv' ) ;
     sTSql := Replace( sTSql, ':_kv2',     ':l_kv2' ) ;
     sTSql := Replace( sTSql, ':_sk',      ':l_sk' ) ;
     sTSql := Replace( sTSql, ':_ext_ref', ':l_ext_ref' ) ;
     sTSql := Replace( sTSql, ':_d_rec',   ':l_d_rec' ) ;
     sTSql := Replace( sTSql, ':_user_id', ':l_user_id' ) ;
     sTmp  := '' ;
     if sTSql is not null then
        begin
           l_cursor := dbms_sql.open_cursor;
           dbms_sql.parse(l_cursor, sTSql, dbms_sql.native);
           if instr(sTSql, ':nRecID')    > 0 then dbms_sql.bind_variable(l_cursor, ':nRecID', nRecID); end if;
           if instr(sTSql, ':nVob')      > 0 then dbms_sql.bind_variable(l_cursor, ':nVob', nVob); end if;
           if instr(sTSql, ':l_tt')      > 0 then dbms_sql.bind_variable(l_cursor, ':l_tt', l_tt); end if;
           if instr(sTSql, ':l_data')    > 0 then dbms_sql.bind_variable(l_cursor, ':l_data', l_data); end if;
           if instr(sTSql, ':l_vdat')    > 0 then dbms_sql.bind_variable(l_cursor, ':l_vdat', l_vdat); end if;
           if instr(sTSql, ':l_pdat')    > 0 then dbms_sql.bind_variable(l_cursor, ':l_pdat', l_pdat); end if;
           if instr(sTSql, ':l_dk')      > 0 then dbms_sql.bind_variable(l_cursor, ':l_dk', l_dk); end if;
           if instr(sTSql, ':l_s')       > 0 then dbms_sql.bind_variable(l_cursor, ':l_s', l_s); end if;
           if instr(sTSql, ':l_sq')      > 0 then dbms_sql.bind_variable(l_cursor, ':l_sq', l_sq); end if;
           if instr(sTSql, ':l_sqv')     > 0 then dbms_sql.bind_variable(l_cursor, ':l_sqv', l_sqv); end if;
           if instr(sTSql, ':l_s2')      > 0 then dbms_sql.bind_variable(l_cursor, ':l_s2', l_s2); end if;
           if instr(sTSql, ':l_sq2')     > 0 then dbms_sql.bind_variable(l_cursor, ':l_sq2', l_sq2); end if;
           if instr(sTSql, ':l_sqv2')    > 0 then dbms_sql.bind_variable(l_cursor, ':l_sqv2', l_sqv2); end if;
           if instr(sTSql, ':l_mfoa')    > 0 then dbms_sql.bind_variable(l_cursor, ':l_mfoa', l_mfoa); end if;
           if instr(sTSql, ':l_mfob')    > 0 then dbms_sql.bind_variable(l_cursor, ':l_mfob', l_mfob); end if;
           if instr(sTSql, ':l_nam_a')   > 0 then dbms_sql.bind_variable(l_cursor, ':l_nam_a', l_nam_a); end if;
           if instr(sTSql, ':l_nam_b')   > 0 then dbms_sql.bind_variable(l_cursor, ':l_nam_b', l_nam_b); end if;
           if instr(sTSql, ':l_id_a')    > 0 then dbms_sql.bind_variable(l_cursor, ':l_id_a', l_id_a); end if;
           if instr(sTSql, ':l_id_b')    > 0 then dbms_sql.bind_variable(l_cursor, ':l_id_b', l_id_b); end if;
           if instr(sTSql, ':l_nazn')    > 0 then dbms_sql.bind_variable(l_cursor, ':l_nazn', l_nazn); end if;
           if instr(sTSql, ':l_nd')      > 0 then dbms_sql.bind_variable(l_cursor, ':l_nd', l_nd); end if;
           if instr(sTSql, ':l_nlsa')    > 0 then dbms_sql.bind_variable(l_cursor, ':l_nlsa', l_nlsa); end if;
           if instr(sTSql, ':l_nlsb')    > 0 then dbms_sql.bind_variable(l_cursor, ':l_nlsb', l_nlsb); end if;
           if instr(sTSql, ':l_bank_a')  > 0 then dbms_sql.bind_variable(l_cursor, ':l_bank_a', l_bank_a); end if;
           if instr(sTSql, ':l_bank_b')  > 0 then dbms_sql.bind_variable(l_cursor, ':l_bank_b', l_bank_b); end if;
           if instr(sTSql, ':l_kv')      > 0 then dbms_sql.bind_variable(l_cursor, ':l_kv', l_kv); end if;
           if instr(sTSql, ':l_kv2')     > 0 then dbms_sql.bind_variable(l_cursor, ':l_kv2', l_kv2); end if;
           if instr(sTSql, ':l_sk')      > 0 then dbms_sql.bind_variable(l_cursor, ':l_sk', l_sk); end if;
           if instr(sTSql, ':l_ext_ref') > 0 then dbms_sql.bind_variable(l_cursor, ':l_ext_ref', l_ext_ref); end if;
           if instr(sTSql, ':l_d_rec')   > 0 then dbms_sql.bind_variable(l_cursor, ':l_d_rec', l_d_rec); end if;
           if instr(sTSql, ':l_user_id') > 0 then dbms_sql.bind_variable(l_cursor, ':l_user_id', l_user_id); end if;
           dbms_sql.define_column(l_cursor, 1, sTmp, 254);
           l_tmpnum := dbms_sql.execute_and_fetch(l_cursor);
           dbms_sql.column_value(l_cursor,  1, sTmp);
           dbms_Sql.close_cursor(l_cursor);
        exception when others then
           bars_error.raise_nerror('TIC', 'SQL Parse Err:'||chr(10)||sTSql);
        end;
     end if;
     lszVars := lszVars || sTPar || '~' ;
     lszVals := lszVals || sTmp || '~' ;
  end loop;

  if l_kv <> gl.baseval or l_kv2 <> gl.baseval then
     if ( l_dk = 0 and l_kv <> gl.baseval ) or ( l_dk = 1 and l_kv = gl.baseval ) then
        -- ! покупка
        begin
           select gl.p_icurval(l_kv,l_s,l_data,1) into l_s_bs from dual ;
        exception when no_data_found then
           l_s_bs := 0 ;
        end;
     else
        -- ! продажа
        begin
           select gl.p_icurval(l_kv,l_s,l_data,2) into l_s_bs from dual ;
        exception when no_data_found then
           l_s_bs := 0 ;
        end;
     end if;
  end if;
  if fExtDocuments = 1 then    -- !---oper---
     -- ! Доп параметры.
     if lszVars <> '' then
        lszVars := lszVars || '~' ;
        lszVals := lszVals || '~' ;
     end if;
     For k in ( select upper(tag) tag, value from operw where ref=nRecID )
     Loop
        szAddTag := k.tag ;
        szAddTagVal := k.value ;
        szAddTag := Trim(szAddTag) ;
        if szAddTag='L_CEN' or szAddTag='L_LIG' or szAddTag='L_SUM' or szAddTag='L_ZAG' or szAddTag='L_ZNJ' then
           szAddTagVal := Replace( szAddTagVal, '.', ',') ;
        end if;
        lszVars := lszVars || 'DR_' || szAddTag || '~' ;
        lszVals := lszVals || Replace(szAddTagVal, '~', '`' ) || '~' ;
        if szAddTag      = 'FIO' then
           szPayer := szAddTagVal ;
        elsif szAddTag = 'PASP' then
           szDoc := szAddTagVal ;
        elsif ( szAddTag = 'ATRT' OR szAddTag = 'PASP1' ) then
           szDocProp := szAddTagVal ;
        elsif szAddTag = 'POKPO' then
           szPayerOKPO := szAddTagVal ;
        elsif szAddTag = 'FIO2' then
           szPayer2 := szAddTagVal ;
        elsif szAddTag = 'ZDAT' then
           szZvitDate := szAddTagVal ;
        elsif szAddTag = 'IDB' then
           l_id_b := szAddTagVal ;
        elsif szAddTag = 'SK' then
           szCashSymb := szAddTagVal ;
        elsif szAddTag = '70' then
           szPmtDet := szAddTagVal ;
        elsif szAddTag = 'ADRES' then
           szPayerAdres := szAddTagVal ;
        elsif szAddTag = 'DOBR' then
           szPayerBD := szAddTagVal ;
        end if;
     end loop;
     begin
        select c.ruk, c.buh into szBoss, szAccMan
         from oper o, accounts a, corps c
        where o.ref  = nRecID
          and o.mfoa = a.kf
          and o.nlsa = a.nls
          and o.kv   = a.kv
          and a.rnk  = c.rnk;
     exception when no_data_found then
        szBoss   := '' ;
        szAccMan := '' ;
     end;
  end if;

  -- OKPO=0000000000
  if l_id_a = '0000000000' then
     l_okpo := null;
     begin
        begin
           select substr(trim(value),1,10) into l_okpo
             from operw
            where ref = nRecID and tag = 'Ф';
        exception when no_data_found then
           select decode(instr(l_d_rec,'#Ф'),0,null,
                  substr(l_d_rec,
                         instr(l_d_rec,'#Ф')+2,
                         instr(substr(l_d_rec,instr(l_d_rec,'#Ф')+2),'#')-1))
             into l_okpo from dual;
        end;
     exception when others then
        l_okpo := null;
     end;
     l_id_a := nvl(l_okpo, l_id_a);
  end if;
  if l_id_b = '0000000000' then
     l_okpo := null;
     begin
        select substr(trim(value),1,10) into l_okpo
          from operw
         where ref = nRecID and tag = 'ф';
     exception when no_data_found then
        select decode(instr(l_d_rec,'#ф'),0,null,
               substr(l_d_rec,
                      instr(l_d_rec,'#ф')+2,
                      instr(substr(l_d_rec,instr(l_d_rec,'#ф')+2),'#')-1))
          into l_okpo from dual;
     end;
     l_id_b := nvl(l_okpo, l_id_b);
  end if;

  -- ! Доп реквизиты.
  l_d_rec := Substr( l_d_rec, -(Length( l_d_rec )-1) ) ;
  if lszVars <> '' then
     lszVars := lszVars || '~' ;
     lszVals := lszVals || '~' ;
  end if;
  while l_d_rec is not null
  loop
     szAddTag := '#' || Substr( l_d_rec, 1, 1) ;
     l_d_rec  := Substr( l_d_rec, 2, Length( l_d_rec )-1 ) ;
     i := Instr( l_d_rec, '#' );
     if i = 0 then
        szAddTagVal := l_d_rec;
        l_d_rec := null;
     else
        szAddTagVal := Substr( l_d_rec, 1, i-1 ) ;
        l_d_rec  := Substr( l_d_rec, i+1 ) ;
     end if;
     if szAddTag = '#C' then
        l_nazn := l_nazn || ' #C' || szAddTagVal || '#';
     elsif szAddTag = '#П' then
        l_nazn := l_nazn || ' #П' || szAddTagVal || '#';
     end if;
     lszVars  := lszVars || 'DR_' || szAddTag || '~' ;
     lszVals  := lszVals || Replace(szAddTagVal, '~', '`' ) || '~' ;
  end loop;

  begin
     select name_from into szTmpMName
       from Meta_month
      where n=to_number(to_char(l_data,'MM')) ;
  exception when no_data_found then
     szTmpMName := '' ;
  end;
  begin
     select name_from into szTmpMNameV
       from Meta_month
      where n=to_number(to_char(l_vdat,'MM')) ;
  exception when no_data_found then
     szTmpMNameV := '' ;
  end;
  if to_number(to_char(l_data,'MM')) = 1 then
     begin
        select name_plain into szTmpKMName
          from Meta_month
         where n=12 ;
     exception when no_data_found then
        szTmpKMName := '' ;
     end;
  else
     begin
        select name_plain into szTmpKMName
          from Meta_month
         where n=to_number(to_char(l_data,'MM'))-1 ;
     exception when no_data_found then
        szTmpKMName := '' ;
     end;
  end if;
  szTmpKYear := to_char(to_number(to_char(l_data,'yyyy'))-1) ;

  begin
     select mnemonik into szTemplSuffix from Dk where dk=l_dk ;
  exception when no_data_found then
     szTemplSuffix := '' ;
  end;
  if szTemplSuffix = '' OR szTemplSuffix is null then
     szTemplSuffix := 'k' ;
  end if;

  sTicName := szTemplPrefix || '_' || szTemplSuffix ;

  lszVars := lszVars ||
     'OMyBankMFO~OMyBankName~OMyBankAdres~OPrintStamp~ONumber~ODay~OMonth~OYear~OKMonth~OKYear~OVDay~OVMonth~OVYear~OValDate~' ||
     'OSender~OBank-A~OMFO-A~OOKPO-A~ONLS-A~OCcyISO~OCcyCode~OS3800~OS3801~OS3801B~OSumm~OSummLit~'  ||
     'OFSumm~OFSummLit~OFSumm2~OFSummLit2~OUserID~OUserName~' ||
     'OReceiver~OBank-B~OMFO-B~OOKPO-B~ONLS-B~OCcyISO-B~OCcyCode-B~OSumm-B~OSummLit-B~' ||
     'ONazn~OPayer~OPOKPO~OPayer2~OZvitDate~ODocument~ODocProp~OCashSymb~OBoss~OAccMan~OPmtDet~' ||
     'OPAdres~OPBrDate~OBSumm~OPDat~OPTime~OVSumm~OVSummLit~OVSumm2~OVSummLit2~ONLS-Aa~ONMS-Aa~ONLS-Ba~ONMS-Ba~' ||
     'ORatO~ORatB~ORatS~ORatOV~ORatBV~ORatSV~ORat1~ORat2~' ||
     'ORatOA~ORatBA~ORatSA~ORatOVA~ORatBVA~ORatSVA~' ||
     'ORatOB~ORatBB~ORatSB~ORatOVB~ORatBVB~ORatSVB' ;

  lszVals := lszVals ||
     szMyBankMFO      || '~' ||
     Replace( szMyBankName, '~', '`' ) || '~' ||
     szMyBankAdres    || '~' ||
     szPrintTimeStamp || '~' ||
     l_nd             || '~' ||
     substr( '00' || to_char(l_data,'dd'), -2 ) || '~' ||
     szTmpMName  || '~' ||
     to_char( l_data,'yyyy' ) || '~' ||
     szTmpKMName || '~' ||
     szTmpKYear  || '~' ||
     substr( '00'|| to_char(l_vdat,'dd'), -2 )  || '~' ||
     szTmpMNameV || '~' ||
     to_char(l_vdat,'yyyy') || '~' ||
     to_char(l_vdat,'dd/MM/yyyy')  || '~' ||
     Replace( l_nam_a,  '~', '`' ) || '~' ||
     Replace( l_bank_a, '~', '`' ) || '~' ||
     l_mfoa   || '~' ||
     l_id_a   || '~' ||
     l_nlsa   || '~' ||
     szISOCCode || '~' ||
     to_char( l_kv ) || '~' ||
     szS3800  || '~' ||
     szS3801  || '~' ||
     szS3801B || '~' ||
     Trim( to_charD( l_s/Power( 10, nDig ), '9999999999999990D'||rpad('9',nDig,'9'))) || '~' ||
     F_SumPr(l_s, l_kv, 'F') || '~' ||
     Trim( to_charD( l_sq/100,  '99999999999990D99' )) || '~' ||
     -- Сбербанк: значение переменной OFSummLit = пусто, если валюта = гривна
     Iif_S(getglobaloption('BANKTYPE'), 'SBER',
           F_SumPr(l_sq, 980, 'F'),
           Iif_S(l_kv, gl.baseval, F_SumPr(l_sq, 980, 'F'), null, F_SumPr(l_sq, 980, 'F')),
           F_SumPr(l_sq, 980, 'F' )) || '~' ||
     Trim( to_charD( l_sq2/100, '99999999999990D99' )) || '~' ||
     F_SumPr( l_sq2, 980, 'F' ) || '~' ||
     to_char( l_user_id )  || '~' ||
     Replace( szUserName, '~', '`' ) ;
  lszVals := lszVals  || '~' ||
     Replace( l_nam_b,  '~', '`' ) || '~' ||
     Replace( l_bank_b, '~', '`' ) || '~' ||
     l_mfob   || '~' ||
     l_id_b   || '~' ||
     l_nlsb   || '~' ||
     szISOCCode2 || '~' ||
     to_char( l_kv2 ) || '~' ||
     Trim( to_charD( l_s2/Power(10,nDig2), '9999999999999990D'||rpad('9',nDig2,'9') )) || '~' ||
     F_SumPr( l_s2, l_kv2, 'F') || '~' ||
     Replace( l_nazn, '~', '`' )  || '~' ||
     Replace( szPayer, '~', '`' ) || '~' ||
     szPayerOKPO || '~' ||
     Replace( szPayer2, '~', '`' ) || '~' ||
     szZvitDate  || '~' ||
     Replace( szDoc, '~', '`' ) || '~' ||
     Replace( szDocProp, '~', '`' ) || '~' ||
     szCashSymb || '~' ||
     Replace( szBoss, '~', '`' )   || '~' ||
     Replace( szAccMan, '~', '`' ) || '~' ||
     Replace( szPmtDet, '~', '`' ) || '~' ||
     Replace( szPayerAdres, '~', '`' ) || '~' ||
     Replace( szPayerBD, '~', '`' ) || '~' ||
     Trim( to_charD( l_s_bs/Power(10,nDig), '9999999999999990D'||rpad('9',nDig,'9') )) || '~' ||
     to_char( l_pdat, 'dd/MM/yyyy hh24:mi:ss' ) || '~' ||
     to_char( l_pdat, 'hh24:mi:ss' ) || '~' ||
     Trim( to_charD( l_sqv/100,  '99999999999990D99' )) || '~' ||
     F_SumPr( l_sqv, 980, 'F' ) || '~' ||
     Trim( to_charD( l_sqv2/100, '99999999999990D99' )) || '~' ||
     F_SumPr( l_sqv2, 980, 'F') || '~' ||
     l_nlsa_a || '~' ||
     Replace( l_nmsa_a, '~', '`' ) || '~' ||
     l_nlsb_a || '~' ||
     Replace( l_nmsb_a, '~', '`' ) || '~' ||
     Trim( to_char( nRatO, '999999999990D9999' )) || '~' ||
     Trim( to_char( nRatB, '999999999990D9999' )) || '~' ||
     Trim( to_char( nRatS, '999999999990D9999' )) || '~' ||
     Trim( to_char( nRatOV,'999999999990D9999' )) || '~' ||
     Trim( to_char( nRatBV,'999999999990D9999' )) || '~' ||
     Trim( to_char( nRatSV,'999999999990D9999' )) || '~' ||
     Trim( to_char( nRat1, '999999999990D9999' )) || '~' ||
     Trim( to_char( nRat2, '999999999990D9999' )) ;
  lszVals := lszVals || '~' ||
     Trim( to_char( nRatO980A, '999999999990D9999' )) || '~' ||
     Trim( to_char( nRatB980A, '999999999990D9999' )) || '~' ||
     Trim( to_char( nRatS980A, '999999999990D9999' )) || '~' ||
     Trim( to_char( nRatOV980A,'999999999990D9999' )) || '~' ||
     Trim( to_char( nRatBV980A,'999999999990D9999' )) || '~' ||
     Trim( to_char( nRatSV980A,'999999999990D9999' )) || '~' ||
     Trim( to_char( nRatO980B, '999999999990D9999' )) || '~' ||
     Trim( to_char( nRatB980B, '999999999990D9999' )) || '~' ||
     Trim( to_char( nRatS980B, '999999999990D9999' )) || '~' ||
     Trim( to_char( nRatOV980B,'999999999990D9999' )) || '~' ||
     Trim( to_char( nRatBV980B,'999999999990D9999' )) || '~' ||
     Trim( to_char( nRatSV980B,'999999999990D9999' ))  ;

exception
  when err then
     bars_error.raise_error('TIC', ern, par1);
end getListAttr;

--***************************************************************--
-- PROCEDURE  : init_static
-- DESCRIPTION  : Инициализация статических значений атрибутов
--***************************************************************--
procedure init_static(nRecID    number, -- Реф. документа
                      szTabName varchar2 default 'OPER', -- Имя таблицы (OPER-внутр.док., ARC_RRP)
                      nMode     number default 0 -- пока не исп.
                      ) is
  l_idx     number := 1;
  l_var_pos number;
  l_var_str varchar2(100);
  l_val_pos number;
  l_val_str varchar2(4000);

  l_static_vars varchar2(4000); -- список переменных
  l_static_vals varchar2(4000); -- список значений
begin
  -- сбрасываем параметры на первоначальные
  g_static_attrs.delete();
  g_static_recid   := nRecID;
  g_static_tabname := szTabName;
  g_static_mode    := nMode;

  -- вызов основной процедуры
  getListAttr(g_static_recid,
              g_static_tabname,
              g_static_mode,
              g_static_ticname,
              l_static_vars,
              l_static_vals,
              g_static_tt,
              g_static_ext_ref);

  -- добавляем фмктивный разделитель в конец,
  -- чтоб не делать отдельной ветки для обработки последнего параметра
  l_static_vars := g_str_separator || l_static_vars || g_str_separator;
  l_static_vals := g_str_separator || l_static_vals || g_str_separator;

  -- разбор результата и формирование масива
  loop
    l_var_pos := instr(l_static_vars, g_str_separator, 1, l_idx);
    l_val_pos := instr(l_static_vals, g_str_separator, 1, l_idx);

    -- выходим если закончился символ разделителя
    exit when(l_var_pos = 0 or l_val_pos = 0 or
              l_var_pos = length(l_static_vars) or
              l_val_pos = length(l_static_vals));

    -- разделитель найден - обрабарываем значение
    l_var_str := substr(l_static_vars,
                        l_var_pos + 1,
                        instr(l_static_vars, g_str_separator, 1, l_idx + 1) -
                        l_var_pos - 1);
    l_val_str := substr(l_static_vals,
                        l_val_pos + 1,
                        instr(l_static_vals, g_str_separator, 1, l_idx + 1) -
                        l_val_pos - 1);
    l_idx     := l_idx + 1;

    -- сохраняем только непустые значения
    if (l_val_str is not null) then
      g_static_attrs(l_var_str) := l_val_str;
    end if;
  end loop;
end init_static;

--***************************************************************--
-- PROCEDURE  : get_static_attr
-- DESCRIPTION  : Получение значения атрибута из статического масива
--***************************************************************--
  function get_static_attr(p_var     in varchar2, -- Имя атрибута
                           p_recid   in number,
                           p_tabname in varchar2 default 'OPER', -- Имя таблицы (OPER-внутр.док., ARC_RRP)
                           p_mode    in number default 0 -- пока не исп.
                           ) return varchar2 is
  begin
    -- проверка ключевых параметров
    if (g_static_recid is null or p_recid != g_static_recid) then
      init_static(p_recid, p_tabname, p_mode);


    end if;

    -- если параметр не найден, то возвращаем null
    if (g_static_attrs.exists(p_var)) then
      return g_static_attrs(p_var);
    else
      return null;
    end if;
  end get_static_attr;
end tic;
/
 show err;
 
PROMPT *** Create  grants  TIC ***
grant EXECUTE                                                                on TIC             to ABS_ADMIN;
grant EXECUTE                                                                on TIC             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on TIC             to BASIC_INFO;
grant EXECUTE                                                                on TIC             to RPBN001;
grant EXECUTE                                                                on TIC             to START1;
grant EXECUTE                                                                on TIC             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/tic.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 