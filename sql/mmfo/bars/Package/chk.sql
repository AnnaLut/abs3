
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/chk.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CHK IS
-- ****************************************************************
-- *            Financial cheks functions package                 *
-- *                Unity-Bars (c) 2000-2009                          *
-- ****************************************************************
/*
    -- OSC+VISASIGN+WEB                 Ощадный банк(ГРЦ)
    -- OSC+VISASIGN+WEB+KF              Ощадный банк(мульти-мфо)
    -- VISASIGN                         Демарк (уточнить, нужен ли макрос FM)
*/

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 3.66 16/10/2016';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := ''

  ||'OSC - формирование внутреннего буфера для Ощадбанка'||chr(10)
  ||'VISASIGN - с ЭЦП на визе'||chr(10)
  ||'WEB - процедуры для WEB'||chr(10)
  ||'KF - мульти-мфо схема с полем ''KF'''||chr(10)
;


-- ----------------------------------------------------------------
-- Global Declaration
-- ----------------------------------------------------------------
    CurrRef_    NUMBER;
    uid_        NUMBER; -- USER IDENT
    self_grp_      number; -- код группы самовизирования
    self_grp_hex_  varchar2(2); -- код группы самовизирования в hex
    cash_grp_      number; -- код группы кассы
    cash_grp_hex_  varchar2(2); -- код группы кассы в hex
    F_VISASIGN  number; -- флаг ЭЦП на визе
    F_INTSIGN   number; -- флаг внутренней ЭЦП

    g_cashvl  varchar2(80);  -- Список касових віз(Касира відділення, Сховище)

    DEF_INT_SIGN CONSTANT PLS_INTEGER := 1;  -- флаг внутренней ЭЦП
    DEF_EXT_SIGN CONSTANT PLS_INTEGER := 2;  -- флаг внешней ЭЦП

  TYPE tt_num_array IS TABLE OF number INDEX BY BINARY_INTEGER;
  TYPE tt_str_array IS TABLE OF varchar2(32676) INDEX BY BINARY_INTEGER;

  type tt_ecp_obj is record(
    id           number,
    sign_type    varchar2(3),
    buffer_hex   varchar2(32676),
    key_id        varchar2(2048),
    sign_hex     varchar2(32676));
  type tt_ecp_array is table of tt_ecp_obj index by binary_integer;
  TYPE tt_visa_obj IS RECORD (ref number, err number, erm varchar2(2000), grp number, f_pay integer, f_sign integer, f_check integer, sign_bufs tt_str_array);
  type tt_visa_obj_ext is record(
    ref            number,
    err            number,
    erm            varchar2(2000),
    grp            number,
    f_pay          integer,
    f_sign         integer,
    f_check        integer,
    sgntype_code   varchar2(3),
    keyid          varchar2(2048),
    int_buffer_hex varchar2(32676),
    int_sign_hex   varchar2(32676),
    ext_buffer_hex varchar2(32676),
    ext_sign_hex   varchar2(32676),
    int_ecp        tt_ecp_array,
    ext_ecp        tt_ecp_obj);

  TYPE tt_visa_array IS TABLE OF tt_visa_obj INDEX BY BINARY_INTEGER;
  TYPE tt_visa_array_ext IS TABLE OF tt_visa_obj_ext INDEX BY BINARY_INTEGER;

  TYPE tt_visa_ECP_data_obj IS RECORD (ref number, key varchar2(6), sign_bufs tt_str_array, sign_bufs_ecp tt_str_array);
  TYPE tt_visa_ECP_data_array IS TABLE OF tt_visa_ECP_data_obj INDEX BY BINARY_INTEGER;

-- Для nextvisagrup
  TYPE oper_type IS TABLE OF oper%ROWTYPE;
  doc  oper%rowtype;
-- Возвращает версию пакета
function header_version return varchar2;
function body_version return varchar2;
function version return varchar2;
-- Инициализация переменных пакета
procedure param;
-- PRAGMA RESTRICT_REFERENCES (param, WNDS );
-- ----------------------------------------------------------------
-- Returns CheckStamp                                            --
-- ----------------------------------------------------------------
FUNCTION put_stmp (idg_ NUMBER) RETURN VARCHAR2;
-- ----------------------------------------------------------------
--  возвращает строку oper из doc oper%rowtype                   --
-- ----------------------------------------------------------------
FUNCTION oper_row
  RETURN oper_type PARALLEL_ENABLE PIPELINED;
-- ----------------------------------------------------------------
--  применяет динамическое условие к документу по ref            --
-- ----------------------------------------------------------------
FUNCTION doc_is_valid ( ref_ NUMBER, cond_ VARCHAR2 ) RETURN NUMBER;
-- ----------------------------------------------------------------
--  применяет динамическое условие к документу в doc             --
-- ----------------------------------------------------------------
FUNCTION doc_is_valid ( cond_ VARCHAR2 ) RETURN NUMBER;
-- ----------------------------------------------------------------
-- Returns next visa group id для транзакции tt                  --
-- ----------------------------------------------------------------
FUNCTION GetNextVisaGroup ( TT_     IN VARCHAR2,
                            CVISAG_ IN VARCHAR2 ) RETURN VARCHAR2;
-- ----------------------------------------------------------------
-- Returns next visa grpoup id для документа ref                 --
-- ----------------------------------------------------------------
FUNCTION GetNextVisaGroup ( REF_    IN NUMBER,
                            CVISAG_ IN VARCHAR2 ) RETURN VARCHAR2;
-- ----------------------------------------------------------------
-- Checks transaction acknowlegement by checker
-- ----------------------------------------------------------------
PROCEDURE doc_ack (ref_ IN  NUMBER,
                    tt_ IN  VARCHAR2,
                   chk_ IN  VARCHAR2,
                   ack_ OUT NUMBER );
-- ----------------------------------------------------------------
-- Puts Big_Ammount_Passed Stamp                                 --
-- ----------------------------------------------------------------
PROCEDURE put_big ( flg_  IN OUT  NUMBER,
                    ref_  NUMBER,
                     tt_  VARCHAR2,
                    kv1_  NUMBER,
                     s1_  NUMBER,
                    kv2_  NUMBER,
                     s2_  NUMBER );
-- ----------------------------------------------------------------
-- Puts Nostro_Account_Assigned_ Stamp                           --
-- ----------------------------------------------------------------
PROCEDURE put_nos (  ref_  NUMBER,
                     grp_  NUMBER );
-- ----------------------------------------------------------------
-- Returns Hex Representation of number                          --
-- ----------------------------------------------------------------
PROCEDURE put_ack (ref_ NUMBER);

PROCEDURE put_prty (p_ref number, p_prty number);

FUNCTION TO_HEX(n_ NUMBER) RETURN VARCHAR2;
--PRAGMA RESTRICT_REFERENCES (TO_HEX, WNDS );

FUNCTION TO_HEX(x_ VARCHAR2) RETURN VARCHAR2;
--PRAGMA RESTRICT_REFERENCES (TO_HEX, WNDS );

-- ----------------------------------------------------------------
-- Puts current visa stamp, inserts oper_visa                    --
-- ----------------------------------------------------------------

-- 0/1 - возвращает 1 если включен режим виз с ЭЦП
-- (INTSIGN=2 and VISASIGN=1)
function  mode_visa_sign return integer;

PROCEDURE put_visa_out (ref_ NUMBER, tt_ CHAR, grp_ NUMBER, status_ NUMBER,
                     keyid_ VARCHAR2, sign1_ VARCHAR2,sign2_ VARCHAR2, sqnc_ out number);

PROCEDURE put_visa (ref_ NUMBER, tt_ CHAR, grp_ NUMBER, status_ NUMBER,
                     keyid_ VARCHAR2, sign1_ VARCHAR2,sign2_ VARCHAR2);

-- Отримання буфферу для накладання внутрішної ЕЦП
procedure get_int_buffer_hex(p_ref        in oper_visa.ref%type,
                             p_lev        in number,
                             p_buffer_hex out varchar2);

-- Отримання даних внутрішньої ЕЦП документу на відповідній візі
procedure get_int_ecp(p_ref          in oper_visa.ref%type,
                      p_lev          in number,
                      p_sign_type    out varchar2,
                      p_buffer_hex   out varchar2,
                      p_key_id       out varchar2,
                      p_sign_hex     out varchar2);

-- Отримання переліку накладених внутрішніх підписів
function get_int_ecps(p_ref in oper_visa.ref%type, p_lev in number)
  return tt_ecp_array;

