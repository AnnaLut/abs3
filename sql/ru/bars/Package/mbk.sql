
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mbk.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MBK IS

--***************************************************************--
--                 Package MBK
--          (C) Unity-BARS 2000-2006
--***************************************************************--

MBK_HEAD_VERS  CONSTANT VARCHAR2(64)  := 'version 52 12.12.2014';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

----------------------------------------------------------------------
PROCEDURE RO_deal (
  CC_ID_NEW varchar2,
  ND_       int     ,
  ND_NEW    OUT int ,
  ACC_NEW   OUT int ,
  nID_      int     ,
  nKV_      int     ,
  NLS_OLD   varchar2,
  NLS_NEW   varchar2,
  NLS8_NEW  varchar2,
  nS_OLD    number  ,
  nS_NEW    number  ,
  nPR_OLD   number  ,
  nPR_NEW   number  ,
  DATK_OLD  date    ,
  DATK_NEW  date    ,
  DATN_OLD  date    ,
  DATN_NEW  date    ,
  NLSB_NEW  varchar2,
  MFOB_NEW  varchar2,
  NLSNB_NEW varchar2,
  MFONB_NEW varchar2,
  REFP_NEW  number,
  BICA_     varchar2,
  SSLA_     varchar2,
  BICB_     varchar2,
  SSLB_     varchar2,
  AltB_     varchar2,
  IntermA_  varchar2,
  IntermB_  varchar2,
  IntPartyA_  varchar2,
  IntPartyB_  varchar2,
  IntIntermA_ varchar2,
  IntIntermB_ varchar2,
  IntAmount_  number );

----------------------------------------------------------------------
Function F_NLS_MB(
  nbs_    in  varchar2,
  rnk_    in  int,
  ACRB_   in  int,
  kv_     in  int,
  maskid_ varchar2 ) return varchar2;

----------------------------------------------------------------------
PROCEDURE inp_deal (
  CC_ID_ varchar2, nVidd_ int    ,
  nTipd_ int     , nKV_   int    , RNKB_  int,
  DAT2_  date    , p_datv date   , DAT4_  date,
  IR_    number  , OP_    number , BR_    number,
  SUM_   number  , nBASEY_  int  , nIO_   int,
  S1_    varchar2, S2_   varchar2, S3_    varchar2, S4_   varchar2, S5_ number,
  NLSA_  varchar2, NMS_  varchar2, NLSNA_ varchar2, NMSN_ varchar2,
  NLSNB_ varchar2, NMKB_ varchar2, Nazn_  varchar2,
  NLSZ_  varchar2, nKVZ_ int     , p_pawn number,   Id_DCP_ int,
  S67_   varchar2, nGrp_ int     , nIsp_ int   ,
  BICA_  varchar2, SSLA_ varchar2, BICB_ varchar2, SSLB_ varchar2,
  SUMP_  number,
  AltB_  varchar2, IntermB_ varchar2,
  IntPartyA_ varchar2, IntPartyB_ varchar2, IntIntermA_ varchar2, IntIntermB_ varchar2,
  ND_    out int , ACC1_ out int , sErr_ out  varchar2) ;

----------------------------------------------------------------------
procedure set_field58d (p_nd number, p_field58d varchar2);

----------------------------------------------------------------------
PROCEDURE del_deal (ND_ int)  ;

----------------------------------------------------------------------
PROCEDURE clos_deal (ND_ int)  ;

----------------------------------------------------------------------
PROCEDURE del_Ro_deal (ND_ int)  ;

----------------------------------------------------------------------
FUNCTION F_GetNazn(MaskId_ varchar2, ND_ number) return varchar2;

----------------------------------------------------------------------
-- set_deal_param
--
--    Процедура установки значения параметра сделки
--
--
procedure set_deal_param (
  p_nd    nd_txt.nd%type,
  p_tag   nd_txt.tag%type,
  p_val   nd_txt.txt%type );

----------------------------------------------------------------------
-- get_deal_param
--
--    Функция возвращает значение параметра сделки
--
--
function get_deal_param (
  p_nd    nd_txt.nd%type,
  p_tag   nd_txt.tag%type) return varchar2;

----------------------------------------------------------------------
-- get_print_value
--
--    Процедура определяет списки переменных и их значений для печати тикета сделки
--
--
procedure get_print_value (
  p_nd         number,
  p_tic_name   varchar2,
  p_vars   out varchar2,
  p_vals   out varchar2 );

----------------------------------------------------------------------
-- SAVE_PARTNER_TRACE()
--
--    Процедура сохраняет информацию о трассе и посреднике
--
procedure save_partner_trace(
  p_custCode   in cc_swtrace.rnk%type,
  p_currCode   in cc_swtrace.kv%type,
  p_swoBic     in cc_swtrace.swo_bic%type,
  p_swoAcc     in cc_swtrace.swo_acc%type,
  p_swoAlt     in cc_swtrace.swo_alt%type,
  p_intermb    in cc_swtrace.interm_b%type,
  p_field58d   in cc_swtrace.field_58d%type,
  p_nls        in cc_swtrace.nls%type );

----------------------------------------------------------------------
-- unlink_dcp
--
--    Процедура отвязки залога ДЦП
--
procedure unlink_dcp(p_nd number);

----------------------------------------------------------------------
-- link_deal
--
--    Процедура привязки договоров
--
procedure link_deal (p_nd number, p_ndi number);

----------------------------------------------------------------------
-- link_nd_ref
--
--    Процедура привязки документа к договору
--
procedure link_nd_ref (p_nd number, p_ref number);

----------------------------------------------------------------------
-- link_docs
--
--    Процедура привязки документов к договорам
--
procedure link_docs (p_dat date);

----------------------------------------------------------------------
/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2;

----------------------------------------------------------------------
---
-- перевірка, чи відноситься угода до функціональності Кредитних ресурсів
---
function is_credit_source_deal(
    p_deal_kind in integer)
return boolean;

------------------------------------------------------------------
---
-- параметри розрахунку процентів для Кредитних ресурсів
---
    function get_proc_dr_credit_source(
        p_balance_account in varchar2,
        p_customer_id in integer)
    return proc_dr%rowtype;
END mbk;
/
CREATE OR REPLACE PACKAGE BODY BARS.MBK IS

MBK_BODY_VERS  CONSTANT VARCHAR2(64)  := 'version 74.1 26.05.2016';

G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := '     - без учета количества договоров по кред.        '||chr(10)||
                                          'OB22 - Сбербанк мультимфо - ведение specparam_int.OB22';
/*
12.05.2016 BAA - змінено логіку вставки параметру ВКР при створенні договору
29.09.2015 Sta - Добавлены доп.рекв при создании договора = PROCEDURE inp_deal
                 VNCRR Поточний ВКР            \
                 VNCRP Поточний=Первинний ВКР  / из карточки кл.
12.12.2014 Artem Yurchenko Изменил способ определения операции начисления процентов по
           кредитным ресурсам
24.11.2014 Artem Yurchenko Изменил способ определения операции оплаты процентов по кредитным ресурсам

21.03.2014 qwa убрала параметр компиляции GOU за ненадобностью (перешли на ммфошную схему)

30.09.2013 qwa автоматическая установка спецпараметра S180 (только 1 класс)
               при вводе новой сделки и пролонгации, вместе с
               Fs180_DEF.fnc от 27-09-2013, FS180.fnc от 30-09-2013

10.07.2013 qwa 03.07.2013 qwa Надра, фининституты (используем косвенно вьюшку
                              mbd_k_fi )
                              свои варианты назначений платежа
                              patch179.ndr.mbk

28.11.2012 qwa Новый параметр компиляции GOU (дополнение к OB22, без KF)
           добавила логическое условие в блоке по параметрам OB22+GOU -
           только для договора похожего на 39 -- потом его отменили
*/

    DEAL_KIND_CRED_SOUR_LOAN    constant integer := 3902;
    DEAL_KIND_CRED_SOUR_DEPOSIT constant integer := 3903;
    FUNDS_SOURCE_OWN            constant integer := 4; -- Самостійно залучені кошти cc_source.sour%type
