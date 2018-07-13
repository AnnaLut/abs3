CREATE OR REPLACE PACKAGE BARS.SEP IS
--***************************************************************--
--            Communication with NBU Payment System
--                   (C) Unity-BARS

/****************************************************************************
    Список параметров для AW.bat
 вызов:   AW sep_head.sql sep_head.out <параметры>
 Банки: *********************************************************************

   -- M03+OSC+SWT+ADDINFO+KLT  -- ОЩАДБАНК ГОУ
   -- M03+OSC+SWT+ADDINFO+KLT+F03  -- ОЩАДБАНК(мульти-мфо)
   -- M03		-- СТОЛИЦА Головной
   -- F03		-- ПЕТРОКОМЕРЦ Филиалы, СТОЛИЦА Филиалы

***************************************************************************/

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 6.28 21/10/2016';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := ''

	||'      Коммерческие банки-НБУ-Казначейство'||chr(10)
	||'      без 8 модели'||chr(10)
	||'M03 - поддержка 3 модели СЕП НБУ'||chr(10)
	||'F03 - филиал мультивалютной ВПС'||chr(10)
	||'      без учета срочных платежей филиалов по 4 модели в Головном банке'||chr(10)
	||'SWT - поддержка SWIFT формата'||chr(10)
	||'OSC - ВПС Ощадбанка'||chr(10)
	||'ADDINFO - с процедурой in_sep_add()'||chr(10)
	||'KLT - с процедурой клиринга транзитов'||chr(10)
;
--***************************************************************--

MD32   CHAR(2)     DEFAULT NULL;  -- Sep data code
aSAB   CHAR(4)     DEFAULT NULL;  -- Local abonent symbol
nMODEL CHAR(1)     DEFAULT '0';   -- Sep Model Number
-- =======================================================
G_rec  NUMBER      DEFAULT NULL;  -- Current rec in ARC_RRP
G_mfoA VARCHAR2(9) DEFAULT NULL;  -- Current mfoA code
G_mfoB VARCHAR2(9) DEFAULT NULL;  -- Current mfoB code
-- =======================================================

TYPE ZagBRec IS RECORD -- Transit record of zag_b table (TRIG)
  (new_kv SMALLINT,  new_fn CHAR(12),    new_dat DATE,
   new_dk SMALLINT,  new_s  DECIMAL(24), new_sos SMALLINT);

zag_b_rec    ZagBRec;

WIN_   VARCHAR2(75) :=
 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЪЫЭЮЯІЇЄабвгдеёжзийклмнопрстуфхцчшщьъыэюяіїє№Ґґ';
DOS_   VARCHAR2(75) :=
 'ЂЃ‚ѓ„…р†‡€‰Љ‹ЊЌЋЏђ‘’“”•–—™њљ›ќћџцшф ЎўЈ¤Ґс¦§Ё©Є«¬­®Їабвгдежзиймклнопчщхьту';

/**
 * header_version - возвращает версию заголовка пакета СЭП
 */
function header_version return varchar2;

/**
 * body_version - возвращает версию тела пакета СЭП
 */
function body_version return varchar2;

/**
 * version - возвращает номер версии Системы Электронных Платежей
 */
function version return integer;

/**
 * ssp_trans_id - возвращает хвост идентификатора транзакции ССП
 * по заданному целому числу
 */
function ssp_trans_id(p_num in integer) return varchar2;

PROCEDURE in_sep(
   err_   OUT INTEGER,    -- Return code
   rec_   OUT INTEGER,    -- Record number
   mfoa_  VARCHAR2,                     -- Sender's MFOs
   nlsa_  VARCHAR2,                     -- Sender's account number
   mfob_  VARCHAR2,                     -- Destination MFO
   nlsb_  VARCHAR2,                     -- Target account number
   dk_    SMALLINT,                     -- Debet/Credit code
   s_     DECIMAL,                      -- Amount
   vob_   SMALLINT,                     -- Document type
   nd_    VARCHAR2,                     -- Document number
   kv_    SMALLINT,                     -- Currency code
   data_  DATE,                         -- Posting date
   datp_  DATE,                         -- Document date
   nam_a_ VARCHAR2,                     -- Sender's customer name
   nam_b_ VARCHAR2,                     -- Target customer name
   nazn_  VARCHAR2,                     -- Narrative
   naznk_ CHAR,                         -- Narrative code
   nazns_ CHAR,                         -- Narrative contens type
   id_a_  VARCHAR2,                     -- Sender's customer identifier
   id_b_  VARCHAR2,                     -- Target customer identifier
   id_o_  VARCHAR2,                     -- Teller identifier
   ref_a_ VARCHAR2,                     -- Sender's reference
   bis_   SMALLINT,                     -- BIS number
   sign_  VARCHAR2,                     -- Signature
   fn_a_  CHAR,                         -- Input file namea
   rec_a_ SMALLINT,                     -- Input file record number
   dat_a_ DATE,                         -- Input file date/time
   d_rec_ VARCHAR2,                     -- Additional parameters
   otm_i  SMALLINT,                     -- Processing flag
   ref_i  INTEGER    DEFAULT NULL,      -- PreAssigned Reference
   blk_i  SMALLINT   DEFAULT NULL,      -- Blocking code
   ref_swt_ VARCHAR2 DEFAULT NULL       -- Swift F20: tag
  );
-- Перенаправление заблокированных документов из СЕП/ВПС на СВИФТ
PROCEDURE sep2swt(rec_ NUMBER);
-- валидация БИСов
PROCEDURE validate_bis(
   err_			OUT INTEGER,				  -- Return code
   ln_list_	    OUT VARCHAR2,				  -- Номера строк, на которые выдается ошибка n1,n2,n3
   err_msg_     OUT VARCHAR2,				  -- Сообщение об ошибке
   rec_			INTEGER,					  -- Record number
   fn_a_		CHAR,                         -- Input file namea
   dat_a_		DATE,                         -- Input file date/time
   rec_a_		SMALLINT                      -- Input file record number
  );
PROCEDURE pay_grc(ref_  INTEGER,    -- Reference
                   tt_  CHAR,       -- Transaction code
                  txt_  VARCHAR2,   -- Comment
                   kv_  SMALLINT,   -- Currency code
                 accd_  INT,        -- Account debet
                 acck_  INT,        -- Account credit
                    s_  DECIMAL) ;
FUNCTION ch_acc(mfo_ VARCHAR, kv_ SMALLINT, tip_ CHAR)
  RETURN INTEGER;
FUNCTION h2_rrp(i SMALLINT)
  RETURN CHAR;
PROCEDURE p_doc(p_tt CHAR,vdat_ DATE, dk_ SMALLINT, kv_ SMALLINT,
           koda_ SMALLINT,mfoa_ VARCHAR,nls1_ VARCHAR,
           kodb_ SMALLINT,mfob_ VARCHAR,nls2_ VARCHAR,
        s_ DECIMAL,ref_ IN OUT INTEGER,
      rec_ NUMBER DEFAULT NULL, p_tip VARCHAR2 DEFAULT NULL);
PROCEDURE p_fil(p_tt CHAR, fn_ CHAR,
           kv_ SMALLINT, koda_ SMALLINT, mfoa_ VARCHAR,
                         kodb_ SMALLINT, mfob_ VARCHAR,
          sde_ DECIMAL,skr_ DECIMAL,ref_ IN OUT INTEGER);
PROCEDURE p_kwt(err_ OUT SMALLINT,
                 fn_     CHAR,
                dat_     DATE,
              rec_a_     SMALLINT,
               errk_     SMALLINT);
PROCEDURE pa_grc(
      errk_  OUT SMALLINT,    -- Error code
      otm_   OUT SMALLINT,    -- Return flag
      kv_    SMALLINT,        -- Currency code
      fn_    CHAR,            -- SEP File name
      dat_   DATE,            -- File date/time
      n_     SMALLINT,        -- line file counter
      sde_   DECIMAL,         -- Debet  amount
      skr_   DECIMAL,         -- Credit amount
      sign_key_ CHAR,         -- Key Identifier
      sign_  RAW,             -- File signature
      entry_ SMALLINT);       -- Entry number
PROCEDURE po_grc;
PROCEDURE bp_grc(ret_ OUT   SMALLINT,    -- Return code
                 pdi_       SMALLINT);   -- Direction number
PROCEDURE dyn_bl_rrp
       ( blk_ IN OUT NUMBER, kv_ NUMBER,
          mfopa_ VARCHAR2, mfoa_ VARCHAR2, nlsa_ VARCHAR2,
          mfopb_ VARCHAR2, mfob_ VARCHAR2, nlsb_ VARCHAR2,
          dk_  NUMBER, s_ NUMBER, id_a_ VARCHAR2, id_b_ VARCHAR2,
          ref_ NUMBER);
PROCEDURE ps_grc(
   err_   OUT INTEGER,    -- Return code
   tt_        CHAR,
   fn_        CHAR,
   dat_       DATE,
   n_         SMALLINT,
   sd_        DECIMAL,
   sk_        DECIMAL,
   errk_      SMALLINT,
   detail_    SMALLINT,
   ab_sign_     RAW default NULL,
   ab_signsize_ SMALLINT default 0,
   dat_2_     DATE default NULL,
   tic_sign_key_ VARCHAR2 default NULL
   );

PROCEDURE pk_grc(
       blkn_ OUT CHAR,
         kn_ OUT SMALLINT,
        knn_ OUT SMALLINT,
        mfo_ VARCHAR,
         ki_ SMALLINT,
       ostf_ DECIMAL,
        lim_ DECIMAL,
        lno_ DECIMAL,
        kvu_ SMALLINT DEFAULT 980);
PROCEDURE pv_grc(fn_v VARCHAR2 DEFAULT NULL);
PROCEDURE pz_grc(ret_  OUT SMALLINT,
                  fn_      CHAR,
                 dat_      DATE,
                   n_      SMALLINT,
                  sd_      DECIMAL,
                  sk_      DECIMAL,
                errk_      SMALLINT);
/**
 * Поиск различий по выписке ССП и информации в БД
 */
PROCEDURE dif_ssp(p_sign_on INTEGER);

PROCEDURE pz3_grc;
FUNCTION zap_reqv(dir_ NUMBER, mfob_ VARCHAR2, d_rec_ VARCHAR2) RETURN VARCHAR2;
PROCEDURE pu_grc
  (op_ CHAR,mfog_ VARCHAR,mfou_ VARCHAR,
            mfo_ VARCHAR,sab_  CHAR,nb_ VARCHAR,nmo_ CHAR,rez_ CHAR);
PROCEDURE pn_grc(mfoa_ VARCHAR);
PROCEDURE ips;
PROCEDURE ips_insert(
          ret_     OUT SMALLINT,    -- Error code
          dat_sep_ DATE,
          mfoa_    VARCHAR, nlsa_    VARCHAR,
          mfob_    VARCHAR, nlsb_    VARCHAR,
          dk_      SMALLINT,s_       DECIMAL,kv_      SMALLINT,
          fn_qa_   VARCHAR, rec_qa_  SMALLINT, dat_qa_  DATE, errk_    CHAR,
          fn_a_    VARCHAR, rec_a_   SMALLINT, dat_a_   DATE, dat_pa_  DATE,
          fn_qb_   VARCHAR, rec_qb_  SMALLINT, dat_qb_  DATE,
          fn_b_    VARCHAR, rec_b_   SMALLINT, dat_b_   DATE, dat_pb_  DATE,
          bis_     SMALLINT,
          dat_l_   DATE,
          f_rq_    CHAR,
          t_rq_    CHAR,
          ref_q_   RAW,
          ref_a_   VARCHAR);
/***************************************************************/
/*** Копирует БИСы в допреквизиты operw                      ***/
/***************************************************************/
PROCEDURE bis2ref(rec_ NUMBER,ref_ NUMBER);
/**
 * set_blk - установить код блокировки участника по валюте
 * @param p_sab - эл. адрес
 * @param p_kv - код валюты
 * @param p_blk - код блокировки
 */
procedure set_blk(p_sab in varchar2, p_kv in int, p_blk in int);

/**
 * set_blk_dir - установить код блокировки участника по направлению
 * @param p_kodn - код направления
 * @param p_kv - код валюты
 * @param p_blk - код блокировки
 */
procedure set_blk_dir(p_kodn in int, p_kv in int, p_blk in int);

/**
 * get_blk - вернуть код блокировки участника по валюте
 * @param p_sab - эл. адрес
 * @param p_kv - код валюты
 * @return - код блокировки
 */
function get_blk(p_sab in varchar2, p_kv in int) return int;

/**
 * in_sep_add - установка дополнительных параметров платежа(после ЭЦП)
 * работает под СЭП-2
 */
PROCEDURE in_sep_add(
		rec_ 		NUMBER,	    -- Номер строки в arc_rrp
	   	fa_name_ 	VARCHAR2,   -- 25 Имя                    файла  A
  		fa_ln_   	NUMBER,     -- 26 Порядковый номер ИС  в файле  A
		fa_t_arm3_  VARCHAR2,   -- 27 Время прохождения через АРМ-3 A
		fa_t_arm2_  VARCHAR2,   -- 28 Время получения       в АРМ-2 A
		f_reserved_ VARCHAR2,   -- Зарезервировано(сейчас не используется)
		fb_name_ 	VARCHAR2,   -- 33 Имя                    файла  B
		fb_ln_   	NUMBER,     -- 34 Порядковый номер ИС  в файле  B
		fb_t_arm2_  VARCHAR2,   -- 35 Время формирования    в АРМ-2 B
		fb_t_arm3_  VARCHAR2,   -- 36 Время получения       в АРМ-3 B
		fb_d_arm3_  DATE        -- 37 Дата  получения       в АРМ-3 B
);

/**
 * mark_zag_k - помечает заголовок расформированного файла отметкой p_otm
 * @param p_fn  - имя файла
 * @param p_dat - дата+время файла
 * @param p_otm - отметка
 */
procedure mark_zag_k(p_fn varchar2, p_dat date, p_otm number);

/**
 * select_ssp_trans - отбирает необходимые идентификаторы транзакций ССП
 */
procedure select_ssp_trans;
--
-- Клиринг транзитов для 3 модели ОщадБанка (Вызывается из JOB)
--
PROCEDURE transit_clearing (dat_ DATE DEFAULT NULL);
--
-- Создание JOBа клиринга транзитов
--
PROCEDURE create_transit_clearing_job;

--
-- get_nbu_mfo - возвращает МФО управления НБУ, которое ведет корсчет банка
--               (оно же MFOP из PARAMS)
function get_nbu_mfo return varchar2;

/**
 * deny_date_control - выключает контроль даты файла $A на соответствие текущей банковской
 */
procedure deny_date_control;

procedure del_ref_t902 (p_ref in number);

procedure check_t902_dok(p_ref in number);

END;

/
CREATE OR REPLACE PACKAGE BODY BARS.SEP IS
--***************************************************************--
--              Communication with NBU Payment System
--                     (C) Unity-BARS (2000-2013)
--***************************************************************--

   -- M03+OSC+SWT+F03+ADDINFO+FM+BR+MULTIREC+KLT  -- ОЩАДБАНК Областные управления (мульти-мфо)
   -- M03+OSC+SWT+F03+ADDINFO     -- НАДРА БАНК
   -- M03    -- СТОЛИЦА Головной
   -- F03    -- CТОЛИЦА Филиалы

--***************************************************************--

G_BODY_VERSION  CONSTANT VARCHAR2(100)  := '$Ver: 6.64 2018-07-13 vitalii.khomida$';

G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := ''

  ||'      Коммерческие банки-НБУ-Казначейство'||chr(10)
  ||'      без 8 модели'||chr(10)
  ||'M03 - поддержка 3 модели СЕП НБУ(Головной банк)'||chr(10)
  ||'F03 - филиал мультивалютной ВПС'||chr(10)
  ||'      без учета срочных платежей филиалов по 4 модели в Головном банке'||chr(10)
  ||'SWT - поддержка SWIFT формата'||chr(10)
  ||'OSC - ВПС Ощадбанка'||chr(10)
  ||'BR - Зарахування на 6 клас по ВПС від ГОУ (Ощадбанк)'||chr(10)
  ||'ADDINFO - с процедурой in_sep_add()'||chr(10)
  ||'FM  - с поддержкой ФинМониторинга'||chr(10)
  ||'KLT - с процедурой клиринга транзитов'||chr(10)
  ||'MULTIREC - Ключ REC в разрезе учреждений (s_arc_rrp.nextval||ru)'||chr(10)
;

--                     ErrCode (9120-9149)
--***************************************************************--
G_pm     SMALLINT      DEFAULT NULL;
G_mfo    VARCHAR(12)   DEFAULT NULL;
G_err    SMALLINT      DEFAULT NULL;
G_koda   SMALLINT      DEFAULT NULL;
G_fn     VARCHAR(12)   DEFAULT NULL;
G_dat    DATE          DEFAULT NULL;

G_acc_T00     INTEGER      DEFAULT NULL;
G_nls_T00     VARCHAR2(15) DEFAULT NULL;
G_acc_T0D     INTEGER      DEFAULT NULL;
G_dval_OP     VARCHAR2(50) DEFAULT NULL;

G_NBU_mfo     VARCHAR(12) DEFAULT NULL;
G_NBU_pm      SMALLINT    DEFAULT NULL;
G_NBU_fmi     CHAR(1)     DEFAULT NULL;
G_NBU_fmo     CHAR(1)     DEFAULT NULL;
G_NBU_sab     CHAR(4)     DEFAULT NULL;
G_NBU_ssp     SMALLINT    DEFAULT NULL;
G_NBU_kodn    SMALLINT    DEFAULT NULL;

G_rec_g       NUMBER      DEFAULT NULL; -- Номер главной строки БИС
G_dat_a       DATE        DEFAULT NULL; -- Дата А из главной строки БИС
G_nosign_kod  NUMBER      DEFAULT NULL;

G_sepnum      INTEGER     DEFAULT NULL;  -- используемая версия СЭП(по параметру 'SEPNUM')
G_SepVobList  VARCHAR2(100) DEFAULT ',1,2,6,11,12,33,81,';
G_kl_bob      SMALLINT DEFAULT NULL;  -- Версия КЛИЕН-БАНК 1-СБ(Вега) или 0 - ИКТ

G_swtype  VARCHAR2(3);
TYPE tag_rec IS RECORD(val VARCHAR2(200),rec VARCHAR2(100));
TYPE tag_tab IS TABLE OF tag_rec INDEX BY VARCHAR2(64);
swt  tag_tab;

-- переменные для полей основной строки БИС, которые должны совпадать во всех строках БИС
main_bis      arc_rrp%ROWTYPE;

-- допустимые символы разделителя в идентификаторе транзакции ССП
G_ssp_delim    CONSTANT VARCHAR2(37) := ':0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
-- допустимые символы первого знака расширения в идентификаторе транзакции ССП
G_ssp_fchar    CONSTANT VARCHAR2(35) := '123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

G_BPGRCCNT     INTEGER := 1000;  -- кол-во обрабатываемых платежей за 1 цикл BP_GRC
G_BPGRSCNT     INTEGER := 0;    -- лічильник пропущених в минулому циклі
g_date_control boolean := true; -- выполнять контроль даты файла $A на соответствие текущей банковской
g_branch varchar2(30);


/**
 * header_version - возвращает версию заголовка пакета СЭП
 */
function header_version return varchar2 is
begin
  return 'Package header SEP '||G_HEADER_VERSION||'.'||chr(10)
     ||'AWK definition: '||chr(10)
     ||G_AWK_HEADER_DEFS;
end header_version;

/**
 * body_version - возвращает версию тела пакета СЭП
 */
function body_version return varchar2 is
begin
  return 'Package body SEP '||G_BODY_VERSION||'.'||chr(10)
     ||'AWK definition: '||chr(10)
     ||G_AWK_BODY_DEFS;
end body_version;

/**
 * version - возвращает номер версии Системы Электронных Платежей
 */
function version return integer is
begin
  return G_sepnum;
end version;

/**
 * trace - вывод трассировочных сообщений в sec_audit
 */
procedure trace(p_msg in varchar2) is
begin
    bars_audit.trace('SEP: '||p_msg);
end trace;

/**
 * trace - вывод информационных сообщений в sec_audit
 */
procedure info(p_msg in varchar2) is
begin
    bars_audit.info('SEP: '||p_msg);
end info;

/**
 * trace - вывод ошибочных сообщений в sec_audit
 */
procedure error(p_msg in varchar2) is
begin
    bars_audit.error('SEP: '||p_msg);
end error;

/**
 * ssp_trans_id - возвращает хвост идентификатора транзакции ССП
 * по заданному целому числу
 */
function ssp_trans_id(p_num in integer) return varchar2 is
begin
  if p_num >= 1678320 /* 37*35*36*36 */ then
    raise_application_error(-20001,
    'Количество транзакций ССП ограничено числом 1678320 (37*35*36*36)!',
    TRUE);
  end if;
  return  substr(G_ssp_delim,trunc(mod(p_num,36*36*35*37)/36/36/35)+1,1)
      ||substr(G_ssp_fchar,trunc(mod(p_num,36*36*35)/36/36)+1,1)
    ||substr(sep.h2_rrp(trunc(mod(p_num,36*36)/36)),1,1)
    ||substr(sep.h2_rrp(mod(p_num,36)),1,1);
end;
/***************************************************************/
/***      Вставка в arc_rrp                                  ***/
/***************************************************************/
PROCEDURE in_sep(
   err_   OUT INTEGER,    -- Return code
   rec_   OUT INTEGER,    -- Record number
   mfoa_  VARCHAR2,                     -- Sender's MFOs
   nlsa_  VARCHAR2,                     -- Sender's account number
   mfob_  VARCHAR2,                     -- Destination MFO
   nlsb_  VARCHAR2,                     -- Target account number
   dk_    SMALLINT,                     -- Debet/Credit code
   s_     DECIMAL,                      -- Amount
   vob_   SMALLINT,                     -- Document type
   nd_    VARCHAR2,                     -- Document number
   kv_    SMALLINT,                     -- Currency code
   data_  DATE,                         -- Posting date
   datp_  DATE,                         -- Document date
   nam_a_ VARCHAR2,                     -- Sender's customer name
   nam_b_ VARCHAR2,                     -- Target customer name
   nazn_  VARCHAR2,                     -- Narrative
   naznk_ CHAR,                         -- Narrative code
   nazns_ CHAR,                         -- Narrative contens type
   id_a_  VARCHAR2,                     -- Sender's customer identifier
   id_b_  VARCHAR2,                     -- Target customer identifier
   id_o_  VARCHAR2,                     -- Teller identifier
   ref_a_ VARCHAR2,                     -- Sender's reference
   bis_   SMALLINT,                     -- BIS number
   sign_  VARCHAR2,                     -- Signature
   fn_a_  CHAR,                         -- Input file name
   rec_a_ SMALLINT,                     -- Input file record number
   dat_a_ DATE,                         -- Input file date/time
   d_rec_ VARCHAR2,                     -- Additional parameters
   otm_i  SMALLINT,                     -- Processing flag
   ref_i  INTEGER    DEFAULT NULL,      -- PreAssigned Reference
   blk_i  SMALLINT   DEFAULT NULL,      -- Blocking code
   ref_swt_ VARCHAR2 DEFAULT NULL       -- Source REF ($A||#rec or Swift F20)
  ) IS
--
-- Inserting of document into ARC_RRP for file processing
--
parent_not_found EXCEPTION;
PRAGMA EXCEPTION_INIT(parent_not_found, -2291);

ern         CONSTANT POSITIVE := 098;
erm         VARCHAR2(80);
err         EXCEPTION;

mfo_   VARCHAR2(12);
mfo_a_ VARCHAR2(12) DEFAULT NULL;
mfo_b_ VARCHAR2(12) DEFAULT NULL;
pm_    SMALLINT;
koda_  SMALLINT     DEFAULT NULL;
kodb_  SMALLINT     DEFAULT NULL;
sos_   SMALLINT;
sab_   CHAR(4)      DEFAULT NULL;
blk_   SMALLINT     := blk_i;
otm_   SMALLINT     := otm_i;
ref_   INTEGER      DEFAULT NULL;
utr_   VARCHAR2(20) DEFAULT NULL;
kod_   SMALLINT;
mfok_  VARCHAR2(12) DEFAULT NULL;
nls_lik_ VARCHAR2(15);
--
ot_s_    NUMBER;
ot_mfoa_ VARCHAR2(12);
ot_nd_   VARCHAR2(10);
ot_vob_  NUMBER;
ot_nlsb_ VARCHAR2(15);
ot_id_b_ VARCHAR2(14);

id_a#    arc_rrp.id_a%type  := TRIM(id_a_);
id_b#    arc_rrp.id_b%type  := TRIM(id_b_);
nazn#    arc_rrp.nazn%type  := TRIM(nazn_);
d_rec#   arc_rrp.d_rec%type := RTRIM(d_rec_);   -- в доп.реквизитах пробелы обрезаем только справа !
naznk#   VARCHAR2(3)        := TRIM(naznk_);

tip_   CHAR(3);
tt_    VARCHAR2(6);
i      NUMBER;
j      NUMBER;
k      NUMBER;

tmp_        VARCHAR2(220);
tag_        VARCHAR2(5);
val_        VARCHAR2(160);

transcode_  VARCHAR2(7);  -- код операции по 1ПБ
iso_countr_ VARCHAR2(3);  -- код страны получателя по 1ПБ
vdat_    DATE;
sw_acc_tip  varchar2(3);
o_symbol    CHAR(1);
dop_char    VARCHAR2(1);
sde_     DECIMAL(24);
skr_     DECIMAL(24);
fa_name_ VARCHAR2(12)  := SUBSTR(ref_swt_,1,12);
--fa_ln_   NUMBER        := SUBSTR(ref_swt_,13,6);
fa_ln_   NUMBER        := CASE WHEN SUBSTR(ref_swt_,18,1)=' ' THEN 0 ELSE SUBSTR(ref_swt_,13,6) END;
ssp_source VARCHAR2(1) := CASE WHEN otm_i=3 THEN SUBSTR(ref_swt_,19,1) ELSE NULL END;  -- источник документа ССП: A,B,a,b
sk_      NUMBER(2);
fn_a#    VARCHAR2(12);
dat_a#   DATE := NVL( dat_a_, CASE WHEN bis_>1 AND G_dat_a IS NOT NULL
                              THEN G_dat_a
                              ELSE TO_DATE  (TO_CHAR(gl.bDATE,'YYYYMMDD')||' '||
                                   TO_CHAR(SYSDATE,'HH24:MI'),'YYYYMMDD HH24:MI')END);
