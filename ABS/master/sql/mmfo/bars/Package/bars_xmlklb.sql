
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_xmlklb.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE package BARS.bars_xmlklb  is

--***************************************************************--
--                         XML - gate
--                        Казначейство, Сбербанк
--***************************************************************--

  g_awk_header_defs constant varchar2(512) := ''
          ||'SBR - Сбербанк' || chr(10)
          ||'MKF - Мультифилиальная версия'
  ;


  -----------------------------------------------------------------
  --
  --    Константы
  --
  -----------------------------------------------------------------

  G_HEADER_VERSION  constant varchar2(64) := 'version 8.2 12.04.2011';
  G_ERR_SYS         constant number(1)    := 1;   -- сиситемная ошибка
  G_ERR_APP         constant number(1)    := 0;   -- прикладная ошибка

  ----------------------------------------------
  --  переменные
  ----------------------------------------------
  G_DOC_REF      number;


  -- переменн?е для валидации доп. реквизитов
  G_TAG     varchar2(5);
  G_VAL     operw.value%type;
  G_S       oper.s%type;
  G_S2      oper.s2%type;
  G_KVA     oper.kv%type;
  G_KVB     oper.kv2%type;
  G_NLSA    oper.nlsa%type;
  G_NLSB    oper.nlsb%type;
  G_MFOA    oper.mfoa%type;
  G_MFOB    oper.mfob%type;
  G_TT      oper.tt%type;

  -----------------------------------------------------------------
  --
  --    Типы
  --
  -----------------------------------------------------------------

  -- тип заголовка входящего пакета
  type t_header   is record
      (  pack_name  xml_gate.pnam%type,         -- имя пакета (файла)
         pack_date  date,                       -- дата, когда сообщение было сформировано
         mess       xml_messtypes.message%type,  -- код сообщения
         sender     customer.sab%type,          -- идентификатор отправителя
         receiver   customer.sab%type,          -- идентификатор получателя
         doccnt     number                      -- кол-во документов в пакете
      );


  -- тип заголовка исходящего пакета
  type t_rplheader   is record
      (  pack_name  xml_gate.pnam%type,         -- имя пакета (файла)                         MessageID
         mess       xml_messtypes.message%type, -- код сообщения (RCPT)                       MessageType
         pack_date  date,                       -- дата, когда сообщение было сформировано    MessageTimestamp
         sender     customer.sab%type,          -- идентификатор отправителя                  SenderID
         receiver   customer.sab%type,          -- идентификатор получателя                   ReceiverID
         rqv_mess   xml_messtypes.message%type, -- на какой тип сообщения ответ               TType
         rqv_pack   xml_gate.pnam%type,         -- имя пакета з запросом на котор?й отвечаем  MsgID
         rqv_date   date                        -- дада пакета с запросом                     MsgTimestamp
      );



    -- структура входящего пакета
  type t_pack   is record
      (  hdr      t_header,              -- заголдовок
         cbody    clob                   -- нода содержащая body (в свою очередь body содержит список док-тов)
      );



   -- описание спаремтров сервисов
   type t_service  is record
     ( name          xml_servlist.snam%type,  -- наименование сервиса
       param1        varchar2(100),      -- параметр 1
       param2        varchar2(100),      -- параметр 2
       param3        varchar2(100),      -- параметр 3
       param4        varchar2(100)       -- параметр 4
     );



   -- список доп. реквизитов для документа
   type type_drec  is record
     ( tag operw.tag%type,
       val operw.value%type
     );
   type array_drec is table of type_drec index by binary_integer;




   -- список аттрибутов, ключ - аттрибут, значение - значение аттрибута
   type t_attrs is table of varchar2(1000) index by varchar2(50);

   -- тип тега со списком аттрибутов
   type t_tag is record
   (  attrs   t_attrs,     -- список аттрибутов со значениями
      tagval  varchar2(1000)  -- значение тега
   );

   -- список тегов с аттрибутами, ключ - наименование тега
   type t_taglist is table of t_tag  index by varchar2(50);


   -----------------------------------------------------------------
   --    IN_GATE()
   --
   --    Перврначальная Обработка документа (9 параметров - с подписью)
   --    Процедура оплачивает документ.
   --    Отдает список референсов в переменную p_refdoc и буффера для подписи
   --    p_buf_win  (последовательно для всех референсов по 444)  -
   --    для того, что б подписать в jbosse, а затем вызвать in_sep
   --    и вставить эту подпись в oper.
   --    Отдает тело для квитанции p_reply
   --
   --    p_packname    - имя файла
   --    p_gateid      - уникальный номер в xml_gate
   --    p_refdoc      - документ со списком референсов из докумнета
   --    p_seckey      - ключ для подписи
   --    p_buf_win     - буффера для подписи (последовательно для всех референсов по 444)
   --    p_partcnt     - кол-во партиций
   --    p_indoc       - тело входящего пакета
   --    p_reply       - тело исходящего пакета (квитанции)
   --    p_rpackname   - исходящее имя файла
   --
   procedure in_gate (
                  p_packname                 varchar2,
                  p_gateid        out        number,
                  p_refdoc        out nocopy clob,
                  p_seckey                   varchar2,
                  p_buf_win       out nocopy blob,
                  p_partcnt       out        number,
                  p_indoc                    clob,
                  p_reply         out nocopy clob,
                  p_rpackname     out        varchar2);



   -----------------------------------------------------------------
   --    IN_GATE()
   --
   --    Перврначальная Обработка документа (7 параметров - без подписи)
   --
   --    p_packname  -  имя файла
   --    p_indoc     -  входящий clob документа
   --    p_reply     -  clob с ответом
   --    p_gateid    -  номер в xml_gate
   --    p_partcnt   -  общеее кол-во партиций
   --    p_rpackname -  имя квитанции
   --
   procedure in_gate (
                  p_packname             varchar2,
                  p_gateid    out        number,
                  p_partcnt   out        number,
                  p_indoc                clob,
                  p_reply     out nocopy clob,
                  p_rpackname out        varchar2 );




   -----------------------------------------------------------------
   --    IN_GATE()
   --
   --    Перврначальная Обработка документа (3 параметра - без поддержки партиций)
   --
   --    p_packname  -  имя файла
   --    p_indoc     -  входящий clob документа
   --    p_reply     -  clob с ответом
   --
   procedure in_gate (
                  p_packname             varchar2,
                  p_indoc                clob,
                  p_reply     out nocopy clob);




   -----------------------------------------------------------------
   --    GETSIGNLIST()
   --
   --    Отдает последовательность виз, кот. нужно проверить
   --
   --
   --
   function getsignlist(
                     p_pack_name varchar2) return varchar2;





   -----------------------------------------------------------------
   --    IN_SEP()
   --
   --    Вызывается из jboss после вызова in_gate.
   --    Процедура делает вставку подписей и имен файлов для
   --    платежа с p_ref
   --
   --      p_ref           - референс
   --      p_seckey        - ключ подписи
   --      p_bufnum        - номер буфера
   --      p_doc_count     - кол-во документов
   --      p_buf           - буфер подписи
   --      p_bsign         - подпись
   --      p_filename      - имя файла


  procedure in_sep( p_ref        number,
                    p_seckey     varchar2,
                    p_bufnum     number,
                    p_doc_count  number,
                    p_buf        in blob,
                    p_bsign      raw,
                    p_filename   varchar2);








  -----------------------------------------------------------------
  --    SAVE_BAD_PACKET
  --
  --    При неуспешной обработке пакета
  --    (неуспешная раскриптовака, снятие подписи на всем пакете)
  --    - оставляем информацию об этом пакете и квитанции
  --
  --
  --    p_pack_name  - имя пакета
  --    p_pack_xml   - тело пакета
  --    p_reply_xml  - тело квитанции
  --
  --
   procedure save_bad_packet(
                   p_pack_nam   varchar2,
                   p_pack_xml   clob,
                   p_reply_xml  clob);




   -----------------------------------------------------------------
   --    PRETEND_BRANCH()
   --
   --    Предствление пол-зователя как branch
   --
   --
   procedure pretend_branch(
                  p_sab varchar2);



   ----------------------------------------------------------------
   --    EXEC_SERVICE
   --
   --    Выполнение процедуры и открытие курсора для сервиса
   --
   --    p_service    - структура параметров сервиса
   --    p_cur        - курсор
   --

   procedure exec_service(
                  p_service          t_service,
                     p_cur       in out sys_refcursor);



   -----------------------------------------------------------------
   --    GET_REPLY_PARTITION
   --
   --    Вычитывает указанную партицию из всех партиций ответа
   --
   --    p_gateid
   --    p_partid   - указанный номер партиции для чтения
   --    p_reply
   --
   PROCEDURE get_reply_partition (
                   p_gateid     number,
                   p_partid     number,
                   p_reply  out nocopy clob);



   ------------------------------------------------------
   --   CREATE_REPLY_PARTTITIONS()
   --
   --   По входящему курсору, гененирует куски ответа с заголовками
   --   указанным размером и момещает их в  xml_gate_receipt
   --
   --   p_gateid          - id записи в xml_gate
   --   p_partcnt         - общее кол-во партиций
   --   p_service         - имя сервиса, его параметры
   --   p_rplhdr          - структура заголовка для ответа
   --   p_cur             - кусор с данными ответа
   --

   procedure create_reply_partitions(
                   p_gateid         number,
                   p_partcnt    out number,
                   p_service        t_service,
                   p_cur            sys_refcursor,
                   p_rplhdr         t_rplheader);



   -----------------------------------------------------------------
   --   RPLHEADER_TOSTRING
   --
   --   Представить структуру заголовка ответа в виде строки
   --
   function rplheader_tostring(
                   p_rplhdr  t_rplheader) return varchar2 ;




   -----------------------------------------------------------------
   --    GET_VPTYPE()
   --
   --    Получить тип выписки. Функа использ. для проставления типа
   --    выписки в заголовке
   --    в ответ 1 - заключительная
   --            0 - текущая
   --
   function get_vptype(p_vpdate  date) return varchar2;


   -----------------------------------------------------------------
   --    CONVERT_TO_DATE()
   --
   --    Проверяет строку на валидность формата даты
   --
   --
   function convert_to_date(
                  p_strdate varchar2,
                  p_tag     varchar2) return date;



   -----------------------------------------------------------------
   --    CONVERT_TO_NUMBER()
   --
   --    Конвертит строку в число  соответсвующим exept
   --
   --
   function convert_to_number(
                  p_str varchar2,
                  p_tag varchar2) return number;



   ------------------------------------------------------
   --   CREATE_REPLY()
   --
   --   Создание квитанции
   --   С указанием ErrorCode и ErrorDetail
   --
   --   p_errcode     - код ошибки  (сообщение тянем из err_klb.err)
   --   p_errdetail   - описание ошибки
   --   p_clbref      - реф кл-банка
   --   p_doc         - исходящий док-т ответа
   --
   procedure create_reply (
                   p_errcode          varchar2,
                   p_errdetail        varchar2,
                   p_clbref           number,
                   p_doc       in out dbms_xmldom.DOMDocument);


   ------------------------------------------------------
   --   CREATE_REPLY()
   --
   --   Создание квитанции
   --   С указанием ErrorCode и ErrorDetail
   --
   --   p_errcode     - код ошибки  (сообщение тянем из err_klb.err)
   --   p_errdetail   - описание ошибки
   --   p_clbref      - реф кл-банка
   --   p_refnode     - нода вставленного ответа для док-та <MsgErrorCode/>...<MsgErrorCode>
   --   p_doc         - исходящий док-т ответа
   --
   --
   procedure  create_reply (
                   p_errcode            varchar2,
                   p_errdetail          varchar2,
                   p_clbref           number,
                   p_refnode        out dbms_xmldom.DOMNode,
                   p_doc         in out dbms_xmldom.DOMDocument);


   -----------------------------------------------------------------
   --    GET_ERROR_TYPE
   --
   --    По sqlerrm - определить - это системная или прикладная ошибка
   --    return 1 - sys error
   --           0 - app error
   --
   function  get_error_type return number;


   -----------------------------------------------------------------
   --    GET_PROCESS_ERROR()
   --
   --    По ошибке понять - она системана или нет - и отдать соответсвущий
   --    код и сообщение об ошибке для квитанции
   --
   --
   procedure get_process_error
                 (p_sqlerrm           varchar2,
                  p_errcode      out  varchar2,
                  p_errmsg       out  varchar2);


   -----------------------------------------------------------------
   --    CREATE_DOCUMENT_REPLY()
   --
   --    Формирование ответа для типа сообщения документа по DOM документу в
   --    котором содержатся коды обработки пакета. Сдесь формируется заголовок.
   --
   --    p_bodydoc  - док-т содержащий ответы для всех докумнетов в пакете
   --    p_hdr      - структура входящего заголовка
   --    p_reply    - исходящий ответ
   --
   procedure create_document_reply(
                  p_bodydoc     dbms_xmldom.DOMDocument,
                  p_hdr         t_header,
                  p_reply   out clob);


   -----------------------------------------------------------------
   --    PARSE_CLOB()
   --
   --    Парсит клоб и возвразает докумнет
   --
   --
   function parse_clob(p_inclob clob) return dbms_xmldom.DOMDocument;



   ------------------------------------------------------
   --   SAVE_REPLY()
   --
   --   Сохранение части(партиции) квитанции после того, как сформирован
   --   ответ.
   --
   --   p_gateid       - уникальный номер в xml_gate
   --   p_partid       - номер партиции
   --   p_reply        - тело партиции
   --
   procedure save_reply(
                   p_gateid    number,
                   p_partid    number,
                   p_reply     clob);



   -----------------------------------------------------------------
   --   SET_HEADER_VALUES
   --
   --   Внести значения для заголовка.
   --   Для сервиса так же внести значения дополнительных аттрибутов
   --
   --   p_replschem  -  схема ответа
   --   p_hdr        -  структура заголовка ответа
   --   p_service    - значения параметров для сервиса, для того, что б добавить доп. теги в header
   --   p_hdraddtags - явно указанные теги с аттрибутами для доп. тегов  в header
   --
   procedure set_header_values(
                  p_reply  in out clob,
                  p_hdr           t_rplheader,
                  p_service       t_service,
                  p_hdraddtags    t_taglist);


   -----------------------------------------------------------------
   --   SET_HEADER_VALUES
   --
   --   Внести значения для заголовка.
   --   Для сервиса так же внести значения дополнительных аттрибутов
   --
   --   p_replschem  -  схема ответа
   --   p_hdr        -  структура заголовка ответа
   --
   procedure set_header_values(
                  p_reply  in out clob,
                  p_hdr           t_rplheader,
                  p_service       t_service default null);





   -----------------------------------------------------------------
   --    ADD_BODY_TO_REPLY
   --
   --    Добавить тег Body в схему док-та для ответа
   --
   --    p_body   -  клоб тега <Body>
   --    p_reply  -  клоб схемы док-та для ответа - сюда же будем добавлять
   --
   procedure add_body_to_reply(
                  p_body             clob,
                  p_reply    in out  clob );



   ------------------------------------------------------
   --   SET_ATTR_VALUE()
   --
   --   Установить значение атрибута
   --
   --   p_xmlclob  - док-т
   --   p_path     - xptah для ноды в кот. будем вставлять (наприм //Header/MessageID)
   --   p_attname  - имя аттриб
   --   p_attval   - значение аттриб.
   --
   procedure set_attr_value(
                   p_xmlclob  in out clob,
                   p_path            varchar2,
                   p_attname         varchar2,
                   p_attval          varchar2);



   -----------------------------------------------------------------
   --   SET_TAG_VALUE
   --
   --   Установить значение для тега по переданной ноде из документа
   --   наприм ( //header/TagName)
   --
   --   p_doc    - документ
   --   p_targnd - нода, где создаем тег и делаем вставку значения ( //header)
   --   p_tag    - тег для установки значения. Если данного тега нету, он создается
   --   p_val    - знячение для установки
   --
   procedure set_tag_value(
                  p_doc    in out dbms_xmldom.DOMDocument,
                  p_ndtarg in out dbms_xmldom.DOMNode,
                  p_tag           varchar2,
                  p_val           varchar2);


   -----------------------------------------------------------------
   --   SET_TAG_VALUE
   --
   --   Установить значение для тега по передвнноve пути
   --   наприм ( //header/TagName)
   --
   --   p_doc    - документ
   --   p_path   - путь ( //header)
   --   p_tag    - тег для установки значения. Если данного тега нету, он создается
   --   p_val    - знячение для установки
   --
   procedure set_tag_value(
                  p_doc   in out dbms_xmldom.DOMDocument,
                  p_path         varchar2,
                  p_tag          varchar2,
                  p_val          varchar2);


   ------------------------------------------------------
   --   SET_PARTITION_ATTRS()
   --
   --   Установить аттрибуты партиции для данного клоба
   --
   --   p_reply        - клоб отета, куда нужно вставить параметры партиции
   --   p_partcnt      - общее кол-во партиций
   --   p_partcur      - текущая партиция
   --
   procedure set_partition_attrs(
                  p_reply      in out clob,
                  p_partcnt           number,
                  p_partcur           number);



   -----------------------------------------------------------------
   --    INIT_DOC_FIELDS()
   --
   --    Инициализировать поля документа
   --
   --    p_docnd    - нода одного документа <PMNT>
   --    p_messtype
   --    p_doc
   --
   --
   procedure init_doc_fields(
                  p_docnd           dbms_xmldom.DOMNode,
                  p_messtype        varchar2,
                  p_seckey          varchar2,
                  p_doc      in out oper%rowtype);


   -----------------------------------------------------------------
   --    PRINT_DOC
   --
   --    Представить документ в текстовом виде
   --
   --    p_doc
   --
   function print_doc(p_doc   oper%rowtype) return varchar2;



   -----------------------------------------------------------------
   --    GET_DOC_ATTRIBS
   --
   --    Получить доп реквизиты документа из ноды документа
   --
   --    p_docnd     - нода док-та
   --    p_path      - путь к списку доп. реквизитов
   --    p_dreclst   - список доп реквизитов
   --
   --
   procedure get_doc_attribs (
                  p_docnd            dbms_xmldom.DOMNode,
                  p_path             varchar2,
                  p_dreclist  in out array_drec);

   -----------------------------------------------------------------
   --    PARSE_BODY
   --
   --    Инициализировать клоб тега <Body>
   --
   --    p_indoc       - клоб входящего пакета
   --    p_hdr         - структура заголовка
   --
   procedure parse_body(
                  p_indoc            clob,
                  p_cbody     in out clob);


   -----------------------------------------------------------------
   --    PARSE_HEADER
   --
   --    Инициализировать структуру заголовка из кллоба входящего пакета
   --
   --    p_packname    - имя файла
   --    p_indoc       - клоб входящего пакета
   --    p_hdr         - структура заголовка
   --
   procedure parse_header(
                  p_packname         varchar2,
                  p_indoc            clob,
                  p_hdr       in out t_header);

   -----------------------------------------------------------------
   --    RESET_BANKDATE
   --
   --    Переустнаовка глобальной банковской даты.
   --    Переустановка учитывает представление текущего пользователя.
   --
   --    Перед вызовом данной процедуры, должно быть выполнено представление
   --    соответсующим отделением.
   --
   --
   procedure reset_bankdate;




   -----------------------------------------------------------------
   --    VALIDATE_ATTRIBS()
   --
   --    Валидация доп. реквизиов
   --
   --
   procedure validate_attribs(
                  p_dreclist array_drec,
                  p_s     number,
                  p_s2    number,
                  p_kv    number,
                  p_kv2   number,
                  p_nlsa  oper.nlsa%type,
                  p_nlsb  oper.nlsb%type,
                  p_mfoa  oper.mfoa%type,
                  p_mfob  oper.mfob%type,
                  p_tt    oper.tt%type);


   -----------------------------------------------------------------
   --    APPLY_ATTRIBS_TO_DOC
   --
   --    Применить доп реквизиты к документу
   --
   --    p_docnd     - нода док-та
   --    p_path      - путь к списку доп. реквизитов
   --    p_dreclst   - список доп реквизитов
   --
   --
   procedure apply_attribs_to_doc (
                  p_doc      in out oper%rowtype,
                  p_dreclist        array_drec);




   -----------------------------------------------------------------
   --    IN_GATE2()
   --
   --    Просто тестовая функция
   --
   procedure in_gate2 (
                  p_packname             varchar2,
                  p_indoc                clob);


   ------------------------------------------------------
   --   CREATE_REPLY()
   --
   --   Создание квитанции
   --   С указанием ErrorCode и ErrorDetail
   --
   --   p_errcode     - код ошибки  (сообщение тянем из err_klb.err)
   --   p_errdetail   - описание ошибки
   --   p_clbref      - реф кл-банка
   --   p_brsref      - реф БАРС-а
   --   p_doc         - исходящий док-т ответа
   --
   --
   procedure  create_reply (
                   p_errcode            varchar2,
                   p_errdetail          varchar2,
                   p_clbref             number,
                   p_brsref             number,
                   p_doc         in out dbms_xmldom.DOMDocument);


   -----------------------------------------------------------------
   --    FREE_XML_GATE()
   --
   --    Удаление данных из накопительной таблицы входящих пакетов
   --    p_date - до какой даты (включительно) удалять данные
   --             смотрим по дате обработки файла xml_gate.datp
   --
   procedure free_xml_gate( p_date date);




   -----------------------------------------------------------------
   --    VALIDATE_TTS_PATTERN
   --
   --    Проверка на совпадение счета в плетже, с шаблоном ввода
   --    счета для операции док-та
   --
   --    p_doc
   --
   --
   procedure validate_tts_pattern(p_doc  oper%rowtype);


END;
/
CREATE OR REPLACE package body BARS.bars_xmlklb is

   ---------------------------------------------------------
   --
   --  Пакет обработки платежных сообщений клиент-банка
   --
   --  DMSU - Для держ. митн. служби
   --  KAZ  - Казначейсво
   --  SBR  - Сбербанк
   --  MKF  - мультиф. схема (Сбербанк)
   --
   ---------------------------------------------------------

   g_awk_body_defs constant varchar2(512) := ''
          ||'SBR - Сбербанк'    || chr(10)
          ||'MKF - Мультифилиальная версия'
  ;

   ----------------------------------------------
   --  константы
   ----------------------------------------------

   G_BODY_VERSION    constant varchar2(64) := 'version 10.5 20.06.2017';
   G_SIGN_BUFF_SIZE  constant number(3)    := 444;      -- размер буффера для подписи
   G_MODULE          constant char(3)      := 'KLB';    -- код модуля
   G_TRACE           constant varchar2(10) := 'xmlklb.';
   G_REPLY_PRFX      constant char(1)      := 'S';      -- префикс файла ответа


   G_EXTERN_DOC      constant smallint     := 1;        -- документ внешний(импортируемый з др. системы)
   G_INNER_DOC       constant smallint     := 0;        -- наш внутренний документ, передаваемый систеой



   --константы для того случая когда квитовка идет не по платежам а по файлу
   G_PACK_PROCESS_STATUS_OK       constant smallint     := 0; --все док-ты пакета обработаны
   G_PACK_PROCESS_STATUS_FAILED   constant smallint     := 1; --некоторые док-ты из пакета не оплачены


   ----------------------------------------------
   --  Переменные
   ----------------------------------------------

   G_PACK_STATUS     smallint;                   --переменная означает статус обработки пакета
   G_REPLY_PACKNAME  varchar2(30);
   G_DOC_TYPE        smallint;                   --тип документа (1-внешний через импорт, 0-внутренний)

   ----------------------------------------------
   --  типы
   ----------------------------------------------

   type t_cursor_rec is record(m_cursor integer,m_stmt varchar2(32767));
   type t_cursor_tab is table of t_cursor_rec index by varchar2(5);
   type t_docdrec_list is table of smallint index by varchar2(5);  --xml_docdrec.tag%type;

   g_cursor_tab    t_cursor_tab;
   g_docdrec_list  t_docdrec_list;

   -- таблица непечатных символов
   G_x00_x1F constant varchar2(32)   := chr(00)||chr(01)||chr(02)||chr(03)||chr(04)||chr(05)||chr(06)||chr(07)||chr(08)||chr(09)||chr(10)||
                                        chr(11)||chr(12)||chr(13)||chr(14)||chr(15)||chr(16)||chr(17)||chr(18)||chr(19)||chr(20)||chr(21)||
					chr(22)||chr(23)||chr(24)||chr(25)||chr(26)||chr(27)||chr(28)||chr(29)||chr(30)||chr(31);

   -----------------------------------------------------------------
   --   FORMAT_DATE
   --
   --   Отдать отформатир. дату
   --
   --
   function format_date(
                  p_date  date)
   return varchar2
   is
   begin
      if p_date is not null then
         return to_char(p_date,'yyyy-mm-dd"T"hh24:mi:ss".000"')||sessiontimezone;
      else
         return  '';
      end if;
   end;



   -----------------------------------------------------------------
   --    GET_REPLY_PACKNAME()
   --
   --    Получить имя исходящего пакета по имени входящего пакета
   --
   function get_reply_packname(
                  p_inpackname  varchar2) return varchar2
   is
   begin
      return  G_REPLY_PRFX||substr(p_inpackname,2);
   end;




   -----------------------------------------------------------------
   --    GET_VPTYPE()
   --
   --    Получить тип выписки. Функа использ. для проставления типа
   --    выписки в заголовке
   --    в ответ 1 - заключительная
   --            0 - текущая
   --
   function get_vptype(p_vpdate  date) return varchar2
   is
      l_rrpday char(1);
   begin

      begin
         select substr(val,1,1) into l_rrpday
         from params where par='RRPDAY';
      exception when no_data_found then
         bars_error.raise_error(G_MODULE,43, '');
      end;

      if (p_vpdate = gl.bd() and l_rrpday = '1') then
         return 0;
      else
         return 1 ;
      end if;
   end;





   -----------------------------------------------------------------
   --    PARSE_CLOB()
   --
   --    Парсит клоб и возвразает докумнет
   --
   --
   function parse_clob(p_inclob clob)  return dbms_xmldom.DOMDocument
   is
      l_parser     dbms_xmlparser.Parser;
      l_doc        dbms_xmldom.DOMDocument;
      l_trace      varchar2(1000):=G_TRACE||'parse_clob: ';
   begin


      l_parser   := dbms_xmlparser.newParser;
                    dbms_xmlparser.parseClob(l_parser, p_inclob);
      l_doc      := dbms_xmlparser.getDocument(l_parser);
                    dbms_xmlparser.freeParser(l_parser);
      return l_doc;
   exception when others then
       dbms_xmlparser.freeParser(l_parser);
       bars_audit.error(l_trace||'ошибка парсинга докумнета: '||sqlerrm);
       raise;
   end;




   -----------------------------------------------------------------
   --    INIT_REPLY_HEADER()
   --
   --    Инициализирует структуру заголовка квитанции
   --    по заголовку входящего пакета
   --
   procedure init_reply_header(
                  p_hdr            t_header,
                  p_rplhdr  in out t_rplheader)
   is
      l_trace     varchar2(1000):=G_TRACE||'init_reply_header: ';
   begin

      p_rplhdr.pack_name := get_reply_packname(p_hdr.pack_name);
      G_REPLY_PACKNAME   := p_rplhdr.pack_name;

      p_rplhdr.mess      := 'RCPT';
      p_rplhdr.pack_date := sysdate;
      p_rplhdr.sender    := p_hdr.receiver;
      p_rplhdr.receiver  := p_hdr.sender;
      p_rplhdr.rqv_mess  := p_hdr.mess;
      p_rplhdr.rqv_pack  := p_hdr.pack_name;
      p_rplhdr.rqv_date  := p_hdr.pack_date;

   exception when others then
      bars_audit.error(l_trace||'Ошибка инициализации заголовка для квитанции');
   end;






   -----------------------------------------------------------------
   --   SET_TAG_VALUE
   --
   --   Установить значение для тега по переданной ноде из документа
   --   наприм ( //header/TagName)
   --
   --   p_doc    - документ
   --   p_targnd - нода, где создаем тег и делаем вставку значения ( //header)
   --   p_tag    - тег для установки значения. Если данного тега нету, он создается
   --   p_val    - знячение для установки
   --
   procedure set_tag_value(
                  p_doc    in out dbms_xmldom.DOMDocument,
                  p_ndtarg in out dbms_xmldom.DOMNode,
                  p_tag           varchar2,
                  p_val           varchar2)
   is
      l_trace  varchar2(1000):=G_TRACE||'set_tag_value: ';
      l_nddoc  dbms_xmldom.DOMNode;
      l_ndtxt  dbms_xmldom.DOMText;
      l_nd     dbms_xmldom.DOMNode;
      l_ndtag  dbms_xmldom.DOMNode;
   begin
      l_nddoc := dbms_xmldom.makeNode(p_doc);
      l_nd    := dbms_xslprocessor.selectSingleNode(p_ndtarg, '/'||p_tag||'/text()');

      if dbms_xmldom.isnull(l_nd) then
         l_ndtag := dbms_xslprocessor.selectSingleNode(p_ndtarg, '/'||p_tag);

         if dbms_xmldom.isnull(l_ndtag) then
             l_ndtag   := dbms_xmldom.makeNode( dbms_xmldom.createElement(p_doc, p_tag) );
             l_ndtag   := dbms_xmldom.appendChild(p_ndtarg, l_ndtag);
         end if;

         l_ndtxt := dbms_xmldom.createTextNode(p_doc, p_val);
         l_ndtag := dbms_xmldom.appendChild(l_ndtag, dbms_xmldom.makeNode(l_ndtxt));
      else
         dbms_xmldom.setNodeValue(p_ndtarg, p_val);
      end if;

   exception when others then
      bars_audit.error(l_trace||'Ошибка установки значения в ноду значения '||p_tag);
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --   SET_TAG_VALUE
   --
   --   Установить значение для тега по передвнноve пути
   --   наприм ( //header/TagName)
   --
   --   p_doc    - документ
   --   p_path   - путь ( //header)
   --   p_tag    - тег для установки значения. Если данного тега нету, он создается
   --   p_val    - знячение для установки
   --
   procedure set_tag_value(
                  p_doc   in out dbms_xmldom.DOMDocument,
                  p_path         varchar2,
                  p_tag          varchar2,
                  p_val          varchar2)
   is
      l_nd        dbms_xmldom.DOMNode;
      l_nddoc     dbms_xmldom.DOMNode;
   begin

      l_nddoc := dbms_xmldom.makeNode(p_doc);
      l_nd    := dbms_xslprocessor.selectSingleNode(l_nddoc, p_path);
      set_tag_value(
                  p_doc     => p_doc,
                  p_ndtarg  => l_nd,
                  p_tag     => p_tag,
                  p_val     => p_val);
   end;




   ------------------------------------------------------
   --   SET_ATTR_VALUE()
   --
   --   Установить значение атрибута
   --
   --   p_doc      - док-т (если аттриб. прийдется добавлять в структуру)
   --   p_path     - xptah для ноды в кот. будем вставлять (наприм //Header/MessageID)
   --   p_attname  - имя аттриб
   --   p_attval   - значение аттриб.
   --
   procedure set_attr_value(
                   p_doc      in out dbms_xmldom.DOMDocument,
                   p_path            varchar2,
                   p_attname         varchar2,
                   p_attval          varchar2)
   is
      l_nd       dbms_xmldom.DOMNode;
      l_ndattr   dbms_xmldom.DOMNode;
      l_ndtag    dbms_xmldom.DOMNode;
      l_attr     dbms_xmldom.DOMattr;
      l_trace    varchar2(1000) := G_TRACE||'set_attr_value: ';
   begin

      l_nd     := dbms_xmldom.makeNode(p_doc);
      l_ndattr := dbms_xslprocessor.selectSingleNode(l_nd, p_path||'/@'||p_attname);

      if dbms_xmldom.isnull(l_ndattr) then
         l_ndtag  := dbms_xslprocessor.selectSingleNode(l_nd, p_path);
         l_attr   := dbms_xmldom.createAttribute(p_doc,p_attname);
                     dbms_xmldom.setValue(l_attr, p_attval);
         l_attr   := dbms_xmldom.setAttributeNode( dbms_xmldom.makeElement(l_ndtag), l_attr);
      else
         dbms_xmldom.setNodeValue(l_ndattr, p_attval);
      end if;


   exception when others then
      bars_audit.error(l_trace||'ошибка установки аттрибута '||p_attname||': '||sqlerrm);
      raise;
   end;





   ------------------------------------------------------
   --   SET_ATTR_VALUE()
   --
   --   Установить значение атрибута
   --
   --   p_xmlclob  - док-т
   --   p_path     - xptah для ноды в кот. будем вставлять (наприм //Header/MessageID)
   --   p_attname  - имя аттриб
   --   p_attval   - значение аттриб.
   --
   procedure set_attr_value(
                   p_xmlclob  in out clob,
                   p_path            varchar2,
                   p_attname         varchar2,
                   p_attval          varchar2)
   is
      l_doc  dbms_xmldom.DOMDocument;
      l_trace    varchar2(1000) := G_TRACE||'set_attr_value: ';
   begin
      l_doc := parse_clob(p_xmlclob);
      set_attr_value(
            p_doc      => l_doc,
            p_path     => p_path,
            p_attname  => p_attname,
            p_attval   => p_attval);


      dbms_xmldom.writetoclob(l_doc,  p_xmlclob);
      dbms_xmldom.freedocument(l_doc);

   exception when others then
      bars_audit.error(l_trace||'ошибка установки аттрибутов: '||sqlerrm);

      if not dbms_xmldom.isnull(l_doc) then
         dbms_xmldom.freedocument(l_doc);
      end if;
   end;



   -----------------------------------------------------------------
   --   SET_HEADER_TAG_VALUE
   --
   --   Установить значение тега для заголовка + аттрибуты
   --
   --   p_doc  - документ
   --   p_tag  - тег для установки значения
   --   p_val  - знячение для установки
   --   p_attrs- список аттрибутов
   --
   procedure set_header_tag_value(
                  p_doc   in out dbms_xmldom.DOMDocument,
                  p_tag          varchar2,
                  p_val          varchar2,
                  p_attrs        t_attrs)
   is
      l_trace  varchar2(1000):=G_TRACE||'set_header_tag_value: ';
      l_path   varchar2(1000);
      l_nddoc  dbms_xmldom.DOMNode;
      l_ndtxt  dbms_xmldom.DOMText;
      l_nd     dbms_xmldom.DOMNode;
      l_ndtag  dbms_xmldom.DOMNode;
      l_ndhdr  dbms_xmldom.DOMNode;
      l_attr   varchar2(50);
   begin

      l_path  := '//Header/'||p_tag;
      l_nddoc := dbms_xmldom.makeNode(p_doc);
      l_nd    := dbms_xslprocessor.selectSingleNode(l_nddoc, l_path||'/text()');


      if dbms_xmldom.isnull(l_nd) then
         l_ndtag := dbms_xslprocessor.selectSingleNode(l_nddoc, l_path);

         if dbms_xmldom.isnull(l_ndtag) then
             l_ndtag   := dbms_xmldom.makeNode( dbms_xmldom.createElement(p_doc, p_tag) );
             l_ndhdr   := dbms_xslprocessor.selectSingleNode(l_nddoc, '//Header');
             l_ndtag   := dbms_xmldom.appendChild(l_ndhdr, l_ndtag);
         end if;

         l_ndtxt := dbms_xmldom.createTextNode(p_doc, p_val);
         l_nd    := dbms_xmldom.appendChild(l_ndtag, dbms_xmldom.makeNode(l_ndtxt));
      else
         dbms_xmldom.setNodeValue(l_nd, p_val);
      end if;



      begin
         l_attr := p_attrs.first;
         while l_attr is not null loop

              set_attr_value(
                   p_doc     => p_doc,
                   p_path    => l_path,
                   p_attname => l_attr,
                   p_attval  => p_attrs(l_attr));

              l_attr := p_attrs.next(l_attr);
         end loop;
     exception when no_data_found then null;
     end;


   exception when others then
      bars_audit.error(l_trace||'Ошибка установки значения '||p_tag||' в header:'||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --   SET_HEADER_TAG_VALUE
   --
   --   Установить значение тега для заголовка + аттрибуты
   --
   --   p_doc  - документ
   --   p_tag  - тег для установки значения
   --   p_val  - знячение для установки
   --
   procedure set_header_tag_value(
                  p_doc   in out dbms_xmldom.DOMDocument,
                  p_tag          varchar2,
                  p_val          varchar2)
   is
      l_attrs  t_attrs;
   begin
      set_header_tag_value(
                  p_doc    => p_doc,
                  p_tag    => p_tag,
                  p_val    => p_val,
                  p_attrs  => l_attrs);
   end;





   -----------------------------------------------------------------
   --   SET_HEADER_ADDTAGS
   --
   --   Добавить дополнительные теги для сообщения в заголовок по уже
   --   подготовленному списку тегов с аттрибутами
   --
   --   p_doc        -  док-т с заголовком
   --   p_hdrtags -  структура доп. тегов с ихними аттрибутами
   --
   procedure set_header_addtags(
                  p_doc       in out dbms_xmldom.DOMDocument,
                  p_hdrtags   t_taglist)
   is
      l_trace    varchar2(1000):=G_TRACE||'set_header_addtags: ';
      l_tag      varchar2(50);
   begin


    l_tag := p_hdrtags.first;
    while l_tag is not null loop

      set_header_tag_value(
              p_doc   => p_doc,
              p_tag   => l_tag,
              p_val   => p_hdrtags(l_tag).tagval,
              p_attrs => p_hdrtags(l_tag).attrs);
      l_tag := p_hdrtags.next(l_tag);

    end loop;


   end;



   -----------------------------------------------------------------
   --   SET_HEADER_ADDTAGS
   --
   --   Добавить дополнительные теги для сообщения в заголовок по таблице xml_addhdrtags
   --
   --   p_doc     -  док-т с заголовком
   --   p_service -  параметры сервиса
   --
   procedure set_header_addtags(
                  p_doc     in out dbms_xmldom.DOMDocument,
                  p_service        t_service)
   is
      l_tagval   varchar2(1000);
      l_sprc     varchar2(1000);
      l_trace    varchar2(1000):=G_TRACE||'set_header_addtags: ';
   begin

      for c in ( select tag, tagfunc
                 from xml_addhdrtags
                 where message = p_service.name ) loop

          l_sprc:= 'select '||c.tagfunc||' from dual';
          begin
             if    instr(c.tagfunc,':4')>0 then
                execute immediate l_sprc into l_tagval using p_service.param1, p_service.param2, p_service.param3, p_service.param4;
             elsif instr(c.tagfunc,':3')>0 then
                execute immediate l_sprc into l_tagval using p_service.param1, p_service.param2, p_service.param3;
             elsif instr(c.tagfunc,':2')>0 then
                execute immediate l_sprc into l_tagval using p_service.param1, p_service.param2;
             elsif instr(c.tagfunc,':1')>0 then
                execute immediate l_sprc into l_tagval using p_service.param1;
             else
                execute immediate l_sprc;
             end if;
          exception when others then
             bars_error.raise_error(G_MODULE, 51, c.tagfunc, c.tag, sqlerrm);
          end;
          bars_audit.trace(l_trace||'значение доп. реквизита= '||l_tagval);
          set_header_tag_value(
                  p_doc  => p_doc,
                  p_tag  => c.tag,
                  p_val  => l_tagval);

      end loop;

   exception when others then
      raise;
   end;



   -----------------------------------------------------------------
   --   SET_HEADER_VALUES
   --
   --   Внести значения для заголовка.
   --   Для сервиса так же внести значения дополнительных аттрибутов
   --
   --   p_replschem  -  схема ответа
   --   p_hdr        -  структура заголовка ответа
   --   p_service    - значения параметров для сервиса, для того, что б добавить доп. теги в header
   --   p_hdraddtags - явно указанные теги с аттрибутами для доп. тегов  в header
   --
   procedure set_header_values(
                  p_reply  in out clob,
                  p_hdr           t_rplheader,
                  p_service       t_service,
                  p_hdraddtags    t_taglist)
   is

      l_doc        dbms_xmldom.DOMDocument;
      l_clob       clob;
      l_trace      varchar2(1000):=G_TRACE||'set_header_values: ';
      l_tmp        varchar2(1000);
      l_tag        varchar2(50);
   begin

      l_doc   := parse_clob(p_reply);

      set_header_tag_value( l_doc, 'MessageID'       , p_hdr.pack_name);
      set_header_tag_value( l_doc, 'MessageTimestamp', format_date(p_hdr.pack_date));
      set_header_tag_value( l_doc, 'MessageType'     , p_hdr.mess);
      set_header_tag_value( l_doc, 'SenderID'        , p_hdr.sender);
      set_header_tag_value( l_doc, 'ReceiverID'      , p_hdr.receiver);
      set_header_tag_value( l_doc, 'TType'           , p_hdr.rqv_mess);
      set_header_tag_value( l_doc, 'MsgID'           , p_hdr.rqv_pack);
      set_header_tag_value( l_doc, 'MsgTimestamp'    , format_date(p_hdr.rqv_date));


      if p_service.name is not null then
         bars_audit.trace(l_trace||'Перед установкой доп. тегов');
         set_header_addtags(l_doc, p_service);
      else
         bars_audit.trace(l_trace||'Доп.теги не устанавливаем');
      end if;


      begin
         l_tag := p_hdraddtags.first;
         bars_audit.trace(l_trace||'Перед установкой доп. тегов');
         set_header_addtags(l_doc, p_hdraddtags);
         bars_audit.trace(l_trace||'Доп.теги не устанавливаем');
      exception when no_data_found then null;
      end;



      dbms_lob.createtemporary(l_clob, false);
      dbms_xmldom.writetoclob(l_doc, l_clob);
      dbms_xmldom.freedocument(l_doc);
      p_reply := l_clob;

   exception when others then
      if not dbms_xmldom.isnull(l_doc) then
         dbms_xmldom.freedocument(l_doc);
      end if;
      bars_audit.error(l_trace||'Ошибка установки значений в header:'||sqlerrm);
      raise;
   end;




   -----------------------------------------------------------------
   --   SET_HEADER_VALUES
   --
   --   Внести значения для заголовка.
   --
   --   p_replschem  -  схема ответа
   --   p_hdr        -  структура заголовка ответа
   --
   procedure set_header_values(
                  p_reply  in out clob,
                  p_hdr       t_rplheader,
                  p_service   t_service default null)
   is
      l_service    t_service;
      l_hdraddtags t_taglist;
   begin
         set_header_values(
                  p_reply      => p_reply,
                  p_hdr        => p_hdr,
                  p_service    => p_service,
                  p_hdraddtags => l_hdraddtags);
   end;





   -----------------------------------------------------------------
   --    ADD_BODY_TO_REPLY
   --
   --    Добавить тег Body в схему док-та для ответа
   --
   --    p_body   -  клоб тега <Body>
   --    p_reply  -  клоб схемы док-та для ответа - сюда же будем добавлять
   --
   procedure add_body_to_reply(
                  p_body             clob,
                  p_reply    in out  clob )
   is
      l_trgdoc     dbms_xmldom.DOMDocument;
      l_trgbodynd  dbms_xmldom.DOMNode;
      l_srcdoc     dbms_xmldom.DOMDocument;
      l_srcbodynd  dbms_xmldom.DOMNode;
      l_cloblen    number;
      l_trace      varchar2(1000):=G_TRACE||'add_body_to_reply: ';
   begin

      l_cloblen := dbms_lob.getlength(p_reply);

      bars_audit.trace(l_trace||'добавление ответа длинной '||l_cloblen);
      bars_audit.trace(l_trace|| dbms_lob.substr(p_reply, 3500) );

      l_trgdoc    :=  parse_clob(p_reply);
      l_trgbodynd :=  dbms_xmldom.item(dbms_xmldom.getelementsbytagname(l_trgdoc, 'Body'), 0);

      l_cloblen := dbms_lob.getlength(p_body);
      bars_audit.trace(l_trace||'добавление тела body длинной '||l_cloblen);
      bars_audit.trace(l_trace|| dbms_lob.substr(p_body, 3500) );

      l_srcdoc    :=  parse_clob(p_body);
      l_srcbodynd :=  dbms_xmldom.item(dbms_xmldom.getelementsbytagname(l_srcdoc, 'Body'), 0);

      l_trgbodynd :=  dbms_xmldom.replaceChild(dbms_xmldom.makeNode(l_trgdoc), l_srcbodynd, l_trgbodynd);

      dbms_xmldom.writetoclob(l_trgdoc, p_reply);
      dbms_xmldom.freedocument(l_trgdoc);
      dbms_xmldom.freedocument(l_srcdoc);

   exception when others then
      if not dbms_xmldom.isnull(l_trgdoc) then
         dbms_xmldom.freedocument(l_trgdoc);
      end if;

      if not dbms_xmldom.isnull(l_srcdoc) then
         dbms_xmldom.freedocument(l_srcdoc);
      end if;

      bars_audit.trace(l_trace||'Ошибка добавления тега Body в ответ:'||sqlerrm);
      raise;
   end;







   -----------------------------------------------------------------
   --    CONVERT_TO_DATE()
   --
   --    Проверяет строку на валидность формата даты
   --
   --
   function convert_to_date(p_strdate varchar2, p_tag varchar2) return date
   is
      l_datepattern   varchar2(10);
      l_date          date;
   begin
      return to_date(p_strdate, 'yyyy-mm-dd');
   exception when others then
      bars_error.raise_error(G_MODULE, 41, p_tag);
   end;



   -----------------------------------------------------------------
   --    CONVERT_TO_DATE()
   --
   --    Проверяет строку на валидность формата даты и выкидывает сообщение по коду ошибки
   --
   --
   function convert_to_date(p_strdate varchar2, p_errcode number) return date
   is
   begin
      return to_date(p_strdate, 'yyyy-mm-dd');
   exception when others then
      bars_error.raise_error(G_MODULE, p_errcode, p_strdate);
   end;



   -----------------------------------------------------------------
   --    RESET_BANKDATE
   --
   --    Переустнаовка глобальной банковской даты.
   --    Переустановка учитывает представление текущего пользователя.
   --
   --    Перед вызовом данной процедуры, должно быть выполнено представление
   --    соответсующим отделением.
   --
   --
   procedure reset_bankdate is

      l_bankdate    date;
      l_isopen      integer;
      l_mfo         number;
      l_trace       varchar2(1000):=G_TRACE||'reset_bankdate: ';

   begin

      l_bankdate := bankdate_g;


      l_mfo:= bars_context.extract_mfo(sys_context('bars_context','user_branch'));
      bars_audit.trace(l_trace||' baranch='||sys_context('bars_context','user_branch')||
                                ' mfo    ='||l_mfo );
      begin
         select to_number(val) into l_isopen
         from params$base
         where par='RRPDAY'
           and kf = l_mfo
         ;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE,43, to_char(l_mfo));
      end;


      if l_isopen=0 then
         bars_error.raise_error(G_MODULE,42, to_char(l_bankdate,'dd-mm-yyyy'));
      end if;
      gl.pl_dat(l_bankdate);

   end reset_bankdate;






   -----------------------------------------------------------------
   --    CONVERT_TO_NUMBER()
   --
   --    Конвертит строку в число  соответсвующим exept
   --
   --
   function convert_to_number(p_str varchar2, p_tag varchar2) return number
   is
      l_nmbr    number(38,5);
   begin
        return to_number(p_str);
   exception when others then
        bars_error.raise_error(G_MODULE, 26, p_tag);
   end;


   -----------------------------------------------------------------
   --    CONVERT_TO_NUMBER()
   --
   --    Конвертит строку в число при неккоректности - выкидывает соотвтетсвтующую ошибку
   --
   --
   function convert_to_number(p_str varchar2, p_errcode number) return number
   is
   begin
        return to_number(p_str);
   exception when others then
        bars_error.raise_error(G_MODULE, p_errcode, p_str);
   end;





   -----------------------------------------------------------------
   --    SAVE_REQUEST
   --
   --    Сохранить в базе запрос, отдать уникальный номер нового запроса
   --
   --    p_hdr       -  стркутура header-а входящего док-та
   --    p_pack_xml  -  тело пакета без header-а
   --
   function save_request(
                  p_hdr       t_header,
                  p_pack_xml  clob)
   return number
   is
      l_newid number;
      l_postdate  date;
      l_strdate   varchar2(100);
      l_trace     varchar2(1000):=G_TRACE||'save_request:';
   begin


      select s_xml_gate.nextval into l_newid from dual;

      bars_audit.trace(l_trace||'присвоим номер запроса = '||l_newid||' тип сообщения - '||p_hdr.mess);


      l_strdate := to_char(gl.bd,'dd-mm-yyyy')||' '||to_char(sysdate,'hh24:mi:ss');

      bars_audit.trace(l_trace||'дата обработки файла '||l_strdate);

      l_postdate:= to_date(  l_strdate , 'dd-mm-yyyy hh24:mi:ss' );


      bars_audit.trace(l_trace||'l_postdate = '|| to_char(l_postdate));
      bars_audit.trace(l_trace||'имя пакета:'|| upper(p_hdr.pack_name)||' время:'||to_char(p_hdr.pack_date,'dd/mm/yyyy hh24:mi:ss'));

      insert into xml_gate
             (id,      pnam,                   xml,        datf,            datp, ndoctotal, messtype)
      values (l_newid, upper(p_hdr.pack_name), p_pack_xml, p_hdr.pack_date, l_postdate, p_hdr.doccnt, p_hdr.mess);
      bars_audit.trace(l_trace||'выполнили вставку');

      return l_newid;
   exception when others then
       bars_audit.error(l_trace||'ошибка при сохранении обрабатываемого файла в xml_gate');
       bars_audit.error(l_trace||sqlerrm);
       raise;
   end save_request;








   -----------------------------------------------------------------
   --    SAVE_BAD_PACKET
   --
   --    При неуспешной обработке пакета (неуспешная раскриптовака,
   --    снятие подписи на всем пакете)
   --    оставляем информацию об этом пакете и квитанции
   --
   --
   procedure save_bad_packet(
                   p_pack_nam   varchar2,
                   p_pack_xml   clob,
                   p_reply_xml  clob)
   is
      l_newid  number;
      l_hdr    t_header;
      l_trace  varchar2(1000) := G_TRACE||'save_bad_packet: ';
   begin

      l_hdr.pack_name := p_pack_nam;
      l_hdr.pack_date := sysdate;

      if sys_context('bars_context','user_branch') = '/' then
         bc.subst_mfo(f_ourmfo_g);
      end if;
      bars_audit.trace(l_trace||'Сохранение необработанного пакета: '||l_hdr.pack_name||' датой '||to_char(l_hdr.pack_date,'dd/mm/yyyy hh24:mi'));
      l_newid:= save_request(l_hdr, p_pack_xml);
      insert into xml_gate_receipt(id, partition, xml_o) values(l_newid, 1, p_reply_xml);
      bc.set_context;

  exception when dup_val_on_index  then
       bc.set_context;
       null;
   end save_bad_packet;






   -----------------------------------------------------------------
   --    PRETEND_BRANCH()
   --
   --    Предствление пол-зователя как branch
   --
   --
   procedure pretend_branch(p_sab varchar2) is

      l_branch branch.branch%type;
      l_trace     varchar2(1000):=G_TRACE||'pretend_branch: ';

   begin


      bars_audit.trace(l_trace||'в функе p_sab='||p_sab);
      if (p_sab = '/') then
          l_branch := p_sab;
      else
         select branch into l_branch
         from   customer
         where  sab = upper(trim(p_sab));
      end if;


      bars_context.subst_branch(l_branch);
      bars_audit.trace(l_trace||'установили branch='||l_branch);

      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 4, p_sab||'-'||p_sab);
         if (l_branch is null) then
            bars_error.raise_error(G_MODULE, 5, p_sab||'-'||p_sab);
         end if;

   end pretend_branch;






   -----------------------------------------------------------------
   --    GETSIGNLIST()
   --
   --    Отдает последовательность виз, кот. нужно проверить
   --
   --
   function getsignlist(p_pack_name varchar2) return varchar2 is
   begin

      case
--         when p_pack_name='PMNT' then return '*:B:D';
         when p_pack_name='PMNT' then return '*';
         when p_pack_name='VSNK' then return '*:BACE:DXYZR';
         when p_pack_name in ('REQV', 'ACCN', 'OFIS', 'REQB', 'DMVF', 'DMVP') then return '*';
         else return '*:B:D';
      end case;

   end;






   ------------------------------------------------------
   --   SAVE_REPLY()
   --
   --   Сохранение части(партиции) квитанции после того, как сформирован
   --   ответ.
   --
   --   p_gateid       - уникальный номер в xml_gate
   --   p_partid       - номер партиции
   --   p_reply        - тело партиции
   --
   procedure save_reply(
                   p_gateid    number,
                   p_partid    number,
                   p_reply     clob)
   is
      l_partcnt  number;
      l_trace    varchar2(1000):=G_TRACE||'save_reply: ';
   begin

      -- не используем xml_gate
      if p_gateid = 0  then
         return;
      end if;

      bars_audit.trace(l_trace||'начало сохранения ответа в БД');
      begin
         select nvl(partition_count, 0)
         into   l_partcnt
            from   xml_gate
            where  id = p_gateid;
      exception when no_data_found then
         l_partcnt := 0;
      end;

      if (p_partid > l_partcnt) then
          update xml_gate set partition_count = p_partid where id = p_gateid;
      end if;

      insert into xml_gate_receipt(id, partition, xml_o)
      values(p_gateid, p_partid, p_reply);

      bars_audit.trace(l_trace||'сохранили квитанцию, партиция='||p_partid);

   end save_reply;







   ------------------------------------------------------
   --   SET_PARTITION_ATTRS()
   --
   --   Установить аттрибуты партиции для данного клоба
   --
   --   p_reply        - клоб отета, куда нужно вставить параметры партиции
   --   p_partcnt      - общее кол-во партиций
   --   p_partcur      - текущая партиция
   --
   procedure set_partition_attrs(
                  p_reply      in out clob,
                  p_partcnt           number,
                  p_partcur           number)
   is
      l_doc      dbms_xmldom.DOMDocument;
      l_path     varchar2(100);
      l_trace    varchar2(1000) := G_TRACE||'set_partition_attrs: ';
      l_clob     clob;
   begin

      l_path := '//Header/MessageID';
      l_doc    := parse_clob(p_reply);


      set_attr_value(
               p_doc     => l_doc,
               p_path    => l_path,
               p_attname => 'Partition',
               p_attval  => p_partcur);

      set_attr_value(
               p_doc     => l_doc,
               p_path    => l_path,
               p_attname => 'PartitionCount',
               p_attval  => p_partcnt);



      dbms_lob.createtemporary(l_clob, false);
      dbms_xmldom.writetoclob(l_doc, l_clob);

      dbms_xmldom.freedocument(l_doc);
      p_reply := l_clob;

      --dbms_lob.freetemporary(l_clob);

   exception when others then
      bars_audit.error(l_trace||'ошибка установки аттрибутов партиции: '||sqlerrm);

      if not dbms_xmldom.isnull(l_doc) then
         dbms_xmldom.freedocument(l_doc);
      end if;

      raise;
   end;





   ------------------------------------------------------
   --   SET_PARTITION_ATTRS()
   --
   --   Установить аттрибуты партиции по номеру в xml_gate
   --
   --   p_gateid          - id записи в xml_gate
   --   p_partcnt         - общее кол-во партиций
   --
   procedure set_partition_attrs(
                   p_gateid     number,
                   p_partcnt    number)
   is
      l_clob     clob;
      l_doc      dbms_xmldom.DOMDocument;
      l_path     varchar2(100);
      l_trace    varchar2(1000) := G_TRACE||'set_partition_attrs: ';
   begin

      l_path := '//Header/MessageID';

      for c in (select xml_o, partition, max(partition) over (partition by id) partcnt
                from xml_gate_receipt
                where id = p_gateid) loop

          bars_audit.trace(l_trace||dbms_lob.getlength(c.xml_o));


          l_doc    := parse_clob(c.xml_o);

          set_attr_value(
                   p_doc     => l_doc,
                   p_path    => l_path,
                   p_attname => 'Partition',
                   p_attval  => to_char(c.partition));

          set_attr_value(
                   p_doc     => l_doc,
                   p_path    => l_path,
                   p_attname => 'PartitionCount',
                   p_attval  => to_char(c.partcnt));


          dbms_lob.createtemporary(l_clob, false);
          dbms_xmldom.writetoclob(l_doc, l_clob);

          update xml_gate_receipt set xml_o = l_clob
          where id = p_gateid and partition = c.partition;

          dbms_xmldom.freedocument(l_doc);
          dbms_lob.freetemporary(l_clob);
     end loop;



   exception when others then
      bars_audit.error(l_trace||'ошибка установки аттрибутов партиции: '||sqlerrm);

      if not dbms_xmldom.isnull(l_doc) then
         dbms_xmldom.freedocument(l_doc);
      end if;

      if dbms_lob.istemporary(l_clob)  = 1 then
         dbms_lob.freetemporary(l_clob);
      end if;

      raise;
   end;






   ------------------------------------------------------
   --   CREATE_REPLY_PARTTITIONS()
   --
   --   По входящему курсору, гененирует куски ответа с заголовками
   --   указанным размером и момещает их в  xml_gate_receipt
   --
   --   p_gateid          - id записи в xml_gate
   --   p_partcnt         - общее кол-во партиций
   --   p_service         - Имя сервиса
   --   p_rplhdr          - структура заголовка для ответа
   --   p_cur             - кусор с данными ответа
   --

   procedure create_reply_partitions(
                   p_gateid         number,
                   p_partcnt    out number,
                   p_service        t_service,
                   p_cur            sys_refcursor,
                   p_rplhdr         t_rplheader)
   is

      l_ctx         dbms_xmlquery.ctxHandle;
      l_curdata     clob;
      l_rowsnbr     number         := 1;    -- кол-во записей в сгенер. XML
      l_partition   number         := 0;
      l_partsize    number;
      l_reply       clob;
      l_replyschem  clob;
      l_trace       varchar2(1000) := G_TRACE||'create_reply_partitions: ';
   begin

      bars_audit.trace(l_trace||'начало формирования ответа для '||p_rplhdr.rqv_mess);

      l_ctx := dbms_xmlgen.newcontext(p_cur);
      dbms_xmlgen.setrowsettag(l_ctx, 'Body');
      dbms_xmlgen.setrowtag(l_ctx, p_service.name);


      -- найдем размер партиции для данного сервиса
      begin
         select partsize into l_partsize
         from xml_servlist
         where snam = p_service.name;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 49, p_service.name);
      end;

      if l_partsize is not null then
            dbms_xmlgen.setmaxrows(l_ctx, l_partsize);
         bars_audit.trace(l_trace||'устновили размер партиции в '||l_partsize);
      else
         bars_audit.trace(l_trace||'размер партиции не установлен');
      end if;




      -- загрузить структуру ответа
      begin
         select reply_schem
         into   l_replyschem
         from   xml_messtypes
         where  message = p_rplhdr.rqv_mess;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 1, p_rplhdr.rqv_mess);
      end;
      bars_audit.trace(l_trace||'загрузили схему ответа');
      if (l_replyschem is null ) then
         bars_error.raise_error(G_MODULE, 48, p_rplhdr.rqv_mess);
      end if;




      -- начнем цикл по кол-ву партиций
      loop
          dbms_lob.createtemporary(l_curdata, false);
          dbms_xmlgen.getxml(l_ctx, l_curdata);
           --кол-во выбранных строк
          l_rowsnbr := dbms_xmlgen.getNumRowsProcessed(l_ctx);

          -- если строк уже нету и партиция не первая - выход
          if l_rowsnbr = 0 and l_partition > 0 then
             exit;
          end if;


          bars_audit.trace(l_trace||'всего выбрали строк '||l_rowsnbr);
          l_reply  :=  l_replyschem;

          -- усановить значения заголовка в ответ
          bars_audit.trace(l_trace||'перед устанвлением значений заголовка');

          set_header_values(
              p_reply      => l_reply,
              p_hdr        => p_rplhdr,
              p_service    => p_service);


              l_partition := l_partition + 1;

          -- если выбрали строки - добавить body
            if (l_rowsnbr > 0) then
              -- добавить тег body в ответ
              bars_audit.trace(l_trace||'перед установкой тела пакета в схему');
              add_body_to_reply(
                  p_body  => l_curdata,
                  p_reply => l_reply);

             end if;

          --сохраним в базе ответ
          bars_audit.trace(l_trace||'перед сохранением ответа в БД');
          save_reply(
              p_gateid  => p_gateid,
              p_partid  => l_partition,
              p_reply   => l_reply);

          dbms_lob.freetemporary(l_reply);
          dbms_lob.freetemporary(l_curdata);


      end loop;

      dbms_xmlgen.closeContext(l_ctx);
      p_partcnt  := l_partition;

      -- для всех созданных партиций установить аттрибуты партиции
      bars_audit.trace(l_trace||'перед установкой аттрибутов');
      set_partition_attrs( p_gateid   => p_gateid,
                           p_partcnt  => l_partition);

      bars_audit.trace(l_trace||'сформировали ответ. Общее кол-во партиций='||p_partcnt);


   exception when others then
      bars_audit.error(l_trace||'ошибка формирования партиций ответа:'||sqlerrm);

      if dbms_lob.istemporary(l_reply) = 1 then
         dbms_lob.freetemporary(l_reply);
      end if;

      if dbms_lob.istemporary(l_curdata) = 1 then
         dbms_lob.freetemporary(l_curdata);
      end if;

      raise;
   end create_reply_partitions;




   ------------------------------------------------------
   --   CREATE_REPLY()
   --
   --   Создание квитанции
   --   С указанием ErrorCode и ErrorDetail
   --
   --   p_errcode     - код ошибки  (сообщение тянем из err_klb.err)
   --   p_errdetail   - описание ошибки
   --   p_clbref      - реф кл-банка
   --   p_refnode     - нода вставленного ответа для док-та <MsgErrorCode/>...<MsgErrorCode>
   --   p_doc         - исходящий док-т ответа
   --
   --
   procedure  create_reply (
                   p_errcode            varchar2,
                   p_errdetail          varchar2,
                   p_clbref             number,
                   p_brsref             number,
                   p_refnode        out dbms_xmldom.DOMNode,
                   p_doc         in out dbms_xmldom.DOMDocument)
   is

      l_ndbody             dbms_xmldom.DOMNode;
      l_elem               dbms_xmldom.DOMElement;
      l_nderr              dbms_xmldom.DOMNode;
      l_ndmsg              dbms_xmldom.DOMNode;
      l_nd                 dbms_xmldom.DOMNode;
      l_ndtxt              dbms_xmldom.DOMNode;
      l_trace              varchar2(1000) := G_TRACE||'create_reply: ';

   begin

      if dbms_xmldom.isnull(p_doc)  then
             p_doc     := dbms_xmldom.createDocument('http://www.w3.org/2001/XMLSchema', null, null);
             l_ndbody  := dbms_xmldom.makeNode( dbms_xmldom.createElement(p_doc, 'Body') );
             l_nd      := dbms_xmldom.makeNode(p_doc);
             l_nd      := dbms_xmldom.appendChild( l_nd, l_ndbody);
      else

             l_ndbody     := dbms_xmldom.item(dbms_xmldom.getElementsByTagName(p_doc, 'Body'), 0);

             if dbms_xmldom.isnull(l_ndbody) then
             bars_audit.error(l_trace||'в документе для вставки очередного оплаченного рефа не найден тег Body');
             bars_error.raise_error(G_MODULE, 44);
          end if;

      end if;

      bars_audit.trace(l_trace||'формирование ответа код:'||p_errcode||'-'||p_errdetail);

      l_elem    := dbms_xmldom.createElement(p_doc, 'MsgErrorCode');
                   if p_brsref is not null then
                      dbms_xmldom.setAttribute(l_elem, 'Ref_a', p_brsref);
                   end if;
                   dbms_xmldom.setAttribute(l_elem,    'Ref'  , p_clbref);

      l_ndmsg   := dbms_xmldom.makeNode(l_elem);
      l_nd      := dbms_xmldom.appendChild(l_ndbody, l_ndmsg);

      l_nderr   := dbms_xmldom.makeNode(dbms_xmldom.createElement(p_doc, 'ErrorCode'));
      l_ndtxt   := dbms_xmldom.makeNode(dbms_xmldom.createTextNode(p_doc, p_errcode));
      l_nd      := dbms_xmldom.appendChild(l_ndmsg, l_nderr);
      l_nd      := dbms_xmldom.appendChild(l_nderr, l_ndtxt);

      l_nderr   := dbms_xmldom.makeNode(dbms_xmldom.createElement(p_doc, 'ErrorDetail'));
      l_ndtxt   := dbms_xmldom.makeNode(dbms_xmldom.createTextNode(p_doc, p_errdetail));
      l_nd      := dbms_xmldom.appendChild(l_ndmsg, l_nderr);
      l_nd      := dbms_xmldom.appendChild(l_nderr, l_ndtxt);
                   dbms_xmldom.setVersion(p_doc, '1.0');

      p_refnode := l_ndmsg;
      bars_audit.trace(l_trace||'удачно добавили в ответ реф='||p_clbref);

   exception when others then
      bars_audit.error(l_trace||'ошибка формирования ответа:'||sqlerrm);
      raise;
   end;



   ------------------------------------------------------
   --   CREATE_REPLY()
   --
   --   Создание квитанции
   --   С указанием ErrorCode и ErrorDetail
   --
   --   p_errcode     - код ошибки  (сообщение тянем из err_klb.err)
   --   p_errdetail   - описание ошибки
   --   p_clbref      - реф кл-банка
   --   p_brsref      - реф БАРС-а
   --   p_doc         - исходящий док-т ответа
   --
   --
   procedure  create_reply (
                   p_errcode            varchar2,
                   p_errdetail          varchar2,
                   p_clbref             number,
                   p_brsref             number,
                   p_doc         in out dbms_xmldom.DOMDocument)
   is
      l_nd  dbms_xmldom.DOMNode;
   begin
       create_reply (
                   p_errcode        => p_errcode,
                   p_errdetail      => p_errdetail,
                   p_clbref         => p_clbref,
                   p_brsref         => p_brsref,
                   p_refnode        => l_nd,
                   p_doc            => p_doc);
   end;

   ------------------------------------------------------
   --   CREATE_REPLY()
   --
   --   Создание квитанции
   --   С указанием ErrorCode и ErrorDetail
   --
   --   p_errcode     - код ошибки  (сообщение тянем из err_klb.err)
   --   p_errdetail   - описание ошибки
   --   p_clbref      - реф кл-банка
   --   p_refnode     - нода вставленного ответа для док-та <MsgErrorCode/>...<MsgErrorCode>
   --   p_doc         - исходящий док-т ответа
   --
   --
   procedure  create_reply (
                   p_errcode            varchar2,
                   p_errdetail          varchar2,
                   p_clbref             number,
                   p_refnode        out dbms_xmldom.DOMNode,
                   p_doc         in out dbms_xmldom.DOMDocument) is
   begin
      create_reply(p_errcode   => p_errcode,
                    p_errdetail => p_errdetail,
                    p_clbref    => p_clbref,
                    p_refnode   => p_refnode,
                    p_brsref    => null,
                    p_doc       => p_doc
          );
   end;

   ------------------------------------------------------
   --   CREATE_REPLY()
   --
   --   Создание квитанции
   --   С указанием ErrorCode и ErrorDetail
   --
   --   p_errcode     - код ошибки  (сообщение тянем из err_klb.err)
   --   p_errdetail   - описание ошибки
   --   p_clbref      - реф кл-банка
   --   p_doc         - исходящий док-т ответа
   --
   --
   procedure  create_reply (
                   p_errcode            varchar2,
                   p_errdetail          varchar2,
                   p_clbref             number,
                   p_doc         in out dbms_xmldom.DOMDocument)
   is
      l_nd  dbms_xmldom.DOMNode;
   begin
      create_reply (
                   p_errcode    => p_errcode  ,
                   p_errdetail  => p_errdetail,
                   p_clbref     => p_clbref   ,
                   p_refnode    => l_nd       ,
                   p_doc        => p_doc      );

   end;


   ------------------------------------------------------
   --   CREATE_REPLY()
   --
   --   Создание квитанции
   --   С указанием ErrorCode и ErrorDetail
   --
   --   p_errcode     - код ошибки  (сообщение тянем из err_klb.err)
   --   p_errdetail   - описание ошибки
   --   p_clbref      - реф кл-банка
   --   p_creply      - исходящий клоб ответа
   --
   procedure create_reply (
                   p_errcode          varchar2,
                   p_errdetail        varchar2,
                   p_clbref           number,
                   p_reply     in out clob)
   is
      l_doc   dbms_xmldom.DOMDocument;
   begin

      create_reply (
                   p_errcode   => p_errcode,
                   p_errdetail => p_errdetail,
                   p_clbref    => p_clbref,
                   p_doc       => l_doc);

      dbms_lob.createtemporary(p_reply, false);
      dbms_xmldom.writetoClob(l_doc, p_reply);
      dbms_xmldom.freedocument(l_doc);

   exception when others then
      if not dbms_xmldom.isnull(l_doc) then
         dbms_xmldom.freedocument(l_doc);
      end if;
      raise;
   end;





   ------------------------------------------------------
   --   CREATE_REPLY()
   --
   --   Создание квитанции "вручную"
   --   С указанием ErrorCode
   --
   procedure create_reply(
                   p_errcode        number,
                   p_clbref           number,
                   p_reply   in out clob)
   is
      l_errdetail          err_texts.err_msg%type;
      l_errcode            varchar2(4);
   begin

      l_errdetail:=  bars_error.get_error_text(G_MODULE, p_errcode);
      l_errcode  :=  lpad(p_errcode, 4, '0');

      create_reply(
                p_errcode   =>  l_errcode,
                p_errdetail =>  l_errdetail,
                p_clbref    =>  p_clbref,
                p_reply     =>  p_reply);
   end;





   ------------------------------------------------------
   --   APPEND_REF_TO_DOC()
   --
   --   Процедура формирует документ в исходящий параметр p_doc,
   --   добавляя новцю ноду REF с текстом-значением референса в параметре p_odb_ref.
   --   Если документ пустой - создает его, если нет - добавляет следующую ноду.
   --
   --   p_odb_ref
   --   p_doc
   --
   procedure append_ref_to_doc (
                  p_odb_ref        number,
                  p_doc     in out dbms_xmldom.DOMDocument)
   is

      l_ndbody        dbms_xmldom.DOMNode;
      l_ndref         dbms_xmldom.DOMNode;
      l_nd            dbms_xmldom.DOMNode;
      l_trace         varchar2(1000) := G_TRACE||'append_ref_to_doc: ';
   begin

      if  dbms_xmldom.isnull(p_doc) then
             p_doc     := dbms_xmldom.createDocument('http://www.w3.org/2001/XMLSchema', null, null);

             l_ndbody  := dbms_xmldom.makeNode( dbms_xmldom.createElement(p_doc, 'Body') );
             l_nd      := dbms_xmldom.makeNode(p_doc);
             l_nd      := dbms_xmldom.appendChild( l_nd, l_ndbody);

      else

          l_ndbody  := dbms_xmldom.item(dbms_xmldom.getElementsByTagName(p_doc, 'Body'), 0);

          if dbms_xmldom.isnull(l_ndbody) then
             bars_audit.error(l_trace||'В документе для вставки очередного оплаченного рефа не найден тег Body');
             bars_error.raise_error(G_MODULE, 44);
          end if;

      end if;

      l_ndref   := dbms_xmldom.makeNode( dbms_xmldom.createElement(p_doc, 'Ref') );
      l_ndbody  := dbms_xmldom.appendChild(l_ndbody, l_ndref);

      l_nd      := dbms_xmldom.makeNode( dbms_xmldom.createTextNode(p_doc, p_odb_ref));
      l_ndref   := dbms_xmldom.appendChild(l_ndref, l_nd);
   end;




   -----------------------------------------------------------------
   --    PRINT_DOC
   --
   --    Представить документ в текстовом виде
   --
   --    p_doc
   --
   function print_doc(p_doc   oper%rowtype) return varchar2
   is
      chr  char(2);
   begin

         return 'Документ: '   ||chr||
                '№ '  ||p_doc.nd ||' s='||p_doc.s||' kv='||p_doc.kv||' s2='||p_doc.s2||' kv2='||p_doc.kv2||' dk='||p_doc.dk||chr||
                'tt='||p_doc.tt||' vob='||p_doc.vob||' datd='||p_doc.datd||' vdat='||p_doc.vdat;
   end;




   -----------------------------------------------------------------
   --    VALIDATE_DOC
   --
   --    Провалидировать общие поля док-та на корректность
   --
   --    p_doc      - структура док-та
   --    p_doctype  - если док-т внешний (импортированный)
   --                 для него другие правила валидации полей
   --                 значения: G_EXTERN_DOC, G_INNER_DOC
   --
   --
   procedure validate_doc( p_doc       in out oper%rowtype )
   is
      l_tt    oper.tt%type;
      l_vob   oper.vob%type;
   begin


      if p_doc.mfoa <> gl.amfo and p_doc.mfob <> gl.amfo  then
         bars_error.raise_nerror(G_MODULE, 'NO_OUR_MFO');
      end if;

      if p_doc.nlsa is null then
         bars_error.raise_error(G_MODULE, 10);
      end if;

      if p_doc.nlsb is null then
         bars_error.raise_error(G_MODULE, 14);
      end if;

      if p_doc.nlsa is null then
         bars_error.raise_error(G_MODULE, 10);
      end if;


      if p_doc.nlsa  = p_doc.nlsb and p_doc.kv = p_doc.kv2 then
         bars_error.raise_nerror(G_MODULE, 'NLSA_NLSB_ARE_EQUAL', p_doc.nlsa);
      end if;


      if p_doc.nd is null then
         bars_error.raise_error(G_MODULE, 6);
      end if;


      if p_doc.datd is null then
         bars_error.raise_error(G_MODULE, 7);
      end if;


      if p_doc.datd > gl.bd + 31  or p_doc.datd < gl.bd - 31  then
         bars_error.raise_nerror(G_MODULE, 'NOTVALID_DATD', to_char(p_doc.datd,'dd/mm/yyyy'));
      end if;


      if p_doc.s is null then
         bars_error.raise_error(G_MODULE, 16);
      end if;

      if p_doc.kv is null then
         bars_error.raise_error(G_MODULE, 17);
      end if;

      if p_doc.nazn is null then
         bars_error.raise_error(G_MODULE, 20);
      end if;
      if p_doc.tt is null then
         bars_error.raise_error(G_MODULE, 21);
      end if;

      if p_doc.dk is null then
         bars_error.raise_error(G_MODULE, 22);
      end if;

      if (p_doc.mfoa = p_doc.mfob and (p_doc.dk = 2  or  p_doc.dk = 3)) then
         bars_error.raise_nerror(G_MODULE, 'INNER_INFO_NOTALLOWED');
      end if;


      if p_doc.datp is null then
         p_doc.datp := gl.bd;
      end if;

      if p_doc.kv2 is null then
         bars_error.raise_error(G_MODULE, 23);
      end if;

      if (p_doc.kv2 <> p_doc.kv ) then
         if p_doc.s2 is null then
            bars_error.raise_error(G_MODULE, 24);
         end if;
      end if;


      begin
         select p_doc.tt into l_tt
         from   tts
         where  tt=p_doc.tt;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 38, p_doc.tt);
      end;


      begin
         select p_doc.vob into l_vob
         from   vob
         where  vob=p_doc.vob;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 39, to_char(p_doc.vob));
      end;


      --проверка на непечатные символы в назначении и наименовании
      if  translate(p_doc.nazn, G_x00_x1F, rpad(' ',32)) <> p_doc.nazn then
          bars_error.raise_nerror(G_MODULE, 'NOPRINT_CHAR_NAZN');
      end if;

      if  translate(p_doc.nam_a, G_x00_x1F, rpad(' ',32)) <> p_doc.nam_a then
          bars_error.raise_nerror(G_MODULE, 'NOPRINT_CHAR_NAMA');
      end if;

      if  translate(p_doc.nam_b, G_x00_x1F, rpad(' ',32)) <> p_doc.nam_b then
          bars_error.raise_nerror(G_MODULE, 'NOPRINT_CHAR_NAMB');
      end if;

   end;



   -----------------------------------------------------------------
   --    VALIDATE_INNER_DOC
   --
   --    Провалидировать часть полей внутреннего док-та(из кл-банка) на корректность
   --
   --    p_doc      - структура док-та
   --
   --
   procedure validate_inner_doc(p_doc  in out oper%rowtype)
   is
   begin


      validate_doc(p_doc);

      if p_doc.mfoa is null then
         bars_error.raise_error(G_MODULE, 9);
      end if;
      if p_doc.nam_a is null then
         bars_error.raise_error(G_MODULE, 8);
      end if;
      if p_doc.id_a is null then
         bars_error.raise_error(G_MODULE, 11);
      end if;



      if p_doc.mfob is null then
         bars_error.raise_error(G_MODULE, 13);
      end if;
      if p_doc.nam_b is null then
         bars_error.raise_error(G_MODULE, 12);
      end if;
      if p_doc.id_b is null then
         bars_error.raise_error(G_MODULE, 15);
      end if;


      if p_doc.vdat is null then
         bars_error.raise_error(G_MODULE, 18);
      end if;
      if p_doc.vob is null then
         bars_error.raise_error(G_MODULE, 19);
      end if;


      if p_doc.ref_a  is null then
         bars_error.raise_error(G_MODULE, 27);
      end if;

      if p_doc.sign is null then
         bars_error.raise_error(G_MODULE, 28);
      end if;

      if p_doc.id_o is null then
         bars_error.raise_error(G_MODULE, 29);
      end if;


   end;




   -----------------------------------------------------------------
   --    VALIDATE_EXTERN_DOC
   --
   --    Провалидировать часть полей внешнего док-та(при импорте) на корректность
   --
   --    p_doc      - структура док-та
   --    p_docnmr   - пслед. номер док-та при импорте
   --
   procedure validate_extern_doc(p_doc  in out oper%rowtype)
   is
      l_trace         varchar2(1000) := G_TRACE||'validate_extern_doc: ';
      l_int           number;
      l_blk           number;
   begin

      null;
      -- функция работы с внешними документами перенесена  в bars_xmlklb_imp

   end;






   -----------------------------------------------------------------
   --    CHECK_SIGNVERIFY()
   --
   --    Проверить есть ли ошибки подписи на документе
   --
   --    p_docnd    - нода одного документа <PMNT>
   --    p_messtype - тип сообзения
   --    p_errcode  - код ошибки подписи
   --    p_errtxt   - текст ошибки подписи
   --
   procedure check_signverify(
                  p_docnd           dbms_xmldom.DOMNode,
                  p_messtype        varchar2,
                  p_errcode         in out varchar2,
                  p_errtxt          in out varchar2)
   is
      l_path constant varchar2(100)  :='Body_'||p_messType||'/Payment/';
      l_trace         varchar2(1000) := G_TRACE||'check_signverify: ';
   begin
      dbms_xslprocessor.valueOf(p_docnd, '@ErrorSignKod', p_errcode);
      dbms_xslprocessor.valueOf(p_docnd, '@ErrorSignTxt', p_errtxt);

      bars_audit.trace(l_trace||'код проверки подписи для данного док-та = '||p_errcode);

   exception when others then
      bars_audit.error(l_trace||'ошибка получения результатов проверки подписи на документе:'||sqlerrm);
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;


   -----------------------------------------------------------------
   --    INIT_DOC_FIELDS()
   --
   --    Инициализировать поля документа.
   --
   --    p_docnd    - нода одного документа <PMNT>
   --    p_messtype
   --    p_doc
   --
   --
   procedure init_doc_fields(
                  p_docnd           dbms_xmldom.DOMNode,
                  p_messtype        varchar2,
                  p_seckey          varchar2,
                  p_doc      in out oper%rowtype)
   is

      l_path constant varchar2(100)  :='Body_'||p_messType||'/Payment/';
      l_tmp           varchar2(2000);
      l_trace         varchar2(1000) := G_TRACE||'init_doc_fields: ';
   begin

      if p_seckey <> '' then
         p_doc.id_o := p_seckey;
      end if;

      bars_audit.trace(l_trace||'поиск значения DocNumber');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'DocNumber/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.nd    := substr(trim(l_tmp), 1, 10);
      --p_doc.nd    := trim(dbms_xmlgen.convert(p_doc.nd,1));


      bars_audit.trace(l_trace||'поиск значения DocDate');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'DocDate/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.datd  := convert_to_date(l_tmp, 151);


      bars_audit.trace(l_trace||'поиск значения Payer/Name');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Payer/Name/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.nam_a := substr(trim(l_tmp), 1, 38);
      --p_doc.nam_a := trim(dbms_xmlgen.convert(p_doc.nam_a,1));


      bars_audit.trace(l_trace||'поиск значения Payer/MFO');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Payer/MFO/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.mfoa  := substr(trim(l_tmp), 1, 12);


      bars_audit.trace(l_trace||'поиск значения Payer/Account');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Payer/Account/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.nlsa  := substr(trim(l_tmp), 1, 14);


      bars_audit.trace(l_trace||'поиск значения Payer/OKPO');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Payer/OKPO/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.id_a  := substr(trim(l_tmp), 1, 14);

      bars_audit.trace(l_trace||'поиск значения Payee/Name');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Payee/Name/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.nam_b := substr(trim(l_tmp), 1, 38);
      --p_doc.nam_b := trim(dbms_xmlgen.convert(p_doc.nam_b,1));

      bars_audit.trace(l_trace||'поиск значения Payee/MFO');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Payee/MFO/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.mfob  := substr(trim(l_tmp), 1, 12);

      bars_audit.trace(l_trace||'поиск значения Payee/Account');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Payee/Account/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.nlsb  := substr(trim(l_tmp), 1, 14);

      bars_audit.trace(l_trace||'поиск значения Payee/OKPO');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Payee/OKPO/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.id_b  := substr(trim(l_tmp), 1, 14);

      bars_audit.trace(l_trace||'поиск значения Amount1/Amount');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Amount1/Amount/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.s     := convert_to_number(l_tmp, 152);

      bars_audit.trace(l_trace||'поиск значения Amount1/Currency/NBUCode');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Amount1/Currency/NBUCode/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.kv    := convert_to_number(substr(trim(l_tmp),1,3), 153);

      bars_audit.trace(l_trace||'поиск значения ValueDate');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'ValueDate/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.vdat  := convert_to_date(l_tmp, 154);

      bars_audit.trace(l_trace||'дата валютирования: '||to_char(p_doc.vdat,'dd/mm/yyyy'));


      if p_doc.vdat < add_months(gl.bdate, -1) or
         p_doc.vdat > add_months(gl.bdate,  1) then
         bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_PAYDATE', to_char(p_doc.vdat,'dd/mm/yyyy'));
      end if;


      bars_audit.trace(l_trace||'поиск значения SK');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'SK/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      if length(l_tmp) > 2 then
         bars_error.raise_nerror(G_MODULE, 'NOTCORRECT_SK', l_tmp);
      end if;
      p_doc.sk    := convert_to_number(l_tmp, 156);

      bars_audit.trace(l_trace||'поиск значения DK');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'DK/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.dk    := convert_to_number(l_tmp, 157);

      bars_audit.trace(l_trace||'поиск значения Details');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Details/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.nazn  := substr(trim(l_tmp), 1, 160);

      if p_doc.vdat is null then
         p_doc.vdat := gl.bd;
      end if;

      if p_doc.datp is null then
         p_doc.datp := gl.bd;
      end if;




      bars_audit.trace(l_trace||'поиск значения Amount2/NBUCode');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Amount2/Currency/NBUCode/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.kv2   := convert_to_number(l_tmp, 158);

      if p_doc.kv2 is null then
         p_doc.kv2 := p_doc.kv;
      end if;


      bars_audit.trace(l_trace||'поиск значения Amount2/Amount');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'Amount2/Amount/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.s2    := convert_to_number(l_tmp, 159);

      if p_doc.s2 = 0 or p_doc.s2 is null then
         if p_doc.kv = p_doc.kv2 then
            p_doc.s2 := p_doc.s;
         else
            if p_doc.kv2 = 980 then
               bars_audit.trace(l_trace||'нати эквивалент суммы для валюты: '||p_doc.kv||' датой валютирования '||to_char(p_doc.vdat,'dd/mm/yyyy')||' сумма: '||p_doc.s);
               -- для разновалютной вторая сумма - вычислим
               p_doc.s2 := gl.p_icurval(p_doc.kv, p_doc.s, p_doc.vdat );
               bars_audit.trace(l_trace||'эквивалент : '||p_doc.s2);
            else
               p_doc.s2 :=  gl.p_ncurval( p_doc.kv2,  gl.p_icurval(p_doc.kv, p_doc.s, p_doc.vdat ), p_doc.vdat);
            end if;
         end if;
      end if;


      dbms_xslprocessor.valueOf(p_docnd, l_path||'REF_A/text()',  p_doc.ref_a);


      bars_audit.trace(l_trace||'поиск значения DATP');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'DATP/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.datp  := convert_to_date(l_tmp, 160);

      bars_audit.trace(l_trace||'поиск значения @SIGN');
      dbms_xslprocessor.valueOf(p_docnd, '@SIGN', p_doc.sign);

      dbms_xslprocessor.valueOf(p_docnd, '@KEY', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.id_o  := substr(trim(l_tmp), 1, 6);


      bars_audit.trace(l_trace||'поиск значения TT');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'TT/text()', l_tmp);
      bars_audit.trace(l_trace||'-> '||l_tmp);
      p_doc.tt    := substr(trim(l_tmp), 1, 3);

      if p_doc.tt is null then
         p_doc.tt := f_getoperation_extdoc(p_doc);
      end if;

      bars_audit.trace(l_trace||'поиск значения VOB');
      dbms_xslprocessor.valueOf(p_docnd, l_path||'VOB/text()', l_tmp);
      p_doc.vob   := convert_to_number(l_tmp, 155);

      if (p_doc.vob is null or p_doc.vob='') then
         begin
            select vob into p_doc.vob from tts_vob
            where  tt = p_doc.tt and rownum = 1;
         exception when no_data_found then
            bars_error.raise_error(G_MODULE,35, bars_error.get_error_text(G_MODULE, 161,p_doc.tt));
         end;
      end if;




      p_doc.sos := 0;

      p_doc.datp:= gl.bdate;




      bars_audit.trace(l_trace||print_doc(p_doc));

   exception when others then
      bars_audit.error(l_trace||'ошибка инициализации полей док-та: '||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    GET_REPLY_PARTITION
   --
   --    Вычитывает указанную партицию из всех партиций ответа
   --
   --    p_gateid
   --    p_partid   - указанный номер партиции для чтения
   --    p_reply
   --
   PROCEDURE get_reply_partition (
                   p_gateid     number,
                   p_partid     number,
                   p_reply  out nocopy clob)
   is
      l_xml_clob   clob;
      l_trace      varchar2(1000) := G_TRACE||'get_reply_partition: ';
   begin

      dbms_lob.createtemporary(p_reply, false);

      select xml_o into l_xml_clob
      from xml_gate_receipt
      where id = p_gateid and partition = p_partid;

      p_reply := l_xml_clob;
      bars_audit.trace(l_trace||'получили ответ, партиция № '||p_partid);
   exception when no_data_found then
      bars_audit.trace(l_trace||'ответа партиции № '||p_partid||' не  существуют ');
      p_reply := null;
   end get_reply_partition;





   -----------------------------------------------------------------
   --    GET_DOC_ATTRIBS
   --
   --    Получить доп реквизиты документа из ноды документа
   --
   --    p_docnd     - нода док-та
   --    p_path      - путь к списку доп. реквизитов
   --    p_dreclst   - список доп реквизитов
   --
   --
   procedure get_doc_attribs (
                  p_docnd            dbms_xmldom.DOMNode,
                  p_path             varchar2,
                  p_dreclist  in out array_drec)
   is
      l_ndlist    dbms_xmldom.DOMNodeList;
      l_nd        dbms_xmldom.DOMNode;
      i           number;
      l_trace     varchar2(1000) := G_TRACE||'get_doc_attribs: ';
      l_tmp       varchar2(1000);
      l_ndcnt     number;
   begin


      p_dreclist.delete;


      l_ndlist   := dbms_xslprocessor.selectNodes(p_docnd, p_path);
      l_ndcnt    := dbms_xmldom.getLength(l_ndlist);

      bars_audit.trace(l_trace||'всего доп-реквизитов='||l_ndcnt);


      if  l_ndcnt is null or l_ndcnt = 0 then
          bars_audit.trace(l_trace||'нода: '||p_path||' не существует или пуста');
          return;
      end if;


      for i in 0..l_ndcnt - 1  loop
           l_nd      := dbms_xmldom.item(l_ndlist, i);

           dbms_xslprocessor.valueOf(l_nd, 'AttributeName/text()', l_tmp );
           bars_audit.trace(l_trace||'аттрибут: '||l_tmp);

           if l_tmp = 'OB40_DB' then l_tmp := 'OB40';  end if;
           if l_tmp = 'OB40_KR' then l_tmp := 'OB40D'; end if;

           p_dreclist(i).tag := trim( l_tmp );

           dbms_xslprocessor.valueOf(l_nd, 'AttributeValue/text()', l_tmp);
           bars_audit.trace(l_trace||'значение: '||l_tmp);
           p_dreclist(i).val  := trim(l_tmp);
       end loop;


   exception when others then
      bars_audit.error(l_trace||'ошибка получения аттрибутов док-та: '||sqlerrm);
      raise;
   end;
   -----------------------------------------------------------------
   --    CHECK_ATTRIBS
   --
   --    Проверка доп. реквизитов на допустимость.
   --    В случае недопустимости значения или самого доп. реквизита  - выдать ошибку
   --
   procedure check_attribs (p_dreclist         array_drec)
   is
      l_trace     varchar2(1000) := G_TRACE||'check_attribs: ';
   begin
      bars_audit.trace(l_trace||'всего доп.реквизитов = : '||p_dreclist.count);

	  for i in  0..p_dreclist.count-1 loop
	      -- строка БИС более 99 символов
		  if regexp_like( trim(p_dreclist(i).tag) ,'C[0-9]{3}$')  then
             bars_error.raise_nerror(G_MODULE, 'MORE_THAN_99_BIS');
          end if;
	  end loop;

   end;


   -----------------------------------------------------------------
   --    APPLY_ATTRIBS_TO_DOC
   --
   --    Применить доп реквизиты к документу
   --    Если значение доп. реквизита начинается на # -  установить это значение в d_rec
   --    Если есть доп. реквизиты, суть которых продолжнеие назначения - установить bis = 1
   --    p_docnd     - нода док-та
   --    p_path      - путь к списку доп. реквизитов
   --    p_dreclst   - список доп реквизитов
   --
   --
   procedure apply_attribs_to_doc (
                  p_doc       in out oper%rowtype,
                  p_dreclist         array_drec)
   is
      l_drec  oper.d_rec%type;
      l_sumk  number;
      l_flg   smallint;
      l_tmp   varchar2(1000);
      l_int   number;
      l_trace     varchar2(1000) := G_TRACE||'apply_attribs_to_doc: ';
   begin
      -- Проверка на допустимость доп. реквизитов
	  check_attribs (p_dreclist);

      bars_audit.trace(l_trace||'всего доп.реквизитов = : '||p_dreclist.count);
      l_flg := 0;

      for i in  0..p_dreclist.count-1 loop

          bars_audit.trace(l_trace||'доп.рекв '||p_dreclist(i).tag||' значение='||p_dreclist(i).val);
          if substr(p_dreclist(i).val, 1, 1) = '#' then
             l_drec := l_drec||p_dreclist(i).val;
          else
             -- некоторые доп. реквизиты нужно поместить в значение d_rec для СЕП,
             -- для этого существует справочник xml_drecdoc
             -- поверим на вхождение в справочнике доп реквизитов для d_rec
             if g_docdrec_list.exists(trim(p_dreclist(i).tag) )  then
                l_tmp := '';
                if l_drec is null or instr(l_drec, '#'||trim(p_dreclist(i).tag)) = 0 then
                    if l_drec is null or substr(l_drec, -1)<> '#'  then
                       l_tmp := '#';
                    end if;
                    l_drec := l_drec||l_tmp||trim(p_dreclist(i).tag)||replace(p_dreclist(i).val,' ')||'#';
                end if;
             end if;
          end if;

          if trim(upper(p_dreclist(i).tag)) <> 'D_REC' then
              if regexp_like( trim(p_dreclist(i).tag) ,'C[0-9]{1,2}$')  then
                 l_flg := 1;
              end if;
          end if;

       end loop;

       p_doc.d_rec :=l_drec;

       if l_flg = 1 then
          p_doc.bis := 1;
       end if;


   exception when others then
      bars_audit.error(l_trace||'ошибка применения аттрибутов док-та: '||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    VALIDATE_TTS_PATTERN
   --
   --    Проверка на совпадение счета в плетже, с шаблоном ввода
   --    счета для операции док-та
   --
   --    p_doc
   --
   --
   procedure validate_tts_pattern(p_doc  oper%rowtype)
   is
      l_nlsa_msk      tts.nlsa%type;
      l_nlsb_msk      tts.nlsb%type;
      l_nlsk          varchar2(14);
      l_nlsd          varchar2(14);
      l_obk           varchar2(2);
      l_obd           varchar2(2);
      l_dk            number(1);
      l_nbs           varchar2(4);
      l_tt            varchar2(3);
      l_trace         varchar2(1000) := G_TRACE||'validate_tts_pattern: ';
   begin

      bars_audit.trace(l_trace||' валидация операции '||p_doc.tt);
      begin
         select nlsa, nlsb into l_nlsa_msk, l_nlsb_msk
         from   tts
         where  tt = p_doc.tt;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE,38, p_doc.tt);
      end;

      bars_audit.trace(l_trace||' шаблоны счетов: '||l_nlsa_msk||' -- '|| l_nlsb_msk);

      if substr(l_nlsa_msk, 1,2)='#(' then
         select substr(l_nlsa_msk,3,length(l_nlsa_msk)-3)
         into   l_nlsa_msk
         from   dual;

         execute immediate 'select '||l_nlsa_msk||' from dual ' into l_nlsa_msk;
         bars_audit.trace(l_trace||'маска счета А: '||l_nlsa_msk);
      end if;

      if substr(l_nlsb_msk, 1,2)='#(' then
         select substr(l_nlsb_msk,3,length(l_nlsb_msk)-3)
         into   l_nlsb_msk
         from   dual;
         execute immediate 'select '||l_nlsb_msk||' from dual ' into l_nlsb_msk;
         bars_audit.trace(l_trace||'маска счета Б: '||l_nlsb_msk);

      end if;


      if (     l_nlsa_msk<>''
           and l_nlsa_msk is not null
           and l_nlsa_msk not like p_doc.nlsa) then
          bars_error.raise_error(G_MODULE, 40, p_doc.nlsa, l_nlsa_msk);
      end if;

      if (     l_nlsb_msk<>''
           and l_nlsb_msk is not null
           and l_nlsb_msk not like p_doc.nlsb) then
          bars_error.raise_error(G_MODULE, 40, p_doc.nlsb, l_nlsb_msk);
      end if;

      bars_audit.trace(l_trace||' валидация балансового и об22');

      if p_doc.dk  = 0 or p_doc.dk = 1 then

         l_nlsk := null;
         l_nlsd := null;

         -- найдем параметры дебетовой стороны
         begin
            select nbs, ob22 into l_nlsd, l_obd
              from accounts
              where nls = decode(p_doc.dk, 1, p_doc.nlsa,p_doc.nlsb)
                and gl.amfo = decode(p_doc.dk, 1, p_doc.mfoa, p_doc.mfob)
                and kv = decode(p_doc.dk, 1, p_doc.kv, p_doc.kv2);

            begin
               select nbs into l_nbs from ps_tts where tt = p_doc.tt and dk = 0 and rownum = 1;

               begin
                  select nbs into l_nbs
                    from ps_tts
                   where tt = p_doc.tt
                     and dk = 0
                     and nbs = substr(l_nlsd,1,4)
                     and nvl(ob22, 0) = decode( nvl(ob22, 0), 0, 0, l_obd)
                     and rownum = 1;
               exception when no_data_found then
                  bars_error.raise_nerror(G_MODULE, 'NOTALLOWED_NBSOB22_D', l_nlsd, l_obd, p_doc.tt);
               end;
            exception when no_data_found then null;
               -- нету ну и хорошо на дебетовую сторону нникаких огнаичений нету
            end;
         exception when no_data_found then null;
              -- ну и хорошо - дебетовый счет не наш
         end;


         -- найдем параметры кредитовой стороны
         begin
            select nbs, ob22 into l_nlsk, l_obk
              from accounts
              where nls = decode(p_doc.dk, 1, p_doc.nlsb,p_doc.nlsa)
                and gl.amfo = decode(p_doc.dk, 1, p_doc.mfob, p_doc.mfoa)
                and kv = decode(p_doc.dk, 1, p_doc.kv2, p_doc.kv) ;
            begin
               select nbs into l_nbs from ps_tts where tt = p_doc.tt and dk = 1 and rownum = 1;

               begin
                  select nbs into l_nbs
                    from ps_tts
                   where tt = p_doc.tt
                     and dk = 1
                     and nbs = substr(l_nlsk,1,4)
                     and nvl(ob22, 0) = decode( nvl(ob22, 0), 0, 0, l_obk)
                     and rownum = 1;
               exception when no_data_found then
                  bars_error.raise_nerror(G_MODULE, 'NOTALLOWED_NBSOB22_K', l_nlsk, l_obk, p_doc.tt);
               end;
            exception when no_data_found then null;
               -- нету ну и хорошо на кредитовую сторону никаких огнаичений нету
            end;
         exception when no_data_found then null;
              -- счет не наш
         end;
      end if;





   exception when others then
      bars_audit.error(l_trace||'ошибка валидирования шаблона операции: '||sqlerrm);
      raise;

   end;



   -----------------------------------------------------------------
   --    INSERT_DOC
   --
   --    вставка док-та с БД с прверкой реквизитов
   --    gl.indoc2 + вставка доп. реквизиов
   --
   --    p_doc
   --    p_doctype  - тип док-та (наш или внещний из импорта)
   --    p_dreclist
   --    p_clbref   - реф. клиент банка
   --    p_sender   - идентиф. отправителя
   --
   --
   procedure insert_doc(
                  p_doc        oper%rowtype,
                  p_doctype    smallint,
                  p_dreclist   array_drec,
                  p_clbref     number,
                  p_hdr        t_header)
   is
      l_drec          varchar2(60);
      l_trace         varchar2(1000) := G_TRACE||'insert_doc: ';
   begin


      bars_audit.trace(l_trace||' перед вставкой док-та, сумма в вал.Б='||p_doc.s2||' sk='||p_doc.sk||' d_rec='||p_doc.d_rec);


      gl.in_doc2(
             ref_   =>  p_doc.ref,
             tt_    =>  p_doc.tt,
             vob_   =>  p_doc.vob,
             nd_    =>  p_doc.nd,
             pdat_  =>  sysdate,
             vdat_  =>  p_doc.vdat,
             dk_    =>  p_doc.dk,
             kv_    =>  p_doc.kv,
             s_     =>  p_doc.s,
             kv2_   =>  p_doc.kv2,
             s2_    =>  p_doc.s2,
             sq_    =>  0,
             sk_    =>  p_doc.sk,
             data_  =>  p_doc.datd,
             datp_  =>  p_doc.datp,
             nam_a_ =>  p_doc.nam_a,
             nlsa_  =>  p_doc.nlsa,
             mfoa_  =>  p_doc.mfoa,
             nam_b_ =>  p_doc.nam_b,
             nlsb_  =>  p_doc.nlsb,
             mfob_  =>  p_doc.mfob,
             nazn_  =>  p_doc.nazn,
             d_rec_ =>  p_doc.d_rec,
             id_a_  =>  p_doc.id_a,
             id_b_  =>  p_doc.id_b,
             id_o_  =>  p_doc.id_o,
             sign_  =>  p_doc.sign,
             sos_   =>  p_doc.sos,
             prty_  =>  0,
             uid_   =>  null);



      update oper set ref_a = p_doc.ref_a, bis = p_doc.bis
       where ref = p_doc.ref;



      --  добавить доп. рекквизиты
      for i in 0..p_dreclist.count - 1 loop

            if ( p_dreclist(i).tag is not null and
                 p_dreclist(i).val is not null and
                 p_dreclist(i).tag <> 'D_REC'
               ) then
                begin
                   bars_audit.trace(l_trace||'вставка реквизита <'||p_dreclist(i).tag||'>');

                   insert into operw(ref, tag, value)
                   values(p_doc.ref, p_dreclist(i).tag, p_dreclist(i).val);

                exception when others then
                    if sqlcode= -02291  then -- integrity constraint (BARS.FK_OPERW_OPFIELD) violated - parent key not found
                          bars_error.raise_error(G_MODULE, 31, p_dreclist(i).tag);
                    end if;

                    if sqlcode= -1  then -- unique constraint
                        bars_error.raise_error(G_MODULE, 62, p_dreclist(i).tag, to_char(p_doc.ref) );
                    end if;

                    raise;

                end;

                     --проверим если доп.реквизит с # то надо проставить в СЭП реквизиты oper D_REG
                if substr(p_dreclist(i).val, 1, 1) = '#' then
                      l_drec := l_drec||p_dreclist(i).val;
                end if;
            else
                if  p_dreclist(i).tag is null then
                    bars_error.raise_error(G_MODULE, 32);
                end if;
                if  p_dreclist(i).val is null then
                    bars_error.raise_error(G_MODULE, 163, p_dreclist(i).tag);
                end if;

               end if;
      end loop;


      case p_doctype
      when G_INNER_DOC then
            -- реф. клиент. банка
            insert into operw(ref, tag, value)
            values(p_doc.ref, 'CLBRF', p_clbref);
            -- отправитель
            insert into operw(ref, tag, value)
            values(p_doc.ref, 'CLBSB', p_hdr.sender);
            -- имя пакета
            insert into operw(ref, tag, value)
            values(p_doc.ref, 'KLBXF', p_hdr.pack_name);
      when  G_EXTERN_DOC then
            -- имя пакета
            insert into operw(ref, tag, value)
            values(p_doc.ref, 'IMPFL', p_hdr.pack_name);
     else null;
     end case;


     -- для оффлайна. Если операция KBQ и док-т не кассовый - интерпритировать его,
     -- как доп. реквизит SK_ZB
     if     p_doc.tt = 'KBQ'
        and substr(p_doc.nlsa,1,4) <> '1002' and substr(p_doc.nlsa,1,4) <> '1001'
        and substr(p_doc.nlsb,1,4) <> '1002' and substr(p_doc.nlsb,1,4) <> '1001'
        and p_doc.sk is not null then

        begin
           insert into operw(ref, tag, value)
           values(p_doc.ref, 'SK_ZB', p_doc.sk);
        exception when dup_val_on_index then null;
        end;

     end if;




   exception when others then
      bars_audit.error(l_trace||'ошибка вставки док-та: '||sqlerrm);
      raise;
   end;






   -----------------------------------------------------------------
   --    INSERT_DOC_INSEP
   --
   --    Вставка док-та в arc_rrp для межбанка
   --
   --
   --
   procedure insert_doc_insep(p_doc        oper%rowtype)
   is
      l_err     number;
      l_rec     number;
      l_errnmbr number;
      l_errumsg varchar2(1000);
      l_trace   varchar2(1000) := G_TRACE||'insert_doc_insep: ';
   begin

      -- fli = 1; --межбанк СЕП
      for c in ( select o.ref  from   oper o, tts t
                    where  o.ref = p_doc.ref and o.sos = 5
                        and t.tt = o.tt and t.fli = 1)  loop

          sep.in_sep(
                err_   =>  l_errnmbr,
                rec_   =>  l_rec,
                mfoa_  =>  p_doc.mfoa,
                nlsa_  =>  p_doc.nlsa,
                mfob_  =>  p_doc.mfob,
                nlsb_  =>  p_doc.nlsb,
                dk_    =>  p_doc.dk,
                s_     =>  p_doc.s,
                vob_   =>  p_doc.vob,
                nd_    =>  trim(p_doc.nd),
                kv_    =>  p_doc.kv,
                data_  =>  p_doc.datd,
                datp_  =>  p_doc.datp,
                nam_a_ =>  trim(p_doc.nam_a),
                nam_b_ =>  trim(p_doc.nam_b),
                nazn_  =>  trim(p_doc.nazn ),
                naznk_ =>  null,
                nazns_ =>  (case when p_doc.d_rec is null then '10' else '11' end),
                id_a_  =>  p_doc.id_a,
                id_b_  =>  p_doc.id_b,
                id_o_  =>  p_doc.id_o,
                ref_a_ =>  p_doc.ref_a,
                bis_   =>  0,
                sign_  =>  null,
                fn_a_  =>  null,
                rec_a_ =>  1,
                dat_a_ =>  sysdate,
                d_rec_ =>  p_doc.d_rec,
                otm_i  =>  0,
                ref_i  =>  p_doc.ref
                );


            if l_errnmbr is not null and l_errnmbr <> 0 then
               bars_audit.trace(l_trace||'ошибка вставки документа в arc_rrp для ref= '||p_doc.ref||',  код= '||l_errnmbr);
               begin
                  select n_er into l_errumsg
                  from s_er where k_er = l_errnmbr;
                  bars_audit.trace(l_trace||l_errumsg);
               exception when no_data_found then
                  l_errumsg:= to_char('Ошибка вставки докумнета в arc_rrp: '||l_errumsg);
               end;
               bars_error.raise_nerror(G_MODULE, 'INSEP_ERROR', l_errumsg);
           end if;

           bars_audit.trace(l_trace||'док-т реф= '||p_doc.ref||' вставлен в arc_rrp');


       end loop;

   exception when others then
      bars_audit.error(l_trace||'ошибка вставки док-та в СЕП: '||sqlerrm);
      raise;
   end;






   -----------------------------------------------------------------
   --    PAY_TEARED_TRANSACTION
   --
   --    Оплатить разорваную операцию. Т.е. оплатить главную, а
   --    дочернюю можно не оплачивать в случае ошибки ее оплаты
   --
   --
   --
   procedure pay_teared_transaction(
                  p_doc      in out oper%rowtype,
                  p_paymode         smallint)
   is
      l_trace      varchar2(1000) := G_TRACE||'pay_teared_transaction: ';
   begin

      bars_audit.trace(l_trace||'начало оплаты разорванной транзакции для реф='||p_doc.ref||' tt='||p_doc.tt);
      -- оплатить главную
      begin
         paytt(
              flg_   => p_paymode,
              ref_   => p_doc.ref,
             datv_   => p_doc.vdat,
               tt_   => p_doc.tt,
              dk0_   => p_doc.dk,
              kva_   => p_doc.kV,
             nls1_   => p_doc.nlsa,
               sa_   => p_doc.s,
              kvb_   => p_doc.kV,
             nls2_   => p_doc.nlsb,
               sb_   => p_doc.s);

        exception when others then
           bars_audit.error(l_trace||'ошибка выполнеения главной транзакции(paytt) для '||p_doc.tt);
           bars_audit.error(l_trace||sqlerrm);
           raise;
        end;
       bars_audit.trace(l_trace||'главная оплачена '||p_doc.tt);

       -- оплатить дочернюю
       savepoint before_doch;
       begin
           gl.dyntt2 (
                 sos_   => p_doc.sos,
                 mod1_  => 2,   -- не платить главную
                 mod2_  => 1,
                 ref_   => p_doc.ref,
                 vdat1_ => p_doc.vdat,
                 vdat2_ => p_doc.vdat,
                 tt0_   => p_doc.tt,
                 dk_    => p_doc.dk,
                 kva_   => p_doc.kV,
                 mfoa_  => p_doc.mfoa,
                 nlsa_  => p_doc.nlsa,
                 sa_    => p_doc.s,
                 kvb_   => p_doc.kv2,
                 mfob_  => p_doc.mfob,
                 nlsb_  => p_doc.nlsb,
                 sb_    => p_doc.s2,
                 sq_    => p_doc.sq,
                 nom_   => 0);
       bars_audit.trace(l_trace||'дочерняя оплачена '||p_doc.tt);
       exception when others then

           -- если системная ошибка - откат всей транзакции
           if get_error_type = G_ERR_SYS then
              bars_audit.error(l_trace||'системная ошибка выполнение доч.оп. в разорванной оп.'||p_doc.tt);
              bars_audit.error(l_trace||sqlerrm);
              raise;
           --если прикладная, тогда откатить выполнение дочерней операции
           --(это и есть суть разорванной транзакции)
           else
              bars_audit.error(l_trace||'прикладная ошибка выполнение доч.оп. - главная операция оплачена-');
              bars_audit.error(l_trace||sqlerrm);
              rollback to before_doch;
           end if;
       end;




   end;



   -----------------------------------------------------------------
   --    IS_DPT_OPERATION
   --
   --   Проверка, что данный платеж касается депозитов
   --   Опреация по депозитам, если есть в наличии доп. реквизит CNTR- номер контракта
   --   return  0-операция не по депозитам, 1-операция по депозитам
   --
   --
   function is_dpt_operation(p_ref number) return smallint
   is
      l_cnt smallint := 0;
   begin
      select 1 into l_cnt
      from operw
      where ref = p_ref and tag = 'CNTR';
      return 1;
   exception when no_data_found then
      return 0;
   end;




   -----------------------------------------------------------------
   --    BEFORE_PAY_PROCEDURE
   --
   --   для того что б не влезать в paytt,
   --   сдесь выполняются все нужные дейсвтия перед оплдатой док-та
   --
   --    p_doc
   --
   --
   procedure before_pay_procedure(p_doc oper%rowtype)
   is
      l_trace      varchar2(1000) := G_TRACE||'before_pay_procedure: ';
   begin
      if (is_dpt_operation(p_doc.ref)) = 1 then
          bars_audit.trace(l_trace||'Операция с депозитом - начинаем прверять доступна ли данная операция');
          --  если выполнили операцию пополнения, проверить,
          --  если дата платежа < банковской даты - доначислить %%
          bars_xmlklb_dpt.check_pay_permission(p_doc.ref, p_doc.tt, p_doc.s);
      end if;
      null;
   end;


   -----------------------------------------------------------------
   --    AFTER_PAY_PROCEDURE
   --
   --   для того что б не влезать в paytt,
   --   сдесь выполняются все нужные дейсвтия после оплдаты док-та
   --
   --    p_doc
   --
   --
   procedure after_pay_procedure(p_doc oper%rowtype)
   is
      l_trace      varchar2(1000) := G_TRACE||'after_pay_procedure: ';
   begin

      if (is_dpt_operation(p_doc.ref)) = 1 then

          bars_xmlklb_dpt.after_pay_dpt_op(p_doc);

      end if;
      null;
   end;


   -----------------------------------------------------------------
   --    PAY_DOC
   --
   --    Оплата док-та
   --
   --    p_doc
   --
   --
   procedure pay_doc(p_doc   in out oper%rowtype)
   is
      l_paymode    number(1); -- как платить(по-факту, по-плану)
      l_transmode  number(1); -- разорванная или нет транзакция
      l_trace      varchar2(1000) := G_TRACE||'pay_doc: ';


   begin

      before_pay_procedure(p_doc);

      -- 37 - Оплата по факт.залишку = 1 / По план.залишку = 0 / Не платити = 2
      begin
         select substr(flags,38,1) as flag37,
                substr(flags,51,1) as flag50
         into   l_paymode, l_transmode
         from   tts
         where  tt = p_doc.tt;
      exception when no_data_found then
         l_paymode   := 0;
         l_transmode :=0;
      end;
      bars_audit.trace(l_trace||'тип оплаты =:'||l_paymode);



     G_DOC_REF := p_doc.ref;

     -- если разорванная операция (т.е. внезависимости от того, выполнилась или нет дочерняя - главная не откатывается)
     if (l_transmode = 1 ) then
        pay_teared_transaction(p_doc, l_paymode);

     -- обычная операция
     else
        begin
            bars_audit.trace(l_trace||'перед gl.dyntt2');
            gl.dyntt2 (
                 sos_   => p_doc.sos,
                 mod1_  => l_paymode,
                 mod2_  => 1,
                 ref_   => p_doc.ref,
                 vdat1_ => p_doc.vdat,
                 vdat2_ => p_doc.vdat,
                 tt0_   => p_doc.tt,
                 dk_    => p_doc.dk,
                 kva_   => p_doc.kV,
                 mfoa_  => p_doc.mfoa,
                 nlsa_  => p_doc.nlsa,
                 sa_    => p_doc.s,
                 kvb_   => p_doc.kv2,
                 mfob_  => p_doc.mfob,
                 nlsb_  => p_doc.nlsb,
                 sb_    => p_doc.s2,
                 sq_    => p_doc.sq,
                 nom_   => 0);


            bars_audit.trace(l_trace||'выполнили gl.dyntt2 ');
        exception when others then
            bars_audit.error(l_trace||'ошибка выполнеения gl.dyntt2: ');
            bars_audit.error(l_trace||sqlerrm);
            raise;
        end;
    end if;






        -- для того что б не влезать в paytt, сдесь выполняются все нужные дейсвтия после
        -- оплдаты док-та
      after_pay_procedure(p_doc);

      G_DOC_REF := null;
   exception when others then
      bars_audit.error(l_trace||'ошибка  оплаты док-та:');
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;






   -----------------------------------------------------------------
   --    GET_ERROR_TYPE
   --
   --    По sqlerrm - определить - это системная или прикладная ошибка
   --    p_sqlerrm  - sqlerrm
   --    p_errtype  - тип ошибки (системная - 0, прикладная - 1)
   --    p_errmsg   - сообщение об ошибке
   --
   procedure  get_error_type(p_sqlerrm     varchar2,
                             p_errtype out number,
                             p_errcode out varchar2,
                             p_errmsg  out varchar2)
   is
      l_trace    varchar2(1000)          := G_TRACE||'get_error_type: ';
      l_errumsg   varchar2(4000);
      l_erracode  varchar2(9);
      l_erramsg   varchar2(4000);
      l_errahlp   err_texts.err_hlp%type;
      l_modcode   err_modules.errmod_code%type;
      l_modname   err_modules.errmod_name%type;
      l_errmsg    varchar2(4000);
      l_errtxt    varchar2(4000);

   begin

      l_errtxt := substr(sqlerrm,1,4000);

      bars_audit.trace(l_trace||'sqlerrm:'||l_errtxt);

      bars_error.get_error_info(
                  p_errtxt   => l_errtxt  ,
                  p_errumsg  => l_errumsg ,
                  p_erracode => l_erracode,
                  p_erramsg  => l_erramsg ,
                  p_errahlp  => l_errahlp ,
                  p_modcode  => l_modcode ,
                  p_modname  => l_modname ,
                  p_errmsg   => l_errmsg    );

      bars_audit.trace(l_trace||'errumsg :'||l_errumsg);
      bars_audit.trace(l_trace||'erracode:'||l_erracode||' erramsg:'||l_erramsg);
      bars_audit.trace(l_trace||'modcode :'||l_modcode||' modname:'||l_modname);
      bars_audit.trace(l_trace||'errmsg  :'||l_errmsg);


      if (      l_erracode = 'BRS-99800'   -- системная ошибка (по Диминому пакету)
                or
                l_erracode = 'KLB-00033'   -- прикладные ошибки, маскированные как системные
                or
                l_erracode = 'BRS-99806'   -- ошибка не описана в справочнике.
                or
                l_erracode = 'KLB-00035'   -- ошибка кл.банка о временно блокированном счете (считаем ее как системная)
               /* or -- Отключили что бы в ошибка была прикладная, так как не оплачивает весь файл
                ( l_erracode = 'BRS-09349' -- ошибка блокировки счета из пакетов БАРСА.
                  and
                  instr(l_errmsg,'\9349') > 0
                )*/

         ) then

         bars_audit.trace(l_trace||'SYSTEM error');
         p_errtype := G_ERR_SYS;
         p_errcode := substr(l_errmsg, length('ORA-')+1, 5);

         -- если счет блокирован, то выдать нормальное сообщение
         if l_erracode = 'BRS-09349' or l_erracode = 'KLB-00035' then
            p_errmsg  := l_errumsg;
         else
            p_errmsg  := l_errmsg;
         end if;

      else
         bars_audit.trace(l_trace||'APPLICATION error');
         p_errtype := G_ERR_APP;

         -- внутренняя ошибка БАРС(ошибки, которые выкинуты посредством raise_application_error)
         if l_erracode = 'BRS-99999' then
            p_errcode := substr(l_errmsg, length('ORA-')+1, 5);
            -- в данном пакете ошиьбка имеет длинну 4, многие из raise_application_error выкидывают
            -- ORA - 20000, что в итоге превращается в 0000- то-есть успешную оплату.
            -- В данном случает просто добавим 1
            if p_errcode  = '20000' then
               p_errcode := '20001';
            end if;

            --отдаем оригинальное
            p_errmsg  := l_errmsg;
         -- именные ошибки
         else
            p_errcode := substr(l_erracode,-4);
            p_errmsg  := l_errumsg;
         end if;

      end if;

   end;


   -----------------------------------------------------------------
   --    GET_ERROR_TYPE
   --
   --    По sqlerrm - определить - это системная или прикладная ошибка
   --    return 1 - sys error
   --           0 - app error
   --
   function  get_error_type return number
   is
      l_errcode varchar2(4);
      l_errmsg  varchar2(4000);
      l_errtype number;
   begin

      get_error_type(p_sqlerrm => sqlerrm,
                     p_errtype => l_errtype,
                     p_errcode => l_errcode,
                     p_errmsg  => l_errmsg);
      return l_errtype;
   end;








   -----------------------------------------------------------------
   --    GET_PROCESS_ERROR()
   --
   --    По ошибке понять - она системана или нет - и отдать соответсвущий
   --    код и сообщение об ошибке для квитанции
   --    В случае системной ошибки - выкинуть ошибку KLB - 34(с сообщением ), если прикладная
   --    оддать код прикладной ошибки (модуля KLB) и ее сообщение
   --
   procedure get_process_error
                 (p_sqlerrm           varchar2,
                  p_errcode      out  varchar2,
                  p_errmsg       out  varchar2)
   is

      l_trace    varchar2(1000)  := G_TRACE||'get_process_error2: ';
      l_errtype  number;
      l_errcode  varchar2(5);    --идет возврат 5-ти цифрового кода
      l_errmsg   varchar2(4000);
   begin

      -- если системная ошибка или ошибка account is locked - выходим, если прикладная -
      -- формируем квитанцию с данной ошибкой

      get_error_type(p_sqlerrm => p_sqlerrm,
                     p_errtype => l_errtype,
                     p_errcode => l_errcode,
                     p_errmsg  => l_errmsg);

      p_errcode := substr(l_errcode, -4);
      p_errmsg  := l_errmsg;

      if l_errtype = G_ERR_SYS then
            bars_error.raise_error(G_MODULE, 34, substr(l_errmsg, 1, 250) );
      end if;


   end;




   -----------------------------------------------------------------
   --    CREATE_DOCUMENT_REPLY()
   --
   --    Формирование тела пакета-ответа для типа сообщения документа по DOM документу в
   --    котором содержатся коды обработки всех док-тов пакета.
   --    Сдесь формируется заголовок.
   --
   --    p_bodydoc  - док-т содержащий ответы для всех докумнетов в пакете
   --    p_hdr      - структура входящего заголовка
   --    p_reply    - исходящий ответ
   --
   procedure create_document_reply(
                  p_bodydoc     dbms_xmldom.DOMDocument,
                  p_hdr         t_header,
                  p_reply   out clob)
   is
      l_bodyclob    clob;
      l_reply       clob;
      l_rplhdr      t_rplheader;
      l_trace       varchar2(1000)         := G_TRACE||'create_document_reply: ';
   begin

       bars_audit.trace(l_trace||'Начало формировния текста всего документа ответа');
       dbms_lob.createtemporary(l_bodyclob, false);
       dbms_xmldom.writetoclob(p_bodydoc,  l_bodyclob);


       bars_audit.trace(l_trace||'Перед инициализацией структуры заголовка для ответа');
       -- инициализируем структуру заголовка для ответа
       init_reply_header(
             p_hdr     => p_hdr,
             p_rplhdr  => l_rplhdr);


      bars_audit.trace(l_trace||'Загружаем структуру ответа');
      -- загрузить структуру ответа
      begin
         select reply_schem
         into   l_reply
         from   xml_messtypes
         where  message = p_hdr.mess;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 1, p_hdr.mess);
      end;

      if (l_reply is null ) then
         bars_error.raise_error(G_MODULE, 48, p_hdr.mess);
      end if;


      bars_audit.trace(l_trace||'Устанавливаем значения заголовка в ответ');
      -- усановить значения заголовка в ответ
      set_header_values(
                  p_reply => l_reply,
                  p_hdr   => l_rplhdr);


      bars_audit.trace(l_trace||'Добавляем тег body в ответ');
      -- добавить тег body в ответ
      add_body_to_reply(
                  p_body  => l_bodyclob,
                  p_reply => l_reply);




      p_reply := l_reply;
      dbms_lob.freetemporary(l_bodyclob);

  exception when others then
      if dbms_lob.istemporary(l_bodyclob) = 1 then
         dbms_lob.freetemporary(l_bodyclob);
      end if;
      bars_audit.error('Ошибка формирования ответа для типа ДОКУМЕНТ: '||sqlerrm);
      raise;
   end;


   -----------------------------------------------------------------
   --    CHECK_OPFIELD()
   --
   --    Валидировать доп. реквизит для документа
   --
   --    p_tag - имя доп. реквизита
   --    p_val - значение доп. реквизита
   --    .... реквизиты документа
   --
   function check_opfield(
              p_tag   in char,
              p_val   in varchar2,
              p_s     number,
              p_s2    number,
              p_kv    number,
              p_kv2   number,
              p_nlsa  oper.nlsa%type,
              p_nlsb  oper.nlsb%type,
              p_mfoa  oper.mfoa%type,
              p_mfob  oper.mfob%type,
              p_tt    oper.tt%type)     return number
   is
      l_chkr          op_field.chkr%type;
      l_result        number;
      l_cursor        integer;
      l_needless      number;
      l_tag           varchar2(5);
      l_trace        varchar2(1000)         := G_TRACE||'check_opfield: ';
   begin

      l_tag := trim(p_tag);

      begin
         select chkr into l_chkr from op_field where tag=p_tag;
      exception when no_data_found then
         return 1;
      end;

      -- если поле chkr не заполнено, считаем что значение доп. реквизита корректно
      if l_chkr is null then
         return 1;
      end if;
      -- поле chkr заполнено, необходимо обработать
      bars_audit.trace(l_trace||'Начало валидации реквизита-'||p_tag||' значение-'||p_val||' формула-'||l_chkr);
      begin
         l_cursor := g_cursor_tab(l_tag).m_cursor;
         l_chkr   := g_cursor_tab(l_tag).m_stmt;
      exception when no_data_found then
         -- готовим выражение
         l_chkr := upper(l_chkr);
         l_chkr := replace(l_chkr, '#(TAG)',     'bars_xmlklb.G_TAG');
         l_chkr := replace(l_chkr, '#(VAL)',     'bars_xmlklb.G_VAL');
         l_chkr := replace(l_chkr, '#(S)',       'bars_xmlklb.G_S');
         l_chkr := replace(l_chkr, '#(S2)',      'bars_xmlklb.G_S2');
         l_chkr := replace(l_chkr, '#(KVA)',     'bars_xmlklb.G_KVA');
         l_chkr := replace(l_chkr, '#(KVB)',     'bars_xmlklb.G_KVB');
         l_chkr := replace(l_chkr, '#(NLSA)',    'bars_xmlklb.G_NLSA');
         l_chkr := replace(l_chkr, '#(NLSB)',    'bars_xmlklb.G_NLSB');
         l_chkr := replace(l_chkr, '#(MFOA)',    'bars_xmlklb.G_MFOA');
         l_chkr := replace(l_chkr, '#(MFOB)',    'bars_xmlklb.G_MFOB');
         l_chkr := replace(l_chkr, '#(TT)',      'bars_xmlklb.G_TT');
         l_chkr := 'begin :l_result := '||l_chkr||'; end;';
         -- создаем переменную курсора
         l_cursor := dbms_sql.open_cursor;
         -- парсим выражение
         dbms_sql.parse(l_cursor, l_chkr, dbms_sql.native);
         -- вяжем переменную результата
         dbms_sql.bind_variable(l_cursor, 'l_result', l_result);
         -- сохраняем само выражение и курсор в массиве
         g_cursor_tab(l_tag).m_stmt   := l_chkr;
         g_cursor_tab(l_tag).m_cursor := l_cursor;
      end;
      -- вяжем переменные
      G_TAG  := trim(p_tag);
      G_VAL  := p_val;
      G_S    := p_s;
      G_S2   := p_s2;
      G_KVA  := p_kv;
      G_KVB  := p_kv2;
      G_NLSA := p_nlsa;
      G_NLSB := p_nlsb;
      G_MFOA := p_mfoa;
      G_MFOB := p_mfob;
      G_TT   := p_tt;

      -- выполняем выражение
      bars_audit.trace(l_trace||'Перед выполнением -'||g_cursor_tab(l_tag).m_stmt);

      l_needless := dbms_sql.execute(l_cursor);
      -- получим значение
      dbms_sql.variable_value(l_cursor, 'l_result', l_result);
      --
      return l_result;
   exception when others then
      bars_audit.error(l_trace||'Ошибка валидации реквизита '||p_tag||' значение '||p_val);
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;




   -----------------------------------------------------------------
   --    CHECK_OPFIELD()
   --
   --    Валидировать доп. реквизит для документа
   --
   --
   --
   function check_opfield(
              p_tag   in char,
              p_val   in varchar2,
              p_doc   in oper%rowtype)  return number
   is
      l_trace        varchar2(1000)         := G_TRACE||'check_opfield: ';
   begin

      return check_opfield(
              p_tag   => p_tag,
              p_val   => p_val,
              p_s     => p_doc.s,
              p_s2    => p_doc.s2,
              p_kv    => p_doc.kv,
              p_kv2   => p_doc.kv2,
              p_nlsa  => p_doc.nlsa,
              p_nlsb  => p_doc.nlsb,
              p_mfoa  => p_doc.mfoa,
              p_mfob  => p_doc.mfob,
              p_tt    => p_doc.tt);
   end;



   -----------------------------------------------------------------
   --    VALIDATE_ATTRIBS()
   --
   --    Валидация доп. реквизиов
   --
   --
   procedure validate_attribs(
                  p_dreclist array_drec,
                  p_s     number,
                  p_s2    number,
                  p_kv    number,
                  p_kv2   number,
                  p_nlsa  oper.nlsa%type,
                  p_nlsb  oper.nlsb%type,
                  p_mfoa  oper.mfoa%type,
                  p_mfob  oper.mfob%type,
                  p_tt    oper.tt%type)
   is
      l_flg    smallint;
      l_valid  smallint;
      l_res    boolean;
      l_trace        varchar2(1000)         := G_TRACE||'validate_attribs: ';
   begin

      bars_audit.trace(l_trace||'Начало проверки документа на наличие обязательных реквизитов для tt='||p_tt);

      for c in ( select tag from bars.op_rules where tt = p_tt and opt='M' ) loop

          l_flg := 0;

          for i in 0..p_dreclist.count - 1 loop
              if p_dreclist(i).tag = c.tag then
                 l_flg := 1;
                 exit;
              end if;
          end loop;

          if l_flg = 0 then
             bars_error.raise_error(G_MODULE, 63, c.tag);
          end if;
      end loop;



      bars_audit.trace(l_trace||'Начало проверки значения реквизита на корректность');
      for i in 0..p_dreclist.count - 1 loop
          l_valid := check_opfield(
                                    p_tag   => p_dreclist(i).tag,
                                    p_val   => p_dreclist(i).val,
                                    p_s     => p_s,
                                    p_s2    => p_s2,
                                    p_kv    => p_kv,
                                    p_kv2   => p_kv2,
                                    p_nlsa  => p_nlsa,
                                    p_nlsb  => p_nlsb,
                                    p_mfoa  => p_mfoa,
                                    p_mfob  => p_mfob,
                                    p_tt    => p_tt);
          if l_valid = 0 then
             bars_error.raise_error(G_MODULE, 65, p_dreclist(i).tag, p_dreclist(i).val);
          end if;
      end loop;

   end;




   -----------------------------------------------------------------
   --    VALIDATE_ATTRIBS()
   --
   --    Валидация доп. реквизиов
   --
   --
   procedure validate_attribs(
                  p_doc      oper%rowtype,
                  p_dreclist array_drec)
   is
      l_trace        varchar2(1000)         := G_TRACE||'validate_attribs: ';
   begin

      validate_attribs(
                  p_dreclist => p_dreclist ,
                  p_s        => p_doc.s,
                  p_s2       => p_doc.s2,
                  p_kv       => p_doc.kv,
                  p_kv2      => p_doc.kv2,
                  p_nlsa     => p_doc.nlsa,
                  p_nlsb     => p_doc.nlsb,
                  p_mfoa     => p_doc.mfoa,
                  p_mfob     => p_doc.mfob,
                  p_tt       => p_doc.tt);


   end;




   -----------------------------------------------------------------
   --    XML_PMNT()
   --
   --    Реальная оплата докумнета с
   --    1)  передачей буффера СЕП подписи
   --    2)  передачей последовательности рефов для проверки подписи
   --    3)  со вставкой в таблицу xml_gate
   --
   --    если используется подпись:
   --    мы должны оплатить все документы из пакета, потом передать на jboss все
   --    их референсы + буффера для подписи,
   --    в jbosse - мы подпишем для каждого ref-а буфер,  а затем выполним in_sep,
   --    где вставим эту подпись в oper и arc_rrp
   --
   --    в переменную p_reply  - передается квитанция, готовая к отправке
   --    переменная p_doc_ref   содержит прсто последовательно теги со значениями референсов для
   --    того, что б знать какой буфер к какому рефу относится
   --    p_buf_win -  содержат последовательно все буфера для подписи для
   --    всех рефов из p_doc_ref
   --
   --    p_pack          - входящий пакет
   --    p_gateid        - идентификатор в xml_gate, под которым сохранили пакет. Если = 0,
   --                    - означает в работе не используется xml_gate
   --    p_seckey        - ключ, которым переподписываем документ (id_o).
   --    p_buf_win       - последовательно скaнкатенированные буффера  по 444b для подписи (только для успешно оплаченных док-тов)
   --    p_reply         - готовая квитанция к отправке
   --    p_clob_reflst   - документ со вставленными обработанными референсами(только для успешно оплаченных док-тов)
   --
   procedure xml_pmnt (p_pack             t_pack,
                       p_gateid           number     default 0,
                       p_seckey           varchar2   default '',
                       p_buf_win      out nocopy blob,
                       p_clob_reflst  out nocopy clob,
                       p_reply        out nocopy clob )
   is
      l_ndlist       dbms_xmldom.DOMNodeList;
      l_nd           dbms_xmldom.DOMNode;
      l_xmldoc       dbms_xmldom.DOMDocument;
      i              number;
      l_messtype     varchar2(10);
      l_dreclist     array_drec;
      l_clbref       number;
      l_doc          oper%rowtype;
      l_errumsg      err_texts.err_msg%type;
      l_errcode      varchar2(10)             := '0000';
      l_errmsg       err_texts.err_msg%type   := 'Success';
      l_okdoccnt     number                   := 0;
      l_rplhdr       t_rplheader;
      l_reply        clob;
      l_bodydoc      dbms_xmldom.DOMDocument; -- документ со списком оплаченных рефов
      l_trace        varchar2(1000)         := G_TRACE||'xml_pmnt: ';
      l_tmp          varchar2(1000);

    begin

       bars_audit.trace(l_trace||'Установка G_PACK_STATUS');

       G_PACK_STATUS := G_PACK_PROCESS_STATUS_OK;

       bars_audit.trace(l_trace||'Начало обработки платежей');

       l_xmldoc   := parse_clob(p_pack.cbody);

       l_messtype := p_pack.hdr.mess;
       bars_audit.trace(l_trace||'инициализируем список нод путем= /Body/'||l_messtype);

       l_ndlist   := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(l_xmldoc), '/Body/'||l_messtype);

       bars_audit.trace(l_trace||'всего док-тов='|| dbms_xmldom.getLength(l_ndlist));

       for i in 0 .. dbms_xmldom.getLength(l_ndlist) - 1  loop

           begin

              savepoint xml_pmnt_before;

              l_nd      := dbms_xmldom.item(l_ndlist, i);
              bars_audit.trace(l_trace||'достаем значение реф клб по пути /@Ref');

              dbms_xslprocessor.valueOf(l_nd, '@Ref',l_tmp);
              l_clbref  := convert_to_number( l_tmp, 'REF');

              bars_audit.trace(l_trace||'начало обработки док-та реф кл.б.='||l_clbref);

              -- инициализировать поля док-та
              bars_audit.trace(l_trace||'начало инициализации полей док-та');


              --проверить на наличие ошибки подписи на документе
              check_signverify(l_nd,l_messtype, l_errcode, l_errmsg);
              if l_errcode is not null then
                 -- если ошибка подписи - неоплачивать)
                 bars_error.raise_error(G_MODULE, 102, l_errmsg);
              end if;

              -- инициализация полей переменной - документа
              init_doc_fields(l_nd, l_messtype, p_seckey, l_doc);

              --l_doc.ref_a := l_clbref;



              bars_audit.trace(l_trace||'Документ: '||print_doc(l_doc));
              -- Валидировать поля документа
              bars_audit.trace(l_trace||'начало валидирования док-та');
              validate_inner_doc(l_doc);


              -- получить новый реф док-та
              gl.ref (l_doc.ref);

              -- получить доп. реквизиты документа
              bars_audit.trace(l_trace||'начало получения  доп.рекв. док-та по пути: '||'/Body_'||l_messtype||'/Payment/AddAttributes/Attribute');
              get_doc_attribs(l_nd, 'Body_'||l_messtype||'/Payment/AddAttributes/Attribute', l_dreclist);


              -- определить всели доп реквизиты присутств. для операции
              validate_attribs(l_doc, l_dreclist);

              --применить доп реквизиты к докумнету
              bars_audit.trace(l_trace||'применение  доп.рекв. ');
              apply_attribs_to_doc(l_doc, l_dreclist);

              -- проверим, совпадают ли счета в плетже, с шаблоном ввода счета для операции док-та
              bars_audit.trace(l_trace||'валидация на совпадение счетов для tts шаблона');
              validate_tts_pattern(l_doc);


              --вставка док-та в БД с прверкой реквизитов
              bars_audit.trace(l_trace||'начало вствки док-та');
              insert_doc(l_doc, G_DOC_TYPE, l_dreclist, l_clbref, p_pack.hdr);


              -- оплатить док-т
              bars_audit.trace(l_trace||'начало оплаты док-та');
              pay_doc(l_doc);


              -- енсли для данной операци сущ. самовиза (первая - поставить ее)
              -- завизировать самовизу

              begin

                 select tt into l_doc.tt
                 from chklist_tts
                 where  tt = l_doc.tt and idchk = 5 and priority = 1;
                 bars_audit.trace(l_trace||'начало визирования самовизы для реф='||l_doc.ref||' опер.='||l_doc.tt||' grp = 5, status=1');
                 bars_audit.trace(l_trace||'Для операции '||l_doc.tt||' существует самовиза');

                 chk.put_visa(
                 ref_    => l_doc.ref,
                 tt_     => l_doc.tt,
                 grp_    => 5,
                 status_ => 1,
                 keyid_  => null,
                 sign1_  => null,
                 sign2_  => null);

                 bars_audit.trace(l_trace||'после put_visa');

              exception when no_data_found then
                 bars_audit.trace(l_trace||'Для операции '||l_doc.tt||' НЕ существует самовиза');
                 null;
              end;



              -- очистить список доп.реквизтов
              l_dreclist.delete;
              l_doc := null;
              l_errcode       := '0000';
              l_errumsg       := 'Success';
              l_okdoccnt      := l_okdoccnt+1;


              bars_audit.info(l_trace||'Док-т  '||l_clbref||' оплачен');

          exception  when others then
              rollback to xml_pmnt_before;
              get_process_error(sqlerrm,l_errcode,l_errumsg);
              G_PACK_STATUS := G_PACK_PROCESS_STATUS_FAILED;
          end;

          -- формируем ответ для этого платежа
          bars_audit.trace(l_trace||'начало формирования ответа для этого платежа');
          --добавление в общее тело ответа l_bodydoc, записи о рез-те обработки данного платежа
          create_reply(l_errcode,l_errumsg, l_clbref, l_bodydoc);


      end loop;


      create_document_reply(
             p_bodydoc => l_bodydoc,
             p_hdr     => p_pack.hdr,
             p_reply   => l_reply);


      --сохраним в базе ответ
      save_reply(
              p_gateid  => p_gateid,
              p_partid  => 1,
              p_reply   => l_reply);


      p_reply := l_reply;


      -- занести кол-во оплаченных документов
      --сохраним в базе ответ
      if p_gateid <> 0 then
          update xml_gate set ndocpayed = l_okdoccnt where id = p_gateid;
      end if;

      bars_context.set_context;


       if not dbms_xmldom.isnull(l_xmldoc) then
          dbms_xmldom.freedocument(l_xmldoc);
       end if;

       if not dbms_xmldom.isnull(l_bodydoc) then
          dbms_xmldom.freedocument(l_bodydoc);
       end if;



   exception when others then

       bars_context.set_context;


       if not dbms_xmldom.isnull(l_xmldoc) then
          dbms_xmldom.freedocument(l_xmldoc);
       end if;

       bars_audit.error(l_trace||'Ошибка обработки пакета документов: ');
       bars_audit.error(sqlerrm);
       raise;

   end;





   ----------------------------------------------------------------
   --    EXEC_SERVICE
   --
   --    Выполнение процедуры и открытие курсора для сервиса
   --
   --    p_service    - структура параметров сервиса
   --    p_cur        - курсор
   --
   procedure exec_service(
                  p_service          t_service,
                     p_cur       in out sys_refcursor)
   is
      l_stxt       xml_servlist.stxt%type;
      l_sprc       xml_servlist.sprc%type;
      l_trace      varchar2(200):= G_TRACE||'exec_service: ';
   begin

      begin
         select stxt,sprc into l_stxt,l_sprc
             from xml_servlist where snam = p_service.name;
         exception  when no_data_found then
               bars_error.raise_error(G_MODULE, 1, p_service.name);
         end;



         bars_audit.trace(l_trace||'процедура формирования:  '||l_sprc);
         if l_sprc is not null then
              if    instr(l_sprc,':4')>0 then
                 execute immediate l_sprc using p_service.param1, p_service.param2, p_service.param3, p_service.param4;
              elsif instr(l_sprc,':3')>0 then
                 execute immediate l_sprc using p_service.param1, p_service.param2, p_service.param3;
              elsif instr(l_sprc,':2')>0 then
                 execute immediate l_sprc using p_service.param1, p_service.param2;
              elsif instr(l_sprc,':1')>0 then
                 execute immediate l_sprc using p_service.param1;
              else
                 execute immediate l_sprc;
              end if;
              bars_audit.trace(l_trace||'выполнена процедура '||l_sprc);
          end if;


          bars_audit.trace(l_trace||'запрос формирования:  '||l_stxt);
          if    instr(l_stxt,':4')>0   then
                open p_cur for l_stxt using p_service.param1, p_service.param2, p_service.param3, p_service.param4;
          elsif instr(l_stxt,':3')>0 then
              open  p_cur for l_stxt using p_service.param1, p_service.param2, p_service.param3;
          elsif instr(l_stxt,':2')>0 then
              open  p_cur for l_stxt using p_service.param1, p_service.param2;
          elsif instr(l_stxt,':1')>0 then
              open  p_cur for l_stxt using p_service.param1;
          else
             open p_cur for l_stxt;
             bars_audit.trace(l_trace||'выполнен запрос');
          end if;

   exception when others then
       bars_audit.error(l_trace||'Ошибка выполнения сервиса : '||sqlerrm);
       raise;
   end;





   ----------------------------------------------------------------
   --    XML_REQV()
   --
   --    Процедура по типу сообщения p_messType считывает запрос в xml_servlist - выполняет его и режет
   --    выборку(xml) на партиции, помещая их в xml_gate_recipt
   --    В параметре  p_partition_count - содержится общее кол-во партиций
   --    в параметре  p_clo   - содержится первая партиция
   --
   --    p_pack           - структура пакета
   --    p_gateid         - id записи в xml_gate
   --    p_partcnt        - общее кол-во партиций
   --    p_clo            - исходящий док-т (первая партиция)
   --
   --
   procedure xml_reqv (
                  p_pack          t_pack,
                  p_gateid        number,
                  p_partcnt   out number,
                  p_clo       out nocopy clob)
   is

      i            number :=1 ;
      l_cur        sys_refcursor;
      l_ndlist     dbms_xmldom.DOMNodeList;
      l_nd         dbms_xmldom.DOMNode;
      l_doc        dbms_xmldom.DOMDocument;
      l_service    t_service;
      l_trace      varchar2(200):= G_TRACE||'xml_reqv: ';
      l_rplhdr     t_rplheader;
      l_errcode    t_service;
      l_params     varchar2_list;
      l_refname    varchar2(100) ;
   begin

      bars_audit.trace(l_trace||'Начало обработки запроса');

      l_doc      := parse_clob(p_inclob => p_pack.cbody);
      l_ndlist   := dbms_xslprocessor.selectNodes(
                    dbms_xmldom.makeNode(l_doc), '/Body/'||p_pack.hdr.mess||'/Body_'||p_pack.hdr.mess);


      l_params := varchar2_list();
      l_params.extend(4);
      l_nd        := dbms_xmldom.item(l_ndlist, 0);


      dbms_xslprocessor.valueOf(l_nd,'Service/@P1', l_params(1));
      dbms_xslprocessor.valueOf(l_nd,'Service/@P2', l_params(2));
      dbms_xslprocessor.valueOf(l_nd,'Service/@P3', l_params(3));
      dbms_xslprocessor.valueOf(l_nd,'Service/@P4',   l_params(4));
      dbms_xslprocessor.valueOf(l_nd,'Service/@Name', l_service.name);

      bars_audit.trace(l_trace||'serviceName='||l_service.name||' p1='||l_params(1)||' p2='||l_params(2)||'p3='||l_params(3)||'p4='||l_params(4));


      begin
         select kltable_name into l_refname
         from xml_reflist_reqv
         where reqv_mess = l_service.name;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE,35,bars_error.get_error_text(G_MODULE,79,l_service.name));
      end;

      bars_xmlklb_ref.post_reqvref_for_sab(
                  p_sab       => p_pack.hdr.sender,
                  p_refname   => l_refname ,
                  p_inpackhdr => p_pack.hdr,
                  p_params    => l_params);

      G_REPLY_PACKNAME := 'S'||substr(p_pack.hdr.pack_name, 2);



      bars_audit.trace(l_trace||'выгрузим первуб партицию для gateid ='||p_gateid);

      select xml_o into p_clo from xml_gate_receipt where id = p_gateid and partition = 1;

      select count(*) into p_partcnt
      from  xml_gate_receipt where id = p_gateid;

   exception when others then
      bars_audit.error(l_trace||'Ошибка создания ответа на запрос сервиса'||p_pack.hdr.mess||': '||sqlerrm);
      raise;
   end;




   -----------------------------------------------------------------
   --    IN_SEP()
   --
   --    Обработка документа, вставка подписи
   --
   --
   procedure in_sep( p_ref        number,     -- референс
                     p_seckey     varchar2,   -- ключ подписи
                     p_bufnum     number,     -- номер буфера
                     p_doc_count  number,     -- кол-во документов
                     p_buf        in blob,    -- буфер подписи
                     p_bsign      raw,        -- подпись
                     p_filename   varchar2)   -- имя файла
   is

     l_buf      raw(444);
     l_bufwin   varchar2(444);
     l_doc      oper%rowtype;
     l_row      varchar2(1000);
     l_trace    varchar2 (1000) := G_TRACE||'in_sep: ';

   begin

      bars_audit.trace(l_trace||'вставка СЕП подписи для реф ='||p_ref||' p_seckey='|| p_seckey);


      l_buf := dbms_lob.substr(p_buf, G_SIGN_BUFF_SIZE, (G_SIGN_BUFF_SIZE * p_bufnum) + 1);
      l_bufwin := utl_raw.cast_to_varchar2(l_buf);

      bars_audit.trace(l_trace||'переданный буффер <'||l_bufwin||'> №'||p_bufnum);

      select * into l_doc from oper where ref = p_ref;

      l_row := 'А: '||l_doc.mfoa||' '||l_doc.nlsa||' '||l_doc.nam_a||' '||l_doc.s||' '||l_doc.mfob||' '||l_doc.nlsb||' '||l_doc.nam_b;

      bars_audit.trace(l_trace||'докумнент по рефу: '||l_row);

      docsign.storesepsign(p_ref, l_bufwin, p_seckey, p_bsign);

      update oper set sign=p_bsign where ref=p_ref;


      for c0 in (select o.ref, o.s
                 from oper o, tts t
                     where o.ref = p_ref and o.sos = 5 and t.tt = o.tt and t.fli = 1)  loop --fli = 1; --межбанк СЕП

          update arc_rrp set sign = p_bsign,  id_o = p_seckey
           where ref = p_ref;

          bars_audit.trace(l_trace||'обновили подпись в arc_rrp');
      end loop;


   end in_sep;




   -----------------------------------------------------------------
   --   header_tostring
   --
   --
   --
   function header_tostring(p_header  t_header) return varchar2
   is
      nwl  char(2) := chr(13)||chr(10);
   begin

      return  'пакет         : '||p_header.pack_name||nwl||
              'дата          : '||p_header.pack_date||nwl||
              'тип сообщения : '||p_header.mess||nwl||
              'отправитель   : '||p_header.sender   ||nwl||
              'получатель    : '||p_header.receiver ||nwl||
              'кол-во док-ов : '||p_header.doccnt;

   end;


   -----------------------------------------------------------------
   --   rplheader_tostring
   --
   --
   --
   function rplheader_tostring(p_rplhdr  t_rplheader) return varchar2
   is
      nwl  char(2) := chr(13)||chr(10);
   begin

      return  'пакет         : '||p_rplhdr.pack_name||nwl||
              'дата          : '||p_rplhdr.pack_date||nwl||
              'тип сообщения : '||p_rplhdr.mess||nwl||
              'отправитель   : '||p_rplhdr.sender   ||nwl||
              'получатель    : '||p_rplhdr.receiver ||nwl||
              'ответ на      : '||p_rplhdr.rqv_mess ||nwl;


   end;



   -----------------------------------------------------------------
   --    PARSE_HEADER
   --
   --    Инициализировать структуру заголовка из кллоба входящего пакета
   --
   --    p_packname    - имя файла
   --    p_indoc       - клоб входящего пакета
   --    p_hdr         - структура заголовка
   --
   procedure parse_header(
                  p_packname         varchar2,
                  p_indoc            clob,
                  p_hdr       in out t_header)
   is
      l_packts   varchar2(35);
      l_doc      dbms_xmldom.DOMDocument;
      l_nd       dbms_xmldom.DOMNode;
      l_ndlst    dbms_xmldom.DOMNodeList;
      l_branch   varchar2 (30);
      l_rnk      number;
      l_date     timestamp;
      l_trace    varchar2 (1000) := G_TRACE||'parse_header: ';
   begin

      l_doc     := parse_clob(p_indoc);
      l_nd      := dbms_xmldom.makeNode(l_doc);