------------------------------------------------------------------
-- RO_deal
--
--    Rollover/пролонгация
--
--
PROCEDURE RO_deal (
  CC_ID_NEW varchar2,     /* новый номер тикета    */
  ND_       int     ,     /* старый ND             */
  ND_NEW    OUT int ,     /* новый ND для ролловер */
  ACC_NEW   OUT int ,     /* ACC нового счета      */
  nID_      int     ,
  nKV_      int     ,
  NLS_OLD   varchar2,
  NLS_NEW   varchar2,
  NLS8_NEW  varchar2,
  nS_OLD    number  ,
  nS_NEW    number  ,
  nPR_OLD   number  ,
  nPR_NEW   number  ,
  DATK_OLD  date    ,
  DATK_NEW  date    ,
  DATN_OLD  date    ,
  DATN_NEW  date    ,
  NLSB_NEW  varchar2,
  MFOB_NEW  varchar2,
  NLSNB_NEW varchar2,
  MFONB_NEW varchar2,
  REFP_NEW  number,
  BICA_     varchar2,
  SSLA_     varchar2,
  BICB_     varchar2,
  SSLB_     varchar2,
  AltB_     varchar2,
  IntermA_  varchar2,
  IntermB_  varchar2,
  IntPartyA_  varchar2,
  IntPartyB_  varchar2,
  IntIntermA_ varchar2,
  IntIntermB_ varchar2,
  IntAmount_  number ) IS

  ACC_OLD  int;  RNK_  int;  VIDD_ int    ;  NMK_   varchar2(38) ;
  ACRA_OLD int;  n_    int;  DAT2_ date   ;  sTXT_  varchar2(250);
  ACRA_NEW int;  GRP_  int;  TIP_  char(3);
  KPROLOG_ int;  ISP_  int;  D020_ char(2);  cc_id_ varchar2(20) ;
  NLSB_OLD varchar2(34);     NLSNB_OLD varchar2(34);
  MFOB_OLD varchar2(12);     MFONB_OLD varchar2(12);
  REFP_OLD number;           nG67_     number;
  ACC_SS int; /* асс ссудного счета для опредения наличия залога*/
  ACC_ZAL int;/* acc счета залога*/
  l_s180 specparam.s180%type;