fmcheck_  SMALLINT;


BEGIN

logger.info('OLEG: bis='||to_char(bis_)||', sign='||sign_||', d_rec='||d_rec_);

   ref_ := ref_i;

-- ----------------------------------------------------------------
   SAVEPOINT insep0;
-- ----------------------------------------------------------------

   if naznk# IS NOT NULL THEN
      err_ := 0616;        -- ошибка в реквизите 16 "Код назначения платежа" - в СЭП-2 это резерв
      rec_ :=   -1;
      RETURN;
   end if;

   IF id_a# IS NULL OR
      NOT (TRANSLATE(id_a#,chr(0)||'0123456789',chr(0)) IS NULL
      AND LENGTH(id_a#) IN (8,9,10) OR id_a#='99999') THEN
      err_ := 0618;        -- Ошибка синтаксиса в реквизите 18 "Идентификационный код клиента А"
      rec_ :=   -1;
      return;
   end if;

   if bis_<>1 AND (INSTR(d_rec#,'#B')>0 AND INSTR(d_rec#,'#d')=0) THEN
      err_ := 0945;        -- БІР: помилка в нумерації рядків
      rec_ :=   -1;
      RETURN;
   end if;

   IF id_b# IS NULL OR
      NOT (TRANSLATE(id_b#,chr(0)||'0123456789',chr(0)) IS NULL
      AND LENGTH(id_b#) IN (8,9,10) OR id_b#='99999') THEN
      err_ := 0956;        -- Не заповнений/невірний ідентиф.код клієнта Б
      rec_ :=   -1;
      return;
   end if;

   IF SUBSTR(fn_a_,3,4)=sep.aSAB AND otm_<>3  -- по ответным СЭП
   OR ( otm_=3 AND ssp_source in ('B','b') )  -- по ответным ССП
   THEN         -- document from NBU then Direction 3 always
      mfo_a_:=G_NBU_mfo;sab_:=G_NBU_sab;koda_:=G_NBU_kodn;pm_:=G_NBU_pm;
   ELSE
      BEGIN
         SELECT mfo,   sab, kodn, pm
           INTO mfo_a_,sab_,koda_,pm_ FROM banks
          WHERE mfop = gl.aMFO AND (
                 mfo = mfoa_ OR
                 mfo = (SELECT mfop FROM banks WHERE mfop <> gl.aMFO AND mfo=mfoa_));
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            err_ := 0902;
            rec_ :=   -1;
            RETURN;        -- No bank A found
      END;
   END IF;

   BEGIN
      SELECT mfo,kodn
        INTO mfo_b_,kodb_ FROM banks
       WHERE mfop = gl.aMFO AND (
              mfo = mfob_ OR
              mfo = (SELECT mfop FROM banks WHERE mfop <> gl.aMFO AND mfo=mfob_));
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         err_ := 0903;
         rec_ :=   -1;
         RETURN;           -- No bank B found
   END;

   IF NOT(koda_ in (4,6) AND SUBSTR(fn_a_,3,4)= sab_ OR
          koda_ in (3,6) AND SUBSTR(fn_a_,3,4)= aSAB OR
          koda_ in (2,5) AND fn_a_ IS NULL OR
          koda_=2 AND fn_a_ IS NOT NULL AND mfoa_=gl.aMFO OR
          koda_=3 AND otm_=3
         )
   THEN
      err_ := 0908;
      rec_ :=   -1;
      RETURN;              -- RP does not correspond MFO
   END IF;

   IF koda_=2 AND fn_a_ IS NOT NULL AND mfoa_=gl.aMFO AND otm_<>3 THEN -- check account

      BEGIN
         SELECT b.sab, a.tip, b.mfo
           INTO   sab_,  tip_, mfok_
           FROM accounts a,banks b,bank_acc c
         WHERE a.acc=c.acc AND b.mfo=c.mfo AND
               a.nls=nlsa_ AND a.kv=kv_;

         IF SUBSTR(fn_a_,3,4)<>sab_ THEN
            err_ := 0908;
            rec_ :=   -1;
            RETURN;        -- No account owner (Відправлено платіж не від свого імені)
         END IF;

      EXCEPTION
         WHEN NO_DATA_FOUND OR TOO_MANY_ROWS THEN
            err_ := 0991;
            rec_ :=   -1;
            RETURN;        -- No account A valid
      END;
   END IF;
--
   IF koda_ in (4,6) AND dk_=0 AND fn_a_ IS NOT NULL THEN
      err_ := 0916;
      rec_ :=   -1;
      RETURN;              -- Debet is not permitted for dir 4,6
   END IF;
-- -------------------- Check if Balance number Valid ----

   IF koda_ in (2,4,6) AND dk_ IN (0,1) AND mfob_<>gl.aMFO THEN
      IF SUBSTR(mfob_,1,1)='8' THEN
         kod_ := 3;
      ELSE
         BEGIN
            SELECT sab INTO sab_ FROM banks WHERE mfo=mfob_ AND blk<>4;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               err_ := 0903;
               rec_ :=   -1;
               RETURN;     -- No bank B found
         END;
         IF SUBSTR(sab_,3,1)='H' THEN kod_ := 1; ELSE kod_ := 2; END IF;
      END IF;

      BEGIN
         SELECT kod INTO kod_ FROM nosep
          WHERE kod=kod_ AND
               (SUBSTR(nlsb_,1,4)=nbs OR SUBSTR(nlsb_,1,3)=nbs OR
                SUBSTR(nlsb_,1,2)=nbs OR SUBSTR(nlsb_,1,1)=nbs);
         err_ := 0914;
         rec_ :=   -1;
         RETURN;           -- Invalid NBS
      EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
      END;
   END IF;
-- ----------------------------------------------------
   IF fn_a_ IS NOT NULL AND koda_<>3 THEN -- документ входящий и НЕ от НБУ?
      IF INSTR( G_SepVobList, ','||TO_CHAR(vob_)||',' )=0 THEN
         err_ := 0921;  -- Невірно вказано умовний числовий код документа
         rec_ :=   -1;
         RETURN;
      END IF;
      IF vob_=33 AND dk_<>3 THEN
         err_ := 0915;  -- Невірно вказано Д/К для переказу готівки vob=33
         rec_ :=   -1;
         RETURN;
      END IF;
--
if gl.aMFO in('300465', '300001') or gl.aMFO like '8%' then
      IF kv_<>gl.baseval AND kodb_ = 3 THEN
         err_ := 0919;        -- Банк Б не работает с указанной валютой
         rec_ :=   -1;
         RETURN;
      END IF;
end if;

      IF koda_=6 AND mfo_a_=mfo_b_ THEN
         err_ := 0909;        -- платеж внутри области сам себе
         rec_ :=   -1;
         RETURN;
      END IF;
      IF nlsb_<>VKRZN(SUBSTR(mfob_,1,5),nlsb_) THEN
         err_ := 0912;          -- Не ключується рахунок клієнта Б
         rec_ :=   -1;
         RETURN;
      END IF;
      IF id_a_<>V_OKPO(id_a_) THEN
         err_ := 0979;          -- Не ключуется идентиф.код клиента А
         rec_ :=   -1;
         RETURN;
      END IF;
      IF id_b_<>V_OKPO(id_b_) THEN
         err_ := 0980;          -- Не ключуется идентиф.код клиента Б
         rec_ :=   -1;
         RETURN;
      END IF;
      IF d_rec# NOT LIKE '#d%' AND INSTR(d_rec#,'#D')>0 THEN
         BEGIN
            vdat_ := TO_DATE(SUBSTR(d_rec#,INSTR(d_rec#,'#D')+2,6),'YYMMDD');
         EXCEPTION WHEN OTHERS THEN
            err_ := 0983;
            rec_ :=   -1;
            RETURN;   -- Некоректна "дата валютування"
         END;
      END IF;

      IF koda_=6 AND (INSTR(d_rec#,'#!')+INSTR(d_rec#,'#-')+INSTR(d_rec#,'#+')+
                      INSTR(d_rec#,'#?')+INSTR(d_rec#,'#*')>0) THEN
         IF NOT (s_>0 AND dk_=MOD(INSTR('!-+?*',SUBSTR(d_rec#,2,1)),2)+2
            AND d_rec# LIKE '#___________________#'
            AND INSTR(G_ssp_delim||'.',SUBSTR(d_rec#,11,1))>0
            AND INSTR(G_ssp_fchar||'0',SUBSTR(d_rec#,12,1))>0
            AND TRANSLATE(SUBSTR(d_rec#,4,11),chr(0)||G_ssp_delim||'.',chr(0)) IS NULL
           ) THEN
            err_ := 0984;     -- Невірно заповнено запит/відповідь
            rec_ :=   -1;
            RETURN;
         END IF;
      END IF;
-- проверка на наличие символа кассплана при импорте кассовых документов
      IF kv_=gl.BaseVal                   -- гривна
         and mfoa_=gl.aMFO and mfob_=gl.aMFO    -- внутренние
         and substr(nlsb_,1,4) in ('1001','1002','1003','1004') then -- кассовые
         if d_rec# not like '%#CSK__#%' then         -- символа кассплана нет
            err_ := 9311;
            rec_ :=   -1;
            RETURN;        -- отсутствует символ кассплана
         else
            -- проверка на корректность символа кассплана
            begin
              sk_ := TO_NUMBER(SUBSTR(d_rec#,INSTR(d_rec#,'#CSK')+4,2));
              if sk_ is null or dk_=0 and sk_>=40 or dk_=1 and sk_<40 then
                 err_ := 9321;
                 rec_ :=   -1;
                 RETURN;   -- неверный символ кассплана
              end if;
            exception when others then
               err_ := 9321;
               rec_ :=   -1;
               RETURN;     -- неверный символ кассплана
            end;
         end if;
      END IF;
-- общие проверки
      IF bis_ IN (0,1) THEN
         tmp_:=d_rec#;
      ELSE
         tmp_:=nazn#||d_rec#;
      END IF;

      if deb.debug then
         deb.trace(8,'tmp_',tmp_);
      end if;
-- проверим общий синтаксис доп.реквизитов на шаблон
-- #K1<значение реквизита 1>#K2<значение реквизита 2>...#
      if tmp_='#' then     -- короткое поле ?
         err_ := 0931; rec_ := -1; RETURN;
      end if;

      FOR i IN 1..7 LOOP
        if INSTR(tmp_,'#'||SUBSTR('nBCDNфФ',i,1), 1, 2)>0 then -- Допоміжний реквізит вказано двічі
           err_ := 0932; rec_ := -1; RETURN;
        end if;
      END LOOP;

      i := instr(tmp_,'#');
      while i>0 loop
         if i=length(tmp_) then EXIT; end if;
         if substr(tmp_,i,2)='#d' and substr(tmp_,i+52,1)='#' then
            exit;                               -- ЦП не проверяем
         end if;
         if substr(tmp_,i+1,1)='#' then         -- второй символ '#' ?
            err_ := 0931; rec_ := -1; RETURN;
         end if;
         if substr(tmp_,i+2,1)=' ' AND kodb_=3 then  -- рекв. нач. с пробела ?
            err_ := 0966; rec_ := -1; RETURN;
         end if;
         j := instr(tmp_,'#',i+2);
         if j=0 then                            -- отсутсвует завершающий '#'
            err_ := 0931; rec_ := -1; RETURN;
         end if;
         if j-i<3 then                          -- значение реквизита пустое
            err_ := 0966; rec_ := -1; RETURN;
         end if;
         if substr(tmp_,j-1,1)=' ' AND kodb_=3 then  -- рекв. конч. пробелом ?
            err_ := 0966; rec_ := -1; RETURN;
         end if;
-- проверка конкретных доп. реквизитов
-- #F
         if substr(tmp_,i,2)='#F' then
-- проверка на соответствие формату #F<TAG>:<VALUE>#
            k := instr(tmp_,':',i+2);
            if k=0 or k>j or k-i<3 then
               err_ := 0953; rec_ := -1; RETURN;
            end if;
         end if;
-- проверка символа доп.реквизита на наличие в справочнике
         begin
            select 1 into k from s_nr where k_rk=substr(tmp_,i+1,1);
         exception when no_data_found then
            err_ := 0933; rec_ := -1; RETURN;
         end;
         i := j;
      end loop;
-- Реквизиты 1-4, 7-13, 18-21 должны совпадать с рекв. основной строки БИС
      if bis_=1 then -- основная строка
         main_bis.mfoa  := mfoa_;
         main_bis.nlsa  := nlsa_;
         main_bis.mfob  := mfob_;
         main_bis.nlsb  := nlsb_;
         main_bis.vob   := vob_;
         main_bis.nd    := nd_;
         main_bis.kv    := kv_;
         main_bis.datd  := data_;
         main_bis.datp  := datp_;
         main_bis.nam_a := nam_a_;
         main_bis.nam_b := nam_b_;
         main_bis.id_a  := id_a#;
         main_bis.id_b  := id_b#;
         main_bis.ref_a := case when length(ref_a_)>9 then substr(ref_a_, -9) else ref_a_ end;
         main_bis.id_o  := id_o_;
      elsif bis_>1 then
         if main_bis.mfoa  <> mfoa_
         or main_bis.nlsa  <> nlsa_
         or main_bis.mfob  <> mfob_
         or main_bis.nlsb  <> nlsb_
         or main_bis.vob   <> vob_
         or main_bis.nd    <> nd_
         or main_bis.kv    <> kv_
         or main_bis.datd  <> data_
         or main_bis.datp  <> datp_
         or main_bis.nam_a <> nam_a_
         or main_bis.nam_b <> nam_b_
         or main_bis.id_a  <> id_a#
         or main_bis.id_b  <> id_b#
         or main_bis.ref_a <> case when length(ref_a_)>9 then substr(ref_a_, -9) else ref_a_ end
         or main_bis.id_o  <> id_o_
         then
            if deb.debug then
               deb.trace(8,'Не совпадают реквизиты основной и текущей строки БИС. Строка № '||to_char(rec_a_),'');
               deb.trace(8,'---------------------------------------------------------------------------------','');
               deb.trace(8,'main_bis.mfoa='''||main_bis.mfoa||''', mfoa_='''||mfoa_||'''','');
               deb.trace(8,'main_bis.nlsa='''||main_bis.nlsa||''', nlsa_='''||nlsa_||'''','');
               deb.trace(8,'main_bis.mfob='''||main_bis.mfob||''', mfob_='''||mfob_||'''','');
               deb.trace(8,'main_bis.nlsb='''||main_bis.nlsb||''', nlsb_='''||nlsb_||'''','');
               deb.trace(8,'main_bis.vob='''||main_bis.vob||''', vob_='''||vob_||'''','');
               deb.trace(8,'main_bis.nd='''||main_bis.nd||''', nd_='''||nd_||'''','');
               deb.trace(8,'main_bis.kv='''||main_bis.kv||''', kv_='''||kv_||'''','');
               deb.trace(8,'main_bis.datd='''||to_char(main_bis.datd,'YYYYMMDD')||''', data_='''||to_char(data_,'YYYYMMDD')||'''','');
               deb.trace(8,'main_bis.datp='''||to_char(main_bis.datp,'YYYYMMDD')||''', datp_='''||to_char(datp_,'YYYYMMDD')||'''','');
               deb.trace(8,'main_bis.nam_a='''||main_bis.nam_a||''', nam_a_='''||nam_a_||'''','');
               deb.trace(8,'main_bis.nam_b='''||main_bis.nam_b||''', nam_b_='''||nam_b_||'''','');
               deb.trace(8,'main_bis.id_a='''||main_bis.id_a||''', id_a_='''||id_a#||'''','');
               deb.trace(8,'main_bis.id_b='''||main_bis.id_b||''', id_b_='''||id_b#||'''','');
               deb.trace(8,'main_bis.ref_a='''||main_bis.ref_a||''', ref_a_='''||ref_a_||'''','');
               deb.trace(8,'main_bis.id_o='''||main_bis.id_o||''', id_o_='''||id_o_||'''','');
               deb.trace(8,'---------------------------------------------------------------------------------','');
            end if;
            err_ := 0946;
            rec_ :=   -1;
            RETURN;
         end if;
      end if;
      IF bis_=1 THEN
-- дополнительная проверка по просьбе Ощадбанка
-- инвалюта на SWIFT должна содержать обязательно #Bnn#fMT nnn# в первой строке
         BEGIN
            SELECT tip INTO sw_acc_tip FROM accounts WHERE kv=kv_ AND nls=nlsb_;
         EXCEPTION WHEN NO_DATA_FOUND THEN sw_acc_tip := NULL;
         END;
         IF sw_acc_tip='TSW' AND dk_ IN (0,1) THEN   -- счет Б типа TSW и платеж реальный
            IF d_rec# NOT LIKE '#B__#fMT ___%' THEN  -- должен быть свифтовкой
               err_ := 9613;
               rec_ :=   -1;
               RETURN;   -- Mandatory fields #Bnn#fMT nnn# not found
            END IF;
         END IF;
         IF d_rec# LIKE '#B__#fMT ___%' THEN
-- проверка на допустимые типы сообщений
            IF SUBSTR(d_rec#,10,3) NOT IN ('103','202') then
               err_ := 9602;
               rec_ :=   -1;
               RETURN;     -- Illegal SWIFT Message Type
            END IF;
-- реквизит #N - Код операции (для 1-ПБ)     ;;;;;
            IF INSTR(d_rec#,'#N')>0 THEN
               transcode_:=SUBSTR(d_rec#,INSTR(d_rec#,'#N')+2,7);
               BEGIN
                  SELECT 1 INTO k FROM bopcode WHERE transcode=transcode_;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  err_ := 9614;
                  rec_ :=   -1;
                  RETURN;       -- 1PB transcode not found
               END;
            ELSE
               err_ := 9614;
               rec_ :=   -1;
               RETURN;       -- 1PB transcode not found
            END IF;
-- реквизит #nО - Код страны (для 1-ПБ)
            IF INSTR(d_rec#,'#nО')>0 THEN
               iso_countr_:=SUBSTR(d_rec#,INSTR(d_rec#,'#nО')+3,3);
               BEGIN
                  SELECT 1 INTO k FROM bopcount
                   WHERE iso_countr=iso_countr_ OR kodc=iso_countr_;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  err_ := 9615;
                  rec_ :=   -1;
                  RETURN;    -- 1PB country not found
               END;
            ELSE
               err_ := 9615;
               rec_ :=   -1;
               RETURN;    -- 1PB country not found
            END IF;
         END IF;
      END IF;
   END IF;  -- (fn_a_ is not null)   документ входящий ?
-- ----------------------------------------------------------------
   IF otm_=0 THEN
      sos_ := 1;                          -- Just inserted, not payed
   ELSE
      sos_ := 3;                          -- Already payed, as a file
   END IF;
-- ----------------------------------------------------------------
   IF otm_=3 THEN
      pm_:=0;                             -- Оплата по-документно
   END IF;
-- ----------------------------------------------------------------
   SAVEPOINT insep0;
-- ----------------------------------------------------------------
   IF pm_=0 THEN sos_ := 3;    -- Every-document payment
-- ----------------------------------------------------------------
      IF koda_=2 AND fn_a_ IS NULL THEN
         otm_ := 2;           -- Our docs had been payed alredy
      END IF;

-- SSP -- SSP -- SSP -- SSP -- SSP -- SSP -- SSP -- SSP -- SSP -- SSP
      IF otm_=3 THEN
         BEGIN  -- looking for doc been already stored
            IF ssp_source='A' THEN
               SELECT rec,fn_a INTO rec_,fn_a#
                 FROM arc_rrp
                WHERE fn_b=fa_name_ AND bis=bis_ AND dat_b>=gl.bDATE AND dat_b<gl.bDATE+1;
            ELSIF ssp_source='B' THEN
               SELECT rec,fn_a INTO rec_,fn_a#
                 FROM arc_rrp
                WHERE fa_name=fa_name_ AND bis=bis_ AND dat_a>=gl.bDATE AND dat_a<gl.bDATE+1;
            ELSE
               rec_:=NULL; fn_a#:=NULL; -- для плетежей филиалов по модели 1(4,7), ssp_source in ('a','b')
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN rec_:=NULL; fn_a#:=NULL;
         END;

         sde_ := 0; skr_ := 0;

         IF    dk_ = 1 THEN  skr_ := s_;
         ELSIF dk_ = 0 THEN  sde_ := s_;
         END IF;

         IF ssp_source IN ('A','B') AND fn_a# IS NULL AND fn_a_ IS NOT NULL THEN
            UPDATE zag_a SET n=n+1,skr=skr+skr_,sde=sde+sde_ WHERE fn=fn_a_ AND dat=dat_a_;
            IF SQL%ROWCOUNT = 0 THEN
               INSERT INTO zag_a(kv, fn,   dat,   n,sde, skr, otm, datk , dat_2 )
                          VALUES(kv_,fn_a_,dat_a_,1,sde_,skr_, 5,SYSDATE,SYSDATE);
            END IF;
         END IF;

         IF ssp_source='A' THEN   -- Own outward SSP docs
            IF rec_ IS NULL THEN
               err_:=1108;
               rec_:=  -1;
               RETURN;
            ELSE
               ps_grc(err_,'RT0',fa_name_,gl.bDATE,1,sde_,skr_,0,-1);
               IF err_<>0 THEN RETURN; END IF;
            END IF;
         END IF;

         IF rec_ IS NOT NULL THEN
            IF fn_a# IS NULL AND fn_a_ IS NOT NULL THEN
               UPDATE arc_rrp SET fn_a=fn_a_,dat_a=dat_a_,rec_a=rec_a_
               WHERE rec=rec_;
            END IF;
            err_:=0701;
            RETURN;
         END IF;
      END IF;
-- ----------------------------------------------------------------
      IF otm_<>2 THEN         -- FeedBack Documents cannot be payed
         p_doc('R00',gl.bDATE,dk_,kv_,koda_,mfo_a_,nlsa_,kodb_,mfo_b_,nlsb_,s_,ref_,NULL,NULL);
         IF otm_=3 AND ref_ IS NOT NULL THEN
            UPDATE opldok SET txt=fa_name_ WHERE ref=ref_; ref_:=NULL;
         END IF; -- 2nd move is due
      END IF;
-- ----------------------------------------------------------------
      IF koda_=4 OR koda_=2 AND fn_a_ IS NOT NULL AND mfoa_=gl.aMFO
--endif
      THEN
/*ifdef NBU
-- *OPERU-NBU*****OPERU-NBU*****OPERU-NBU*****OPERU-NBU*****OPERU-NBU*
         IF tip_='LIK' AND ref_ IS NOT NULL THEN
            BEGIN
               IF SUBSTR(nazn#,1,1)>='0' AND SUBSTR(nazn#,1,1)<='9' AND
                  SUBSTR(nazn#,2,1)>='0' AND SUBSTR(nazn#,2,1)<='9'
               THEN
                  SELECT VKRZN(SUBSTR(gl.aMFO,1,5),'00000'||rr||SUBSTR(nazn#,1,2))
                    INTO nls_lik_
                    FROM lik_rr_mfo WHERE mfo IN (mfok_,SUBSTR(nazn#,4,6));
               ELSE
                  err_ := 9300;
                  rec_ :=   -1;
                  ROLLBACK TO insep0; RETURN;
               END IF;

            EXCEPTION WHEN NO_DATA_FOUND OR TOO_MANY_ROWS THEN
               err_ := 9300;
               rec_ :=   -1;
               ROLLBACK TO insep0; RETURN;
            END;
            gl.payv(1,ref_,gl.bDATE,'LIK',1,kv_,nls_lik_,s_,kv_,VKRZN(SUBSTR(gl.aMFO,1,5),'00006'),s_);
         END IF;
-- *OPERU-NBU*****OPERU-NBU*****OPERU-NBU*****OPERU-NBU*****OPERU-NBU*
endif
*/
         IF  ref_ IS NOT NULL THEN
             UPDATE oper
                SET userid=DECODE(NVL(userid,0),0,gl.aUID,userid),
                   kv=kv_,s=s_,kv2=kv_,s2=s_,
                   dk=dk_,mfoa=mfoa_,nlsa=nlsa_,mfob=mfob_,nlsb=nlsb_,
                 vob=vob_,datd=data_,datp=datp_,id_a=id_a#,id_b=id_b#,
                 ref_a=case when length(ref_a_)>9 then substr(ref_a_, -9) else ref_a_ end,id_o=id_o_,sign=sign_,
                 nd    = nd_,
                 nam_a = nam_a_, nam_b = nam_b_,
                 nazn  = nazn# , d_rec = d_rec#
              WHERE ref=ref_;
         END IF;
      END IF;   -- from file docs
-- ----------------------------------------------------------------
   END IF;   -- Every-document payment
-- ----------------------------------------------------------------

   IF G_nosign_kod IS NOT NULL AND
             sign_ IS     NULL AND
             fn_a_ IS NOT NULL THEN
      blk_ := G_nosign_kod;
   END IF;

   rec_ := bars_sqnc.get_nextval('s_arc_rrp');
   logger.info('BIS1'||rec_);

   BEGIN                           -- Assure it is unique document
      IF koda_=2 AND (bis_=0 OR bis_=1) AND (dk_=0 OR dk_=1) THEN
         INSERT INTO ref_lst (datd, nd, mfoa, nlsa, mfob, nlsb, s, ref, rec )
                      VALUES (data_,nd_,mfoa_,nlsa_,mfob_,nlsb_,s_,ref_,rec_);
      END IF;
   EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
      BEGIN
         SELECT blk INTO i FROM arc_rrp
          WHERE rec = (SELECT rec FROM ref_lst WHERE s=s_ AND datd=data_
                          AND nd=nd_ AND mfoa=mfoa_ AND nlsa=nlsa_ AND
                                         mfob=mfob_ AND nlsb=nlsb_ );
         IF NVL(i,0)>=0 THEN blk_ := 9122; END IF;
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
      UPDATE ref_lst SET rec=rec_,ref=ref_ WHERE s=s_ AND datd=data_
                          AND nd=nd_ AND mfoa=mfoa_ AND nlsa=nlsa_ AND
                                         mfob=mfob_ AND nlsb=nlsb_;
   END;

   IF mfob_=gl.aMFO AND nlsb_=G_nls_T00 THEN blk_ := 9305; END IF;

-------------------------------------------------------------------

   INSERT INTO arc_rrp ( rec, ref,
          mfoa,nlsa,mfob,nlsb,dk,s,vob,nd,kv,datd,datp,
          nam_a,nam_b,nazn,naznk,nazns,id_a,id_b,id_o,ref_a,bis,
          sign,fn_a,rec_a,dat_a,d_rec,sos,blk,fa_name,fa_ln,prty
          )
   VALUES (rec_,ref_,
          mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,data_,datp_,
          nam_a_,nam_b_,nazn#,naznk#,nazns_,id_a#,id_b#,id_o_,case when length(ref_a_)>9 then substr(ref_a_, -9) else ref_a_ end,bis_,
          sign_,fn_a_,rec_a_,dat_a#,d_rec#,sos_,blk_,
          fa_name_,fa_ln_,CASE WHEN otm_=3 THEN 1 ELSE 0 END
          );

   logger.info('BIS2'||rec_);

   err_ := 0;

-- Put IN payment queue
   IF    bis_ = 0 THEN G_rec_g := NULL; G_dat_a := NULL;
   ELSIF bis_ = 1 THEN G_rec_g := rec_; G_dat_a := dat_a#;
   END IF;
   IF ref_=gl.aREF THEN fmcheck_:=gl.aFMcheck; ELSE fmcheck_:=0; END IF;

   INSERT INTO rec_que(rec,rec_g,otm,fmcheck) VALUES (rec_,G_rec_g,0,fmcheck_);
-- Put IN request queue
   IF s_>0 AND (dk_=2 OR dk_=3) AND koda_ in (2,3,4,5,6) THEN
      i := INSTR('!+*-',SUBSTR(d_rec#,2,1)) ;

      IF dk_=2 AND i=4 OR dk_=3 AND i IN (1,2,3) THEN
         BEGIN
            SELECT a.rec,a.s,a.mfoa,a.nd,a.vob,a.nlsb,a.id_b
              INTO j,ot_s_,ot_mfoa_,ot_nd_,ot_vob_,ot_nlsb_,ot_id_b_
              FROM arc_rrp a,t902 t
             WHERE a.rec=t.rec AND
               a.fa_name=SUBSTR(d_rec#,3,12) AND a.fa_ln=SUBSTR(d_rec#,15,6) AND
                a.dat_a>=ADD_MONTHS(gl.bDATE,-1);
            IF NOT(
               s_=ot_s_ AND mfoa_=ot_mfoa_ AND nd_=ot_nd_ AND vob_=ot_vob_ AND
               (nlsb_=ot_nlsb_ OR id_b_=ot_id_b_))
            THEN
               i:=5;
            END IF;
            UPDATE t902 SET otm=i+1,dat=gl.bDATE,rec_o=rec_ WHERE rec=j;
         EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
         END;
      ELSE
         INSERT INTO tzapros (rec) VALUES (rec_);
      END IF;
   END IF;
   IF fn_a_ IS NOT NULL AND koda_<>3 then -- документ входящий и НЕ от НБУ?
--#B10#fMT 100#  SWIFT messages
      IF    bis_=0 THEN G_swtype := NULL;
      ELSIF bis_=1 THEN swt.DELETE;
         IF d_rec# LIKE '#B__#fMT ___%' THEN
            G_swtype := SUBSTR(d_rec#,10,3);
         ELSE
            G_swtype := NULL;
         END IF;
      END IF;

      IF bis_>1 AND G_swtype IS NOT NULL THEN

         tmp_:=nazn#||d_rec#;

         IF deb.debug THEN
            deb.trace(8,'tmp_',tmp_);
         END IF;
-- обработка свифтовых полей
         i:=INSTR(tmp_,'#F');
         WHILE i>0 LOOP   -- обработка подряд идущих #F<TAG>:<VAL>#F<TAG>:<VAL>#
            tmp_:=SUBSTR(tmp_,i+2);
            i:=INSTR(tmp_,'#');
            IF i>0 THEN
               j:=INSTR(tmp_,':');

               val_:=SUBSTR(tmp_,j+1,i-j-1);
               tag_:=SUBSTR(tmp_,1,j-1);

               IF deb.debug THEN
                  deb.trace(8,tag_,val_);
               END IF;

-- проверка является ли тэг корректным свифтовым тэгом
               begin
                  select 1 into k from op_field where tag=rpad(tag_,5) and vspo_char='F';
               exception when no_data_found then goto next#F;
               end;

               IF swt.EXISTS(tag_) THEN
                  swt(tag_).val:=SUBSTR(swt(tag_).val||CHR(13)||CHR(10)||val_,1,200);
                  swt(tag_).rec:=swt(tag_).rec||','||rec_a_;
               ELSE
                  swt(tag_).val:=val_;
                  swt(tag_).rec:=rec_a_;
               END IF;

            END IF;
<<next#F>>
            i:=INSTR(tmp_,'#F');
         END LOOP; -- WHILE i>0 LOOP
      END IF;
   END IF;  -- (fn_a_ is not null)   документ входящий ?

EXCEPTION WHEN OTHERS THEN info(SQLERRM);
 ROLLBACK TO insep0;
   IF SQLCODE=100 THEN
      raise_application_error(-(20000+ern),'\9133 - Cannot execute #in_sep',TRUE);
   ELSE
      RAISE;
   END IF;
END in_sep;

-- разбор строки сообщения об ошике в поле/документе SWIFT
-- с выдачей ошибки СЭП
function parse_swift_exception(p_errno in number, p_errmsg in varchar2) return number is
  tmp_buf     varchar2(1024);
  app_err     number;
  swt_err     varchar2(3);
  i           integer;
  ret_err     number;
begin
   tmp_buf := '';
   if substr(p_errmsg,12,1)=chr(92) then -- в сообщении есть прикладной код
      i := 13;
      while i<length(p_errmsg) and substr(p_errmsg,i,1) in ('0','1','2','3','4','5','6','7','8','9')
      loop
         tmp_buf := tmp_buf || substr(p_errmsg,i,1);
         i := i+1;
      end loop;
      app_err := to_number(tmp_buf);
      if length(tmp_buf)>0 then  -- прикладной код присутствует
         case app_err
            when 905 then ret_err := 9604;
            when 906 then ret_err := 9610;
            when 930 then ret_err := 9603;
            when 931 then ret_err := 9601;
            else ret_err := 9604;
         end case;
      else -- общая ошибка
         ret_err := 9604;
      end if;
   elsif substr(p_errmsg,15,1)=':' then -- свифтовый код
      swt_err := substr(p_errmsg,12,3);
      case swt_err
         when 'E18' then ret_err := 9605;
         when 'T42' then ret_err := 9606;
         when 'T47' then ret_err := 9606;
         when 'E44' then ret_err := 9606;
         when 'D98' then ret_err := 9607;
         when 'D67' then ret_err := 9608;
         when 'E46' then ret_err := 9609;
         when 'C81' then ret_err := 9611;
         when 'D97' then ret_err := 9612;
         else ret_err := 9604;
      end case;
   end if;
   return ret_err;
end parse_swift_exception;
-- Перенаправление заблокированных документов из СЕП/ВПС на СВИФТ
PROCEDURE sep2swt(rec_ NUMBER) IS

nls_swt VARCHAR2(14) :='191992';
dat_    DATE         := TO_DATE  (TO_CHAR(gl.bDATE,'MM-DD-YYYY')||' '||
                        TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');
ref_    NUMBER;
ern       CONSTANT POSITIVE := 059;
erm       VARCHAR2(80);
err       EXCEPTION;

BEGIN

   BEGIN
      SELECT nls INTO nls_swt FROM accounts
       WHERE tip='TSW' AND kv='980' AND dazs IS NULL AND rownum=1;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      erm := '9129 - No SWIFT transit account found# (980,TSW) ';
      raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
   END;

FOR c IN (SELECT arc_rrp.* FROM arc_rrp,rec_que
           WHERE dk = 1 AND kv = 980 AND arc_rrp.rec=rec_que.rec
             AND bis IN (0,1) AND fn_b IS NULL AND sos = 3
             AND arc_rrp.rec = rec_   AND blk > 0
      FOR UPDATE OF dat_b,sos,blk,ref NOWAIT)
LOOP
    BEGIN
       if deb.debug then deb.trace(1,'2 SWT Started ref#',c.rec); end if;
       IF c.ref IS NULL THEN gl.ref(ref_);
          gl.in_doc2 (ref_,'R01',c.vob,c.nd,SYSDATE,gl.bDATE,
                   c.dk, c.kv, c.s, c.kv, c.s, NULL, NULL, c.datd, c.datp,
                   c.nam_a, c.nlsa, c.mfoa, c.nam_b, c.nlsb, c.mfob,
                   c.nazn, c.d_rec, c.id_a, c.id_b, c.id_o, c.sign, 0,
                   c.prty,NULL);
       ELSE
          ref_ := c.ref;
       END IF;

       gl.payv(1,ref_, gl.bDATE, 'R01',c.dk,c.kv,G_nls_T00,c.s,c.kv,nls_swt,c.s);

       INSERT INTO operw (REF, TAG, VALUE)
       VALUES (ref_, '59', '/'||c.nlsb||CHR(13)||CHR(10)||c.nam_b);
       INSERT INTO operw (REF, TAG, VALUE)
       VALUES (ref_, '71A', 'OUR');
       INSERT INTO operw (REF, TAG, VALUE)
       VALUES (ref_, 'NOS_A', '0');
       INSERT INTO operw (REF, TAG, VALUE)
       VALUES (ref_, 'f', 'MT 103');

       IF c.bis=0 THEN
          UPDATE arc_rrp SET ref=ref_,dat_b=dat_,sos=5,blk=0 WHERE rec=c.rec;
          DELETE FROM rec_que WHERE rec=c.rec; -- Remove From Que
       ELSE
          UPDATE arc_rrp SET ref=ref_,dat_b=dat_,sos=5,blk=0
           WHERE bis>0
             AND rec IN (SELECT rec FROM rec_que WHERE rec_g=c.rec AND rec_g IS NOT NULL);
          DELETE FROM rec_que WHERE rec_g=c.rec AND rec_g IS NOT NULL;
       END IF;
       if deb.debug then deb.trace(1,'2 SWT Finished rec#',c.rec); end if;
     END;
END LOOP;
END;
/***************************************************************/
/***  валидация БИСов                                                       ***/
/***************************************************************/
PROCEDURE validate_bis(
   err_             OUT  INTEGER,  -- Return code
   ln_list_      OUT VARCHAR2,  -- Номера строк, на которые выдается ошибка n1,n2,n3
   err_msg_         OUT VARCHAR2,  -- Сообщение об ошибке
   rec_      INTEGER,   -- Record number
   fn_a_    CHAR,      -- Input file namea
   dat_a_    DATE,      -- Input file date/time
   rec_a_    SMALLINT   -- Input file record number
  ) is

    swift_validation_error EXCEPTION;
    PRAGMA EXCEPTION_INIT(swift_validation_error, -20782);

    swift_not_implemented EXCEPTION;
    PRAGMA EXCEPTION_INIT(swift_not_implemented, -20999);

  ern         CONSTANT POSITIVE := 099;
  erm         VARCHAR2(80);
  err         EXCEPTION;
  sys_err     EXCEPTION;
  d_rec_      arc_rrp.d_rec%type;
--  ref_        arc_rrp.ref%type;
  l_dk        arc_rrp.dk%type;
  tag_        operw.tag%type;
  val_        operw.value%type;
  v_tag       sw_tag.tag%type;
        x           bars_swift_msg.t_doc;
  v_opt       varchar2(1);
  tmp_buf     varchar2(1024);
  i           integer;
  pos         integer;
  pos_end     integer;
  mask        varchar2(64);
begin
   logger.info('BIS'||rec_);

   if deb.debug then
      deb.trace(ern, 'Validate_bis(): rec_  = ',rec_ );
      deb.trace(ern, 'Validate_bis(): fn_a_ = ',fn_a_);
      deb.trace(ern, 'Validate_bis(): dat_a_= ',to_char(dat_a_,'YYYY-MM-DD HH24:MI'));
      deb.trace(ern, 'Validate_bis(): rec_a_= ',rec_a_);
   end if;

   err_     := 0;
   ln_list_ := NULL;
   err_msg_ := NULL;


   select ref,'R00',vob,nd,kv,dk,s,datd,datp,
          nam_a,nlsa,mfoa,nam_b,nlsb,mfob,nazn,d_rec,sos,ref_a,
          CASE WHEN INSTR(d_rec,'#D')>0
          THEN TO_DATE(SUBSTR(d_rec,INSTR(d_rec,'#D')+2,6),'YYMMDD')
          ELSE gl.bDATE END,
          d_rec, dk
     into x.docrec.ref,x.docrec.tt,x.docrec.vob,x.docrec.nd,
          x.docrec.kv, x.docrec.dk,x.docrec.s,x.docrec.datd,x.docrec.datp,
          x.docrec.nam_a,x.docrec.nlsa,x.docrec.mfoa,
          x.docrec.nam_b,x.docrec.nlsb,x.docrec.mfob,x.docrec.nazn,
          x.docrec.d_rec,x.docrec.sos, x.docrec.ref_a,
          x.docrec.vdat, d_rec_, l_dk
     from arc_rrp where rec=rec_;

   IF d_rec_ LIKE '#B__#fMT ___%' THEN

-- идем по свифтовым тэгам и проверяем их
      tag_ := swt.FIRST;
      WHILE tag_ IS NOT NULL LOOP
         begin

            x.doclistw(tag_).value:=swt(tag_).val;

            v_tag := SUBSTR(TRIM(tag_),1,2);
            v_opt := SUBSTR(TRIM(tag_),3,1);
            if deb.debug then
               deb.trace(ern, 'Validate_bis(): tag='||v_tag||',opt='||v_opt,swt(tag_).val);
            end if;
            bars_swift.validate_field(v_tag,v_opt,swt(tag_).val,1);
            if deb.debug then
               deb.trace(ern, 'Validate_bis(): success','');
            end if;
         exception
            when swift_validation_error or bars_error.err then
               if deb.debug then
                  deb.trace(ern, 'Validate_bis(): error: ',SQLERRM);
               end if;
               err_     := parse_swift_exception(SQLCODE, SQLERRM);
               err_msg_ := substr(SQLERRM, 12);
               if deb.debug then
                  deb.trace(ern, 'Validate_bis(): parsed code: '||err_,'');
               end if;
               ln_list_ := swt(tag_).rec;
               RETURN;
            when swift_not_implemented then
-- не реализовано => трактуем как ошибку синтаксиса
               if deb.debug then
                  deb.trace(ern, 'Validate_bis(): swift_not_implemented: ',SQLERRM);
               end if;
               err_     := 9601;
               err_msg_ := substr(SQLERRM, 12);
               RETURN;
         end;
         tag_ := swt.NEXT(tag_);
      END LOOP;
   ELSE
      RETURN;
   END IF;

-- валидация документа в целом
   if deb.debug then
      deb.trace(ern, 'Validate_bis(): whole document validation:','');
   end if;
   begin
      bars_swift_msg.docmsg_document_validate(x);
   exception
      when swift_validation_error or bars_error.err then
         if deb.debug then
            deb.trace(ern, 'Validate_bis(): error: ',SQLERRM);
         end if;
         err_     := parse_swift_exception(SQLCODE, SQLERRM);
         ln_list_ := to_char(rec_a_);  -- ошибку на БИС в целом выдаем по 1-ой строке блока
         err_msg_ := substr(SQLERRM, 12);
         if deb.debug then
            deb.trace(ern, 'Validate_bis(): parsed code: '||err_,'');
            deb.trace(ern, 'Validate_bis(): error lines: '||ln_list_,'');
         end if;
         return;
      when swift_not_implemented then
-- не реализовано => трактуем как ошибку синтаксиса
         if deb.debug then
            deb.trace(ern, 'Validate_bis(): swift_not_implemented: ',SQLERRM);
         end if;
         err_ := 9601;
         ln_list_ := to_char(rec_a_);
         err_msg_ := substr(SQLERRM, 12);
         return;
   end;
   if deb.debug then
      deb.trace(ern, 'Validate_bis(): finish','');
   end if;
exception
   when err then
        raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
   when sys_err then
        raise_application_error(-(20000+ern),erm,TRUE);
end validate_bis;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE pay_grc(ref_  INTEGER,    -- Reference
                   tt_  CHAR,       -- Transaction code
                  txt_  VARCHAR2,   -- Comment
                   kv_  SMALLINT,   -- Currency code
                 accd_  INT,        -- Account debet
                 acck_  INT,        -- Account credit
                    s_  DECIMAL)    -- Amount
IS
--
--  BARS98 Procedure of payment for GRC. Called from p_fil,p_doc.
--
BEGIN
   IF s_ <> 0 THEN
      gl.pay2(null,ref_,gl.bDATE,tt_,kv_,0,accd_,s_,0,1,txt_);
      gl.pay2(null,ref_,gl.bDATE,tt_,kv_,1,acck_,s_,0,0,txt_);
      gl.pay2(   2,ref_,gl.bDATE);
   END IF;
END pay_grc;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
FUNCTION ch_acc(mfo_ VARCHAR, kv_ SMALLINT, tip_ CHAR)
  RETURN INTEGER  IS
--
--  File Processing accounts genaration
--
acc_     INTEGER;
id_      SMALLINT;
nms_     VARCHAR(35);
--
ern       CONSTANT POSITIVE := 059;
erm       VARCHAR2(80);
err       EXCEPTION;

BEGIN
   IF    tip_='T00' and kv_=980 THEN
      IF G_acc_T00 IS NOT NULL THEN RETURN G_acc_T00; END IF;
   ELSIF tip_='T0D' and kv_=980 THEN
      IF G_acc_T0D IS NOT NULL THEN RETURN G_acc_T0D; END IF;
   END IF;

   SELECT a.acc INTO acc_ FROM bank_acc a, accounts b
    WHERE a.mfo=mfo_ AND b.kv=kv_ AND b.tip=tip_ AND a.acc=b.acc;
   RETURN acc_;
EXCEPTION
   WHEN NO_DATA_FOUND THEN  -- no account --> Autogenerate it
      BEGIN
         BEGIN
            acc_ := NULL;
            IF tip_='T00' OR tip_='T0D' THEN
               SELECT acc INTO acc_ FROM accounts WHERE tip=tip_ AND kv=kv_;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN acc_ := NULL;
         END;
         IF acc_ IS NULL THEN
            erm := '9129 - No account found #('||kv_||','||mfo_||','||tip_||')';
            raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
         END IF;
         INSERT INTO bank_acc ( acc, mfo ) VALUES ( acc_, mfo_ );
         RETURN acc_;
      END;
   WHEN TOO_MANY_ROWS THEN  -- more then one --> It never be happened
      erm := '9123 - DubleDefined bank_acc ('||kv_||','||mfo_||','||tip_||')';
      raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
END ch_acc;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
FUNCTION h2_rrp(i SMALLINT) RETURN CHAR IS
-- Decimal --> 32-imal
x char(1);
BEGIN
IF i>=0 AND i<=9 THEN
   x := CHR(i+48);
ELSIF i>=10 AND i<=35 THEN
   x := CHR(i+55);
ELSE
   x := '0';
END IF;
RETURN x;
END h2_rrp;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE p_doc(p_tt CHAR,vdat_ DATE,dk_ SMALLINT, kv_ SMALLINT,
          koda_ SMALLINT,mfoa_ VARCHAR,nls1_ VARCHAR,
          kodb_ SMALLINT,mfob_ VARCHAR,nls2_ VARCHAR,
       s_ DECIMAL,ref_ IN OUT INTEGER,
     rec_ NUMBER    DEFAULT NULL,
    p_tip VARCHAR2  DEFAULT NULL
) IS
--
-- BARS98 Single document payment. Called from File processing procedures.
--
--     Modification history     --
--                  23/04/98    New reference assigning method
--            (MIK) 26/06/98    Migrated from Informix
--            (MIK) 07/12/98    90D type added
--                              suspend doc ref insertion into T902
pm_     SMALLINT:= 0;        -- Podokumentno
mfo_    VARCHAR(12);
mas_    VARCHAR2(15);
nls_    VARCHAR2(15);
nlsalt_ VARCHAR2(15);
nl_     VARCHAR2(15);
nlst_    VARCHAR2(15);

tt_     VARCHAR2(3) := p_tt;
tip_    VARCHAR2(3) := p_tip;
nlsa_   VARCHAR2(15):= nls1_;
nlsb_   VARCHAR2(15):= nls2_;

accd_   INTEGER;
acck_   INTEGER;
accv_   INTEGER;
t_      CHAR(3);
td_     CHAR(3);
tk_     CHAR(3);
ti_     CHAR(3):= 'NLS';           -- Acc type for internal accounts
ts_     CHAR(3):= '902';           --          for suspend  accounts
tl_     CHAR(3);
wd_     CHAR(1);
wk_     CHAR(1);
txt_    VARCHAR(70);
susp_   SMALLINT;
tipk_   CHAR(3); -- credit account type
isp_    NUMBER;
grp_    NUMBER;
rnk_    NUMBER;
tmp_    NUMBER;
nms_    VARCHAR2(70);
dk0_    NUMBER;
tt0_    CHAR(3);
sos_    NUMBER;

ern     CONSTANT POSITIVE := 035;  -- p_doc funct errcode
erm     VARCHAR2(80);
err     EXCEPTION;

sec_  accounts.sec%type;

CURSOR c0 IS
  SELECT tip_d,wd,tip_k,wk,ttl FROM TEMPLATES
  WHERE kv=kv_ AND kodn_i=koda_ AND kodn_o=kodb_ AND tt=tt_ AND pm=pm_;
--
BEGIN
--
IF s_=0 THEN
   ref_ := NULL;
   RETURN;
END IF;
--
IF dk_=0 THEN
   tt_ := 'D'||SUBSTR(tt_,2,2);
   ts_ := '90D';
END IF;
--
OPEN c0;
LOOP
  FETCH c0 INTO td_,wd_,tk_,wk_,tl_;
  EXIT WHEN c0%NOTFOUND;
    accd_ := NULL;
    acck_ := NULL;
    susp_ := 0;
                          -- Check DEBET
    IF td_ = ti_ THEN     -- account ODB
       BEGIN
        SELECT acc INTO accd_ FROM accounts WHERE nls=nlsa_ AND kv=kv_;
       EXCEPTION
          WHEN NO_DATA_FOUND THEN accd_ := ch_acc( gl.aMFO, kv_, ts_ );
          susp_ := 1;
       END;
    ELSE
       IF wd_='A' THEN    -- account RRP
          mfo_ := mfoa_;
       ELSE
          mfo_ := mfob_;
       END IF;
       accd_ := ch_acc( mfo_, kv_, td_ );
    END IF;
                          -- Check CREDIT
    IF tk_ = ti_ THEN     -- account ODB
       BEGIN
        SELECT a.acc,a.nlsalt,a.tip,a.isp, a.grp, a.nms,cu.rnk,a.sec
          INTO   acck_,nlsalt_,tipk_, isp_,  grp_,  nms_,  rnk_, sec_
          FROM accounts a,cust_acc cu
         WHERE a.acc=cu.acc AND a.nls=nlsb_ AND a.kv=kv_;
       EXCEPTION
          WHEN NO_DATA_FOUND THEN acck_ := ch_acc( gl.aMFO, kv_, ts_ );
          susp_ := 1;
       END;
    ELSE
       IF wk_='A' THEN    -- account RRP
          mfo_ := mfoa_;
       ELSE
          mfo_ := mfob_;
       END IF;
       acck_ := ch_acc( mfo_, kv_, tk_ );
    END IF;
    IF (dk_=0 OR dk_=1) AND ref_ IS NULL THEN
       gl.ref(ref_);
       INSERT INTO oper (ref, tt,    pdat, vdat,  userid)
              VALUES    (ref_,tt_,SYSDATE, vdat_, gl.aUID);
    END IF;
    IF SUBSTR(tt_,3,1)='0' THEN
       txt_ := ' 0 '||mfob_||'   '||nlsb_||' '||ref_;
    ELSE
       txt_ := ' 0 '||mfoa_||'   '||nlsa_||' '||ref_;
    END IF;

-- Another value date

    IF tk_ = ti_ AND dk_=1 AND susp_ = 0 AND vdat_>gl.bDATE THEN

IF deb.debug THEN
   deb.trace(ern,'Another value date',vdat_);
END IF;

       accv_ := NULL;

       FOR c IN (SELECT nbs,mask FROM nbs_dval) LOOP
          IF       c.nbs  = SUBSTR(nlsb_,1,4) OR
             RTRIM(c.nbs) = SUBSTR(nlsb_,1,3) OR
             RTRIM(c.nbs) = SUBSTR(nlsb_,1,2) OR
             RTRIM(c.nbs) = SUBSTR(nlsb_,1,1)
          THEN
             nl_ := '';
             mas_:= RPAD(TRIM(c.mask),15);
             nls_:= RPAD(TRIM(nlsb_) ,15);

             FOR i IN 1..15 LOOP
                IF SUBSTR(mas_,i,1)='?' OR SUBSTR(mas_,i,1)='?' THEN
                   nl_ := nl_ || SUBSTR(nls_,i,1);
                ELSE
                   nl_ := nl_ || SUBSTR(mas_,i,1);
                END IF;
             END LOOP;

IF deb.debug THEN
   deb.trace(ern,'Vdat Transit acc #',nl_);
END IF;

             BEGIN
                mas_ := VKRZN(SUBSTR(gl.aMFO,1,5),TRIM(nl_));
                SELECT acc INTO accv_
                  FROM accounts
                 WHERE nls=mas_ AND kv=kv_;
             EXCEPTION
                WHEN NO_DATA_FOUND THEN
                IF G_dval_OP = '1' THEN
                   OP_REG(99,0,0,grp_,tmp_,rnk_,mas_,kv_,nms_,'ODB',isp_,accv_);
                   UPDATE accounts SET sec=sec_,vid=99 WHERE acc=accv_;
                ELSE
                   erm := '9124 - No account found '||
                        '#'||mas_||'('||TO_CHAR(kv_)||')';
                   RAISE err;
                END IF;
             END;
             gl.pay2(null,ref_,gl.bDATE,tt_,kv_,0,accd_,s_,0,1,txt_);
             gl.pay2(null,ref_,gl.bDATE,tt_,kv_,1,accv_,s_,0,0,txt_);
             gl.pay2(null,ref_,vdat_,tt_,kv_,0,accv_,s_,0,1,txt_);
             gl.pay2(null,ref_,vdat_,tt_,kv_,1,acck_,s_,0,0,txt_);

             INSERT INTO tdval (ref,rec) VALUES (ref_,rec_);

             EXIT;
          END IF;
       END LOOP;
    END IF;

--  today-s value-date

    IF accv_ IS NULL AND (dk_=1 OR dk_=0) THEN     -- Pay it
       IF tt_='R01' AND dk_=1 AND (tip_ LIKE 'PK_' or tip_ LIKE 'W4_' or tip_ LIKE 'NLE')
       THEN
          BEGIN
             SELECT nls INTO nlst_ FROM accounts WHERE acc=accd_;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             erm := '9124 - No transit account found INT#'||accd_;
             RAISE err;
          END;

          gl.dyntt2 (sos_,0,0,ref_,gl.bDATE,gl.bDATE,CASE tip_ WHEN 'NLE' THEN 'NLE' ELSE 'R03' END,
                         dk_,kv_,mfoa_,nlst_,s_,kv_,mfob_,nlsb_,s_,0,0);
       ELSE

if gl.aMFO in('300001','300465','344443') or gl.aMFO like '8%' then
      gl.pay2(null,ref_,gl.bDATE,tt_,kv_,1-dk_,accd_,s_,0,1,txt_);
      gl.pay2(null,ref_,gl.bDATE,tt_,kv_,dk_  ,acck_,s_,0,0,txt_);
else
  gl.pay2(null,ref_,gl.bDATE,tt_,kv_,1-dk_,accd_,s_,0,1,case when g_branch is null then txt_ else g_branch end);
    gl.pay2(null,ref_,gl.bDATE,tt_,kv_,dk_  ,acck_,s_,0,0,case when g_branch is null then txt_ else g_branch end);
end if;

       END IF;
    END IF;
-- Additional treasury profit reflection
    IF tl_ IS NOT NULL AND (dk_=0 OR dk_=1) AND susp_ = 0 THEN
       IF accv_ IS NULL THEN
          gl.dyntt2 (sos_,9,0,ref_,gl.bDATE,gl.bDATE,tip_,
                     dk_,kv_,mfoa_,nlsa_,s_,kv_,mfob_,nlsb_,s_,0,0);
       ELSE
          gl.dyntt2 (sos_,9,0,ref_,vdat_,   vdat_,   tip_,
                     dk_,kv_,mfoa_,nlsa_,s_,kv_,mfob_,nlsb_,s_,0,0);
       END IF;
    END IF;
--
    gl.pay2(   2,ref_,gl.bDATE);
--
    IF  susp_ = 1 AND (dk_=0 OR dk_=1) THEN  -- Suspended account was used
       INSERT INTO t902 (ref,rec) VALUES (ref_,rec_);
    END IF;

END LOOP;
CLOSE c0;
EXCEPTION
   WHEN err THEN
        raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
END p_doc;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE p_fil(p_tt CHAR, fn_ CHAR,
             kv_ SMALLINT, koda_ SMALLINT, mfoa_ VARCHAR,
                           kodb_ SMALLINT, mfob_ VARCHAR,
             sde_ DECIMAL, skr_ DECIMAL,ref_ IN OUT INTEGER) IS

--
--  BARS98 Single file payment. Called from File processing procedures.
--
--     Modification history     --
--                  23/04/98    New reference assigning method
--            (MIK) 15/09/98    Migrated from Informix
accd_   INTEGER;
acck_   INTEGER;
pm_     SMALLINT;
mfo_    VARCHAR2(12);
td_     CHAR(3);
tk_     CHAR(3);
tt_     CHAR(3);
t_      CHAR(1);
wd_     CHAR(1);
wk_     CHAR(1);
comm_   VARCHAR2(70);
CURSOR c0 IS
  SELECT tip_d,wd,tip_k,wk,comm
    FROM TEMPLATES
   WHERE kv=kv_ AND kodn_i=koda_ AND kodn_o=kodb_ AND tt=tt_ AND pm=pm_;

BEGIN

pm_  := 1;   -- Pofailivo
tt_  := p_tt;

FOR i_ IN 1..2
LOOP
  IF i_=1 THEN t_ := 'R'; ELSE t_ := 'D'; END IF;

  IF t_='D' AND sde_<>0 OR t_='R' AND skr_<>0 THEN
     tt_ := t_||SUBSTR(tt_,2,2);

     OPEN c0;
     LOOP
       FETCH c0 INTO td_,wd_,tk_,wk_,comm_;
       EXIT WHEN c0%NOTFOUND;
         accd_ := NULL;
         acck_ := NULL;

         IF wd_='A' THEN
            mfo_ := mfoa_;
         ELSE
            mfo_ := mfob_;
         END IF;
                        -- Check DEBET
         accd_ := ch_acc( mfo_, kv_, td_ );

         IF wk_='A' THEN
            mfo_ := mfoa_;
         ELSE
            mfo_ := mfob_;
         END IF;
                        -- Check CREDIT
         acck_ := ch_acc( mfo_, kv_, tk_ );
         IF ref_ IS NULL THEN
            gl.ref(ref_);
            INSERT INTO oper (ref, tt, pdat,       vdat, userid)
                    VALUES   (ref_,tt_,SYSDATE,gl.bDATE, gl.aUID);
         END IF;

         IF t_='D' THEN
            pay_grc(ref_,tt_,fn_,kv_,acck_,accd_,sde_);
         END IF;
         IF t_='R' THEN
            pay_grc(ref_,tt_,fn_,kv_,accd_,acck_,skr_);
         END IF;
     END LOOP;
     CLOSE c0;
  END IF;
END LOOP;
END p_fil;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE p_kwt(err_ OUT SMALLINT,
                 fn_     CHAR,
                dat_     DATE,
              rec_a_     SMALLINT,
               errk_     SMALLINT) IS
--
--   Blocking of rejected document(s). Called from File processing programm.
--
-- Modification history:
-- (29/09/98 MIK)  Migrated from Informix

rec_        INTEGER;
rec_b_      SMALLINT;
bis_        SMALLINT;

BEGIN

err_   := 0;
bis_   := NULL;
rec_   := NULL;
rec_b_ := NULL;

IF rec_a_ = 0 THEN
   UPDATE arc_rrp SET blk=errk_ WHERE fn_b = fn_ AND dat_b = dat_;
ELSE
   BEGIN
      SELECT rec, rec_b, bis
        INTO rec_,rec_b_,bis_ FROM arc_rrp
       WHERE fn_b = fn_ AND dat_b = dat_ AND rec_b=rec_a_;

      IF bis_=0 THEN
         UPDATE arc_rrp SET blk=errk_ WHERE rec=rec_;
      ELSE
         UPDATE arc_rrp SET blk = errk_
          WHERE fn_b = fn_ AND dat_b = dat_
            AND bis>0 AND rec_b-bis = rec_b_-bis_;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN RETURN;
   END;
END IF;

IF SQL%ROWCOUNT = 0 THEN
   err_ := 9121; -- No record found
END IF;
RETURN;
END p_kwt;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE pa_grc(
      errk_  OUT SMALLINT,    -- Error code
      otm_   OUT SMALLINT,    -- Return flag
      kv_    SMALLINT,        -- Currency code
      fn_    CHAR,            -- SEP File name
      dat_   DATE,            -- File date/time
      n_     SMALLINT,        -- line file counter
      sde_   DECIMAL,         -- Debet  amount
      skr_   DECIMAL,         -- Credit amount
      sign_key_ CHAR,         -- Key Identifier
      sign_  RAW,             -- File signature
      entry_ SMALLINT         -- Entry number
      ) IS
--
-- "A" Phase (Incoming file acception), direction 3,4,6  only.
--            Called from File processing programm.
-- Modification history
-- (03/11/98  MIK) - OTM is null Err Amended
ref_          INT;
datk_         DATE;
blk_          SMALLINT;
mfoa_         VARCHAR(12);
mfob_         VARCHAR(12);
fm_           CHAR(1);
j             SMALLINT;
BEGIN

   datk_ := TO_DATE (TO_CHAR(gl.bDATE,'MM-DD-YYYY')||' '||
                     TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');
   otm_  := 0;
   ref_  := NULL;
   IF entry_=2 AND G_fn=fn_ AND G_dat=dat_ THEN
      IF G_err=0 THEN
         IF G_pm=1 THEN    -- Payment of the whole file
            mfoa_ := G_mfo;
            mfob_ := gl.aMFO;
            p_fil('R00',fn_,kv_,G_koda,mfoa_,0,mfob_,sde_,skr_,ref_);
         END IF;

         IF G_koda in (4,6,14) THEN   -- Mark "payed"
            otm_ := 1;
         END IF;

         UPDATE zag_a SET ref=ref_,datk=datk_,dat_2=SYSDATE,otm=otm_
          WHERE fn=fn_ AND dat=dat_;
      END IF;
   ELSE
      G_fn  := fn_;
      G_dat := dat_;
      G_mfo := NULL;
      datk_ := NULL;
      blk_  := 0;
      G_err := 0;
      BEGIN

         IF SUBSTR(fn_,2,5)='B'||aSAB THEN        -- sender is NBU
             G_mfo := G_NBU_mfo;
              G_pm := G_NBU_pm;
            G_koda := G_NBU_kodn;
               fm_ := G_NBU_fmi;
              blk_ := 0;
         ELSE   -- Our participant. Must be present in BANKS and not blocked
            SELECT  mfo,   pm,   kodn,   SUBSTR(fmi,2,1)
             INTO   G_mfo, G_pm, G_koda, fm_
             FROM   banks
             WHERE  mfop=gl.aMFO AND sab=SUBSTR(fn_,3,4) AND kodn IN (4,6,14);
            SELECT  blk INTO blk_ FROM lkl_rrp WHERE mfo=G_mfo AND kv=kv_;
         END IF;

-- MIK-SWT    IF kv_<>gl.BaseVal THEN G_pm:=0; END IF; -- Foreign currency only

         IF blk_ IS NOT NULL AND blk_ NOT IN (0,2) THEN
            G_err := 1006;                 -- Blocked Bank
         END IF;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN G_mfo := NULL;
      END;
      IF G_mfo IS NULL THEN
         G_err := 0904;                    -- No participant
      ELSE

         IF SUBSTR(fn_,1,2) like '_'||fm_ THEN

            IF TRUNC(dat_)=TRUNC(gl.bDATE) AND SUBSTR(fn_,7,2)=MD32 -- дата файла совпадает с банковской
                      OR NOT g_date_control       -- или контроль отключен
            THEN
               BEGIN
                  SELECT otm INTO otm_ FROM zag_a
                   WHERE fn=fn_ AND dat>=TRUNC(dat_) AND dat<TRUNC(dat_)+1;
                  G_err := 0701;          -- Previously received file
               EXCEPTION
                  WHEN NO_DATA_FOUND THEN otm_ := 0;
               END;
            ELSE
               G_err := 0705; -- Not current banking day
            END IF;
         ELSE
            G_err := 0702;    -- File name error
         END IF;
      END IF;
      IF G_pm=1 and G_koda in (4,6,14) THEN   -- Planning pofajlovo
         otm_ := 1;
      END IF;
      IF G_err = 0 THEN
         INSERT INTO zag_a(kv, fn, dat, n, sde, skr, sign ,sign_key )
                    VALUES(kv_,fn_,dat_,n_,sde_,skr_,sign_,sign_key_);
      END IF;
   END IF;
errk_ := G_err;
END pa_grc;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE po_grc IS
--
-- "B" Phase (Payment stage), direction 3,4  only.
--            Called from File processing programm.
--
-- Modification history
-- (16/09/98 MIK) Direction 6 added
-- (28/09/98 MIK) Migrated from informix

kodn_    SMALLINT;
pm_      SMALLINT;
kv_      SMALLINT;
blk_     SMALLINT;
ref_     INTEGER;
sde_     NUMERIC(24);
skr_     NUMERIC(24);
mfo_     VARCHAR(12);
dat_     DATE;
fn_      CHAR(12);

CURSOR zag IS
   SELECT kv,fn,dat,sde,skr,ref FROM zag_b
    WHERE DECODE(otm,0,0,1,1,2,2,3,3,NULL) = 0 AND fn IS NOT NULL
      FOR UPDATE OF ref,otm;

BEGIN

OPEN zag;
LOOP
<<FETCH_zag>>
  FETCH zag INTO kv_,fn_,dat_,sde_,skr_,ref_;
  EXIT WHEN zag%NOTFOUND;
  mfo_ := NULL;
  BEGIN
     IF SUBSTR(fn_,3,4) = aSAB THEN
-- Get data for NBU
         mfo_ := G_NBU_mfo;
          pm_ := G_NBU_pm;
        kodn_ := G_NBU_kodn;
     ELSE
-- Get data for participant
        SELECT mfo, pm, kodn
        INTO   mfo_,pm_,kodn_
        FROM   banks
        WHERE  mfop=gl.aMFO AND sab=SUBSTR(fn_,3,4) AND kodn IN (4,6,14);
     END IF;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN GOTO FETCH_ZAG;  -- No participant
  END;

--  IF blk_ IN (2,3,9) THEN
--     GOTO FETCH_ZAG;       -- Blocked bank
--  END IF;

  IF pm_ = 1 THEN          -- Payment of the whole file
     p_fil('R01',fn_,kv_,0,mfo_,kodn_,mfo_,sde_,skr_,ref_);
  END IF;

  UPDATE zag_b SET ref=ref_,otm=1 WHERE CURRENT OF zag;

END LOOP;
END po_grc;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE bp_grc(ret_ OUT   SMALLINT,    -- Return code
                 pdi_       SMALLINT     -- Direction number
                 ) IS

--
-- "B" Phase (Assigning Outcoming file names), direction 3,4  only.
--            Called from File processing programm.

TYPE lkl_rec IS RECORD(bn NUMBER,bn_ssp NUMBER);
TYPE lkl_tab IS TABLE OF lkl_rec INDEX BY VARCHAR2(64);

uch  lkl_tab;
rec  VARCHAR2(64);

i NUMBER :=0;
j NUMBER :=0;
k NUMBER :=0;
x NUMBER :=0;

mfo_     VARCHAR(12);
mfoa_    VARCHAR(12);
mfob_    VARCHAR(12);
mfop_    VARCHAR(12);
nlsa_    VARCHAR(15);
nlsb_    VARCHAR(15);
bis_     SMALLINT;
dk_      SMALLINT;
i_       SMALLINT;
j_       SMALLINT;
k_       SMALLINT;
pm_      SMALLINT;
koda_    SMALLINT;
kodn_    SMALLINT;
bn_      SMALLINT;
bn_ssp_  SMALLINT;
kv_      SMALLINT;
blk_     SMALLINT;
blkd_    SMALLINT;
blk0_    NUMBER;
blk1_    NUMBER;
dazs_    DATE;
ref_     INTEGER;
rec_     INTEGER;
s_       NUMERIC(24);
trnz_    NUMERIC(24):=0;
loro_    NUMERIC(24):=0;
dat_     DATE;
dat_b_   DATE;
sea_     CHAR(2);
sea_ssp_ CHAR(4);
sab_     CHAR(4);
sv_      CHAR(1);
fm_      CHAR(1);
fn_      CHAR(12);
maxdok_  SMALLINT;
max_     SMALLINT;
otm_     SMALLINT;
sde_     DECIMAL(24);
skr_     DECIMAL(24);
man_     SMALLINT; -- auto/manual flag
tmp_     VARCHAR(6);
vob_     SMALLINT;
nd_      VARCHAR(10);
nam_a_   VARCHAR(38);
nam_b_   VARCHAR(38);
nazn_    VARCHAR(160);
d_rec_   VARCHAR(80);
id_a_    VARCHAR2(14);
id_b_    VARCHAR2(14);
id_o_    VARCHAR2(6);
sign_    arc_rrp.sign%type;
ref_a_   VARCHAR2(9);  -- sender's reference
datd_    DATE;
datp_    DATE;
vdat_    DATE;
fn_a_    VARCHAR2(12);
dat_a_   DATE;
rec_a_   NUMBER;
fn_b_    VARCHAR2(12);
tip_     CHAR(3) := NULL;
nbu_     SMALLINT;  -- Nbu Flag (0/1)
ssp_     SMALLINT;  -- SSP bank flag
sspon_   SMALLINT;  -- SSP constantly on flag
prty_    SMALLINT;  -- prty flag
err_     SMALLINT;  --

-------------------------------------------------------------------
CURSOR arc0 IS     -- Main selection
  SELECT /*+ FULL (rec_que) INDEX (arc_rrp XPK_ARC_RRP) */
         arc_rrp.rec,ref,kv,blk,fn_a,dat_a,rec_a,
         mfoa,nlsa,mfob,nlsb,dk,s,bis,nazn,d_rec,id_a,id_b,prty,
         vob, nd, datd, datp, nam_a, nam_b, id_o ,ref_a, sign
    FROM arc_rrp,rec_que
   WHERE rownum<=(G_BPGRCCNT+G_BPGRSCNT) AND arc_rrp.rec=rec_que.rec AND
         bis IN (0,1) AND fn_b IS NULL AND sos = 3 AND NVL(blk,0)=0
     AND fmcheck=1
     FOR UPDATE OF fn_b,rec_b,dat_b,sos,blk,ref NOWAIT;
-------------------------------------------------------------------
CURSOR bis0 IS -- BIS selection
   SELECT rec_que.rec
     FROM arc_rrp,rec_que WHERE bis>0
      AND arc_rrp.rec=rec_que.rec AND rec_g=rec_ AND rec_g IS NOT NULL
      FOR UPDATE OF fn_b,rec_b,dat_b,sos,blk,ref NOWAIT
      order by arc_rrp.rec;
-------------------------------------------------------------------
pay_err EXCEPTION;
PRAGMA EXCEPTION_INIT(pay_err, -20203);

payterr EXCEPTION;
PRAGMA EXCEPTION_INIT(payterr, -20063);

payverr EXCEPTION;
PRAGMA EXCEPTION_INIT(payterr, -20035);

ern       CONSTANT POSITIVE := 060;
erm       VARCHAR2(80);
err       EXCEPTION;
c                               NUMBER;
-- Блокирует Документ Или БИС
PROCEDURE BlkDoc(blk_ NUMBER) IS
BEGIN
   IF bis_=0 THEN
      UPDATE arc_rrp SET blk=blk_ WHERE rec=rec_;
   ELSE
      UPDATE arc_rrp SET blk=blk_ WHERE bis>0
         AND rec IN (SELECT rec FROM rec_que WHERE rec_g=rec_ AND rec_g IS NOT NULL);
   END IF;
END;
-- Возвращает Суффикс (9,10,11,12 байты) для имени файла или пакета
FUNCTION GetFnSuff( prty_ SMALLINT,bn_ SMALLINT ) RETURN VARCHAR2 IS
BEGIN
   IF prty_=1 THEN      -- срочные платежи ССП
      RETURN sep.ssp_trans_id(bn_);
   ELSE                 -- обычные платежи СЭП/ВПС
      RETURN '.0'||sep.h2_rrp(TRUNC((bn_)/36))||sep.h2_rrp(MOD((bn_),36));
   END IF;
END;

BEGIN


IF deb.debug THEN
   deb.trace(ern,'Entering BP_GRC with',pdi_);
END IF;

sep.MD32 := sep.h2_rrp(TO_NUMBER(TO_CHAR(gl.bDATE,'MM')))||
            sep.h2_rrp(TO_NUMBER(TO_CHAR(gl.bDATE,'DD')));

i_      :=0;
k_      :=0;
ret_    :=060;
nbu_    :=0;  -- NBU flag

BEGIN
  SELECT val INTO nbu_ FROM params WHERE par='NBUBANK';
EXCEPTION
   WHEN NO_DATA_FOUND THEN nbu_ := 0;
END;

BEGIN
  SELECT DECODE(val,'MANUAL',1,0) INTO man_ FROM params WHERE par='SEP$A';
EXCEPTION
   WHEN NO_DATA_FOUND THEN man_ := 0;
END;

BEGIN
  SELECT 1 INTO sspon_ FROM params WHERE par='SSPON' AND VAL IN ('1','Y');
EXCEPTION
   WHEN NO_DATA_FOUND THEN sspon_ := 0;
END;

BEGIN
  SELECT GREATEST(99,val) INTO maxdok_ FROM params WHERE par='MAXDOC';
EXCEPTION
   WHEN OTHERS THEN maxdok_ := 1000;
END;

IF nbu_=0 THEN -- Get recource scope

   BEGIN
      SELECT ostf-lim INTO loro_ FROM lkl_rrp WHERE mfo=sep.G_NBU_mfo AND kv=980;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN loro_ := 0;
   END;

   FOR c IN (SELECT p_tip tip,ostc+lim ostc
               FROM v_accounts_proc WHERE p_tip IN ('TNB','N00') AND kv=980)
   LOOP
      IF c.tip='N00' AND -c.ostc < loro_ THEN loro_ := -c.ostc; END IF;
      IF c.tip='TNB'                     THEN trnz_ :=  c.ostc; END IF;
   END LOOP;

   loro_ := loro_ - trnz_;
   IF deb.debug THEN
      deb.trace(ern,'MIN(LORO,NOSTRO)-TNB',loro_);
   END IF;

END IF;

dat_ := TO_DATE  (TO_CHAR(gl.bDATE,'MM-DD-YYYY')||' '||
        TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');
IF deb.debug THEN
   deb.trace(ern,'BANK',dat_);
   deb.trace(ern,'G_BPGRCCNT',G_BPGRCCNT);
   deb.trace(ern,'G_BPGRSCNT',G_BPGRSCNT);
END IF;

/*********************************************************/
 OPEN arc0;
 LOOP
  <<FETCH_arc>>
    FETCH arc0
    INTO rec_,ref_,kv_,blkd_,fn_a_,dat_a_,rec_a_,
        mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,bis_,nazn_,d_rec_,id_a_,id_b_,prty_,
         vob_,nd_,datd_,datp_,nam_a_,nam_b_,id_o_,ref_a_,sign_;
    EXIT WHEN arc0%NOTFOUND; i:=i+1;

if gl.aMFO not in('300001','300465','344443') and gl.aMFO not like '8%' then
    if upper(substr(d_rec_,3,6)) ='BRANCH' then
      g_branch := trim(substr(d_rec_,10,(instr(substr(d_rec_,2),'#',1))-9));
    else
      g_branch:=null;
    end if;
end if;


-------- Global variables assignment -----------------------

    SEP.G_rec  := rec_;
    SEP.G_mfoA := mfoa_;
    SEP.G_mfoB := mfob_;

--------- Get source ---------------------------------------
    BEGIN
       SELECT mfo,kodn INTO mfop_,koda_ FROM banks
        WHERE mfop = gl.aMFO AND (mfo = mfoa_ OR
          mfo = (SELECT mfop FROM banks WHERE mfop <> gl.aMFO AND mfo=mfoa_));
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
          BlkDoc(0902);    -- Вместе с БИС
          GOTO FETCH_ARC;  -- No Bank A Found - skip doc
    END;

--------- Get target ---------------------------------------
    BEGIN
       SELECT mfo, DECODE(kodn,3,sep.aSAB,sab), pm, kodn,
                   SUBSTR(fmo,2,1), ssp
         INTO mfo_,sab_,pm_,kodn_,fm_,ssp_
         FROM banks
        WHERE mfop = gl.aMFO AND (mfo = mfob_ OR
          mfo = (SELECT mfop FROM banks WHERE mfop <> gl.aMFO AND mfo=mfob_ AND blk<>4));
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
          BlkDoc(0903);    -- Вместе с БИС
          GOTO FETCH_ARC;  -- No Bank B Found - skip doc
    END;

---------- Internal payments ReRouting via NBU -------------
    IF kodn_=6 AND kv_=980 THEN
       BEGIN
          SELECT 6 INTO kodn_ FROM vps_acc
           WHERE mfo=mfob_ AND nls=nlsb_ AND nlsa=nlsa_;
            mfo_ := G_NBU_mfo;
            sab_ := sep.aSAB;
             pm_ := G_NBU_pm;
           kodn_ := G_NBU_kodn;
             fm_ := G_NBU_fmo;
            ssp_ := G_NBU_ssp;
       EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
       END;
    END IF;


------------- Check it out via buisines rules --------------
    IF blkd_ IS NULL THEN
       sep.dyn_bl_rrp(blkd_,kv_,mfop_,mfoa_,nlsa_,mfo_,mfob_,nlsb_,dk_,s_,id_a_,id_b_,ref_);
       IF blkd_<>0 THEN
          BlkDoc(blkd_);    -- Вместе с БИС
          GOTO FETCH_ARC;   -- Trapped - skip doc
       END IF;
    END IF;

    IF blkd_=0 AND fm_ IS NOT NULL AND fm_<>' ' THEN  -- filename assigning

       IF ssp_=1 AND (prty_=1 OR sspon_=1) AND kodn_=3 THEN prty_:=1; ELSE prty_:=0; END IF;

---------- NBU direction MANUAL option only
       IF kodn_ = 3 AND man_ = 1 AND prty_=0 THEN
          BEGIN
             SELECT otm INTO otm_ FROM rec_que WHERE rec=rec_ AND otm=1;
          EXCEPTION
             WHEN NO_DATA_FOUND THEN
             IF deb.debug THEN
                deb.trace(ern,'Skip_Not_marked_doc',rec_);
             END IF;
             k := k + 1;       -- count skipping
             BlkDoc(0);        -- Вместе с БИС
             GOTO FETCH_ARC;   -- Not marked -> Skip doc
          END;
       END IF;
--------- Look at SEP-closed flag ----------------------------
       IF kodn_=3 AND kv_=980 AND prty_=0 THEN
          BEGIN
             SELECT 3 INTO kodn_ FROM lkl_rrp
              WHERE mfo=mfo_ AND kv=kv_ AND NVL(blk,0) IN (0,1);
          EXCEPTION
             WHEN NO_DATA_FOUND THEN
             BlkDoc(1007);    -- Вместе с БИС
             GOTO FETCH_ARC;  -- SEP is closed - skip doc
          END;
       END IF;
------------- Checking out money shortage --------------------
       IF nbu_=0 AND kodn_=3 AND dk_=1 AND kv_=980 THEN
          IF s_ > loro_ THEN
             IF deb.debug THEN
                deb.trace(ern,'NO_MONEY_SKIP',s_);
             END IF;
             BlkDoc(7031);
             GOTO FETCH_ARC;  -- No money - skip doc
          ELSE
             loro_ := loro_ - s_;
          END IF;
       END IF;
------------- Get File/Packet counter -----------------------
       BEGIN

          bn_     :=uch(mfo_||'/'||LPAD(kv_,3,'0')||'/'||prty_).bn;

       EXCEPTION WHEN NO_DATA_FOUND THEN
          BEGIN
           SELECT dat,DECODE(prty_,1,bn_ssp,bn) INTO dat_b_,bn_
             FROM lkl_rrp WHERE mfo=mfo_ AND kv=kv_
              FOR UPDATE OF dat,kn,bn,bn_ssp NOWAIT;
          EXCEPTION WHEN NO_DATA_FOUND THEN GOTO FETCH_ARC;
          END;

          IF TRUNC(dat_)<>TRUNC(dat_b_) THEN bn_:=0;
             UPDATE lkl_rrp
                SET dat=dat_,bn=0,bn_ssp=0,kn=-1
              WHERE mfo=mfo_ AND kv=kv_;
          END IF;

          uch(mfo_||'/'||LPAD(kv_,3,'0')||'/'||prty_).bn := bn_;

       END;
------------- File/Packet name assigning ---------------------
       IF kv_=980 THEN sv_:='$';
       ELSE
          BEGIN
             SELECT sv INTO sv_ FROM tabval WHERE kv=kv_;
          EXCEPTION WHEN NO_DATA_FOUND THEN sv_:='$';
          END;
       END IF;

       fn_ := sv_ || fm_ || sab_ || sep.MD32 ||GetFnSuff(prty_,bn_);
--------------------------------------------------------------

       sde_ := 0;
       skr_ := 0;

       IF dk_ = 1 THEN
          skr_ := s_;
       ELSIF dk_ = 0 THEN
          sde_ := s_;
       END IF;

       IF bis_=1 THEN x:=SUBSTR(d_rec_,3,2); ELSE x:=1; END IF;

       IF kodn_=3 THEN max_:=LEAST(maxdok_,1000); ELSE max_:=maxdok_; END IF;

       IF kodn_=3 AND prty_=1 THEN max_:=x; END IF;

       IF bis_>0 THEN OPEN bis0; END IF;

       LOOP
          IF bis_>0 THEN FETCH bis0 INTO rec_; EXIT WHEN bis0%NOTFOUND; END IF;

          UPDATE zag_b SET n=n+1,sde=sde+sde_,skr=skr+skr_
           WHERE kv=kv_ AND fn=fn_ AND dat=dat_ AND n+x<=max_ AND otm=0
            RETURNING n INTO i_; x:=0;

          IF SQL%ROWCOUNT = 0 THEN

             uch(mfo_||'/'||LPAD(kv_,3,'0')||'/'||prty_).bn := bn_+1;

             fn_ := sv_ || fm_ || sab_ || sep.MD32 ||GetFnSuff(prty_,bn_+1);

             BEGIN
                SELECT -1 INTO i_ FROM
                (SELECT 1 FROM zag_b
                  WHERE kv=kv_ AND fn=fn_ AND dat>=TRUNC(dat_) AND dat<TRUNC(dat_)+1
                  UNION ALL
                 SELECT 1 FROM zag_k
                  WHERE kv=kv_ AND fn=fn_ AND dat>=TRUNC(dat_) AND dat<TRUNC(dat_)+1
                ) WHERE rownum=1;  EXIT;  -- Сбой счетчика файлов
             EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
             END;

             INSERT INTO zag_b(kv, fn, dat, n,sde, skr ,otm)
                        VALUES(kv_,fn_,dat_,1,sde_,skr_,0);
             i_:=1;

          END IF;

          IF deb.debug THEN
             deb.trace(2,'File_name '||fn_,i_);
          END IF;

          IF bis_>0 THEN
             UPDATE arc_rrp SET fn_b=fn_,rec_b=i_,dat_b=dat_,blk=0 WHERE rec=rec_;
          ELSE
             UPDATE arc_rrp SET fn_b=fn_,rec_b=i_,dat_b=dat_,blk=0 WHERE CURRENT OF arc0;
          END IF;
          DELETE FROM rec_que WHERE rec=rec_;    -- Remove From Que

          IF bis_>0 THEN sde_ := 0; skr_ := 0; ELSE EXIT; END IF;

       END LOOP;
       IF bis_>0 THEN CLOSE bis0; END IF;

    END IF;   -- End if filename assigning

    IF pm_ = 0 THEN   -- "Single document" payment block

       IF mfob_=gl.aMFO AND dk_ IN (0,1) THEN
          BEGIN
             SELECT dazs,blkd,blkk,tip INTO dazs_,blk0_,blk1_,tip_
               FROM accounts
              WHERE nls=nlsb_ AND kv=kv_;
             IF dazs_ IS NOT NULL    THEN blkd_ := 9303; -- Acc closed
             ELSIF dk_=1 AND blk1_>0 THEN blkd_ := 9305; -- Acc blk cred
             ELSIF dk_=0 AND blk0_>0 THEN blkd_ := 9304; -- Acc blk deb
             ELSE                         blkd_ := 0;
             END IF;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             IF mfoa_=gl.aMFO THEN blkd_:=9300; ELSE blkd_ := 0; END IF;
          END;


          IF blkd_<>0 THEN
             BlkDoc(blkd_);   -- Вместе с БИС
             GOTO FETCH_ARC;  -- Trapped - skip doc
          END IF;

       END IF;
-- Value date

       IF INSTR(d_rec_,'#d')>0 THEN  -- Exclude DCP
          i_ := INSTR(d_rec_,'#D',INSTR(d_rec_,'#d')+52);
       ELSE
          i_ := INSTR(d_rec_,'#D');
       END IF;

       IF i_>0 THEN
          vdat_ := TO_DATE(SUBSTR(d_rec_,i_+2,6),'YYMMDD');
          IF vdat_ -  gl.bDATE > 10 THEN
             vdat_ := gl.bDATE;
          END IF;
       ELSE
          vdat_ := gl.bDATE;
       END IF;

       BEGIN
          SAVEPOINT bp_pay_before;

          IF (dk_=0 OR dk_=1) AND ref_ IS NULL THEN
             gl.ref(ref_);
             INSERT INTO oper (ref,tt,pdat,vdat,datd,datp,
             nam_a,mfoa,nlsa,kv, s, id_a,
             nam_b,mfob,nlsb,kv2,s2,id_b,id_o,ref_a,nazn,d_rec,vob,dk,nd,bis,sign,userid,sk)
             VALUES (ref_,DECODE(dk_,0,'D01','R01'),SYSDATE,vdat_,datd_,datp_,
                     nam_a_,mfoa_,nlsa_,kv_,s_,id_a_,
                     nam_b_,mfob_,nlsb_,kv_,s_,id_b_,id_o_,ref_a_,nazn_,d_rec_,
                     vob_,dk_,nd_,bis_,sign_,gl.aUID,
                     case
                     when d_rec_ like '%#CSK__#%' then substr(d_rec_, instr(d_rec_,'#CSK')+4,2)
                     else null
                     end );
          END IF;

          p_doc('R01',vdat_,dk_,kv_,koda_,mfop_,nlsa_,kodn_,mfo_,nlsb_,s_,ref_,rec_,tip_);

       EXCEPTION
          WHEN pay_err OR payterr OR payverr THEN
             ROLLBACK TO bp_pay_before;
             IF deb.debug THEN
                deb.trace(ern,SQLERRM,mfo_);
             END IF;

             j_ := INSTR(SQLERRM,chr(92));
             IF j_>0 THEN
                blkd_ := SUBSTR(SQLERRM,j_+1,4);
             ELSE
                blkd_ := 9120;
             END IF;
             IF blkd_ <> 9349 THEN   -- locked acc skipping
                BlkDoc(blkd_);  -- Вместе с БИС
             END IF;
             GOTO FETCH_ARC;
       END;

       IF kodn_=2 AND ref_ IS NOT NULL THEN
          IF ( mfoa_<>gl.aMFO -- внешние платежи
                    OR
               mfoa_=gl.aMFO AND mfoa_=mfob_ -- внутренние платежи(импорт, коммуналка, денежные переводы и пр.)
             )
             AND INSTR(d_rec_,'#B')>0
          THEN
             IF d_rec_ LIKE '#B__#fMT ___%' THEN
                BEGIN
                   SELECT otm INTO otm_ FROM t902 WHERE rec=rec_ AND otm=0;
                EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                     BEGIN
                        INSERT INTO operw(ref,tag,value) VALUES(ref_,'NOS_A','0');
                     EXCEPTION WHEN dup_val_on_index THEN
                        IF deb.debug THEN
                           deb.trace(ern,'Tag NOS_A already exist for ref=',ref_);
                        END IF;
                     END;
                     begin
                        INSERT INTO operw(ref,tag,value) VALUES(ref_,'f',SUBSTR(d_rec_,7,6));
                     exception when dup_val_on_index then
                        null;
                        --raise_application_error(-20999, 'Повторная вставка в OPERW: ref='||ref_||',tag='||'f'||',value='||SUBSTR(d_rec_,7,6));
                     end;
                END;
             END IF;
            -- Вставка Допрекв в operw
             sep.bis2ref(rec_,ref_);
          END IF;
/*
          UPDATE oper SET userid=DECODE(NVL(userid,0),0,gl.aUID,userid),
                 kv=kv_,s=s_,kv2=kv_,s2=s_,
                 dk=dk_,mfoa=mfoa_,nlsa=nlsa_,mfob=mfob_,nlsb=nlsb_,
                 vob=vob_,datd=datd_,datp=datp_,id_a=id_a_,id_b=id_b_,
                id_o=id_o_,ref_a=ref_a_,sign=sign_,
                  nd = nd_,
               nam_a = nam_a_,
               nam_b = nam_b_,
                nazn = nazn_ ,
               d_rec = d_rec_,
                 bis = bis_,
                  sk = case
                       when d_rec_ like '%#CSK__#%' then substr(d_rec_, instr(d_rec_,'#CSK')+4, 2)
                       else null
                       end
            WHERE ref=ref_;
*/
       END IF;

       -- вставка символа кассплана в operw при импорте своих документов
       if d_rec_ like '%#CSK__#%' then
         insert into operw(ref, tag, value) values(ref_, 'SK', substr(d_rec_, instr(d_rec_,'#CSK')+4, 2));
       end if;
       IF deb.debug THEN
          deb.trace(ern,'SOS5_SETTING. Ref',ref_);
       END IF;

       IF bis_=0 THEN
          UPDATE arc_rrp SET ref=ref_,dat_b=dat_,sos=5,blk=0 WHERE CURRENT OF arc0;
          DELETE FROM rec_que WHERE rec=rec_; -- Remove From Que
       ELSE
          UPDATE arc_rrp SET ref=ref_,dat_b=dat_,sos=5,blk=0
           WHERE bis>0
             AND rec IN (SELECT rec FROM rec_que WHERE rec_g=rec_ AND rec_g IS NOT NULL);
          DELETE FROM rec_que WHERE rec_g=rec_ AND rec_g IS NOT NULL;
       END IF;
    END IF; -- End of "Single document" payment

    j:=j+1;

 END LOOP; -- End of arc_rrp scanning

 CLOSE arc0;
/*********************************************************/
rec := uch.FIRST;
WHILE rec IS NOT NULL LOOP
   IF SUBSTR(rec,-1)='1' THEN
      UPDATE lkl_rrp SET bn_ssp=uch(rec).bn
       WHERE mfo=SUBSTR(rec,1,6) AND kv=SUBSTR(rec,8,3);
   ELSE
      UPDATE lkl_rrp SET bn=uch(rec).bn
       WHERE mfo=SUBSTR(rec,1,6) AND kv=SUBSTR(rec,8,3);
   END IF;
   rec := uch.NEXT(rec);
END LOOP;
/*********************************************************/
 G_BPGRSCNT := k; -- store skipped count
 ret_ := 0; -- Set normal return code

IF deb.debug THEN
   deb.trace(1,'  Total',i);
   deb.trace(1,'succeed',j);
   deb.trace(1,'skipped',k);
END IF;

END bp_grc;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE dyn_bl_rrp
       ( blk_ IN OUT NUMBER, kv_ NUMBER,
          mfopa_ VARCHAR2, mfoa_ VARCHAR2, nlsa_ VARCHAR2,
          mfopb_ VARCHAR2, mfob_ VARCHAR2, nlsb_ VARCHAR2,
          dk_ NUMBER, s_ NUMBER,
        id_a_ VARCHAR2,
        id_b_ VARCHAR2,ref_ NUMBER)
IS

c                               NUMBER;

l_ru  varchar2(50) := bars_sqnc.ru;

BEGIN
   c := DBMS_SQL.OPEN_CURSOR;

    DBMS_SQL.PARSE(c,
     'BEGIN
      bl_rrp'
     ||'_'||l_ru
     ||'(:BLK,:KV,
             :MFOPA,:MFOA,:NLSA,
             :MFOPB,:MFOB,:NLSB,:DK,:S,:ID_A,:ID_B,:REF);
      END;',DBMS_SQL.NATIVE);

    DBMS_SQL.BIND_VARIABLE(c,':BLK',  blk_);
    DBMS_SQL.BIND_VARIABLE(c,':KV',   kv_);
    DBMS_SQL.BIND_VARIABLE(c,':MFOPA',mfopa_);
    DBMS_SQL.BIND_VARIABLE(c,':MFOA', mfoa_);
    DBMS_SQL.BIND_VARIABLE(c,':NLSA', nlsa_);
    DBMS_SQL.BIND_VARIABLE(c,':MFOPB',mfopb_);
    DBMS_SQL.BIND_VARIABLE(c,':MFOB', mfob_);
    DBMS_SQL.BIND_VARIABLE(c,':NLSB', nlsb_);
    DBMS_SQL.BIND_VARIABLE(c,':DK',   dk_);
    DBMS_SQL.BIND_VARIABLE(c,':S',    s_);
    DBMS_SQL.BIND_VARIABLE(c,':ID_A', id_a_);
    DBMS_SQL.BIND_VARIABLE(c,':ID_B', id_b_);
    DBMS_SQL.BIND_VARIABLE(c,':REF',  ref_);



    blk_ := DBMS_SQL.EXECUTE(c);

    DBMS_SQL.VARIABLE_VALUE(c,':BLK', blk_);
    DBMS_SQL.CLOSE_CURSOR(c);

END dyn_bl_rrp;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE ps_grc(
   err_   OUT INTEGER,    -- Return code
   tt_        CHAR,
   fn_        CHAR,
   dat_       DATE,
   n_         SMALLINT,
   sd_        DECIMAL,
   sk_        DECIMAL,
   errk_      SMALLINT,
   detail_    SMALLINT,
   ab_sign_     RAW  default NULL,
   ab_signsize_ SMALLINT default 0,
   dat_2_     DATE default NULL,
   tic_sign_key_ VARCHAR2 default NULL
   )  IS
--
-- "S" Phase ("Kwitovka"), direction 3,4  only.
--            Called from File processing programm.
--
-- Modification history:
-- (16/09/98 MIK)  Direction 6 added
-- (28/09/98 MIK)  Migrated from Informix
-- (03/11/98 MIK)  Sep Model-1 implemented
mfo_   VARCHAR(12);
mfoa_  VARCHAR(12);
mfob_  VARCHAR(12);
koda_  SMALLINT;
kodb_  SMALLINT;
kodn_  SMALLINT;
nn     SMALLINT;
blk_   SMALLINT;
pm_    SMALLINT;
accd_  INTEGER;
acck_  INTEGER;
rec_   INTEGER;
ref_   INTEGER;
refd_  INTEGER;
bis_   INTEGER;
td_    CHAR(3);
tk_    CHAR(3);
wd_    CHAR(1);
wk_    CHAR(1);
kv_    SMALLINT;
pap_   SMALLINT;
otm_   SMALLINT;
dk_    SMALLINT;
sde_   DECIMAL(24);
skr_   DECIMAL(24);
s_     DECIMAL(24);
lim_   DECIMAL(24);
ostf_  DECIMAL(24);
datt_  DATE;
datk_  DATE;
nlsa_  VARCHAR(15);
nlsb_  VARCHAR(15);
sign_  arc_rrp.sign%type;
sign_key_  CHAR(6);
current_dat_2_ DATE;

CURSOR arc IS
SELECT rec,mfoa,nlsa,mfob,nlsb,dk,s,ref,bis
  FROM arc_rrp
 WHERE fn_b = fn_ AND dat_b=datt_ ORDER BY rec_b
   FOR UPDATE OF fn_b,dat_b,rec_b,sos NOWAIT;

ern       CONSTANT POSITIVE := 062;
erm       VARCHAR2(80);
err       EXCEPTION;


BEGIN

IF deb.debug THEN
   deb.trace(ern,'Entering PS_GRC with', fn_);
END IF;

datk_ := TO_DATE (TO_CHAR(gl.bDATE,'MM-DD-YYYY')||' '||
                  TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');

-- Check to see if original file is valid.
nn := NULL;
BEGIN

IF tt_='RT0' THEN
   SELECT n,kv, dat,  sde, skr, otm, ref, sign ,sign_key, dat_2
    INTO nn,kv_,datt_,sde_,skr_,otm_,ref_,sign_,sign_key_,current_dat_2_
    FROM zag_b WHERE fn=fn_ AND dat>=TRUNC(dat_) AND dat<TRUNC(dat_)+1;
ELSE
   SELECT n,kv, dat,  sde, skr, otm, ref, sign ,sign_key, dat_2
    INTO nn,kv_,datt_,sde_,skr_,otm_,ref_,sign_,sign_key_,current_dat_2_
    FROM zag_a WHERE fn=fn_ AND dat>=TRUNC(dat_) AND dat<TRUNC(dat_)+1;
END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
-- Check if we get Model-1 record
   IF errk_ = 0 AND nMODEL='1' THEN
      BEGIN
         SELECT mfo,mfop INTO mfo_,mfob_
          FROM banks WHERE sab=SUBSTR(fn_,3,4) AND mfop=G_NBU_mfo;
         BEGIN
            SELECT n,kv, dat,  sde, skr, otm, ref, sign
             INTO nn,kv_,datt_,sde_,skr_,otm_,ref_,sign_
             FROM zag_k WHERE fn=fn_ AND dat>=TRUNC(dat_) AND dat<TRUNC(dat_)+1;

            err_ := 1104;    -- duplicate
            RETURN;

         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            IF tt_='RT0' THEN
               p_fil('RT2',fn_,980,0,mfo_,0,mfob_,sd_,sk_,ref_);
            ELSE
               p_fil('RT3',fn_,980,0,mfob_,0,mfo_,sd_,sk_,ref_);
            END IF;
            INSERT INTO zag_k (ref,kv,fn,dat,n,sde,skr,datk,dat_2,k_er)
                 VALUES (ref_,980,fn_,dat_,n_,sd_,sk_,datk_,dat_2_,errk_);
            err_ := 0;   -- Sep Model 1 Okay
            RETURN;
         END;
      EXCEPTION WHEN NO_DATA_FOUND THEN NULL; -- No file owner found
      END;
   END IF;
   -- Если сюда дошли, значит файл не является файлом филиала по модели 1
   -- проверим, может это наш расформированный начальный (по причине ошибки)?
   IF tt_='RT0' AND errk_<>0 THEN
     BEGIN
       SELECT n INTO nn FROM zag_k WHERE fn=fn_ AND dat>=TRUNC(dat_) AND dat<TRUNC(dat_)+1;
       -- нашли => выходим с кодом 1104 - повторная квитовка
       err_ := 1104;
       RETURN;
     EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
     END;
   END IF;
END;

IF nn  IS NULL THEN
   err_ := 1103;    -- receipt on nonexisting file
   RETURN;
ELSIF otm_ = 5 THEN
   -- при квитовке начальных на НБУ поле dat_2_ пустое для $T и заполнено для $K, обрабатываем эту ситуацию
   IF tt_='RT0' AND current_dat_2_ IS NULL AND dat_2_ IS NOT NULL THEN
     UPDATE zag_b SET dat_2=dat_2_ WHERE fn=fn_ AND dat=datt_;
     err_ := 0;
     RETURN;
   ELSE
     err_ := 1104;    -- duplicate
     RETURN;
   END IF;
ELSIF NOT(tt_='RT0' AND errk_=0  AND otm_ =3 OR
          tt_='RT0' AND errk_<>0 AND otm_ IN (1,2,3) OR
          tt_='RT1' AND otm_ IN (0,1)) THEN
   err_ := 9125;    -- receipt ne k mestu
   RETURN;
ELSIF NOT(errk_<>0 AND n_=0 AND sd_=0 AND sk_=0 OR
          n_=nn AND sd_=sde_ AND sk_=skr_
                AND TRUNC(dat_)=TRUNC(datt_)) THEN
   err_ := 1105;    -- receipt is not fitted
   RETURN;
ELSIF detail_>0 AND dat_<>datt_ THEN
   err_ := 1105;
   RETURN;
ELSIF tt_='RT0'
  AND (ab_sign_ IS NOT NULL OR ab_signsize_>0)
  AND sign_<>ab_sign_ THEN
  -- different sign of file and sign in his ticket (for outgoing file only)
  err_ := 1102;
  IF deb.debug THEN
    deb.trace(ern, 'check sign error:', err_);
  END IF;
  RETURN;
END IF;

-- Whole file rejected, don't force collect it again.
IF errk_<>0 AND tt_='RT0' AND detail_=0 THEN
   UPDATE zag_b SET k_er=errk_ WHERE fn=fn_ AND dat=datt_;
   IF errk_=1006 OR errk_=1007 THEN    -- Direction locked, lock it
      IF SUBSTR(fn_,3,4)=aSAB THEN     -- Data for NBU
         update lkl_rrp set blk = 2 where kv=kv_ and mfo=G_NBU_mfo;
      END IF;
   END IF;
   err_ := 0;
   RETURN;
END IF;

IF errk_<>0 AND tt_<>'RT0' THEN
   err_ := errk_;
   RETURN;
END IF;

-- Looking for appropriate file direction
BEGIN

IF SUBSTR(fn_,3,4)=aSAB THEN   -- Get data for NBU
   pm_  := G_NBU_pm;
   mfo_ := G_NBU_mfo;
   kodn_:= G_NBU_kodn;
ELSE                           -- Get data for participant
   SELECT mfo, pm, kodn INTO mfo_,pm_,kodn_
   FROM banks WHERE mfop=gl.aMFO AND sab=SUBSTR(fn_,3,4) AND kodn in (4,6,14);
END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
   err_ := 0904; RETURN;       -- No participant
END;

IF kodn_ in (4,6,14) THEN
  BEGIN
    SELECT blk INTO blk_ FROM lkl_rrp WHERE kv=kv_ and mfo=mfo_;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    err_ := 0904; RETURN;      -- No participant
  END;
  IF blk_=9 THEN
     err_ := 1006;       -- Direct partisipant is closed
     RETURN;
  END IF;
END IF;

IF pm_ = 1 THEN
-- --------------------------------  WHOLE FILE PAYMENT

   IF tt_ = 'RT0' THEN  -- ticket of sent file (S,,)
      koda_ := 0;
      kodb_ := kodn_;
      mfoa_ := gl.aMFO;
      mfob_ := mfo_;
   ELSE     -- ticket of received file (K)
      koda_ := kodn_;
      kodb_ := 0;
      mfoa_ := mfo_;
      mfob_ := gl.aMFO;
   END IF;

   IF errk_=0 THEN                      -- Normal reciept
      p_fil(tt_,fn_,kv_,koda_,mfoa_,kodb_,mfob_,sde_,skr_,ref_);
      IF tt_='RT0' THEN
         UPDATE arc_rrp SET sos=7 WHERE fn_b = fn_ AND dat_b = datt_;
      ELSE
         UPDATE arc_rrp SET sos=3 WHERE fn_a = fn_ AND dat_a = datt_;
      END IF;
   ELSIF tt_ = 'RT0' AND errk_<>0 THEN   -- Otkat B-file
      p_fil('R02',fn_,kv_,0,mfob_,kodb_,mfob_,sde_,skr_,ref_);

-- Back In Que

      OPEN arc;
      LOOP
      FETCH arc INTO rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,refd_,bis_;
      EXIT WHEN arc%NOTFOUND;

      IF bis_=0 THEN
         G_rec_g := NULL;
      ELSIF
         bis_=1 THEN G_rec_g := rec_;
      END IF;

      INSERT INTO rec_que (rec,rec_g,otm) VALUES(rec_,G_rec_g,0);

      UPDATE arc_rrp SET fn_b=NULL,dat_b=NULL,rec_b=NULL WHERE CURRENT OF arc;

      END LOOP;
      CLOSE arc;
      INSERT INTO zag_k (ref,kv,fn,dat,n,sde,skr,dat_2,sign,sign_key,k_er)
        VALUES (ref_,kv_,fn_,datt_,nn,sde_,skr_,
                nvl(dat_2_,datk_),sign_,nvl(tic_sign_key_,sign_key_),errk_);

      DELETE FROM zag_b WHERE fn=fn_ AND dat=datt_;

      err_ := 0;
      RETURN;

   END IF;
ELSE
-- --------------------------------  LOOP FOR EVERY DOCUMENT
   IF errk_=0 THEN                      -- Normal reciept

      OPEN arc;
      LOOP
      FETCH arc INTO rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,refd_,bis_;
      EXIT WHEN arc%NOTFOUND;

      IF s_>0 THEN
-- A------------------------------------------------------------
         BEGIN
            SELECT mfo,  kodn INTO  mfoa_,koda_ FROM banks
             WHERE mfop = gl.aMFO AND (
                   mfo = mfoa_ OR
             mfo = (SELECT mfop FROM banks WHERE mfop<>gl.aMFO AND mfo=mfoa_));
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            err_ := 0904; --  No participant _mfoa;
            RETURN;
         END;
-- B------------------------------------------------------------
         BEGIN
            SELECT mfo,  kodn INTO  mfob_,kodb_ FROM banks
             WHERE mfop = gl.aMFO AND (
                   mfo = mfob_ OR
             mfo = (SELECT mfop FROM banks WHERE mfop<>gl.aMFO AND mfo=mfob_));
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            err_ := 0905; --  No participant _mfob;
            RETURN;
         END;
-- ---------------------------------------------------------------------
         p_doc(tt_,gl.bDATE,dk_,kv_,koda_,mfoa_,nlsa_,kodb_,mfob_,nlsb_,s_,refd_,NULL);
-- ---------------------------------------------------------------------
      END IF;
      UPDATE arc_rrp SET sos=7 WHERE CURRENT OF arc;
      END LOOP;
      CLOSE arc;

   ELSIF tt_ = 'RT0' AND errk_<>0 THEN   -- Otkat B-file

-- Back In Que

      OPEN arc;
      LOOP
      FETCH arc INTO rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,refd_,bis_;
      EXIT WHEN arc%NOTFOUND;

      IF bis_=0 THEN
         G_rec_g := NULL;
      ELSIF
         bis_=1 THEN G_rec_g := rec_;
      END IF;

      INSERT INTO rec_que (rec,rec_g,otm) VALUES(rec_,G_rec_g,0);

      UPDATE arc_rrp SET fn_b=NULL,dat_b=NULL,rec_b=NULL WHERE CURRENT OF arc;

      END LOOP;
      CLOSE arc;
      INSERT INTO zag_k (ref,kv,fn,dat,n,sde,skr,dat_2,sign,sign_key,k_er)
        VALUES (ref_,kv_,fn_,datt_,nn,sde_,skr_,
                nvl(dat_2_,datk_),sign_,nvl(tic_sign_key_,sign_key_),errk_);

      DELETE FROM zag_b WHERE fn=fn_ AND dat=datt_;

      err_ := 0;
      RETURN;
   ELSE
      err_ := errk_;
      RETURN;
   END IF;

END IF;

-- Mark the original file as proceeded.

IF tt_='RT0' THEN
   UPDATE zag_b  SET otm=5,datk=datk_,ref=ref_,k_er=NULL,
          dat_2 = nvl(dat_2_,dat_2),
          sign_key = nvl(tic_sign_key_,sign_key)
    WHERE fn=fn_ AND dat=datt_;
ELSE
   UPDATE zag_a  SET otm=5,datk=datk_,ref=ref_
    WHERE fn=fn_ AND dat=datt_;
END IF;

err_ := 0;
RETURN;

END ps_grc;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE pk_grc(
       blkn_ OUT CHAR,
         kn_ OUT SMALLINT,
        knn_ OUT SMALLINT,
        mfo_ VARCHAR,
         ki_ SMALLINT,
       ostf_ DECIMAL,
        lim_ DECIMAL,
        lno_ DECIMAL,
        kvu_ SMALLINT DEFAULT 980) IS
--
-- "K" Phase (Getting and Setting of counters and limits)
--            Called from File processing programm.
--
dat_    DATE;
dat_b_  DATE;
knt_    SMALLINT;
--knn_    SMALLINT;
blk_    SMALLINT;
kodn_   SMALLINT;
--blkn_   CHAR(1);
mfoa_   VARCHAR(12);
ern       CONSTANT POSITIVE := 058;
erm       VARCHAR2(80);
err       EXCEPTION;

CURSOR uch IS
  SELECT dat,kn FROM lkl_rrp WHERE mfo=mfo_ AND kv=kvu_
  FOR UPDATE;

BEGIN

mfoa_ := NULL;
BEGIN
   SELECT mfo,kodn INTO mfoa_,kodn_
   FROM banks WHERE mfop = gl.aMFO AND mfo = mfo_;
   select blk into blk_ from lkl_rrp where mfo=mfo_ and kv=kvu_;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
       erm := '0904 - Not an direct participant '||mfo_||'.';
       raise_application_error(-(20746),erm,TRUE);
END;

IF blk_ IN (1,3,9) THEN
   blkn_ := 'Y';
ELSE
   blkn_ := ' ';
END IF;

dat_b_ := TO_DATE (TO_CHAR(gl.bDATE,'MM-DD-YYYY')||' '||
                   TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');

dat_ := NULL;
kn_  := 0;
knn_ := 0;

OPEN uch;
LOOP
<<FETCH_uch>>
  FETCH uch INTO dat_,knt_;
  EXIT WHEN uch%NOTFOUND;
     IF TRUNC(dat_)<>TRUNC(dat_b_) THEN
        UPDATE lkl_rrp SET bn=0 WHERE CURRENT OF uch;
     END IF;
     IF kodn_=1 OR kodn_=3 THEN  -- $K из НБУ
        IF knt_<ki_ OR TRUNC(dat_)<TRUNC(dat_b_) THEN
           IF ki_=999 THEN
              UPDATE lkl_rrp SET ostf=ostf_,lim=lim_,lno=lno_,dat=dat_b_
               WHERE CURRENT OF uch;
           ELSE
              UPDATE lkl_rrp SET ostf=ostf_,lim=lim_,lno=lno_,dat=dat_b_,kn=ki_
               WHERE CURRENT OF uch;
           END IF;
        END IF;
     ELSE                        -- $K на/з ВПС
        IF TRUNC(dat_)=TRUNC(dat_b_) AND ki_<>0 THEN
           knn_ := knt_+1;
        ELSE
           knn_ := 0;
        END IF;
        UPDATE lkl_rrp SET ostf=ostf_,lim=lim_,lno=lno_,dat=dat_b_,kn=knn_
         WHERE CURRENT OF uch;
     END IF;
     kn_ := knt_;
  EXIT;
END LOOP;
CLOSE uch;

RETURN;

END pk_grc;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE pv_grc(fn_v VARCHAR2 DEFAULT NULL) IS

sd_       DECIMAL(24);
sk_       DECIMAL(24);
dat_      DATE;
fn_       CHAR(12);
tt_       CHAR(3);
n_        SMALLINT;
errk_     SMALLINT;
kvu_      SMALLINT   := 980;
md_       CHAR(2);
sab_      VARCHAR2(4) := SUBSTR(fn_v,3,4);

i  INTEGER;
j  INTEGER;
x  CHAR(1);
yyyymmdd_ VARCHAR2(8);

x_1       CHAR(1);        x_2       CHAR(1);
fn_1      VARCHAR2(12);   fn_2      VARCHAR2(12);
rec_1     NUMBER;         rec_2     NUMBER;
line_1    VARCHAR2(100);  line_2    VARCHAR2(100);

sv        VARCHAR2(1);  -- символ валюты

CURSOR tmp IS SELECT fn,sum(n),sum(sde),sum(skr) FROM tmp_z GROUP BY fn;
CURSOR doc IS
-- начальные из ARC_RRP
SELECT 'A' x,fn_b fn,rec_b rec,
       RPAD(mfoa,9)||RPAD(nlsa,14)||RPAD(mfob,9)||RPAD(nlsb,14)||
       RPAD(dk,1)||LPAD(s,16)||LPAD(vob,2)||RPAD(nd,10)||LPAD(kv,3)||
       TO_CHAR(datp,'YYMMDD')||LPAD(ref_a,9)||' Y' line
  FROM arc_rrp
 WHERE dat_b>=gl.bDATE AND dat_b<gl.bDATE+1 AND fn_b LIKE
  case
  when gl.aMFO in('300465','300001', '344443') or gl.aMFO like '8%' then
  '$A'||sab_||'__.___'
  else
   sv||'A'||sep.aSAB||'__.___'
   end
   AND sos>=7 -- только сквитованные
 UNION ALL
-- ответные из ARC_RRP
SELECT 'A' x,fn_a fn,rec_a rec,
       RPAD(mfoa,9)||RPAD(nlsa,14)||RPAD(mfob,9)||RPAD(nlsb,14)||
       RPAD(dk,1)||LPAD(s,16)||LPAD(vob,2)||RPAD(nd,10)||LPAD(kv,3)||
       TO_CHAR(datp,'YYMMDD')||LPAD(ref_a,9)||' Y' line
  FROM arc_rrp
 WHERE dat_a>=gl.bDATE AND dat_a<gl.bDATE+1 AND fn_a LIKE
  case
  when gl.aMFO in('300465','300001', '344443') or gl.aMFO like '8%' then
  '$B'||sab_||'__.___'
  else
    sv||'B'||sep.aSAB||'__.___'
   end
   AND sos>1 -- только сквитованные
 UNION ALL
-- начальные из $V
SELECT 'V' x,fn_a fn,rec_a rec,
       RPAD(mfoa,9)||RPAD(nlsa,14)||RPAD(mfob,9)||RPAD(nlsb,14)||
       RPAD(dk,1)||LPAD(s,16)||LPAD(vob,2)||RPAD(nd,10)||
       LPAD(kv,3)||TO_CHAR(datp,'YYMMDD')||LPAD(ref_a,9)||' Y' line
  FROM tmp_v WHERE o=1
 UNION ALL
-- ответные из $V
SELECT 'V' x,fn_b fn,rec_b rec,
       RPAD(mfoa,9)||RPAD(nlsa,14)||RPAD(mfob,9)||RPAD(nlsb,14)||
       RPAD(dk,1)||LPAD(s,16)||LPAD(vob,2)||RPAD(nd,10)||
       LPAD(kv,3)||TO_CHAR(datp,'YYMMDD')||LPAD(ref_a,9)||' Y' line
  FROM tmp_v WHERE o=2 AND otm='Y'
ORDER BY 2,3,1;

ern       CONSTANT POSITIVE := 014;
erm       VARCHAR2(80);
err       EXCEPTION;

BEGIN

-- определяем код валюты по первому символу имени файла выписки
begin
  select kv into kvu_ from tabval where sv=substr(fn_v,1,1);
exception when no_data_found then kvu_ := 980;
end;

IF fn_v IS NULL THEN
   md_:=sep.MD32;
ELSE
   md_:=substr(fn_v,7,2);
END IF;

IF deb.debug THEN deb.trace(1,fn_v,md_); END IF;

-- populate table Z: SEP files


 INSERT INTO tmp_z (fn,n,sde,skr)
 WITH v AS
(SELECT UNIQUE
        mfoa,nlsa,mfob,nlsb,dk,s,vob,nd,kv,datp,ref_a,fn_a,rec_a,fn_b,rec_b,otm
   FROM tmp_v WHERE o IN (1,3) OR o IN (2,4) AND otm='Y')
  SELECT fn_a,count(*),sum(s),0 FROM v
   WHERE dk=0 AND SUBSTR(fn_a,2,7) IN (
      SELECT 'A'||b.sab||md_ FROM banks b,lkl_rrp l WHERE b.mfo=l.mfo AND l.kv=kvu_
         AND (b.mfop=G_NBU_mfo OR l.mfo=gl.aMFO))
   GROUP BY fn_a UNION ALL
  SELECT fn_a,count(*),0,sum(s) FROM v
   WHERE dk=1 AND SUBSTR(fn_a,2,7) IN (
      SELECT 'A'||b.sab||md_ FROM banks b,lkl_rrp l WHERE b.mfo=l.mfo AND l.kv=kvu_
         AND (b.mfop=G_NBU_mfo OR l.mfo=gl.aMFO))
   GROUP BY fn_a UNION ALL
  SELECT fn_a,count(*),0,0 FROM v
   WHERE dk IN (2,3) AND SUBSTR(fn_a,2,7) IN (
      SELECT 'A'||b.sab||md_ FROM banks b,lkl_rrp l WHERE b.mfo=l.mfo AND l.kv=kvu_
         AND (b.mfop=G_NBU_mfo OR l.mfo=gl.aMFO))
   GROUP BY fn_a UNION ALL
  SELECT fn_b,count(*),0,0 FROM v
   WHERE dk=0 AND otm='Y' AND SUBSTR(fn_b,2,7) IN (
      SELECT 'B'||b.sab||md_ FROM banks b,lkl_rrp l WHERE b.mfo=l.mfo AND l.kv=kvu_
         AND (b.mfop=G_NBU_mfo OR l.mfo=gl.aMFO))
   GROUP BY fn_b UNION ALL
  SELECT fn_b,count(*),0,sum(s) FROM v
   WHERE dk=1 AND otm='Y' AND SUBSTR(fn_b,2,7) IN (
      SELECT 'B'||b.sab||md_ FROM banks b,lkl_rrp l WHERE b.mfo=l.mfo AND l.kv=kvu_
         AND (b.mfop=G_NBU_mfo OR l.mfo=gl.aMFO))
   GROUP BY fn_b UNION ALL
  SELECT fn_b,count(*),0,0 FROM v
   WHERE dk IN (2,3) AND otm='Y' AND SUBSTR(fn_b,2,7) IN (
      SELECT 'B'||b.sab||md_ FROM banks b,lkl_rrp l WHERE b.mfo=l.mfo AND l.kv=kvu_
         AND (b.mfop=G_NBU_mfo OR l.mfo=gl.aMFO))
   GROUP BY fn_b;


OPEN tmp;

LOOP
  FETCH tmp INTO  fn_, n_, sd_, sk_;
  EXIT WHEN tmp%NOTFOUND;

  IF SUBSTR(fn_,2,1)='A' THEN tt_ := 'RT0';  -- outgoing payments
                         ELSE tt_ := 'RT1';  -- incoming payments
  END IF;

  IF deb.debug THEN
     deb.trace(ern,'Kwitovka po V',fn_||' '||dat_||' '||n_||' '||sd_||' '||sk_);
  END IF;

  yyyymmdd_:=TO_CHAR(gl.bDATE,'YYYY');

  FOR i IN 7..8 LOOP
     x:=SUBSTR(fn_,i,1);
     IF    x>='0' AND x<='9' THEN j:=48;
     ELSIF x>='A' AND x<='Z' THEN j:=55;
     ELSE  EXIT;
     END IF;
     yyyymmdd_:=yyyymmdd_||SUBSTR(TO_CHAR(ASCII(x)-j,'09'),-2);
  END LOOP;

  IF LENGTH(yyyymmdd_)=8 THEN
     dat_ := TO_DATE (yyyymmdd_ ||' 01:01','YYYYMMDD HH24:MI');
  ELSE
     dat_ := TO_DATE (TO_CHAR(gl.bDATE,'MM-DD-YYYY')||' '||
                      TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');

  END IF;

  ps_grc(errk_,tt_,fn_,dat_,n_,sd_,sk_,0,-1);

  IF deb.debug THEN
     deb.trace(ern,'KWT_RESULT is ',sep.pv_grc.errk_);
  END IF;

END LOOP;
CLOSE tmp;

if fn_v is null then
  sv := '_';
else
  sv := substr(fn_v,1,1);
end if;

-- Sverka dokumentov
OPEN doc;

LOOP
<<M1>>
  FETCH doc INTO x_1,fn_1,rec_1,line_1;  EXIT WHEN doc%NOTFOUND;
<<M2>>
  FETCH doc INTO x_2,fn_2,rec_2,line_2;

  IF doc%NOTFOUND THEN
     INSERT INTO tmp_v2 (x,fn,rec,line) VALUES(x_1,fn_1,rec_1,line_1);
     EXIT;
  END IF;

  IF fn_1=fn_2 AND rec_1=rec_2 THEN
     IF line_1<>line_2 THEN
        INSERT INTO tmp_v2 (x,fn,rec,line) VALUES(x_1,fn_1,rec_1,line_1);
        INSERT INTO tmp_v2 (x,fn,rec,line) VALUES(x_2,fn_2,rec_2,line_2);
     END IF;
     GOTO M1;
  ELSE
     INSERT INTO tmp_v2 (x,fn,rec,line) VALUES(x_1,fn_1,rec_1,line_1);
        x_1:=x_2;
       fn_1:=fn_2;
      rec_1:=rec_2;
     line_1:=line_2;
     GOTO M2;
  END IF;

END LOOP;
CLOSE doc;
DELETE FROM ref_lst WHERE datd<gl.bDATE-7;  -- Clear old reference list
END pv_grc;
/***************************************************************/
/***  Поиск различий по выписке ССП и информации в БД        ***/
/***************************************************************/
PROCEDURE dif_ssp(p_sign_on INTEGER) IS
  ern       constant positive := 073;
  erm       varchar2(80);
  sys_err   exception;

  x_1           char(1);        x_2           char(1);
  trans_id_1    varchar2(12);  trans_id_2    varchar2(12);
  trans_ln_1  integer;  trans_ln_2    integer;
  line_1        varchar2(444);  line_2        varchar2(444);
  sign_1        arc_rrp.sign%type;  sign_2        arc_rrp.sign%type;
  otm_1         char(1);        otm_2         char(1);

  CURSOR doc IS
    -- наши начальные пл ССП из ARC_RRP
  SELECT 'A' x, fn_b trans_id, rec_b trans_ln,
       lpad(mfoa, 9) || lpad(nlsa, 14) ||
       lpad(mfob, 9) || lpad(nlsb, 14) ||
       lpad(to_char(dk), 1) || lpad(to_char(s), 16) ||
       lpad(to_char(vob),2)
       || rpad(nvl(nd,' '), 10)  ||
       lpad(to_char(kv), 3) || nvl(to_char(datd,'YYMMDD'),'      ') ||
       nvl(to_char(datp,'YYMMDD'),'      ') ||
       rpad(nvl(nam_a,' '), 38)  || rpad(nvl(nam_b,' '),38) ||
       rpad(nvl(nazn,' '), 160) || rpad(nvl(d_rec,' '),60) || rpad(nvl(naznk,' '), 3) ||
       rpad(nvl(nazns,' '), 2) ||
       lpad(nvl(id_a,' '), 14) || lpad(nvl(id_b,' '), 14)  ||
       lpad(nvl(ref_a,' '), 9) || rpad(nvl(id_o,' '), 6) ||
       lpad(to_char(bis),2) || lpad(' ', 8)
       as line,
       sign,
       'Y' otm
  FROM arc_rrp
  WHERE dat_b>=gl.bDATE AND dat_b<gl.bDATE+1
  AND fn_b LIKE '$A'||sep.aSAB||'______' -- AND prty=1
        AND SUBSTR(fn_b,9,1)<>'.'
  AND sos>=7 -- только по сквитованным
  UNION ALL
  -- наши ответные пл ССП из ARC_RRP
  SELECT 'A' x, fa_name trans_id, fa_ln trans_ln,
       lpad(mfoa, 9) || lpad(nlsa, 14) ||
             lpad(mfob, 9) || lpad(nlsb, 14) ||
       lpad(to_char(dk), 1) || lpad(to_char(s), 16) ||
       lpad(to_char(vob),2)
       || rpad(nvl(nd,' '), 10)  ||
       lpad(to_char(kv), 3) || nvl(to_char(datd,'YYMMDD'),'      ') ||
       nvl(to_char(datp,'YYMMDD'),'      ') ||
       rpad(nvl(nam_a,' '), 38)  || rpad(nvl(nam_b,' '),38) ||
       rpad(nvl(nazn,' '), 160) || rpad(nvl(d_rec,' '),60) || rpad(nvl(naznk,' '), 3) ||
       rpad(nvl(nazns,' '), 2) ||
       lpad(nvl(id_a,' '), 14) || lpad(nvl(id_b,' '), 14)  ||
       lpad(nvl(ref_a,' '), 9) || '      ' ||  --rpad(nvl(id_o,' '), 6) ||
       lpad(to_char(bis),2) || lpad(' ', 8)
       as line,
       sign,
       'Y' otm
  FROM arc_rrp
  WHERE dat_a>=gl.bDATE AND dat_a<gl.bDATE+1
  AND fa_name is not null AND substr(fa_name,9,1)<>'.' --AND prty=1
  AND substr(fa_name,3,4)<>sep.aSAB  -- этим условием исключаем наши начальные
  AND sos>=3  -- только по сквитованным
  UNION ALL
  -- начальные пл ССП из выписки $V.G/F
  SELECT 'V' x, trans_id, trans_ln,
       lpad(mfoa, 9) || lpad(nlsa, 14) ||
                   lpad(mfob, 9) || lpad(nlsb, 14) ||
       lpad(to_char(dk), 1) || lpad(to_char(s), 16) ||
       lpad(to_char(vob),2)
       || rpad(nvl(nd,' '), 10)  ||
       lpad(to_char(kv), 3) || nvl(to_char(datd,'YYMMDD'),'      ') ||
       nvl(to_char(datp,'YYMMDD'),'      ') ||
       rpad(nvl(nam_a,' '), 38)  || rpad(nvl(nam_b,' '),38) ||
       rpad(nvl(nazn,' '), 160) || rpad(nvl(d_rec,' '),60) || rpad(nvl(naznk,' '), 3) ||
       rpad(nvl(nazns,' '), 2) ||
       lpad(nvl(id_a,' '), 14) || lpad(nvl(id_b,' '), 14)  ||
       lpad(nvl(ref_a,' '), 9) || rpad(nvl(id_o,' '), 6) ||
       lpad(to_char(bis),2) || lpad(nvl(reserved,' '), 8)
       as line,
       sign,
       'Y' otm
  FROM tmp_ssp_v
  WHERE src='A'
  UNION ALL
  -- ответные пл ССП из выписки $V.G/F
  SELECT 'V' x, trans_id, trans_ln,
       lpad(mfoa, 9) || lpad(nlsa, 14) ||
           lpad(mfob, 9) || lpad(nlsb, 14) ||
       lpad(to_char(dk), 1) || lpad(to_char(s), 16) ||
       lpad(to_char(vob),2)
       || rpad(nvl(nd,' '), 10)  ||
       lpad(to_char(kv), 3) || nvl(to_char(datd,'YYMMDD'),'      ') ||
       nvl(to_char(datp,'YYMMDD'),'      ') ||
       rpad(nvl(nam_a,' '), 38)  || rpad(nvl(nam_b,' '),38) ||
       rpad(nvl(nazn,' '), 160) || rpad(nvl(d_rec,' '),60) || rpad(nvl(naznk,' '), 3) ||
       rpad(nvl(nazns,' '), 2) ||
       lpad(nvl(id_a,' '), 14) || lpad(nvl(id_b,' '), 14)  ||
       lpad(nvl(ref_a,' '), 9) || '      ' ||  --rpad(nvl(id_o,' '), 6) ||
       lpad(to_char(bis),2) || lpad(nvl(reserved,' '), 8)
       as line,
       sign,
       'Y' otm
  FROM tmp_ssp_v
  WHERE src='B'
  ORDER BY 2,3,1;

BEGIN
  if p_sign_on is null or p_sign_on not in (0,1) then
    erm := 'Недопустимое значение параметра p_sign_on: '||p_sign_on;
    raise sys_err;
  end if;
  -- пока ЭЦП не сверяем, т.к. при работе по 3 модели документы в ARC_RRP уже лежат с внутр. ЭЦП
  OPEN doc;

  LOOP
  <<M1>>
    FETCH doc INTO x_1,trans_id_1,trans_ln_1,line_1,sign_1,otm_1;
    EXIT WHEN doc%NOTFOUND;
  <<M2>>
    FETCH doc INTO x_2,trans_id_2,trans_ln_2,line_2,sign_2,otm_2;

    IF doc%NOTFOUND THEN
     INSERT INTO tmp_dif_ssp_v(x,trans_id,trans_ln,line,sign,otm)
     VALUES(x_1,trans_id_1,trans_ln_1,line_1,sign_1,otm_1);
     EXIT;
    END IF;

    IF trans_id_1=trans_id_2 AND trans_ln_1=trans_ln_2 THEN
     IF line_1<>line_2 or otm_1<>otm_2 THEN -- подпись пока не сверяем
      INSERT INTO tmp_dif_ssp_v (x,trans_id,trans_ln,line,sign,otm)
      VALUES(x_1,trans_id_1,trans_ln_1,line_1,sign_1,otm_1);
      INSERT INTO tmp_dif_ssp_v (x,trans_id,trans_ln,line,sign,otm)
      VALUES(x_2,trans_id_2,trans_ln_2,line_2,sign_2,otm_2);
     END IF;
     GOTO M1;
    ELSE
     INSERT INTO tmp_dif_ssp_v (x,trans_id,trans_ln,line,sign,otm)
     VALUES(x_1,trans_id_1,trans_ln_1,line_1,sign_1,otm_1);
     x_1    :=  x_2;
     trans_id_1 :=  trans_id_2;
     trans_ln_1 :=  trans_ln_2;
     line_1     :=  line_2;
     sign_1     :=  sign_2;
     otm_1      :=  otm_2;
     GOTO M2;
    END IF;

  END LOOP;
  CLOSE doc;
exception when sys_err then
  raise_application_error(-(20000+ern),erm,TRUE);
END dif_ssp;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE pz_grc(ret_  OUT SMALLINT,
                  fn_      CHAR,
                 dat_      DATE,
                   n_      SMALLINT,
                  sd_      DECIMAL,
                  sk_      DECIMAL,
                errk_      SMALLINT) IS

nn      SMALLINT;
sde_    DECIMAL(24);
skr_    DECIMAL(24);
datt_   DATE;

BEGIN

INSERT INTO tmp_z (fn, dat, n,sde,skr, errk)
           VALUES (fn_,dat_,n_,sd_,sk_,errk_);

BEGIN
IF SUBSTR(fn_,2,1)='A' THEN
   SELECT  n, dat,   sde,  skr
     INTO nn, datt_, sde_, skr_
   FROM zag_b
   WHERE fn=fn_ AND dat>=TRUNC(dat_) AND dat<TRUNC(dat_)+1;
ELSE
   SELECT  n, dat,   sde,  skr
     INTO nn, datt_, sde_, skr_
   FROM zag_a
   WHERE fn=fn_ AND dat>=TRUNC(dat_) AND dat<TRUNC(dat_)+1;
END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN nn := NULL;
END;

IF nn  IS NULL THEN
   ret_ := 1103;    -- receipt on nonexisting file
   RETURN;
ELSIF n_<> nn OR dat_<>datt_ OR sd_<>sde_ OR sk_<>skr_ THEN
   ret_ := 1105;    -- receipt is not fitted
   RETURN;
END IF;
ret_ := 0;
RETURN;
END pz_grc;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE pz3_grc IS
--
-- Подготовка данных по межобластным оборотам(для головного банка по 3 модели)
--
dat_        DATE;

BEGIN
dat_ := gl.bDATE+1;

INSERT INTO tmp_z3 (id1,id2,n,s)

SELECT id1,id2,SUM(n) n,SUM(s) s
  FROM

(SELECT
       SUBSTR(c.sab,2,1) id1,SUBSTR(d.sab,2,1) id2,count(*) n,sum(s) s
   FROM arc_rrp x,banks c,banks d
  WHERE x.dk = 1 AND x.kv=980
    AND x.mfoa<>G_NBU_mfo AND x.mfob<>G_NBU_mfo
    AND x.mfoa = c.mfo AND c.mfop<>G_NBU_mfo AND
        (c.mfop=gl.aMFO OR c.mfop IN
           (SELECT mfo FROM banks WHERE mfop=gl.aMFO and mfo<>G_NBU_mfo)
        )
    AND x.mfob = d.mfo AND d.mfop<>G_NBU_mfo AND
  (d.mfop=gl.aMFO OR d.mfop IN
           (SELECT mfo FROM banks WHERE mfop=gl.aMFO and mfo<>G_NBU_mfo)
        )
    AND  x.dat_b >= gl.bDATE AND x.dat_b < dat_
  GROUP BY SUBSTR(c.sab,2,1), SUBSTR(d.sab,2,1)

  UNION ALL

 SELECT
  SUBSTR(d.sab,2,1) id1,SUBSTR(c.sab,2,1) id2,count(*) n,sum(s) s
   FROM arc_rrp x,banks c,banks d
  WHERE x.dk = 0 AND x.kv=980
    AND x.mfoa<>G_NBU_mfo AND x.mfob<>G_NBU_mfo
    AND x.mfob = c.mfo AND c.mfop<>G_NBU_mfo AND
        (c.mfop=gl.aMFO OR c.mfop IN
           (SELECT mfo FROM banks WHERE mfop=gl.aMFO and mfo<>G_NBU_mfo)
        )
    AND x.mfoa = d.mfo AND d.mfop<>G_NBU_mfo AND
  (d.mfop=gl.aMFO OR d.mfop IN
           (SELECT mfo FROM banks WHERE mfop=gl.aMFO and mfo<>G_NBU_mfo)
        )
    AND  x.dat_b >= gl.bDATE AND x.dat_b < dat_
  GROUP BY SUBSTR(d.sab,2,1), SUBSTR(c.sab,2,1)
  UNION ALL
 select id1.id,id2.id,0,0 from
(SELECT UNIQUE decode(substr(a.sab,2,1),'J','I','1','I',substr(a.sab,2,1)) id
 FROM banks a
 WHERE SUBSTR(a.sab,2,1) BETWEEN 'A' AND 'Z') id1,
(SELECT UNIQUE decode(substr(a.sab,2,1),'J','I','1','I',substr(a.sab,2,1)) id
 FROM banks a
 WHERE SUBSTR(a.sab,2,1) BETWEEN 'A' AND 'Z') id2
)
 GROUP BY id1,id2;
END pz3_grc;

/***************************************************************/
/***  Функция zap_reqv() для подмены доп. реквизитов         ***/
/***  для запросов на уточнение реквизитов платежа           ***/
/***************************************************************/
FUNCTION zap_reqv(dir_ NUMBER, mfob_ VARCHAR2, d_rec_ VARCHAR2) RETURN VARCHAR2 IS

tmp_ VARCHAR2(18);
l_cnt pls_integer;

BEGIN

   IF mfob_=gl.aMFO OR INSTR('!+*-?',SUBSTR(d_rec_,2,1))=0 THEN RETURN d_rec_; END IF;

   tmp_:=SUBSTR(d_rec_,3,18);

select count(*) into l_cnt from banks where mfop='300465' and mfo = mfob_ and mfo<>'300001';
   /*bars_audit.info('SEP.zap_reqv1 dir_ = '||dir_||'SUBSTR(d_rec_,2,1) = '||SUBSTR(d_rec_,2,1));*/
   IF /*dir_=3 AND */SUBSTR(d_rec_,2,1)='?' THEN   --  NBU Request
     /*bars_audit.info('SEP.zap_reqv2 dir_ = '||dir_||'SUBSTR(d_rec_,2,1) = '||SUBSTR(d_rec_,2,1));*/
      BEGIN
         SELECT fn_a||LPAD(TO_CHAR(rec_a),6) INTO tmp_
           FROM arc_rrp
          WHERE fn_b=SUBSTR(d_rec_,3,12) AND rec_b=SUBSTR(d_rec_,15,6)
                                         AND dat_b>=ADD_MONTHS(gl.bDATE,-1);
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
   ELSIF dir_ IN (4,6,14) AND INSTR('!+*-',SUBSTR(d_rec_,2,1))>0
 and l_cnt = 0
THEN -- Branch reply

      BEGIN
         SELECT fn_b||LPAD(TO_CHAR(rec_b),6) INTO tmp_
           FROM arc_rrp
          WHERE fn_a=SUBSTR(d_rec_,3,12) AND rec_a=SUBSTR(d_rec_,15,6)
                                         AND dat_a>=ADD_MONTHS(gl.bDATE,-1);
      EXCEPTION WHEN OTHERS THEN NULL;
      END;
   END IF;
   /*bars_audit.info('SEP.zap_reqv3 tmp_ = '||tmp_);*/
   RETURN SUBSTR(d_rec_,1,2)||tmp_||SUBSTR(d_rec_,21);

END zap_reqv;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE pu_grc
  (op_ CHAR,mfog_ VARCHAR,mfou_ VARCHAR,
             mfo_ VARCHAR,sab_  CHAR,nb_ VARCHAR,nmo_ CHAR,rez_ CHAR)
  IS

kodg_     SMALLINT;
mfok_     VARCHAR(12);
mfop_     VARCHAR(12);
ssp_      SMALLINT;

BEGIN

IF op_ NOT IN ('A','D') THEN
   RETURN;
END IF;

IF G_kl_bob IS NOT NULL THEN
   IF op_ = 'A' THEN
      BEGIN
         SELECT mfo INTO mfok_ FROM banks WHERE mfo = mfo_;
         INSERT INTO klpu ( nbw, mfo,  sab, op )
                   VALUES ( nb_, mfo_, sab_,'U');

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
         INSERT INTO klpu ( nbw, mfo,  sab, op )
                   VALUES ( nb_, mfo_, sab_,'I');
      END;
   ELSE
      INSERT INTO klpu ( nbw, mfo,  sab, op )
                VALUES ( nb_, mfo_, sab_,'D');
   END IF;
END IF;

kodg_ := NULL;

BEGIN
  SELECT kodg INTO kodg_ FROM banks WHERE mfo=mfou_;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
  BEGIN
    SELECT kodg INTO kodg_ FROM banks WHERE mfo=mfog_;
  EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
  END;
END;

IF kodg_ IS NULL THEN
   kodg_ := 999;
END IF;

-- Признак работы в ССП ставим для всех
ssp_ := 1;

mfop_ := NULL;
BEGIN
  SELECT mfo INTO mfop_ FROM banks
   WHERE mfop = gl.aMFO AND (
         mfo = mfo_  OR
         mfo = (SELECT mfop FROM banks WHERE mfop<>gl.aMFO AND mfo=mfo_));

  IF mfop_ = gl.aMFO THEN     -- Do not permit direct particpant update
     RETURN;
  END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
END;

IF mfop_ IS NULL THEN         -- Looking if main bank registered
   mfop_ := G_NBU_mfo;
   IF op_ = 'A' THEN
      INSERT INTO banks( mfo, sab, nb, mfop, kodg, blk, mfou, nmo, ssp)
                 VALUES( mfo_,sab_,nb_,mfop_,kodg_,  0, mfou_,nmo_,ssp_);
   END IF;
ELSE                    --  OUR participant Found
   IF op_ = 'A' THEN    --  Just    UPDATE
      UPDATE banks
         SET sab=sab_,nb=nb_,blk=0,kodg=kodg_,mfou=mfou_,nmo=nmo_,ssp=ssp_
       WHERE mfo=mfo_;
   ELSE
      UPDATE banks SET blk=4 WHERE mfo=mfo_;
   END IF;
END IF;

RETURN;

END pu_grc;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE pn_grc(mfoa_ VARCHAR) IS
--
-- On opening new BANKING DATE - Assigning of new FILE NAMES
--            Called from OPEN-BANKING-DAY programm.
--
-- Modification history:
-- (16/09/98 MIK)  Direction 6 added
-- (30/09/98 MIK)  Migrated from Informix
--
--
mfo_       VARCHAR(12);
koda_      SMALLINT;
otm_       SMALLINT;
sab_       CHAR(4);
sea_       CHAR(1);
dd_        CHAR(2);
sv_        CHAR(1);
fm_        CHAR(1);
fmo_       CHAR(2);
fn_        CHAR(12);
fn_b_      CHAR(12);
dat_       DATE;
dat_b_     DATE;
lkl_dat_   DATE;
sde_       DECIMAL(24);
skr_       DECIMAL(24);
n_         SMALLINT;
i_         SMALLINT  := 0;
bn_        SMALLINT;
bn_ssp_    SMALLINT;
kv_        SMALLINT;
errk_      SMALLINT;
ref_       INTEGER;
row_       ROWID;

-- работаем только за последний месяц
CURSOR zag IS
SELECT ref, kv, fn, dat, n, sde, skr, otm, rowid
  FROM zag_b
 WHERE fn like '_'||fm_||sab_||'%' AND dat < TRUNC(dat_b_) AND dat>=ADD_MONTHS(TRUNC(dat_b_),-1) AND
       SUBSTR(fn,9,1)='.' AND -- только файлы СЭП
       DECODE("OTM",0,0,1,1,2,2,3,3,NULL)<=3;

CURSOR zag_ssp IS
SELECT ref, kv, fn, dat, n, sde, skr, otm, rowid
  FROM zag_b
 WHERE kv=980 AND
       fn like '$'||fm_||sab_||'%' AND dat < TRUNC(dat_b_) AND dat>=ADD_MONTHS(TRUNC(dat_b_),-1) AND
       SUBSTR(fn,9,1)<>'.' AND -- пакеты ССП
       DECODE("OTM",0,0,1,1,2,2,3,3,NULL)<=3;

ern       CONSTANT POSITIVE := 051;
erm       VARCHAR2(80);
err       EXCEPTION;

BEGIN
   trace('Старт для МФО '||mfoa_);

   dd_    := TO_CHAR(gl.bDATE,'DD');
   dat_b_ := TO_DATE (TO_CHAR(gl.bDATE,'MM-DD-YYYY')||' '||
                      TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');

   MD32 := h2_rrp(TO_NUMBER(TO_CHAR(gl.bDATE,'MM')))||
           h2_rrp(TO_NUMBER(TO_CHAR(gl.bDATE,'DD')));

   mfo_   := NULL;
   sab_   := NULL;
   sea_   := NULL;
   koda_  := NULL;

   BEGIN
      SELECT mfo, sab, kodn, fmo
        INTO mfo_,sab_,koda_,fmo_ FROM banks
       WHERE mfop = gl.aMFO AND mfo = mfoa_;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         erm := '\0904 - Not an direct participant '||mfoa_;
         raise_application_error(-(20746),erm,TRUE);
   END;

   sv_ := SUBSTR(fmo_,1,1);
   fm_ := SUBSTR(fmo_,2,1);

   IF koda_=1 OR koda_=3 THEN
      sab_ := aSAB;
   END IF;

   OPEN zag;
   LOOP
   <<FETCH_zag>>
     FETCH zag INTO ref_,kv_,fn_,dat_,n_,sde_,skr_,otm_,row_;
     EXIT WHEN zag%NOTFOUND;

     IF sea_ IS NOT NULL THEN COMMIT; END IF;

     IF kv_=980 THEN sv_:='$';
     ELSE
        BEGIN
           SELECT sv INTO sv_ FROM tabval WHERE kv=kv_;
        EXCEPTION WHEN NO_DATA_FOUND THEN sv_:='$';
        END;
     END IF;

     IF koda_=0 OR koda_=1 THEN
        sea_ := TRANSLATE(SUBSTR(fn_,10,1),
               '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ',
               'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');

        fn_b_:= sv_||fm_||SUBSTR(fn_,3,4)||dd_||'.'||sea_||SUBSTR(fn_,11,2);

     ELSIF koda_ in (4,6,14) THEN     -- Internal (New)

        IF SUBSTR(fn_,10,1) IN ('0','1','2','3','4','5','6','7','8') THEN
           sea_ := CHR(ASCII(SUBSTR(fn_,10,1))+1);
        ELSE   -- Expired file. AutoSettlment.
           sea_ := 'X';
        END IF;

        fn_b_ := sv_||fm_||SUBSTR(fn_,3,4)||MD32||'.'||sea_||SUBSTR(fn_,11,2);

     ELSIF koda_=3 THEN     -- NBU (New)

        BEGIN
           SELECT dat,bn INTO lkl_dat_,bn_ FROM lkl_rrp WHERE mfo=mfo_ AND kv=kv_;
        EXCEPTION
           WHEN NO_DATA_FOUND THEN
              erm := '\9126 - No participant in lkl_rrp '||mfoa_||'('||kv_||')';
              raise_application_error(-(20746),erm,TRUE);
        END;

        IF TRUNC(lkl_dat_)=TRUNC(dat_b_) THEN
           bn_ := bn_+1;
           UPDATE lkl_rrp SET dat=dat_b_,bn=bn_ WHERE mfo=mfo_ AND kv=kv_;
        ELSE
           bn_ := 1;
           UPDATE lkl_rrp SET dat=dat_b_,kn=-1,bn=1,bn_ssp=0 WHERE mfo=mfo_ AND kv=kv_;
        END IF;

        sea_  := '0';
        fn_b_ := sv_||fm_||SUBSTR(fn_,3,4)||MD32||SUBSTR(fn_,9,2)||h2_rrp(TRUNC(bn_/36))||h2_rrp(MOD(bn_,36));

     END IF;

     IF otm_ = 3 THEN otm_ := 1; END IF;

     BEGIN
        SELECT 1 INTO i_ FROM
        (SELECT 1 FROM zag_b
          WHERE kv=kv_ AND fn=fn_b_ AND dat>=TRUNC(dat_b_) AND dat<TRUNC(dat_b_)+1
          UNION ALL
         SELECT 1 FROM zag_k
          WHERE kv=kv_ AND fn=fn_b_ AND dat>=TRUNC(dat_b_) AND dat<TRUNC(dat_b_)+1
         ) WHERE rownum=1; EXIT;  -- Сбой счетчика файлов
     EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
     END;

     INSERT INTO zag_b(ref, kv, fn,   dat,   n, sde, skr ,otm)
                VALUES(ref_,kv_,fn_b_,dat_b_,n_,sde_,skr_,otm_);

     UPDATE arc_rrp SET fn_b=fn_b_,dat_b=dat_b_ WHERE fn_b=fn_ AND dat_b=dat_;

     DELETE FROM zag_b WHERE rowid=row_;

     info('Переформирован ночной файл: '
          ||fn_||' за '||to_char(dat_,'DD.MM.YYYY HH24:MI')||' --> '
          ||fn_b_||' за '||to_char(dat_b_,'DD.MM.YYYY HH24:MI')
         );
-- Expired file. AutoSettlment.

     IF koda_ IN (4,6,14) AND SUBSTR(fn_b_,10,1)='X' THEN
        ps_grc(errk_,'RT0',fn_b_,dat_b_,n_,sde_,skr_,0,0);
        IF errk_<>0 THEN
           error('Ошибка '||errk_||' при автозачислении файла '
                 ||fn_b_||' за '||to_char(dat_b_,'DD.MM.YYYY HH24:MI'));
           erm := chr(92)||TO_CHAR(errk_,'9999')||' - Unable to settle.File '||fn_b_;
           raise_application_error(-(20746),erm,TRUE);
        END IF;
        info('Автозачисление файла '||fn_b_||' за '||to_char(dat_b_,'DD.MM.YYYY HH24:MI'));
     END IF;

   END LOOP;
   CLOSE zag;

-- переформировуем пакеты ССП
   IF koda_=3 THEN
      trace('Переформирование пакетов ССП');
      sv_:='$';  -- пакеты только в гривне
      OPEN zag_ssp;
      LOOP
      <<FETCH_zag_ssp>>
        FETCH zag_ssp INTO ref_,kv_,fn_,dat_,n_,sde_,skr_,otm_,row_;
        EXIT WHEN zag_ssp%NOTFOUND;
-- читаем текущие значения счетчиков
           BEGIN
              SELECT dat,bn,bn_ssp INTO lkl_dat_,bn_,bn_ssp_ FROM lkl_rrp WHERE mfo=mfo_ AND kv=kv_;
           EXCEPTION
              WHEN NO_DATA_FOUND THEN
                 erm := '\9126 - No participant in lkl_rrp '||mfoa_||'('||kv_||')';
                 raise_application_error(-(20746),erm,TRUE);
           END;
-- инкрементируем счетчики
           IF TRUNC(lkl_dat_)=TRUNC(dat_b_) THEN
              bn_ssp_ := bn_ssp_+1;
              UPDATE lkl_rrp SET dat=dat_b_,bn_ssp=bn_ssp_ WHERE mfo=mfo_ AND kv=kv_;
           ELSE
              bn_ssp_ := 1;
              UPDATE lkl_rrp SET dat=dat_b_,kn=-1,bn=0,bn_ssp=bn_ssp_ WHERE mfo=mfo_ AND kv=kv_;
           END IF;
-- назначаем новое имя пакета
           fn_b_ := sv_||fm_||SUBSTR(fn_,3,4)||MD32||ssp_trans_id(bn_ssp_);
           INSERT INTO zag_b(ref, kv, fn,   dat,   n, sde, skr ,otm)
                      VALUES(ref_,kv_,fn_b_,dat_b_,n_,sde_,skr_,otm_);

           UPDATE arc_rrp SET fn_b=fn_b_,dat_b=dat_b_ WHERE fn_b=fn_ AND dat_b=dat_;

           DELETE FROM zag_b WHERE rowid=row_;

           info('Переформирован ночной пакет: '
              ||fn_||' за '||to_char(dat_,'DD.MM.YYYY HH24:MI')||' --> '
              ||fn_b_||' за '||to_char(dat_b_,'DD.MM.YYYY HH24:MI')
               );

      END LOOP;
      CLOSE zag_ssp;
      COMMIT;
   END IF;

   trace('Финиш для МФО '||mfoa_);

END pn_grc;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE ips IS
--
-- BARS98 Informacionno-Poiskovaja Sistema NBU
--
sea_      CHAR(2);
fn_qa_    CHAR(12);
fn_qb_    CHAR(12);
fn_qd_    CHAR(12);
fn_a_     CHAR(12);
fn_b_     CHAR(12);
mfoa_  VARCHAR(12);
mfob_  VARCHAR(12);
mfop_  VARCHAR(12);
nlsa_  VARCHAR(15);
nlsb_  VARCHAR(15);
dat_a_        DATE;
dat_b_        DATE;
dat_k_        DATE;
dat_pb_       DATE;
datt_         DATE;
kv_       SMALLINT;
dk_       SMALLINT;
errk_     SMALLINT;
kodn_     SMALLINT;
bis_      SMALLINT;
bas_      SMALLINT;
s_     DECIMAL(24);
rec_a_    SMALLINT;
rec_b_    SMALLINT;
upd_      SMALLINT;
rn_       SMALLINT;
dat_          DATE;
dat_o_        DATE;
f_rq_      CHAR(1);
t_rq_      CHAR(3);
ref_q_    arc_rrp.sign%type;
suf_       CHAR(1);
dat_s_        DATE;  -- data SEP

CURSOR ips IS
    SELECT  fn_qa, mfoa, nlsa, fn_a, dat_a, rec_a, bis,
            fn_qb, mfob, nlsb, fn_b, dat_b, rec_b,
            dk, s, kv, dat_pb, errk, f_rq, t_rq, ref_q, dat_sep
      FROM ips_rrp WHERE otm IS NULL
       FOR UPDATE OF fn_qa,rec_qa,otm;

CURSOR ipi IS
    SELECT  fn_qa,dat_sep
      FROM ips_rrp
     WHERE fn_qb=fn_qa_ AND --dat_sep=dat_s_ AND
            fn_b=fn_a_  AND rec_b=rec_a_ AND
            mfoa=mfoa_ AND nlsa=nlsa_ AND
            mfob=mfob_ AND nlsb=nlsb_ AND dk=dk_ AND s=s_ AND kv=kv_
        FOR UPDATE OF bis;



ern       CONSTANT POSITIVE := 015;
erm       VARCHAR2(80);
err       EXCEPTION;


BEGIN
DELETE from ips_rrp WHERE otm=5;

datt_ := TO_DATE (TO_CHAR(gl.bDATE,'MM-DD-YYYY')||' '||
                  TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');

BEGIN
   SELECT  dat_r, rn
     INTO  dat_,  rn_ FROM lkl_rrp WHERE mfo=G_NBU_mfo AND kv=gl.baseval;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      erm := 'No NBU participant found (lkl_rrp)';
      RAISE err;
END;

IF NOT(TRUNC(datt_)=TRUNC(dat_)) THEN
   UPDATE lkl_rrp SET dat_r = datt_,rn = 0 WHERE mfo=G_NBU_mfo AND kv=gl.baseval;
   rn_ := 0;
END IF;

rn_  := rn_ + 1;
sea_ := h2_rrp(TRUNC(rn_/36))||h2_rrp(MOD(rn_,36));
bas_ := 0;
upd_ := 0;


OPEN ips;
LOOP
<<FETCH_ips>>
  FETCH ips INTO fn_qa_,mfoa_,nlsa_,fn_a_,dat_a_,rec_a_,bis_,
                 fn_qb_,mfob_,nlsb_,fn_b_,dat_b_,rec_b_,
                 dk_,s_,kv_,dat_pb_,errk_,f_rq_,t_rq_,ref_q_,dat_s_;
  EXIT WHEN ips%NOTFOUND;

  BEGIN
     SELECT DECODE(kodn,3,'A','K') INTO suf_
       FROM banks
      WHERE mfop = gl.aMFO AND (
             mfo = mfob_ OR
        mfo = (SELECT mfop FROM banks WHERE mfop <> gl.aMFO AND mfo=mfob_));
  EXCEPTION
     WHEN NO_DATA_FOUND THEN suf_ := 'A';
  END;

  IF fn_qa_ IS NULL THEN   -- OUR request sending (Assign QA-Name AvK)

     upd_   := 1;
     fn_qa_ := SUBSTR(fn_a_,1,1)||'Q'||SUBSTR(fn_a_,3,4)||MD32||'.'||suf_||sea_;
     UPDATE ips_rrp
        SET fn_qa = fn_qa_,rec_qa = 0,otm = 1 WHERE CURRENT OF ips;

  ELSIF SUBSTR(fn_qa_,10,1) IN ('K','A') AND fn_qb_ IS NULL THEN -- Rqst from outside

     BEGIN
        SELECT a.fn_b,a.dat_b,a.rec_b,z.datk
          INTO   fn_b_, dat_b_, rec_b_, dat_k_
          FROM arc_rrp a,zag_b z
         WHERE a.fn_a=fn_a_
           AND a.dat_a=dat_a_
           AND a.s=s_
           AND a.dk=dk_
           AND a.mfoa=mfoa_
           AND a.nlsa=nlsa_
           AND a.mfob=mfob_
           AND a.nlsb=nlsb_
           AND z.dat=a.dat_b
           AND z.fn=a.fn_b
           AND ROWNUM=1;
     EXCEPTION
         WHEN NO_DATA_FOUND THEN
              fn_b_ := NULL;
             dat_b_ := NULL;
             rec_b_ := NULL;
             dat_k_ := NULL;

     END;

     IF fn_b_ IS NULL THEN
        errk_ := 0402;  -- Not found
     ELSE
        errk_ := 0000;
     END IF;

     BEGIN
       SELECT mfop, kodn
         INTO mfop_,kodn_ FROM banks WHERE mfo=mfob_;
     EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
     END;

     IF errk_<>0000 OR mfob_=gl.aMFO OR mfop_=gl.aMFO AND kodn_ IN (4,6,14)
     THEN

        upd_   := 1;
        IF SUBSTR(fn_qa_,10,1)='K' THEN
           fn_qb_ := SUBSTR(fn_qa_,1,6)||MD32||'.S'||sea_;
        ELSE
           fn_qb_ := SUBSTR(fn_qa_,1,6)||MD32||'.B'||sea_;
        END IF;

        UPDATE ips_rrp
           SET fn_qb = fn_qb_, fn_b = fn_b_, dat_b =dat_b_, rec_b = rec_b_,
               dat_pb= dat_k_, errk= errk_, dat_qa=datt_, bis = 0,otm = 2
         WHERE CURRENT OF ips;
        GOTO FETCH_ips;
     END IF;

     IF errk_=0000 AND mfob_ <> gl.aMFO THEN  -- Transmitting of the request down

        upd_   := 1;
        fn_qa_ := SUBSTR(fn_b_,1,1)||'Q'||SUBSTR(fn_b_,3,4)||MD32||'.'||suf_||sea_;

        UPDATE ips_rrp
           SET fn_qb=fn_qa_, fn_b=fn_b_, dat_b =dat_b_, rec_b=rec_b_,
              dat_pb=dat_k_, errk=errk_, dat_qa=datt_
        WHERE CURRENT OF ips;

        INSERT INTO ips_rrp
         (dat_sep,fn_qa,rec_qa,mfoa,nlsa,mfob,nlsb,dk,s,kv,
          fn_a,dat_a,rec_a,f_rq,t_rq,ref_q,otm)
        VALUES
         (dat_b_,fn_qa_,0,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,kv_,
          fn_b_,dat_b_,rec_b_,f_rq_,t_rq_,ref_q_,1);

     END IF;

  ELSIF ( (SUBSTR(fn_qa_,10,1) = 'A' AND SUBSTR(fn_qb_,10,1) = 'B')
       OR (SUBSTR(fn_qa_,10,1) = 'K' AND SUBSTR(fn_qb_,10,1) = 'S'))
      AND (bis_=0 OR bis_=1) THEN -- Rpl trns

     fn_qd_ := NULL;
     OPEN ipi;
     LOOP
     <<FETCH_ips>>
     FETCH ipi INTO fn_qd_,dat_s_;
     EXIT WHEN ipi%NOTFOUND;

         UPDATE ips_rrp
            SET fn_qb=fn_qb_, bis= bis_-1 WHERE CURRENT OF ipi;

         EXIT;
     END LOOP;
     CLOSE ipi;

     IF fn_qd_ IS NOT NULL THEN

        upd_   := 1;

        fn_qd_ := SUBSTR(fn_qd_,1,6)||MD32||SUBSTR(fn_qb_,9,2)||sea_;

/*      IF SUBSTR(fn_qb_,10,1) = 'B'THEN
           fn_qd_ := SUBSTR(fn_qd_,1,6)||MD32||'.S'||sea_;
        ELSE
           fn_qd_ := SUBSTR(fn_qd_,1,6)||MD32||'.B'||sea_;
        END IF; */

        bas_   := bas_+100;

        UPDATE ips_rrp
           SET fn_qb = fn_qd_, rec_qb = bis+bas_, dat_qb = datt_,
                 bis = bis+2-bis_, otm = 2, dat_sep = dat_s_
         WHERE fn_qb=fn_qb_ AND otm IS NULL AND
                mfoa=mfoa_ AND nlsa=nlsa_ AND
                mfob=mfob_ AND nlsb=nlsb_ AND dk=dk_ AND s=s_ AND kv=kv_;

     END IF;
  END IF;

END LOOP;
CLOSE ips;

IF upd_ > 0 THEN
   UPDATE lkl_rrp SET rn = rn_ WHERE mfo=G_NBU_mfo AND kv=gl.baseval;
END IF;

END ips;
/***************************************************************/
/***                                                         ***/
/***************************************************************/
PROCEDURE ips_insert(
          ret_     OUT SMALLINT,    -- Error code
          dat_sep_ DATE,
    mfoa_    VARCHAR,
    nlsa_    VARCHAR,
    mfob_    VARCHAR,
    nlsb_    VARCHAR,
    dk_      SMALLINT,
    s_       DECIMAL,
    kv_      SMALLINT,
    fn_qa_   VARCHAR,
    rec_qa_  SMALLINT,
    dat_qa_  DATE,
    errk_    CHAR,
    fn_a_    VARCHAR,
    rec_a_   SMALLINT,
    dat_a_   DATE,
    dat_pa_  DATE,
    fn_qb_   VARCHAR,
    rec_qb_  SMALLINT,
    dat_qb_  DATE,
    fn_b_    VARCHAR,
    rec_b_   SMALLINT,
    dat_b_   DATE,
    dat_pb_  DATE,
    bis_     SMALLINT,
    dat_l_   DATE,
    f_rq_    CHAR,
    t_rq_    CHAR,
    ref_q_   RAW,
    ref_a_   VARCHAR) IS

flag_  VARCHAR(12);
--
-- Inserting ips docs
--
BEGIN

INSERT INTO ips_rrp (dat_sep,mfoa,nlsa,mfob,nlsb,dk,s,kv,
        fn_qa,rec_qa,dat_qa,errk,fn_a,rec_a,dat_a,
  dat_pa,fn_qb,rec_qb,dat_qb,fn_b,rec_b,dat_b,
  dat_pb,bis,dat_l,f_rq,t_rq,ref_q,ref_a)
VALUES (dat_sep_,TRIM(mfoa_),TRIM(nlsa_),TRIM(mfob_),TRIM(nlsb_),dk_,s_,kv_,
  fn_qa_,rec_qa_,dat_qa_,errk_,fn_a_,rec_a_,dat_a_,
  dat_pa_,fn_qb_,rec_qb_,dat_qb_,fn_b_,rec_b_,dat_b_,
  dat_pb_,bis_,dat_l_,f_rq_,t_rq_,ref_q_,ref_a_);

ret_ := 0;
RETURN;

END ips_insert;
/***************************************************************/
/*** Копирует БИСы в допреквизиты operw                      ***/
/***************************************************************/
PROCEDURE bis2ref(rec_ NUMBER,ref_ NUMBER) IS
i      NUMBER;
j      NUMBER;
tmp_   VARCHAR2(230);

tag_   VARCHAR2(10);
val_   VARCHAR2(250);
sim_   VARCHAR2(1);
BEGIN

FOR c IN (SELECT nazn,d_rec,bis FROM arc_rrp
           WHERE bis>1 AND rec IN
          (SELECT rec FROM rec_que WHERE rec_g=rec_ AND rec_g IS NOT NULL))
LOOP
   tmp_:=trim(c.nazn||c.d_rec);

   i:=GREATEST(INSTR(tmp_,'#F'),INSTR(tmp_,'#C'),INSTR(tmp_,'#П'));

   WHILE i>0 LOOP -- обработка подряд идущих #F<TAG>:<VAL>#F<TAG>:<VAL>#
      sim_:=SUBSTR(tmp_,i+1,1);
      tmp_:=SUBSTR(tmp_,i+2);
      i:=INSTR(tmp_,'#');
      IF i>0 THEN
         IF sim_='F' THEN
            j:=INSTR(tmp_,':');
            val_:=TRIM(SUBSTR(tmp_,j+1,i-j-1));
            tag_:=TRIM(SUBSTR(tmp_,1,j-1));
         ELSE
            val_:=TRIM(SUBSTR(tmp_,1,i-1));
            tag_:=sim_||TO_CHAR(c.bis-1);
         END IF;

         UPDATE operw SET value=value||CHR(13)||CHR(10)||val_
          WHERE ref=ref_ AND TRIM(tag)=tag_;

         IF SQL%ROWCOUNT=0 THEN
            BEGIN
               INSERT INTO operw(ref,tag,value) VALUES(ref_,tag_,val_);
            EXCEPTION WHEN OTHERS THEN NULL;
            END;
         END IF;
      END IF;
      i:=GREATEST(INSTR(tmp_,'#F'),INSTR(tmp_,'#C'),INSTR(tmp_,'#П'));
   END LOOP; -- WHILE i>0 LOOP
END LOOP; -- SELECT
END bis2ref;
/**
 * get_blk - вернуть код блокировки участника по валюте
 * @param p_sab - эл. адрес
 * @param p_kv - код валюты
 * @return - код блокировки
 */
function get_blk(p_sab in varchar2, p_kv in int) return int is
  ern       constant positive := 070;
  erm       varchar2(80);
  sys_err   exception;
  l_blk  int;
begin
  -- блокировка в разрезе валют
  begin
  select l.blk into l_blk
  from banks b, lkl_rrp l where b.sab=p_sab and b.mfo=l.mfo and l.kv=p_kv;
  return l_blk;
  exception when no_data_found then
    erm := 'Не найден участник с кодом '||p_sab;
    raise sys_err;
  end;
exception when sys_err then
  raise_application_error(-(20000+ern),erm,TRUE);
end get_blk;
/***************************************************************/
/***  Установить код блокировки участника по валюте          ***/
/***************************************************************/
procedure set_blk(p_sab in varchar2, p_kv in int, p_blk in int) is
-- p_sab - эл. адрес
-- p_kv  - код валюты
-- p_blk - код блокировки
  ern       constant positive := 071;
  erm       varchar2(80);
  sys_err   exception;
begin
  -- блокируем в разрезе валют
  update lkl_rrp set blk=p_blk
  where kv=p_kv and mfo=(select mfo from banks where sab=p_sab);
  if sql%rowcount=0 then
    erm := 'Не найден участник с кодом '||p_sab;
    raise sys_err;
  end if;
exception when sys_err then
  raise_application_error(-(20000+ern),erm,TRUE);
end set_blk;
/***************************************************************/
/*** Установить код блокировки участника по направлению        */
/***************************************************************/
procedure set_blk_dir(p_kodn in int, p_kv in int, p_blk in int) is
  ern       constant positive := 072;
  erm       varchar2(80);
  sys_err   exception;
begin
  update lkl_rrp set blk=p_blk
  where kv=p_kv and mfo in (select mfo from banks where kodn=p_kodn and mfop=gl.aMFO);
  if sql%rowcount=0 then
    erm := 'Не найден участник по направлению '||p_kodn;
    raise sys_err;
  end if;
exception when sys_err then
  raise_application_error(-(20000+ern),erm,TRUE);
end set_blk_dir;

/**
 * in_sep_add - установка дополнительных параметров платежа(после ЭЦП)
 * работает под СЭП-2
 */
PROCEDURE in_sep_add(
    rec_     NUMBER,      -- Номер строки в arc_rrp
       fa_name_   VARCHAR2,   -- 25 Имя                    файла  A
      fa_ln_     NUMBER,     -- 26 Порядковый номер ИС  в файле  A
    fa_t_arm3_  VARCHAR2,   -- 27 Время прохождения через АРМ-3 A
    fa_t_arm2_  VARCHAR2,   -- 28 Время получения       в АРМ-2 A
    f_reserved_ VARCHAR2,   -- Зарезервировано(сейчас не используется)
    fb_name_   VARCHAR2,   -- 33 Имя                    файла  B
    fb_ln_     NUMBER,     -- 34 Порядковый номер ИС  в файле  B
    fb_t_arm2_  VARCHAR2,   -- 35 Время формирования    в АРМ-2 B
    fb_t_arm3_  VARCHAR2,   -- 36 Время получения       в АРМ-3 B
    fb_d_arm3_  DATE        -- 37 Дата  получения       в АРМ-3 B
) IS
   ern     CONSTANT POSITIVE := 100;
   sys_err EXCEPTION;
   erm     VARCHAR2(80);

BEGIN



  UPDATE arc_rrp SET
       fa_name    = fa_name_,
      fa_ln     = fa_ln_,
    fa_t_arm3   = fa_t_arm3_,
    fa_t_arm2   = fa_t_arm2_,
    fb_name   = fb_name_,
    fb_ln     = fb_ln_,
    fb_t_arm2   = fb_t_arm2_,
    fb_t_arm3   = fb_t_arm3_,
    fb_d_arm3   = fb_d_arm3_
  WHERE rec=rec_;
  IF SQL%ROWCOUNT = 0 THEN
      -- выбрасываем отрицательную(!) ошибку
      erm := 'Document not found, rec='||rec_;
      RAISE sys_err;
  END IF;
EXCEPTION WHEN sys_err THEN
   raise_application_error(-(20000+ern),erm,TRUE);
END in_sep_add;

procedure del_ref_t902 (p_ref in number) is
 begin
   DELETE FROM t902 WHERE ref= p_ref;
END;

procedure check_t902_dok(p_ref in number) is
  l_ref number;
begin
  select ref into l_ref from t902 where ref = p_ref for update skip locked;

exception
  when no_data_found then
    raise_application_error(-20000,
                            'Документ вже оброблено!');
  
end;
/**
 * mark_zag_k - помечает заголовок расформированного файла отметкой p_otm
 * @param p_fn  - имя файла
 * @param p_dat - дата+время файла
 * @param p_otm - отметка
 */
procedure mark_zag_k(p_fn varchar2, p_dat date, p_otm number) is
   ern     CONSTANT POSITIVE := 101;
   sys_err EXCEPTION;
   erm     VARCHAR2(80);
begin
  update zag_k set otm=p_otm where fn=p_fn and dat=p_dat;
  if sql%rowcount = 0 then
      erm := 'File not found: '||p_fn||', '||to_char(p_dat,'DD.MM.YYYY HH24:MI');
      raise sys_err;
  end if;
exception when sys_err then
   raise_application_error(-(20000+ern),erm,true);
end mark_zag_k;

/**
 * select_ssp_trans - отбирает необходимые идентификаторы транзакций ССП
 */
procedure select_ssp_trans is
begin
    -- удаляем из tmp_ssp_trans ранее принятые входящие срочные на банк (и входящие на филиалы по ВПС)
    delete from tmp_ssp_trans where trans_id in (
      select fa_name from arc_rrp
      where bis in (0,1) and dat_a>=gl.bDATE and dat_a<gl.bDATE+1
      and fa_name is not null and substr(fa_name,9,1)<>'.');
end select_ssp_trans;
--
-- Клиринг транзитов для 3 модели ОщадБанка (Вызывается из JOB)
--
PROCEDURE transit_clearing (dat_ DATE DEFAULT NULL) IS
dat1_   DATE;
dat2_   DATE;
nlsa_   VARCHAR2(14);  nlsb_  VARCHAR2(14);
tip_a_  VARCHAR2(3);   tip_b_ VARCHAR2(3);
ostca_  NUMBER;
ostcb_  NUMBER;
kv_     SMALLINT    := 980;
dk_     SMALLINT    := NULL;
dk#     SMALLINT;
rec#    NUMBER(38)  := NULL;
ref_    NUMBER(38);
mfoa_   VARCHAR2(9) := NULL;
mfob_   VARCHAR2(9) := NULL;
mfo_nbu VARCHAR2(9) := NULL;
s_      NUMBER(38)  := 0;
s#      NUMBER(38);

mfoa#   VARCHAR2(9);
mfob#   VARCHAR2(9);
i       INTEGER     := 0;
j       INTEGER     := 0;

CURSOR c0 IS
SELECT rec,dk,s,
DECODE(SUBSTR(fn_a,3,4),sep.aSAB,mfo_nbu,DECODE(vob,90,gl.aMFO,
 (SELECT mfo FROM banks
   WHERE mfop = gl.aMFO AND (
         mfo  = mfoa OR
         mfo  = (SELECT mfop FROM banks WHERE mfop <> gl.aMFO AND mfo=mfoa))))) mfoa,
DECODE(SUBSTR(fn_b,3,4),sep.aSAB,mfo_nbu,
 (SELECT mfo FROM banks
   WHERE mfop = gl.aMFO AND (
         mfo  = mfob OR
         mfo  = (SELECT mfop FROM banks WHERE mfop <> gl.aMFO AND mfo=mfob)))) mfob
    FROM arc_rrp
   WHERE (fn_a IS NOT NULL OR mfoa=gl.aMFO OR vob=90)
     AND kv=kv_ AND dat_b>=dat1_ AND dat_b<dat2_ AND dk IN (0,1)
     AND sos>3 AND sos<8
 ORDER by mfob,mfoa,dk;

BEGIN

if gl.aMFO = '300465' then

SELECT mfo INTO mfo_nbu FROM banks WHERE mfop = gl.aMFO AND kodn=3;


dat1_ := NVL(dat_,gl.bDATE);
dat2_ := NVL(dat_,gl.bDATE) + 1;

bars_audit.info('Transit clearing STARTED for date '||to_char(dat1_,'DD-MM-YYYY'));

OPEN c0;
savepoint this#mfo;
LOOP
FETCH c0 INTO rec#,dk#,s#,mfoa#,mfob#;
   IF c0%NOTFOUND AND rec# IS NULL THEN EXIT; END IF;
   IF c0%NOTFOUND OR dk#<>dk_ OR mfoa# <> mfoa_ OR mfob# <> mfob_ THEN

      BEGIN
         SELECT nls,tip,ostc INTO nlsa_,tip_a_,ostca_ FROM accounts a,bank_acc b
          WHERE a.kv=kv_
            AND tip IN (case when dk_=0 then 'T0D' else 'T00' end,
                        case when dk_=0 then 'TOD' else 'TO0' end) AND a.acc=b.acc AND b.mfo=mfoa_;
      EXCEPTION
         WHEN OTHERS THEN
            dbms_output.put_line('Ош. поиска счета для '||mfoa_||' '||SQLERRM);
            nlsa_:='?';tip_a_:='???';ostca_:=0;
      END;

      BEGIN
         SELECT nls,tip,ostc INTO nlsb_,tip_b_,ostcb_ FROM accounts a,bank_acc b
          WHERE a.kv=kv_
            AND tip IN (case when dk_=0 then 'TUD' else 'TUR' end,
                        case when dk_=0 then 'TND' else 'TNB' end) AND a.acc=b.acc AND b.mfo=mfob_;
      EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Ош. поиска счета для '||mfob_||' '||SQLERRM);
            nlsb_:='?';tip_b_:='???';ostcb_:=0;
      END;

--    dbms_output.put_line('***'||mfoa_||'->'||mfob_||' s='||s_);
--    dbms_output.put_line('__'||mfoa_||' '||nlsa_||' '||tip_a_||' '||ostca_);
--    dbms_output.put_line('__'||mfob_||' '||nlsb_||' '||tip_b_||' '||ostcb_);

      begin

         gl.ref (ref_);

         INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,datd,
            nam_a,nlsa,mfoa,nam_b,nlsb,mfob,kv,s,kv2,s2,id_a,id_b,nazn,userid)
         VALUES (ref_,'KLR',6,substr(ref_,-10),dk_,SYSDATE,gl.bDATE,gl.bDATE,
               'Отправленные платежи участника '||mfoa_,nlsa_,gl.aMFO,
               'Сквитованные платежи участника '||mfob_,nlsb_,gl.aMFO,kv_,s_,kv_,s_,'99999','99999',
               'Клірінг транзитних рахунків за '||to_date(dat1_,'DD/MM/YYYY'),gl.aUID);

         PAYTT(1,ref_,gl.bDATE,'KLR',dk_,kv_,nlsa_,s_,kv_,nlsb_,s_);

      exception
         when others then
            rollback to this#mfo;
            j := j + 1;
            bars_audit.info('Transit clearing ERROR:'||SUBSTR(sqlerrm,1,255));
--          dbms_output.put_line(SUBSTR(sqlerrm,1,255));
      end;

      savepoint this#mfo;

      s_ := 0;

   END IF;

   EXIT WHEN c0%NOTFOUND;

---   dbms_output.put_line('rec='||rec#||','||mfoa#||'->'||mfob#||' s='||s#);

   s_ := s_ + s#; dk_:=dk#; mfoa_ := mfoa#; mfob_ := mfob#;

   UPDATE arc_rrp SET sos = 9 WHERE rec = rec#;
   i := i + 1;
END LOOP;
bars_audit.info('Transit clearing COMPLETED. Total:'||to_char(i)||', Skipped:'||to_char(j)||' docs.');
END IF; -- MFO 300465
END transit_clearing;
--
-- Создание JOBа клиринга транзитов
--
PROCEDURE create_transit_clearing_job IS
    l_jobid   number;    /* идентификатор созданного задания */
BEGIN
   DBMS_JOB.SUBMIT(l_jobid, 'SEP.Transit_clearing;', SYSDATE,'SYSDATE + 1/48');
   bars_audit.info('SEP.Transit_clearing JOB created id='|| to_char(l_jobid));
   COMMIT;
END create_transit_clearing_job;
--
-- get_nbu_mfo - возвращает МФО управления НБУ, которое ведет корсчет банка
--               (оно же MFOP из PARAMS)
function get_nbu_mfo return varchar2 is
begin
  return G_NBU_mfo;
end get_nbu_mfo;

/**
 * deny_date_control - выключает контроль даты файла $A на соответствие текущей банковской
 */
procedure deny_date_control is
begin
  g_date_control := false;
end deny_date_control;

/*********************** BCE *************************/
BEGIN

   BEGIN
      SELECT GREATEST(99,val)
        INTO G_BPGRCCNT
        FROM params
       WHERE par='BPGRCCNT';
   EXCEPTION WHEN OTHERS THEN G_BPGRCCNT := 1000;
   END;

   BEGIN
      SELECT  sab
        INTO aSAB
        FROM banks
       WHERE mfo = gl.aMFO;
   EXCEPTION WHEN NO_DATA_FOUND THEN aSAB := 'XXXX';
   END;

   BEGIN
      SELECT mfo,sab,kodn,pm,SUBSTR(fmi,2,1),SUBSTR(fmo,2,1),ssp
        INTO G_NBU_mfo,G_NBU_sab,G_NBU_kodn,G_NBU_pm,G_NBU_fmi,G_NBU_fmo,G_NBU_ssp
        FROM banks
       WHERE mfop = gl.aMFO AND kodn=3;
   EXCEPTION WHEN NO_DATA_FOUND THEN
        raise_application_error(-20902,'No NBU bank found',TRUE);
   END;

   BEGIN
      SELECT val
        INTO nMODEL
        FROM params
       WHERE par = 'NUMMODEL';
   EXCEPTION WHEN NO_DATA_FOUND THEN nMODEL := '0';
   END;
   BEGIN
      SELECT val
        INTO G_dval_OP
        FROM params
       WHERE par = 'SEPDVALO';
   EXCEPTION WHEN NO_DATA_FOUND THEN G_dval_OP := NULL;
   END;
   BEGIN
      SELECT val
        INTO G_nosign_kod
        FROM params
       WHERE par = 'NOSI_KOD';
   EXCEPTION WHEN OTHERS THEN G_nosign_kod := NULL;
   END;
   BEGIN
      SELECT to_number(val)
        INTO G_sepnum
        FROM params
       WHERE par = 'SEPNUM';
   EXCEPTION WHEN OTHERS THEN G_sepnum := 1;
   END;
   BEGIN
      SELECT ','||TRIM(val)||','
        INTO G_SepVobList
        FROM params
       WHERE par = 'VOB2SEP2';
   EXCEPTION WHEN OTHERS THEN G_SepVobList := ',1,2,6,33,81,';
   END;
   BEGIN
      SELECT to_number(val)
        INTO G_kl_bob
        FROM params
       WHERE par = 'KL_BOB';
   EXCEPTION WHEN OTHERS THEN G_kl_bob := NULL;
   END;
   BEGIN
      SELECT acc,nls
        INTO G_acc_T00,G_nls_T00
        FROM v_accounts_proc
       WHERE p_tip = 'T00' AND kv=980;
   EXCEPTION WHEN OTHERS THEN G_acc_T00 := NULL;
   END;

   BEGIN
      SELECT acc
        INTO G_acc_T0D
        FROM v_accounts_proc
       WHERE p_tip = 'T0D' AND kv=980;
   EXCEPTION WHEN OTHERS THEN G_acc_T0D := NULL;
   END;

MD32 := h2_rrp(TO_NUMBER(TO_CHAR(gl.bDATE,'MM')))||
        h2_rrp(TO_NUMBER(TO_CHAR(gl.bDATE,'DD')));
END;
/