-- Отримання зовнішнього підпису (у вигляді об'єкту)
function get_ext_ecp_obj(p_ref in oper_visa.ref%type) return tt_ecp_obj;

-- Отримання зовнішнього підпису
procedure get_ext_ecp(p_ref          in oper_visa.ref%type,
                      p_sign_type    out varchar2,
                      p_buffer_hex   out varchar2,
                      p_key_id       out varchar2,
                      p_sign_hex     out varchar2);

PROCEDURE get_buf(ref_ NUMBER, lev_ NUMBER, buf_ OUT VARCHAR2);

PROCEDURE get_buf_aux(ref_ NUMBER, lev_ NUMBER, buf_ OUT VARCHAR2, sign_len OUT NUMBER);

procedure pvisa_flag4check(ref_ number, lev_ number, fsig_ out integer);

function visa_flag4check(ref_ number, lev_ number) return integer;

/*
 * visa_flag4sign() вычисление флага ЭЦП визы для операции и группы контроля
 * для наложения ЭЦП
 */
procedure visa_flag4sign(tt_ varchar2, grp_ number, fsig_ out integer);

/**
 * Блокировка документа для последующего визирования
 */
PROCEDURE lock_doc(ref_ NUMBER,grp_ NUMBER,
                 fpay_ OUT NUMBER, fsig_ OUT NUMBER);

-- возвращает буфер документа для внутр. ЭЦП
procedure make_int_docbuf(pref in number, buf out varchar2);

-- возвращает буфер документа для внутр. ЭЦП и его размер
procedure make_int_docbuf2(pref in number, buf out varchar2, buf_len out number);

/**
 * Получение параметров визы документа без блокировки
 */
PROCEDURE get_visa_params(ref_ NUMBER,grp_ NUMBER, fpay_ OUT NUMBER, fsig_ OUT NUMBER);

/**
 * процедура возвращает буфера для ЭЦП и прочую информацию по заданному списку  референсов
 * @param p_refs in - список референсов
 * @param p_grp in - код группы визирования
 * @param p_key in - отладочный ключ, если NULL - берем из БД
 * @param p_visa_array out массив данных для наложения виз на перечень документов
 */
procedure make_data4visa(p_refs in tt_num_array, p_grp in integer, p_key in varchar2, p_visa_array out tt_visa_array);

/**
 * Разширение make_data4visa для работы с новой криптографией
 */
procedure make_data4visa_ext(p_refs in tt_num_array, p_grp in integer, p_key in varchar2, p_key_hash in varchar2, p_sign_type in varchar2, p_visa_array out tt_visa_array_ext);


/**
 * Аналогичная к make_data4visa
 * только параметры в xml
 */
procedure make_data4visa_xml(inDataClob in CLOB, outDataXml out CLOB);

/**
 * Разширение make_data4visa_xml для работы с новой криптографией
 */
procedure make_data4visa_ext_xml(inDataClob in CLOB, outDataXml out CLOB);

/**
 * Наложение виз на документы и оплата по факту
 * параметры в xml
 */
procedure put_visas_xml(inDataClob in CLOB, outDataXml out CLOB);

procedure put_visas_xml_ext(inDataClob in CLOB, outDataXml out CLOB, enableCommit in number default 0);

/**
 * update_check_sign - модификация информации о проверке ЭЦП на визе
 * @param p_sqnc in - глобальный номер визы
 * @param p_check_code in - код проверки ЭЦП на визе
 * @param p_check_msg in - описание кода проверки ЭЦП на визе
 */
procedure update_check_sign(p_sqnc in number, p_check_code in integer, p_check_msg in varchar2);

/**
* Возвращает длину буффера документа (зависит от типа ЭЦП)
*/
function get_SignLng return number deterministic;

/**
* возвращает номер групы "самовиза"
*/
function get_selfvisa_grp_id return number deterministic;

/**
* возвращает номер групы "самовиза" в hex
*/
function get_selfvisa_grp_hex return varchar2 deterministic;

/**
* возвращает номер групы "касса"
*/
function get_cashvisa_grp_id return number deterministic;

/**
* возвращает номер групы "касса" в hex
*/
function get_cashvisa_grp_hex return varchar2 deterministic;

/**
* Определяем флаг ЭЦП на указаном документе и его уровни и получаем необходимые буффера для проверки
*/
procedure getVisaBuffersForCheck(pRef in number, pLev in number, FSign out integer, IntBuff out varchar2, ExtBuff out varchar2);

PROCEDURE put_ack0(ref_ NUMBER, grp_ NUMBER);

/**
 * reset_visa_history - сбрасывает историю виз на плановых документах
 * @param p_tt in - тип опрации
 */
procedure reset_visa_history(p_tt in tts.tt%type);

/**
 * proc_reset_visa_queue - сбрасывает историю виз на плановых документах
 * разбирает очередь RESET_VISA_QUEUE
 */
procedure proc_reset_visa_queue;

/**
 * enqueue_reset_visa - вставляет код операции TT в очередь на сброс истории визирования
 */
procedure enqueue_reset_visa(p_tt in tts.tt%type);


/**
 * back_last_visa - откатывает последнюю визу
 * @param p_ref in - референс документа
 * @param p_reasonid in - код причины отката визы
 */
procedure back_last_visa(p_ref in oper.ref%type, p_reasonid in oper_visa.passive_reasonid%type default null);

----
-- get_next_visa_branches - возвращает список бранчей для следующей визы
--
function get_next_visa_branches return oper.next_visa_branches%type;


END chk;

/
CREATE OR REPLACE PACKAGE BODY BARS.CHK IS

-- ****************************************************************
-- *            Financial cheks functions package                 *
-- *               Unity-Bars (c) 2000-2006                       *
-- *                                                              *
-- ****************************************************************

/*
   -- OSC+VISASIGN+WEB+FM+KF+ORA11     Ощадный банк(мульти-мфо)
   -- VISASIGN                         Демарк (уточнить, нужен ли макрос FM)
*/

G_BODY_VERSION  CONSTANT VARCHAR2(100)  := '$Ver: 3.58 2018-07-10';

G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := ''

  ||'GOU - формирование внутреннего буфера для Ощадбанка-ГРЦ'||chr(10)
  ||'OSC - формирование внутреннего буфера для Ощадбанка'||chr(10)
  ||'VISASIGN - с ЭЦП на визе'||chr(10)
  ||'WEB - процедуры для WEB'||chr(10)
  ||'FM  - с проверкой Фин.Мониторинга'||chr(10)
  ||'KF  - мульти-мфо схема с полем ''KF'''||chr(10)
  ||'ORA11 - под Oracle 11g'||chr(10)
;

g_pack_name varchar2(20) := 'chk. ';

MODCODE constant varchar2(3) := 'VIS';

g_sepnum   number;   /* номер версии СЭП */


DEF_CHARGED number := 4;

G_CHECKTT0      tts.tt%type;
G_CHECKTT1      tts.tt%type;

-- Флаг нового алгоритму побудови буфферу для ЕЦП (0 - старий "матрьошка", 1 - новий кожний рядок)
g_use_new_buffer_scheme number := 1;

-- определяем исключение на отсутствие сообщений в очереди
MQ_EMPTY_OR_TIMEOUT_EXCEPTION EXCEPTION;
PRAGMA EXCEPTION_INIT(MQ_EMPTY_OR_TIMEOUT_EXCEPTION, -25228);


-- ----------------------------------------------------------------
--  version - возвращает версию пакета                           --
-- ----------------------------------------------------------------
function header_version return varchar2 is
begin
  return 'Package header CHK '||G_HEADER_VERSION||'.'||chr(10)
     ||'AWK definition: '||chr(10)
     ||G_AWK_HEADER_DEFS;
end header_version;
function body_version return varchar2 is
begin
  return 'Package body CHK '||G_BODY_VERSION||'.'||chr(10)
     ||'AWK definition: '||chr(10)
     ||G_AWK_BODY_DEFS;
end body_version;
function version return varchar2 is
begin
  return 'Package header CHK '||G_HEADER_VERSION||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||G_AWK_HEADER_DEFS||chr(10)||chr(10)||
         'Package   body CHK '||G_BODY_VERSION||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||G_AWK_BODY_DEFS;
end version;
-- ----------------------------------------------------------------
-- Returns CheckStamp                                            --
-- ----------------------------------------------------------------
FUNCTION put_stmp (idg_ NUMBER) RETURN VARCHAR2 IS
BEGIN

   RETURN LPAD(NVL(TO_HEX(idg_),0),2,'0')||LPAD(TO_HEX(uid_),4,'0');

END put_stmp;

-- ----------------------------------------------------------------
-- Returns next visa grpoup id для документа ref                 --
-- ----------------------------------------------------------------
FUNCTION GetNextVisaGroup ( REF_    IN NUMBER,
                            CVISAG_ IN VARCHAR2 ) RETURN VARCHAR2
IS

    NVISAG_ VARCHAR2(2);

BEGIN
    BEGIN
        SELECT * INTO chk.doc FROM oper WHERE ref = REF_;
        NVISAG_ := GetNextVisaGroup( chk.doc.tt, CVISAG_ );
    EXCEPTION WHEN NO_DATA_FOUND THEN
        NVISAG_ := NULL;
    END;

    RETURN NVISAG_;
END GetNextVisaGroup;


function get_flag_37(p_tt tts.tt%type) return varchar2
    result_cache relies_on(tts)
is
    l_flag  varchar2(1);
begin
    select substr(flags,38,1) into l_flag from tts where tt=p_tt;
    return l_flag;
exception when no_data_found then
    return '1';
end;
-- ----------------------------------------------------------------
--  возвращает строку опер из doc oper%rowtype                   --
-- ----------------------------------------------------------------
FUNCTION oper_row
  RETURN oper_type PARALLEL_ENABLE PIPELINED IS
BEGIN
   PIPE ROW(doc); RETURN;
END oper_row;
-- ----------------------------------------------------------------
--  применяет динамическое условие к документу по ref            --
-- ----------------------------------------------------------------
FUNCTION doc_is_valid ( ref_ NUMBER, cond_ VARCHAR2 ) RETURN NUMBER IS
i   NUMBER := 0;
BEGIN
  IF cond_ IS NULL THEN i := 1;
  ELSE
     BEGIN
        EXECUTE IMMEDIATE
       'SELECT 1 FROM oper o WHERE ref = :1 AND '||cond_ INTO i USING ref_;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN NULL;
        WHEN OTHERS THEN
      -- 'Ошибка в условии визы ;
         bars_error.raise_nerror(MODCODE, 'ERR_VIS_COND','$COND',cond_);
     END;
  END IF;
  RETURN i;
END;
-- ----------------------------------------------------------------
--  применяет динамическое условие к документу в doc             --
-- ----------------------------------------------------------------
FUNCTION doc_is_valid ( cond_ VARCHAR2 ) RETURN NUMBER IS
i   NUMBER := 0;
BEGIN
  IF cond_ IS NULL THEN i := 1;
  ELSE
     BEGIN
        EXECUTE IMMEDIATE
       'SELECT 1 FROM TABLE(chk.oper_row) o WHERE '||cond_ INTO i;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN NULL;
        WHEN OTHERS THEN
        -- выдаем нормальную диагностику
        raise_application_error(-20000, 'Помилка в умові на візі:'||chr(10)
        ||cond_||chr(10)
        ||'Текст помилки:'||chr(10)
        ||dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace
        );
     END;
  END IF;
  RETURN i;
END;
-- ----------------------------------------------------------------
-- Возвращает код следующей группы визирования
-- текущий рефернс документа используется для вычисления
-- динамического построения цепочки финансовых виз
--            (Вызывается из триггера tiu_oper_chk)
--                 должен быть заполнен chk.doc
-- ----------------------------------------------------------------
FUNCTION GetNextVisaGroup ( TT_     IN VARCHAR2,
                            CVISAG_ IN VARCHAR2 ) RETURN VARCHAR2
IS
    MAXG_    NUMBER;
    DEFG_    NUMBER;
    CVIS_    VARCHAR2(2);
    NVIS_    VARCHAR2(2);
    CPRT_    NUMBER;
    CIDC_    NUMBER;
    PFLAG_   VARCHAR2(1);


BEGIN

    -- Get controls flag for operation
    -- Return "ReadyToPay" sign if operation set to pay immediately
    IF get_flag_37(tt_) = '1' THEN
       RETURN '!!';
    END IF;

    CVIS_ := SUBSTR('00' || CVISAG_, -2);
    IF CVIS_ = '!!' THEN
       RETURN '!!';
    END IF;
    CIDC_ := (INSTR('0123456789ABCDEF',SUBSTR(CVIS_,1,1))-1)*16+
              INSTR('0123456789ABCDEF',SUBSTR(CVIS_,2,1))-1;

--  Get visagroup id with max. priority
    MAXG_ := NULL;
    FOR m IN (SELECT IDCHK, SQLVAL, PRIORITY FROM CHKLIST_TTS
               WHERE TT=TT_
               ORDER BY PRIORITY DESC)
    LOOP
        IF m.IDCHK IS NOT NULL THEN
           IF DEFG_ IS NULL THEN
              DEFG_ := m.IDCHK;
           END IF;
           IF chk.DOC_IS_VALID( m.SQLVAL ) = 1 THEN
              MAXG_ := m.IDCHK;
              EXIT;
           END IF;
        END IF;
    END LOOP;
--
--  Get the max group if no one is defined

    IF DEFG_ IS NULL THEN
        BEGIN
            SELECT MIN(idchk) INTO DEFG_ FROM CHKLIST;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            DEFG_ := NULL;
        END;
    END IF;

--  Get the defult (maximal available) group if no one is suitable.

    IF MAXG_ IS NULL AND DEFG_ IS NOT NULL THEN
       MAXG_ := DEFG_;
    END IF;
--
--  We reach the ceil of group list. Return the "payed" mark

    IF MAXG_ = CIDC_ THEN

        RETURN '!!';
    END IF;

--  In case of trouble with dynamic groups...
    IF DEFG_ = CIDC_ THEN
       RETURN '!!';
    END IF;
--
    IF CIDC_ = 0 THEN
       CPRT_ := 0;
    ELSE
        BEGIN
           SELECT PRIORITY INTO CPRT_
             FROM CHKLIST_TTS
            WHERE TT=TT_
              AND IDCHK=CIDC_;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN RETURN '';
        END;
    END IF;

    NVIS_:='00';
    FOR c IN (SELECT IDCHK, SQLVAL FROM CHKLIST_TTS
               WHERE PRIORITY > CPRT_
                 AND TT = TT_
                 AND IDCHK <> CIDC_
               ORDER BY PRIORITY)
    LOOP
        IF c.IDCHK IS NOT NULL THEN
           IF chk.DOC_IS_VALID( c.SQLVAL) = 1 THEN
              NVIS_ := chk.TO_HEX(c.IDCHK);
              EXIT;
           END IF;
        END IF;
    END LOOP;

    IF NVIS_ = '00' THEN
        IF TT_ = 'ЧЕК' OR TT_ = G_CHECKTT0 OR TT_ = G_CHECKTT1 THEN
           NVIS_ := 'XX';
        ELSE
            IF DEFG_ IS NOT NULL THEN
               NVIS_ := chk.TO_HEX(DEFG_);
            END IF;
        END IF;
    END IF;

    RETURN SUBSTR('00' || NVIS_, -2);

END GetNextVisaGroup;
-- ----------------------------------------------------------------
-- Checks transaction acknowlegement by checker
-- ----------------------------------------------------------------
PROCEDURE doc_ack (ref_ IN  NUMBER,
                    tt_ IN  VARCHAR2,
                   chk_ IN  VARCHAR2,
                   ack_ OUT NUMBER ) IS

idchk_   NUMBER;
CVISA_   VARCHAR2(2);

BEGIN

   ack_ := 0;           -- No acknowleged

   CVISA_ := SUBSTR(RTRIM(chk_), -6, 2);
   IF GetNextVisaGroup( ref_, CVISA_) = '!!' THEN
      ack_ := 1;        -- Acknowleged
   END IF;

   RETURN;

END doc_ack;

-- ----------------------------------------------------------------
-- Puts Big_Ammount_Passed Stamp                                 --
-- ----------------------------------------------------------------
PROCEDURE put_big ( flg_  IN OUT  NUMBER,
                    ref_  NUMBER,
                     tt_  VARCHAR2,
                    kv1_  NUMBER,
                     s1_  NUMBER,
                    kv2_  NUMBER,
                     s2_  NUMBER )

IS

big_    NUMBER;
last_   NUMBER;
stmp_   VARCHAR2(6);

BEGIN
   IF flg_=1 THEN RETURN; END IF;  -- Return if Actual payment

   big_  := 0;
   last_ := 0;

   FOR r IN (SELECT idchk,priority,f_big_amount
               FROM chklist_tts
              WHERE tt = tt_ ORDER BY priority) LOOP
       IF big_ =0 AND r.f_big_amount=1 THEN
          big_ := r.idchk;
       END IF;
       last_ := r.idchk;
   END LOOP;

   IF big_>0 THEN
      IF gl.p_icurval(kv1_,s1_,gl.bDATE)<5000000 THEN  -- It's small amnt
         stmp_ := put_stmp(big_);
         UPDATE oper SET chk=stmp_ WHERE ref=ref_;

         IF big_=last_ THEN flg_ := 1; END IF;

      END IF;

   END IF;

END put_big;

-- ----------------------------------------------------------------
-- Puts Nostro_Account_Assigned_ Stamp                           --
-- ----------------------------------------------------------------
PROCEDURE put_nos (  ref_  NUMBER,
                     grp_  NUMBER )
IS

stmp_   VARCHAR2(6);

BEGIN
   stmp_ := put_stmp(grp_);
   UPDATE oper SET chk=RTRIM(NVL(chk,''))||stmp_ WHERE ref=ref_;
END put_nos;

PROCEDURE put_ack(ref_ NUMBER) AS
sum_   NUMBER;
ack_   NUMBER;
tt_    CHAR(3);
chk_   VARCHAR2(80);

pay_er EXCEPTION;
PRAGMA EXCEPTION_INIT(pay_er, -20203);

pos_   NUMBER;

msg_   VARCHAR2(100);

fli_   NUMBER;
flg_   NUMBER;
refL_  NUMBER;
refA_  VARCHAR2(9);
prty_  NUMBER;
sos_   NUMBER;

err_   NUMBER;    -- Return code
rec_   NUMBER;    -- Record number
mfoa_  VARCHAR2(12);   -- Sender's MFOs
nlsa_  VARCHAR2(15);   -- Sender's account number
mfob_  VARCHAR2(12);   -- Destination MFO
nlsb_  VARCHAR2(15);   -- Target account number
dk_    NUMBER;         -- Debet/Credit code
s_     DECIMAL(24);    -- Amount
vob_   NUMBER;         -- Document type
nd_    VARCHAR2(10);   -- Document number
kv_    NUMBER;         -- Currency code
datD_  DATE;           -- Document date
datP_  DATE;           -- Posting date
nam_a_  VARCHAR2(38);  -- Sender's customer name
nam_b_  VARCHAR2(38);  -- Target customer name
nazn_   VARCHAR(160);  -- Narrative
nazns_ CHAR(2);        -- Narrative contens type
id_a_  VARCHAR2(14);   -- Sender's customer identifier
id_b_  VARCHAR2(14);   -- Target's customer identifier
id_o_  VARCHAR2(6);    -- Teller identifier
sign_  OPER.SIGN%TYPE; -- Signature
datA_  DATE;           -- Input file date/time
d_rec_ VARCHAR2(80);   -- Additional parameters


PROCEDURE to_log (ref_ NUMBER, msg_ VARCHAR2) IS
      PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   INSERT INTO tmp_log (ref,msg) VALUES (ref_, msg_);
   COMMIT;
END;

BEGIN
   BEGIN
      SELECT o.tt,o.chk,o.refl
        INTO   tt_, chk_, refL_
        FROM oper o
       WHERE o.ref=ref_ AND o.sos>0 AND o.sos<5 AND o.vdat<=gl.bDATE
         FOR UPDATE OF sos NOWAIT;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN RETURN;
   END;

   -- читаем флаги из tts
   select fli, SUBSTR(flags,38,1) into fli_, flg_ from tts where tt=tt_;

   BEGIN
      SELECT SUM(DECODE(dk,0,-s,s)) INTO sum_
        FROM opldok
       WHERE ref = ref_ AND sos < 5 AND fdat <= gl.bDATE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN sum_ := NULL;
   END;

   IF sum_ = 0 THEN     -- Check if the document acknowleged

      chk.doc_ack ( ref_,tt_,chk_,ack_);

      IF ack_ = 1 THEN

         BEGIN  -- Clear document

            SAVEPOINT chk_pay_before;
            gl.pay ( 2, ref_, gl.bDATE);

            IF fli_=1 AND (flg_=0 OR flg_=1 OR flg_=3) THEN

               SELECT mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
                      datd, datp, nam_a, nam_b, nazn, id_a, id_b,
                      id_o, sign, d_rec, sos, ref_a, prty
                 INTO mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
                      datd_,datp_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
                      id_o_,sign_,d_rec_, sos_, refA_, prty_
                 FROM oper WHERE ref=ref_;

               IF sos_ = 5 THEN -- Value date arrived

                  IF LENGTH(TRIM(NVL(d_rec_,'')))>0 THEN
                     nazns_ := '11';
                  ELSE
                     nazns_ := '10';
                  END IF;

                 if g_sepnum<>2 then
                  nd_    := TRANSLATE(nd_,   sep.WIN_,sep.DOS_);
                  nam_a_ := TRANSLATE(nam_a_,sep.WIN_,sep.DOS_);
                  nam_b_ := TRANSLATE(nam_b_,sep.WIN_,sep.DOS_);
                  nazn_  := TRANSLATE(nazn_, sep.WIN_,sep.DOS_);
                  d_rec_ := TRANSLATE(d_rec_,sep.WIN_,sep.DOS_);
                 end if;
                 datA_  := TO_DATE (TO_CHAR(datP_,'MM-DD-YYYY')||' '||
                            TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');

                  err_ := -1;
                  rec_ :=  0;
                  sep.in_sep(err_,rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,
                         vob_,nd_,kv_,datD_,datP_,nam_a_,nam_b_,nazn_,
                          NULL,nazns_,id_a_,id_b_,id_o_,refA_,0,sign_,
                               NULL,NULL,datA_,d_rec_,0,ref_);

                  IF err_=0 THEN
                     msg_:= 'Оплачен. Передан в СЭП.';
                     IF prty_>0 THEN    -- Set SSP flag
                         UPDATE arc_rrp SET prty=prty_ WHERE rec=rec_;
                     END IF;
                  ELSE
                     ROLLBACK TO chk_pay_before;
                     msg_:= 'Невозможно передать в СЭП';
                  END IF;

               END IF;
            END IF;

         EXCEPTION
            WHEN OTHERS THEN ROLLBACK TO chk_pay_before;

            msg_ := SUBSTR(SQLERRM,13,100);
            pos_ := INSTR(msg_,CHR(10));

            IF pos_ > 0 THEN
               msg_ := SUBSTR(msg_,1,pos_-1);
            END IF;
         END;
      ELSE
         msg_:= 'Не завизирован';
      END IF;
   ELSE
      msg_:= 'Нет проводок для оплаты';
   END IF;

   to_log(ref_, msg_);
END put_ack;

-- ----------------------------------------------------------------
-- Put_Prty                                                      --
-- ----------------------------------------------------------------
PROCEDURE put_prty (p_ref number, p_prty number)
is
  l_ref    number;
  l_refl   number;
begin

  l_ref := p_ref;

  loop

     update oper set prty = p_prty where ref = l_ref;

     begin
        select refl into l_refl from oper where ref = l_ref;
     exception when no_data_found then
        l_refl := null;
     end;

     if l_refl is null then
        exit;
     end if;

     l_ref := l_refl;

  end loop;

end put_prty;

-- ----------------------------------------------------------------
-- Returns Hex Representation of number                          --
-- ----------------------------------------------------------------
FUNCTION TO_HEX(n_ NUMBER)
RETURN VARCHAR2 IS
hex_ VARCHAR2(10) := '';
i_   NUMBER;
BEGIN
   i_   := n_;
   WHILE i_ > 0 LOOP
      hex_ := SUBSTR('0123456789ABCDEF',MOD(i_,16)+1,1)||hex_;
      i_ := (i_-MOD(i_,16))/16;
   END LOOP;
RETURN hex_;
END;

-- ----------------------------------------------------------------
-- Returns Hex Representation of string                          --
-- ----------------------------------------------------------------
FUNCTION TO_HEX(x_ VARCHAR2)
RETURN VARCHAR2 IS
hex_ VARCHAR2(1024) := '';
i_   NUMBER;
j_   NUMBER := 1;
BEGIN
   IF x_ IS NOT NULL THEN
      FOR j_ IN 1..LENGTH(x_) LOOP
         i_   := ASCII(SUBSTR(x_,j_,1));
         hex_ := hex_||SUBSTR('0123456789ABCDEF',(i_-MOD(i_,16))/16+1,1)||
                       SUBSTR('0123456789ABCDEF',    MOD(i_,16)+1,1);
      END LOOP;
   END IF;
RETURN hex_;
END;

-- создает xml элемент в укаазаном документе и привязывает к родительскому элементу
function createelement(p_name in varchar2,
                       p_doc  in dbms_xmldom.domdocument)
  return dbms_xmldom.domelement is
  l_element dbms_xmldom.domelement;
begin
  l_element := dbms_xmldom.createelement(p_doc, p_name);
  return l_element;
end createelement;

function createelement(p_name           in varchar2,
                       p_doc            in dbms_xmldom.domdocument,
                       p_parent_element in dbms_xmldom.domelement)
  return dbms_xmldom.domelement is
  l_element dbms_xmldom.domelement;
  l_node    dbms_xmldom.domnode;
begin
  l_element := createelement(p_name, p_doc);
  l_node    := dbms_xmldom.appendchild(dbms_xmldom.makenode(p_parent_element),
                                       dbms_xmldom.makenode(l_element));
  return l_element;
end createelement;
-- устанавливает атрибут xml элемента
procedure setattribute(p_element in dbms_xmldom.domelement,
                       p_name    in varchar2,
                       p_value   in varchar2) is
begin
  dbms_xmldom.setattribute(p_element, p_name, p_value);
end setattribute;

-- ----------------------------------------------------------------
-- Puts current visa stamp, inserts oper_visa                    --
-- ----------------------------------------------------------------

-- 0/1 - возвращает 1 если включен режим виз с ЭЦП
-- (INTSIGN=2 and VISASIGN=1)
function mode_visa_sign return integer is
begin
  if F_VISASIGN=1 AND F_INTSIGN=2 then
    return 1;
  else
    return 0;
  end if;
end mode_visa_sign;

PROCEDURE put_visa_out (ref_ NUMBER, tt_ CHAR, grp_ NUMBER, status_ NUMBER,
                keyid_ VARCHAR2, sign1_ VARCHAR2,sign2_ VARCHAR2, sqnc_ out number) IS
hex_   VARCHAR2(6);
fch_   NUMBER;
l_otm     number := 0;
l_fmcheck number := 0;
respid_   SMALLINT;
refl_     NUMBER;
err       EXCEPTION;
ers       varchar2(30);

v_teller_flag number;
v_status      number := status_;

hasIntSign  binary_integer;
hasExtSign  binary_integer;
hasRespond  binary_integer;

BEGIN
   logger.trace('put_visa():start');
   logger.trace('put_visa():'
   ||'ref='||ref_||','
   ||'tt='||tt_||','
   ||'grp='||grp_||','
   ||'status='||status_||','
   ||'keyid='||keyid_||','
   ||'sign1='||sign1_||','
   ||'sign2='||sign2_);

   -- проверка Теллера
   declare
     v_errtxt varchar2(2000);
     v_num number;
   begin
     dbms_output.put_line('branch start put_visa_out ='|| sys_context('bars_context','user_branch') );
     begin
     execute immediate 'begin :1 := teller_tools.validate_visa(p_visa   => '||status_||',
                                                               p_docref => '||ref_||',
                                          p_errtxt => :2);
                              :3 := teller_tools.is_teller_doc('||ref_||');
                        exception
                          when others then
                            :1 := 0;
                        end;'
       using out v_num, out v_errtxt, out v_teller_flag;
     exception
       when others then
         null;
     end;
     if v_teller_flag = 1 then
       v_status := 2;
     end if;
/*     bars_audit.info('Teller_chk: ref = '||ref_||', visa = '||status_||', v_num = '||v_num||', v_teller_flag = '||v_teller_flag||', errtxt = '||v_errtxt);
     bars_audit.info('status_ = '||status_);
*/     if v_teller_flag = 1 and v_num = -1 then  -- нельзя визировать!
         bars_error.raise_nerror('TEL','TELL_DOC2',v_errtxt);
--       raise_application_error(-20100,v_errtxt);
     end if;
   end;

   dbms_output.put_line('branch before FM ='|| sys_context('bars_context','user_branch') );
   -- проверка ФМ

   -- status=0 - ввод
   if status_ = 0 then
      l_fmcheck := 1;
   -- status=1 - визирование
   elsif status_ = 1 then
      begin
         select fmcheck into l_fmcheck from ref_que where ref=ref_;
      exception when no_data_found then
         l_fmcheck := 0;
      end;
   -- status=2 - оплата (НЕ управление КС)
   elsif status_ = 2 and grp_ <> GetGlobalOption('SEPVISA') then
      -- fmchek - признак проверки ФМ
      -- gl.aRef is not null, если сначала оплата, потом виза.
      if gl.aRef is not null then
         -- gl.aFMcheck - fmcheck удаленной из ref_que записи после оплаты документа
         if ref_ = gl.aRef then
            l_fmcheck := gl.aFMcheck;
         else
            begin
               select r.fmcheck into l_fmcheck
                 from rec_que r, arc_rrp a
                where a.rec=r.rec and bis in (0,1) and a.ref=ref_;
            exception when no_data_found then
               l_fmcheck := 0;
            end;
         end if;
      -- gl.aRef is null, если сначала виза, потом оплата
      -- или манипуляции с исх.документом.
      else
         begin
            select fmcheck into l_fmcheck from ref_que where ref=ref_;
         exception when no_data_found then
            if gl.aFMcheck is not null then
               l_fmcheck := gl.aFMcheck;
            else
               begin
                  select r.fmcheck into l_fmcheck
                    from rec_que r, arc_rrp a
                   where a.rec=r.rec and bis in (0,1) and a.ref=ref_;
               exception when no_data_found then
                  l_fmcheck := 0;
               end;
            end if;
         end;
      end if;
   end if;

   -- проверки не было, проверяем
   if l_fmcheck = 0 then
      -- проверка документа
      p_fm_intdoccheck(ref_);
   end if;

   -- смотрим на код (otm)
   begin
      select otm into l_otm from fm_ref_que where ref=ref_;
   exception when no_data_found then l_otm := 0;
   end;

   if l_otm > 0 then
      -- 'ФИНАНСОВЫЙ МОНИТОРИНГ: оплата документа ' || :new.ref || ' приостановлена!';
      bars_error.raise_nerror('DOC', 'FM_STOPVISA', '$REF', to_char(ref_));
   end if;


   if mode_visa_sign=1 then

     visa_flag4sign(tt_,grp_,fch_);

     hasIntSign := bitand(fch_,DEF_INT_SIGN);
     hasExtSign := bitand(fch_,DEF_EXT_SIGN);

     logger.trace('put_visa():fch='||fch_);
     logger.trace('put_visa():bitand(fch_,DEF_INT_SIGN)='||hasIntSign);
     logger.trace('put_visa():bitand(fch_,DEF_EXT_SIGN)='||hasExtSign);
     -- всевозможные проверки
     IF keyid_ IS NOT NULL THEN
       IF hasIntSign<>0 and sign1_ is null THEN
          -- отсутствует внутренняя ЭЦП
          ers := 'INT_SIGN_EMPTY';
          raise err;
       ELSIF hasExtSign<>0 and sign2_ is null and status_<>3 THEN
          -- отсутствует внешняя ЭЦП(кроме случая сторнирования)
          ers := 'EXT_SIGN_EMPTY';
          raise err;
       END IF;
     END IF;
     IF grp_ IS NOT NULL and status_<>3 THEN -- для сторно(status=3) update oper.chk выполняет p_back_doc
       hex_:=put_stmp(grp_);
       UPDATE oper SET chk=RTRIM(NVL(chk,''))||hex_,
              respid=DECODE(bitand(fch_,DEF_CHARGED),0,respid,uid_)
       WHERE ref=ref_ RETURNING refl,respid INTO refl_,respid_;

       IF refl_ IS NOT NULL THEN  -- есть связанные документы
          UPDATE oper SET respid=respid_
           WHERE ref IN (SELECT ref FROM oper WHERE ref <> ref_
           START WITH ref=ref_ CONNECT BY PRIOR refl=ref);
       END IF;

     END IF;
     IF hasExtSign<>0 and status_<>3 THEN  -- обновляем внешнюю ЭЦП(исключение - сторно)
       UPDATE oper SET ref_a=MOD(ref_,1000000000),
              id_o=keyid_,sign=sign2_ WHERE ref=ref_;
     END IF;

     INSERT INTO oper_visa (ref, dat, userid, groupid, status, keyid, sign)
           VALUES (ref_,sysdate,uid_,   grp_,    status_,
      decode(hasIntSign,0,NULL,keyid_),
      decode(hasIntSign,0,NULL,sign1_)
     ) returning sqnc into sqnc_;
     if hasIntSign<>0 then
        update oper set signed='Y' where ref=ref_;
     end if;
   else
     IF grp_ IS NOT NULL and status_<>3 THEN -- для сторно(status=3) update oper.chk выполняет p_back_doc
      hex_:=put_stmp(grp_);
      UPDATE oper SET chk=RTRIM(NVL(chk,''))||hex_ WHERE ref=ref_;
     END IF;
     INSERT INTO oper_visa (ref, dat, userid, groupid, status)
           VALUES (ref_,sysdate,uid_,   grp_,    status_) returning sqnc into sqnc_;
   end if;
   --
   logger.trace('Наложена виза на док. ref='||ref_||', groupid='||grp_||', status='||status_);
   --
EXCEPTION WHEN err THEN
   bars_error.raise_nerror(MODCODE, ers);
END put_visa_out;

PROCEDURE put_visa (ref_ NUMBER, tt_ CHAR, grp_ NUMBER, status_ NUMBER,
                keyid_ VARCHAR2, sign1_ VARCHAR2,sign2_ VARCHAR2) IS
  l_sqnc oper_visa.sqnc%type;
  v_teller_flag number := -1;
  v_status      number;
BEGIN
   declare
     v_errtxt varchar2(2000);
     v_num number;
   begin
     dbms_output.put_line('branch start chk.put_visa ='|| sys_context('bars_context','user_branch') );
     execute immediate 'begin :1 := teller_tools.validate_visa(p_visa   => '||status_||',
                                                               p_docref => '||ref_||',
                                          p_errtxt => :2);
                              :3 := teller_tools.is_teller_doc('||ref_||');
                        exception
                          when others then
                            :1 := 0;
                        end;'
       using out v_num, out v_errtxt, out v_teller_flag;
     exception
       when others then
         null;
    end;