BEGIN

  ACC_NEW := to_number(NUll) ;
  VIDD_   := to_number(substr(NLS_NEW ,1,4));

  BEGIN
     -- реквизиты старой сделки
     SELECT d.cc_id,   a.bDATE,   d.KPROLOG, c.RNK, c.nmkk, a.accs,
            a.acckred, a.mfokred, a.accperc, a.mfoperc,  a.refp
       INTO cc_id_ ,   DAT2_  ,   KPROLOG_,  RNK_, NMK_, ACC_OLD,
            NLSB_OLD,  MFOB_OLD,  NLSNB_OLD, MFONB_OLD,  REFP_OLD
       FROM cc_deal d,  customer c , cc_add a
      WHERE d.nd=ND_ AND d.rnk=c.rnk AND a.nd=d.nd AND a.adds=0 ;

     SELECT acra INTO ACRA_OLD FROM int_accn
      WHERE acc=ACC_OLD AND id=nID_ AND acra is not null ;

     IF nvl(CC_ID_NEW, cc_id_) = cc_id_ and DATN_NEW = DAT2_ THEN
        --старая сделка (не ролловер, а пролонгация), просто меняем  реквизиты сделки
        UPDATE cc_deal
           SET KPROLOG=KPROLOG +1, vidd=VIDD_, limit= nS_NEW, wdate=DatK_NEW
         WHERE nd= ND_;
        ND_NEW := ND_;
     ELSE
        -- новая сделка-клон (ролловер)
        SELECT s_cc_deal.nextval into ND_NEW  FROM dual ;
        INSERT INTO cc_deal d (nd, vidd, rnk, d.user_id, cc_id, sos, wdate, sdate, limit, kprolog)
        SELECT ND_NEW, VIDD_, rnk, gl.aUID, CC_ID_NEW, 10, DatK_NEW, gl.BDATE, nS_NEW, 0
          FROM cc_deal WHERE nd=ND_;

        INSERT INTO cc_add (
          nd,    adds, s, kv, bdate, wdate, sour, acckred, mfokred, freq, accperc, mfoperc, refp, int_amount,
          swi_bic, swi_acc, swi_ref, swo_bic, swo_acc, swo_ref, alt_partyb, interm_b,
          int_partya, int_partyb, int_interma, int_intermb )
        SELECT
          ND_NEW, 0,   s, kv, bdate, wdate, sour, acckred, mfokred, freq, accperc, mfoperc,refp, int_amount,
          swi_bic, swi_acc, null, swo_bic, swo_acc, null, alt_partyb, interm_b,
          int_partya, int_partyb, int_interma, int_intermb
        FROM cc_add WHERE nd=ND_ AND adds=0;

        insert into nd_acc (nd,acc) select ND_NEW, acc from nd_acc where nd=ND_;
     END IF;
  EXCEPTION WHEN NO_DATA_FOUND THEN return;
  END;

  IF NLS_OLD <> NLS_NEW THEN   -- другой балансовый счет
     BEGIN
        -- Счет уже открыт
        SELECT acc, tip INTO ACC_NEW, TIP_ FROM accounts WHERE nls=NLS_NEW and kv=nKv_;
        -- привязываем его к сделке
        INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW,ACC_NEW);
        BEGIN
           -- Счет Нач.%% открыт
           SELECT acc INTO ACRA_NEW FROM accounts WHERE nls=NLS8_NEW and kv=nKv_;
           -- привязываем его к сделке
           INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW,ACRA_NEW);
        EXCEPTION WHEN NO_DATA_FOUND THEN
           -- Счет Нач.%% не открыт, открываем (Op_reg(1, ...) - c insert into nd_acc)
           IF ACRA_OLD > 0 THEN
              SELECT tip into TIP_ from accounts where acc=ACRA_OLD;
           END IF;
           Op_Reg_ex(1,ND_NEW,n_,GRP_,n_,RNK_,NLS8_NEW,nKv_,NMK_,TIP_,ISP_,ACRA_NEW,
              '1',null,null,
              null);   --  KB pos=1
           p_setAccessByAccmask(ACRA_NEW,ACC_NEW);
           BEGIN
              INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW,ACRA_NEW);
           EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
           END;
        END;
     EXCEPTION WHEN NO_DATA_FOUND THEN
        -- открываем счет
        BEGIN
           SELECT grp, isp, tip INTO GRP_, ISP_, TIP_
             FROM accounts WHERE acc=ACC_OLD;
           Op_Reg_ex(1,ND_NEW,n_,GRP_,n_,RNK_,NLS_NEW,nKv_,NMK_,TIP_,ISP_,ACC_NEW,
              '1',null,null,
            null);   --  KB pos=1
           p_setAccessByAccmask(ACC_NEW,ACC_OLD);
           BEGIN
              INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW, ACC_NEW);
              If TIP_= 'SS ' THEN
                 INSERT INTO cc_accp(ACC, ACCS, nD)
                 SELECT acc, ACC_NEW, nd FROM cc_accp WHERE accs=ACC_OLD ;
              END IF;
           EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
           END;
           -- открываем счет Нач.%%
           IF ACRA_OLD > 0 THEN
             SELECT tip INTO TIP_ FROM accounts WHERE acc=ACRA_OLD;
           END IF;
           Op_Reg_ex(1,ND_NEW,n_,GRP_,n_,RNK_,NLS8_NEW,nKv_,NMK_,TIP_,ISP_,ACRA_NEW,
              '1',null,null,
              null);   --  KB pos=1
           p_setAccessByAccmask(ACRA_NEW,ACC_NEW);
           BEGIN
              INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW,ACRA_NEW);
           EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
           END;
        EXCEPTION WHEN NO_DATA_FOUND THEN  return;
        end;
     end;
     /* Для сделок с залогами, по которым пролонгация (не ролл) */
     /* Привязка к новому счету старого залога*/
     acc_ss:=ACC_OLD;
     begin
        /* определим по старому счету текущей сделки наличие залога*/
        /* в данном случае ND_NEW=ND */
        select c.acc,c.accs into acc_zal,acc_ss
          from cc_accp c, pawn_acc p
         where c.acc=p.acc  and c.nd =ND_NEW;
     exception when no_data_found then acc_ss:='0';
     end;
     if acc_ss=ACC_OLD then
        update cc_accp set accs=ACC_NEW where nd=ND_NEW;
     end if;
     /* проверим наличие старых закрытых договоров с залогами по "новому счету"*/
     for k in (select c.nd from cc_accp c,cc_deal d
                where c.accs=ACC_NEW and c.nd<>ND_NEW
                  and c.nd=d.nd  and d.sos=15
                  and c.acc<>ACC_ZAL)
     loop
        delete from cc_accp where nd=k.nd and accs=ACC_NEW;
     end loop;
  ELSE
     ACC_NEW  := ACC_OLD;
     ACRA_NEW := ACRA_OLD;
  END IF;

  if ND_ <> ND_NEW then
     -- перепривязываем залог к новому договору
     update cc_accp set accs = ACC_NEW, nd = ND_NEW where nd = ND_;
     -- отвязываем залоги от старого счета
     delete from cc_accp where accs = ACC_OLD;
  end if;

  -- для остального
  select substr(
    decode(nvl(CC_ID_NEW, cc_id_),cc_id_,
              decode (DATN_NEW,DAT2_,'Змiни:','Змiни-Ролл:'),'Змiни-Ролл:')||
    decode ( nS_OLD  , nS_NEW  , '',
           ' Суми з ' || trim(to_char(nS_OLD*100,'9999999999999,99')) ||
           ' до '     || trim(to_char(nS_NEW*100,'9999999999999,99')) || '. ') ||
    decode ( nPr_OLD , nPr_NEW , '',
           ' % Ст. з '|| nPr_OLD ||
           ' до '     || nPr_NEW || '. ') ||
    decode ( DatK_OLD, DatK_NEW, '',
           ' Строку з ' || to_char(DatK_OLD,'dd/MM/yyyy') ||
           ' до '       || to_char(DatK_NEW,'dd/MM/yyyy') || '. ') ||
    decode ( NLS_OLD , NLS_NEW , '',
           ' Рахунку з ' || Nls_OLD ||
           ' на '        || NLS_NEW || '.') ||
    decode ( NLSB_OLD , NLSB_NEW , '',
           ' Рахунку осн. партнера з ' || NLSB_OLD || ' (МФО ' || MFOB_OLD || ')' ||
           ' на '                      || NLSB_NEW || ' (МФО ' || MFOB_NEW || ').') ||
    decode ( NLSNB_OLD , NLSNB_NEW , '',
           ' Рахунку нар.% партнера з '|| NLSNB_OLD || ' (МФО ' || MFONB_OLD || ')' ||
           ' на '                      || NLSNB_NEW || ' (МФО ' || MFONB_NEW || ').')
    , 1,250)
  into sTXT_  from dual ;

  BEGIN
     INSERT INTO cc_prol(nd,npp, FDAT, MDATE, TXT, ACC)
     VALUES(ND_NEW,KPROLOG_, gl.bdate, DatK_NEW, sTXT_, ACC_OLD);
  EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
  END;

  If DATK_OLD <> DATK_NEW OR ACC_OLD <> ACC_NEW then
     UPDATE accounts SET mdate=DatK_NEW, pap=nID_+1 WHERE acc=ACC_NEW;
     UPDATE accounts SET mdate=DatK_NEW
            --, pap=nID_+1            оставим в соотв. с планом счетов
      WHERE acc=ACRA_NEW;
     UPDATE int_accn SET STP_DAT=DatK_NEW-1 WHERE acc=ACC_NEW and id=nID_;
     IF SQL%rowcount = 0 THEN     -- определим контрсчет для проц карточки
        BEGIN
           if to_number(to_char(gl.bdate,'MM'))=to_number(to_char(DatK_NEW-1,'MM')) then
              select f_proc_dr(s.rnk, 4,0,'MKD',s.Vidd,a.KV) into nG67_   -- непереходящие
                from cc_deal s,cc_add a where s.nd=ND_NEW and s.nd=a.nd;
	   else
	      select f_proc_dr(s.rnk ,4,0,'MKD',s.Vidd,a.KV) into nG67_  -- переходящие
                from cc_deal s,cc_add a where s.nd=ND_NEW and s.nd=a.nd;
           end if;
        EXCEPTION WHEN NO_DATA_FOUND THEN
           nG67_ := null;
        END;
        INSERT INTO int_accn (ACC, ID, METR, BASEM, BASEY, FREQ, STP_DAT, ACR_DAT, APL_DAT,
               TT, ACRA, ACRB, S, TTB, KVB, NLSB, MFOB, NAMB, NAZN)
        SELECT ACC_NEW ,nID_,METR, BASEM, BASEY, FREQ, DatK_NEW-1, ACR_DAT, APL_DAT,
               TT, ACRA_NEW, nvl(nG67_,ACRB), S, TTB, KVB, NLSB, MFOB, NAMB, NAZN
          FROM int_accn WHERE acc=ACC_OLD and id = nID_;
     END IF;
  END IF;

  IF nPr_OLD <> nPr_NEW OR ACC_OLD <> ACC_NEW THEN
     UPDATE int_ratn SET IR=nPr_NEW WHERE acc=ACC_NEW AND id=nID_ AND BDAT=gl.BDATE;
     IF SQL%rowcount = 0 THEN
        INSERT INTO int_ratn(ACC, ID, BDAT, IR)
        VALUES (ACC_NEW, nId_, gl.BDATE, nPr_NEW);
     END IF;
  END IF;

  IF ACC_OLD <> ACC_NEW THEN
     DELETE FROM nd_acc WHERE nd=ND_NEW AND acc in (ACC_OLD, ACRA_OLD);
  END IF;

  UPDATE cc_add
  SET accs=ACC_NEW, bdate=DATN_NEW, wdate=DATN_NEW, s=nS_NEW,
      acckred=NLSB_NEW,  mfokred=MFOB_NEW,
      accperc=NLSNB_NEW, mfoperc=MFONB_NEW, refp=REFP_NEW,
      swi_bic    = bica_,
      swi_acc    = ssla_,
      swo_bic    = bicb_,
      swo_acc    = sslb_,
      alt_partyb = altb_,
      interm_b   = intermb_,
      int_partya = intPartyA_,
      int_partyb = intPartyB_,
      int_interma= intIntermA_,
      int_intermb= intIntermB_,
      int_amount = intAmount_
  WHERE nd=ND_NEW and adds=0;

  -- Если порождаем новый договор, то
  If ND_NEW <> ND_ then  D020_ := '01';
  else                   D020_ := '02';
  end if;

  UPDATE specparam set D020 = D020_ where acc = ACC_NEW ;
  if SQL%rowcount = 0 then
     INSERT INTO specparam ( ACC, D020 ) values ( ACC_NEW, D020_ );
  end if;

  -- новый код срока только для 1-го класса
  if vidd_ like '1%' then
     l_s180 := FS180(ACC_NEW, '1', bankdate);
     update specparam set s180 = l_s180 where acc = ACC_NEW;
     if SQL%rowcount = 0 then
        INSERT INTO specparam (ACC, S180) values (ACC_NEW, l_s180);
     end if;
  end if;

END RO_deal;

------------------------------------------------------------------
-- F_NLS_MB
--
--    Функция возвращает номера счетов сделки (30 симв.)
--
--
Function F_NLS_MB (
  nbs_     in varchar2,
  rnk_     in int,
  ACRB_    in int,
  kv_      in int,
  maskid_     varchar2 ) return varchar2  IS

nbsn_ char(4);                         -- БС нач %%
SS_   varchar2(14) := to_char(null);   -- осн счет как результат
SN_   varchar2(14) := to_char(null);   -- предполож нач % как результат
ACRA_ int;
acc_  int;
id_   int;
MASK_ VARCHAR2(10);

  -- 30.08.2010 Sta
  l_INITIATOR   varchar2(2);
