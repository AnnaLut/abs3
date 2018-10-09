create or replace package BARS_XMLKLB_IMP
is

  -----------------------------------------------------------------
  --
  --    Константы
  --
  -----------------------------------------------------------------

   G_HEADER_VERSION  constant varchar2(64) := 'version 3.2 12.03.2016';

  -----------------------------------------------------------------
  --
  --    Типы
  --
  -----------------------------------------------------------------



   type t_doc is record( doc  xml_impdocs%rowtype,       --платнжные реквизитв документа
                         drec bars_xmlklb.array_drec);  --список доп. реквизитов


   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   --
   --
   function header_version return varchar2;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   --
   --
   function body_version return varchar2;


   -----------------------------------------------------------------
   --    MAKE_IMPORT()
   --
   --    Импорт докумнетов из внешних задач
   --
   --
   --    p_indoc     -  входящий clob документа
   --    p_packname  -  имя файла
   --
   procedure make_import(p_indoc  clob, p_packname out varchar2);




   -----------------------------------------------------------------
   --    MAKE_IMPORT_CNT()
   --
   --    Для импорта док-тов из Centura (входящий пакет считывается пакетом  bars_lob.import_blob(l_blob))
   --    из временной таблицы tmp_lob. Предполагается, что перед выполнением данной функи, выполнили вгрузку
   --    входящего файла при помощи Centura функции - PutFileToTmpLob
   --
   --
   --    p_packname  -  имя файла
   --

   procedure import_doc_cnt(p_packname   in out varchar2);




   -----------------------------------------------------------------
   --    IMPORT_RESULTS
   --
   --    Результаты импорта файла
   --
   --  p_filename   - Имя файла импорта
   --  p_dat        - банк. дата импорта
   --  p_filesum    - исход значение суммы файла
   --  p_filecnt    - исход значение кол-ва док-тов файла
   --
   procedure import_results(
                  p_filename     varchar2,
                  p_dat          date,
                  p_filecnt  out number,
                  p_filesum  out number);



   -----------------------------------------------------------------
   --    IS_BISTAG
   --
   --    Является ли тег допревизита, тегом биса
   --    return 0 - нет, 1- да, это тег БИС-а
   --
   function is_bistag (p_tag varchar2) return smallint;




   -----------------------------------------------------------------
   --    VALIDATE_DOC
   --
   --    Провалидировать поля документа и его доп. реквизиты по референсу импорта.
   --    Проставить ему статус и ошибку (если есть) валидации в базе
   --    Возвращает код ошибки или '0000' если все ОК
   --
   --    p_impref  - реф импортированного докумнета
   --    p_errcode - код ошибки валидирования ('0000' - sucess)
   --
   procedure validate_doc(p_impref       number,
                          p_errcode  out varchar2);



   -----------------------------------------------------------------
   --    PAY_DOC
   --
   --    Оплатить выбранный док-т по рефу
   --
   --    p_impref  - реф. документа импорта
   --    p_errcode - код ошибки воплаты ('0000' - sucess)
   --
   procedure  pay_doc(p_impref       number,
                      p_errcode  out varchar2);


   -----------------------------------------------------------------
   --    PAY_FILE_DOCS()
   --
   --    Оплата документов из файла ткущего пользователя
   --
   --    p_filename  -  имя файла
   --    p_dat       -  дата импорта
   --    p_okcnt     -  кол-во успешно оплаченных
   --    p_oksum     -  сумма  успешно оплаченных
   --    p_badcnt    -  кол-во НЕуспешно оплаченных
   --    p_badsum    -  сумма  НЕуспешно оплаченных
   --
   procedure pay_file_docs(
                  p_filename     varchar2,
                  p_dat          date,
                  p_okcnt    out number,
                  p_oksum    out number,
                  p_badcnt   out number,
                  p_badsum   out number);

   -----------------------------------------------------------------
   --    DELETE_DOC
   --
   --    Удаление документа
   --
   --    p_impref  - реф импортированного докумнета
   --    p_errcode - код ошибки выполнения ('0000' - sucess)
   --
   procedure delete_doc(p_impref       number,
                        p_errcode  out varchar2);


   -----------------------------------------------------------------
   --    UPDATE_DOC
   --
   --    Обновить реквизиты док-та по рефу
   --
   --    p_impref  - реф. документа импорта
   --    p_errcode - код ошибки воплаты ('0000' - sucess)
   --
   procedure  update_doc(
                  p_impref       number,
                  p_mfoa         varchar2  default null,
                  p_nlsa         varchar2  default null,
                  p_ida          varchar2  default null,
                  p_nama         varchar2  default null,
                  p_mfob         varchar2  default null,
                  p_nlsb         varchar2  default null,
                  p_idb          varchar2  default null,
                  p_namb         varchar2  default null,
                  p_nazn         varchar2  default null,
                  p_s            number    default 0,
                  p_sk           number    default 0,
                  p_kv           number
);


   -----------------------------------------------------------------
   --    CLEAR_IMPORT_JOURNALS
   --
   --    Удалить всю ненужную информацию про импорт (для оплаченных и удаленных документов)
   --
   --    p_date -  по какую дату ( НЕ включая)
   --
   procedure  clear_import_journals(p_date  date);




   -----------------------------------------------------------------
   --    UPDATE_DOCBIS
   --
   --    Обновить бис. строку для документа
   --
   --    p_impref  - реф. документа импорта
   --    p_bistag  - тег биса, наприм. С01
   --    p_bisval  - значение биса
   --
   procedure  update_docbis(
                  p_impref   number,
                  p_bistag   varchar2,
                  p_bisval   varchar2,
                  p_action   smallint);


   -----------------------------------------------------------------
   --    UPDATE_DOCDREC
   --
   --    Обновить доп. реквизит для документа
   --
   --    p_impref  - реф. документа импорта
   --    p_bistag  - тег биса, наприм. С01
   --    p_bisval  - значение биса
   --    p_action  - (0-удалить, 1-изменить 2-добавить)
   --
   procedure  update_docdrec(
                  p_impref   number,
                  p_tag      varchar2,
                  p_val      varchar2,
                  p_action   smallint);



   -----------------------------------------------------------------
   --    MAKE_IMPORT()
   --
   --    Импорт докумнетов из внешних задач
   --
   --
   --    p_indoc     -  входящий clob документа
   --    p_packname  -  имя файла
   --    p_outdoc    -  исходящий клоб с ответами
   --
   procedure make_import(p_indoc  clob, p_packname out varchar2, p_outdoc in out clob);


   -----------------------------------------------------------------
   --    PAY_EXTERN_DOC
   --
   --    Оплатить внешний докумнет
   --
   --
   procedure  pay_extern_doc(p_extref         varchar2,     -- внешний реф
                             p_nd             varchar2,     -- № док-та
                             p_datd           date,         -- дата док-та
                             p_vdat           date,
                             p_nama           varchar2,
                             p_mfoa           varchar2,
                             p_nlsa           varchar2,
                             p_ida            varchar2,
                             p_namb           varchar2,
                             p_mfob           varchar2,
                             p_nlsb           varchar2,
                             p_idb            varchar2,
                             p_s              number,
                             p_kv             number,
                             p_s2             number,
                             p_kv2            number,
                             p_sk             number,
                             p_dk             number,
                             p_tt             varchar2,
                             p_vob            number,
                             p_nazn           varchar2,
                             p_userid         number,
                             p_tag1           varchar2 default null,  -- тег доп.реквизита №1
                             p_val1           varchar2 default null,  -- значение доп.реквизита №1
                             p_tag2           varchar2 default null,  -- тег доп.реквизита №2
                             p_val2           varchar2 default null,  -- значение доп.реквизита №2
                             p_tag3           varchar2 default null,  -- тег доп.реквизита №3
                             p_val3           varchar2 default null,  -- значение доп.реквизита №3
                             p_errcode    out varchar2,  -- исходящий код ошибки
                             p_errmsg     out varchar2,  -- исходящее сообщение об ошибке
                             p_barsref    out number  );  -- реф. БАРС-а для оплаченного док-та




   -----------------------------------------------------------------
   --    PAY_EXTERN_DOC
   --
   --    Оплатить внешний докумнет
   --    p_doc     - структура документа с доп. реквизитами
   --    p_errcode - исходящий код ошибки
   --    p_errmsg  - исходящее сообщение об ошибке
   --
   --    В поле p_doc.doc.ref - будет находиться реф БАРС-а
   --
   procedure  pay_extern_doc(p_doc     in out t_doc,
                             p_errcode    out varchar2,  -- исходящий код ошибки
                             p_errmsg     out varchar2);  -- исходящее сообщение об ошибке



   -----------------------------------------------------------------
   --    GET_IMPORT_OPERATION()
   --
   --    По реквизитам документа, получить код операции для БАРС-а
   --
   --    I00 I00 _мпорт внутр_шн_х платеж_в
   --    I01 off I01 _мпорт м_жбанк_вських платеж_в (МВПС, СЕП)
   --    I02 I02 Iмпорт прих_д каси (ГРН)
   --    I03 I03 _мпорт видаток каси (ГРН)
   --    I04 I04 _мпорт прихiд каси (ВАЛ)
   --    I05 I05 _мпорт видаток каси (ВАЛ)
   --    I06 I06 _мпорт _нформац_йний дебет (dk=2)
   --    I07 I07 - Iмпорт реальний ДЕБЕТ мiжбанк
   --    I09 I09 - Тест
   --    I0I I0I - Тест _нформац_йний (dk=3)
   --
   --
   function get_import_operation(
                        p_nlsa varchar2,
                        p_mfoa varchar2,
                        p_nlsb varchar2,
                        p_mfob varchar2,
                        p_dk   number,
                        p_kv   number) return varchar2;

   procedure get_participant_details(
                   p_mfo   in  varchar2,
           p_nls   in  varchar2,
           p_kv    in  number,
           p_dk    in  number,
           p_force in  number,
           p_nmk   in  out varchar2,
           p_okpo  in  out varchar2
           );

end;
/

show errors

----------------------------------------------------------------------------------------------------