--bars_audit.info('v_teller_flag = '||v_teller_flag);
  if v_teller_flag = 1 then
    v_status := 2;
  else
    v_status := status_;
  end if;
  
  dbms_output.put_line('branch before chk.put_visa_out ='|| sys_context('bars_context','user_branch') );
  put_visa_out(ref_, tt_, grp_, v_status, keyid_, sign1_, sign2_, l_sqnc);
  dbms_output.put_line('branch after chk.put_visa_out ='|| sys_context('bars_context','user_branch') );
END put_visa;

-- Отримання буфферу для накладання внутрішної ЕЦП
procedure get_int_buffer_hex(p_ref        in oper_visa.ref%type,
                             p_lev        in number,
                             p_buffer_hex out varchar2) is
  l_buffer        varchar2(32676);
  l_keyid         sgn_data.key_id%type;
  l_sign_hex      varchar2(32676);
  l_sign_type     sgn_data.sign_type%type;
  l_sign_hex_clob sgn_data.sign_hex%type;
begin
  -- отримання буфферу документу
  chk.make_int_docbuf(p_ref, l_buffer);
  p_buffer_hex := chk.to_hex(l_buffer);

  -- остаточне формування буферу з попередніх ЕЦП
  for c in (select 0 as rwn, ov.keyid, ov.sign, sin.sign_id
              from oper_visa ov, sgn_int_store sin
             where ov.sqnc = sin.rec_id
               and ov.status = 0
               and ov.groupid is null
               and ov.ref = p_ref
            union all
            select rownum as rwn, keyid, sign, sign_id
              from (select ov.keyid, ov.sign, sin.sign_id
                      from oper_visa ov, sgn_int_store sin
                     where ov.sqnc = sin.rec_id
                       and ov.ref = p_ref
                       and nvl(ov.passive, 0) = 0
                       and ov.status <> 0
                       and ov.groupid is not null
                     order by ov.sqnc)
             where rownum <= p_lev) loop
    -- Нова схема збереження ЕЦП
    sgn_mgr.get_sign_data(p_id        => c.sign_id,
                          p_sign_type => l_sign_type,
                          p_key_id    => l_keyid,
                          p_sign_hex  => l_sign_hex_clob);
    l_sign_hex := dbms_lob.substr(l_sign_hex_clob);

    -- формуємо буффер для накладення наступної ЕЦП конкатенацією попередніх підписів
    p_buffer_hex := p_buffer_hex || chk.to_hex(l_keyid) || l_sign_hex;
  end loop;

  -- в залежності від поточної схеми формування буфферу повертаємо інформацію
  if (g_use_new_buffer_scheme = 1) then
    p_buffer_hex := chk.to_hex(l_buffer);
  end if;
end get_int_buffer_hex;

-- Отримання даних внутрішньої ЕЦП документу на відповідній візі
procedure get_int_ecp(p_ref          in oper_visa.ref%type,
                      p_lev          in number,
                      p_sign_type    out varchar2,
                      p_buffer_hex   out varchar2,
                      p_key_id       out varchar2,
                      p_sign_hex     out varchar2) is
  l_buffer        varchar2(32676);
  l_buffer_hex    varchar2(32676);
  l_sign_hex      varchar2(32676);
  l_key_id        sgn_data.key_id%type := null;
  l_sign_hex_clob sgn_data.sign_hex%type;
  l_sign_type     sgn_data.sign_type%type;

begin
  -- отримання буферу документу
  chk.make_int_docbuf(p_ref, l_buffer);
  l_buffer_hex := chk.to_hex(l_buffer);

  -- остаточне формування буферу з попередных ЕЦП
  for c in (select 0 as rwn, ov.keyid, ov.sign, sin.sign_id
              from oper_visa ov, sgn_int_store sin
             where ov.sqnc = sin.rec_id
               and ov.status = 0
               and ov.groupid is null
               and ov.ref = p_ref
            union all
            select rownum as rwn, keyid, sign, sign_id
              from (select ov.keyid, ov.sign, sin.sign_id
                      from oper_visa ov, sgn_int_store sin
                     where ov.sqnc = sin.rec_id
                       and ov.ref = p_ref
                       and nvl(ov.passive, 0) = 0
                       and ov.status <> 0
                       and ov.groupid is not null
                     order by ov.sqnc)
             where rownum <= p_lev) loop
    -- формуємо буфер для перевірки попереднього підпису
    if (l_key_id is not null and l_sign_hex is not null) then
      l_buffer_hex := l_buffer_hex || chk.to_hex(l_key_id) || l_sign_hex;
    end if;
    -- нова схема збереження ЕЦП
    sgn_mgr.get_sign_data(p_id        => c.sign_id,
                          p_sign_type => l_sign_type,
                          p_key_id     => l_key_id,
                          p_sign_hex  => l_sign_hex_clob);
    l_sign_hex := dbms_lob.substr(l_sign_hex_clob);
  end loop;

  -- в залежності від поточної схеми формування буферу повертаємо інформацію
  if (g_use_new_buffer_scheme = 1) then
    l_buffer_hex := chk.to_hex(l_buffer);
  end if;

  -- повертаємо останній підпис та ключ
  p_buffer_hex := l_buffer_hex;
  p_sign_type := l_sign_type;
  p_key_id    := l_key_id;
  p_sign_hex := l_sign_hex;

end get_int_ecp;

-- Отримання переліку накладених внутрішніх підписів
function get_int_ecps(p_ref in oper_visa.ref%type, p_lev in number)
  return tt_ecp_array is
  l_ecp_array tt_ecp_array;
begin
  -- почерзі обробляємо кожну візу
  for c in (select 0 as rwn, sin.sign_id
              from oper_visa ov, sgn_int_store sin
             where ov.sqnc = sin.rec_id
               and ov.status = 0
               and ov.groupid is null
               and ov.ref = p_ref
            union all
            select rownum as rwn, sign_id
              from (select sin.sign_id
                      from oper_visa ov, sgn_int_store sin
                     where ov.sqnc = sin.rec_id
                       and ov.ref = p_ref
                       and nvl(ov.passive, 0) = 0
                       and ov.status <> 0
                       and ov.groupid is not null
                     order by ov.sqnc)
             where rownum <= p_lev) loop
    declare
      l_ecp_obj tt_ecp_obj;
    begin
      -- послідовний номер візи
      l_ecp_obj.id := c.rwn;
      -- отримання парметрів ЕЦП на візі
      get_int_ecp(p_ref        => p_ref,
                  p_lev        => c.rwn,
                  p_sign_type  => l_ecp_obj.sign_type,
                  p_buffer_hex => l_ecp_obj.buffer_hex,
                  p_key_id     => l_ecp_obj.key_id,
                  p_sign_hex   => l_ecp_obj.sign_hex);

      l_ecp_array(c.rwn + 1) := l_ecp_obj;
    end;
  end loop;

  return l_ecp_array;
end get_int_ecps;