BEGIN

  BEGIN

     SELECT nbsn INTO nbsn_ FROM proc_dr WHERE nbs=nbs_ and ROWNUM=1; -- если несколько записей - берем первую

     BEGIN

        IF gl.amfo = '300001' THEN

           --Только для НБУ
           MASK_ := NVL( maskid_, 'MBK');
           IF MASK_ = 'MBK' THEN
              -- вот он свободный  SS_
              SELECT a.nls, a.acc, a.pap-1
                INTO SS_,   acc_,  id_
                FROM accounts a, int_accn i, accounts n
               WHERE a.acc = i.acc   AND a.kv   = kv_  AND a.nbs  = nbs_
                 AND a.rnk = rnk_    AND a.ostc = 0
                 AND a.ostb=0        AND a.ostf = 0    AND i.acra = n.acc
                 AND n.ostc=0        AND n.ostb = 0    AND n.ostf = 0
                 AND (a.mdate < gl.BDATE OR a.mdate IS NULL) AND a.dazs is null
                 AND (n.mdate < gl.BDATE OR n.mdate IS NULL) AND n.dazs is null
                 AND (i.acrb  = ACRB_ or ACRB_ = 0)
                 AND ROWNUM=1
                 AND substr(a.nls,10,1)<>'5'
               ORDER BY substr(a.nls,6,9) ;
           ELSE
              SELECT a.nls, a.acc, a.pap-1
                INTO SS_,   acc_,  id_
                FROM accounts a, int_accn i, accounts n
               WHERE a.acc  = i.acc  AND a.kv   = kv_  AND a.nbs =nbs_
                 AND a.rnk  = rnk_   AND a.ostc = 0
                 AND a.ostb = 0      AND a.ostf = 0    AND i.acra=n.acc
                 AND n.ostc = 0      AND n.ostb = 0
                  AND n.ostf=0
                 AND (a.mdate < gl.BDATE OR a.mdate IS NULL) AND a.dazs is null
                 AND (n.mdate < gl.BDATE OR n.mdate IS NULL) AND n.dazs is null
                 AND (i.acrb  = ACRB_ or ACRB_ = 0)
                 AND ROWNUM=1
                 AND substr(a.nls,10,1)='5'
               ORDER BY substr(a.nls,6,9) ;
           END IF;

        ELSE

           -- Не НБУ !!!
           if nbs_ like '39%' then  MASK_ := 'MFK';
           else                     MASK_ := 'MBK';
           end if;

           -- 30.08.2010 Sta
           -- только для ГОУ ОБ

           l_INITIATOR := substr( pul.Get_Mas_Ini_Val('INITIATOR'), 1, 2 );

           If gl.aMfo = '300465' and l_INITIATOR is not null then

              EXECUTE IMMEDIATE
             'SELECT a.acc
                FROM accounts a, int_accn i, accounts n,
                     (select acc from SPECPARAM_CP_OB where INITIATOR ='''|| l_INITIATOR || ''') o
               WHERE a.acc= o.acc (+)
                 and a.acc  = i.acc
                 AND a.kv   = '  || kv_  || '
                 AND a.nbs  = '''|| nbs_ || '''
                 AND a.rnk  = '  || rnk_ || '
                 AND a.ostc = 0 AND a.ostb = 0 AND a.ostf = 0
                 AND n.ostc = 0 AND n.ostb = 0 AND n.ostf = 0
                 AND i.acra = n.acc
                 AND (a.mdate < gl.BD OR a.mdate IS NULL) AND a.dazs is null
                 AND (n.mdate < gl.BD OR n.mdate IS NULL) AND n.dazs is null
                 and (a.dapp is null or a.dapp < bankdate-10)
                 and (n.dapp is null or n.dapp < bankdate-10)
                 AND ROWNUM=1 ' into ACC_ ;

              SELECT nls,pap-1  INTO SS_, id_ FROM accounts where acc=ACC_;

           else

              -- Для всех других банков
              -- вот он свободный  SS_
              SELECT a.nls, a.acc, a.pap-1
                INTO SS_,   acc_,  id_
                FROM accounts a, int_accn i, accounts n
               WHERE a.acc  = i.acc
                 AND a.kv   = kv_
                 AND a.nbs  = nbs_
                 AND a.rnk  = rnk_
                 AND a.ostc = 0 AND a.ostb = 0 AND a.ostf = 0
                 AND n.ostc = 0 AND n.ostb = 0 AND n.ostf = 0
                 AND i.acra = n.acc
                 AND (a.mdate < gl.BDATE OR a.mdate IS NULL) AND a.dazs is null
                 AND (n.mdate < gl.BDATE OR n.mdate IS NULL) AND n.dazs is null
                 and (a.dapp is null or a.dapp < bankdate-10)
                 and (n.dapp is null or n.dapp < bankdate-10)
                 AND ROWNUM=1 ;

           end if;

        END IF ;

        -- а как его счет  SN ?
        SELECT a.nls, i.acra  INTO SN_, acra_  FROM int_accn i, accounts a
        WHERE i.acc=acc_ AND i.id=id_ AND i.acra=a.acc AND a.dazs is null;

     exception when NO_DATA_FOUND THEN

        -- увы, нет --смоделируем следующий (первый) новый
        SS_ := F_NEWNLS2(null, MASK_, nbs_ , RNK_,null);
        SN_ := F_NEWNLS2(null, MASK_, nbsn_, RNK_,null);

     END;

     IF gl.amfo = '300001' THEN
        SN_ := VKRZN(substr(gl.aMFO,1,5),nbsn_||substr(SS_,5,10)) ;
     END IF;

  exception when NO_DATA_FOUND THEN null;
  end;

  return (substr(SS_||'               ', 1, 15) ||
          substr(SN_||'               ', 1, 15)
         );

END F_NLS_MB ;

------------------------------------------------------------------
---
-- перевірка, чи відноситься угода до функціональності Кредитних ресурсів
---
    function is_credit_source_deal(
        p_deal_kind in integer)
    return boolean
    is
    begin
        return p_deal_kind in (DEAL_KIND_CRED_SOUR_LOAN, DEAL_KIND_CRED_SOUR_DEPOSIT);
    end;

------------------------------------------------------------------
---
-- визначення банківських параметрів клієнта
---
    function read_custbank(
        p_customer_id in integer,
        p_raise_ndf in boolean default true)
    return custbank%rowtype
    is
        l_custbank_row custbank%rowtype;
    begin
        select *
        into   l_custbank_row
        from   custbank c
        where  c.rnk = p_customer_id;

        return l_custbank_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Банківські параметри для клієнта з ідентифікатором {' || p_customer_id || '} не знайдені');
             else return null;
             end if;
    end;

------------------------------------------------------------------
---
-- параметри розрахунку процентів для Кредитних ресурсів
---
    function get_proc_dr_credit_source(
        p_balance_account in varchar2,
        p_customer_id in integer)
    return proc_dr%rowtype
    is
        l_custbank_row custbank%rowtype;
    begin

        l_custbank_row := read_custbank(p_customer_id, p_raise_ndf => false);

        for i in (select *
                  from   proc_dr dr
                  where  dr.nbs = p_balance_account and
                         dr.sour = FUNDS_SOURCE_OWN and
                         (dr.rezid = l_custbank_row.mfo or dr.rezid = 0 or dr.rezid is null)
                  order by case when dr.rezid = l_custbank_row.mfo then 0
                                else 1
                           end) loop
            return i;
        end loop;

        return null;
    end;