create or replace package body BARS_XMLKLB_IMP
is

   ---------------------------------------------------------
   --
   --  Пакет обработки импорта докумнетов
   --
   --  KAZ  - Казначейсво
   --  Сбербанк по умолчанию
   --
   ---------------------------------------------------------

   ----------------------------------------------
   --  константы
   ----------------------------------------------
   G_BODY_VERSION    constant varchar2(64) := 'version 13.14 20.07.2018';

   G_MODULE          constant char(3)      := 'KLB';    -- код модуля
   G_TRACE           constant varchar2(50) := 'xmlklb_imp.';


   --
   -- статусы документа, кот. находится в промежуточной таблице импорта
   --
   G_IMPORTED        constant smallint  := 0;  -- только импортированный
   G_NOVALID         constant smallint  := 4;  -- валидирован с ошибкми
   G_VALIDATED       constant smallint  := 1;  -- валидированный
   G_PAYED           constant smallint  := 2;  -- оплаченный
   G_DELETED         constant smallint  := 3;  -- удаленный

   G_ACT_DEL         constant smallint  := 0;  -- удалить
   G_ACT_UPD         constant smallint  := 1;  -- изменить
   G_ACT_ADD         constant smallint  := 2;  -- добавить


   -- коды ошибок проверки ОКПО
   -- плательщик
   G_OKPO_NONUMBER_A  constant smallint  := 88;  -- не числовое значение
   G_OKPO_NOLENGTH_A  constant smallint  := 89;  -- длинна < 8-ми
   G_OKPO_NOVALID_A   constant smallint  := 87;  -- не прошла проверку v_okpo
   -- получатель
   G_OKPO_NONUMBER_B  constant smallint  := 92;  -- не числовое значение
   G_OKPO_NOLENGTH_B  constant smallint  := 93;  -- длинна < 8-ми
   G_OKPO_NOVALID_B   constant smallint  := 94;  -- не прошла проверку v_okpo

   G_OKPO_OK          constant smallint  := 0;   -- все ОК



   -- таблица кодировки непечатаемых символов
   G_x00_x1F constant varchar2(32)   := chr(00)||chr(01)||chr(02)||chr(03)||chr(04)||chr(05)||chr(06)||chr(07)||chr(08)||chr(09)||chr(10)||
                                        chr(11)||chr(12)||chr(13)||chr(14)||chr(15)||chr(16)||chr(17)||chr(18)||chr(19)||chr(20)||chr(21)||
                    chr(22)||chr(23)||chr(24)||chr(25)||chr(26)||chr(27)||chr(28)||chr(29)||chr(30)||chr(31);


   G_VALIDATE_OK     constant varchar2(4) := '0000';  -- код успешной обработки

   G_FILEBUFF        blob     := null;  -- переменная содержащая файл для импорта
   ----------------------------------------------
   --  типы, переменные
   ----------------------------------------------

   type t_opfield_list is table of smallint index by varchar2(5);  --op_field.tag%type;
   opfield_list  t_opfield_list;


   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   --
   --
   function header_version return varchar2
   is
   begin
       return 'package header BARS_XMLKLB_IMP: ' || G_HEADER_VERSION;
   end header_version;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   --
   --
   function body_version return varchar2
   is
   begin
       return 'package body BARS_XMLKLB_IMP: ' || G_BODY_VERSION;
   end body_version;



   -----------------------------------------------------------------
   --    CHECK_IF_DOC_PROCESSED
   --
   --    Посмотреть , обработан ли документ уже, можно ли с ним еще что-то делать
   --
   --    p_impref  - реф. документа импорта
   --
   procedure  check_if_doc_processed(p_impref  number)
   is
      l_status    smallint;
   begin
      select status into l_status
      from xml_impdocs where impref = p_impref;

      if l_status = G_PAYED or l_status = G_DELETED then
         bars_error.raise_error(G_MODULE, 167);
      end if;
   exception when no_data_found then
         bars_error.raise_error(G_MODULE, 162, to_char(p_impref));
   end;


   -----------------------------------------------------------------
   --    IMPORT_RESULTS
   --
   --    Результаты импорта файла
   --
   --  p_filename   -  Имя файла импорта
   --  p_dat        - банк. дата импорта
   --  p_filesum    - исход значение суммы файла
   --  p_filecnt    - исход значение кол-ва док-тов файла
   --
   procedure import_results(
                  p_filename     varchar2,
                  p_dat          date,
                  p_filecnt  out number,
                  p_filesum  out number
                  )
   is
   begin
      select count(*), sum(s)                             ins
      into p_filecnt, p_filesum
      from xml_impdocs
      where fn = upper(p_filename) and dat = p_dat;
   exception when no_data_found then
      bars_error.raise_error(G_MODULE, 163, p_filename, to_char(p_dat,'dd/mm/yyyy'));
   end;

   -----------------------------------------------------------------
   --    GET_DRECLIST
   --
   --    Для рефа получить доп реквизиты
   --
   --    p_impref      - реф
   --
   procedure get_dreclist(
                  p_impref          number,
                  p_dreclist in out bars_xmlklb.array_drec
)
   is
      i        number := 0;
   begin
      for c in (select tag, value
                  from xml_impdocsw
                 where impref = p_impref) loop
--       p_dreclist(i).tag := case  when c.tag = chr(207) then chr(67) else c.tag end; -- заменить П(латин) на С(киррил)
         p_dreclist(i).tag := c.tag;
         p_dreclist(i).val := c.value;
         i := i + 1;
      end loop;
   end;


   -----------------------------------------------------------------
   --    IS_CASH
   --
   --    Проверка балансового на пренадлежность к кассе
   --
   --
   function is_cash(p_nbs  varchar2) return number
   is
   begin
      if p_nbs = '1001' or p_nbs = '1002' or p_nbs = '1003' or p_nbs = '1004' then
         return 1;
      else
         return 0;
      end if;
   end;

   -----------------------------------------------------------------
   --    VALIDATE_OKPO
   --
   --    Валидировать значение ОКПО
   --
   --    p_okpo     - МФО счета
   --    p_dk       - 0 - ОКПО А,  1-ОКПО Б (для соответсвующего кода ошибки)
   --    return     number error code
   --
   function validate_okpo(p_okpo varchar2, p_dk smallint) return number
   is
      l_int number;
      l_trace        varchar2(1000) := G_TRACE||'validate_okpo: ';
   begin
      begin
         l_int := to_number(p_okpo);
      exception when others then
         bars_audit.error(l_trace||'Ошибка преобразования в число значения: '||p_okpo);
     return (case p_dk when 0 then G_OKPO_NONUMBER_A else G_OKPO_NONUMBER_B end);
      end;

      if length(p_okpo) < 8 and p_okpo<>'99999' then
         bars_audit.error(l_trace||'Длинна ОКПО < 8: '||p_okpo);
     return (case p_dk when 0 then G_OKPO_NOLENGTH_A else G_OKPO_NOLENGTH_B end);
      end if;

      /* не работает по физикам поетому не годится
      if v_okpo(p_okpo) <> p_okpo then
         bars_audit.error(l_trace||'Ошибка валидации ф-цией v_okpo: '||v_okpo(p_okpo)||' <> '||p_okpo);
     return (case p_dk when 0 then G_OKPO_NOVALID_A else G_OKPO_NOVALID_B end);
      end if;*/

     begin
         l_int := f_validokpo(p_okpo);
         if l_int = -1 then
          bars_audit.error(l_trace||'Ошибка валидации ф-цией f_validokpo: ОКПО - '||p_okpo||' некоректне ');
          return (case p_dk when 0 then G_OKPO_NOVALID_A else G_OKPO_NOVALID_B end);
          end if;
      end;
      return G_OKPO_OK;

   end;

   -----------------------------------------------------------------
   --    GET_PARTICIPANT_DETAILS
   --
   --    По лицевому счету и валюте получить наименование и ОКПО клиента
   --
   --    p_mfo      - МФО счета
   --    p_nls      - лицевой счет
   --    p_kv       - валюта
   --    p_dk       - 0 - сторона А, 1- сторона Б (для соотв. вывода ошибки)
   --    p_force    - 1  - c сообщениями об ошибках, 0- просто подставить найденное значение
   --
   procedure get_participant_details(
           p_mfo   in  varchar2,
           p_nls   in  varchar2,
           p_kv    in  number,
           p_dk    in  number,
           p_force in  number,
           p_nmk   in  out varchar2,
           p_okpo  in  out varchar2
           )
   is
      l_okpochk_code number;
      l_rnk          number;
      l_trace        varchar2(1000) := G_TRACE||'get_participant_details: ';
   begin
      if p_mfo = gl.amfo then
         begin
            select nvl(p_nmk, substr(nvl(p_nmk, nmk),1,38)), nvl(p_okpo, okpo), c.rnk
              into p_nmk, p_okpo, l_rnk
              from customer c, accounts a
             where c.rnk = a.rnk
               and a.nls =  p_nls
               and a.kv = p_kv;

         exception when no_data_found then
            if p_force = 1 then
               bars_error.raise_nerror(G_MODULE, 'NO_ACCOUNT_FOUND', p_nls, to_char(p_kv ));
        end if;
         end;
      else
         begin
            select nvl(p_nmk, substr(nvl(p_nmk, name),1,38)), nvl(p_okpo, okpo)
              into p_nmk, p_okpo
              from alien
         where mfo = p_mfo and nls = p_nls
               and kv = p_kv
               and okpo is not null
               and name is not null
               and rownum = 1;
     exception when no_data_found then
        if p_force = 1 then
           bars_error.raise_nerror(G_MODULE, 'NO_ALIEN_FOUND', to_char(p_mfo), p_nls, to_char(p_kv ));
        end if;
     end;
      end if;

      if p_force = 1 then
         l_okpochk_code := validate_okpo(p_okpo, p_dk);
         bars_audit.trace(l_trace||' Нашли ОКПО='||p_okpo||' Код валидации: '||l_okpochk_code);
         if l_okpochk_code <> 0 then
            if p_mfo = gl.amfo then
           bars_error.raise_nerror(G_MODULE, 'CUST_OKPO_NOTCORRECT',  to_char(l_rnk), p_nls, to_char(p_kv), bars_error.get_error_text(G_MODULE, l_okpochk_code, p_okpo));
        else
           bars_error.raise_nerror(G_MODULE, 'ALIEN_OKPO_NOTCORRECT', p_nls, to_char(p_kv), bars_error.get_error_text(G_MODULE, l_okpochk_code, p_okpo));
        end if;
         end if;
      end if;