-- Отримання зовнішнього підпису (у вигляді об'єкту)
function get_ext_ecp_obj(p_ref in oper_visa.ref%type) return tt_ecp_obj is
  l_ecp_obj  tt_ecp_obj;
  l_sign_id  sgn_data.id%type;
  l_sign_hex sgn_data.sign_hex%type;
  l_buffer   varchar2(32676);
begin
  -- смотрим есть ли подпись сэп, берем ее
  begin
    select ses.sign_id
      into l_sign_id
      from oper o, sgn_ext_store ses
     where o.ref = ses.ref
       and o.ref = p_ref;
  exception
    when no_data_found then
      return null;
  end;
  sgn_mgr.get_sign_data(p_id        => l_sign_id,
                        p_sign_type => l_ecp_obj.sign_type,
                        p_key_id    => l_ecp_obj.key_id,
                        p_sign_hex  => l_sign_hex);
  l_ecp_obj.sign_hex := dbms_lob.substr(l_sign_hex);
  l_ecp_obj.id := 0;

  -- получаем буфер документа
  docsign.retrievesepbuffer(p_ref, l_ecp_obj.key_id, l_buffer);
  l_ecp_obj.buffer_hex := rawtohex(utl_raw.cast_to_raw(l_buffer));

  return l_ecp_obj;
end get_ext_ecp_obj;

-- Отримання зовнішнього підпису
procedure get_ext_ecp(p_ref        in oper_visa.ref%type,
                      p_sign_type  out varchar2,
                      p_buffer_hex out varchar2,
                      p_key_id     out varchar2,
                      p_sign_hex   out varchar2) is
  l_ecp_obj tt_ecp_obj;
begin
  -- параметри беремо з отриманого об'єкту
  l_ecp_obj    := get_ext_ecp_obj(p_ref);
  p_sign_type  := l_ecp_obj.sign_type;
  p_buffer_hex := l_ecp_obj.buffer_hex;
  p_key_id     := l_ecp_obj.key_id;
  p_sign_hex   := l_ecp_obj.sign_hex;
end get_ext_ecp;


PROCEDURE get_buf_aux(ref_ NUMBER, lev_ NUMBER, buf_ OUT VARCHAR2, sign_len OUT NUMBER)
IS
  i_  NUMBER := 0;
  keyid_  oper_visa.keyid%type;
  sign_   oper_visa.sign%type;
BEGIN
  buf_:=NULL;
  sign_len := 0;


  if mode_visa_sign=1 then

    IF lev_<0 THEN RETURN;
    END IF;
    begin
      select keyid,sign
        into keyid_,sign_
        from oper_visa
       where status=0
         and groupid is null
         and ref=ref_;
      buf_ := buf_ || chk.TO_HEX(keyid_)||sign_;
      sign_len := length(sign_)/2;
    exception when no_data_found then null;
    end;
    i_ := 1;
    FOR c IN (SELECT keyid, sign
                FROM oper_visa
               WHERE ref=ref_
                 AND NVL(passive,0)=0
                 AND status<>0
                 AND groupid is not null
               ORDER BY sqnc)
    LOOP
    IF i_ <= lev_ THEN
      buf_ := buf_ || chk.TO_HEX(c.keyid) || c.sign;
      sign_len := length(c.sign)/2;
    ELSE
      EXIT;
    END IF;
    i_ := i_+1;
    END LOOP;

  end if;


END get_buf_aux;

PROCEDURE get_buf(ref_ NUMBER,lev_ NUMBER, buf_ OUT VARCHAR2)
IS
  sign_len  number;
BEGIN
  get_buf_aux(ref_, lev_, buf_, sign_len);
END get_buf;


/*
 * visa_flag4check - возвращает флаг ЭЦП для документа ref_
 *                 на визе уровня lev_
 *                 для проверки ЭЦП
 * значения флага ЭЦП
 *         0 - отсутствует
 *         1 - внутр
 *         2 - СЭП
 *         3 - внутр + СЭП
 */
function visa_flag4check(ref_ number,lev_ number) return integer is
  err        exception;
  ers        varchar2(30);
  l_fsig     integer;
begin
  logger.trace('visa_flag4check: start');


  if mode_visa_sign=1 then
    logger.trace('ref='||ref_||',lev='||lev_);
    if lev_<0 then
      -- Уровень визы не может быть отрицательным.
      ers := 'LEVEL_NEGATIV';
    raise err;
    end if;
    begin
    -- ищем флаг для визы уровня 0 (если такой визы нету, возвращаем 0)
    if lev_=0 then
      begin
        select f_in_charge into l_fsig from oper_visa
        where ref=ref_ and nvl(passive,0)=0 and status=0 and groupid is null;
      exception when no_data_found then
        l_fsig := 0;
      end;
    else
      -- ищем флаг для виз уровня 1,2,...
      select f_in_charge into l_fsig from
      (select rownum rn, f_in_charge from
        (select f_in_charge from oper_visa where ref=ref_
        and nvl(passive,0)=0 and status<>0 and groupid is not null
        order by sqnc)
      ) where rn=lev_;
    end if;
    exception when no_data_found then
      -- Виза уровня LEV не найдена!
      ers := 'VISA_NOT_FOUND';
    raise err;
    end;
  else
    l_fsig := 0;
  end if;

  logger.trace('visa_flag4check: fsig='||l_fsig);
  return l_fsig;
exception when err then
  bars_error.raise_nerror(MODCODE, ers, '$LEV', to_char(lev_));
end;

procedure pvisa_flag4check(ref_ number,lev_ number, fsig_ out integer)
is
begin
  fsig_ := visa_flag4check(ref_,lev_);
end;


   ---------------------------------------------------------------------
   --  visa_flag4sign - вычислить флаг ЭЦП
   --
   --  Т.е. вычислить какая именно подпись должна быть на документе на текущий момент в цепочке визирования
   --
   --  данный флаг принимает значения:
   --  = 0 - отсутсвует,   т.е. поля oper.sign  =  null и oper_visa.sign = null
   --  = 1 - внутр,        т.е. поля oper.sign  =  null и oper_visa.sign <> null
   --  = 2 - СЕП,          т.е. поля oper.sign  <> null и oper_visa.sign = null
   --  = 3 - внутр + СЕП,  т.е. поля oper.sign  <> null и oper_visa.sign <> null
   --
   --  Если група контроля передана пустая, флаг берется на операции в поле flags во второй позиции
   --  Если передана группа контроля (из цепочки), тогда флаг вычисляется из составля
   ---------------------------------------------------------------------

  procedure visa_flag4sign(tt_ varchar2, grp_ number, fsig_ out integer) is
     fres_ SMALLINT :=0;
  begin
  logger.trace('visa_flag4sign: start ');

  if mode_visa_sign=1 then
    logger.trace('tt='||tt_||',grp='||grp_);
        -- пустая группа означает просто вставку документа в oper_visa
    if grp_ is null then
      select to_number(substr(flags,2,1)) into fsig_ from tts where tt=tt_;
    else
      begin
              select bitand(f_in_charge,3),
                     NVL(bitand(flags,1),0)
                into fsig_,fres_
                from chklist_tts
               where tt = tt_
                 and idchk = grp_;
      exception when no_data_found then
        fsig_ := null;
      end;
      if fsig_ is null then
        select f_in_charge into fsig_ from chklist where idchk=grp_;
      end if;
    end if;
        fsig_ := bitand(fsig_,3) + fres_ * 4;
  else
    fsig_ := 0;
  end if;
  logger.trace('fsig='||fsig_);
  exception when others then
  logger.error('visa_flag4sign():'||SQLERRM);
  raise;
  end;

/*
 * lock_doc - процедура блокировки записи документа для визирования
 *           и выдачи флагов оплаты и ЭЦП
 * ref_    - [in] референс документа
 * grp_    - [in] код группы визирования
 * fpay_   - [out] флаг(0/1) требования оплаты после визирования(признак последней визы)
 * fsig_   - [out] флаг ЭЦП на визе
 *         0 - отсутствует
 *         1 - внутр
 *         2 - СЭП
 *         3 - внутр + СЭП
 */
PROCEDURE lock_doc(ref_ NUMBER,grp_ NUMBER,
                 fpay_ OUT NUMBER, fsig_ OUT NUMBER) IS
hex_   VARCHAR2(2);

tt_    VARCHAR2(3);
tmp_   VARCHAR2(2);
curr_  VARCHAR2(2);
prev_  VARCHAR2(2);
onext_ VARCHAR2(2);
nnext_ VARCHAR2(2);

err     EXCEPTION;
ers     varchar2(30);

l_ref           oper.ref%type;
l_sos           oper.sos%type;
l_nextvisagrp   oper.nextvisagrp%type;

BEGIN
   logger.trace('chk.lock_doc(ref=>'||ref_||',grp=>'||grp_||')');
   hex_:=LPAD(NVL(TO_HEX(grp_),0),2,'0');

-- Lock current document

   BEGIN
      SELECT tt,currvisagrp,nextvisagrp,substr(chk.GetNextVisaGroup(ref,nextvisagrp),1,2)
        INTO tt_,curr_,onext_,nnext_ FROM oper
       WHERE ref=ref_ AND ref IN (SELECT ref FROM ref_que)
         AND sos BETWEEN 0 AND 3 AND nextvisagrp = hex_
         FOR UPDATE OF chk NOWAIT;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
        begin
          select sos, nextvisagrp into l_sos, l_nextvisagrp from oper
          where ref=ref_;
          if not (l_sos between 0 and 3) then
            -- Невозможно заблокировать документ REF=%s на визе № %s: Неверное значение поля SOS=%s
            ers := 'INCORRECT_SOS';
          elsif l_nextvisagrp<>hex_ then
            -- Невозможно заблокировать документ REF=%s на визе № %s: Неверное значение поля NEXTVISAGRP=%s
            ers := 'INCORRECT_NEXTVISAGRP';
          else
            begin
              select ref into l_ref from ref_que where ref=ref_;
            exception when no_data_found then
              -- Невозможно заблокировать документ REF=%s на визе № %s: Документ не найден в очереди визирования REF_QUE!
              ers := 'DOC_NOT_FOUND_REFQUE';
            end;
          end if;
        exception when no_data_found then
          -- Невозможно заблокировать документ REF=%s на визе № %s: Документ не найден вообще!
          ers := 'DOC_NOT_FOUND_GENERAL';
        end;
        bars_error.raise_nerror(MODCODE, ers, '$REF', to_char(ref_), '$VISA', to_char(grp_), '$SOS', to_char(l_sos), '$NEXTVISAGRP', l_nextvisagrp);
      WHEN OTHERS THEN
        -- Невозможно заблокировать документ REF=%s на визе № %s
        ers := 'ERR_BLOCK_DOC';
        bars_audit.error(p_msg => MODCODE||' chk.lock_doc(): ref='||to_char(ref_)||', visagrp='||to_char(grp_)||
                         '# error:'||dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
        if SQLCODE=-54 then

          -- 'Невозможно заблокировать документ REF=%s на визе № %s: Документ заблокирован другим пользователем'
          ers := 'DOC_IS_BLOCKED';
        end if;
        bars_error.raise_nerror(MODCODE, ers, '$REF', to_char(ref_), '$VISA', to_char(grp_));
   END;

   logger.trace('chk.lock_doc(): currvisagrp='||curr_||',nextvisagrp='||onext_||',nnext='||nnext_);

-- Whether it needs paying
/* MIK  убрал излишества
   tmp_  := '  ';
   prev_ := NULL;

   WHILE NOT(tmp_ =  hex_ OR tmp_ = '!!') LOOP
      prev_ := TRIM(tmp_);
      tmp_  := SUBSTR(chk.GetNextVisaGroup( ref_, prev_), 1, 2) ;
   END LOOP;

   IF (curr_ = prev_ OR curr_ is null and prev_ is null) AND onext_ = hex_  AND nnext_ = '!!' THEN
      fpay_:=1;
   ELSE
      fpay_:=0;
   END IF;
*/
   fpay_:=CASE WHEN onext_ = hex_  AND nnext_ = '!!' THEN 1 ELSE 0 END;

   logger.trace('chk.lock_doc(): fpay='||fpay_);
-- Whether it needs signing
   visa_flag4sign(tt_,grp_,fsig_);

EXCEPTION
   WHEN NO_DATA_FOUND THEN
   bars_error.raise_nerror(MODCODE, 'UNHANDLED_NO_DATA_FOUND', '$PROC', 'lock_doc');
END lock_doc;

-- возвращает буфер документа для внутр. ЭЦП
procedure make_int_docbuf(pref in number, buf out varchar2) is
  err  EXCEPTION;
  ers  varchar2(30);
  doc_buf  varchar2(1024);
begin
  begin
 if gl.amfo='300465' then
    select nvl(rpad(nd,10),rpad(' ',10))||nvl(to_char(datd,'YYMMDD'),rpad(' ',6))
    ||nvl(lpad(to_char(dk),1),' ')
    ||nvl(lpad(mfoa,9),rpad(' ',9))||nvl(lpad(nlsa,14),rpad(' ',14))
    ||nvl(lpad(to_char(kv),3),rpad(' ',3))||nvl(lpad(to_char(s),16),rpad(' ',16))
    ||nvl(lpad(mfob,9),rpad(' ',9))||nvl(lpad(nlsb,14),rpad(' ',14))
    ||nvl(lpad(to_char(kv2),3),rpad(' ',3))||nvl(lpad(to_char(s2),16),rpad(' ',16))
    into doc_buf
    from oper where ref=pref;
  else
    select nvl(rpad(nd,10),rpad(' ',10))||nvl(to_char(datd,'YYMMDD'),rpad(' ',6))
    ||nvl(lpad(to_char(dk),1),' ')
    ||nvl(lpad(mfoa,9),rpad(' ',9))||nvl(lpad(nlsa,14),rpad(' ',14))
    ||nvl(lpad(to_char(kv),3),rpad(' ',3))||nvl(lpad(to_char(s),16),rpad(' ',16))
    ||nvl(rpad(nam_a,38),rpad(' ',38))||lpad(nvl(id_a,' '), 14)
    ||nvl(lpad(mfob,9),rpad(' ',9))||nvl(lpad(nlsb,14),rpad(' ',14))
    ||nvl(lpad(to_char(kv2),3),rpad(' ',3))||nvl(lpad(to_char(s2),16),rpad(' ',16))
    ||nvl(rpad(nam_b,38),rpad(' ',38))||lpad(nvl(id_b,' '), 14)
    ||nvl(rpad(nazn,160),rpad(' ',160))
    into doc_buf
    from oper where ref=pref;
  end if;
    buf := doc_buf;
  exception when no_data_found then
    -- Документ не найден. REF=%s
    ers := 'DOC_NOT_FOUND';
    raise err;
  end;
exception when err then
  bars_error.raise_nerror(MODCODE, ers, '$REF', to_char(pref));
end;

-- возвращает буфер документа для внутр. ЭЦП и его размер
procedure make_int_docbuf2(pref in number, buf out varchar2, buf_len out number) is
begin
  make_int_docbuf(pref, buf);
  if buf is null then
    buf_len := 0;
  else
    buf_len := length(buf);
  end if;
end;

/**
 * Получение параметров визы документа без блокировки
 * ref_    - [in] референс документа
 * grp_    - [in] код группы визирования
 * fpay_   - [out] флаг(0/1) требования оплаты после визирования(признак последней визы)
 * fsig_   - [out] флаг ЭЦП на визе
 *         0 - отсутствует
 *         1 - внутр
 *         2 - СЭП
 *         3 - внутр + СЭП
 */
PROCEDURE get_visa_params(ref_ NUMBER,grp_ NUMBER, fpay_ OUT NUMBER, fsig_ OUT NUMBER) IS

hex_   VARCHAR2(2);

tt_    VARCHAR2(3);
tmp_   VARCHAR2(2);
curr_  VARCHAR2(2);
prev_  VARCHAR2(2);
onext_ VARCHAR2(2);
nnext_ VARCHAR2(2);

ers     varchar2(30);
err     EXCEPTION;

ERR_VISA_EXCEPTION EXCEPTION;
PRAGMA EXCEPTION_INIT(ERR_VISA_EXCEPTION, -20722);

BEGIN
   logger.trace('chk.get_visa_params(ref=>'||ref_||',grp=>'||grp_||')');
   hex_:=LPAD(NVL(TO_HEX(grp_),0),2,'0');
   BEGIN
      SELECT tt,currvisagrp,nextvisagrp,substr(chk.GetNextVisaGroup(ref,nextvisagrp),1,2)
        INTO tt_,curr_,onext_,nnext_ FROM oper
       WHERE ref=ref_ AND ref IN (SELECT ref FROM ref_que)
         AND sos BETWEEN 0 AND 3 AND nextvisagrp = hex_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
       -- Ошибка получения параметров документа REF=%s на визе № %s
       ers := 'ERR_GET_PARAMS';
       -- bars_error.raise_nerror(MODCODE, ers, '$REF', to_char(ref_), '$VISA', to_char(grp_));
       raise_application_error(-20722, 'Помилка отримання параметрів документа REF='||to_char(ref_)||' на візі № '||to_char(grp_), true);
   END;

-- Whether it needs paying
/* MIK убрал излишества
   tmp_  := '  ';
   prev_ := NULL;

   WHILE NOT(tmp_ =  hex_ OR tmp_ = '!!') LOOP
      prev_ := TRIM(tmp_);
      tmp_  := SUBSTR(chk.GetNextVisaGroup( ref_, prev_), 1, 2) ;
   END LOOP;

   IF (curr_ = prev_ OR curr_ is null and prev_ is null) AND onext_ = hex_  AND nnext_ = '!!' THEN
      fpay_:=1;
   ELSE
      fpay_:=0;
   END IF;
*/
   fpay_:=CASE WHEN onext_ = hex_  AND nnext_ = '!!' THEN 1 ELSE 0 END;

   logger.trace('chk.get_visa_params(): fpay='||fpay_);

   visa_flag4sign(tt_,grp_,fsig_);

END get_visa_params;


/**
 * make_data4visa
 * процедура возвращает буфера для ЭЦП и прочую информацию по заданному списку  референсов
 * с блокировкой ==> выполнять в транзакции
 * @param p_refs in - список референсов
 * @param p_grp in - код группы визирования
 * @param p_key in - отладочный ключ, если NULL - берем из БД
 * @param p_visa_array out массив данных для наложения виз на перечень документов
 */
procedure make_data4visa(p_refs in tt_num_array, p_grp in integer,
  p_key in varchar2, p_visa_array out tt_visa_array) is

ERR_VISA_EXCEPTION EXCEPTION;
PRAGMA EXCEPTION_INIT(ERR_VISA_EXCEPTION, -20722);

  l_ref       number;
  l_uid       number;
  l_self_grp_hex  varchar2(16);
  visa_obj      tt_visa_obj;
  l_key       varchar2(32);
  f_pay       integer;
  f_sign      integer;
  sep_buf     varchar2(444);
  int_buf     varchar2(1024);
  int_suffix    varchar2(32767);
  sign_bufs     tt_str_array;
begin
  l_self_grp_hex := chk.to_hex(self_grp_);
  for i in p_refs.first..p_refs.last loop

    visa_obj.ref := p_refs(i);
    visa_obj.err := 0;
    visa_obj.erm := null;
    visa_obj.grp := p_grp;

    visa_obj.f_pay := null;
    visa_obj.f_sign := null;
    visa_obj.f_check := null;

    select userid into l_uid from oper where ref=p_refs(i);
    if p_grp=self_grp_ then
      if l_uid<>uid_ then
        visa_obj.err := 1;
        visa_obj.erm := '1 - Запрещено визировать чужие документы на самовизе.';
      end if;
    else
      if l_uid=uid_ then
         declare
           l_staff staff$base%rowtype;
         begin
           select * into l_staff from staff$base s where s.id = uid_;

           visa_obj.err := 2;
           visa_obj.erm := '2 - Документ не может быть визирован пользователем ' || l_staff.logname;
         end;
      end if;
    end if;
    if visa_obj.err=0 then
      if p_key is not null then
        l_key := p_key;
      else
        l_key := Docsign.getIdOper;
      end if;
      -- получаем параметры визы документа
      begin
        get_visa_params(p_refs(i), p_grp, f_pay, f_sign);
        visa_obj.f_pay  := f_pay;
        visa_obj.f_sign := f_sign;
        if bitand(f_sign,chk.DEF_INT_SIGN)<>0 then
          chk.make_int_docbuf(p_refs(i), int_buf);
          chk.get_buf(p_refs(i),99,int_suffix);
          sign_bufs(1):=rawtohex(utl_raw.cast_to_raw(int_buf))||int_suffix;
        else
          sign_bufs(1):=null;
        end if;
        if bitand(f_sign,chk.DEF_EXT_SIGN)<>0 then
          Docsign.RetrieveSEPBuffer(p_refs(i), l_key, sep_buf);
          sign_bufs(2):=rawtohex(utl_raw.cast_to_raw(sep_buf));
        else
          sign_bufs(2):=null;
        end if;
        visa_obj.sign_bufs := sign_bufs;
      exception when ERR_VISA_EXCEPTION then
        visa_obj.err := 3;
        visa_obj.erm := '3 - Состояние документа было изменено и он не может быть визирован, обновите данные';
      end;

      -- Смотрим нужнали проверка ЭЦП
      declare
        l_tmp_buf varchar2(32767);
        l_tmp_buflng number;
      begin
        visa_obj.f_check := 0;

        if(visa_obj.f_sign = 1) then
            chk.get_buf(p_refs(i), 99, l_tmp_buf);
            select decode(l_tmp_buf, null, 0, length(l_tmp_buf)) into l_tmp_buflng from dual;

            if(l_tmp_buflng > 0) then
                visa_obj.f_check := 1;
            end if;
        end if;
      end;

    end if;
    p_visa_array(i) := visa_obj;
  end loop;
end;

/**
 * Разширение make_data4visa для работы с новой криптографией
 */
procedure make_data4visa_ext(p_refs       in tt_num_array,
                             p_grp        in integer,
                             p_key        in varchar2,
                             p_key_hash   in varchar2,
                             p_sign_type  in varchar2,
                             p_visa_array out tt_visa_array_ext) is

  err_visa_exception exception;
  pragma exception_init(err_visa_exception, -20722);

  l_uid    number;
  visa_obj tt_visa_obj_ext;
  l_key    varchar2(32);
  f_pay    integer;
  f_sign   integer;
  sep_buf  varchar2(444);
begin
  for i in p_refs.first .. p_refs.last loop
    visa_obj.ref := p_refs(i);
    visa_obj.err := 0;
    visa_obj.erm := null;
    visa_obj.grp := p_grp;

    visa_obj.f_pay   := null;
    visa_obj.f_sign  := null;
    visa_obj.f_check := null;

    -- проверка может ли пользователь накладывать визу на этот документ
    select userid into l_uid from oper where ref = p_refs(i);
    if p_grp = self_grp_ then
      if l_uid <> uid_ then
        visa_obj.err := 1;
        visa_obj.erm := '1 - Запрещено визировать чужие документы на самовизе.';
      end if;
    else
      if l_uid = uid_ then
        declare
          l_staff staff$base%rowtype;
        begin
          select * into l_staff from staff$base s where s.id = uid_;

          visa_obj.err := 2;
          visa_obj.erm := '2 - Документ не може бути завізовано\повернуто користувачем (' ||
                          l_staff.logname || '), який створив документ.';
        end;
      end if;
    end if;

    -- если нет ошибки то продолжаем
    if visa_obj.err = 0 then
      -- получаем параметры визы документа
      begin
        get_visa_params(p_refs(i), p_grp, f_pay, f_sign);
        visa_obj.f_pay  := f_pay;
        visa_obj.f_sign := f_sign;
        visa_obj.f_check := 0;

        -- внутреняя подпись
        if bitand(f_sign, chk.def_int_sign) <> 0 then
          chk.get_int_buffer_hex(p_refs(i), 99, visa_obj.int_buffer_hex);
          visa_obj.int_ecp := get_int_ecps(p_refs(i), 99);
          if(visa_obj.int_ecp is not null) then
              visa_obj.f_check := 1;
          end if;
        else
          declare
            l_ecp_array tt_ecp_array;
          begin
            visa_obj.int_buffer_hex := null;
            visa_obj.int_ecp        := l_ecp_array;
          end;
        end if;
        -- внешняя подпись
        if bitand(f_sign, chk.def_ext_sign) <> 0 then
          docsign.retrievesepbuffer(p_refs(i), p_key, sep_buf);
          visa_obj.ext_buffer_hex := rawtohex(utl_raw.cast_to_raw(sep_buf));
          visa_obj.ext_ecp        := get_ext_ecp_obj(p_refs(i));
          if(visa_obj.ext_ecp.id is not null) then
            if (visa_obj.f_check = 0) then
                 visa_obj.f_check := 2;
            else
               visa_obj.f_check := 3;
            end if;
          end if;
        else
          visa_obj.ext_buffer_hex := null;
          visa_obj.ext_ecp        := null;
        end if;

      exception
        when err_visa_exception then
          visa_obj.err := 3;
          visa_obj.erm := '3 - Состояние документа было изменено и он не может быть визирован, обновите данные';
      end;

      -- Смотрим нужнали проверка ЭЦП
      /*if (visa_obj.int_buffer_hex is not null ) then
        visa_obj.f_check := 1;
      else
        visa_obj.f_check := 0;
      end if;*/
    end if;
    p_visa_array(i) := visa_obj;
  end loop;
end;

/**
 * Аналогичная к make_data4visa
 * только параметры в xml
 */
  procedure make_data4visa_xml(inDataClob in CLOB, outDataXml out CLOB) is
    l_proc_name varchar2(100) := 'make_data4visa_xml. ';

    l_xmlParser      dbms_xmlparser.Parser;
    l_xmlDoc         dbms_xmldom.DOMDocument;
    l_xmlNode        dbms_xmldom.DOMNode;
    l_xmlRootElement dbms_xmldom.DOMElement;
    l_xmlDocNodes    dbms_xmldom.DOMNodeList;
    l_xmlDocNode     dbms_xmldom.DOMNode;
    l_xmlDocElement  dbms_xmldom.DOMElement;
    l_xmlBufsNode    dbms_xmldom.DOMNode;
    l_xmlBufsElement dbms_xmldom.DOMElement;

    l_refs     tt_num_array;
    l_grp      number;
    l_key      varchar2(400);
    l_visadata tt_visa_array;
  begin
    /* Структура входящего XML inDataClob:
    <?xml version="1.0" encoding="utf-8" ?>
    <docs4visa grpid="grpId" key="key">
      <doc ref="ref" />
    </docs4visa>
    */

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: inDataClob=%s',
                     dbms_lob.substr(inDataClob, 3000, 1));

    -- парсим XML через DOM
    l_xmlParser := dbms_xmlparser.newParser;
    begin
      -- загружаем xml из clob
      dbms_xmlparser.parseClob(l_xmlParser, inDataClob);
      l_xmlDoc := dbms_xmlparser.getDocument(l_xmlParser);

      -- берем рут єлемент и читаем параметры l_grp и l_key
      l_xmlRootElement := dbms_xmldom.getDocumentElement(l_xmlDoc);
      l_grp            := to_number(dbms_xmldom.getAttribute(l_xmlRootElement,
                                                             'grpid'));
      l_key            := nvl(dbms_xmldom.getAttribute(l_xmlRootElement,
                                                       'key'),
                              Docsign.getIdOper);
      -- на случай если работает схема с 8-значным tabn из staff
      if length(l_key) = 8 then
         l_key := substr(l_key,3);
      end if;
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. l_grp=%s, l_key=%s',
                       l_grp,
                       l_key);

      -- перебираем все документы
      l_xmlDocNodes := dbms_xmldom.getElementsByTagName(l_xmlDoc, 'doc');
      for i in 0 .. dbms_xmldom.getLength(l_xmlDocNodes) - 1 loop
        l_xmlDocNode    := dbms_xmldom.item(l_xmlDocNodes, i);
        l_xmlDocElement := dbms_xmldom.makeElement(l_xmlDocNode);

        -- референс
        l_refs(i) := to_number(dbms_xmldom.getAttribute(l_xmlDocElement,
                                                        'ref'));
        bars_audit.trace(g_pack_name || l_proc_name ||
                         'Process. i=%s, l_refs(i)=%s',
                         i,
                         l_refs(i));
      end loop;

      -- отчищаем память от парсера и документа
      dbms_xmlparser.freeParser(l_xmlParser);
      dbms_xmldom.freeDocument(l_xmlDoc);
    exception
      when others then
        -- отчищаем память от парсера и документа
        dbms_xmlparser.freeParser(l_xmlParser);
        dbms_xmldom.freeDocument(l_xmlDoc);

        -- бросаем ошибку дальше
        raise_application_error(-20000,
                                substr(sqlerrm || chr(10) ||
                                       dbms_utility.format_call_stack(),
                                       0,
                                       4000),
                                true);
    end;

    -- формируем данные для визирования
    make_data4visa(l_refs, l_grp, l_key, l_visadata);
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Process. make_data4visa done');

    -- формируем ответ
    -- !!!! <?xml version="1.0" encoding="windows-1251" ?>
    l_xmlDoc         := dbms_xmldom.newDOMDocument;
    l_xmlRootElement := dbms_xmldom.createElement(l_xmlDoc, 'docs4visa');
    l_xmlNode        := dbms_xmldom.appendChild(dbms_xmldom.makeNode(l_xmlDoc),
                                                dbms_xmldom.makeNode(l_xmlRootElement));

    for i in l_visadata.first .. l_visadata.last loop
      -- элемент документа
      l_xmlDocElement := dbms_xmldom.createElement(l_xmlDoc, 'doc');
      l_xmlNode       := dbms_xmldom.appendChild(dbms_xmldom.makeNode(l_xmlRootElement),
                                                 dbms_xmldom.makeNode(l_xmlDocElement));

      dbms_xmldom.setAttribute(l_xmlDocElement, 'ref', l_visadata(i).ref);
      dbms_xmldom.setAttribute(l_xmlDocElement, 'err', l_visadata(i).err);
      dbms_xmldom.setAttribute(l_xmlDocElement, 'erm', l_visadata(i).erm);
      bars_audit.trace(g_pack_name || l_proc_name || 'Process. i=' || i ||
                       ', ref=' || l_visadata(i).ref || ', err=' || l_visadata(i).err ||
                       ', erm=' || l_visadata(i).erm);

      if (l_visadata(i).err = 0) then
        dbms_xmldom.setAttribute(l_xmlDocElement, 'grp', l_visadata(i).grp);
        dbms_xmldom.setAttribute(l_xmlDocElement,
                                 'f_pay',
                                 l_visadata(i).f_pay);
        dbms_xmldom.setAttribute(l_xmlDocElement,
                                 'f_sign',
                                 l_visadata(i).f_sign);
        dbms_xmldom.setAttribute(l_xmlDocElement,
                                 'f_check',
                                 l_visadata(i).f_check);

        -- буффера для подписи
        l_xmlBufsElement := dbms_xmldom.createElement(l_xmlDoc, 'bufs');
        l_xmlNode        := dbms_xmldom.appendChild(dbms_xmldom.makeNode(l_xmlDocElement),
                                                    dbms_xmldom.makeNode(l_xmlBufsElement));

        dbms_xmldom.setAttribute(l_xmlBufsElement,
                                 'inner_buf',
                                 l_visadata(i).sign_bufs(1));
        dbms_xmldom.setAttribute(l_xmlBufsElement,
                                 'outer_buf',
                                 l_visadata(i).sign_bufs(2));
      end if;
    end loop;

    /* Структура исходящего XML outDataXml:
    <docs4visa>
      <doc ref="ref" err="1" erm="ффффф" />
      <doc ref="ref" err="0" erm="..." grp="grp" f_pay="f_pay" f_sign="f_sign" f_check="f_check">
        <bufs inner_buf="inSign" outer_buf="outSign" />
      </doc>
    </docs4visa>
    */

    -- конвертируем xml в clob и возвращаем его
    dbms_lob.createtemporary(outDataXml, true);
    dbms_xmldom.writeToClob(l_xmlDoc, outDataXml);
    dbms_xmldom.freeDocument(l_xmlDoc);

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish. outDataXml=%s',
                     dbms_lob.substr(outDataXml, 3000, 1));
  end make_data4visa_xml;