------------------------------------------------------------------
-- inp_deal
--
--    Ввод новой сделки
--
--
PROCEDURE inp_deal (
  CC_ID_      varchar2,   -- N тикета/договора
  nVidd_      int,        -- Вид договора
  nTipd_      int,        -- Тип договора
  nKV_        int,        -- Валюта
  RNKB_       int,        -- Рег.№ партнера
  DAT2_       date,       -- дата сделки
  p_datv      date,       -- дата валютирования
  DAT4_       date,       -- дата окончания
  IR_         number,     -- индив ставка
  OP_         number,     -- арифм.знак
  BR_         number,     -- базовая ставки
  SUM_        number,     -- Сумма сделки (в руб.)
  nBASEY_     int,        -- % база
  nIO_        int,        -- Начисление на входящий остаток 1-Да/0-Нет
  S1_         varchar2,   -- Осн.Счет для банка Б
  S2_         varchar2,   -- Код банка Б (mfo/bic) для осн.сч
  S3_         varchar2,   -- Счет нач.% для банка Б
  S4_         varchar2,   -- Код банка Б (mfo/bic) для сч нач.%
  S5_         number,     -- Счет для входа валюты
  NLSA_       varchar2,   -- Основной счет в нашем банке
  NMS_        varchar2,   -- Наименование основного счета
  NLSNA_      varchar2,   -- Счет начисленных % в нашем банке
  NMSN_       varchar2,   -- Наименование счета начисленных %
  NLSNB_      varchar2,   -- Счет нач.% для банка Б = S3_
  NMKB_       varchar2,   -- Наименование клиента
  Nazn_       varchar2,   -- Назначение платежа (% по дог. CC_ID)
  NLSZ_       varchar2,   -- Счет обеспечения
  nKVZ_       int,        -- Валюта обеспечения
  p_pawn      number,     -- код вида обеспечения
  Id_DCP_     int,        -- Id from dcp_p.id
  S67_        varchar2,   -- Счет доходов
  nGrp_       int,        -- Группа доступа счетов
  nIsp_       int,        -- Исполнитель
  BICA_       varchar2,   -- BIC нашего банка
  SSLA_       varchar2,   -- Счет VOSTRO у нашего банка-корреспонд
  BICB_       varchar2,   -- BIC партнера
  SSLB_       varchar2,   -- Счет VOSTRO партнера у его банка-корресп
  SUMP_       number,     -- Сумма %%
  AltB_       varchar2,
  IntermB_    varchar2,
  IntPartyA_  varchar2,
  IntPartyB_  varchar2,
  IntIntermA_ varchar2,
  IntIntermB_ varchar2,
  ND_         out int,
  ACC1_       out int,
  sErr_       out varchar2
) IS
  sTTA_ char(3); sTTB_ char(3); Tip1_ char(3) ; Tip2_ char(3);
  ACC2_ int    ; ACC3_  int   ; ACC4_  int    ;
  nID_  int    ; nUser_ int   ; nTmp_  int    ; V_ZAL_ int   ;
  l_s180         specparam.s180%type;
  l_initiator    varchar2(2);
  l_ob22         specparam_int.ob22%type;
  l_proc_dr_row  proc_dr%rowtype;
  l_txt          customerw.value%type;