-- поломал когда делал пакет для ДКУ по новому КБ
      --p_hdr.pack_name  := dbms_xslprocessor.valueOf(l_nd, '//Header/MessageID/text()');
      --p_hdr.pack_name  := upper(p_hdr.pack_name);
      --p_hdr.mess       := dbms_xslprocessor.valueOf(l_nd, '//Header/MessageType/text()');
      --p_hdr.sender     := dbms_xslprocessor.valueOf(l_nd, '//Header/SenderID/text()');
      dbms_xslprocessor.valueOf(l_nd, '//Header/MessageID/text()', p_hdr.pack_name);
      p_hdr.pack_name  := upper(p_hdr.pack_name);
      dbms_xslprocessor.valueOf(l_nd, '//Header/MessageType/text()', p_hdr.mess);
      dbms_xslprocessor.valueOf(l_nd, '//Header/SenderID/text()', p_hdr.sender);
-- конец ломалки


      bars_audit.trace(l_trace||' перед установкой' );

      if p_hdr.sender is null or p_hdr.sender = '' then
         bars_audit.trace(l_trace||' sender is null' );
         /*
         -- найти отправителя по текущему соединению
         -- это в случае выполнения импорта в онлайне и сентуре
         begin
            select branch into l_branch from staff$base where id = user_id;
            bars_audit.trace(l_trace||' отправителя по текущему соединению branch = '||l_branch);
         exception when no_data_found then
            bars_error.raise_error(G_MODULE,35,bars_error.get_error_text(G_MODULE,80, to_char(user_id)));
         end;

         --найти рнк
         begin
            select val into l_rnk from branch_parameters
            where branch = l_branch and tag = 'RNK';
            bars_audit.trace(l_trace||' рнк = '||l_rnk);
         exception when no_data_found then
            bars_error.raise_error(G_MODULE,35,bars_error.get_error_text(G_MODULE,77, l_branch));
         end;

         --найти sab
         begin
            select sab into p_hdr.sender from customer
            where  rnk = l_rnk;
            bars_audit.trace(l_trace||' саб='||p_hdr.sender);
            if p_hdr.sender is null then
               bars_error.raise_error(G_MODULE,35,bars_error.get_error_text(G_MODULE,82, to_char(l_rnk)));
            end if;
         exception when no_data_found then
            bars_error.raise_error(G_MODULE,35,bars_error.get_error_text(G_MODULE,81, to_char(l_rnk)));
         end;
         */
      end if;