/**
 * Разширение make_data4visa_xml для работы с новой криптографией
 */
procedure make_data4visa_ext_xml(indataclob in clob, outdataxml out clob) is
  l_proc_name varchar2(100) := 'make_data4visa_ext_xml. ';

  l_xmlparser      dbms_xmlparser.parser;
  l_xmldoc         dbms_xmldom.domdocument;
  l_xmlnode        dbms_xmldom.domnode;
  l_xmlrootelement dbms_xmldom.domelement;
  l_xmldocnodes    dbms_xmldom.domnodelist;
  l_xmldocnode     dbms_xmldom.domnode;
  l_xmldocelement  dbms_xmldom.domelement;
  l_xmlintecpelement dbms_xmldom.domelement;
  l_xmlextecpelement dbms_xmldom.domelement;
  l_xmlecpelement    dbms_xmldom.domelement;

  l_refs tt_num_array;
  l_grp  number;

  l_sign_type varchar2(3);
  l_key_id     varchar2(2048);
  l_key_hash   varchar2(2048);

  l_visadata tt_visa_array_ext;
begin
  /* Структура входящего XML inDataClob:
  <?xml version="1.0" encoding="utf-8" ?>
  <docs4visa grpid="grpId" key="key" key_hash="key_hash" sign_type="VEG">
    <doc ref="ref" />
  </docs4visa>
  */
  bars_audit.trace(g_pack_name || l_proc_name ||
                   'Start. Params: inDataClob=%s',
                   dbms_lob.substr(indataclob, 3000, 1));

  -- парсим XML через DOM
  l_xmlparser := dbms_xmlparser.newparser;
  begin
    -- загружаем xml из clob
    dbms_xmlparser.parseclob(l_xmlparser, indataclob);
    l_xmldoc := dbms_xmlparser.getdocument(l_xmlparser);

    -- берем рут єлемент и читаем параметры
    l_xmlrootelement := dbms_xmldom.getdocumentelement(l_xmldoc);
    l_grp            := to_number(dbms_xmldom.getattribute(l_xmlrootelement, 'grpid'));
    l_sign_type      := dbms_xmldom.getattribute(l_xmlrootelement, 'sign_type');
    l_key_id         := dbms_xmldom.getattribute(l_xmlrootelement, 'key');
    l_key_hash       := dbms_xmldom.getattribute(l_xmlrootelement, 'key_hash');

    /*
    TODO: owner="andriy.sukhov" category="Review" priority="2 - Medium" created="17.08.2016"
    text="Корректно отработать ключи VEGA2"
    */
    -- на случай если работает схема с 8-значным tabn из staff
    if (length(l_key_id) = 8) then
      l_key_id := substr(l_key_id, 3);
    end if;

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Process. l_grp=%s, l_key_id=%s',
                     l_grp,
                     l_key_id);

    -- перебираем все документы
    l_xmldocnodes := dbms_xmldom.getelementsbytagname(l_xmldoc, 'doc');
    for i in 0 .. dbms_xmldom.getlength(l_xmldocnodes) - 1 loop
      l_xmldocnode    := dbms_xmldom.item(l_xmldocnodes, i);
      l_xmldocelement := dbms_xmldom.makeelement(l_xmldocnode);

      -- референс
      l_refs(i) := to_number(dbms_xmldom.getattribute(l_xmldocelement,
                                                      'ref'));
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. i=%s, l_refs(i)=%s',
                       i,
                       l_refs(i));
    end loop;

    -- отчищаем память от парсера и документа
    dbms_xmlparser.freeparser(l_xmlparser);
    dbms_xmldom.freedocument(l_xmldoc);
  exception
    when others then
      -- отчищаем память от парсера и документа
      dbms_xmlparser.freeparser(l_xmlparser);
      dbms_xmldom.freedocument(l_xmldoc);

      -- бросаем ошибку дальше
      raise_application_error(-20000,
                              substr(sqlerrm || chr(10) ||
                                     dbms_utility.format_call_stack(),
                                     0,
                                     4000),
                              true);
  end;

  -- формируем данные для визирования
  make_data4visa_ext(l_refs, l_grp, l_key_id, l_key_hash, l_sign_type, l_visadata);
  bars_audit.trace(g_pack_name || l_proc_name ||
                   'Process. make_data4visa done');

  -- формируем ответ
  -- !!!! <?xml version="1.0" encoding="windows-1251" ?>
  l_xmldoc         := dbms_xmldom.newdomdocument;
  l_xmlrootelement := dbms_xmldom.createelement(l_xmldoc, 'docs4visa');
  l_xmlnode        := dbms_xmldom.appendchild(dbms_xmldom.makenode(l_xmldoc),
                                              dbms_xmldom.makenode(l_xmlrootelement));

  for i in l_visadata.first .. l_visadata.last loop
    -- элемент документа
    l_xmldocelement := dbms_xmldom.createelement(l_xmldoc, 'doc');
    l_xmlnode       := dbms_xmldom.appendchild(dbms_xmldom.makenode(l_xmlrootelement),
                                               dbms_xmldom.makenode(l_xmldocelement));

    dbms_xmldom.setattribute(l_xmldocelement, 'ref', l_visadata(i).ref);
    dbms_xmldom.setattribute(l_xmldocelement, 'err', l_visadata(i).err);
    dbms_xmldom.setattribute(l_xmldocelement, 'erm', l_visadata(i).erm);
    bars_audit.trace(g_pack_name || l_proc_name || 'Process. i=' || i ||
                     ', ref=' || l_visadata(i).ref || ', err=' || l_visadata(i).err ||
                     ', erm=' || l_visadata(i).erm);

    if (l_visadata(i).err = 0) then
      dbms_xmldom.setattribute(l_xmldocelement, 'grp', l_visadata(i).grp);
      dbms_xmldom.setattribute(l_xmldocelement,
                               'f_pay',
                               l_visadata(i).f_pay);
      dbms_xmldom.setattribute(l_xmldocelement,
                               'f_sign',
                               l_visadata(i).f_sign);
      dbms_xmldom.setattribute(l_xmldocelement,
                               'f_check',
                               l_visadata(i).f_check);

      -- блок данных для ЭЦП
      -- внутрішній підпис
      l_xmlintecpelement := createelement('int_ecp',
                                          l_xmldoc,
                                          l_xmldocelement);
      setattribute(l_xmlintecpelement,
                   'int_buffer_hex',
                   l_visadata(i).int_buffer_hex);
      if(l_visadata(i).int_ecp.first is not null) then
        for i0 in l_visadata(i).int_ecp.first .. l_visadata(i).int_ecp.last loop
          if (l_visadata(i).int_ecp(i0).id is not null) then
            l_xmlecpelement := createelement('ecp',
                                             l_xmldoc,
                                             l_xmlintecpelement);
            setattribute(l_xmlecpelement, 'id', l_visadata(i).int_ecp(i0).id);
            setattribute(l_xmlecpelement,
                         'sign_type',
                         l_visadata(i).int_ecp(i0).sign_type);
            setattribute(l_xmlecpelement,
                         'buffer_hex',
                         l_visadata(i).int_ecp(i0).buffer_hex);
            setattribute(l_xmlecpelement,
                         'key_id',
                         l_visadata(i).int_ecp(i0).key_id);
            setattribute(l_xmlecpelement,
                         'sign_hex',
                         l_visadata(i).int_ecp(i0).sign_hex);
          end if;
        end loop;
      end if;
      -- зовнішній підпис
      l_xmlextecpelement := createelement('ext_ecp',
                                          l_xmldoc,
                                          l_xmldocelement);
      setattribute(l_xmlextecpelement,
                   'ext_buffer_hex',
                   l_visadata(i).ext_buffer_hex);

      if (l_visadata(i).ext_ecp.id is not null) then
        l_xmlecpelement := createelement('ecp',
                                         l_xmldoc,
                                         l_xmlextecpelement);
        setattribute(l_xmlecpelement, 'id', l_visadata(i).ext_ecp.id);
        setattribute(l_xmlecpelement,
                     'sign_type',
                     l_visadata(i).ext_ecp.sign_type);
        setattribute(l_xmlecpelement,
                     'buffer_hex',
                     l_visadata(i).ext_ecp.buffer_hex);
        setattribute(l_xmlecpelement, 'key_id', l_visadata(i).ext_ecp.key_id);
        setattribute(l_xmlecpelement,
                     'sign_hex',
                     l_visadata(i).ext_ecp.sign_hex);
      end if;
    end if;
  end loop;

  /* Структура исходящего XML outDataXml:
  <docs4visa>
    <doc ref="ref" err="1" erm="ффффф" />
    <doc ref="ref" err="0" erm="..." grp="grp" f_pay="f_pay" f_sign="f_sign" f_check="f_check">
      <int_ecp int_buffer_hex="">
        <ecp id="" sgntype_code="" buffer_hex="" keyid="" sign_hex="" />
        ...
      </int_ecp>
      <ext_ecp ext_buffer_hex="">
        <ecp id="" sgntype_code="" buffer_hex="" keyid="" sign_hex="" />
      <ext_ecp>
    </doc>
  </docs4visa>
  */

  -- конвертируем xml в clob и возвращаем его
  dbms_lob.createtemporary(outdataxml, true);
  dbms_xmldom.writetoclob(l_xmldoc, outdataxml);
  dbms_xmldom.freedocument(l_xmldoc);
end make_data4visa_ext_xml;