BEGIN

  nUser_ := USER_ID;
  ND_    := null;

  -- счет доходов-расходов
  BEGIN
     SELECT acc INTO ACC3_ FROM accounts
     WHERE kv=gl.baseval and nls=S67_ and dazs is null;
  EXCEPTION WHEN NO_DATA_FOUND THEN sERR_ := 'Не открыт счет '||S67_;  return;
  END;

  SELECT s_cc_deal.nextval into ND_  FROM dual ;
  INSERT INTO cc_deal (nd, vidd, rnk, user_id, cc_id, sos, wdate, sdate, limit, kprolog)
  VALUES (ND_, nVidd_, RNKB_, nUser_, CC_ID_, 10, DAT4_, gl.BDATE, SUM_, 0);

  INSERT INTO cc_add (nd, adds, s, kv, bdate, wdate, sour, acckred, mfokred, freq, accperc, mfoperc, refp,
      swi_bic, swi_acc, swo_bic, swo_acc, int_amount, alt_partyb, interm_b,
      int_partya, int_partyb, int_interma, int_intermb )
  VALUES (ND_, 0, Sum_, nKv_, DAT2_, p_datv, 4, S1_, S2_, 2, S3_, S4_, S5_,
      bica_, ssla_, bicb_, sslb_, sump_, altb_, intermb_,
      IntPartyA_, IntPartyB_, IntIntermA_, IntIntermB_);

  if nTipd_ = 1 then
     nID_ :=0; Tip1_:='SS '; Tip2_:='SN ';
  else nID_ :=1; Tip1_:='DEP'; Tip2_:='DEN';
  end if ;

  -- открытие основного счета
  Op_Reg_ex(1,ND_,nTmp_,nGrp_,nTmp_,RNKB_,NLSA_, nKv_,NMS_, Tip1_,nIsp_,ACC1_, '1', null, null,
     null);  -- KB  pos=1

  -- открытие счета нач.%%
  Op_Reg_ex(1,ND_,nTmp_,nGrp_,nTmp_,RNKB_,NLSNA_,nKv_,NMSN_,Tip2_,nIsp_,ACC2_, '1', null, null,
     null);  -- KB  pos=1

  UPDATE cc_add SET accs=ACC1_ WHERE nd=ND_;

  -- 30.08.2010 Sta
  l_INITIATOR := substr( pul.Get_Mas_Ini_Val('INITIATOR'), 1, 2 );

  If gl.aMfo = '300465' and l_INITIATOR is not null then
     -- Доп.реквизиты счета SS
     EXECUTE IMMEDIATE 'update SPECPARAM_CP_OB set INITIATOR =''' || l_INITIATOR || ''' where acc= '|| ACC1_ ;
     if SQL%rowcount = 0 then
        EXECUTE IMMEDIATE 'insert into SPECPARAM_CP_OB (ACC,INITIATOR) ' ||
                          'values ( ' || ACC1_ || ', '''|| l_INITIATOR || ''' )';
     end if;

     EXECUTE IMMEDIATE 'update SPECPARAM_CP_OB set INITIATOR =''' || l_INITIATOR || ''' where acc= '|| ACC2_ ;
     if SQL%rowcount = 0 then
        EXECUTE IMMEDIATE 'insert into SPECPARAM_CP_OB (ACC,INITIATOR) ' ||
                          'values ( ' || ACC2_ || ', '''|| l_INITIATOR || ''' )';
     end if;
  end if;
  -------------

  IF NLSZ_ is not null then
     -- открытие счета залога
     Op_Reg_ex(2, ND_, p_pawn, 2, nTmp_, RNKB_, NLSZ_, nKVZ_, NMS_, 'ZAL', nIsp_, ACC4_, '1', null, null,
        null);  -- KB  pos=1
     -- проставляем группу доступа для счета залога как для основного счета
     p_setAccessByAccmask(ACC4_, ACC1_);
     insert into nd_acc (nd, acc) values (ND_, ACC4_);
     IF nTipd_ = 1 then
        update cc_accp set nd=ND_ where acc=ACC4_ and accs=ACC1_;
        IF SQL%rowcount = 0 then
           INSERT into cc_accp (ACC,ACCS,nd) values (ACC4_,ACC1_,ND_);
        END IF;
     END IF;
     mbk.set_deal_param(ND_, 'PAWN', to_char(p_pawn));
  END IF;

  IF Id_DCP_ is not null then
     -- обеспечение - ДЦП
     UPDATE dcp_p Set ref=-ND_, acc=ACC1_ WHERE id=Id_DCP_;
  END IF;

  UPDATE accounts SET mdate=DAT4_,PAP=nTipd_ WHERE acc=ACC1_;
  UPDATE accounts SET mdate=DAT4_            WHERE acc=ACC2_;
  UPDATE accounts SET mdate=DAT4_            WHERE acc=ACC4_;
/*
  if substr(nVidd_,1,2) = '39' then

     -- установка ОБ22
     l_ob22 := case when nKV_ = gl.baseval then '02' else '12' end;
     update specparam_int set ob22 = l_ob22 where acc = ACC1_ ;
     if SQL%rowcount = 0 then
        insert into specparam_int (acc, ob22)
        values (ACC1_, l_ob22);
     end if;
     update specparam_int set ob22 = '02' where acc = ACC2_ ;
     if SQL%rowcount = 0 then
        insert into specparam_int (acc, ob22)
        values (ACC2_, '02');
     end if;

     -- проставим спецпараметр МФО (нужно для файлов 32, 33)
     update specparam_int set mfo=S2_ where acc = ACC1_ ;
     if SQL%rowcount = 0 then
        insert into specparam_int (acc, mfo)
        values (ACC1_, S2_);
     end if;
     update specparam_int set mfo=S2_ where acc = ACC2_ ;
     if SQL%rowcount = 0 then
        insert into specparam_int (acc, mfo)
        values (ACC2_, S2_);
     end if;

  end if;
*/
  -- Artem Yurchenko, 24.11.2014
  -- для кредитных ресурсов необходимо использовать другие операции
  if (is_credit_source_deal(nVidd_)) then
      -- установка ОБ22
      l_ob22 := '02';
      account_utl.set_specparam_int(ACC1_, 'OB22', l_ob22);
      account_utl.set_specparam_int(ACC2_, 'OB22', l_ob22);

      -- проставим спецпараметр МФО (нужно для файлов 32, 33)
      account_utl.set_specparam_int(ACC1_, 'MFO', s2_);
      account_utl.set_specparam_int(ACC2_, 'MFO', s2_);

      sTTB_ := 'PS2';

      --операция по начислению проц
      l_proc_dr_row := get_proc_dr_credit_source(to_char(nVidd_, 'FM9999'), rnkb_);
      sTTA_ := case when nKv_ = gl.baseval then l_proc_dr_row.tt
                    else l_proc_dr_row.ttv
               end;
  else
      sTTB_ := case when nKv_ = gl.baseval then 'WD2' else 'WD3' end;

      --операция по начислению проц
      BEGIN
         SELECT val INTO sTTA_ FROM params WHERE par='MBD_%%1';
      EXCEPTION WHEN NO_DATA_FOUND THEN sTTA_ := '%%1';
      END;
      BEGIN
         --резидент-нерезидент
         SELECT decode (codcagent,1, sTTA_, decode(nTipd_,1,'%00','%02') ) INTO sTTA_
           FROM customer WHERE rnk=RNKB_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sERR_ := 'Не найден RNKB '||RNKB_; return;
      END;
  end if;

  UPDATE int_accN
     SET BASEY=nBASEY_,TT=sTTA_,STP_DAT=DAT4_-1,ACRA=ACC2_,ACRB=ACC3_,s=0,IO=nIO_,
         acr_dat=decode(nIO_,1,gl.BDATE,acr_dat)
   WHERE acc=ACC1_ and id=nID_;
  IF SQL%rowcount = 0 then
     INSERT INTO int_accN (acc, ID, metr, basem, BASEY, freq, ACRA, ACRB, KVB, TT, TTB, STP_DAT, s, IO, acr_dat)
     VALUES (ACC1_, nID_, 0, 0, nBASEY_, 1, ACC2_, ACC3_, nKv_, sTTA_, sTTB_, DAT4_-1, 0, nIO_, decode(nIO_,1,gl.BDATE,null));
  END IF;

  IF nID_ = 1 and nKV_=gl.baseval then
     UPDATE int_accN
        Set NLSB=NLSNB_,MFOB=S2_,NAMB=NMKB_,NAZN=Nazn_
      WHERE acc=ACC1_ AND id=1;
  ELSIF nID_ = 1 and nKV_<>gl.baseval then
      if (is_credit_source_deal(nVidd_)) then
          update int_accn
          set    nlsb = substr(nlsnb_, 1, 14),
                 mfob = s2_,
                 namb = nmkb_,
                 nazn = nazn_
           where acc = acc1_ and
                 id = 1;
      else
          UPDATE int_accN
             Set NLSB=substr(NLSNB_,1,14),NAMB=NMKB_,NAZN=Nazn_
           WHERE acc=ACC1_ AND id=1;
      end if;
  END IF;

  update INT_ratn
     SET ir=IR_, op=OP_, br=BR_
   where acc=ACC1_ and id=nID_ and bdat=DAT2_;
  if SQL%rowcount = 0 then
     INSERT INTO INT_ratn (acc  , ID ,bdat ,ir ,op ,br)
     VALUES (ACC1_, nID_, DAT2_, IR_, OP_, BR_);
  end if;

  -- При открытии договора D020 := '01'
  UPDATE specparam set D020 = '01' where acc=ACC1_;
  if SQL%rowcount = 0 then
     INSERT INTO specparam (ACC, D020 ) values ( ACC1_, '01' );
  end if;

  -- новый код срока только для 1-го класса
  if nVidd_ like '1%' then
     l_s180 := FS180(ACC1_, '1', bankdate);
     update specparam set s180 = l_s180 where acc = acc1_;
     if SQL%rowcount = 0 then
        INSERT INTO specparam (ACC, S180) values (ACC1_, l_s180);
     end if;
  end if;

  -- установка параметрів Первинний та Поточний ВКР
  begin
    select VALUE
      into l_txt
      from BARS.CUSTOMERW
     where RNK = RNKB_
       and TAG = 'VNCRR';
  exception
    when NO_DATA_FOUND then
      bars_audit.info( 'mbk.inp_deal: not found "VNCRR" for RNK = ' || to_char(RNKB_) );
      -- raise_application_error(-20666, 'Відсутнє занчення ВКР у клієнта з РНК = '||to_char(RNKB_), true);
  end;

  -- Поточний ВКР
  MBK.SET_DEAL_PARAM( ND_, 'VNCRR', l_txt );

  -- Первинний ВКР
  begin
    -- первинний ВКР не оновлюється тому юзаєм INSERT
    insert
      into BARS.ND_TXT
      ( ND, TAG, TXT )
    values
      ( ND_, 'VNCRP', l_txt );
  exception
    when DUP_VAL_ON_INDEX then
      -- вже був вставлений тригером
      null;
  end;

END inp_deal;

----------------------------------------------------------------------
procedure set_field58d (p_nd number, p_field58d varchar2)
is
begin
  update cc_add set field_58d = p_field58d where nd = p_nd;
end set_field58d;

------------------------------------------------------------------
-- del_deal
--
--    Удаление сделки
--
--
PROCEDURE del_deal (ND_ int ) is
DAT1_ date;
TIPD_ int;
-- удаление ош.введенной сделки
BEGIN
  BEGIN
    select d.SDATE, v.TIPD into DAT1_,TIPD_
    from cc_deal d , cc_vidd v
    where d.nd=ND_ and d.vidd=v.vidd ;
    for k in (select acc from nd_acc where nd=ND_)
    loop
      delete from int_ratn where acc=k.ACC and bdat >=DAT1_;
      update accounts SET mdate = null  where acc=k.Acc
	and acc not in (select acc from mbd_k where nd<>ND_)   -- не сбрасываем дату
	and ostc+ostb=0;                                       -- если счет обслуживает 2 сделки
                                                           -- или ненулевые остатки по счету
    end loop;
    delete from mbd_k_r where nd=ND_ and ref in
                                     (select ref from oper where sos<0);
    DELETE FROM nd_acc  WHERE nd=ND_;
    DELETE FROM cc_add  WHERE nd=ND_;
    DELETE FROM cc_deal WHERE nd=ND_;
    DELETE FROM cc_docs WHERE nd=ND_;
    DELETE FROM cc_accp WHERE nd=ND_;
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  END;
  return;
END del_deal;

------------------------------------------------------------------
-- clos_deal
--
--    Закрытие сделки
--
--
PROCEDURE clos_deal (ND_ int ) is
p_nd   number:=0;
p_sos  number;
-- закрытие сделок на финише дня
BEGIN
  for k in  -- проверка претендентов на закрытие (дата истекла, но не закрыты)
  (select d.ND, d.WDATE, v.TIPD, d.SOS ,p.accs,p.accp ,
          a.ostc ostcs,a.ostb ostbs,a.ostf ostfs,
	  n.ostc ostcp,n.ostb ostbp,n.ostf ostfp,
	  i.acr_dat,a.mdate mdate_a,n.mdate mdate_n
     from cc_deal D, cc_vidd V,cc_add p,accounts a,accounts n,int_accn i
    where (ND_=0 or d.nd=ND_) and d.nd=p.nd
      and d.vidd=v.vidd and v.custtype=1
      and p.adds=0 and  p.accs=a.acc
      AND i.acc=a.acc AND i.acra=n.acc
     and d.sos<15 and d.WDATE <= gl.BDATE)
  LOOP
    /* Готовы ли к закрытию по остаткам на SS SN и дате нач%?   */
    begin  -- определим максимальный номер договора, который обслуживают счета
      select max(nd) into p_nd from nd_acc  where acc in (k.accs,k.accp);
    EXCEPTION WHEN NO_DATA_FOUND THEN p_nd:=0;
    end;
    if ( k.ostcs=0 and k.ostbs=0 and k.ostfs=0
     and k.ostcp=0 and k.ostbp=0 and k.ostfp=0
     and k.acr_dat+1>=k.wdate and k.mdate_a=k.wdate
     and k.mdate_a=k.mdate_n )
    then
          p_sos:=15;
    elsif   -- остатки ненулевые, но счета обслуживают уже новую сделку (возможно Ролловер)
       ( k.ostcs<>0 or k.ostbs<>0 or k.ostfs<>0
      or k.ostcp<>0 or k.ostbp<>0 or k.ostfp<>0 )
     and k.nd <p_nd and k.mdate_a=k.mdate_n and k.mdate_a>k.wdate
    then  p_sos:=15;
    else  p_sos:=k.sos;
    end if;
    update cc_deal set SOS=p_sos where nd=k.ND;
    -- отвязываем счета залога
    if p_sos = 15 then
       for z in ( select acc, accs from cc_accp where nd = k.nd )
       loop
          delete from nd_acc where nd = k.nd and acc in (z.acc, z.accs);
       end loop;
       delete from cc_accp where nd = k.nd;
    end if;
    commit;
  END LOOP;
  return;
END clos_deal;

------------------------------------------------------------------
-- del_Ro_deal
--
--    откат сегодняшней сделки Ролловер
--
--
PROCEDURE del_Ro_deal (ND_ int ) IS
/* откат сегодняшней сделки Ролловер
*/
Ref_      number;
Ref1_     number;
Ref2_     number;
Tipd_     number;
ND_Old_   number;
SDate_    date;
WDate_    date;
Dat1_     date;
par2_      number;
par3_     varchar2(30);
ern         CONSTANT POSITIVE := 101;  -- error code
err         EXCEPTION;
erm         VARCHAR2(80);
BEGIN
 Ref1_:=0;    Ref2_:=0;
  SELECT sdate INTO Dat1_ FROM cc_deal WHERE nd=ND_ ;
  IF SDate_ <> gl.bdate THEN
    erm := 'Невозможно откатить несегодняшнюю сделку RollOver!';
    raise err;
  END IF;
  -- тип договора 1- размещ.,2-привлеч.
  begin
    select t.tipd into tipd_  from cc_vidd t, cc_deal c
    where c.nd=ND_ and c.vidd=t.vidd;
    EXCEPTION WHEN NO_DATA_FOUND THEN
     erm := 'Не определен вид договора или договора нет в системе';
    raise err;
  end;
  -- ND сделки, исходной для Ролловер (предыдущей)
  -- Откат переброски по Ролл
  -- 1. референс документа Ролл текущей сделки
  --logger.info ('MBK_Sel31 до = REF2_='||REF2_);
  --logger.info ('MBK_Sel31 до= ND_='||ND_);
  begin
    SELECT nvl(min(m.ref),0) INTO Ref2_
    FROM mbd_k_r m, oper p
	WHERE m.nd=ND_ AND m.ref=p.ref AND p.tt='KV1'
         AND   upper(p.nazn) like '%ROLLOVER%' ;
 --logger.info ('MBK_Sel32 после = REF2_='||Ref2_);
 --logger.info ('MBK_Sel32 после = ND_='||ND_);
 IF  Ref2_=0 THEN
      erm := 'Не нашли Реф. документа Ролловер текущей сделки';
      raise err;
  END IF;
  end;
  begin
   select to_number(value) into ND_Old_ from operw where ref=Ref2_ and tag='MBKND';
   EXCEPTION WHEN NO_DATA_FOUND THEN
     erm := 'Отсутствует  допреквизит MBKND для реф.'||Ref2_;
   raise err;
  end;
    -- 2. Максимальный Ref документа Ролл предыдущ. сделки (если несколько Ролл по старым версиям)
   begin
	SELECT nvl(max(m.ref),0) INTO Ref1_
    FROM mbd_k_r m, oper p
    WHERE m.nd=ND_Old_ AND m.ref=p.ref AND p.tt='KV1'
	      AND   upper(p.nazn) like '%ROLLOVER%' ;
	IF Ref1_=0 THEN
       erm := 'Не нашли Реф. документа Ролловер предыдущей сделки';
      raise err;
  END IF;
  end;
 --logger.info ('MBK_Sel4 после = Ref1_='||Ref1_);
    -- 3.откат всех документов, которые были по новой сделке, кроме документа Ролловер
	-- Межбанк уже проверили в библиотеке
  FOR k IN (SELECT m.ref ref FROM mbd_k_r m, oper p
            WHERE m.nd=ND_ AND m.ref=p.ref and p.ref<> Ref2_ AND p.sos>0
            ORDER BY m.ref desc)
  LOOP
  p_back_dok(k.ref,5,null,par2_,par3_,1);
  update operw set value='RollOver. Отказ от визы' where ref=k.ref and tag='BACKR';
  END LOOP;
  -- 4. собственно откат KV1-Ролловер
  -- 4.1 сначала вернем на транзит ( Активный по плану счетов )
  --logger.info ('MBK_Sel411 = Ref_1=2='||ref1_||'='||ref2_);
    if tipd_=1 then ref_:=Ref2_; else ref_:=Ref1_; end if;
    if Ref2_<>0 then   -- удаляем  документ KV1, если он есть (могли снять с визы)
       p_back_dok(ref_,5,null,par2_,par3_,1);
       update operw set value='RollOver. Отказ от визы' where ref=ref_ and tag='BACKR';
    end if;
  -- 4.2 затем вернем на счет договора
    if tipd_=1 then ref_:=Ref1_; else ref_:=Ref2_; end if;
     if Ref1_<>0 then -- удаляем документ KV1, если он есть (могли снять с визы)
	   p_back_dok(ref_,5,null,par2_,par3_,1);
       update operw set value='RollOver. Отказ от визы' where ref=ref_ and tag='BACKR';
     end if;
  -- SDate, WDate предыдущ. сделки
  BEGIN
  --logger.info ('MBK_Sel5 = sdate,wdate');
    SELECT sdate, wdate INTO SDate_, WDate_ FROM cc_deal WHERE nd=ND_Old_ ;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    erm := 'Не нашли даты предыдущ. сделки';
    raise err;
  END;
  --logger.info ('MBK_Sel6 = acc_nd_acc');
  FOR k IN (SELECT acc FROM nd_acc WHERE nd=ND_)
  LOOP
    DELETE FROM int_ratn WHERE acc=k.ACC AND bdat>=Dat1_ AND bdat>SDate_ ;
    UPDATE accounts SET mdate=WDate_ WHERE acc=k.Acc
	and acc not in (select acc from mbd_k where nd<>ND_)   -- не сбрасываем дату
	and ostc+ostb<>0;                                      -- если счет обслуживает 2 сделки
                                                           -- или ненулевые остатки по счету
    UPDATE int_accn SET stp_dat=WDate_-1 WHERE acc=k.Acc ;
  END LOOP;
  DELETE FROM mbd_k_r WHERE nd=ND_;
  DELETE FROM mbd_k_r WHERE nd=ND_Old_ AND ref in (Ref1_,Ref2_);   -- один из Ref1_,Ref2_ принадлежит "старой сделке"
  DELETE FROM nd_acc  WHERE nd=ND_;
  DELETE FROM cc_add  WHERE nd=ND_;
  DELETE FROM cc_prol WHERE nd=ND_;
  DELETE FROM cc_docs WHERE nd=ND_;
  DELETE FROM cc_deal WHERE nd=ND_;

EXCEPTION
  WHEN err THEN
    raise_application_error(-(20000+ern),'\'||erm,TRUE);
  WHEN OTHERS THEN
    raise_application_error(-(20000+ern),SQLERRM,TRUE);
END del_Ro_deal;

------------------------------------------------------------------
-- f_getnazn
--
--    функция возвращает назначение платежа
--
--
FUNCTION F_GetNazn(MaskId_ varchar2, ND_ number) return varchar2  IS
Mask_   varchar2(250);
n_      number;
sStr_   varchar2(250);
nLen_   number;
sPar_   varchar2(10);
sTmp_   varchar2(250);
sNazn_  varchar2(250);
SqlVal_ varchar2(2000);
refcur SYS_REFCURSOR;
acc_fi  number:=0;

BEGIN
  --logger.info ('MBK = F_GetNazn1 = MaskId_=ND_'||'старт'||'='||MaskId_||'='||ND_);

   begin
     execute immediate
                 'select   nvl(acc,0)
                    from   mbd_k_fi
                   where   ND='||ND_
                  into acc_fi;
     exception when no_data_found
             then acc_fi:=0;
   end;

  if acc_fi<>0 then
     BEGIN  -- надра фининституты
       SELECT mask INTO Mask_ FROM mbk_mask WHERE upper(id)=upper('F'||MaskId_) ;
       EXCEPTION WHEN NO_DATA_FOUND THEN
       RETURN '' ;
     END;
  else
     BEGIN
       SELECT mask INTO Mask_ FROM mbk_mask WHERE upper(id)=upper(MaskId_) ;
       EXCEPTION WHEN NO_DATA_FOUND THEN
       RETURN '' ;
     END;
  end if;

  sNazn_ := Mask_ ;
  sStr_  := Mask_ ;
  n_     := InStr(sStr_,'#') ;

  WHILE n_ > 0 LOOP
    nLen_ := Length(sStr_);
    sStr_ := Substr(sStr_, n_+1, nLen_-n_) ;
    n_    := InStr(sStr_,'#') ;
    sPar_ := Substr(sStr_, 1, n_-1) ;
    sTmp_ := '';    -- если не установить  - дублирует иногда подстановки
    BEGIN
      SELECT sqlval INTO SqlVal_ FROM mbk_descr WHERE id=sPar_ ;
      SqlVal_ := Replace(SqlVal_, ':ND', to_char(ND_)) ;
      OPEN refcur FOR SqlVal_ ;
      FETCH refcur INTO sTmp_;
      CLOSE refcur;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      sTmp_ := '' ;
    END;
    --logger.info ('MBK = F_GetNazn2 =sTmp_='||sTmp_);
    sNazn_ := Replace(sNazn_, '#'||sPar_||'#', sTmp_) ;
    sStr_  := sNazn_ ;
    n_     := InStr(sStr_,'#') ;
  END LOOP;
  --logger.info ('MBK = F_GetNazn2 = sNazn_'||'='||sNazn_||'=конец');

  RETURN sNazn_ ;

END F_GetNazn;

----------------------------------------------------------------------
-- set_deal_param
--
--    Процедура установки значения параметра сделки
--
--
procedure SET_DEAL_PARAM
( p_nd    nd_txt.nd%type,
  p_tag   nd_txt.tag%type,
  p_val   nd_txt.txt%type
) is
begin

  if p_val is not null
  then

      update nd_txt
         set txt = p_val
       where nd  = p_nd
         and tag = p_tag;

      if ( sql%rowcount = 0 )
      then
        insert into nd_txt(nd, tag, txt)
        values ( p_nd, p_tag, p_val );
      end if;

  else
    delete from nd_txt
     where nd = p_nd and tag = p_tag;
  end if;

end set_deal_param;

----------------------------------------------------------------------
-- get_deal_param
--
--    Функция возвращает значение параметра сделки
--
--
function get_deal_param (
  p_nd    nd_txt.nd%type,
  p_tag   nd_txt.tag%type) return varchar2
is
  l_val   nd_txt.txt%type;
begin
  begin
     select txt into l_val from nd_txt where nd = p_nd and tag = p_tag;
  exception when no_data_found then l_val := null;
  end;
  return l_val;
end get_deal_param;

----------------------------------------------------------------------
-- get_print_value
--
--    Процедура определяет списки переменных и их значений для печати тикета сделки
--
--
procedure get_print_value (
  p_nd         number,
  p_tic_name   varchar2,
  p_vars   out varchar2,
  p_vals   out varchar2 )
is
  l_sql    tickets_par.txt%type;
  l_value  varchar2(2000);
begin

  for k in ( select b.par, b.txt
               from ( select a.par, nvl(b.rep_prefix,'DEFAULT') rep_prefix
                        from ( select par from tickets_par
                                where upper(rep_prefix) = upper(p_tic_name)
                                  and mod_code = 'MBK'
                                union
                               select par from tickets_par
                                where upper(rep_prefix) = upper('DEFAULT')
                                  and mod_code = 'MBK' ) a, tickets_par b
                       where a.par = b.par(+)
                         and upper(b.rep_prefix(+)) = upper(p_tic_name) ) a, tickets_par b
              where upper(a.rep_prefix) = upper(b.rep_prefix)
                and a.par = b.par
                and b.txt is not null )
  loop

     l_sql := replace( k.txt, ':ND', to_char(p_nd) ) ;
     execute immediate l_sql into l_value;
     p_vars := p_vars || k.par   || '~' ;
     p_vals := p_vals || l_value || '~' ;

  end loop;

end get_print_value;

------------------------------------------------------------------
-- SAVE_PARTNER_TRACE()
--
--    Процедура сохраняет информацию о трассе и посреднике
--
--
procedure save_partner_trace(
    p_custCode   in cc_swtrace.rnk%type,
    p_currCode   in cc_swtrace.kv%type,
    p_swoBic     in cc_swtrace.swo_bic%type,
    p_swoAcc     in cc_swtrace.swo_acc%type,
    p_swoAlt     in cc_swtrace.swo_alt%type,
    p_intermb    in cc_swtrace.interm_b%type,
    p_field58d   in cc_swtrace.field_58d%type,
    p_nls        in cc_swtrace.nls%type )
is
begin

    update cc_swtrace
       set swo_bic   = p_swoBic,
           swo_acc   = p_swoAcc,
           swo_alt   = p_swoAlt,
           interm_b  = p_intermb,
           field_58d = p_field58d,
           nls       = p_nls
     where rnk = p_custCode
       and kv = p_currCode;

    if sql%rowcount = 0 then

        insert into cc_swtrace (rnk, kv, swo_bic, swo_acc, swo_alt, interm_b, field_58d, nls)
        values (p_custCode, p_currCode, p_swoBic, p_swoAcc, p_swoAlt, p_intermb, p_field58d, p_nls);

    end if;

end save_partner_trace;

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2 is
begin
  return 'Package header MBK'||MBK_HEAD_VERS||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_HEADER_DEFS;
end header_version;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2 is
begin
  return 'Package body MBK '||MBK_BODY_VERS||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_BODY_DEFS;
end body_version;

----------------------------------------------------------------------
-- unlink_dcp
--
--    Процедура отвязки залога ДЦП
--
procedure unlink_dcp(p_nd number)
is
  l_pawn  varchar2(30);
begin

  select substr(trim(n.txt),1,30) into l_pawn
    from nd_txt n, cc_pawn c
   where n.nd = p_nd and n.tag = 'PAWN'
     and substr(trim(n.txt),1,30) = to_char(c.pawn) and c.code = 'DCP';

  update dcp_p set ref = null, acc = null where ref = - p_nd;

  delete from nd_txt where nd = p_nd and tag = 'PAWN';

exception when no_data_found then null;
end unlink_dcp;

----------------------------------------------------------------------
-- link_deal
--
--    Процедура привязки договоров
--
procedure link_deal (p_nd number, p_ndi number)
is
begin
  update cc_deal set ndi = p_ndi where nd = p_nd;
end link_deal;

----------------------------------------------------------------------
-- link_nd_ref
--
--    Процедура привязки документа к договору
--
procedure link_nd_ref (p_nd number, p_ref number)
is
begin
  insert into mbd_k_r (nd, ref) values (p_nd, p_ref);
exception when dup_val_on_index then null;
end link_nd_ref;

------------------------------------------------------------------
-- link_docs
--
--    Процедура привязки документов к договорам
--
procedure link_docs (p_dat date)
is
begin
  -- выбираем договора
  for z in ( select nd, b_acc from mbk_deal )
  loop
     -- выбираем документы по договору:
     -- 1) док. по нач.%%
     for d in ( select unique o.ref
                  from opldok o
                 where o.acc  = z.b_acc
                   and o.fdat = p_dat
                   and not exists (select 1 from mbd_k_r where nd = z.nd and ref = o.ref) )
     loop
        link_nd_ref(z.nd, d.ref);
     end loop;
     -- 1) док. по залогам
     for d in ( select unique o.ref
                  from nd_acc n, opldok o
                 where n.nd   = z.nd
                   and n.acc  = o.acc
                   and o.fdat = p_dat
                   and o.tt   = 'ZAL'
                   and not exists (select 1 from mbd_k_r where nd = z.nd and ref = o.ref) )
     loop
        link_nd_ref(z.nd, d.ref);
     end loop;
  end loop;
end link_docs;

END mbk;
/
 show err;
 
PROMPT *** Create  grants  MBK ***
grant EXECUTE                                                                on MBK             to FOREX;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/mbk.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 