--проверка на соответсвие счета клиенту, считанного из файла, проверка по ОКПО клиента
      if p_mfo = gl.amfo then
            begin
                select c.okpo into p_okpo
                  from accounts a,
                       customer c
                 where a.rnk  = c.rnk
                   and c.okpo = p_okpo
                   and a.nls  = p_nls
                   and kv     = p_kv;
            exception when no_data_found then
               if p_force = 1 then
                   bars_error.raise_nerror(G_MODULE, 'CUST_OKPO_NOTCORRECT',  to_char(l_rnk), p_nls, to_char(p_kv));
               end if;
            end;
       end if;
   end;


   -----------------------------------------------------------------
   --    VALIDATE_PAY_RIGHTS
   --
   --    Проверить может ли текущий пользователь оплатить данный документ
   --
   --    p_impdoc      - структура док-та
   --
   procedure validate_pay_rights(p_impdoc  in xml_impdocs%rowtype)
   is
      l_nlsdb    varchar2(14);
      l_nlskr    varchar2(14);
      l_nls      varchar2(14);
      l_kvdb     number;
      l_kvkr     number;
      l_mfodb    varchar2(6);
      l_mfokr    varchar2(6);

   begin
      if p_impdoc.dk = 1 then
         l_nlsdb := p_impdoc.nlsa;
         l_kvdb  := p_impdoc.kv;
         l_mfodb := p_impdoc.mfoa;

     l_nlskr := p_impdoc.nlsb;
         l_kvkr  := p_impdoc.kv2;
         l_mfokr := p_impdoc.mfob;
      else
         l_nlsdb := p_impdoc.nlsb;
         l_kvdb  := p_impdoc.kv2;
         l_mfodb := p_impdoc.mfob;

     l_nlskr := p_impdoc.nlsa;
         l_kvkr  := p_impdoc.kv;
         l_mfokr := p_impdoc.mfoa;
      end if;

      if l_mfodb = gl.amfo then
         begin
        select nls into l_nls
              from saldod
             where nls =  l_nlsdb and l_kvdb = kv;
         exception when no_data_found then
            bars_error.raise_nerror(G_MODULE, 'NO_DEBET_RIGHTS', l_nlsdb, to_char(l_kvdb));
         end;
      else
        -- дебе не нашего МФО (нижестоящего)
    null;
      end if;

     -- begin
     --    select nls into l_nls
     --     from saldok
     --    where nls =  l_nlskr and l_kvkr = kv;
     -- exception when no_data_found then
     --   bars_error.raise_nerror(G_MODULE, 'NO_KREDIT_RIGHTS', l_nlskr, to_char(l_kvkr));
     -- end;

   end;

   -----------------------------------------------------------------
   --    VALIDATE_DOC_FIELDS
   --
   --    Провалидировать часть полей док-та(при импорте) на корректность
   --    Некоторые поля корректируются
   --    При ошибке проверки  - выкидывает исключение
   --
   --    p_impdoc      - структура док-та
   --
   procedure validate_doc_fields(p_impdoc  in out xml_impdocs%rowtype)
   is
      l_trace         varchar2(1000) := G_TRACE||'validate_doc_fields: ';
      l_int           number;
      l_blk           number;
      l_mfo           varchar2(6);
      l_iscashA       smallint;
      l_iscashB       smallint;
      l_okpohk_code   number;
      l_dazs          date;
   begin

      if p_impdoc.s = 0 then
         bars_error.raise_nerror(G_MODULE, 'NULLABLE_SUM');
      end if;


      -- проверка того, что мы можем дебетовать толко счет своего МФО
      if  p_impdoc.dk = 1 then
         if p_impdoc.mfoa <> gl.amfo then
            bars_error.raise_nerror(G_MODULE, 'NOT_OUR_MFO', p_impdoc.mfoa);
         end if;
      else
      if p_impdoc.dk = 0 then
        -- проверим, может мы дебетуем свое нижестоящее МФО - тогда можно
        if p_impdoc.mfob <> gl.amfo then
           begin
              select mfo into l_mfo
            from banks
               where mfop  = gl.kf and mfo  = p_impdoc.mfob and kodn = 6;
           exception when no_data_found then
               bars_error.raise_nerror(G_MODULE, 'NOT_OUR_MFO', p_impdoc.mfob);
           end;
        end if;
         end if;
      end if;


      -- проверка стороны А
      if p_impdoc.mfoa is null then
         bars_error.raise_error(G_MODULE, 68, p_impdoc.nlsa, to_char(p_impdoc.kv ));
      end if;


      if p_impdoc.nlsa is null then
         bars_error.raise_error(G_MODULE, 10);
      end if;

      -- проверка контрольного разряда
      if p_impdoc.nlsa <> vkrzn( substr(p_impdoc.mfoa,1,5), p_impdoc.nlsa ) then
         bars_error.raise_nerror(G_MODULE, 'NOTCORECT_CHECK_DIGIT_A', p_impdoc.nlsa );
      end if;

      -- иногда наименов клиента и его ОКПО отсутствует в импортируемом документе
      if p_impdoc.id_a is null or p_impdoc.nam_a  is null then
         get_participant_details(
           p_mfo   => p_impdoc.mfoa,
           p_nls   => p_impdoc.nlsa,
           p_kv    => p_impdoc.kv,
           p_dk    => 0,
           p_force => 1,
           p_nmk   => p_impdoc.nam_a,
           p_okpo  => p_impdoc.id_a);
      end if;

      begin
         select blk,  mfo into l_blk, p_impdoc.mfoa
         from banks where mfo = p_impdoc.mfoa;
         if l_blk > 0 then
            bars_error.raise_error(G_MODULE, 91, p_impdoc.mfoa);
         end if;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 90, p_impdoc.mfoa);
      end;


      if p_impdoc.mfoa = gl.amfo then
         begin
            select nls, dazs
              into p_impdoc.nlsa, l_dazs
             from accounts where nls = p_impdoc.nlsa and kv = p_impdoc.kv;

            if l_dazs is not null then
               bars_error.raise_nerror(G_MODULE, 'CLOSE_PAYER_ACCOUNT', p_impdoc.nlsa, to_char(p_impdoc.kv));
            end if;


         exception when no_data_found then
            begin -- Для перехода на новый план счетов пытаемся найти по nlsalt новый счет если пришол старый
                 select nls, dazs
                  into p_impdoc.nlsa, l_dazs
                 from accounts where nlsalt = p_impdoc.nlsa and kv = p_impdoc.kv AND dat_alt IS NOT NULL;
                 
                        if l_dazs is not null then
                           bars_error.raise_nerror(G_MODULE, 'CLOSE_PAYER_ACCOUNT', p_impdoc.nlsa, to_char(p_impdoc.kv));
                        end if;
            exception when no_data_found then
            bars_error.raise_error(G_MODULE, 168, p_impdoc.nlsa||'('||p_impdoc.kv||')' );
         end;
        end;
      else
         if p_impdoc.nlsa <> vkrzn(substr(p_impdoc.mfoa,1,5), p_impdoc.nlsa) then
            bars_error.raise_error(G_MODULE, 85, p_impdoc.nlsa);
         end if;
      end if;


      p_impdoc.id_a := trim(p_impdoc.id_a);
      l_okpohk_code := validate_okpo(p_impdoc.id_a, 0);
      if l_okpohk_code <> 0 then
         bars_error.raise_error(G_MODULE, l_okpohk_code, p_impdoc.id_a);
      end if;



      -- проверка стороны Б

       if p_impdoc.mfob is null then
          bars_error.raise_error(G_MODULE, 100, p_impdoc.nlsa, to_char(p_impdoc.kv ));
       end if;


       if p_impdoc.kv2 is null then
          bars_error.raise_error(G_MODULE, 23);
       end if;


       if p_impdoc.id_b is null or p_impdoc.nam_b  is null then
         get_participant_details(
           p_mfo   => p_impdoc.mfob,
           p_nls   => p_impdoc.nlsb,
           p_kv    => p_impdoc.kv2,
           p_dk    => 1,
           p_force => 1,
           p_nmk   => p_impdoc.nam_b,
           p_okpo  => p_impdoc.id_b);
     end if;


      if p_impdoc.nlsb is null then
         bars_error.raise_error(G_MODULE, 14);
      end if;

      -- проверка контрольного разряда
      if p_impdoc.nlsb <> vkrzn( substr(p_impdoc.mfob,1,5), p_impdoc.nlsb ) then
         bars_error.raise_nerror(G_MODULE, 'NOTCORECT_CHECK_DIGIT_B', p_impdoc.nlsb );
      end if;

      if p_impdoc.nlsb = p_impdoc.nlsa and p_impdoc.mfoa = p_impdoc.mfob then
         bars_error.raise_error(G_MODULE, 173);
      end if;

      if (p_impdoc.mfoa = p_impdoc.mfob and (p_impdoc.dk = 2  or  p_impdoc.dk = 3)) then
          bars_error.raise_nerror(G_MODULE, 'INNER_INFO_NOTALLOWED');
      end if;


      begin
         select blk,  mfo into l_blk, p_impdoc.mfob
         from banks where mfo = p_impdoc.mfob;
         if l_blk > 0 then
            bars_error.raise_error(G_MODULE, 95, p_impdoc.mfob);
         end if;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 96, p_impdoc.mfob);
      end;


      if p_impdoc.mfob = gl.amfo then
         begin
            select nls, dazs into p_impdoc.nlsb, l_dazs
            from accounts where nls = p_impdoc.nlsb and kv = p_impdoc.kv2;

            if l_dazs is not null then
               bars_error.raise_nerror(G_MODULE, 'CLOSE_PAYEE_ACCOUNT', p_impdoc.nlsa, to_char(p_impdoc.kv));
            end if;



         exception when no_data_found then
            begin   -- Для перехода на новый план счетов пытаемся найти по nlsalt новый счет если пришол старый
                    select nls, dazs into p_impdoc.nlsb, l_dazs
                    from accounts where nlsalt = p_impdoc.nlsb and kv = p_impdoc.kv2 AND dat_alt IS NOT NULL;
                 
                        if l_dazs is not null then
                           bars_error.raise_nerror(G_MODULE, 'CLOSE_PAYER_ACCOUNT', p_impdoc.nlsb, to_char(p_impdoc.kv));
                        end if;
            exception when no_data_found then 
            bars_error.raise_error(G_MODULE, 169, p_impdoc.nlsb||'('||p_impdoc.kv2||')' );
         end;
         end;
      else
        if p_impdoc.nlsb <> vkrzn(substr(p_impdoc.mfob,1,5), p_impdoc.nlsb) then
           bars_error.raise_error(G_MODULE, 86, p_impdoc.nlsb);
        end if;
      end if;




      p_impdoc.id_b := trim(p_impdoc.id_b);

      l_okpohk_code := validate_okpo(p_impdoc.id_b, 1);
      if l_okpohk_code <> 0 then
         bars_error.raise_error(G_MODULE, l_okpohk_code, p_impdoc.id_b);
      end if;


      begin
         l_int := to_number(p_impdoc.id_b);
      exception when others then
         bars_error.raise_error(G_MODULE, 92, p_impdoc.id_b);
      end;

      if length(p_impdoc.id_b) < 8 and p_impdoc.id_b<>'99999' then
         bars_error.raise_error(G_MODULE, 93, p_impdoc.id_b);
      end if;

      if v_okpo(p_impdoc.id_b) <> p_impdoc.id_b then
         bars_error.raise_error(G_MODULE, 94, p_impdoc.id_b);
      end if;


      -- Общие реквизиты
      if p_impdoc.nd is null then
         bars_error.raise_error(G_MODULE, 6);
      end if;

      if p_impdoc.datd is null then
         --bars_error.raise_error(G_MODULE, 7);
         p_impdoc.datd := gl.bd;
      end if;

      if p_impdoc.vdat is null then
         --bars_error.raise_error(G_MODULE, 7);
         p_impdoc.vdat := gl.bd;
      end if;

      if p_impdoc.s is null then
         bars_error.raise_error(G_MODULE, 16);
      end if;

      if p_impdoc.kv is null then
         bars_error.raise_error(G_MODULE, 17);
      end if;


      if p_impdoc.nazn is null or length(p_impdoc.nazn) < 3 then
         bars_error.raise_error(G_MODULE, 20);
      end if;
      --удалиь все лидирующие, конечные пробелы и непечатные символы
      p_impdoc.nazn := trim(translate(p_impdoc.nazn, G_x00_x1F, rpad(' ',32)));


      if p_impdoc.tt is null then
         bars_error.raise_error(G_MODULE, 21);
      end if;
      if p_impdoc.dk is null then
         bars_error.raise_error(G_MODULE, 22);
      end if;



      bars_audit.trace(l_trace||'sk = '||p_impdoc.sk);


      l_iscashA := is_cash(substr(p_impdoc.nlsa,1,4));
      l_iscashB := is_cash(substr(p_impdoc.nlsb,1,4));

      -- случай,  когда  подкрепление/изъятие банкоомата без дороги (1004-1001(тогда 66) или  1001-1004(тогда 39) )

      -- ( касса - касса)пополнение банкомата
      if l_iscashA = 1 and l_iscashB = 1 then
         if  ( ( substr(p_impdoc.nlsa,1,4) = '1004' and
                 substr(p_impdoc.nlsb,1,4) in ('1001','1002') and
                 p_impdoc.dk = 1
                 ) or
                 (substr(p_impdoc.nlsb,1,4) = '1004' and
                  substr(p_impdoc.nlsa,1,4) in ('1001','1002') and
                  p_impdoc.dk = 0
                 )
             ) and p_impdoc.sk <> 66 then
             bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_CASH66', to_char(p_impdoc.sk));
         end if;

         -- изъятие банкомата
         if  ( (substr(p_impdoc.nlsa,1,4) in ('1001','1002')  and
                 substr(p_impdoc.nlsb,1,4) = '1004' and
                 p_impdoc.dk = 1
                 ) or
                 (substr(p_impdoc.nlsb,1,4) in ('1001','1002')  and
                 substr(p_impdoc.nlsa,1,4) = '1004' and
                 p_impdoc.dk = 0
                 )
             ) and p_impdoc.sk <> 39 then
             bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_CASH39', to_char(p_impdoc.sk));
         end if;
      else
         if (  l_iscashA = 1  and p_impdoc.kv  = 980 )
            or
            (  l_iscashB = 1  and p_impdoc.kv2 = 980) then

            bars_audit.trace(l_trace||'кассовый документ');
            if p_impdoc.sk is null then
               bars_error.raise_error(G_MODULE, 165);
            end if;

            begin
               bars_audit.trace(l_trace||'проверяем наличие СКП');
               select sk into p_impdoc.sk from  sk
                where sk = p_impdoc.sk;
               bars_audit.trace(l_trace||'есть');
               -- прихiд каси
               if ( l_iscashA = 1 and p_impdoc.dk = 1)
                  or
                  ( l_iscashB = 1 and p_impdoc.dk = 0) then

                  if p_impdoc.sk < 2 or p_impdoc.sk > 39 then
                     bars_error.raise_error(G_MODULE, 97, to_char(p_impdoc.sk));
                  end if;
               else
               -- видаток каси
                  if ( l_iscashA = 1  and p_impdoc.dk = 0)
                     or
                     ( l_iscashB = 1  and p_impdoc.dk = 1) then

                     if p_impdoc.sk < 40 or p_impdoc.sk > 73 then
                        bars_error.raise_error(G_MODULE, 98, to_char(p_impdoc.sk));
                     end if;
                  end if;
               end if;

            exception when no_data_found then
               bars_audit.trace(l_trace||'даного ск не сущ');
               bars_error.raise_error(G_MODULE, 84, to_char(p_impdoc.sk));
            end;
         else
            p_impdoc.sk := null;
            --null;
         end if;
      end if;






      if (p_impdoc.kv2 <> p_impdoc.kv ) then
         if p_impdoc.s2 is null then
            bars_error.raise_error(G_MODULE, 24);
         end if;
      end if;



      --проверка на непечатные символы в назначении и наименовании
      if  translate(p_impdoc.nazn, G_x00_x1F, rpad(' ',32)) <> p_impdoc.nazn then
          bars_error.raise_nerror(G_MODULE, 'NOPRINT_CHAR_NAZN');
      end if;

      if  translate(p_impdoc.nam_a, G_x00_x1F, rpad(' ',32)) <> p_impdoc.nam_a then
          bars_error.raise_nerror(G_MODULE, 'NOPRINT_CHAR_NAMA');
      end if;

      if  translate(p_impdoc.nam_b, G_x00_x1F, rpad(' ',32)) <> p_impdoc.nam_b then
          bars_error.raise_nerror(G_MODULE, 'NOPRINT_CHAR_NAMB');
      end if;


   exception when others then
      bars_audit.error(l_trace||'Ошибка при валидации полей док-та №'||p_impdoc.nd);
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;

   -----------------------------------------------------------------
   --    IS_BISTAG
   --
   --    Является ли тег допревизита, тегом биса
   --    return 0 - нет, 1- да, это тег БИС-а
   --
   function is_bistag (p_tag varchar2) return smallint
   is
   begin
       if regexp_like( trim(p_tag) ,'(C|П)[0-9]{1,2}$') or trim(p_tag) = 'П'  then
          return 1;
       else
          return 0;
       end if;
   end;


   -----------------------------------------------------------------
   --    VALIDATE_DOC_ATTR
   --
   --    Провалидировать доп. реквизиты док-та
   --    Возвращает код ошибки или '0000' если все ОК
   --
   --    p_impref  - реф импортированного докумнета
   --
   --
   procedure  validate_doc_attr(
                  p_impdoc   xml_impdocs%rowtype,
                  p_dreclist bars_xmlklb.array_drec
)
   is
   begin
      bars_xmlklb.validate_attribs(
                  p_dreclist => p_dreclist    ,
                  p_s        => p_impdoc.s    ,
                  p_s2       => p_impdoc.s2   ,
                  p_kv       => p_impdoc.kv   ,
                  p_kv2      => p_impdoc.kv2  ,
                  p_nlsa     => p_impdoc.nlsa ,
                  p_nlsb     => p_impdoc.nlsb ,
                  p_mfoa     => p_impdoc.mfoa ,
                  p_mfob     => p_impdoc.mfob ,
                  p_tt       => p_impdoc.tt);

   end;


   -----------------------------------------------------------------
   --    DELETE_DOC
   --
   --    Удаление документа
   --
   --    p_impref  - реф импортированного докумнета
   --    p_errcode - код ошибки выполнения ('0000' - sucess)
   --
   procedure delete_doc(p_impref       number,
                        p_errcode  out varchar2)
   is
      l_status   smallint;
      l_trace    varchar2(1000) := G_TRACE||'delete_doc: ';
      l_impdoc   xml_impdocs%rowtype;
   begin
      -- установка тольк статуса удаленного
      --delete from xml_impdocsw where impref = p_impref;
      --delete from xml_impdocs  where impref = p_impref;
      check_if_doc_processed(p_impref);


      update xml_impdocs set status = G_DELETED
      where impref = p_impref and status not in (G_PAYED,G_DELETED);

      select * into l_impdoc from xml_impdocs where impref = p_impref;

      bars_audit.info(l_trace||' удаление докумета №'||l_impdoc.nd||' дата док.='||to_char(l_impdoc.datd, 'dd/mm/yyyy')||' сумма='||l_impdoc.s||' строна А(мфо,счет,окпо)='||l_impdoc.mfoa||','||l_impdoc.nlsa||','||l_impdoc.id_a||' строна Б(мфо,счет,окпо)= '||l_impdoc.mfob||','||l_impdoc.nlsb||','||l_impdoc.id_b);

      p_errcode := G_VALIDATE_OK;
   end;


   -----------------------------------------------------------------
   --    CONVERT_XMLDOC_TO_OPER
   --
   --    Трансформировать oper%rowtype к xm,xml_impdoc%rowtype
   --
   function convert_xmldoc_to_oper(p_doc  xml_impdocs%rowtype) return oper%rowtype
   is
      l_doc  oper%rowtype;
   begin

      l_doc.ref   := p_doc.ref  ;
      l_doc.tt    := p_doc.tt   ;
      l_doc.vob   := p_doc.vob  ;
      l_doc.nd    := p_doc.nd   ;
      l_doc.vdat  := p_doc.vdat ;
      l_doc.datd  := p_doc.datd ;
      l_doc.kv    := p_doc.kv   ;
      l_doc.kv2   := p_doc.kv2  ;
      l_doc.dk    := p_doc.dk   ;
      l_doc.s     := p_doc.s    ;
      l_doc.s2    := p_doc.s2   ;
      l_doc.sk    := p_doc.sk   ;
      l_doc.nam_a := p_doc.nam_a;
      l_doc.nlsa  := p_doc.nlsa ;
      l_doc.mfoa  := p_doc.mfoa ;
      l_doc.id_a  := p_doc.id_a ;
      l_doc.nam_b := p_doc.nam_b;
      l_doc.nlsb  := p_doc.nlsb ;
      l_doc.mfob  := p_doc.mfob ;
      l_doc.id_b  := p_doc.id_b ;
      return  l_doc;

   end;

   -----------------------------------------------------------------
   --    VALIDATE_DOC
   --
   --    Провалидировать поля документа и его доп. реквизиты по референсу импорта.
   --    Проставить ему статус и ошибку (если есть) валидации в базе
   --    Возвращает код ошибки или '0000' если все ОК
   --
   --    p_impref  - реф импортированного докумнета
   --    p_errcode - код ошибки валидирования ('0000' - sucess)
   --    p_errmsg  - текст ошибки
   --
   procedure validate_doc(p_impref       number,
                          p_errcode  out varchar2,
                          p_errmsg   out varchar2)
   is
      l_errcode   xml_impdocs.errcode%type;
      l_errmsg    xml_impdocs.errmsg%type;
      l_impdoc    xml_impdocs%rowtype;
      l_dreclist  bars_xmlklb.array_drec;
      i           number;
      l_trace     varchar2(1000) := G_TRACE||'validate_doc: ';
   begin

      check_if_doc_processed(p_impref);

      begin
         select * into  l_impdoc from xml_impdocs where impref = p_impref;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 162, to_char(p_impref));
      end;

      -- валидация реквизитов документа
      validate_doc_fields(l_impdoc);

      --валидация допреквизитов
      get_dreclist(p_impref, l_dreclist);
      validate_doc_attr(l_impdoc, l_dreclist);

      -- валидация шаблона операции
      bars_xmlklb.validate_tts_pattern(convert_xmldoc_to_oper(l_impdoc));

      update xml_impdocs
      set errcode = G_VALIDATE_OK, status = G_VALIDATED
      where impref = p_impref;

      p_errcode := G_VALIDATE_OK;
      p_errmsg  := 'Success';

   exception when others then
      bars_audit.error(l_trace||'Ошибка при валидации док-та №'||l_impdoc.nd);
      bars_audit.error(l_trace||sqlerrm);
      bars_xmlklb.get_process_error(sqlerrm, l_errcode, l_errmsg);
      -- если ошибка прикладная далее exception не выкидывается
      update xml_impdocs
      set errcode = l_errcode, errmsg = l_errmsg, status = G_NOVALID
      where impref = p_impref;

      p_errcode := l_errcode;
      p_errmsg  := l_errmsg;

   end;

   -----------------------------------------------------------------
   --    VALIDATE_DOC
   --
   --    Провалидировать поля документа и его доп. реквизиты по референсу импорта.
   --    Проставить ему статус и ошибку (если есть) валидации в базе
   --    Возвращает код ошибки или '0000' если все ОК
   --
   --    p_impref  - реф импортированного докумнета
   --    p_errcode - код ошибки валидирования ('0000' - sucess)
   --
   procedure validate_doc(p_impref       number,
                          p_errcode  out varchar2)
   is
      l_errmsg    xml_impdocs.errmsg%type;
   begin
      validate_doc(p_impref, p_errcode, l_errmsg);
   end;


   -----------------------------------------------------------------
   --    INSERT_DOC_TO_OPER
   --
   --    Вставить док-т в oper и в operw
   --
   --    p_impdoc      - структура док-та
   --
   procedure insert_doc_to_oper(
                  p_impdoc    in out xml_impdocs%rowtype,
                  p_ref              number,
                  p_dreclist     bars_xmlklb.array_drec
)
   is
      l_trace     varchar2(1000) := G_TRACE||'insert_doc_to_oper: ';
   begin

     if ( p_impdoc.id_b in ('0000000000','9999999999') )
     then
       if ( p_impdoc.d_rec is null )
       then
         p_impdoc.d_rec := '#ф'||'Клієнтом не надано'||'#';
       else
          p_impdoc.d_rec := p_impdoc.d_rec||'ф'||'Клієнтом не надано'||'#';
       end if;
     end if;

     gl.in_doc2(
             ref_   =>  p_ref,
             tt_    =>  p_impdoc.tt,
             vob_   =>  p_impdoc.vob,
             nd_    =>  p_impdoc.nd,
             pdat_  =>  sysdate,         -- дата системная вставки в OPER
             vdat_  =>  p_impdoc.vdat,   -- банковская дата ипорта файла
             dk_    =>  p_impdoc.dk,
             kv_    =>  p_impdoc.kv,
             s_     =>  p_impdoc.s,
             kv2_   =>  p_impdoc.kv2,
             s2_    =>  p_impdoc.s2,
             sq_    =>  0,
             sk_    =>  p_impdoc.sk,
             data_  =>  p_impdoc.datd,   -- дата документа (из файла импорта)
             datp_  =>  p_impdoc.datp,   -- дата прихода в банк (из файла импорта)
             nam_a_ =>  p_impdoc.nam_a,
             nlsa_  =>  p_impdoc.nlsa,
             mfoa_  =>  p_impdoc.mfoa,
             nam_b_ =>  p_impdoc.nam_b,
             nlsb_  =>  p_impdoc.nlsb,
             mfob_  =>  p_impdoc.mfob,
             nazn_  =>  p_impdoc.nazn,
             d_rec_ =>  p_impdoc.d_rec,
             id_a_  =>  p_impdoc.id_a,
             id_b_  =>  p_impdoc.id_b,
             id_o_  =>  null,
             sign_  =>  null,
             sos_   =>  0,
             prty_  =>  0,
             uid_   =>  p_impdoc.userid);

      for i in  0..p_dreclist.count-1 loop
          -- вставка доп. реквизитов
          if ( p_dreclist(i).tag is not null and
               p_dreclist(i).val is not null ) then
             begin
                bars_audit.trace(l_trace||'вставка реквизита <'||p_dreclist(i).tag||'>');
                insert into operw(ref, tag, value)
                values(p_ref, p_dreclist(i).tag, p_dreclist(i).val);
             exception when others then
                case sqlcode
                   when  -02291  then bars_error.raise_error(G_MODULE, 31, p_dreclist(i).tag); -- integrity constraint (BARS.FK_OPERW_OPFIELD) violated - parent key not found
                   when  -1      then bars_error.raise_error(G_MODULE, 62, p_dreclist(i).tag, to_char(p_ref) ); -- unique constraint
                   else raise;
               end case;
             end;
          else
             if  p_dreclist(i).tag is null then
                 bars_error.raise_error(G_MODULE, 32);
             end if;
             if  p_dreclist(i).val is null then
                 if is_bistag( p_dreclist(i).tag ) = 1 then
                    bars_error.raise_error(G_MODULE, 174, p_dreclist(i).tag);
                 else
                    bars_error.raise_error(G_MODULE, 163, p_dreclist(i).tag);
                 end if;
             end if;
          end if;

       end loop;

      if p_impdoc.bis = 1 then
         update oper set bis = p_impdoc.bis where ref = p_ref;
      end if;

      if p_impdoc.fn is not null then
         insert into operw(ref, tag, value)
         values(p_ref, 'IMPFL', p_impdoc.fn);
      end if;

   exception when others then
      bars_audit.error(l_trace||'Ошибка при вставке док-та в OPER док-та №'||p_impdoc.nd);
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;




   -----------------------------------------------------------------
   --    GLPAY_DOC
   --
   --    Оплатить док-т кот. только что вставили в oper
   --
   --    p_impdoc      - структура док-та
   --
   procedure glpay_doc(p_impdoc    in out xml_impdocs%rowtype,
                       p_ref   number)
   is
      l_trace         varchar2(1000) := G_TRACE||'glpay_doc: ';
      l_int           number;
      l_blk           number;
      l_sos           smallint;
      l_paymode       number(1); -- как платить(по-факту, по-плану)
   begin

      -- 37 - Оплата по факт.залишку = 1 / По план.залишку = 0 / Не платити = 2
      begin
         select substr(flags,38,1) as flag37
         into   l_paymode from   tts
         where  tt = p_impdoc.tt;
      exception when no_data_found then
         l_paymode   := 0;
      end;

      bars_audit.trace(l_trace||'перед gl.dyntt2');

      gl.dyntt2 (
         sos_   => l_sos,
         mod1_  => l_paymode,
         mod2_  => 1,
         ref_   => p_ref,
         vdat1_ => p_impdoc.vdat,
         vdat2_ => p_impdoc.vdat,
         tt0_   => p_impdoc.tt,
         dk_    => p_impdoc.dk,
         kva_   => p_impdoc.kV,
         mfoa_  => p_impdoc.mfoa,
         nlsa_  => p_impdoc.nlsa,
         sa_    => p_impdoc.s,
         kvb_   => p_impdoc.kv2,
         mfob_  => p_impdoc.mfob,
         nlsb_  => p_impdoc.nlsb,
         sb_    => p_impdoc.s2,
         sq_    => 0,
         nom_   => 0);

   -- установка записи  в oper_list
   chk.put_visa (p_ref, p_impdoc.tt, null, 0, null, null, null);

   exception
     when others then
       bars_audit.error(l_trace||'ошибка  оплаты док-та:');
       bars_audit.error(l_trace||sqlerrm);
       raise;
   end glpay_doc;


   -----------------------------------------------------------------
   --    ADD_FLD
   --
   --    добавление поля через запятую
   --
   function add_fld(p_dest    varchar2,
                    p_colname varchar2,
                    p_colval  varchar2,
                    p_coltype char) return varchar2
   is
      l_tmp varchar2(2000);
      l_trace     varchar2(1000) := G_TRACE||'add_fld: ';
   begin

      l_tmp := p_colname||'=';


      if p_coltype = 'C' then
         l_tmp := l_tmp || ''''||replace(p_colval,'''','''''')||'''';
      else
         if p_colval is null then
            l_tmp := l_tmp || 'null';
         else
            l_tmp := l_tmp || p_colval;
         end if;
      end if;

      bars_audit.trace(l_trace||'l_tmp = '||l_tmp);

      if length(nvl(p_dest,'')) > 0 then
         l_tmp := p_dest||','||l_tmp;
      end if;


      return l_tmp;
   end;





   -----------------------------------------------------------------
   --    UPDATE_DOCBIS
   --
   --    Обновить бис. строку для документа
   --
   --    p_impref  - реф. документа импорта
   --    p_bistag  - тег биса, наприм. С01
   --    p_bisval  - значение биса
   --
   procedure  update_docbis(
                  p_impref   number,
                  p_bistag   varchar2,
                  p_bisval   varchar2,
                  p_action   smallint)
   is
      l_trace     varchar2(1000) := G_TRACE||'update_docbis: ';
   begin

      check_if_doc_processed(p_impref);

      bars_audit.info(l_trace||'Обновление строки БИС для имп.реф '||p_impref||' тег:'||p_bistag||', значение:'||p_bisval);

      update xml_impdocsw set value =  p_bisval
      where impref = p_impref and tag = p_bistag;

      case p_action
         when G_ACT_DEL then
              bars_audit.trace(l_trace||'Удаление');
              delete from xml_impdocsw where tag = p_bistag and impref = p_impref;
         when G_ACT_UPD then
              bars_audit.trace(l_trace||'Измеение');
              update xml_impdocsw set value = p_bisval where tag = p_bistag and impref = p_impref;
         when G_ACT_ADD then
              begin
                 bars_audit.trace(l_trace||'Вставка нового');
                 insert into xml_impdocsw(impref, tag, value)
                 values(p_impref, p_bistag, p_bisval);
              exception when others then
                 case sqlcode
                      when -02291 then bars_error.raise_error(G_MODULE, 175, p_bistag); -- integrity constraint (BARS.XFK_XMLIMPDOCSW) violated - parent key
                      when -1     then bars_error.raise_error(G_MODULE, 176, p_bistag); -- DUP_VAL_ON_INDEX
                      else raise;
                 end case;
             end;

      end case;
   exception when others then
      bars_audit.error(l_trace||'Ошибка обновлений доп. реквизитов');
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;







   -----------------------------------------------------------------
   --    UPDATE_DOCDREC
   --
   --    Обновить доп. реквизит для документа
   --
   --    p_impref  - реф. документа импорта
   --    p_bistag  - тег биса, наприм. С01
   --    p_bisval  - значение биса
   --    p_action  - (0-удалить, 1-изменить 2-добавить)
   --
   procedure  update_docdrec(
                  p_impref   number,
                  p_tag      varchar2,
                  p_val      varchar2,
                  p_action   smallint)
   is
      l_trace     varchar2(1000) := G_TRACE||'update_docdrec: ';
   begin

      check_if_doc_processed(p_impref);

      bars_audit.info(l_trace||'Обновление доп. реквизита для имп.док '||p_impref||' реквизит:'||p_tag||', значение:'||p_val||', тип дейсвия:'||p_action);

      case p_action
           when G_ACT_DEL then
                   bars_audit.trace(l_trace||'Удаление');
                  delete from xml_impdocsw where tag = p_tag and impref = p_impref;
           when G_ACT_UPD then
                  bars_audit.trace(l_trace||'Измеение');
                  update xml_impdocsw set value = p_val where tag = p_tag and impref = p_impref;
           when G_ACT_ADD then
                             begin
                                bars_audit.trace(l_trace||'Вставка нового');
                                insert into xml_impdocsw(impref, tag, value)
                                values(p_impref, p_tag, p_val);
                             exception when others then
                                case sqlcode
                                     when -02291 then bars_error.raise_error(G_MODULE, 175, p_tag); -- integrity constraint (BARS.XFK_XMLIMPDOCSW) violated - parent key
                                     when -1     then bars_error.raise_error(G_MODULE, 176, p_tag); -- DUP_VAL_ON_INDEX
                                     else raise;
                                end case;
                             end;

      end case;
   exception when others then
      bars_audit.error(l_trace||'Ошибка обновлений доп. реквизитов');
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;

   -----------------------------------------------------------------
   --    CHANGED
   --
   --    Сравнить два значения - оригнинальное и измененное и сказать равны они или нет
   --     если неравны - выдать 1
   --     если равны выдать 0
   --
   function changed(p_old varchar2, p_new varchar2) return boolean
   is
   begin
      if (p_old is null and p_new is not null) or
         (p_new is null and p_old is not null) or
         (p_new <> p_old) then
         return true;
      else
         return false;
      end if;

   end;

   -----------------------------------------------------------------
   --    CHANGED
   --
   --    Сравнить два значения - оригнинальное и измененное и сказать равны они или нет
   --     если неравны - выдать 1 (true)
   --     если равны выдать 0  (false)
   --
   function changed(p_old number, p_new number) return boolean
   is
   begin
      if (p_old is null and p_new is not null) or
         (p_new is null and p_old is not null) or
         (p_new <> p_old) then
         return true;
      else
         return false;
      end if;
   end;


   -----------------------------------------------------------------
   --    UPDATE_DOC
   --
   --    Обновить реквизиты док-та по рефу
   --
   --    p_impref  - реф. документа импорта
   --    p_errcode - код ошибки воплаты ('0000' - sucess)
   --
   procedure  update_doc(
                  p_impref       number,
                  p_mfoa         varchar2  default null,
                  p_nlsa         varchar2  default null,
                  p_ida          varchar2  default null,
                  p_nama         varchar2  default null,
                  p_mfob         varchar2  default null,
                  p_nlsb         varchar2  default null,
                  p_idb          varchar2  default null,
                  p_namb         varchar2  default null,
                  p_nazn         varchar2  default null,
                  p_s            number    default 0,
                  p_sk           number    default 0,
                  p_kv           number
)
   is
      l_columns   varchar2(2000) := null;
      l_sql       varchar2(8000);
      l_s2        number;
      l_kv        number;
      l_kv2       number;
      l_doc       xml_impdocs%rowtype;
      l_trace     varchar2(1000) := G_TRACE||'update_doc: ';
   begin

      check_if_doc_processed(p_impref);




      select * into l_doc from xml_impdocs where impref = p_impref;

      bars_audit.info(l_trace||'Изменение реквизитов имп.док №'||l_doc.nd||' дата док.='||to_char(l_doc.datd, 'dd/mm/yyyy')||' сумма='||l_doc.s||' строна А(мфо,счет,окпо)='||l_doc.mfoa||','||l_doc.nlsa||','||l_doc.id_a||' строна Б(мфо,счет,окпо)= '||l_doc.mfob||','||l_doc.nlsb||','||l_doc.id_b);

      if changed(p_mfoa, l_doc.mfoa) then
         l_columns := add_fld(l_columns,'mfoa', p_mfoa, 'C');
         bars_audit.info(l_trace||'Изменение MFOA на '||p_mfoa);
      end if;




      if changed(p_nlsa, l_doc.nlsa) then
         bars_audit.trace(l_trace||'добавляем поле '||p_nlsa);
         if length(p_nlsa) > 14 then
            bars_error.raise_error(G_MODULE, 185, p_nlsa);
         end if;
         l_columns := add_fld(l_columns,'nlsa', p_nlsa, 'C');
         bars_audit.info(l_trace||'Изменение Счета А на '||p_nlsa);
      end if;

      if changed(p_ida, l_doc.id_a)  then
         l_columns := add_fld(l_columns,'id_a', p_ida, 'C');
         bars_audit.info(l_trace||'Изменение ОКПО А на '||p_ida);
      end if;

      if changed(p_nama, l_doc.nam_a)  then
         if length(p_nama) > 38 then
            bars_error.raise_error(G_MODULE, 186, p_nama);
         end if;
     l_columns := add_fld(l_columns,'nam_a', p_nama, 'C');
     bars_audit.info(l_trace||'Изменение наим.отправителя на '||p_nama);
      end if;

      if changed(p_mfob, l_doc.mfob) then
         l_columns := add_fld(l_columns,'mfob',p_mfob, 'C');
         bars_audit.info(l_trace||'Изменение MFO Б на '||p_mfob);

      end if;

      if changed(p_nlsb, l_doc.nlsb)  then
         if length(p_nlsb) > 14 then
            bars_error.raise_error(G_MODULE, 185, p_nlsb);
         end if;
     l_columns := add_fld(l_columns,'nlsb',p_nlsb, 'C');
         bars_audit.info(l_trace||'Изменение Счета Б на '||p_nlsb);
      end if;

      if changed(p_idb, l_doc.id_b)  then
         l_columns := add_fld(l_columns,'id_b', p_idb, 'C');
         bars_audit.info(l_trace||'Изменение ОКПО Б на '||p_idb);
      end if;

      if changed(p_namb, l_doc.nam_b)  then
         if length(p_namb) > 38 then
            bars_error.raise_error(G_MODULE, 186, p_namb);
         end if;
     l_columns := add_fld(l_columns,'nam_b', p_namb, 'C');
         bars_audit.info(l_trace||'Изменение наим.получателя на '||p_namb);
      end if;

      if changed(p_nazn , l_doc.nazn) then
         if length(p_nazn) > 160 then
            bars_error.raise_error(G_MODULE, 187);
         end if;
         l_columns := add_fld(l_columns,'nazn',p_nazn, 'C');
         bars_audit.info(l_trace||'Изменение назначения '||p_nazn);
      end if;


      if changed(p_s, l_doc.s) then
         l_columns := add_fld(l_columns,'s',  p_s, 'N');
         l_columns := add_fld(l_columns,'s2', p_s, 'N');

         bars_audit.info(l_trace||'Изменение суммы '||p_s);

      end if;

      if changed(p_sk , l_doc.sk)  then
         l_columns := add_fld(l_columns,'sk', p_sk, 'N');
         bars_audit.info(l_trace||'Изменение символа кассы '||p_sk);
      end if;


      if l_columns is not null then

         --l_columns := add_fld(l_columns,'status', G_IMPORTED, 'N');

         l_sql := 'update xml_impdocs set '||l_columns|| ' where impref = '||p_impref;
         bars_audit.trace(l_trace||'выполнение изменений реквизитов: '||l_sql);
         execute immediate l_sql;
      else
         bars_audit.trace(l_trace||'никакие поля не изменены'||l_sql);
      end if;

   exception when others then
      bars_audit.error(l_trace||'ошибка  изменений реквизитов:');
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    PAY_EXTERN_DOC
   --
   --    Оплатить внешний докумнет
   --    p_doc     - структура документа с доп. реквизитами
   --    p_errcode - исходящий код ошибки
   --    p_errmsg  - исходящее сообщение об ошибке
   --
   --    В поле p_doc.doc.ref - будет находиться реф БАРС-а
   --
   procedure  pay_extern_doc(p_doc     in out t_doc,
                             p_errcode    out varchar2,  -- исходящий код ошибки
                             p_errmsg     out varchar2)  -- исходящее сообщение об ошибке
   is
      l_errcode   xml_impdocs.errcode%type;
      l_errmsg    xml_impdocs.errmsg%type;
      l_dreclist  bars_xmlklb.array_drec;
      l_impdoc    xml_impdocs%rowtype;
      l_ref       number;
      l_trace     varchar2(1000) := G_TRACE||'pay_extern_doc: ';
   begin

      l_impdoc   := p_doc.doc;
      l_dreclist := p_doc.drec;

      -- валидация реквизитов документа
      validate_doc_fields(l_impdoc);

      -- валидация полномочий на совершение оплаты
      validate_pay_rights(l_impdoc);

      -- валидация допреквизитов
      validate_doc_attr(l_impdoc, l_dreclist);

      begin
         savepoint before_pay;

         gl.ref(l_ref);

         insert_doc_to_oper(l_impdoc, l_ref, l_dreclist);
         if l_impdoc.dk <= 1 then
            glpay_doc(l_impdoc, l_ref);
            bars_audit.info(l_trace||'Док-т с имп.рефом '||l_impdoc.impref||' оплачен рефом '||l_ref);
         else
            bars_audit.info(l_trace||'Док-т с имп.рефом '||l_impdoc.impref||' информационный - без оплаты');
         end if;


         p_errcode := G_VALIDATE_OK;
         bars_audit.info(l_trace||'Док-т с имп.рефом '||l_impdoc.impref||' с рефом '||l_ref);

         p_doc.doc.ref := l_ref;

      exception when others then
         rollback to before_pay;
         raise;
      end;

   exception when others then
      bars_audit.error(l_trace||'Ошибка при оплате док-та с имп.рефом '||l_impdoc.impref);
      bars_audit.error(l_trace||sqlerrm);
      bars_xmlklb.get_process_error(sqlerrm, l_errcode, l_errmsg);
      -- если ошибка прикладная далее exception не выкидывается
      p_errcode := l_errcode;
      p_errmsg  := l_errmsg;
   end;



   -----------------------------------------------------------------
   --    PAY_EXTERN_DOC
   --
   --    Оплатить внешний докумнет
   --
   --
   procedure  pay_extern_doc(p_extref         varchar2,     -- внешний реф
                             p_nd             varchar2,     -- № док-та
                             p_datd           date,         -- дата док-та
                             p_vdat           date,
                             p_nama           varchar2,
                             p_mfoa           varchar2,
                             p_nlsa           varchar2,
                             p_ida            varchar2,
                             p_namb           varchar2,
                             p_mfob           varchar2,
                             p_nlsb           varchar2,
                             p_idb            varchar2,
                             p_s              number,
                             p_kv             number,
                             p_s2             number,
                             p_kv2            number,
                             p_sk             number,
                             p_dk             number,
                             p_tt             varchar2,
                             p_vob            number,
                             p_nazn           varchar2,
                             p_userid         number,
                             p_tag1           varchar2 default null,  -- тег доп.реквизита №1
                             p_val1           varchar2 default null,  -- значение доп.реквизита №1
                             p_tag2           varchar2 default null,  -- тег доп.реквизита №2
                             p_val2           varchar2 default null,  -- значение доп.реквизита №2
                             p_tag3           varchar2 default null,  -- тег доп.реквизита №3
                             p_val3           varchar2 default null,  -- значение доп.реквизита №3
                             p_errcode    out varchar2,  -- исходящий код ошибки
                             p_errmsg     out varchar2,  -- исходящее сообщение об ошибке
                             p_barsref    out number  )  -- реф. БАРС-а для оплаченного док-та
   is
      l_doc       t_doc;
      l_dreclist  bars_xmlklb.array_drec;
      l_impdoc    xml_impdocs%rowtype;
      i           number := 0;
      l_trace     varchar2(1000) := G_TRACE||'pay_extern_doc: ';
   begin

      if p_tag1 is not null then
         l_dreclist(i).tag := p_tag1;
         l_dreclist(i).val := p_val1;
         i := i + 1;
      end if;

      if p_tag2 is not null then
         l_dreclist(i).tag := p_tag2;
         l_dreclist(i).val := p_val2;
         i := i + 1;
      end if;

      if p_tag3 is not null then
         l_dreclist(i).tag := p_tag3;
         l_dreclist(i).val := p_val3;
         i := i + 1;
      end if;


      l_impdoc.ref_a  := p_extref ;
      l_impdoc.impref := p_extref ;
      l_impdoc.nd     := p_nd     ;
      l_impdoc.datd   := p_datd   ;
      l_impdoc.vdat   := p_vdat   ;
      l_impdoc.nam_a  := p_nama   ;
      l_impdoc.mfoa   := p_mfoa   ;
      l_impdoc.nlsa   := p_nlsa   ;
      l_impdoc.id_a   := p_ida    ;
      l_impdoc.nam_b  := p_namb   ;
      l_impdoc.mfob   := p_mfob   ;
      l_impdoc.nlsb   := p_nlsb   ;
      l_impdoc.id_b   := p_idb    ;
      l_impdoc.s      := p_s      ;
      l_impdoc.kv     := p_kv     ;
      l_impdoc.s2     := p_s2     ;
      l_impdoc.kv2    := p_kv2    ;
      l_impdoc.sk     := p_sk     ;
      l_impdoc.dk     := p_dk     ;
      l_impdoc.tt     := p_tt     ;
      l_impdoc.vob    := p_vob    ;
      l_impdoc.nazn   := p_nazn   ;
      l_impdoc.datp   := gl.bd    ;
      l_impdoc.userid := p_userid ;

      l_doc.doc  := l_impdoc;
      l_doc.drec := l_dreclist;

      pay_extern_doc( p_doc     => l_doc,
                      p_errcode => p_errcode,
                      p_errmsg  => p_errmsg );

      p_barsref := l_doc.doc.ref;

   end;




   -----------------------------------------------------------------
   --    PAY_DOC
   --
   --    Оплатить выбранный док-т по рефу
   --
   --    p_impref  - реф. документа импорта
   --    p_errcode - код ошибки воплаты ('0000' - sucess)
   --
   --    данная функция не выдает никаких exception-ов при неуспешной оплате,
   --    она откатывает вставку и оплату документа и отдает код ошибки оплаты
   --    в переменную p_errcode
   --
   procedure  pay_doc(p_impref       number,
                      p_errcode  out varchar2)
   is
      l_errcode   xml_impdocs.errcode%type;
      l_errmsg    xml_impdocs.errmsg%type;
      l_impdoc    xml_impdocs%rowtype;
      l_dreclist  bars_xmlklb.array_drec;
      l_ref       number;
      i           number;
      l_trace     varchar2(1000) := G_TRACE||'pay_doc: ';
   begin

      check_if_doc_processed(p_impref);

      begin
         select * into  l_impdoc from xml_impdocs where impref = p_impref;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE, 162, to_char(p_impref));
      end;

      if l_impdoc.status = G_PAYED  or
         l_impdoc.status = G_DELETED then
         bars_error.raise_error(G_MODULE, 163, l_impdoc.fn, l_impdoc.nd);
      end if;


      begin

         get_dreclist(p_impref, l_dreclist);

         --if l_impdoc.status = G_IMPORTED or l_impdoc.status = G_NOVALID  then

        -- валидация реквизитов документа
            validate_doc_fields(l_impdoc);
            -- валидация полномочий на совершение оплаты
            validate_pay_rights(l_impdoc);
        -- валидация допреквизитов
            validate_doc_attr(l_impdoc, l_dreclist);
            -- валидация шаблона операции
            bars_xmlklb.validate_tts_pattern(convert_xmldoc_to_oper(l_impdoc));
         --end if;


         begin
            savepoint before_pay;

            gl.ref(l_ref);

            insert_doc_to_oper(l_impdoc, l_ref, l_dreclist);


            if l_impdoc.dk <= 1 then
               glpay_doc(l_impdoc,  l_ref);
               bars_audit.info(l_trace||'Док-т с имп.рефом '||l_impdoc.impref||' оплачен рефом '||l_ref);
            else
               bars_audit.info(l_trace||'Док-т с имп.рефом '||l_impdoc.impref||' информационный - без оплаты');
            end if;


            update xml_impdocs
               set errcode = G_VALIDATE_OK, status = G_PAYED, ref = l_ref
             where impref = p_impref;


            p_errcode := G_VALIDATE_OK;
            bars_audit.info(l_trace||'Док-т с имп.рефом '||l_impdoc.impref||' оплачен рефом '||l_ref);
         exception when others then
            rollback to before_pay;
            raise;
         end;

      exception when others then

        bars_audit.error(l_trace||'Ошибка при оплате док-та с имп.рефом '||l_impdoc.impref);
        bars_audit.error(l_trace||sqlerrm);
        bars_xmlklb.get_process_error(sqlerrm, l_errcode, l_errmsg);
        -- если ошибка прикладная далее exception не выкидывается
        update xml_impdocs
        set errcode = l_errcode, errmsg = l_errmsg, status = G_NOVALID
        where impref = p_impref;
        p_errcode := l_errcode;
     end;


   end;




   -----------------------------------------------------------------
   --    CLEAR_IMPORT_JOURNALS
   --
   --    Удалить всю ненужную информацию про импорт (для оплаченных и удаленных документов)
   --
   --    p_date -  по какую дату ( НЕ включая)
   --
   procedure  clear_import_journals(p_date  date)   is
      l_trace   varchar2 (1000) := G_TRACE||'clear_imp_journals: ';
	  l_date date;
   begin
		
	  if p_date >= dat_next_u(gl.bd, - 5) then
	      bars_audit.info(l_trace||'Данные за последние 5 дней еще храним. Меняем дату '||to_char(p_date,'dd/mm/yyyy'));
		  l_date := dat_next_u(gl.bd, - 5);
	  else
	      l_date := p_date;
	  end if;
      bars_audit.info(l_trace||'Начало очистки журналов импорта по '||to_char(l_date,'dd/mm/yyyy') ||' (не вкючая)' );

      for c in (select impref
                  from xml_impdocs
                 where (status in (G_PAYED, G_DELETED) and dat < l_date)
                    or dat < sysdate - 30
               ) loop
          delete from xml_impdocsw where impref = c.impref;
          delete from xml_impdocs  where impref = c.impref;
      end loop;


      for c in ( select fn, dat, kf
                 from  ( select f.fn, f.dat, f.kf, impref
                           from xml_impfiles f, xml_impdocs d
                          where f.fn  = d.fn(+)
                            and f.dat = d.dat(+)
                            and f.kf  = d.kf(+)
                       )
                 where impref is null
                   and dat < l_date
               ) loop
           delete from xml_impfiles where fn = c.fn and  dat = c.dat and  kf= c.kf;
      end loop;

      bars_audit.info(l_trace||'Очистка журналов закончена');

   end;







   -----------------------------------------------------------------
   --    INIT_MISSING_FIELDS
   --
   --    Некоторые поля могут отсутствовать, например окпо или наименование клиета
   --    поскольку они  наши. Их нужно добавить
   --    Так же инициализируется дата валютировнаияЮ если это корректирующие проводки
   --
   procedure init_missing_fields(p_doc    in out oper%rowtype,
                                 p_impref in number )
   is
      l_trace     varchar2(1000) := G_TRACE||'init_missing_fields: ';
   begin

      if p_doc.nazn is null then
         p_doc.nazn := 'Автозгенероване призначення платежу. Модуль імпорту із зовнішніх задач';
      end if;
      if p_doc.nd is null then
         p_doc.nd :=  p_impref;
      end if;

      if p_doc.nam_a is null or
         p_doc.id_a  is null    then
         bars_audit.trace(l_trace||'недостаточно реквизитов стороны А');

         get_participant_details(
                   p_mfo   => p_doc.mfoa,
           p_nls   => p_doc.nlsa,
           p_kv    => p_doc.kv,
           p_dk    => 0,
           p_force => 0,
           p_nmk   => p_doc.nam_a,
           p_okpo  => p_doc.id_a);

         bars_audit.trace(l_trace||'реквизиты для '||p_doc.nlsa||': '||p_doc.mfoa||' наимен:'||p_doc.nam_a||' окпо:'||p_doc.id_a);

      end if;


      -- если отсутствуют реквизиты стороны B - возможно это наш счет
      if p_doc.nam_b is null or
         p_doc.id_b  is null    then
         bars_audit.trace(l_trace||'недостаточно реквизитов стороны B');
         get_participant_details(
                   p_mfo   => p_doc.mfob,
           p_nls   => p_doc.nlsb,
           p_kv    => p_doc.kv,
           p_dk    => 0,
           p_force => 0,
           p_nmk   => p_doc.nam_b,
           p_okpo  => p_doc.id_b);

            bars_audit.trace(l_trace||'реквизиты для '||p_doc.nlsb||': '||p_doc.mfob||' наимен:'||p_doc.nam_b||' окпо:'||p_doc.id_b);

      end if;

      -- для корректирующих установить дату валютирования в последнюю дату (банковську)
      -- прошлого месяца
      if p_doc.tt = '096' then
         p_doc.datp := p_doc.vdat;
         p_doc.datd := trunc(sysdate);
         p_doc.vdat := dat_next_u(trunc(gl.bd, 'MM'),-1);  --add_months(last_day(gl.bd),-1);
      else
         p_doc.datp := p_doc.vdat;
         p_doc.vdat := gl.bd;
      end if;
   end;

   -----------------------------------------------------------------
   --    INSERT_EXTERN_DOCS()
   --
   --    c проверкой на валидность
   --    p_pack   - входящий пакет
   --    p_needreply - требуется или нет исходящий ответ
   --    p_outdomdoc - исходящий ответ
   --
   procedure insert_extern_docs(p_pack             bars_xmlklb.t_pack,
                                p_needreply        number default 0,
                                p_outdomdoc in out dbms_xmldom.DOMDocument)
   is

      l_ndlist       dbms_xmldom.DOMNodeList;
      l_nd           dbms_xmldom.DOMNode;
      l_xmldoc       dbms_xmldom.DOMDocument;

      i              number;
      l_bisflg       smallint;
      l_dreclist     bars_xmlklb.array_drec;
      l_doc          oper%rowtype;
      l_impdoc       xml_impdocs%rowtype;
      l_errumsg      err_texts.err_msg%type;
      l_errcode      varchar2(10)             := '0000';
      l_errmsg       err_texts.err_msg%type   := 'Success';
      l_impref       number                   := 0;
      l_trace        varchar2(1000)           := G_TRACE||'insert_ext_docs: ';
      l_docerr       varchar2(1000);

   begin

      -- принитить допустимые доп реквизиты
      if opfield_list.count  = 0 then
         for c in (select tag from op_field) loop
            opfield_list(c.tag) := 0;
        end loop;
      end if;

      l_xmldoc   := bars_xmlklb.parse_clob(p_pack.cbody);
      l_ndlist   := dbms_xslprocessor.selectNodes(dbms_xmldom.makeNode(l_xmldoc), '/Body/PMNT');

      bars_audit.trace(l_trace||'всего док-тов='|| dbms_xmldom.getLength(l_ndlist));


      for i in 0 .. dbms_xmldom.getLength(l_ndlist) - 1  loop

          l_nd      := dbms_xmldom.item(l_ndlist, i);
          l_bisflg  := null;
          -- При инициализации полей и аттрибутов если и случается какая-то
          -- ошибка, то она системная. Ошибки оплаты - будут показаны только при
          -- оплате или валидации докумнета

          -- инициализировать поля док-та
          bars_audit.trace(l_trace||'начало инициализации полей док-та');
          bars_xmlklb.init_doc_fields(l_nd, 'PMNT', '', l_doc);
          bars_audit.trace(l_trace||'Документ: '||bars_xmlklb.print_doc(l_doc));


          --вставка док-та в БД с прверкой реквизитов
          bars_audit.trace(l_trace||'начало вставки док-та файла '||p_pack.hdr.pack_name||' датой '||to_char(gl.bd,'dd/mm/yyyy') );
          l_impref := s_xmlimpdocs.nextval;
         -- добавить недостающие значение  - реквизиты сторон, если их нету и если они наши
          init_missing_fields(l_doc, l_impref);

          -- получить доп. реквизиты документа
          bars_xmlklb.get_doc_attribs(l_nd, 'Body_PMNT/Payment/AddAttributes/Attribute', l_dreclist);


          -- по некоторым доп. реквизитам  - заполнить поля док-та (Наприм bis)
          bars_xmlklb.apply_attribs_to_doc(l_doc, l_dreclist);


          for j in 0 .. l_dreclist.count - 1 loop
             if is_bistag(l_dreclist(j).tag) = 1   then
                l_bisflg := 1;
                exit;
             end if;
          end loop;



       insert into xml_impdocs(
              fn, dat, impref,
              mfoa, nlsa, id_a, nam_a,
              mfob, nlsb, id_b, nam_b,
              s, s2,
              kv, kv2, dk, nd, tt, nazn, vob, d_rec, sk, bis,
              datd,   -- дата документа
              datp,   -- дата поступления в банк А
              vdat,   -- дата валютирования
              ref_a,  -- уникальный номер дкумента породившей системы
              status)
           values (
              p_pack.hdr.pack_name, gl.bd, l_impref ,
              l_doc.mfoa, l_doc.nlsa, l_doc.id_a, l_doc.nam_a,
              l_doc.mfob, l_doc.nlsb, l_doc.id_b, l_doc.nam_b,
              l_doc.s, l_doc.s2,
              l_doc.kv, l_doc.kv2,
              l_doc.dk, l_doc.nd, l_doc.tt, l_doc.nazn,  l_doc.vob, l_doc.d_rec, l_doc.sk, l_bisflg,
              l_doc.datd,  -- дата документа             -  из поля DocDate из файла импорта
              l_doc.datp,  -- дата поступления в банк А  -  из поля ValueDate из файла импорта
              l_doc.vdat,  -- дата валютирования         -  банковская дата импорта файла
              l_doc.ref_a,
              G_IMPORTED);


           for j in 0 .. l_dreclist.count - 1 loop
              if  opfield_list.exists(l_dreclist(j).tag) then
             insert into xml_impdocsw(impref, tag, value)
                 values(l_impref,decode( trim(l_dreclist(j).tag), chr(207),'C',l_dreclist(j).tag) , l_dreclist(j).val);
          end if;
           end loop;


           -- если требуется ответ
       if p_needreply = 1 then
              validate_doc(l_impref, l_errcode, l_errumsg);
              -- вставить код ошибки для данного документа
              bars_xmlklb.create_reply (
                    p_errcode    =>  l_errcode,
                    p_errdetail  =>  l_errumsg,
                    p_clbref     =>  l_doc.ref_a,
                    p_brsref     =>  l_impref,
                    p_doc        =>  p_outdomdoc);
           end if;


       bars_audit.info(l_trace||'Док-т №'||l_doc.nd||' импортирован с реф. '||l_impref);
           -- очистить список доп.реквизтов
       l_dreclist.delete;
           l_doc := null;

      end loop;

      bars_context.set_context;

      dbms_xmldom.freedocument(l_xmldoc);

   exception when others then
       bars_context.set_context;

       if not dbms_xmldom.isnull(l_xmldoc) then
          dbms_xmldom.freedocument(l_xmldoc);
       end if;

       bars_audit.error(l_trace||'Ошибка обработки пакета документов: ');
       bars_audit.error(sqlerrm);
       raise;

   end;


   -----------------------------------------------------------------
   --    INSERT_EXTERN_DOCS()
   --
   --    c проверкой на валидность
   --    p_pack - входящий пакет
   --
   procedure insert_extern_docs(p_pack  bars_xmlklb.t_pack)
   is
      l_outdomdoc dbms_xmldom.DOMDocument;
   begin
      insert_extern_docs(p_pack => p_pack, p_needreply=> 0, p_outdomdoc => l_outdomdoc);
   end;


   -----------------------------------------------------------------
   --    PAY_FILE_DOCS()
   --
   --    Оплата документов из файла ткущего пользователя
   --
   --    p_filename  -  имя файла
   --    p_dat       -  дата импорта
   --    p_okcnt     -  кол-во успешно оплаченных
   --    p_oksum     -  сумма  успешно оплаченных
   --    p_badcnt    -  кол-во НЕуспешно оплаченных
   --    p_badsum    -  сумма  НЕуспешно оплаченных
   --
   procedure pay_file_docs(
                  p_filename     varchar2,
                  p_dat          date,
                  p_okcnt    out number,
                  p_oksum    out number,
                  p_badcnt   out number,
                  p_badsum   out number)
   is

      l_errcode  varchar2 (4);
      l_trace    varchar2 (1000) := G_TRACE||'pay_file_docs: ';
   begin

      p_okcnt  := 0;
      p_oksum  := 0;
      p_badcnt := 0;
      p_badsum := 0;

      bars_audit.info(l_trace||'Выбрана оплата документов импортирован. файла '||p_filename||' за '||to_char(p_dat,'dd/mm/yyyy'));

      for c in ( select impref, s
                 from xml_impdocs d, xml_impfiles f
                 where f.fn = d.fn and f.dat = d.dat and f.userid = user_id
                   and f.fn = upper(p_filename) and f.dat = p_dat
                   and status not in(G_PAYED, G_DELETED ))
      loop
         pay_doc(c.impref, l_errcode);
         if l_errcode = '0000' then
            p_okcnt  := p_okcnt + 1;
            p_oksum  := p_oksum + c.s;
         else
            p_badcnt := p_badcnt + 1;
            p_badsum := p_badsum + c.s;
         end if;

      end loop;

   end;





   -----------------------------------------------------------------
   --    MAKE_IMPORT()
   --
   --    Импорт докумнетов из внешних задач
   --
   --
   --    p_indoc     -  входящий clob документа
   --    p_packname  -  имя файла
   --    p_outdoc    -  исходящий клоб с ответами
   --
   procedure make_import( p_indoc          clob,
                          p_packname   out varchar2,
                          p_outdoc  in out clob)

   is
      l_pack       bars_xmlklb.t_pack;
      l_packname   varchar2(100);
      l_bodydoc    dbms_xmldom.DOMDocument; -- документ со списком оплаченных рефов
      l_outdomdoc  dbms_xmldom.DOMDocument;
      l_trace      varchar2 (1000) := G_TRACE||'make_import: ';
   begin

      if length(p_packname) > 30 then
         bars_error.raise_nerror(G_MODULE, 'FILENAME_TOO_LONG', p_packname);
      end if;


      bars_xmlklb.parse_header(
                   p_packname => '',
                   p_indoc    => p_indoc,
                   p_hdr      => l_pack.hdr);


      bars_audit.trace(l_trace||' заголовок: '||l_pack.hdr.pack_name||' sender='||l_pack.hdr.sender);

      bars_audit.info(l_trace||'Импорт файла '||l_pack.hdr.pack_name||' датой '||to_char(gl.bd,'dd/mm/yyyy'));


      begin
         insert into xml_impfiles(fn,dat,userid)
         values (upper(l_pack.hdr.pack_name), gl.bd, user_id);
      exception when dup_val_on_index then
         bars_error.raise_error(G_MODULE,83, l_pack.hdr.pack_name);
      end;


      bars_xmlklb.parse_body(
                  p_indoc     => p_indoc,
                  p_cbody     => l_pack.cbody);



      if p_outdoc is not null then

     bars_audit.trace(l_trace||'исходящий документ не пуст');
     insert_extern_docs(p_pack => l_pack, p_needreply=> 1, p_outdomdoc => l_outdomdoc);

     bars_xmlklb.create_document_reply(
             p_bodydoc => l_outdomdoc,
             p_hdr     => l_pack.hdr,
             p_reply   => p_outdoc);
      else
         bars_audit.trace(l_trace||'исходящий документ ПУСТ');
     insert_extern_docs(p_pack => l_pack );
      end if;


      bars_audit.trace(l_trace||'1');
      l_packname := l_pack.hdr.pack_name;
      bars_audit.trace(l_trace||' packname = '||l_packname);
      p_packname := l_packname;


      dbms_lob.freetemporary(l_pack.cbody);


   exception when others then
       bars_audit.error(l_trace||'ошибка выполнения import_doc: ');
       bars_audit.error(l_trace||sqlerrm);
       raise;
   end;


   -----------------------------------------------------------------
   --    MAKE_IMPORT()
   --
   --    Импорт докумнетов из внешних задач
   --
   --
   --    p_indoc     -  входящий clob документа
   --    p_packname  -  имя файла
   --
   procedure make_import(p_indoc  clob, p_packname out varchar2) is
      l_clob clob;
   begin
      make_import(p_indoc     => p_indoc,
                  p_packname  => p_packname,
          p_outdoc    => l_clob) ;
   end;



   -----------------------------------------------------------------
   --    IMPORT_DOC_CNT()
   --
   --    Для импорта док-тов из Centura (входящий пакет считывается пакетом  bars_lob.import_blob(l_blob))
   --    из временной таблицы tmp_lob. Предполагается, что перед выполнением данной функи, выполнили вгрузку
   --    входящего файла при помощи Centura функции - PutFileToTmpLob
   --
   --
   --    p_packname  -  имя файла (фиктивный параметр для совместимости с Centura)
   --
   procedure import_doc_cnt(p_packname  in out varchar2)

   is
      l_clob      clob;
      l_indoc     clob;
      l_packname  varchar2(30);
   begin

      if length(p_packname) > 30 then
         bars_error.raise_nerror(G_MODULE, 'FILENAME_TOO_LONG', p_packname);
      end if;

      -- после вгрузки файла во временн. таблицу частями.
      -- соберем эти части в единое целое.
      bars_lob.import_clob(l_indoc);

      if (l_indoc is null or dbms_lob.getlength(l_indoc) <=0) then
         bars_error.raise_error(G_MODULE,66);
      end if;

      make_import(l_indoc, l_packname);

      p_packname :=l_packname;

   end;


   -----------------------------------------------------------------
   --    GET_IMPORT_OPERATION()
   --
   --    По реквизитам документа, получить код операции для БАРС-а
   --
   --    I00 I00 _мпорт внутр_шн_х платеж_в
   --    I01 off I01 _мпорт м_жбанк_вських платеж_в (МВПС, СЕП)
   --    I02 I02 Iмпорт прих_д каси (ГРН)
   --    I03 I03 _мпорт видаток каси (ГРН)
   --    I04 I04 _мпорт прихiд каси (ВАЛ)
   --    I05 I05 _мпорт видаток каси (ВАЛ)
   --    I06 I06 _мпорт _нформац_йний дебет (dk=2)
   --    I07 I07 - Iмпорт реальний ДЕБЕТ мiжбанк
   --    I09 I09 - Тест
   --    I0I I0I - Тест _нформац_йний (dk=3)
   --
   --
   function get_import_operation(
                        p_nlsa varchar2,
                        p_mfoa varchar2,
                        p_nlsb varchar2,
                        p_mfob varchar2,
                        p_dk   number,
                        p_kv   number) return varchar2

   is
      l_nbsa  varchar2(4);
      l_nbsb  varchar2(4);
      l_tt    varchar2(3);
   begin
      l_nbsa := substr(p_nlsa,1,4);
      l_nbsb := substr(p_nlsb,1,4);

      if (l_nbsa in ('1001','1002') or l_nbsb in ('1001','1002'))  and p_dk<>0 and p_dk<>1 then
          bars_error.raise_nerror(G_MODULE, 'NO_INFORM_FOR_CASH');
      end if;

      if p_dk > 3 or p_dk < 0 then
          bars_error.raise_nerror(G_MODULE, 'NO_SUCH_DK');
      end if;


      if  p_mfoa = p_mfob then
          -- кассовый
          if l_nbsa in ('1001','1002') or l_nbsb in ('1001','1002') then
             if  l_nbsa in ('1001','1002') then
                 l_tt := case p_dk when 1 then ( case  when p_kv = 980 then 'I02' else 'I04' end)
                                   when 0 then ( case  when p_kv = 980 then 'I03' else 'I05' end)
                         end;
             else
                 l_tt := case p_dk when 1 then ( case  when p_kv = 980 then 'I03' else 'I05' end)
                                   when 0 then ( case  when p_kv = 980 then 'I02' else 'I04' end)
                         end;
             end if;


          -- некасовый
          else
              l_tt := 'I00';
          end if;

      else
         l_tt := case p_dk when 0 then 'I07'
                           when 1 then 'I01'
                           when 2 then 'I09'
                           when 3 then 'I0I'
                 end;
      end if;

      return l_tt;

   end;



end bars_xmlklb_imp;
/
 show err;
 
PROMPT *** Create  grants  BARS_XMLKLB_IMP ***
grant EXECUTE                                                                on BARS_XMLKLB_IMP to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_XMLKLB_IMP to KLBX;
grant EXECUTE                                                                on BARS_XMLKLB_IMP to OPER000;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_xmlklb_imp.sql =========*** End
 PROMPT ===================================================================================== 
 