/**
 * Наложение виз на документы и оплата по факту
 * параметры в xml
 */
  procedure put_visas_xml(inDataClob in CLOB, outDataXml out CLOB) is
    l_xmlParser      dbms_xmlparser.Parser;
    l_xmlDoc         dbms_xmldom.DOMDocument;
    l_xmlNode        dbms_xmldom.DOMNode;
    l_xmlRootElement dbms_xmldom.DOMElement;
    l_xmlDocNodes    dbms_xmldom.DOMNodeList;
    l_xmlDocNode     dbms_xmldom.DOMNode;
    l_xmlDocElement  dbms_xmldom.DOMElement;
    l_xmlBufsNode    dbms_xmldom.DOMNode;
    l_xmlBufsElement dbms_xmldom.DOMElement;
    l_xmlECPsNode    dbms_xmldom.DOMNode;
    l_xmlECPsElement dbms_xmldom.DOMElement;

    l_teller_flag number := 0;

    l_grp number;
    l_par number;

    l_visadata_ecp tt_visa_ECP_data_array;
    l_visadata_obj tt_visa_ECP_data_obj;

    l_signbufs     tt_str_array;
    l_signbufs_ecp tt_str_array;

    l_key varchar2(400);

    l_tt         char(3);
    l_status     number;
    l_status_tmp number;
    l_tmp1       number;
    l_tmp2       varchar(500);

    l_tmp_ref          number;
    l_tmp_signbufs     tt_str_array;
    l_tmp_signbufs_ecp tt_str_array;
    l_tmp_pay          integer;
    l_tmp_sign         integer;
    l_tmp_int_buf      varchar2(32767);
    l_tmp_sep_buf      varchar2(32767);
    l_tmp_int_suffix   varchar2(32767);
    l_int_check        integer;
    l_sep_check        integer;
    l_tmp              varchar(32767);

    l_isSepDoc integer;
    l_flags38  varchar(10);

    err_lock_visa_exception exception;
    pragma exception_init(err_lock_visa_exception, -20721);
    err_put_visa_exception exception;
    pragma exception_init(err_put_visa_exception, -20722);
    err_pay_doc_exception exception;
    pragma exception_init(err_pay_doc_exception, -20203);
    err_doc_storno_exception exception;
    pragma exception_init(err_doc_storno_exception, -20101);
  begin
    /* Структура входящего XML inDataClob:
    <?xml version="1.0" encoding="utf-8" ?>
    <docs4visa grpid="grpId" par="par">
      <doc ref="ref" key="ECP[3]">
        <bufs inner_buf="inSign" outer_buf="outSign" />
        <ecps inner_ecp="ECP[1]" outer_ecp="ECP[2]" />
      </doc>
    </docs4visa>
    */

    -- парсим XML через DOM
    l_xmlParser := dbms_xmlparser.newParser;
    begin
      -- загружаем xml из clob
      dbms_xmlparser.parseClob(l_xmlParser, inDataClob);
      l_xmlDoc := dbms_xmlparser.getDocument(l_xmlParser);

      -- берем рут єлемент и читаем параметры l_grp и l_par
      l_xmlRootElement := dbms_xmldom.getDocumentElement(l_xmlDoc);
      l_grp            := to_number(dbms_xmldom.getAttribute(l_xmlRootElement,
                                                             'grpid'));
      l_par            := to_number(dbms_xmldom.getAttribute(l_xmlRootElement,
                                                             'par'));

      if (l_par = -1) then
        -- возвратна одну назад
        l_status := -1;
      elsif (l_par = 0) then
        -- визирование
        l_status := 0;
      else
        -- сторнирование
        l_status := 3;
      end if;

      -- перебираем все документы
      l_xmlDocNodes := dbms_xmldom.getElementsByTagName(l_xmlDoc, 'doc');
      for i in 0 .. dbms_xmldom.getLength(l_xmlDocNodes) - 1 loop
        l_xmlDocNode    := dbms_xmldom.item(l_xmlDocNodes, i);
        l_xmlDocElement := dbms_xmldom.makeElement(l_xmlDocNode);

        -- референс и ключ
        l_visadata_obj.ref := to_number(dbms_xmldom.getAttribute(l_xmlDocElement,
                                                                 'ref'));
        l_visadata_obj.key := dbms_xmldom.getAttribute(l_xmlDocElement,
                                                       'key');

        -- внутр и внеш буфер
        l_xmlBufsNode := dbms_xmldom.item(dbms_xmldom.getElementsByTagName(l_xmlDocElement,
                                                                           'bufs'),
                                          0);
        l_xmlBufsElement := dbms_xmldom.makeElement(l_xmlBufsNode);
        l_signbufs(1) := dbms_xmldom.getAttribute(l_xmlBufsElement,
                                                  'inner_buf');
        l_signbufs(2) := dbms_xmldom.getAttribute(l_xmlBufsElement,
                                                  'outer_buf');
        l_visadata_obj.sign_bufs := l_signbufs;

        -- внутр и внеш подпись
        l_xmlECPsNode := dbms_xmldom.item(dbms_xmldom.getElementsByTagName(l_xmlDocElement,
                                                                           'ecps'),
                                          0);
        l_xmlECPsElement := dbms_xmldom.makeElement(l_xmlECPsNode);
        l_signbufs_ecp(1) := dbms_xmldom.getAttribute(l_xmlECPsElement,
                                                      'inner_ecp');
        l_signbufs_ecp(2) := dbms_xmldom.getAttribute(l_xmlECPsElement,
                                                      'outer_ecp');
        l_visadata_obj.sign_bufs_ecp := l_signbufs_ecp;

        -- добавляем текущий объект в масив
        l_visadata_ecp(i) := l_visadata_obj;
      end loop;

      -- отчищаем память от парсера и документа
      dbms_xmlparser.freeParser(l_xmlParser);
      dbms_xmldom.freeDocument(l_xmlDoc);
    exception
      when others then
        -- отчищаем память от парсера и документа
        dbms_xmlparser.freeParser(l_xmlParser);
        dbms_xmldom.freeDocument(l_xmlDoc);

        -- бросаем ошибку дальше
        raise_application_error(-20000,
                                substr(sqlerrm || chr(10) ||
                                       dbms_utility.format_call_stack(),
                                       0,
                                       4000),
                                true);
    end;

    -- формируем ответ
    -- !!!! <?xml version="1.0" encoding="windows-1251" ?>
    l_xmlDoc         := dbms_xmldom.newDOMDocument;
    l_xmlRootElement := dbms_xmldom.createElement(l_xmlDoc, 'docs4visa');
    dbms_xmldom.setAttribute(l_xmlRootElement, 'grpid', l_grp);
    dbms_xmldom.setAttribute(l_xmlRootElement, 'par', l_par);
    l_xmlNode        := dbms_xmldom.appendChild(dbms_xmldom.makeNode(l_xmlDoc),
                                                dbms_xmldom.makeNode(l_xmlRootElement));

    for j in l_visadata_ecp.first .. l_visadata_ecp.last loop
      -- элемент документа
      l_xmlDocElement := dbms_xmldom.createElement(l_xmlDoc, 'doc');
      dbms_xmldom.setAttribute(l_xmlDocElement,
                               'ref',
                               l_visadata_ecp(j).ref);

      begin
        -- точка отката в случае неудачного визирования
        savepoint before_locknput_visa;

        l_tmp_ref          := l_visadata_ecp(j).ref;
        l_key              := l_visadata_ecp(j).key;
        l_tmp_signbufs     := l_visadata_ecp(j).sign_bufs;
        l_tmp_signbufs_ecp := l_visadata_ecp(j).sign_bufs_ecp;

        l_int_check := 1;
        l_sep_check := 1;

        -- получаем параметры визы документа
        chk.lock_doc(l_tmp_ref, l_grp, l_tmp_pay, l_tmp_sign);

        -- сверяем внеш подпись
        if bitand(l_tmp_sign, chk.DEF_EXT_SIGN) <> 0 then
          Docsign.RetrieveSEPBuffer(l_tmp_ref, l_key, l_tmp_sep_buf);
          l_tmp_sep_buf := rawtohex(utl_raw.cast_to_raw(l_tmp_sep_buf));

          if ((l_tmp_sep_buf is null and l_tmp_signbufs(2) is null) or
             (l_tmp_sep_buf = l_tmp_signbufs(2))) then
            l_sep_check := 1;
          else
            l_sep_check := 0;
          end if;
        end if;

        begin
          execute immediate 'begin :1 := teller_tools.is_teller_doc('||l_visadata_ecp(j).ref||'; exception when others then :1 := 0;end;'
            using out l_teller_flag;
          exception when others then l_teller_flag := 0;
        end;
        l_status_tmp := l_status;
        if (l_status = 0) then
          if (l_tmp_pay = 1) or (l_teller_flag = 1) then
            l_status_tmp := 2;
          else
            l_status_tmp := 1;
          end if;
        end if;

        case l_status_tmp
          when -1 then
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '0');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     'Повернення на одну візу назад виконано успішно');
          when 1 then
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '0');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     'Документ успішно візовано');
          when 2 then
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '0');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     'Документ успішно візовано та оплачено');
          when 3 then
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '0');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     'Документ успішно сторновано');
        end case;

        -- сверяем внутр подпись
        if bitand(l_tmp_sign, chk.DEF_INT_SIGN) <> 0 then
          chk.make_int_docbuf(l_tmp_ref, l_tmp_int_buf);
          chk.get_buf(l_tmp_ref, 99, l_tmp_int_suffix);
          l_tmp := rawtohex(utl_raw.cast_to_raw(l_tmp_int_buf)) ||
                   l_tmp_int_suffix;

          if ((l_tmp is null and l_tmp_signbufs(1) is null) or
             (l_tmp = l_tmp_signbufs(1))) then
            l_int_check := 1;
          else
            l_int_check := 0;
          end if;
        end if;

        -- визируем документ
        if (l_int_check = 1 and l_sep_check = 1) then
          select TT into l_tt from OPER where REF = l_tmp_ref;

          -- возврат на одну назад
          if (l_status_tmp = -1) then
            UPDATE oper
               SET chk = substr(chk, 1, length(rtrim(chk)) - 6)
             WHERE ref = l_tmp_ref;
            DELETE FROM oper_visa
             WHERE sqnc =
                   (SELECT max(sqnc) FROM oper_visa WHERE ref = l_tmp_ref);
            INSERT INTO oper_visa
              (ref, dat, userid, groupid, status, passive)
            VALUES
              (l_tmp_ref, SYSDATE, uid_, l_grp, 0, 1);
          end if;

          -- визирование
          if (l_status_tmp = 1) then
            chk.put_visa(l_tmp_ref,
                         l_tt,
                         l_grp,
                         l_status_tmp,
                         l_key,
                         l_tmp_signbufs_ecp(1),
                         l_tmp_signbufs_ecp(2));

          end if;

          -- оплата
          if (l_status_tmp = 2) then
            -- виза
            chk.put_visa(l_tmp_ref,
                         l_tt,
                         l_grp,
                         l_status_tmp,
                         l_key,
                         l_tmp_signbufs_ecp(1),
                         l_tmp_signbufs_ecp(2));

            -- оплата
            declare
              l_oper_row oper%rowtype;
              l_refl     number := l_tmp_ref;
            begin
              while (l_refl is not null) loop
                -- оплата документа и дочерних
                gl.pay(2, l_refl, gl.bDATE);
                -- фиксируем момент оплаты в журнале
                logger.trace('Оплачен документ, ref=' || l_refl);
                -- достаем из опера данные
                select o.*
                  into l_oper_row
                  from oper o
                 where o.ref = l_refl;
                l_refl := l_oper_row.refl;

                -- берем парметры операции
                select tt.fli, substr(tt.flags, 38, 1)
                  into l_isSepDoc, l_flags38
                  from tts tt
                 where tt.tt = l_oper_row.tt;

                -- документ СЕП
                if (l_isSepDoc = 1 and l_oper_row.mfoa != l_oper_row.mfob and
                   (l_flags38 = 0 or l_flags38 = 1 or l_flags38 = 3)) then
                  declare
                    l_arc_row  arc_rrp%rowtype;
                    l_err      number;
                    l_n_er     s_er.n_er%type;
                    l_msg      varchar2(256);
                    l_vob_list params.val%type;
                    l_vob_bad  oper.vob%type;
                  begin
                    -- документ оплачен по факту ?
                    if l_oper_row.sos = 5 then

                      -- определяем nazns
                      if trim(l_oper_row.d_rec) is not null then
                        l_arc_row.nazns := '11';
                      else
                        l_arc_row.nazns := '10';
                      end if;

                      if (l_oper_row.bis = 1) then
                        -- ошибка: Невозможно передать в СЭП документ с блоком информ. сообщений.
                        -- bars_error.raise_error('BRS-00201');
                        -- TODO
                        null;
                      end if;

                      l_arc_row.dat_a := to_date(to_char(l_oper_row.datp,
                                                         'DD-MM-YYYY') || ' ' ||
                                                 to_char(sysdate, 'HH24:MI'),
                                                 'DD-MM-YYYY HH24:MI');

                      -- обработываем VOB
                      begin
                        select to_number(val)
                          into l_vob_bad
                          from params
                         where par = 'VOB2SEP';
                      exception
                        when no_data_found then
                          l_vob_bad := 1;
                      end;
                      begin
                        select ',' || replace(trim(val), ' ', '') || ','
                          into l_vob_list
                          from params
                         where par = 'VOB2SEP2';
                      exception
                        when no_data_found then
                          l_vob_list := null;
                      end;
                      if l_vob_list is null then
                        if l_oper_row.vob not in (1, 2, 6, 33, 81) then
                          l_oper_row.vob := l_vob_bad;
                        end if;
                      else
                        if instr(l_vob_list, ',' || l_oper_row.vob || ',') = 0 then
                          l_oper_row.vob := l_vob_bad;
                        end if;
                      end if;

                      l_err         := -1;
                      l_arc_row.rec := 0;

                      -- помещаем в СЭП
                      sep.in_sep(l_err,
                                 l_arc_row.rec,
                                 l_oper_row.mfoa,
                                 l_oper_row.nlsa,
                                 l_oper_row.mfob,
                                 l_oper_row.nlsb,
                                 l_oper_row.dk,
                                 l_oper_row.s,
                                 l_oper_row.vob,
                                 l_oper_row.nd,
                                 l_oper_row.kv,
                                 l_oper_row.datd,
                                 l_oper_row.datp,
                                 l_oper_row.nam_a,
                                 l_oper_row.nam_b,
                                 l_oper_row.nazn,
                                 null,
                                 l_arc_row.nazns,
                                 l_oper_row.id_a,
                                 l_oper_row.id_b,
                                 l_oper_row.id_o,
                                 l_oper_row.ref_a,
                                 nvl(l_oper_row.bis, 0),
                                 l_oper_row.sign,
                                 null,
                                 null,
                                 l_arc_row.dat_a,
                                 l_oper_row.d_rec,
                                 0,
                                 l_oper_row.ref);

                      -- обрабатываем результат работы
                      if l_err = 0 then
                        -- если документ пришел из OFFLINE-отделения, у него должен быть реквизит REF_F
                        -- значение реквизита REF_F проставляем в поле arc_rrp.ref_a
                        declare
                          l_value operw.value%type;
                        begin
                          select value
                            into l_value
                            from operw
                           where ref = l_oper_row.ref
                             and tag = 'REF_F';
                          update arc_rrp
                             set ref_a = l_value
                           where rec = l_arc_row.rec;
                        exception
                          when no_data_found then
                            null;
                        end;

                        -- приоретет Set SSP flag
                        if l_oper_row.prty > 0 then
                          update arc_rrp
                             set prty = l_oper_row.prty
                           where rec = l_arc_row.rec;
                        end if;

                        -- все ок
                        dbms_xmldom.setAttribute(l_xmlDocElement,
                                                 'err',
                                                 '0');
                        dbms_xmldom.setAttribute(l_xmlDocElement,
                                                 'erm',
                                                 'Документ успішно візовано та оплачено. Передано у СЕП.');
                      else
                        -- ошибка
                        begin
                          select n_er
                            into l_n_er
                            from s_er
                           where k_er = l_err;
                        exception
                          when no_data_found then
                            null;
                        end;

                        -- ошибка: Невозможно передать в СЭП. Ошибка : %s
                        bars_error.raise_error('BRS-00200', l_n_er);
                      end if;
                    end if;
                  end;
                end if;
              end loop;
            end;
          end if;

          -- сторнирование
          if (l_status_tmp = 3) then
            p_back_dok(l_tmp_ref, 5, l_par, l_tmp1, l_tmp2, 0);
            chk.put_visa(l_tmp_ref,
                         l_tt,
                         l_grp,
                         l_status_tmp,
                         l_key,
                         l_tmp_signbufs_ecp(1),
                         l_tmp_signbufs_ecp(2));
          end if;
        end if;

        -- делаем запись в исходящий xml
        case
          when (l_int_check = 0) then
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '1');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     '1 - Внутр. буфер не співпадає зі старим значенням');
          when (l_sep_check = 0) then
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '2');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     '2 - Зовн. буфер не співпадає зі старим значенням');
          when (l_int_check = 0 and l_sep_check = 0) then
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '3');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     '2 - Внутр. та зовн. буфер не співпадає зі старим значенням');
          else
            -- ошибки нет
            null;
        end case;

      exception
        when err_lock_visa_exception then
          rollback to before_locknput_visa;
          dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '4');
          dbms_xmldom.setAttribute(l_xmlDocElement,
                                   'erm',
                                   '4 - Документ зайнятий');
        when err_put_visa_exception then
          rollback to before_locknput_visa;
          dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '5');
          dbms_xmldom.setAttribute(l_xmlDocElement,
                                   'erm',
                                   '5 - Неможливо візувати документ');
        when err_pay_doc_exception then
          rollback to before_locknput_visa;
          declare
            l_errumsg  varchar2(4000);
            l_erracode varchar2(4000);
            l_erramsg  varchar2(4000);
          begin
            bars_error.get_error_info(SQLERRM,
                                      l_errumsg,
                                      l_erracode,
                                      l_erramsg);

            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '6');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     '6 - Неможливо оплатити документ: ' || l_errumsg);
          end;
        when err_doc_storno_exception then
          rollback to before_locknput_visa;
          declare
            l_errumsg  varchar2(4000);
            l_erracode varchar2(4000);
            l_erramsg  varchar2(4000);
          begin
            bars_error.get_error_info(SQLERRM,
                                      l_errumsg,
                                      l_erracode,
                                      l_erramsg);
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '7');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     '7 - Неможливо сторнувати документ: ' || l_errumsg);
          end;
          -- если определенная нами ошибка
        when OTHERS then
          -- ошибка: Невозможно передать в СЭП. Ошибка : %s
          if (bars_error.get_error_code(sqlerrm) = 'BRS-00200') then
            rollback to before_locknput_visa;
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '8');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     '8 - ' || sqlerrm);
          elsif (bars_error.get_error_code(sqlerrm) = 'BRS-00201') then
            rollback to before_locknput_visa;
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '9');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     '9 - ' || sqlerrm);
          elsif (bars_error.get_error_code(sqlerrm) = 'BRS-00205') then
            rollback to before_locknput_visa;
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '10');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     '10 - ' || substr(sqlerrm,22, instr(substr(sqlerrm,22),'ORA-06512')-1));
          elsif (bars_error.get_error_code(sqlerrm) = 'BRS-00206') then
            rollback to before_locknput_visa;
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '11');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     '11 -  Перевищено термін очікування від сервера(ЦБД)!');
          elsif (bars_error.get_error_code(sqlerrm) = 'BRS-00101') then
            rollback to before_locknput_visa;
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '12');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     '12 - ' || substr(sqlerrm,22, instr(substr(sqlerrm,22),'ORA-06512')-1));
          elsif (bars_error.get_error_code(sqlerrm) = 'BRS-00208') then
            rollback to before_locknput_visa;
            dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '13');
            dbms_xmldom.setAttribute(l_xmlDocElement,
                                     'erm',
                                     '13 - ' || substr(sqlerrm,22, instr(substr(sqlerrm,22),'ORA-06512')-1));
          elsif (sqlcode between -20999 and -20000) then
            rollback to before_locknput_visa;
            declare
                l_errumsg  varchar2(4000);
                l_erracode varchar2(4000);
                l_erramsg  varchar2(4000);
            begin
                bars_error.get_error_info(SQLERRM,
                                      l_errumsg,
                                      l_erracode,
                                      l_erramsg);
                dbms_xmldom.setAttribute(l_xmlDocElement, 'err', '14');
                dbms_xmldom.setAttribute(l_xmlDocElement, 'erm', l_erracode || ' ' || l_errumsg);
            end;
          else
            -- если нет, то бросаем дальше
            raise_application_error(-20000,
                                    substr(sqlerrm || chr(10) ||
                                           dbms_utility.format_call_stack(),
                                           0,
                                           4000),
                                    true);
          end if;
      end;

      l_xmlNode := dbms_xmldom.appendChild(dbms_xmldom.makeNode(l_xmlRootElement),
                                           dbms_xmldom.makeNode(l_xmlDocElement));
    end loop;

    /* Структура исходящего XML outDataXml:
    <docs4visa grpid="grpId" par="par">
      <doc ref="ref" err="1" erm="ффффф" />
    </docs4visa>
    */

    -- конвертируем xml в clob и возвращаем его
    dbms_lob.createtemporary(outDataXml, true);
    dbms_xmldom.writeToClob(l_xmlDoc, outDataXml);
    dbms_xmldom.freeDocument(l_xmlDoc);
  end put_visas_xml;

  procedure put_visas_xml_ext(inDataClob in clob, outDataXml out clob, enableCommit in number default 0) is
    l_proc_name varchar2(100) := 'put_visas_xml_ext. ';

    l_xmlParser      dbms_xmlparser.Parser;
    l_xmlDoc         dbms_xmldom.DOMDocument;
    l_xmlNode        dbms_xmldom.DOMNode;
    l_xmlRootElement dbms_xmldom.DOMElement;
    l_xmlDocNodes    dbms_xmldom.DOMNodeList;
    l_xmlDocNode     dbms_xmldom.DOMNode;
    l_xmlDocElement  dbms_xmldom.DOMElement;
    l_xmlBufsNode    dbms_xmldom.DOMNode;
    l_xmlBufsElement dbms_xmldom.DOMElement;
    l_xmlECPsNode    dbms_xmldom.DOMNode;
    l_xmlECPsElement dbms_xmldom.DOMElement;

    l_grp number;
    l_par number;
    l_sqnc oper_visa.sqnc%type;

    l_visa_obj   tt_visa_obj_ext ;
    l_visa_array tt_visa_array_ext;

    err_lock_visa_exception exception;
    pragma exception_init(err_lock_visa_exception, -20721);
    err_put_visa_exception exception;
    pragma exception_init(err_put_visa_exception, -20722);
    err_pay_doc_exception exception;
    pragma exception_init(err_pay_doc_exception, -20203);
    err_doc_storno_exception exception;
    pragma exception_init(err_doc_storno_exception, -20101);

    -- Повернення на одну візу назад
    procedure p_oneback(p_ref     in number,
                        l_userid  in oper_visa.userid%type,
                        l_groupid in oper_visa.groupid%type) is
     l_rec_id  oper_visa.sqnc%type;
    begin
      update oper o
         set o.chk = substr(o.chk, 1, length(rtrim(o.chk)) - 6)
       where o.ref = p_ref;

      select max(sqnc) into l_rec_id from oper_visa where ref = p_ref;
      -- видаляємо підпис зі сховища спочатку
      sgn_mgr.del_int_sign(p_ref, l_rec_id);
      -- видаляємо саму візу
      delete from oper_visa ov
       where ov.sqnc = l_rec_id;

      insert into oper_visa
        (ref, dat, userid, groupid, status, passive)
      values
        (p_ref, sysdate, l_userid, l_groupid, 0, 1);
    end p_oneback;

    -- Оплата
    procedure p_pay(p_ref           in number,
                    l_xmlDocElement in dbms_xmldom.DOMElement) is
      l_oper_row oper%rowtype;
      l_refl     number := p_ref;

      l_isSepDoc  integer;
      l_flags35   varchar(10);
      l_flags38   varchar(10);
      l_anazn     tt_str_array;
      l_req_value varchar2(1024);
      l_index     integer := 0;
      l_bis       integer := 0;
    begin
      while (l_refl is not null) loop
        -- оплата документа и дочерних
        gl.pay(2, l_refl, gl.bDATE);
        -- фиксируем момент оплаты в журнале
        logger.trace('Оплачен документ, ref=' || l_refl);
        -- достаем из опера данные
        select o.* into l_oper_row from oper o where o.ref = l_refl;
        l_refl := l_oper_row.refl;

        -- берем парметры операции
        select tt.fli, substr(tt.flags, 35, 1), substr(tt.flags, 38, 1)
          into l_isSepDoc, l_flags35, l_flags38
          from tts tt
         where tt.tt = l_oper_row.tt;

        -- документ СЕП
        if (l_isSepDoc = 1 and l_oper_row.mfoa != l_oper_row.mfob and
           (l_flags38 = 0 or l_flags38 = 1 or l_flags38 = 3)) then
          declare
            l_arc_row  arc_rrp%rowtype;
            l_err      number;
            l_n_er     s_er.n_er%type;
            l_vob_list params.val%type;
            l_vob_bad  oper.vob%type;
          begin
            -- документ оплачен по факту ?
            if l_oper_row.sos = 5 then

              -- определяем nazns
              if trim(l_oper_row.d_rec) is not null then
                l_arc_row.nazns := '11';
              else
                l_arc_row.nazns := '10';
              end if;

              l_arc_row.dat_a := to_date(to_char(l_oper_row.datp,
                                                 'DD-MM-YYYY') || ' ' ||
                                         to_char(sysdate, 'HH24:MI'),
                                         'DD-MM-YYYY HH24:MI');
              -- обработываем VOB
              begin
                select to_number(val)
                  into l_vob_bad
                  from params
                 where par = 'VOB2SEP';
              exception
                when no_data_found then
                  l_vob_bad := 1;
              end;
              begin
                select ',' || replace(trim(val), ' ', '') || ','
                  into l_vob_list
                  from params
                 where par = 'VOB2SEP2';
              exception
                when no_data_found then
                  l_vob_list := null;
              end;
              if l_vob_list is null then
                if l_oper_row.vob not in (1, 2, 6, 33, 81) then
                  l_oper_row.vob := l_vob_bad;
                end if;
              else
                if instr(l_vob_list, ',' || l_oper_row.vob || ',') = 0 then
                  l_oper_row.vob := l_vob_bad;
                end if;
              end if;

              l_err         := -1;
              l_arc_row.rec := 0;

              l_index := 0;
              l_anazn.delete;
              -- если есть swift реквизит mt или включено формирование бис-ов
              if instr(l_oper_row.d_rec, '#fMT') > 0 or l_flags35 = 1 then
                for c in (select w.tag, w.value, v.vspo_char
                          from operw w, op_field v
                          where w.ref=l_oper_row.ref and w.tag=v.tag and v.vspo_char in ('F','П','C') order by v.vspo_char,w.tag)
                loop
                  for v in (select regexp_substr(c.value ,'[^'|| chr(13)||chr(10) ||']+', 1, level) value
                            from dual
                            connect by regexp_substr(c.value , '[^'|| chr(13)||chr(10) ||']+', 1, level) is not null)
                  loop
                    l_index := l_index + 1;
                    if c.vspo_char = 'F' then
                       l_req_value := '#F' || trim(c.tag) || ':' || rpad(trim(v.value) || '#', 158);
                    else
                       l_req_value := '#' || c.vspo_char || rpad(trim(v.value) || '#', 218);
                    end if;
                    l_anazn(l_index) := l_req_value;
                  end loop;
                end loop;
              end if;

              -- есть БИС строки
              if l_index > 0 then
                l_bis := 1;
                l_arc_row.rec := 0;
                while l_bis <= l_index + 1
                loop
                  if l_bis = 1 then -- первая строка
                    l_arc_row.d_rec := '#B' || lpad(l_index + 1, 2, '0') || nvl(l_oper_row.d_rec, '#');
                    l_arc_row.nazns := '11';
                  else              -- остальные строки
                    l_arc_row.nazns := '33';
                    l_oper_row.s := 0;
                    l_oper_row.dk := case l_oper_row.dk when 0 then 2 when 1 then 3 else l_oper_row.dk end;
                    l_req_value := l_anazn(l_bis - 1); -- берем из колекции
                    if length(l_req_value) > 160 then
                       l_arc_row.d_rec := substr(l_req_value, 161, 60);
                       l_oper_row.nazn := substr(l_req_value, 1, 160);
                    else
                       l_arc_row.d_rec := '';
                       l_oper_row.nazn := substr(l_req_value, 1, 160);
                    end if;
                  end if;
                  sep.in_sep(l_err,
                             l_arc_row.rec,
                             l_oper_row.mfoa,
                             l_oper_row.nlsa,
                             l_oper_row.mfob,
                             l_oper_row.nlsb,
                             l_oper_row.dk,
                             l_oper_row.s,
                             l_oper_row.vob,
                             l_oper_row.nd,
                             l_oper_row.kv,
                             l_oper_row.datd,
                             l_oper_row.datp,
                             l_oper_row.nam_a,
                             l_oper_row.nam_b,
                             l_oper_row.nazn,
                             null,
                             l_arc_row.nazns,
                             l_oper_row.id_a,
                             l_oper_row.id_b,
                             null,
                             l_oper_row.ref_a,
                             l_bis,
                             null,
                             null,
                             null,
                             l_arc_row.dat_a,
                             l_arc_row.d_rec,
                             0,
                             l_oper_row.ref,
                             null,
                             null);
                    l_bis := l_bis + 1;
                    if l_err = 0 then
                      declare
                        l_value operw.value%type;
                      begin
                        select value
                          into l_value
                          from operw
                         where ref = l_oper_row.ref
                           and tag = 'REF_F';
                        update arc_rrp
                           set ref_a = l_value
                         where rec = l_arc_row.rec;
                      exception
                        when no_data_found then
                          null;
                      end;
                      -- приоретет Set SSP flag
                      if l_oper_row.prty > 0 then
                        update arc_rrp
                           set prty = l_oper_row.prty
                         where rec = l_arc_row.rec;
                      end if;
                    end if;
                end loop;
                -- все ок
                setAttribute(l_xmlDocElement, 'err', '0');
                setAttribute(l_xmlDocElement,
                             'erm',
                             'Документ успішно візовано та оплачено. Передано у СЕП.');
                --
              else -- помещаем в СЭП без БИС-ов
                sep.in_sep(l_err,
                           l_arc_row.rec,
                           l_oper_row.mfoa,
                           l_oper_row.nlsa,
                           l_oper_row.mfob,
                           l_oper_row.nlsb,
                           l_oper_row.dk,
                           l_oper_row.s,
                           l_oper_row.vob,
                           l_oper_row.nd,
                           l_oper_row.kv,
                           l_oper_row.datd,
                           l_oper_row.datp,
                           l_oper_row.nam_a,
                           l_oper_row.nam_b,
                           l_oper_row.nazn,
                           null,
                           l_arc_row.nazns,
                           l_oper_row.id_a,
                           l_oper_row.id_b,
                           null,-- специально пустой ключ
                           l_oper_row.ref_a,
                           0,
                           l_oper_row.sign,
                           null,
                           null,
                           l_arc_row.dat_a,
                           l_oper_row.d_rec,
                           0,
                           l_oper_row.ref);
                if l_err = 0 then
                  -- если документ пришел из OFFLINE-отделения, у него должен быть реквизит REF_F
                  -- значение реквизита REF_F проставляем в поле arc_rrp.ref_a
                  declare
                    l_value operw.value%type;
                  begin
                    select value
                      into l_value
                      from operw
                     where ref = l_oper_row.ref
                       and tag = 'REF_F';
                    update arc_rrp
                       set ref_a = l_value
                     where rec = l_arc_row.rec;
                  exception
                    when no_data_found then
                      null;
                  end;
                  -- приоретет Set SSP flag
                  if l_oper_row.prty > 0 then
                    update arc_rrp
                       set prty = l_oper_row.prty
                     where rec = l_arc_row.rec;
                  end if;
                  -- установка rec для внешней подписи, когда БИС-ов нет
                  sgn_mgr.set_ext_rec(l_oper_row.ref, l_arc_row.rec);
                  -- все ок
                  setAttribute(l_xmlDocElement, 'err', '0');
                  setAttribute(l_xmlDocElement,
                               'erm',
                               'Документ успішно візовано та оплачено. Передано у СЕП.');
                else
                  -- ошибка
                  begin
                    select n_er into l_n_er from s_er where k_er = l_err;
                  exception
                    when no_data_found then
                      null;
                  end;

                  -- ошибка: Невозможно передать в СЭП. Ошибка : %s
                  bars_error.raise_error('BRS-00200', l_n_er);
                end if;
              end if;

            end if;
          end;
        end if;
      end loop;
    end p_pay;

  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: inDataClob=%s',
                     dbms_lob.substr(inDataClob, 3000, 1));

    /* Структура входящего XML inDataClob:
    <?xml version="1.0" encoding="utf-8" ?>
    <docs4visa grpid="grpId" par="par">
      <doc ref="ref" key="ECP[3]" SGNTypeCode="...">
        <bufs inner_buf="inSign" outer_buf="outSign" />
        <ecps inner_ecp="ECP[1]" outer_ecp="ECP[2]" />
      </doc>
    </docs4visa>
    */

    -- парсим XML через DOM
    l_xmlParser := dbms_xmlparser.newParser;
    begin
      -- загружаем xml из clob
      dbms_xmlparser.parseClob(l_xmlParser, inDataClob);
      l_xmlDoc := dbms_xmlparser.getDocument(l_xmlParser);

      -- берем рут єлемент и читаем параметры l_grp и l_par
      l_xmlRootElement := dbms_xmldom.getDocumentElement(l_xmlDoc);
      l_grp            := to_number(dbms_xmldom.getAttribute(l_xmlRootElement,
                                                             'grpid'));
      l_par            := to_number(dbms_xmldom.getAttribute(l_xmlRootElement,
                                                             'par'));

      -- перебираем все документы
      l_xmlDocNodes := dbms_xmldom.getElementsByTagName(l_xmlDoc, 'doc');
      for i in 0 .. dbms_xmldom.getLength(l_xmlDocNodes) - 1 loop
        l_xmlDocNode    := dbms_xmldom.item(l_xmlDocNodes, i);
        l_xmlDocElement := dbms_xmldom.makeElement(l_xmlDocNode);

        -- референс, ключ, тип подписи
        l_visa_obj.ref          := to_number(dbms_xmldom.getAttribute(l_xmlDocElement,
                                                                      'ref'));
        l_visa_obj.keyid        := dbms_xmldom.getAttribute(l_xmlDocElement,
                                                            'key_id');
        l_visa_obj.sgntype_code := dbms_xmldom.getAttribute(l_xmlDocElement,
                                                            'sign_type');

        -- внутр и внеш буфер
        l_xmlBufsNode             := dbms_xmldom.item(dbms_xmldom.getElementsByTagName(l_xmlDocElement,
                                                                                       'bufs'),
                                                      0);
        l_xmlBufsElement          := dbms_xmldom.makeElement(l_xmlBufsNode);
        l_visa_obj.int_buffer_hex := dbms_xmldom.getAttribute(l_xmlBufsElement,
                                                              'inner_buf');
        l_visa_obj.ext_buffer_hex := dbms_xmldom.getAttribute(l_xmlBufsElement,
                                                              'outer_buf');

        -- внутр и внеш подпись
        l_xmlECPsNode           := dbms_xmldom.item(dbms_xmldom.getElementsByTagName(l_xmlDocElement,
                                                                                     'ecps'),
                                                    0);
        l_xmlECPsElement        := dbms_xmldom.makeElement(l_xmlECPsNode);
        l_visa_obj.int_sign_hex := dbms_xmldom.getAttribute(l_xmlECPsElement,
                                                            'inner_ecp');
        l_visa_obj.ext_sign_hex := dbms_xmldom.getAttribute(l_xmlECPsElement,
                                                            'outer_ecp');

        -- добавляем текущий объект в масив
        l_visa_array(i) := l_visa_obj;
      end loop;

      -- отчищаем память от парсера и документа
      dbms_xmlparser.freeParser(l_xmlParser);
      dbms_xmldom.freeDocument(l_xmlDoc);
    exception
      when others then

        -- отчищаем память от парсера и документа
        dbms_xmlparser.freeParser(l_xmlParser);
        dbms_xmldom.freeDocument(l_xmlDoc);

        -- бросаем ошибку дальше
        raise_application_error(-20000,
                                substr(sqlerrm || chr(10) ||
                                       dbms_utility.format_call_stack(),
                                       0,
                                       4000),
                                true);
    end;

    -- формируем ответ
    -- !!!! <?xml version="1.0" encoding="windows-1251" ?>
    l_xmlDoc         := dbms_xmldom.newDOMDocument;
    l_xmlRootElement := dbms_xmldom.createElement(l_xmlDoc, 'docs4visa');
    setAttribute(l_xmlRootElement, 'grpid', l_grp);
    setAttribute(l_xmlRootElement, 'par', l_par);
    l_xmlNode        := dbms_xmldom.appendChild(dbms_xmldom.makeNode(l_xmlDoc),
                                                dbms_xmldom.makeNode(l_xmlRootElement));

    for j in l_visa_array.first .. l_visa_array.last loop
      declare
        l_ref            number := l_visa_array(j).ref;
        l_sgntype_code   varchar2(3) := l_visa_array(j).sgntype_code;
        l_keyid          varchar2(2048) := l_visa_array(j).keyid;
        l_int_buffer_hex varchar2(32676) := l_visa_array(j).int_buffer_hex;
        l_int_sign_hex   varchar2(32676) := l_visa_array(j).int_sign_hex;
        l_ext_buffer_hex varchar2(32676) := l_visa_array(j).ext_buffer_hex;
        l_ext_sign_hex   varchar2(32676) := l_visa_array(j).ext_sign_hex;

        l_mode varchar2(300); -- режим обработки документа

        l_tt        oper.tt%type;
        l_pay_flag  integer;
        l_sign_flag integer;

        l_cur_ext_buffer     varchar2(32767);
        l_cur_ext_buffer_hex varchar2(32767);
        l_cur_int_buffer_hex varchar2(32767);

        l_int_check number := 1;
        l_sep_check number := 1;

        l_teller_flag number:=-1;
      begin
        --if(length(l_keyid) = 8) then
        --   l_keyid := substr(l_keyid, 3, 6);
        --end if;
        -- точка отката в случае неудачного визирования
        savepoint before_locknput_visa;

        -- элемент документа
        l_xmlDocElement := createElement('doc', l_xmlDoc, l_xmlRootElement);
        setAttribute(l_xmlDocElement, 'ref', l_ref);

        -- получаем параметры визы документа
        chk.lock_doc(l_ref, l_grp, l_pay_flag, l_sign_flag);

        -- определяем режим обработки документа
        /*
        ONEBACK - Повернення на одну візу назад
        VISA - Візування
        VISAPAY - Візування та оплата
        STORNO - Cторновання
        */
        begin
          execute immediate 'begin :1 := teller_tools.is_teller_doc('||l_ref||'); exception when others then :1 := 0;end;'
            using out l_teller_flag;
          exception when others then l_teller_flag := 0;
        end;
        case
          when (l_par = -1) then
            l_mode := 'ONEBACK';
          when (l_par = 0 and (l_pay_flag is null or l_pay_flag != 1) and l_teller_flag != 1) then
            l_mode := 'VISA';
          when (l_par = 0 and (l_pay_flag = 1 or l_teller_flag = 1)) then
            l_mode := 'VISAPAY';
          else
            l_mode := 'STORNO';
        end case;

        -- формируем сообщение
        case l_mode
          when 'ONEBACK' then
            setAttribute(l_xmlDocElement, 'err', '0');
            setAttribute(l_xmlDocElement,
                         'erm',
                         'Повернення на одну візу назад виконано успішно');
          when 'VISA' then
            setAttribute(l_xmlDocElement, 'err', '0');
            setAttribute(l_xmlDocElement,
                         'erm',
                         'Документ успішно візовано');
          when 'VISAPAY' then
            setAttribute(l_xmlDocElement, 'err', '0');
            setAttribute(l_xmlDocElement,
                         'erm',
                         'Документ успішно візовано та оплачено');
          when 'STORNO' then
            setAttribute(l_xmlDocElement, 'err', '0');
            setAttribute(l_xmlDocElement,
                         'erm',
                         'Документ успішно сторновано');
        end case;

        -- сверяем внеш буффер
        if bitand(l_sign_flag, chk.DEF_EXT_SIGN) <> 0 then
          Docsign.RetrieveSEPBuffer(l_ref, l_keyid, l_cur_ext_buffer);
          l_cur_ext_buffer_hex := rawtohex(utl_raw.cast_to_raw(l_cur_ext_buffer));
          if ((l_cur_ext_buffer_hex is null and l_ext_buffer_hex is null) or
             (l_cur_ext_buffer_hex = l_ext_buffer_hex)) then
            l_sep_check := 1;
          else
            l_sep_check := 0;
          end if;
        end if;

        -- сверяем внутр буффер
        if bitand(l_sign_flag, chk.DEF_INT_SIGN) <> 0 then
          chk.get_int_buffer_hex(l_ref, 99, l_cur_int_buffer_hex);
          if ((l_cur_int_buffer_hex is null and l_int_buffer_hex is null) or
             (l_cur_int_buffer_hex = l_int_buffer_hex)) then
            l_int_check := 1;
          else
            l_int_check := 0;
          end if;
        end if;

        -- обрабатываем документ
        if (l_int_check = 1 and l_sep_check = 1) then
          -- читаем тип операции
          select o.tt into l_tt from oper o where o.ref = l_ref;

          -- Повернення на одну візу назад
          if (l_mode = 'ONEBACK') then
            p_oneback(l_ref, uid_, l_grp);
          end if;

          -- Візування
          if (l_mode = 'VISA') then
            chk.put_visa_out(l_ref,
                          l_tt,
                          l_grp,
                          1, -- Візування
                          null, -- Ідентификатор ключа
                          null,
                          null,
                          l_sqnc);
            if(l_int_sign_hex is not null) then
               sgn_mgr.store_int_sign(l_ref, l_sqnc, l_sgntype_code, l_keyid, l_int_sign_hex);
            end if;
            if(l_ext_sign_hex is not null) then
               sgn_mgr.store_sep_sign(l_ref, l_sgntype_code, l_keyid, l_ext_sign_hex);
            end if;
          end if;

          -- Візування та оплата
          if (l_mode = 'VISAPAY') then
            -- виза
            chk.put_visa_out(l_ref,
                          l_tt,
                          l_grp,
                          2, -- Візування та оплата
                          null, -- Ідентификатор ключа
                          null,
                          null,
                          l_sqnc);
            if(l_int_sign_hex is not null) then
               sgn_mgr.store_int_sign(l_ref, l_sqnc, l_sgntype_code, l_keyid, l_int_sign_hex);
            end if;
            if(l_ext_sign_hex is not null) then
               sgn_mgr.store_sep_sign(l_ref, l_sgntype_code, l_keyid, l_ext_sign_hex);
            end if;
            -- оплата
            p_pay(l_ref, l_xmlDocElement);
          end if;

          -- Cторновання
          if (l_mode = 'STORNO') then
            declare
              l_par2 number; -- не використовується
              l_par3 number; -- не використовується
            begin
              p_back_dok(l_ref, 5, l_par, l_par2, l_par3, 0);
            end;

            chk.put_visa_out(l_ref,
                          l_tt,
                          l_grp,
                          3, -- Cторновання
                          null, -- Ідентификатор ключа
                          null,
                          null,
                          l_sqnc);
            if(l_int_sign_hex is not null) then
               sgn_mgr.store_int_sign(l_ref, l_sqnc, l_sgntype_code, l_keyid, l_int_sign_hex);
            end if;
            if(l_ext_sign_hex is not null) then
               sgn_mgr.store_sep_sign(l_ref, l_sgntype_code, l_keyid, l_ext_sign_hex);
            end if;
          end if;

          -- trace sign
          if sgn_mgr.g_trace_enabled = 1 then
            sgn_mgr.trace_sign(l_ref, null, l_keyid, l_mode, 'int', l_cur_int_buffer_hex, l_int_sign_hex, 0, null);
            if(l_ext_sign_hex is not null) then
               sgn_mgr.trace_sign(l_ref, null, l_keyid, l_mode, 'ext', l_cur_ext_buffer_hex, l_ext_sign_hex, 0, null);
            end if;
          end if;
        end if;

        -- делаем запись в исходящий xml
        case
          when (l_int_check = 0) then
            setAttribute(l_xmlDocElement, 'err', '1');
            setAttribute(l_xmlDocElement,
                         'erm',
                         '1 - Внутр. буфер не співпадає зі старим значенням');
          when (l_sep_check = 0) then
            setAttribute(l_xmlDocElement, 'err', '2');
            setAttribute(l_xmlDocElement,
                         'erm',
                         '2 - Зовн. буфер не співпадає зі старим значенням');
          when (l_int_check = 0 and l_sep_check = 0) then
            setAttribute(l_xmlDocElement, 'err', '3');
            setAttribute(l_xmlDocElement,
                         'erm',
                         '2 - Внутр. та зовн. буфер не співпадає зі старим значенням');
          else
            -- ошибки нет
            null;
        end case;

      exception
        when err_lock_visa_exception then
          rollback to before_locknput_visa;
          setAttribute(l_xmlDocElement, 'err', '4');
          setAttribute(l_xmlDocElement,
                       'erm',
                       '4 - Документ зайнятий');
        when err_put_visa_exception then
          rollback to before_locknput_visa;
          setAttribute(l_xmlDocElement, 'err', '5');
          setAttribute(l_xmlDocElement,
                       'erm',
                       '5 - Неможливо візувати документ');
        when err_pay_doc_exception then
          rollback to before_locknput_visa;
          declare
            l_errumsg  varchar2(4000);
            l_erracode varchar2(4000);
            l_erramsg  varchar2(4000);
          begin
            bars_error.get_error_info(SQLERRM,
                                      l_errumsg,
                                      l_erracode,
                                      l_erramsg);

            setAttribute(l_xmlDocElement, 'err', '6');
            setAttribute(l_xmlDocElement,
                         'erm',
                         '6 - Неможливо оплатити документ: ' || l_errumsg);
          end;
        when err_doc_storno_exception then
          rollback to before_locknput_visa;
          declare
            l_errumsg  varchar2(4000);
            l_erracode varchar2(4000);
            l_erramsg  varchar2(4000);
          begin
            bars_error.get_error_info(SQLERRM,
                                      l_errumsg,
                                      l_erracode,
                                      l_erramsg);
            setAttribute(l_xmlDocElement, 'err', '7');
            setAttribute(l_xmlDocElement,
                         'erm',
                         '7 - Неможливо сторнувати документ: ' || l_errumsg);
          end;
          -- если определенная нами ошибка
        when OTHERS then
          -- ошибка: Невозможно передать в СЭП. Ошибка : %s
          if (bars_error.get_error_code(sqlerrm) = 'BRS-00200') then
            rollback to before_locknput_visa;
            setAttribute(l_xmlDocElement, 'err', '8');
            setAttribute(l_xmlDocElement, 'erm', '8 - ' || sqlerrm);
          elsif (bars_error.get_error_code(sqlerrm) = 'BRS-00201') then
            rollback to before_locknput_visa;
            setAttribute(l_xmlDocElement, 'err', '9');
            setAttribute(l_xmlDocElement, 'erm', '9 - ' || sqlerrm);
          elsif (bars_error.get_error_code(sqlerrm) = 'BRS-00205') then
            rollback to before_locknput_visa;
            setAttribute(l_xmlDocElement, 'err', '10');
            setAttribute(l_xmlDocElement,
                         'erm',
                         '10 - ' ||
                         substr(sqlerrm,
                                22,
                                instr(substr(sqlerrm, 22), 'ORA-06512') - 1));
          elsif (bars_error.get_error_code(sqlerrm) = 'BRS-00206') then
            rollback to before_locknput_visa;
            setAttribute(l_xmlDocElement, 'err', '11');
            setAttribute(l_xmlDocElement,
                         'erm',
                         '11 -  Перевищено термін очікування від сервера(ЦБД)!');
          elsif (bars_error.get_error_code(sqlerrm) = 'BRS-00101') then
            rollback to before_locknput_visa;
            setAttribute(l_xmlDocElement, 'err', '12');
            setAttribute(l_xmlDocElement,
                         'erm',
                         '12 - ' ||
                         substr(sqlerrm,
                                22,
                                instr(substr(sqlerrm, 22), 'ORA-06512') - 1));
          elsif (bars_error.get_error_code(sqlerrm) = 'BRS-00208') then
            rollback to before_locknput_visa;
            setAttribute(l_xmlDocElement, 'err', '13');
            setAttribute(l_xmlDocElement,
                         'erm',
                         '13 - ' ||
                         substr(sqlerrm,
                                22,
                                instr(substr(sqlerrm, 22), 'ORA-06512') - 1));
          elsif (sqlcode between -20999 and -20000) then
            rollback to before_locknput_visa;
            declare
              l_errumsg  varchar2(4000);
              l_erracode varchar2(4000);
              l_erramsg  varchar2(4000);
            begin
              bars_error.get_error_info(SQLERRM,
                                        l_errumsg,
                                        l_erracode,
                                        l_erramsg);
              setAttribute(l_xmlDocElement, 'err', '14');
              setAttribute(l_xmlDocElement,
                           'erm',
                           l_erracode || ' ' || l_errumsg);
            end;
          else
            -- если нет, то бросаем дальше
            raise_application_error(-20000,
                                    substr(sqlerrm || chr(10) ||
                                           dbms_utility.format_error_backtrace,
                                           0,
                                           4000),
                                    true);
          end if;
      end;
      if mod(j, 100) = 0 and enableCommit = 1 then
        commit;
      end if;
    end loop;

    /* Структура исходящего XML outDataXml:
    <docs4visa grpid="grpId" par="par">
      <doc ref="ref" err="1" erm="ффффф" />
    </docs4visa>
    */


    -- конвертируем xml в clob и возвращаем его
    dbms_lob.createtemporary(outDataXml, true);
    dbms_xmldom.writeToClob(l_xmlDoc, outDataXml);
    dbms_xmldom.freeDocument(l_xmlDoc);