-- поломал когда делал пакет для ДКУ по новому КБ
      --p_hdr.receiver   := dbms_xslprocessor.valueOf(l_nd, '//Header/ReceiverID/text()');
      --l_packts         := dbms_xslprocessor.valueOf(l_nd, '//Header/MessageTimestamp/text()');
      dbms_xslprocessor.valueOf(l_nd, '//Header/ReceiverID/text()', p_hdr.receiver);
      dbms_xslprocessor.valueOf(l_nd, '//Header/MessageTimestamp/text()', l_packts);
      p_hdr.pack_date  := to_date(substr(l_packts,1,10)||substr(l_packts,12,8),'yyyy-mm-dd:hh24:mi:ss');
-- конец ломалки



      -- Найдем кол-во документов в пакете
      l_ndlst          := dbms_xslprocessor.selectNodes(l_nd, '//Body/'||p_hdr.mess);
      p_hdr.doccnt     := dbms_xmldom.getlength(l_ndlst);
      dbms_xmldom.freedocument(l_doc);
      bars_audit.trace(l_trace||' выходим из функи' );
   exception when others then
      dbms_xmldom.freedocument(l_doc);
      bars_audit.error(l_trace||' ошибка разбора заголовка:'||sqlerrm);

      raise;
   end;



   -----------------------------------------------------------------
   --    PARSE_BODY
   --
   --    Инициализировать клоб тега <Body>
   --
   --    p_indoc       - клоб входящего пакета
   --    p_hdr         - структура заголовка
   --
   procedure parse_body(
                  p_indoc            clob,
                  p_cbody     in out clob)
   is
      l_doc      dbms_xmldom.DOMDocument;
      l_nd       dbms_xmldom.DOMNode;
      l_ndtxt    dbms_xmldom.DOMNode;
      l_trace    varchar2 (1000) := G_TRACE||'parse_body: ';
   begin

      l_doc     := dbms_xmldom.newdomdocument(p_indoc);
      l_nd      := dbms_xmldom.makeNode(l_doc);
      l_ndtxt   := dbms_xslprocessor.selectSingleNode(l_nd, '//Body');

      dbms_lob.createtemporary(p_cbody, false);
      dbms_xmldom.writetoclob(l_ndtxt, p_cbody);
      dbms_xmldom.freedocument(l_doc);

   exception when others then
      dbms_xmldom.freedocument(l_doc);
      bars_audit.error(l_trace||' ошибка Инициализации тела пакета:'||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    PROCRESS_PACKET()
   --
   --    Обрабоотка разобранного док-та по его типу сообщения
   --
   --
   procedure process_packet (
                  p_pack     in out t_pack,
                  p_gateid   in out number,
                  p_seckey          varchar2,
                  p_buf_win  in out nocopy blob,
                  p_partcnt  in out number,
                  p_refdoc   in out nocopy clob,
                  p_reply       out nocopy clob)


   is
      l_trace    varchar2 (1000) := G_TRACE||'process_packet: ';
      l_messtype varchar2 (100);
   begin

      bars_audit.trace(l_trace||'Начало обработки пакета '||p_pack.hdr.pack_name||' тип сообщения: '||p_pack.hdr.mess);
      -- проверка на наличие даного типа сообщения
      begin
         select type into l_messtype
         from xml_messtypes
         where upper(message) = upper(p_pack.hdr.mess);
      exception when no_data_found then
          bars_audit.error(l_trace||'тип сообщения '||p_pack.hdr.mess||' не описан в банке');
          -- Данного типа сообщения - нету, сделаем квитанцию с кодом ошибки
          create_reply(
                   p_errcode => 111,
                   p_clbref  => null,
                   p_reply   => p_reply);


          if p_gateid <> 0 then
             --сохраним квитанцию
             save_reply(
                   p_gateid  => p_gateid,
                   p_partid  => 1,
                   p_reply   => p_reply);
          end if;
          return;

      end;


      --установить тек. банк. дату
      bars_audit.trace(l_trace||'перед установкой БД');
      reset_bankdate;
      bars_audit.trace(l_trace||'после установки банк. даты');
      bars_audit.trace(l_trace||'тип сообщений '||l_messtype||'-'||p_pack.hdr.mess);

      case l_messtype
      -- док-т со специфич. обработкой
      when 'document' then
             bars_audit.trace(l_trace||'тип сообщений документы');
             case p_pack.hdr.mess
             -- оплата пакета

             when 'PMNT' then
                  xml_pmnt(
                       p_pack         => p_pack,
                       p_gateid       => p_gateid,
                       p_seckey       => p_seckey,
                       p_buf_win      => p_buf_win,
                       p_clob_reflst  => p_refdoc,
                       p_reply        => p_reply );

             -- импорт документов других задач
             when 'IMPT' then
                  xml_pmnt(
                       p_pack         => p_pack,
                       p_gateid       => p_gateid,
                       p_seckey       => p_seckey,
                       p_buf_win      => p_buf_win,
                       p_clob_reflst  => p_refdoc,
                       p_reply        => p_reply );

            else
                bars_error.raise_error(G_MODULE, 45, p_pack.hdr.mess);
            end case;


      -- док-т с запросом на ответ, описанный в xml_servlist
      when 'service' then

            -- обработка запроса
            xml_reqv( p_pack     => p_pack,
                      p_gateid   => p_gateid,
                      p_partcnt  => p_partcnt,
                      p_clo      => p_reply);

                      p_buf_win     := null;
                      p_refdoc      := null;



      when 'deposit' then
             bars_audit.trace(l_trace||'тип сообщений депозиты');

                  bars_xmlklb_dpt.xml_dpt(
                       p_message  => p_pack.hdr.mess,
                       p_pack     => p_pack,
                       p_gateid   => p_gateid,
                       p_seckey   => p_seckey,
                       p_reply    => p_reply);
      else
          bars_error.raise_error(G_MODULE, 46, p_pack.hdr.mess, p_pack.hdr.mess);
      end case;


   bars_audit.info(l_trace||'Пакет обработан успешно');
   exception when others then
       bars_audit.error(l_trace||'ошибка: '||sqlerrm);
       raise;
   end;



   -----------------------------------------------------------------
   --    IN_GATE()
   --
   --    Перврначальная Обработка документа (9 параметров - с подписью)
   --    Процедура оплачивает документ.
   --    Отдает список референсов в переменную p_refdoc и буффера для подписи
   --    p_buf_win  (последовательно для всех референсов по 444)  -
   --    для того, что б подписать в jbosse, а затем вызвать in_sep
   --    и вставить эту подпись в oper.
   --    Отдает тело для квитанции p_reply
   --
   --    p_packname    - имя файла
   --    p_gateid      - уникальный номер в xml_gate
   --    p_refdoc      - документ со списком референсов из докумнета
   --    p_seckey      - ключ для подписи
   --    p_buf_win     - буффера для подписи (последовательно для всех референсов по 444)
   --    p_partcnt     - кол-во партиций
   --    p_indoc       - тело входящего пакета
   --    p_reply       - тело исходящего пакета (квитанции)
   --    p_rpackname   - исходящее имя файла
   --
   procedure in_gate (
                  p_packname                 varchar2,
                  p_gateid        out        number,
                  p_refdoc        out nocopy clob,
                  p_seckey                   varchar2,
                  p_buf_win       out nocopy blob,
                  p_partcnt       out        number,
                  p_indoc                    clob,
                  p_reply         out nocopy clob,
                  p_rpackname     out        varchar2)
   is

      l_senderblk    number(1);
      l_pack         t_pack;
      l_trace        varchar2 (1000) := G_TRACE||'in_gate: ';
      l_indoc        clob;
   begin


      l_indoc  :=  p_indoc;

      --l_indoc := convert(p_indoc,  'CL8MSWIN1251','UTF8');

      p_gateid    :=  0;
      p_refdoc    := '0';
      p_partcnt   :=  1;
      p_rpackname :=  get_reply_packname(p_packname);

      bars_audit.info(l_trace||'начало обработки пакета '||p_packname);


      -- Есть ли уже записи для этого файла во ходящей таблице xml_gate
      -- если да, тогда узнать порядковый номер записи и общее кол-во партиций
      begin
         select nvl(id, -1), partition_count
         into p_gateid, p_partcnt
               from xml_gate
               where pnam = upper(p_packname)
                 and to_char(datp,'yyyy') = to_char(gl.bd,'yyyy');

         bars_audit.trace(l_trace||'ответ для пакета уже был сформирован');
         get_reply_partition(
                   p_gateid   => p_gateid,
                   p_partid   => 1,
                   p_reply    => p_reply);
           p_refdoc := null;
         return;

      exception when no_data_found then
         bars_audit.trace(l_trace||'ответ для пакета еще не был сформирован');
         p_gateid := 0;
      end;



      -- разобрать заголовок
      parse_header( p_packname => p_packname,
                    p_indoc    => l_indoc,
                    p_hdr      => l_pack.hdr);
      bars_audit.trace(l_trace||'информация о заголовке: '|| header_tostring(l_pack.hdr));


      -- инициализироть клоб тела док-та <Body>
      parse_body(   p_indoc     => l_indoc,
                    p_cbody     => l_pack.cbody);


      -- Представимся пользователем от кого платим
      bars_audit.trace(l_trace||'before pr.br branch='||sys_context('bars_context','user_branch')||
                                           ' mfo='||bars_context.extract_mfo);
      pretend_branch(l_pack.hdr.sender);
      bars_audit.trace(l_trace||'after  pr.br branch='||sys_context('bars_context','user_branch')||
                                           ' mfo='||bars_context.extract_mfo);

      --сохранить запрос в таблице xml_gate
      p_gateid := save_request( l_pack.hdr, l_indoc);




      -- Проверим, заблокировано ли входящее направление для клиента
      begin
         select blk into l_senderblk
         from   kl_customer_params cp, customer c
         where  cp.rnk=c.rnk and c.sab = l_pack.hdr.sender;
         bars_audit.trace(l_trace||'код блокировки клиента = '||l_senderblk);
      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 2, l_pack.hdr.sender);
      end;

      -- Входное направление закрыто (1- на вход, 3 - на вход и на выход)
      -- сделаем квитанцию с кодом ошибки
      if  l_senderblk = 1 or l_senderblk = 3 then
          bars_audit.info(l_trace||'входное направление закрыто - формируем квитанцию');
          create_reply(
                   p_errcode => 106,
                   p_clbref  => null,
                   p_reply   => p_reply);

          --сохраним квитанцию
          save_reply(
                   p_gateid  => p_gateid,
                   p_partid  => 1,
                   p_reply   => p_reply);
          return;
      end if;



      process_packet(p_pack    => l_pack   ,
                     p_gateid  => p_gateid ,
                     p_seckey  => p_seckey ,
                     p_buf_win => p_buf_win,
                     p_partcnt => p_partcnt,
                     p_refdoc  => p_refdoc ,
                     p_reply   => p_reply );



      --bars_audit.info(l_trace||'buff='||utl_raw.cast_to_varchar2(p_buf_win));
      --bars_audit.info(l_trace||'refd='||p_refdoc);


      p_rpackname := G_REPLY_PACKNAME;


      dbms_lob.freetemporary(l_pack.cbody);

      bars_context.set_context();
   exception when others then

       bars_context.set_context();

       if dbms_lob.istemporary(l_pack.cbody) = 1 then
          dbms_lob.freetemporary(l_pack.cbody);
       end if;

       bars_audit.error(l_trace||'ошибка выполнения in_gate: '||sqlerrm);
       raise;
   end;






   -----------------------------------------------------------------
   --    IN_GATE()
   --
   --    Перврначальная Обработка документа (6 параметров - без подписи)
   --
   --
   --    p_packname  -  имя файла
   --    p_indoc     -  входящий clob документа
   --    p_reply     -  clob с ответом
   --    p_gateid    -  номер в xml_gate
   --    p_partcnt   -  общеее кол-во партиций
   --    p_rpackname -  имя квитанции
   --
   procedure in_gate (
                  p_packname             varchar2,
                  p_gateid    out        number,
                  p_partcnt   out        number,
                  p_indoc                clob,
                  p_reply     out nocopy clob,
                  p_rpackname out        varchar2 )
   is
      l_docref   clob        := null;
      l_seckey   varchar2(6) := null;
      l_buf_win  blob        := null;

   begin

      in_gate( p_packname  => p_packname,
               p_gateid    => p_gateid,
               p_refdoc    => l_docref,
               p_seckey    => l_seckey,
               p_buf_win   => l_buf_win,
               p_partcnt   => p_partcnt,
               p_indoc     => p_indoc,
               p_reply     => p_reply,
               p_rpackname => p_rpackname);
   end;




   -----------------------------------------------------------------
   --    IN_GATE()
   --
   --    Перврначальная Обработка документа (3 параметра )
   --    1) без поддержки партиций
   --    2) без проверки подписи
   --    3) без сохранения в xml_gate

   --    без записи в
   --    p_packname  -  имя файла
   --    p_indoc     -  входящий clob документа
   --    p_reply     -  clob с ответом
   --    p_header    -  разобранный заголовок в структуру. Иногда при входе вобработку- заголовок уже разобран
   --
   procedure in_gate (
                  p_packname             varchar2,
                  p_indoc                clob,
                      p_reply     out nocopy clob,
                  p_header               t_header )
   is
      l_pack    t_pack;
      l_partcnt number := 0;
      l_gateid  number := 0;
      l_trace   varchar2 (1000) := G_TRACE||'in_gate: ';
      l_seckey  varchar2 (100):='';
      l_clob    clob;
      l_blob    blob;
   begin

      if p_header.pack_name is null then
          parse_header( p_packname => p_packname,
                        p_indoc    => p_indoc,
                        p_hdr      => l_pack.hdr);
      else
         l_pack.hdr := p_header;
      end if;

      bars_audit.trace(l_trace||'информация о заголовке: '|| header_tostring(l_pack.hdr));

      parse_body( p_indoc     => p_indoc,
                  p_cbody     => l_pack.cbody);

      pretend_branch(l_pack.hdr.sender);
      bars_audit.trace(l_trace||'after  pr.br branch='||sys_context('bars_context','user_branch')||' mfo='||bars_context.extract_mfo);

      process_packet(p_pack    => l_pack,
                     p_gateid  => l_gateid,
                     p_seckey  => l_seckey,
                     p_buf_win => l_blob,
                     p_partcnt => l_partcnt,
                     p_refdoc  => l_clob,
                     p_reply   => p_reply );


      dbms_lob.freetemporary(l_pack.cbody);

      bars_context.set_context();

   exception when others then

       bars_context.set_context();
       if dbms_lob.istemporary(l_pack.cbody) = 1 then
          dbms_lob.freetemporary(l_pack.cbody);
       end if;

       bars_audit.error(l_trace||'ошибка выполнения in_gate: '||sqlerrm);
       raise;
   end;




   -----------------------------------------------------------------
   --    IN_GATE()
   --
   --    Перврначальная Обработка документа (3 параметра )
   --    1) без поддержки партиций
   --    2) без проверки подписи
   --    3) без сохранения в xml_gate

   --    без записи в
   --    p_packname  -  имя файла
   --    p_indoc     -  входящий clob документа
   --    p_reply     -  clob с ответом
   --
   procedure in_gate (
                  p_packname             varchar2,
                  p_indoc                clob,
                      p_reply     out nocopy clob)

   is
      l_hdr      t_header;
      l_trace   varchar2 (1000) := G_TRACE||'in_gate: ';
   begin

      in_gate (
                p_packname => p_packname,
                p_indoc    => p_indoc,
                p_reply    => p_reply,
                p_header   => l_hdr) ;
   end;


   -----------------------------------------------------------------
   --    IN_GATE2()
   --
   --    Просто тестовая функция
   --
   procedure in_gate2 (
                  p_packname             varchar2,
                  p_indoc                clob)
   is
   begin
      insert into xml_gate(pnam, xml)
      values(p_packname, p_indoc);
   end;



   -----------------------------------------------------------------
   --    FREE_XML_GATE()
   --
   --    Удаление данных из накопительной таблицы входящих пакетов
   --    p_date - до какой даты (включительно) удалять данные
   --             смотрим по дате обработки файла xml_gate.datp
   --
   procedure free_xml_gate( p_date date)
	   is
      l_trace        varchar2 (1000) := G_TRACE||'free_xml_gate: ';
      i     number := 0;
   begin

      for c in (select id from xml_gate where datp <= p_date) loop
          delete from xml_gate_receipt where id  = c.id;
          delete from xml_gate         where id  = c.id;
          i := i + 1;
      end loop;
      bars_audit.info(l_trace||'При чистке входящих пакето было удалено '||i||' строк');
   end;



   -----------------------------------------------------------------
   --    INIT_PACK
   --
   --    Функция для инициализации пакета
   --
   procedure init_pack
   is
   begin

      G_DOC_TYPE := G_INNER_DOC;

      -- инициализация массива доп. реквизитов, которые должны быть записаны в d_rec
      if g_docdrec_list.count  = 0 then
             for c in (select trim(tag) tag from xml_docdrec) loop
                 g_docdrec_list(c.tag) := 0;
             end loop;
          end if;
   end;
   -----------------------------------------------------------------


begin
   init_pack;
end bars_xmlklb;
/
 show err;
 
PROMPT *** Create  grants  BARS_XMLKLB ***
grant EXECUTE                                                                on BARS_XMLKLB     to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_XMLKLB     to BARSAQ_ADM;
grant EXECUTE                                                                on BARS_XMLKLB     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_XMLKLB     to KLBX;
grant EXECUTE                                                                on BARS_XMLKLB     to OPER000;
grant EXECUTE                                                                on BARS_XMLKLB     to TECH006;
grant EXECUTE                                                                on BARS_XMLKLB     to WR_ALL_RIGHTS;
grant EXECUTE                                                                on BARS_XMLKLB     to WR_XMLIMP;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_xmlklb.sql =========*** End ***
 PROMPT ===================================================================================== 
 