exception
  when others then
    logger.info('chk.put_visas_xml_ext: '||sqlerrm||' '||dbms_utility.format_call_stack);
    raise;
  end put_visas_xml_ext;


/**
 * update_check_sign - модификация информации о проверке ЭЦП на визе
 * @param p_sqnc in - глобальный номер визы
 * @param p_check_code in - код проверки ЭЦП на визе
 * @param p_check_msg in - описание кода проверки ЭЦП на визе
 */
procedure update_check_sign(p_sqnc in number, p_check_code in integer, p_check_msg in varchar2)
is
begin
  update oper_visa set check_ts=sysdate, check_code=p_check_code, check_msg=substr(p_check_msg,1,256)
  where sqnc=p_sqnc;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
   bars_error.raise_nerror(MODCODE, 'UNHANDLED_NO_DATA_FOUND', '$PROC', 'update_check_sign');
end update_check_sign;

/**
* возвращает номер групы "самовиза"
*/
function get_selfvisa_grp_id return number deterministic
is
begin
   return self_grp_;
end get_selfvisa_grp_id;

/**
* возвращает номер групы "самовиза" в hex
*/
function get_selfvisa_grp_hex return varchar2 deterministic
is
begin
   return self_grp_hex_;
end get_selfvisa_grp_hex;

/**
* возвращает номер групы "касса"
*/
function get_cashvisa_grp_id return number deterministic
is
begin
   return cash_grp_;
end get_cashvisa_grp_id;


/**
* возвращает номер групы "касса" в hex
*/
function get_cashvisa_grp_hex return varchar2 deterministic
is
begin
   return cash_grp_hex_;
end get_cashvisa_grp_hex;

/**
* Возвращает длину буффера документ  а (зависит от типа ЭЦП)
*/
function get_SignLng return number deterministic
is
begin
   return docsign.get_SignLng;
end get_SignLng;

/**
* Определяем флаг ЭЦП на указаном документе и его уровни и получаем необходимые буффера для проверки
*/
procedure getVisaBuffersForCheck(pRef in number, pLev in number, FSign out integer, IntBuff out varchar2, ExtBuff out varchar2)
is
  str_tmp varchar2(32767);
  str_hasSep varchar2(32767);
  str_SepKey varchar2(8);
  n_maxLevel integer;
begin
  -- уровень максимальной виз
  select NVL(length(rtrim(chk))/6,0) into n_maxLevel from OPER where REF = pRef;

  if pLev > n_maxLevel then
    FSign := 0;
    IntBuff := null;
    ExtBuff := null;
  else
    FSign := chk.visa_flag4check(pRef, pLev);

    if bitand(FSign, chk.DEF_INT_SIGN)<>0 then
      chk.make_int_docbuf(pRef, IntBuff);
      chk.get_buf(pRef, pLev, str_tmp);
          IntBuff := rawtohex(utl_raw.cast_to_raw(IntBuff))||str_tmp;
    else
      IntBuff := null;
    end if;

    -- смотрим есть ли подпись СЭП, берем ее
    select SIGN, ID_O into str_hasSep, str_SepKey from OPER where REF = pRef;
    if str_hasSep is null then
      ExtBuff := null;
    else
      Docsign.RetrieveSEPBuffer(pRef, str_SepKey, ExtBuff);
      -- формируем строку определенного вида для последующего ее разбора в скрипте
      ExtBuff := rawtohex(utl_raw.cast_to_raw(ExtBuff)) || str_SepKey || str_hasSep;
    end if;
  end if;
end getVisaBuffersForCheck;

PROCEDURE put_ack0(ref_ NUMBER, grp_ NUMBER) AS
sum_   NUMBER;
ack_   NUMBER;
tt_    CHAR(3);
chk_   VARCHAR2(80);
hex_   VARCHAR2(6);

pay_er EXCEPTION;
PRAGMA EXCEPTION_INIT(pay_er, -20203);

pos_   NUMBER;

msg_   VARCHAR2(100);

fli_   NUMBER;
flg_   NUMBER;
refL_  NUMBER;
refA_  VARCHAR2(9);
prty_  NUMBER;
sos_   NUMBER;

err_   NUMBER;    -- Return code
rec_   NUMBER;    -- Record number
mfoa_  VARCHAR2(12);   -- Sender's MFOs
nlsa_  VARCHAR2(15);   -- Sender's account number
mfob_  VARCHAR2(12);   -- Destination MFO
nlsb_  VARCHAR2(15);   -- Target account number
dk_    NUMBER;         -- Debet/Credit code
s_     DECIMAL(24);    -- Amount
vob_   NUMBER;         -- Document type
nd_    VARCHAR2(10);   -- Document number
kv_    NUMBER;         -- Currency code
datD_  DATE;           -- Document date
datP_  DATE;           -- Posting date
nam_a_  VARCHAR2(38);  -- Sender's customer name
nam_b_  VARCHAR2(38);  -- Target customer name
nazn_   VARCHAR(160);  -- Narrative
nazns_ CHAR(2);        -- Narrative contens type
id_a_  VARCHAR2(14);   -- Sender's customer identifier
id_b_  VARCHAR2(14);   -- Target's customer identifier
id_o_  VARCHAR2(6);    -- Teller identifier
sign_  OPER.SIGN%TYPE; -- Signature
datA_  DATE;           -- Input file date/time
d_rec_ VARCHAR2(80);   -- Additional parameters

l_dk   oper.dk%type;

PROCEDURE to_log (ref_ NUMBER, msg_ VARCHAR2) IS
      PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   INSERT INTO tmp_log (ref,msg) VALUES (ref_, msg_);
   COMMIT;
END;

BEGIN

   BEGIN
      SELECT o.tt,o.chk,o.refl
        INTO   tt_, chk_, refL_
        FROM oper o
       WHERE o.ref=ref_ AND o.sos>0 AND o.sos<5 AND o.vdat<=gl.bDATE
         FOR UPDATE OF sos NOWAIT;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN RETURN;
   END;

   -- читаем флаги из tts
   select fli, SUBSTR(flags,38,1) into fli_, flg_ from tts where tt=tt_;


   BEGIN
      SELECT SUM(DECODE(dk,0,-s,s)) INTO sum_
        FROM opldok
       WHERE ref = ref_ AND sos < 5 AND fdat <= gl.bDATE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
        sum_ := NULL;
   END;

   if l_dk in (2,3) then
      sum_ := 0;
   end if;

   IF sum_ = 0 THEN     -- Check if the document acknowleged

      BEGIN  -- Clear document

         SAVEPOINT chk_pay_before;
         hex_:=chk.put_stmp(grp_);


         UPDATE oper SET chk=RTRIM(NVL(chk,''))||hex_ WHERE ref=ref_
             RETURNING chk INTO chk_;
         INSERT INTO oper_visa (ref, dat, userid, groupid, status)
               VALUES (ref_, sysdate, user_id, grp_,    1);

         chk.doc_ack ( ref_,tt_,chk_,ack_);

         IF ack_ = 1 THEN

            gl.pay ( 2, ref_, gl.bDATE);

            IF fli_=1 AND (flg_=0 OR flg_=1 OR flg_=3) THEN

               SELECT mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
                      datd, datp, nam_a, nam_b, nazn, id_a, id_b,
                      id_o, sign, d_rec, sos, ref_a, prty
                 INTO mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
                      datd_,datp_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
                      id_o_,sign_,d_rec_, sos_, refA_, prty_
                 FROM oper WHERE ref=ref_;

               IF sos_ = 5 THEN -- Value date arrived

                  IF LENGTH(TRIM(NVL(d_rec_,'')))>0 THEN
                     nazns_ := '11';
                  ELSE
                     nazns_ := '10';
                  END IF;

                  datA_  := TO_DATE (TO_CHAR(datP_,'MM-DD-YYYY')||' '||
                            TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');

                  err_ := -1;
                  rec_ :=  0;

                  sep.in_sep(err_,rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,
                         vob_,nd_,kv_,datD_,datP_,nam_a_,nam_b_,nazn_,
                          NULL,nazns_,id_a_,id_b_,'******',refA_,0,'00',
                               NULL,NULL,datA_,d_rec_,0,ref_);

                  IF err_=0 THEN
                     msg_:= 'Оплачен. Передан в СЭП.';
                     IF prty_>0 THEN    -- Set SSP flag
                         UPDATE arc_rrp SET prty=prty_ WHERE rec=rec_;
                     END IF;
                  ELSE
                     ROLLBACK TO chk_pay_before;
                     msg_:= 'Невозможно передать в СЭП: Ош.'||err_;
                  END IF;

               END IF;
            END IF;
         ELSE
            msg_:= 'Не завизирован';
         END IF; -- ack_ = 1

      EXCEPTION
         WHEN OTHERS THEN ROLLBACK TO chk_pay_before;

         msg_ := SUBSTR(SQLERRM,13,100);
         pos_ := INSTR(msg_,CHR(10));

         IF pos_ > 0 THEN
            msg_ := SUBSTR(msg_,1,pos_-1);
         END IF;
      END;
   ELSE
      msg_:= 'Нет проводок для оплаты';
   END IF;
   deb.trace(1,msg_,ref_);
   to_log(ref_, msg_);
END put_ack0;

-- инициализация переменных пакета
procedure param is
begin

   -- SELECT id INTO uid_ FROM staff$base WHERE logname = user;
   uid_ := user_id;

   begin
      select to_number(val) into self_grp_ from params where par='SELFVISA';
   exception when no_data_found then self_grp_:=5;
   end;
   --
   begin
      select idchk_hex into self_grp_hex_ from chklist where idchk=self_grp_;
   exception when no_data_found then self_grp_hex_ := lpad(chk.to_hex(self_grp_),2,'0');
   end;
   --
   begin
      select to_number(val) into cash_grp_ from params where par='CASHVISA';
   exception when no_data_found then cash_grp_:=1;
   end;
   --
   begin
      select idchk_hex into cash_grp_hex_ from chklist where idchk=cash_grp_;
   exception when no_data_found then cash_grp_hex_ := lpad(chk.to_hex(cash_grp_),2,'0');
   end;
   --
   begin
     select to_number(val) into F_VISASIGN from params where par='VISASIGN';
   exception when no_data_found then F_VISASIGN := 0;
   end;
   begin
     select to_number(val) into F_INTSIGN from params where par='INTSIGN';
   exception when no_data_found then F_INTSIGN := 0;
   end;

   -- CASHVL
   begin
      select val
        into g_cashvl
        from params
       where par='CASHVL';
   exception
      when no_data_found then
          g_cashvl := null;
   end;
   --

   BEGIN
      SELECT   to_number(val)
        INTO   g_sepnum
        FROM   params
       WHERE   par = 'SEPNUM';
   EXCEPTION
        WHEN OTHERS THEN g_sepnum := 1;
   END;


   -- Cut out transaction, that must be retain witout visas
   BEGIN
       SELECT TRIM(VAL) INTO G_CHECKTT0 FROM PARAMS WHERE PAR='TTCHECK0';
   EXCEPTION WHEN NO_DATA_FOUND THEN
       G_CHECKTT0 := 'ЧЕК';
   END;

   BEGIN
       SELECT TRIM(VAL) INTO G_CHECKTT1 FROM PARAMS WHERE PAR='TTCHECK1';
   EXCEPTION WHEN NO_DATA_FOUND THEN
       G_CHECKTT1 := 'ЧЕК';
   END;

end param;

/**
 * reset_visa_history_int - сбрасывает историю виз на плановых документах
 * @param p_tt in - тип опрации
 */
procedure reset_visa_history_int(p_tt in tts.tt%type) is
    l_reflist        bars.tt_num_array;
    p   constant varchar2(61) := 'chk.rvhi';
begin

    logger.trace('%s: start', p);

    logger.info('Запущена процедура сброса виз для операции '||p_tt);

    -- идем по всем филиалам
    for c in (select * from mv_kf)
    loop
        -- представимся филиалом
        bc.subst_mfo(c.kf);
        logger.trace('%s: вошли в МФО %s', p, c.kf);
        -- читаем массив плановых документов
        select ref bulk collect into l_reflist from oper
        where ref in (select ref from ref_que) and tt=p_tt and sos between 0 and 3 and nextvisagrp<>'!!';
        --
        logger.trace('%s: вычитано %s незавизированных документов с кодом операции %s для сброса виз',
            p, to_char(l_reflist.count), p_tt
        );
        --
        -- сбрасываем поле CHK в OPER
        update oper set chk=null
        where ref in (select value(t) from table(cast(l_reflist as bars.tt_num_array)) t);
        --
        logger.trace('%s: сброшено %s полей oper.chk', p, to_char(sql%rowcount));
        --
        -- сбрасываем признак активной визы в OPER_VISA
        update oper_visa set passive = 1
        where groupid is not null and ref in (select value(t) from table(cast(l_reflist as bars.tt_num_array)) t);
        --
        logger.trace('%s: сброшено %s виз', p, to_char(sql%rowcount));
        --
        logger.trace('%s: закончили работу в МФО %s', p, c.kf);
        --
    end loop;
    -- вернем умолчательный контекст
    bc.set_context;
    --
    logger.trace('%s: finish', p);
    --
exception when others then
    -- вернем умолчательный контекст
    bc.set_context();
    -- исключение выбрасываем дальше
    raise_application_error(-20000, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
end reset_visa_history_int;

/**
 * reset_visa_history - сбрасывает историю виз на плановых документах
 * @param p_tt in - тип опрации
 */
procedure reset_visa_history(p_tt in tts.tt%type) is
    l_reflist        bars.tt_num_array;
    p   constant varchar2(61) := 'chk.rvh';
begin
    enqueue_reset_visa(p_tt);
end reset_visa_history;

/**
 * proc_reset_visa_queue - сбрасывает историю виз на плановых документах
 * разбирает очередь RESET_VISA_QUEUE
 */
procedure proc_reset_visa_queue
is
    p   constant varchar2(61) := 'chk.prvq';
    l_dequeue_options         dbms_aq.dequeue_options_t;
    l_message_properties      dbms_aq.message_properties_t;
    l_msgid                   raw(16);
    l_msg                     sys.anydata;
    l_tt                      tts.tt%type;
begin
  logger.trace('%s: start', p);
  --
  l_dequeue_options.consumer_name   := 'QOWNER';
  l_dequeue_options.wait            := dbms_aq.no_wait;
  l_dequeue_options.navigation      := dbms_aq.first_message;
  --
  while true loop
    begin
      dbms_aq.dequeue(
        queue_name          => 'qowner.reset_visa_queue',
        dequeue_options     => l_dequeue_options,
        message_properties  => l_message_properties,
        payload             => l_msg,
        msgid               => l_msgid
      );
      l_tt := l_msg.accessChar();
      --
      logger.trace('%s: из очереди изъята операция ''%s''', p, l_tt);
      --
      reset_visa_history_int(l_tt);
      --
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION
    then
      logger.trace('%s: в очереди нет сообщений', p);
      exit;
    end;
    --
    if l_dequeue_options.navigation = dbms_aq.first_message
    then
        l_dequeue_options.navigation := dbms_aq.next_message;
    end if;
    --
  end loop;
  --
  logger.trace('%s: finish', p);
  --
end proc_reset_visa_queue;

/**
 * enqueue_reset_visa - вставляет код операции TT в очередь на сброс истории визирования
 */
procedure enqueue_reset_visa(p_tt in tts.tt%type)
is
  l_enqueue_options         dbms_aq.enqueue_options_t;
  l_message_properties      dbms_aq.message_properties_t;
  l_msg                    sys.anydata := sys.anydata.convertChar(p_tt);
  l_msgid            raw(16);
begin
  l_message_properties.sender_id := sys.aq$_agent ('QOWNER', null, null);
  dbms_aq.enqueue(
    queue_name          => 'qowner.reset_visa_queue',
    enqueue_options     => l_enqueue_options,
    message_properties  => l_message_properties,
    payload             => l_msg,
    msgid               => l_msgid
  );
  --
  logger.info('Операция '''||p_tt||''' помещена в очередь для сброса истории виз');
  --
end enqueue_reset_visa;


/**
 * back_last_visa - откатывает последнюю визу
 * @param p_ref in - референс документа
 * @param p_reasonid in - код причины отката визы
 */
procedure back_last_visa(p_ref in oper.ref%type, p_reasonid in oper_visa.passive_reasonid%type default null) is
begin
    update oper set chk=substr(chk, 1, length(rtrim(chk))-6) where ref=p_ref;
    update oper_visa set passive=1, passive_reasonid=p_reasonid
    where sqnc=(select max(sqnc) from oper_visa where ref=p_ref);
    update ref_que set otm=1 WHERE ref=p_ref;
exception
   when no_data_found then
   bars_error.raise_nerror(MODCODE, 'UNHANDLED_NO_DATA_FOUND', '$PROC', 'back_last_visa');
end back_last_visa;

----
-- get_next_visa_branches - возвращает список бранчей для следующей визы
--
function get_next_visa_branches return oper.next_visa_branches%type
is
    l_cheque_flag            varchar2(1);
    l_next_visa_branches        oper.next_visa_branches%type;
begin
    -- если последующих виз не будет, обнуляем список бранчей следующих виз
    if chk.doc.nextvisagrp = '!!'
    then
        l_next_visa_branches := null;
        return l_next_visa_branches;
    end if;
    -- следующая виза кассира или сховище ?
    if instr(g_cashvl, chk.doc.nextvisagrp)>0
    then
        -- получим признак операции с чеками
        select substr(flags,62,1)
          into l_cheque_flag
          from tts
         where tt = chk.doc.tt;
        --
        if l_cheque_flag = '1'
        then
            -- для чековых операций смотрим на бранч счета-Б
            begin
                select branch||','
                  into l_next_visa_branches
                  from accounts
                 where nls = chk.doc.nlsb
                   and kv = chk.doc.kv;
            exception
                when no_data_found then
                    raise_application_error(-20000, 'Не знайдено рахунок '||chk.doc.nlsb||'('||chk.doc.kv||')');
            end;
        else
            -- для кассовых операций смотрим на бранчи кассовых счетов в проводках
            select substr( max( sys_connect_by_path(branch, ',') ) || ',' , 2 )
              into l_next_visa_branches
              from ( select rownum rn, branch
                       from ( select unique a.branch
                                from opldok p, accounts a
                               where p.ref = chk.doc.ref
                                 and p.acc = a.acc
                                 and a.nbs in ('1001','1002','1004','1005','1101','1102'
                                              ,'9810','9812','9819','9820','9821','9830','9831'
                                              ,'9890','9891','9892','9893','9898','9899')
                            )
                   )
            connect by prior rn+1=rn
              start with rn=1;
            --
            if l_next_visa_branches is null
            then
                -- если виза кассира первая, то бухмодели в opldok пока нету,
                -- опираемся на oper, предполагая, что проводка плоская
                --
                select substr( max( sys_connect_by_path(branch, ',') ) || ',' , 2 )
                  into l_next_visa_branches
                  from ( select rownum rn, branch
                           from ( select branch
                                    from accounts
                                   where nls = chk.doc.nlsa
                                     and kv = chk.doc.kv
                                     and nbs in ('1001','1002','1004','1005','1101','1102'
                                                ,'9810','9812','9819','9820','9821','9830','9831'
                                                ,'9890','9891','9892','9893','9898','9899')
                                   union all
                                  select branch
                                    from accounts
                                   where nls = chk.doc.nlsb
                                     and kv = chk.doc.kv
                                     and nbs in ('1001','1002','1004','1005','1101','1102'
                                                ,'9810','9812','9819','9820','9821','9830','9831'
                                                ,'9890','9891','9892','9893','9898','9899')
                                )
                       )
                connect by prior rn+1=rn
                  start with rn=1;
            end if;
            --
        end if;
    else
        l_next_visa_branches := null;
    end if;
    --
    return l_next_visa_branches;
    --
end get_next_visa_branches;


BEGIN

  chk.param;

END chk;
/

show err;

PROMPT *** Create  grants  CHK ***

grant EXECUTE on CHK to ABS_ADMIN;
grant EXECUTE on CHK to BARS009;
grant EXECUTE on CHK to BARS010;
grant EXECUTE on CHK to BARS014;
grant EXECUTE on CHK to BARSAQ with grant option;
grant EXECUTE on CHK to BARS_ACCESS_DEFROLE;
grant EXECUTE on CHK to CHCK;
grant EXECUTE on CHK to JBOSS_USR;
grant EXECUTE on CHK to OPER000;
grant EXECUTE on CHK to OPERKKK;
grant EXECUTE on CHK to OW;
grant EXECUTE on CHK to PYOD001;
grant EXECUTE on CHK to START1;
grant EXECUTE on CHK to TOSS;
grant EXECUTE on CHK to WR_ALL_RIGHTS;
grant EXECUTE on CHK to WR_CHCKINNR_ALL;
grant EXECUTE on CHK to WR_CHCKINNR_CASH;
grant EXECUTE on CHK to WR_CHCKINNR_SELF;
grant EXECUTE on CHK to WR_CHCKINNR_SUBTOBO;
grant EXECUTE on CHK to WR_CHCKINNR_TOBO;
grant EXECUTE on CHK to WR_DOCVIEW;
grant EXECUTE on CHK to WR_DOC_INPUT;
grant EXECUTE on CHK to WR_IMPEXP;
grant EXECUTE on CHK to WR_VERIFDOC;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/chk.sql =========*** End *** =======
PROMPT ===================================================================================== 
