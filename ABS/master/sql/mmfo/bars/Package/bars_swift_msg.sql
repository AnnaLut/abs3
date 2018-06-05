CREATE OR REPLACE PACKAGE BARS.bars_swift_msg
is

--**************************************************************--
--*                    SWIFT message package                   *--
--*                  (C) Copyright Unity-Bars                  *--
--*                                                            *--
--**************************************************************--


    VERSION_HEADER       constant varchar2(64)  := 'version 1.11 21.05.2018';
    VERSION_HEADER_DEFS  constant varchar2(512) := '';

    -- Устаревшие типы
    subtype t_recdoc    is oper%rowtype;
    type    t_listdocw  is table of operw.value%type index by varchar2(5);



    subtype t_docref    is oper.ref%type;
    subtype t_docwtag   is varchar2(5);         -- !!! Тип не совпадает с таблицей хранения
    subtype t_docwval   is operw.value%type;

    subtype t_docrec    is oper%rowtype;
    type    t_docwrec   is record (value operw.value%type);
    type    t_docwlist  is table of t_docwrec index by varchar2(5);
    type    t_doc       is record (docrec t_docrec, doclistw t_docwlist);

    subtype t_swmt      is sw_mt.mt%type;


--**************************************************************--
--*            Generate SWIFT message from document            *--
--**************************************************************--

    -----------------------------------------------------------------
    -- DOCMSG_PROCESS_DOCUMENT()
    --
    --     Процедура создания сообщения по документу
    --
    --
    --
    --
    --     Параметры:
    --
    --         p_ref      Референс документа
    --
    --         p_flag     Флаги обработки
    --
    --         p_errque   Признак постановки документа
    --                    в очередь ошибочных, при возникновении
    --                    ошибок при формировании сообщения
    --
    --
     procedure docmsg_process_document(
                   p_ref    in  oper.ref%type,
                   p_flag   in  char,
                   p_errque in  boolean       default false);

    -----------------------------------------------------------------
    -- DOCMSG_PROCESS_DOCUMENT2()
    --
    --     Процедура создания сообщения по документу
    --
    --
    --
    --
    --     Параметры:
    --
    --         p_ref      Референс документа
    --
    --         p_flag     Флаги обработки
    --
    --
     procedure docmsg_process_document2(
                   p_ref    in  oper.ref%type,
                   p_flag   in  char           );

    --------------------------------------------------------------
    -- ENQUEUE_DOCUMENT()
    --
    --     Функция постановки в очередь документа, по которому
    --     необходимо будет сформировать SWIFT сообщение.  При
    --     постановке в очередь в документе  проверяется  доп.
    --     реквизит - флаг формирования SWIFT сообщения
    --
    --     Параметры:
    --
    --         p_ref      Референс документа, для постановки в
    --                    очередь
    --         p_flag     Флаги для создания сообщения, специ-
    --                    фичные для данного типа сообщения
    --
    --         p_priority Приоритет обработки
    --

    procedure enqueue_document(
                  p_ref      in  oper.ref%type,
                  p_flag     in  char          default null,
                  p_priority in  number        default null );


    --------------------------------------------------------------
    -- PROCESS_DOCUMENT()
    --
    --     Процедура формирования SWIFT сообщения  по  одному
    --     документу из очереди документов.  Данная процедура
    --     предназначена для регистрации как CallBack функция
    --     обработки сообщения очереди.
    --
    --     Параметры:
    --
    --
    --
    procedure process_document;


    --------------------------------------------------------------
    -- PROCESS_DOCUMENT_QUEUE()
    --
    --     Процедура разбора очереди документов для формирования
    --     SWIFT сообщений.
    --
    --
    --
    --
    --
    procedure process_document_queue;


--**************************************************************--
--*           Generate SWIFT statement from document           *--
--**************************************************************--

    --------------------------------------------------------------
    -- ENQUEUE_STMT_DOCUMENT()
    --
    --     Функция постановки в очередь документа, по которому
    --     необходимо  будет  сформировать  SWIFT  выписку (на
    --     данный момент MT900/MT910)
    --
    --
    --     Параметры:
    --
    --         p_stmt     Номер выписки, для формирования кото-
    --                    рой вставляется документ
    --
    --         p_ref      Референс документа, для постановки в
    --                    очередь
    --
    --         p_flag     Флаги для создания сообщения, специ-
    --                    фичные для данного типа выписки
    --
    --         p_priority Приоритет обработки
    --

    procedure enqueue_stmt_document(
                  p_stmt     in  sw_stmt.mt%type,
                  p_ref      in  oper.ref%type,
                  p_flag     in  char          default null,
                  p_priority in  number        default null );


    -----------------------------------------------------------------
    -- PROCESS_STMT_QUEUE()
    --
    --     Процедура разбора очереди документов для формирования
    --     выписок SWIFT.
    --
    --
    --
    --
    --
    procedure process_stmt_queue;


--**************************************************************--
--*    Validate document req                                   *--
--**************************************************************--

    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VLDLISTRST()
    --
    --     Процедура очистки списка документов для проверки
    --
    --
    --
    --
    procedure docmsg_document_vldlistrst;


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VLDLISTADD()
    --
    --     Процедура добавления документа в список документов для
    --     проверки
    --
    --
    --
    procedure docmsg_document_vldlistadd(
                  p_docref      in   t_docref );


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VLDLISTPRC()
    --
    --     Процедура выполнения проверки над документами в списке
    --     документов для проверки
    --
    --
    --
    procedure docmsg_document_vldlistprc;



    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VALIDATE()
    --
    --     Процедура проверки корректности доп. реквизитов документа
    --     из которого будет формироваться сообщение SWIFT
    --
    --
    --
    --
    --
    procedure docmsg_document_validate(
                  p_doc    in    t_doc );

    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VALIDATE()
    --
    --     Процедура проверки корректности доп. реквизитов документа
    --     из которого будет формироваться сообщение SWIFT
    --
    --
    --
    --
    --
    procedure docmsg_document_validate(
                  p_ref     in  oper.ref%type );

    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VLDTRANS()
    --
    --     Процедура проверки корректности доп. реквизитов документа
    --     после выполнения транслитерации полей
    --
    --
    --
    --
    --
    procedure docmsg_document_vldtrans(
                  p_ref     in  oper.ref%type );


    -----------------------------------------------------------------
    -- Формирование МТ103 с покрытием                              --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_GET103COVHDR()
    --
    --     Получение отправителей/получателей МТ103 и МТ202
    --
    --     Параметры:
    --
    --         p_docref        Референс документа
    --
    --         p_senderbic     BIC-код отправителя
    --
    --         p_sendername    Наименование отправителя
    --
    --         p_rcv103bic     BIC-код получателя МТ103
    --
    --         p_rcv103name    Наименование получателя МТ103
    --
    --         p_rcv202bic     BIC-код получателя МТ202
    --
    --         p_rcv202name    Наименование получателя МТ202
    --
    --
    procedure docmsg_document_get103covhdr(
                  p_docref       in  oper.ref%type,
                  p_senderbic    out  varchar2,
                  p_sendername   out  varchar2,
                  p_rcv103bic    out  varchar2,
                  p_rcv103name   out  varchar2,
                  p_rcv202bic    out  varchar2,
                  p_rcv202name   out  varchar2      );


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_SET103COVHDR()
    --
    --     Установка получателей для сообщений МТ103 и МТ202
    --
    --     Параметры:
    --
    --         p_docref        Референс документа
    --
    --         p_rcv103bic     BIC-код получателя МТ103
    --
    --         p_rcv202bic     BIC-код получателя МТ202
    --
    --
    procedure docmsg_document_set103covhdr(
                  p_docref       in  oper.ref%type,
                  p_rcv103bic    in  varchar2,
                  p_rcv202bic    in  varchar2     );
       
    -----------------------------------------------------------------
    -- GENMSG_MT199()
    --
    --     Генерация MT199 - статус свифт сообщения в GPI
    --
    --     Параметры:
    --
    --         p_swref        Референс родительской свифтовки
    --
    --         p_statusid     Ид статуса из справочника SW_STATUSES
    --
 
--    procedure genmsg_mt199(p_swref    in sw_journal.swref%type,
--                           p_statusid in number);
--
--    procedure job_send_mt199;
--





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


end bars_swift_msg;
/

CREATE OR REPLACE PACKAGE BODY BARS.bars_swift_msg
is

    VERSION_BODY      constant varchar2(64)  := 'version 1.36 21.05.2018';
    VERSION_BODY_DEFS constant varchar2(512) := '';
    type t_strlist  is table of sw_operw.value%type;
    type t_reflist  is table of oper.ref%type;

    -- Типы
    subtype t_swmsg_tag        is  varchar2(2);
    subtype t_swmsg_tagopt     is  varchar2(1);
    subtype t_swmsg_tagrpblk   is  varchar2(10);
    subtype t_swmsg_tagvalue   is  varchar2(1024);

    subtype t_swmsg_tagvallist is t_strlist;


    subtype t_swmodelrec       is  sw_model%rowtype;



    CRLF   constant char(2) := chr(13) || chr(10);

    MODCODE               constant varchar2(3)   := 'SWT';
    PKG_CODE              constant varchar2(100) := 'swtmsg';

    TAGSTATE_MANDATORY    constant varchar2(1)   := 'M';
    TAGSTATE_OPTIONAL     constant varchar2(1)   := 'O';

    MSG_MT103  constant number := 103;
    MSG_MT202  constant number := 202;



    MODPAR_MSGVALTRIM     constant params.par%type := 'SWTMSGVT';
    MODPAR_MSGTRANSLATE   constant params.par%type := 'SWTTRANS';

    MODVAL_MSGTRANSLATE_YES constant params.val%type := '1';
    MODVAL_MSGTRANSLATE_NO  constant params.val%type := '0';


    g_vldList t_reflist;




    -----------------------------------------------------------------
    -- STR_WRAP()
    --
    --     Функция возвращает строку разбитую по заданному
    --     количеству символов переводами строк
    --
    --     Параметры:
    --
    --         p_str       Исходная строка
    --
    --         p_len       Длина одной строки
    --
    function str_wrap(
                 p_str   in  t_swmsg_tagvalue,
                 p_len   in  number            ) return t_swmsg_tagvalue
    is
    p       constant varchar2(100) := PKG_CODE || 'strwrap';
    --
    l_value   t_swmsg_tagvalue;   /* результирующая строка */
    l_tmp     t_swmsg_tagvalue;   /*       временный буфер */
    l_isfirst boolean := true;    /* признак первого цикла */
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, p_str, to_char(p_len));

        if (p_str is null or p_len is null or p_len = 0) then
            bars_audit.trace('%s: succ end, nothing to do', p);
            return p_str;
        end if;

        l_value := null;
        l_tmp   := p_str;

        while (nvl(length(l_tmp), 0) > 0)
        loop

            if (not l_isfirst) then l_value := l_value || CRLF;
            else                    l_isfirst := false;
            end if;

            if (length(l_tmp) > p_len) then
                l_value := l_value || substr(l_tmp, 1, p_len);
                l_tmp   := substr(l_tmp, p_len + 1);
            else
                l_value := l_value || l_tmp;
                l_tmp   := null;
            end if;

        end loop;
        bars_audit.trace('%s: succ  end, return %s', p, l_value);
        return l_value;

    end str_wrap;


    -----------------------------------------------------------------
    -- GET_PARAM_VALUE()
    --
    --     Функция получения значения конфигурационного параметра
    --     Если такого параметра нет,  то  функция  возвращает
    --     значение NULL
    --
    --     Параметры:
    --
    --         p_parname    Код (имя) параметра (params.par)
    --
    --
    function get_param_value(
                 p_parname  in  params.par%type ) return params.val%type
    is
    p       constant varchar2(100) := PKG_CODE || 'getparval';
    --
    l_value     params.val%type;   /* значение конф. параметра */
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, p_parname);

        select val into l_value
          from params
         where par = p_parname;
        bars_audit.trace('%s: succ end, return %s', p, l_value);
        return l_value;
    exception
        when NO_DATA_FOUND then
            bars_audit.trace('%s: succ end, parameter doesnt set', p);
            return null;
    end get_param_value;


    -----------------------------------------------------------------
    -- GET_CHARSET_ID()
    --
    --     Функция получения кода таблицы перекодировки,
    --     установленной для указанного получателя.  Если
    --     для получателя таблица перекодировки не
    --     устанавливалась, то будет использована таблица
    --     с кодом TRANS
    --
    --     Параметры:
    --
    --         p_bic        BIC-код участника
    --
    --
    --
    function get_charset_id(
                 p_bic      in  sw_banks.bic%type ) return sw_chrsets.setid%type
    is
    p       constant varchar2(100) := PKG_CODE || 'getchrset';
    --
    l_charset  sw_chrsets.setid%type;      /* код таблицы перекодировки */
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, p_bic);

        select nvl(chrset, 'TRANS') into l_charset
          from sw_banks
         where bic = p_bic;
        bars_audit.trace('%s: succ end, return %s', p, l_charset);
        return l_charset;
    exception
        when NO_DATA_FOUND then
            bars_audit.trace('%s: succ end, bank not found - return TRANS', p);
            return 'TRANS';
    end get_charset_id;



    -----------------------------------------------------------------
    -- GENMSG_TRANSLATE_VALUE()
    --
    --     Функция выполняет транслитерацию значения тега
    --
    --     Параметры:
    --
    --         p_mt        Тип SWIFT сообщения
    --
    --         p_tag       Тег SWIFT сообщения
    --
    --         p_opt       Опция тега SWIFT сообщения
    --
    --         p_value     Строка для транслитерации
    --
    --         p_transtab  Код таблицы перекодировки, которая будет
    --                     использоваться при транслитерации
    --
    --
    function genmsg_translate_value(
        p_mt       in  sw_mt.mt%type,
        p_tag      in  sw_tag.tag%type,
        p_opt      in  sw_opt.opt%type,
        p_value    in  sw_operw.value%type,
        p_transtab in  sw_chrsets.setid%type ) return sw_operw.value%type
    is

    l_cnt     number;                       /*               просто счетчик */
    l_pos     number;                       /*      позиция перевода строки */
    l_value   sw_operw.value%type := null;  /* транслитерированное значение */
    l_tmp     sw_operw.value%type := null;  /*              временный буфер */

    begin

        bars_audit.trace('translating value for mt=%s tag=% opt=%s ...', to_char(p_mt), p_tag, p_opt);

        --
        -- Получаем флаг транслитерации для данного тега
        --
        select count(*) into l_cnt
          from sw_model
         where mt    = p_mt
           and tag   = p_tag
           and nvl(opt, '-') = nvl(p_opt, '-')
           and trans = 'Y';

        if (l_cnt = 0) then

            select count(*) into l_cnt
              from sw_model m, sw_model_opt o
             where m.mt    = p_mt
               and m.tag   = p_tag
               and m.mt    = o.mt
               and m.num   = o.num
               and nvl(o.opt, '-')   = nvl(p_opt, '-')
               and o.trans = 'Y';

            if (l_cnt = 0) then
                bars_audit.trace('translate flag not set for for mt=%s tag=% opt=%s.', to_char(p_mt), p_tag, p_opt);
                return p_value;
            end if;

        end if;

        --
        -- Для некоторого списка тегов в первой строке
        -- может быть счет, который не транслитерируется
        --
        if ( p_tag || p_opt in
               ('50K', '59',  '52D', '53D', '54D', '55D', '56D',
                '57D', '58D', '53B', '54B', '55B', '57B' )       ) then

            bars_audit.trace('attempt to exclude /account ...');

            if (substr(p_value, 1, 1) = '/') then

                l_pos := instr(p_value, CRLF);

                if (l_pos is not null and l_pos != 0) then
                    l_value := substr(p_value, 1, l_pos+1);
                    l_tmp   := substr(p_value, l_pos+2);
                else
                    l_tmp   := p_value;
                end if;

                bars_audit.trace('first line excluded from translating.');

            else
                l_tmp := p_value;
                bars_audit.trace('first line isnt include account, skip exlude');
            end if;

        else

            --
            -- Значение может начинаться с кодового слова,
            -- которое заключено в символы "/"
            --
            bars_audit.trace('looking for first /code/ ...');

            if (substr(p_value, 1, 1) = '/') then

                -- Ищем заключающую наклонную
                l_pos := instr(substr(p_value, 2), '/');
                bars_audit.trace('trailing symbol / is at position %s', to_char(nvl(l_pos,-1)));

                --
                -- Заключающая наклонная должна быть
                -- на этой же строке и между ними не
                -- должно быть пробелов
                --
                if (l_pos is not null and l_pos != 0
                    and l_pos < nvl(instr(substr(p_value, 2), CRLF), 99999)
                    and l_pos < nvl(instr(substr(p_value, 2), ' '), 99999) ) then

                    l_value := substr(p_value, 1, l_pos);
                    l_tmp   := substr(p_value, l_pos+1);

                    bars_audit.trace('code substring excluded to pos %s', to_char(l_pos));

                else
                    l_tmp   := p_value;
                    bars_audit.trace('trailing symbol position rejected.');
                end if;

            else
                l_tmp := p_value;
                bars_audit.trace('first symbol isnt /, skip step.');
            end if;

        end if;

        --
        -- Просто транслитерируем значение
        --
        l_value := l_value || bars_swift.StrToSwift(l_tmp, p_transtab);
        bars_audit.trace('mt=%s tag=% opt=%s value translated.', to_char(p_mt), p_tag, p_opt);

        return l_value;

    end genmsg_translate_value;



    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_GETMTVLD()
    --
    --     Функция получения типа сообщения по значению доп.
    --     реквизита документа
    --
    --     Параметры:
    --
    --         p_str    Значение доп. реквизита документа
    --
    --
    function genmsg_document_getmtvld(
                    p_str   in  t_docwval ) return  t_swmt
    is
    p         constant varchar2(100) := PKG_CODE || '.gmdocgetmtvld';
    --
    l_mt      t_swmt;          /*     тип SWIFT сообщения */
    l_cnt     number;          /*          просто счетчик */
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, p_str);

        -- Формат доп. реквизит f: "MT XXX"
        if (length(p_str) != 6 or substr(p_str, 1, 3) != 'MT ') then
            bars_audit.trace('%s: invalid req format', p);
            bars_error.raise_nerror(MODCODE, 'GENMSG_INVALID_MTFORMAT');
        end if;

        begin
            l_mt := to_number(substr(p_str, 4, 3));
            bars_audit.trace('%s: mt is %s', p, to_char(l_mt));
        exception
            when OTHERS then
                bars_audit.trace('%s: invalid req format (mt value)', p);
                bars_error.raise_nerror(MODCODE, 'GENMSG_INVALID_MTFORMAT');
        end;

        -- Проверяем значение по справочнику типов
        select count(*) into l_cnt
          from sw_mt
         where mt = l_mt;

       if (l_cnt = 0) then
           bars_audit.trace('%s: unknown message format %s', to_char(l_mt));
           bars_error.raise_nerror(MODCODE, 'GENMSG_UNKNOWN_MT', to_char(l_mt));
       end if;

       bars_audit.trace('%s: succ end, return %s', p, to_char(l_mt));
       return l_mt;

    end genmsg_document_getmtvld;


    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_GETMT()
    --
    --     Функция получения типа сообщения, которое необ-
    --     ходимо будет сформировать по указанному документу.
    --     Тип сообщения проверяется по справочнику типов
    --
    --     Параметры:
    --
    --         p_ref    Референс документа
    --
    --
    function genmsg_document_getmt(
                 p_ref    in  t_docref ) return  t_swmt
    is
    p         constant varchar2(100) := PKG_CODE || '.gmdocgetmt';
    --
    l_value   t_docwval;       /* значение доп. реквизита */
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_ref));
        begin
            select value into l_value
              from operw
             where ref = p_ref
               and tag = rpad('f', 5, ' ');
            bars_audit.trace('%s: document property "f" => %s', l_value);
        exception
            when NO_DATA_FOUND then
                bars_audit.trace('%s: document req "f" not found', p);
                bars_error.raise_nerror(MODCODE, 'GENMSG_REQMT_NOTFOUND');
        end;

        return genmsg_document_getmtvld(l_value);

    end genmsg_document_getmt;



    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_GETMT()
    --
    --     Функция получения типа сообщения, которое необ-
    --     ходимо будет сформировать по указанному документу.
    --     Тип сообщения проверяется по справочнику типов
    --
    --     Параметры:
    --
    --         p_doc   Структура с реквизитами документа
    --
    --
    function genmsg_document_getmt(
                 p_doc   in  t_doc ) return  t_swmt
    is
    p         constant varchar2(100) := PKG_CODE || '.gmdocgetmt';
    --
    l_value   t_docwval;       /* значение доп. реквизита */
    --
    begin
        bars_audit.trace('%s: entry point', p);

        begin
            l_value := p_doc.doclistw('f').value;
            bars_audit.trace('%s: property "f" => %s', p, l_value);
        exception
            when NO_DATA_FOUND then
                bars_audit.trace('%s: document property "f" not found', p);
                bars_error.raise_nerror(MODCODE, 'GENMSG_REQMT_NOTFOUND');
        end;
        bars_audit.trace('%s: succ end, after validation', p);
        return genmsg_document_getmtvld(l_value);

    end genmsg_document_getmt;




    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_GETMSGFLG()
    --
    --     Функция получения флагов сообщения, сохраненных в доп.
    --     реквизитах документа.
    --
    --     Параметры:
    --
    --         p_ref    Референс документа, из которого будет
    --                  выполняться получение реквизита
    --
    --         p_tag    имя флага сообщения
    --
    --
    function genmsg_document_getmsgflg(
      p_ref     in oper.ref%type,
      p_tag     in operw.tag%type ) return operw.value%type
    is

    l_value    sw_operw.value%type;
    l_docDRec  oper.d_rec%type;
    l_pos      number;

    begin

        bars_audit.trace('query for document Ref=%s message flag %s', to_char(p_ref), p_tag);

        if (p_tag = 'SWAHF') then

            bars_audit.trace('message flag type selected');

            -- Этот реквизит сохраняется в поле OPER.D_REC (#u)
            select d_rec into l_docDRec
              from oper
             where ref = p_ref;

            bars_audit.trace('document field D_REC is %s', l_docDRec);

            l_pos := instr(l_docDRec, '#u');

            bars_audit.trace('tag position in field is %s', to_char(l_pos));

            if (l_docDRec is not null and  l_pos != 0) then
                l_value := substr(l_docDRec, l_pos + 2, instr(substr(l_docDRec, l_pos + 2), '#') - 1);
            end if;

        end if;

        bars_audit.trace('Message flag is %s', l_value);

        return l_value;

    end genmsg_document_getmsgflg;



    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_GETVALUE()
    --
    --     Функция получения доп. реквизита документа. Если
    --     у документа нет  указанного  доп. реквизита,  то
    --     функция возвращает значение NULL
    --
    --     Параметры:
    --
    --         p_ref    Референс документа, из которого будет
    --                  выполняться получение реквизита
    --
    --         p_tag    имя доп. реквизита
    --
    --
    function genmsg_document_getvalue(
      p_ref     in oper.ref%type,
      p_tag     in operw.tag%type ) return operw.value%type
    is

    l_retval operw.value%type;       /* значение доп. реквизита документа */

    begin

        bars_audit.trace('query for document req ref=%s tag=%s ...', to_char(p_ref), p_tag);

        select value
          into l_retval
          from operw
         where ref = p_ref
           and tag = p_tag;

        bars_audit.trace('value for document ref=%s tag=%s is %s.', to_char(p_ref), p_tag, l_retval);


        if (get_param_value(MODPAR_MSGVALTRIM) = '0') then
            null;
        else

            --
            -- Убираем лидирующие и завершающие пробелы и
            -- после этого проверяем наличие завершающего перевода строки
            --
            l_retval := ltrim(rtrim(l_retval));

            if (substr(l_retval, -2, 2) = CRLF) then
                l_retval := substr(l_retval, 1, length(l_retval)-2);
            end if;

        end if;


        return l_retval;

    exception
        when NO_DATA_FOUND then

            bars_audit.trace('ref=%s tag=%s not found.', to_char(p_ref), p_tag);
            return null;

    end genmsg_document_getvalue;




    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_GETVALUELIST()
    --
    --     Функция получения списка значений из строки. Значения в
    --     переданной строке должны быть разделены символами CRLF
    --
    --     Параметры:
    --
    --         p_value  Строка содержащаю список значений,
    --                  разделенных символами CRLF
    --
    --

    function genmsg_document_getvaluelist(
                 p_value   in   sw_operw.value%type ) return t_strlist
    is

    l_list   t_strlist := t_strlist();   /*      список значений */
    l_value  sw_operw.value%type;        /*   строка для разбора */
    l_tmp    sw_operw.value%type;        /*   буфер для значения */
    l_pos    number;                     /*  позиция разделителя */
    l_cnt    number  := 1;               /*      кол-во значений */

    begin

        bars_audit.trace('generating list of values...');

        if (p_value is not null) then

            l_value := p_value;

            while (l_value is not null)
            loop

                l_pos := instr(l_value, CRLF);

                if (l_pos != 0) then
                    l_tmp   := rtrim(ltrim(substr(l_value, 1, l_pos-1)));
                    l_value := substr(l_value, l_pos+2);
                else
                    l_tmp   := l_value;
                    l_value := null;
                end if;

                if (l_tmp is not null) then
                    l_list.extend;
                    l_list(l_cnt) := l_tmp;
                    l_cnt := l_cnt + 1;
                end if;

            end loop;

        end if;

        bars_audit.trace('value list created, items count=>%s', to_char(l_list.count));
        return l_list;

    end genmsg_document_getvaluelist;




    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_GETVALUE_EX()
    --
    --     Процедура генерации значений тегов, для которых требуется
    --     специальная обработка. Для таких тегов в метаописании
    --     сообщения установлен флаг "SPEC"
    --
    --     Параметры:
    --
    --         p_model   Строка метаописания для данного тега
    --
    --         p_swref   Референс создаваемого SWIFT сообщения
    --
    --         p_ref     Референс документа, из которого будет
    --                   выполняется формирование
    --
    --         p_recno   Порядковый номер последнего вставленного
    --                   тега SWIFT сообщения
    --
    --
    function genmsg_document_getvalue_ex(
        p_model      in     sw_model%rowtype,
        p_swref      in     sw_journal.swref%type,
        p_ref        in     oper.ref%type,
        p_recno      in     sw_operw.n%type,
        p_opt        in out sw_operw.opt%type       ) return sw_operw.value%type
    is

    l_value   sw_operw.value%type := null;   /* Сформированное значение тега */
    l_amount    oper.s%type;                 /*      Поле 32A:         сумма */
    l_currCode  tabval.kv%type;              /*      Поле 32A:    код валюты */
    l_docAccA   oper.nlsa%type;              /*      Поле 50K:  счет клиента */
    l_accNostro accounts.acc%type;           /*    Код подобранного корсчета */
    

    begin

        bars_audit.trace('special generation for tag %s...', p_model.tag || p_model.opt);

        if   (    p_model.mt in (103, 200, 202)
              and p_model.tag = '32'
              and p_model.opt = 'A'             ) then


            select to_number(value) into l_accNostro
              from operw
             where ref = p_ref
               and tag = 'NOS_A';

             select s into l_amount
               from opldok
              where ref = p_ref
                and dk  = 1
                and acc = l_accNostro;

             select o.kv, to_char(o.vdat, 'yymmdd')
               into l_currCode, l_value
               from oper o, tabval t
              where o.ref = p_ref
                and o.kv  = t.kv;

            l_value := l_value || bars_swift.AmountToSwift(l_amount, l_currCode, true, true);
            

        elsif (    p_model.mt = 103
               and p_model.tag = '23'
               and p_model.opt = 'B'            ) then

             l_value := genmsg_document_getvalue(p_ref, p_model.tag || p_model.opt);

             if (l_value is null) then
                 l_value := 'CRED';
             end if;

        elsif (    p_model.mt = 103
               and p_model.tag = '70'
               and p_model.opt is null          ) then

            l_value := genmsg_document_getvalue(p_ref, '70');

            if (l_value is null) then

                select substr(nazn, 1, 120) into l_value
                  from oper
                 where ref = p_ref;

                l_value := str_wrap(l_value, 30);

            end if;

        elsif (    p_model.mt = 103
               and p_model.tag = '50'
               and p_model.opt = 'a'            ) then

            l_value := genmsg_document_getvalue(p_ref, '50A');
            p_opt   := 'A';

            if (l_value is null) then
                l_value := genmsg_document_getvalue(p_ref, '50K');
                p_opt   := 'K';
            end if;

            if (l_value is null) then
                l_value := genmsg_document_getvalue(p_ref, '50F');
                p_opt   := 'F';
            end if;

            -- Получаем клиента из номер счета
            if (l_value is null) then

                -- Если документ не наш, то значение должно
                -- передаваться как доп. реквизит
                select mfoa  into l_value
                  from oper
                 where ref = p_ref;

                if (l_value != gl.aMFO) then
                    return null;
                end if;

                -- По номеру счета и коду валюты находим
                -- клиента и его параметры
                select o.nlsa, substr(c.nmkk, 1, 30) || ' ' || substr(c.adr, 1, 90)
                  into l_docAccA, l_value
                  from oper o, accounts a, cust_acc ca, customer c
                 where o.ref = p_ref
                   and a.nls = o.nlsa
                   and a.kv  = o.kv
                   and a.acc = ca.acc
                   and c.rnk = ca.rnk;

                l_value := '/' || l_docAccA || CRLF || str_wrap(l_value, 30);
                p_opt := 'K';

            end if;

        elsif (    p_model.mt  = 202
               and p_model.tag = '21'
               and p_model.opt is null ) then

             l_value := genmsg_document_getvalue(p_ref, p_model.tag || p_model.opt);

             if (l_value is null) then
                 l_value := 'NONREF';
             end if;

        -- elsif (    p_model.mt  = 103
        --       and p_model.tag = '33'
        --       and p_model.opt = 'B' ) then
        --
        --     l_value := genmsg_document_getvalue(p_ref, p_model.tag || p_model.opt);
        --
        --     if (l_value is null) then
        --
        --         -- Проверяем есть ли поля 71F, 71G
        --         l_val71g := genmsg_document_getvalue(p_ref, '71G');
        --         l_val71f := genmsg_document_getvalue(p_ref, '71F');
        --
        --     end if;

        else
            bars_audit.error('Неподдерживаемы тег для спецобработки (' || p_model.tag || p_model.opt || ')');
            raise_application_error(-20781, '\040 Неподдерживаемое тег для спецобработки (' || p_model.tag || p_model.opt || ')');
        end if;

        bars_audit.trace('special generated value=>%s', l_value);

        return l_value;

    end genmsg_document_getvalue_ex;




    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_CHECK()
    --
    --     Процедура начальной проверки документа, до
    --     формирования по нему SWIFT-сообщенияя
    --
    --     Параметры:
    --
    --         p_mt     Тип SWIFT сообщения
    --
    --         p_ref    Референс документа, из которого будет
    --                  выполняться формирование сообщения
    --
    --         p_flag   Флаг генерации ошибки, если передано
    --                  значение TRUE, то в случае отсутствия
    --                  на документе флага генерации сообщения
    --                  будет сгенерирована ошибка
    --
    procedure genmsg_document_check(
        p_mt   in  sw_mt.mt%type,
        p_ref  in  oper.ref%type,
        p_flag in  boolean        )
    is

    l_ref        oper.ref%type;                /*                   Референс документа */
    l_mt         sw_mt.mt%type;                /* Тип сообщения SWIFT для формирования */
    l_accNostro  accounts.acc%type;            /*     Идентификатор подобранного счета */
    l_cnt        number;                       /*                       просто счетчик */
    l_mtfinflag  sw_mt.mt%type;                /*      флаг FIN данного типа сообщения */

    begin

        bars_audit.trace('document checking ...');
        bars_audit.trace('par[0]=>' || to_char(p_mt) || ' par[1]=>' || to_char(p_ref) || ' par[2]=> <unk>');

        --
        -- Просто ищем документ
        --
        bars_audit.trace('checking document with ref=' || to_char(p_ref) || '...');
        begin

            select ref into l_ref
              from oper
             where ref = p_ref;

             bars_audit.trace('document ref' || to_char(p_ref) || ' found.');

        exception
            when NO_DATA_FOUND then
                bars_audit.error('Документ ref=' || to_char(p_ref) || ' не найден');
                raise_application_error(-20781, '\001 Документ не найден Ref=' || to_char(p_ref));
        end;

        --
        -- Проверяем флаг формирования сообщения
        --
        l_mt := genmsg_document_getmt(p_ref => p_ref);

        --
        -- Если задано соответствие, то проверяем
        --
        bars_audit.trace('checking message type eqv...');
        if (p_mt is not null) then

            if (p_mt != l_mt) then
                bars_audit.error('Тип сообщения не соответствует заданному (' || to_char(l_mt) || '!=' || to_char(p_mt) || ')');
                raise_application_error(-20781, '\004 Тип сообщения не соответствует заданному (' || l_mt || '!=' || p_mt || ')');
            end if;

            bars_audit.trace('message type check passed.');

        else
            bars_audit.trace('skip message type check (first parameter null).');
        end if;

        --
        -- По справочнику типов сообщений проверяем допустим ли тип
        -- и получаем флаг проверки подбора корсчета (необходимо
        -- для случая когда это информационное сообщение и идет
        -- без позиционера и подбора корсчета)
        --
        bars_audit.trace('query message type FIN flag...');

        select to_number(substr(flag, 1, 1)) into l_mtfinflag
          from sw_mt
         where mt = l_mt;

        bars_audit.trace('message type FIN flag is %s.', to_char(l_mtfinflag));

        --
        -- Проверяем формировалось ли сообщение
        -- данного типа по этому документу
        --

        select count(*) into l_cnt
          from sw_oper l, sw_journal j
         where l.ref   = p_ref
           and l.swref = j.swref
           and j.mt    = l_mt;

        if (l_cnt != 0) then
            bars_audit.error('По данному документу уже сформировано сообщение (тип ' || to_char(l_mt) || '). Ref=' || to_char(p_ref));
            raise_application_error(-20781, '\005 По данному документу уже сформировано сообщение (тип ' || to_char(l_mt) || '). Ref=' || to_char(p_ref));
        end if;

        -- Для сообщений, которые должны пройти подбор
        -- корсчета FIN флаг должен быть равен 1
        if (l_mtfinflag = 1) then

            -- Проверяем выполнен ли подбор корсчета
            bars_audit.trace('looking for doc req NOS_A ...');

            l_accNostro := to_number(genmsg_document_getvalue(p_ref, 'NOS_A'));

            bars_audit.trace('doc req NOS_A=%s', to_char(l_accNostro));

            if (nvl(l_accNostro, 0) = 0) then
                bars_audit.error('Не выполнена операция подбора корсчета Ref=' || to_char(p_ref));
                raise_application_error(-20781, '\006 Не выполнена операция подбора корсчета Ref=' || to_char(p_ref));
            end if;

            --
            -- на всякий случай проверим корректность счета
            --
            bars_audit.trace('checking for acc=%s ...', to_char(l_accNostro));
            begin

                select acc into l_accNostro
                  from accounts
                 where acc = l_accNostro;

                bars_audit.trace('account acc=%s found.', to_char(l_accNostro));

            exception
                when NO_DATA_FOUND then
                    bars_audit.error('Не найден подобранный корсчет. Acc=' || to_char(l_accNostro));
                    raise_application_error(-20781, '\007 Не найден подобранный корсчет. Acc=' || to_char(l_accNostro));
            end;

            -- Проверяем была ли выполнена проводка по корсчету
            bars_audit.trace('checking transaction on NOSTRO ...');

            select count(*) into l_cnt
              from opldok
             where ref = p_ref
               and dk  = 1
               and acc = l_accNostro;

            bars_audit.trace('transaction count=%s', to_char(l_cnt));

            if (l_cnt != 1) then
                bars_audit.error('Не выполнена проводка по корсчету или выполнено несколько проводок. Ref=' || to_char(p_ref));
                raise_application_error(-20781, '\008 Не выполнена проводка по корсчету или выполнено несколько проводок. Ref=' || to_char(p_ref));
            end if;

        end if;

        bars_audit.trace('document check complete ref=%s', to_char(p_ref));

    end genmsg_document_check;



    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_INSTAG()
    --
    --     Процедура вставки тега сообщения по указанному значению
    --     или из соответствующего доп. реквизита документа
    --
    --
    --     Параметры:
    --
    --         p_model      Описание тега в метаописании сообщения
    --
    --         p_swref      Референс формируемого SWIFT сообщения
    --
    --         p_ref        Референс документа, из которого выпол
    --                      няется формирование  SWIFT  сообщения
    --
    --         p_recno      Номер строки в формируемом сообщении
    --
    --         p_opt        Опция тега
    --
    --         p_value      Значение тега
    --
    --         p_insflag    Флаг вставки  значения,  переданного
    --                      в параметре p_value вместо получения
    --                      его из доп. реквизитов
    --
    --         p_usetrans   Флаг использования транслитерации
    --
    --         p_transtable Код таблицы транслитерации
    --

    procedure genmsg_document_instag(
        p_model      in     sw_model%rowtype,
        p_swref      in     sw_journal.swref%type,
        p_ref        in     oper.ref%type,
        p_recno      in out sw_operw.n%type,
        p_opt        in     sw_opt.opt%type,
        p_value      in     sw_operw.value%type,
        p_insflag    in     boolean,
        p_usetrans   in     boolean                 default false,
        p_transtable in     sw_chrsets.setid%type   default null   )
    is

    l_ins   boolean            := false;
    l_opt   sw_opt.opt%type;
    l_value sw_operw.value%type;
    l_cnt   number;
    l_list  t_strlist;

    begin

        bars_audit.trace('generating tag=%s opt=%s...', p_model.tag, p_model.opt);

        --
        -- Если флаг вставки определен
        --
        if (p_insflag is not null) then

            bars_audit.trace('flag SPECVAL is set ...');

            --
            -- Флаг может запрещать вставку (значение FALSE)
            --
            if (p_insflag) then

                l_ins   := true;
                l_value := p_value;

                bars_audit.trace('flag SPECVAL=true, inserting ...');

                bars_audit.trace('validating tag option ...');

                if (lower(p_model.opt) = p_model.opt) then

                    -- Проверяем допустимость опции
                    select count(*) into l_cnt
                      from sw_model_opt
                     where mt  = p_model.mt
                       and num = p_model.num
                       and opt = nvl(p_opt, '-');

                    if (l_cnt = 0) then
                        bars_audit.error('Опция ' || nvl(p_opt, 'NULL') || ' недопустима для поля ' || p_model.tag);
                        raise_application_error(-20781, '\050 Опция ' || p_opt || ' недопустима для поля ' || p_model.tag);
                    end if;

                    l_opt := p_opt;

                else
                    l_opt := p_model.opt;
                end if;

                bars_audit.trace('option validated (opt=%s)', l_opt);

            else

                bars_audit.trace('flag SPECVAL=false, skip insert');
                return;

            end if;

        --
        -- Поле 20 всегда совпадает с референсом в заголовке
        --
        elsif (p_model.tag = '20' and p_model.opt is null) then

            select trn into l_value
              from sw_journal
             where swref = p_swref;

            l_opt := p_model.opt;
            l_ins := true;

            bars_audit.trace('special block for field 20 =>%s', l_value);

        else

            --
            -- Получаем значение из доп. реквизита документа
            -- Если переданная опция, маленькая буква, то
            -- такая опция должна подбираться из допустимых
            -- для этого поля
            --
            bars_audit.trace('query value from document req ...');

            if (lower(p_model.opt) = p_model.opt) then

                bars_audit.trace('selecting from option list...');

                for o in (select opt
                            from sw_model_opt
                           where mt  = p_model.mt
                             and num = p_model.num
                          order by opt )
                loop

                    if (o.opt = '-') then
                        l_opt := null;
                     else
                        l_opt := o.opt;
                     end if;

                    l_value := genmsg_document_getvalue(p_ref, p_model.tag || l_opt);

                    bars_audit.trace('document req %s%s value=>', p_model.tag, l_opt, l_value);

                    if (l_value is not null) then
                        l_ins := true;
                        bars_audit.trace('selected option is %s', l_opt);
                        exit;
                    end if;

                end loop;

            else

                l_opt   := p_model.opt;
                l_value := genmsg_document_getvalue(p_ref, p_model.tag || l_opt);

                bars_audit.trace('value from document req =>%s', l_value);

                if (l_value is null) then
                    l_ins := false;
                else
                    l_ins := true;
                end if;

            end if;

        end if;

        bars_audit.trace('inserting tag=%s opt=%s...', p_model.tag, l_opt);

        if (l_ins) then

            -- Если необходимо, то проводим транслитерацию
            if (p_useTrans) then
                l_value := genmsg_translate_value(p_model.mt, p_model.tag, l_opt, l_value, p_transTable);
            end if;

            if (p_model.rpblk is null ) then


                bars_swift.in_swoperw(p_swref, p_model.tag, p_model.seq, p_recno, l_opt, l_value);
                p_recno := p_recno + 1;
                bars_audit.trace('tag=%s opt=%s inserted.', p_model.tag, l_opt);

            elsif (p_model.rpblk = 'RI' ) then

                l_list := genmsg_document_getvaluelist(l_value);

                for i in 1..l_list.count
                loop

                  bars_swift.in_swoperw(p_swRef, p_model.tag, p_model.seq, p_recno, l_opt, l_list(i));
                  p_recno := p_recno + 1;
                  bars_audit.trace('tag=%s opt=%s inserted.', p_model.tag, l_opt);

                end loop;

            else
                raise_application_error(-20999, '\SWT implementation restriction - unknown repeated flag');
            end if;

        else
            bars_audit.trace('tag=%s opt=%s skipped.', p_model.tag, l_opt);
        end if;

    end genmsg_document_instag;



    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_ABSTRACT()
    --
    --     Процедура создания SWIFT сообщения на базе
    --     метаописания сообщения данного типа
    --
    --

    procedure genmsg_document_abstract(
                  p_ref      in  oper.ref%type,
                  p_flag     in  char          )
    is

    -- Курсор по метаописанию сообщения
    cursor cursModel(p_mt in number)
    is
    select *
      from sw_model
     where mt = p_mt;

    l_mt          sw_mt.mt%type;             /*           Тип сообщения по документу */
    l_mtfinflag   number(1);                 /* Значение флага финансового сообщения */
    l_currCode    tabval.kv%type;            /*                 Код валюты документа */
    l_accNostro   accounts.acc%type;         /*     Идентификатор подобранного счета */
    l_retCode     number;                    /* Код возврата функции создания загол. */
    l_recModel    sw_model%rowtype;          /*               Строка модели сообщния */
    l_cnt         number;                    /*                       просто счетчик */

    l_sender      sw_journal.sender%type;    /*        Заголовок:    BIC отправителя */
    l_receiver    sw_journal.receiver%type;  /*        Заголовок:    BIC получателя  */
    l_currency    sw_journal.currency%type;  /*        Заголовок:         код валюты */
    l_amount      sw_journal.amount%type;    /*        Заголовок:    сумма сообщения */
    l_dateValue   sw_journal.vdate%type;     /*        Заголовок: дата валютирования */

    l_useTrans    boolean;                   /*     Флаг использования перекодировки */
    l_transTable  sw_chrsets.setid%type;     /*            Код таблицы перекодировки */

    l_swRef       sw_journal.swref%type;     /*             Референс сообщения SWIFT */
    l_value       sw_operw.value%type;       /*                        Значение тега */
    l_recno       sw_operw.n%type;           /*              Порядковый номер записи */
    l_opt         sw_operw.opt%type;         /*                    Опция тега записи */

    l_msgAppHdrFlags sw_journal.app_flag%type; /*                    флаги сообщения */
    
    l_guid varchar2(36);

    begin
       

        bars_audit.trace('genmsg_abstract: entry point');
        bars_audit.trace('par[0]=>%s par[1]=%s', to_char(p_ref), p_flag);
        bars_audit.info('Создание SWIFT-сообщения (общее) из документа ref=' || to_char(p_ref) || '...');

        -- Проверяем корректность документа
        genmsg_document_check(
            p_mt    => null,     /* тип сообщения не определен */
            p_ref   => p_ref,
            p_flag  => true  );  /* генерируем исключение при ошибках */

        -- Получаем тип сообщения
        l_mt := genmsg_document_getmt(
                    p_ref   => p_ref);

        bars_audit.trace('document message type is %s', to_char(l_mt));

        -- Получаем признак финансового сообщения
        select to_number(substr(flag, 1, 1))  into l_mtfinflag
          from sw_mt
         where mt = l_mt;

        bars_audit.trace('message type FIN is %s', to_char(l_mtfinflag));

        --
        -- Проверяем есть ли метаописание
        --
        select count(*) into l_cnt
          from sw_model
         where mt = l_mt;

        if (l_cnt = 0) then
            bars_audit.trace('Error! message description not found');
            raise_application_error(-20781, '\998 Нет метаописания данного типа сообщения');
        end if;

        --
        -- Формируем заголовок сообщения
        --
        bars_audit.trace('get message header req ...');

        l_sender := bars_swift.get_ourbank_bic;
        bars_audit.trace('message sender => %s', l_sender);

        --
        -- Если сообщение не финансовое, то получатель
        -- будет находиться в доп. реквизите SWRCV
        --
        if (l_mtfinflag = 0) then

            --
            -- Получателя определяем по реквизиту SWRCV
            --

            l_receiver := substr(genmsg_document_getvalue(p_ref, 'SWRCV'), 1, 11);

            if (l_receiver is null) then
                bars_audit.trace('receiver BIC not found (req SWRCV), throw error...');
                bars_audit.error('Не найден BIC банка получателя по доп. реквизиту SWRCV Ref=' || to_char(p_ref));
                raise_application_error(-20781, '\002 Не найден BIC банка получателя. Документ Ref=' || to_char(p_ref));
            end if;

            --msgvld_validate_bic(l_receiver);
            bars_audit.trace('message receiver => %s', l_receiver);

            l_currency  := null;
            l_amount    := 0;
            l_dateValue := bankdate_g;

        else

            --
            -- Получателя определяем по подобранному корсчету
            --

            select to_number(value) into l_accNostro
              from operw
             where ref = p_ref
               and tag = 'NOS_A';


             begin
                 select bic into l_receiver
                   from bic_acc
                  where acc = l_accNostro;

                 bars_audit.trace('receiver BIC=> %s', l_receiver);

             exception
                 when NO_DATA_FOUND then
                     bars_audit.trace('receiver BIC not found for acc=%s, throw error...', to_char(l_accNostro));
                     bars_audit.error('Не найден BIC банка получателя по подобранному корсчету Ref=' || to_char(p_ref));
                     raise_application_error(-20781, '\002 Не найден BIC банка получателя. Документ Ref=' || to_char(p_ref));
             end;

             --
             -- Сумму определяем по проводке на подобранный корсчет
             --
             select s
               into l_amount
               from opldok
              where ref = p_ref
                and dk  = 1
                and acc = l_accNostro;

             --
             -- Дата валютирования из плановой даты валютирования документа
             --
             select o.kv, t.lcv, o.vdat
               into l_currCode, l_currency, l_dateValue
               from oper o, tabval t
              where o.ref = p_ref
                and o.kv  = t.kv;

        end if;

        --
        -- Определяем таблицу перекодировки, которую будем использовать
        --
        --    Если сообщение уже перекодировано и используется перекоди
        --    ровка RUR6, то в доп.реквизите 20 будет значение "+"
        --    (?#?&@&*! Сбербанка - а если отправят через другой банк?)
        --
        select count(*) into l_cnt
          from operw
         where ref   = p_ref
           and tag   = '20'
           and value = '+';

        bars_audit.trace('result for looking 20=+ is %s', to_char(l_cnt));

        if (l_cnt != 0) then

            --
            -- Устанавливаем предопределенную таблицу
            --
            l_transTable := 'RUR6';
            l_useTrans   := false;

        else

            --
            -- Нормальный метод определения перекодировки - по банку
            -- получателю сообщения определяем таблицу перекодировки
            --
            l_transTable := get_charset_id(l_receiver);
            l_useTrans   := true;

        end if;

        bars_audit.trace('message translate table is %s', l_transTable);

        --
        -- Определяем заданы ли флаги сообщения по параметру SWAHF
        --
        l_msgAppHdrFlags := genmsg_document_getmsgflg(p_ref, 'SWAHF');

        bars_audit.trace('application header flags is %s', l_msgAppHdrFlags);


        bars_audit.trace('create message header ...');

        --
        -- создаем заголовок (заменить)
        --
        
        l_guid:=bars_swift.generate_uetr;
        
        bars_swift.In_SwJournalInt(
             ret_        => l_retCode,
             swref_      => l_swRef,
             mt_         => l_mt,
             mid_        => null,
             page_       => null,
             io_         => 'I',
             sender_     => l_sender,
             receiver_   => l_receiver,
             transit_    => null,
             payer_      => null,
             payee_      => null,
             ccy_        => l_currency,
             amount_     => l_amount,
             accd_       => null,
             acck_       => null,
             vdat_       => to_char(l_dateValue, 'MM/DD/YYYY'),
             idat_       => to_char(sysdate,  'YYYY-MM-DD HH24:MI'),
             flag_       => 'L',
             trans_      => l_transTable,
             apphdrflg_  => l_msgAppHdrFlags,
             sti_        =>'001',
             uetr_       => lower(l_guid));

        -- Устанавливаем признак уже оплаченного документа
        update sw_journal
           set date_pay = sysdate
         where swref = l_swRef;

        bars_audit.trace('message header created SwRef=> %s', to_char(l_swRef));

        -- Привязываем сообщение к документу
        insert into sw_oper(ref, swref)
        values (p_ref, l_swRef);

        bars_audit.trace('message linked with document.');
        bars_audit.trace('write message details ...');

        -- Открываем модель сообщения
        open cursModel(l_mt);
        l_recno := 1;

        loop
            fetch cursModel into l_recModel;
            exit when cursModel%notfound;

            --
            -- Для полей, требующих спецобработку вызываем функцию
            --
            if (l_recModel.spec = 'Y') then

                l_value := genmsg_document_getvalue_ex(l_recModel, l_swRef, p_ref, l_recno, l_opt);

                if (l_value is not null) then
                    genmsg_document_instag(l_recModel, l_swRef, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
                end if;

            else

                genmsg_document_instag(l_recModel, l_swRef, p_ref, l_recno, null, null, null, l_useTrans, l_transTable);

            end if;

        end loop;

        close cursModel;

        bars_audit.trace('message generated swref=%s.', to_char(l_swRef));
        bars_audit.info('Сформировано сообщение SwRef=' || to_char(l_swRef));

    end genmsg_document_abstract;


    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_MT103()
    --
    --     Процедура создания SWIFT сообщения MT103 с покрытием
    --     (MT103 + MT202)
    --
    --
    --
    procedure genmsg_document_mt103(
                  p_ref      in  oper.ref%type,
                  p_flag     in  char          )
    is

    -- Курсор по метаописанию сообщения
    cursor cursModel(p_mt in number)
    is
    select *
      from sw_model
     where mt = p_mt;

    l_mt          sw_mt.mt%type  := 103;     /*           Тип сообщения по документу */
    l_mt2         sw_mt.mt%type  := 202;     /*               Тип сообщения покрытия */

    l_currCode    tabval.kv%type;            /*                 Код валюты документа */
    l_accNostro   accounts.acc%type;         /*     Идентификатор подобранного счета */
    l_retCode     number;                    /* Код возврата функции создания загол. */
    l_recModel    sw_model%rowtype;          /*               Строка модели сообщния */
    l_cnt         number;                    /*                       просто счетчик */

    l_sender      sw_journal.sender%type;    /*        Заголовок:    BIC отправителя */
    l_receiver    sw_journal.receiver%type;  /*        Заголовок:    BIC получателя  */
    l_currency    sw_journal.currency%type;  /*        Заголовок:         код валюты */
    l_amount      sw_journal.amount%type;    /*        Заголовок:    сумма сообщения */
    l_dateValue   sw_journal.vdate%type;     /*        Заголовок: дата валютирования */

    l_useTrans    boolean;                   /*     Флаг использования перекодировки */
    l_transTable  sw_chrsets.setid%type;     /*            Код таблицы перекодировки */

    l_swRef       sw_journal.swref%type;     /*     Референс сообщения SWIFT (МТ103) */
    l_swRef2      sw_journal.swref%type;     /*     Референс сообщения SWIFT (МТ202) */

    l_value       sw_operw.value%type;       /*                        Значение тега */
    l_recno       sw_operw.n%type;           /*              Порядковый номер записи */
    l_opt         sw_operw.opt%type;         /*                    Опция тега записи */
    l_pos         number;                    /*                              позиция */

    l_msgAppHdrFlags sw_journal.app_flag%type; /*                    флаги сообщения */

    l_mt103rcv    char(11);                  /*   BIC код получателя сообщения MT103 */
    l_mt202rcv    char(11);                  /*   BIC код получателя сообщения MT202 */
    l_fld56a      sw_operw.value%type;       /*    Значение поля 56A сообщения МТ103 */
    l_fld52a      sw_operw.value%type;       /*    Значение поля 52A сообщения МТ103 */
    l_fld56bic    char(11);                  /*             BIC код посредника (56А) */
    l_fld57a      sw_operw.value%type;       /*    Значение поля 57A сообщения МТ103 */
    l_fld59a      sw_operw.value%type;       /*    Значение поля 59A сообщения МТ103 */
    l_guid varchar2(36);

    begin

        bars_audit.trace('genmsg_mt103: entry point');
        bars_audit.trace('par[0]=>%s par[1]=%s', to_char(p_ref), p_flag);
        bars_audit.info('Создание SWIFT-сообщения MT103 из документа ref=' || to_char(p_ref) || '...');
        
        
          l_guid :=bars_swift.generate_uetr;

        -- Реализация функции подразумевает обязательное наличие (флаг = '2')
        if (p_flag is null or p_flag != '2') then
            bars_audit.error('internal error - expected flag=2');
            raise_application_error(-20999, 'internal error - expected flag=2');
        end if;

        -- Проверяем корректность документа
        genmsg_document_check(
            p_mt    => 103,
            p_ref   => p_ref,
            p_flag  => true  );  /* генерируем исключение при ошибках */


        -- Получаем получателей сообщения
        l_mt103rcv := rpad(ltrim(rtrim(genmsg_document_getvalue(p_ref, 'SWRCV'))), 11, 'X');
        bars_audit.trace('%s: MT103 receiver is %s', l_mt103rcv);

        l_mt202rcv := rpad(ltrim(rtrim(genmsg_document_getvalue(p_ref, 'NOS_B'))), 11, 'X');
        bars_audit.trace('%s: MT103 receiver is %s', l_mt202rcv);


        --
        -- Проверяем есть ли метаописание
        --
        select count(*) into l_cnt
          from sw_model
         where mt = l_mt;

        if (l_cnt = 0) then
            bars_audit.trace('Error! message description not found');
            raise_application_error(-20781, '\998 Нет метаописания сообщения MT103');
        end if;

        bars_audit.trace('message MT103 description found.');

        select count(*) into l_cnt
          from sw_model
         where mt = l_mt2;

        if (l_cnt = 0) then
            bars_audit.trace('Error! message description not found');
            raise_application_error(-20781, '\998 Нет метаописания сообщения MT202');
        end if;

        bars_audit.trace('message MT202 description found.');

        --
        -- Формируем заголовок сообщения (MT103)
        --
        bars_audit.trace('get message MT103 header req ...');

        l_sender := bars_swift.get_ourbank_bic;
        bars_audit.trace('message sender => %s', l_sender);

        --
        -- Сумму определяем по проводке на подобранный корсчет
        --
        select to_number(value) into l_accNostro
          from operw
         where ref = p_ref
           and tag = 'NOS_A';

        select s
          into l_amount
          from opldok
         where ref = p_ref
           and dk  = 1
           and acc = l_accNostro;

        bars_audit.trace('message amount is %s', to_char(l_amount));

        --
        -- Дата валютирования из плановой даты валютирования документа
        --
        select o.kv, t.lcv, o.vdat
          into l_currCode, l_currency, l_dateValue
          from oper o, tabval t
         where o.ref = p_ref
           and o.kv  = t.kv;

        --
        -- Определяем таблицу перекодировки, которую будем использовать
        --
        --    Если сообщение уже перекодировано и используется перекоди
        --    ровка RUR6, то в доп.реквизите 20 будет значение "+"
        --    (?#?&@&*! Сбербанка - а если отправят через другой банк?)
        --
        select count(*) into l_cnt
          from operw
         where ref   = p_ref
           and tag   = '20'
           and value = '+';

        bars_audit.trace('result for looking 20=+ is %s', to_char(l_cnt));

        if (l_cnt != 0) then

            --
            -- Устанавливаем предопределенную таблицу
            --
            l_transTable := 'RUR6';
            l_useTrans   := false;

        else

            --
            -- Нормальный метод определения перекодировки - по банку
            -- получателю сообщения определяем таблицу перекодировки
            --
            l_transTable := get_charset_id(l_receiver);
            l_useTrans   := true;

        end if;

        bars_audit.trace('message translate table is %s', l_transTable);

        --
        -- Определяем заданы ли флаги сообщения по параметру SWAHF
        --
        l_msgAppHdrFlags := genmsg_document_getmsgflg(p_ref, 'SWAHF');

        bars_audit.trace('application header flags is %s', l_msgAppHdrFlags);


        bars_audit.trace('create message MT103 header ...');
            
        
        --
        -- создаем заголовок (заменить)
        --
        bars_swift.In_SwJournalInt(
             ret_        => l_retCode,
             swref_      => l_swRef,
             mt_         => l_mt,
             mid_        => null,
             page_       => null,
             io_         => 'I',
             sender_     => l_sender,
             receiver_   => l_mt103rcv,
             transit_    => null,
             payer_      => null,
             payee_      => null,
             ccy_        => l_currency,
             amount_     => l_amount,
             accd_       => null,
             acck_       => null,
             vdat_       => to_char(l_dateValue, 'MM/DD/YYYY'),
             idat_       => to_char(sysdate,  'YYYY-MM-DD HH24:MI'),
             flag_       => 'L',
             trans_      => l_transTable,
             apphdrflg_  => l_msgAppHdrFlags,
             sti_        =>'001',
             uetr_       => lower(l_guid) );

        -- Устанавливаем признак уже оплаченного документа
        update sw_journal
           set date_pay = sysdate
         where swref = l_swRef;

        bars_audit.trace('message MT103 header created SwRef=> %s', to_char(l_swRef));

        -- Привязываем сообщение к документу
        insert into sw_oper(ref, swref)
        values (p_ref, l_swRef);

        bars_audit.trace('message MT103 linked with document.');
        bars_audit.trace('write message MT103 details ...');

        -- Получаем значение поля 56А и выделяем BIC, если такое поле существует
        l_fld56a := genmsg_document_getvalue(p_ref, '56A');

        if (l_fld56a is not null) then

            -- Получаем BIC-код
            if (substr(l_fld56a, 1, 1) = '/') then l_fld56bic := rpad(substr(l_fld56a, instr(l_fld56a, CRLF)+2), 11, 'X');
            else                                   l_fld56bic := rpad(l_fld56a, 11, 'X');
            end if;

        end if;

        -- Получаем значение для 57А
        l_fld57a := genmsg_document_getvalue(p_ref, '57A');


        -- Открываем модель сообщения
        open cursModel(l_mt);
        l_recno := 1;

        loop
            fetch cursModel into l_recModel;
            exit when cursModel%notfound;


            --
            -- Отдельно формируем поля 53a, 54a, 56a, 57a
            --
            if    (l_recModel.tag = '53' and l_recModel.opt = 'a') then

                l_opt   := 'A';
                l_value := l_mt202rcv;
                genmsg_document_instag(l_recModel, l_swRef, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
            --
            elsif (l_recModel.tag = '54' and l_recModel.opt = 'a') then
            
                    if (l_fld56a is not null and l_mt202rcv != l_fld56bic) then
                                l_opt   := 'A';
                                l_value := l_fld56a;
                                genmsg_document_instag(l_recModel, l_swRef, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
                   /* else
                                l_opt   := 'A';
                                l_value := l_fld57a;
                                genmsg_document_instag(l_recModel, l_swRef, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
                    */
                    end if;
            elsif (l_recModel.tag = '56' and l_recModel.opt = 'a' and l_fld56a is not null) then

                -- Поле 56 не заполняем
                null;

            elsif (l_recModel.tag = '57' and l_recModel.opt = 'a' and l_fld56a is not null) then
                     -- logger.info('SWIFT l_fld56a='||l_fld56a);
                -- Поле 57 заполняем c 56A
                --l_value := l_fld56a;
                
                --l_opt   := 'A';
                --genmsg_document_instag(l_recModel, l_swRef, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
                
                 null;
            else

                --
                -- Для полей, требующих спецобработку вызываем функцию
                --
                if (l_recModel.spec = 'Y') then

                    l_value := genmsg_document_getvalue_ex(l_recModel, l_swRef, p_ref, l_recno, l_opt);

                    if (l_value is not null) then
                        genmsg_document_instag(l_recModel, l_swRef, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
                    end if;

                else
                  if (l_recModel.Tag='72') then
                    null;
                  elsif (l_recModel.Tag='59') then
                       l_opt:='';
                      -- l_fld59a:=substr(genmsg_document_getvalue(p_ref, '59'), instr(genmsg_document_getvalue(p_ref, '59'), chr(10))+1);
                       l_fld59a:=genmsg_document_getvalue(p_ref, '59');
                       genmsg_document_instag(l_recModel, l_swRef, null, l_recno, l_opt, l_fld59a, true, l_useTrans, l_transTable);
                  elsif (l_recModel.Tag='57' --and l_fld56a is null 
                  ) then
                      null;     
                  else
                    genmsg_document_instag(l_recModel, l_swRef, p_ref, l_recno, null, null, null, l_useTrans, l_transTable);
                  end if;
                end if;

            end if;

        end loop;

        close cursModel;

        bars_audit.trace('message MT103 generated swref=%s.', to_char(l_swRef));
        bars_audit.info('Сформировано сообщение SwRef=' || to_char(l_swRef));

        --
        -- Формируем заголовок сообщения (MT202)
        --
        bars_audit.trace('create message MT202 header ...');
        --guid має бути такий як в 103
         --l_sources_guid :=sys_guid(); /* GUID*/
         --l_guid :=substr(l_sources_guid,1,8)||'-'||substr(l_sources_guid,9,4)||'-'||substr(l_sources_guid,13,4)||'-'||substr(l_sources_guid,17,4)||'-'||substr(l_sources_guid,21) ;
        --
        -- создаем заголовок (заменить)
        --
        bars_swift.In_SwJournalInt(
             ret_        => l_retCode,
             swref_      => l_swRef2,
             mt_         => l_mt2,
             mid_        => null,
             page_       => null,
             io_         => 'I',
             sender_     => l_sender,
             receiver_   => l_mt202rcv,
             transit_    => null,
             payer_      => null,
             payee_      => null,
             ccy_        => l_currency,
             amount_     => l_amount,
             accd_       => null,
             acck_       => null,
             vdat_       => to_char(l_dateValue, 'MM/DD/YYYY'),
             idat_       => to_char(sysdate,  'YYYY-MM-DD HH24:MI'),
             flag_       => 'L',
             trans_      => l_transTable,
             apphdrflg_  => l_msgAppHdrFlags,
         --    sti_        => '001',
         --    uetr_       => lower(l_guid),
             cov_        => 'COV' );

        -- Устанавливаем признак уже оплаченного документа
        update sw_journal
           set date_pay = sysdate
         where swref = l_swRef2;

        bars_audit.trace('message MT202 header created SwRef=> %s', to_char(l_swRef2));

        -- Привязываем сообщение к документу
        insert into sw_oper(ref, swref)
        values (p_ref, l_swRef2);

        bars_audit.trace('message MT202 linked with document.');
        bars_audit.trace('write message MT202 details ...');

        -- Открываем модель сообщения
        open cursModel(l_mt2);
        l_recno := 1;

        loop
            fetch cursModel into l_recModel;
            exit when cursModel%notfound;

            if (l_recModel.tag = '20' and l_recModel.opt is null) then
                genmsg_document_instag(l_recModel, l_swRef2, p_ref, l_recno, null, null, null, l_useTrans, l_transTable);
            elsif (l_recModel.tag = '21' and l_recModel.opt is null) then

                -- Получаем реф. сообщения МТ103
                select trn into l_value
                  from sw_journal
                 where swref = l_swRef;
                l_opt   := l_recModel.opt;
                genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);

            elsif (l_recModel.tag = '32' and l_recModel.opt = 'A') then

                -- Получаем значение поля 32A сообщения МТ103
                select value into l_value
                  from sw_operw
                 where swref = l_swRef
                   and tag   = l_recModel.tag
                   and opt   = l_recModel.opt;

                l_opt   := l_recModel.opt;

                genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
             /*
              В sw_model для 202 додаємо 50 поле
              з 52D робимо 50F
             */    
                --            elsif (l_recModel.tag = '52' and l_recModel.opt = 'a') then
                --
                --                select opt, value into l_opt, l_value
                --                  from sw_operw
                --                 where swref = l_swRef
                --                   and tag   = '50';
                --
                --                if (l_opt in ('K', 'F')) then l_opt := 'D';
                --                end if;
                --                genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
            elsif (l_recModel.tag = '50' and l_recModel.opt = 'a') then

                select opt, value into l_opt, l_value
                  from sw_operw
                 where swref = l_swRef
                   and tag   = '50';

                if (l_opt in ('K', 'F')) then l_opt := 'F';
                end if;
                genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
             elsif (l_recModel.tag = '52' and l_recModel.opt = 'a') then   
                  l_fld52a := genmsg_document_getvalue(p_ref, '52A');  
                
                 if (l_fld52a is not null) then
                                l_opt   := 'A';
                                l_value := l_fld52a;
                                genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
                 end if;
            elsif (l_recModel.tag = '57' and l_recModel.opt = 'a' and l_fld56a is not null) then  
                                l_opt   := 'A';
                                l_value := l_fld56a;
                                genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);      

            -- 57A не заповнюэмо так як з MT103 54A прибираємо
            --            elsif (l_recModel.tag = '57' and l_recModel.opt = 'a') then
            --
            --                -- Получаем значение поля 54 сообщения МТ103
            --                begin
            --                    select opt, value into l_opt, l_value
            --                      from sw_operw
            --                     where swref = l_swRef
            --                       and tag   = '54';
            --                exception
            --                    when NO_DATA_FOUND then l_value := null;
            --                end;
            --
            --                if (l_opt != 'A') then
            --                    bars_audit.trace('Error! message 103 has option A in field 54');
            --                    raise_application_error(-20781, '\998 Нет описания для конвертации опции '||l_opt||' поля 54а в поле 57 сообщения MT202');
            --                end if;
            --
            --                if (l_value is not null) then
            --                    genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
            --                end if;


            -- залишаємо тільки BIC
            elsif (l_recModel.tag = '58' and l_recModel.opt = 'a') then

                 --l_value:= substr(genmsg_document_getvalue(p_ref, '59'),1,instr(genmsg_document_getvalue(p_ref, '59'), chr(13)))||chr(10)||l_mt103rcv;
                 l_value:=l_mt103rcv;
               --
                 l_opt := 'A';
                 genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
            
            -- 72 нахер
            --            elsif (l_recModel.tag = '72') then
            --
            --                -- Получаем реф. сообщения МТ103
            --                select trn into l_value
            --                  from sw_journal
            --                 where swref = l_swRef;
            --
            --                l_opt := '';
            --                l_value := '/BNF/COVER OF OUR MT103' || CRLF || 'REF ' || l_value;
            --                genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
            
            elsif (l_recModel.tag = '59' and l_recModel.opt = 'a') then
                -- l_value:=l_mt103rcv;
                l_value:=genmsg_document_getvalue(p_ref, '59');
               --
                 l_opt := 'A';
                 genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);

            -- Додаємо 59A і 70 теги
            elsif (l_recModel.tag = '70') then
                l_value:=genmsg_document_getvalue(p_ref, '70');
                l_opt   := l_recModel.opt;
                genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
            elsif (l_recModel.tag = '72') then
                l_value:=genmsg_document_getvalue(p_ref, '72');
                if (l_value is not null) then 
                    l_opt   := l_recModel.opt;
                    genmsg_document_instag(l_recModel, l_swRef2, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);  
                end if;      
            
            
            end if;

        end loop;

        close cursModel;

        bars_audit.trace('message MT202 generated swref=%s.', to_char(l_swRef2));
        bars_audit.info('Сформировано сообщение SwRef=' || to_char(l_swRef2));
        bars_audit.info('Сформировано сообщение MT103 SwRef=' || to_char(l_swRef) || ' с покрытием SwRef=' || to_char(l_swRef2));

    end genmsg_document_mt103;



    -----------------------------------------------------------------
    -- GENMSG_STMT_MT900()
    --
    --     Процедура внесения документа в очередь документов с
    --     ошибками формирования
    --
    --
    --     Параметры:
    --
    --         p_stmt     Тип выписки (900/910)
    --
    --         p_date     Дата валютирования
    --
    --         p_acc      Идентификатор счета, по которому
    --                    формируется выписка
    --
    --         p_ref      Референс документа
    --
    --
    procedure genmsg_stmt_mt900(
                 p_stmt   in  sw_stmt.mt%type,
                 p_date   in  opldok.fdat%type,
                 p_acc    in  accounts.acc%type,
                 p_ref    in  oper.ref%type      )
    is

    -- Курсор по метаописанию сообщения
    cursor cursModel(p_mt in number)
    is
    select *
      from sw_model
     where mt = p_mt;

    l_sender      sw_journal.sender%type;    /*        Заголовок:    BIC отправителя */
    l_receiver    sw_journal.receiver%type;  /*        Заголовок:    BIC получателя  */
    l_currency    sw_journal.currency%type;  /*        Заголовок:         код валюты */
    l_amount      sw_journal.amount%type;    /*        Заголовок:    сумма сообщения */
    l_currCode    tabval.kv%type;            /*                 Код валюты документа */
    l_accNum      accounts.nls%type;         /*                          Номер счета */
    l_recModel    sw_model%rowtype;          /*                  строка метаописания */


    l_retCode     number;                    /* Код возврата функции создания загол. */
    l_cnt         number;                    /*                       просто счетчик */
    l_useTrans    boolean;                   /*     Флаг использования перекодировки */
    l_transTable  sw_chrsets.setid%type;     /*            Код таблицы перекодировки */
    l_swRef       sw_journal.swref%type;     /*             Референс сообщения SWIFT */
    l_swRefSrc    sw_journal.swref%type;     /*  Референс начального сообщения SWIFT */
    l_value       sw_operw.value%type;       /*                        Значение тега */
    l_value2      sw_operw.value%type;       /*                        Значение тега */
    l_recno       sw_operw.n%type;           /*              Порядковый номер записи */
    l_opt         sw_operw.opt%type;         /*                    Опция тега записи */
    l_isUse50     boolean := false;          /*        Признак использования поля 50 */

    l_nam_a       oper.nam_a%type;
    l_nlsa        oper.nlsa%type;
    l_nazn        oper.nazn%type;

    begin

        --
        -- Формируем заголовок сообщения
        --
        bars_audit.trace('get statement message header req ...');

        l_sender := bars_swift.get_ourbank_bic;
        bars_audit.trace('statement message sender => %s', l_sender);

        --
        -- По справочнику корсчетов определяем получателя
        --
        begin

            select bic into l_receiver
              from bic_acc
             where acc = p_acc;

             bars_audit.trace('statement message receiver => %s', l_receiver);

        exception
            when NO_DATA_FOUND then
                bars_audit.error('Не найден получатель по справочнику корсчетов. Acc=' || to_char(p_acc));
                raise_application_error(-20781, '\201 Не найден получатель по справочнику корсчетов. Acc=' || to_char(p_acc));
        end;

        --
        -- Код валюты берем из счета
        --
        select a.nls, t.kv, t.lcv
          into l_accNum, l_currCode, l_currency
          from accounts a, tabval t
         where a.acc = p_acc
           and a.kv  = t.kv;

        bars_audit.trace('statement currency is %s', l_currency);

        --
        -- Cумму берем из проводки
        --
        select sum(s)  into l_amount
          from opldok
         where ref  = p_ref
           and acc  = p_acc
           and fdat = p_date;

        bars_audit.trace('statement amount is %s', to_char(l_amount));

        --
        -- Нормальный метод определения перекодировки - по банку
        -- получателю сообщения определяем таблицу перекодировки
        --
        l_transTable := get_charset_id(l_receiver);
        l_useTrans   := true;

        bars_audit.trace('message translate table is %s', l_transTable);

        bars_audit.trace('create message header ...');

          --Аналізуємо чи є СВІФТовка для нашого документу,
       --якщо немає то формуємо по іншму алгоритму
       begin
        select swref into l_swRefSrc
            from sw_oper
           where ref   = p_ref
             and rownum <= 1;
        exception when no_data_found then
          l_swRefSrc:=null;
       end;

        --
        -- создаем заголовок (заменить)
        --
        bars_swift.In_SwJournalInt(
             ret_        => l_retCode,
             swref_      => l_swRef,
             mt_         => p_stmt,
             mid_        =>case when (l_swRefSrc is null) then p_ref else null end,
             page_       => null,
             io_         => 'I',
             sender_     => l_sender,
             receiver_   => l_receiver,
             transit_    => null,
             payer_      => null,
             payee_      => null,
             ccy_        => l_currency,
             amount_     => l_amount,
             accd_       => null,
             acck_       => null,
             vdat_       => to_char(p_date, 'MM/DD/YYYY'),
             idat_       => to_char(sysdate,  'YYYY-MM-DD HH24:MI'),
             flag_       => 'L',
             trans_      => l_transTable );

        bars_audit.trace('message header created SwRef=> %s', to_char(l_swRef));

        bars_audit.trace('write statement message details ...');

        l_recno := 1;



    if (l_swRefSrc is not null) then
        -- 20
        select trn into l_value
          from sw_journal
         where swref = l_swRef;
      -- Для 643 додаємо спочатку "+"
    /*    if (l_currCode=643) then
            l_value:='+'||l_value;
         end if;
   */
        bars_swift.in_swoperw(l_swRef, '20', 'A', l_recno, null, l_value);
        l_recno := l_recno + 1;

        -- 21 (нужно уточнить)
        select trn into l_value
          from sw_journal
         where swref   = l_swRefSrc;

        bars_swift.in_swoperw(l_swRef, '21', 'A', l_recno, null, l_value);
        l_recno := l_recno + 1;

        -- 25
        bars_swift.in_swoperw(l_swRef, '25', 'A', l_recno, null, l_accNum);
        l_recno := l_recno + 1;

        -- 32A
        l_value := to_char(p_date, 'yymmdd') || bars_swift.AmountToSwift(l_amount, l_currCode, true, true);
        bars_swift.in_swoperw(l_swRef, '32', 'A', l_recno, 'A', l_value);
        l_recno := l_recno + 1;


        -- 50
        if (p_stmt = 910 and l_currCode!=643) then

            begin

                select opt, value into l_opt, l_value
                  from sw_operw
                 where swref = l_swRefSrc
                   and tag   = '50'
                   and opt  in ('A', 'K', 'F');

               bars_swift.in_swoperw(l_swRef, '50', 'A', l_recno, l_opt, l_value);


                l_recno := l_recno + 1;

                l_isUse50 := true;

            exception
                when NO_DATA_FOUND then null;
            end;

        end if;

         if (p_stmt = 910 and l_currCode=643) then
            l_isUse50 := true;
         end if;

        -- 52
        if (not l_isUse50) then
            begin
              select opt, value into l_opt, l_value
                    from sw_operw
                   where swref = l_swRefSrc
                     and tag   = '52'
                     and opt  in ('A', 'D');

                bars_swift.in_swoperw(l_swRef, '52', 'A', l_recno, l_opt, l_value);


                l_recno := l_recno + 1;

            exception
                when NO_DATA_FOUND then null;
            end;
        end if;

   -- 52 для 643 по просьбі Климентьева(заповнювати його навіть якщо заповнено 50)
        if (l_currCode=643) then
         if (p_stmt = 910)
          then
            begin
              select opt, value into l_opt, l_value
                    from sw_operw
                   where swref = l_swRefSrc
                     and tag   = '50'
                     and opt  in ('K');

                bars_swift.in_swoperw(l_swRef, '52', 'A', l_recno, 'D', l_value);


                l_recno := l_recno + 1;

            exception
                when NO_DATA_FOUND then
               -- Якщо 52 пусте то заповнюєм його в нашій виписці BIC РУ який відсилав платіж
                begin
                 select c.bic into l_value from sw_oper so, oper o, custbank c
                    where so.swref=l_swRefSrc
                    and so.ref=o.ref
                    and o.mfoa=c.mfo;

                   bars_swift.in_swoperw(l_swRef, '52', 'A', l_recno, 'D', l_value);


                  l_recno := l_recno + 1;
                 exception when no_data_found then null;
                end;
            end;
         else
             begin
                  select opt, value into l_opt, l_value
                        from sw_operw
                       where swref = l_swRefSrc
                         and tag   = '52'
                         and opt  in ('A', 'D');

                    bars_swift.in_swoperw(l_swRef, '52', 'A', l_recno, l_opt, l_value);


                    l_recno := l_recno + 1;

                exception
                    when NO_DATA_FOUND then

                    begin
                     select c.bic into l_value from sw_oper so, oper o, custbank c
                        where so.swref=l_swRefSrc
                        and so.ref=o.ref
                        and o.mfoa=c.mfo;

                       bars_swift.in_swoperw(l_swRef, '52', 'A', l_recno, 'A', l_value);


                      l_recno := l_recno + 1;
                     exception when no_data_found then null;
                    end;
                end;
            end if;
        end if;



        -- 56
        if (p_stmt = 910) then

            begin

                select opt, value into l_opt, l_value
                  from sw_operw
                 where swref = l_swRefSrc
                   and tag   = '56'
                   and opt  in ('A', 'D');

                bars_swift.in_swoperw(l_swRef, '56', 'A', l_recno, l_opt, l_value);

                l_recno := l_recno + 1;

            exception
                when NO_DATA_FOUND then null;
            end;

        end if;

      if (p_stmt = 910 and l_currCode=643) then
         begin

            select value into l_value
              from sw_operw
             where swref = l_swRefSrc
               and tag   = '70'
               and opt is null;

            bars_swift.in_swoperw(l_swRef, '72', 'A', l_recno, 'D', l_value);
            l_recno := l_recno + 1;

        exception
            when NO_DATA_FOUND then null;
        end;
      else
        -- 72
        begin

            select value into l_value
              from sw_operw
             where swref = l_swRefSrc
               and tag   = '72'
               and opt is null;

            bars_swift.in_swoperw(l_swRef, '72', 'A', l_recno, null, l_value);
            l_recno := l_recno + 1;

        exception
            when NO_DATA_FOUND then null;
        end;
        end if;

    else --СВІФТовку не знайшли - формуємо по новому алгоритму

      --Поле 20(opt пусто)
         l_value:=to_char(p_ref);
         bars_swift.in_swoperw(l_swRef, '20', 'A', l_recno, null, l_value);

      -- Поле 21
         l_recno := l_recno + 1;
         l_value:='NONREF';
         bars_swift.in_swoperw(l_swRef, '21', 'A', l_recno, null, l_value);

        --Поле 32A
        l_recno := l_recno + 1;
        l_value := to_char(p_date, 'yymmdd') || bars_swift.AmountToSwift(l_amount, l_currCode, true, true);
        bars_swift.in_swoperw(l_swRef, '32', 'A', l_recno, 'A', l_value);
        --Поле 52D
        begin
          select nam_a, nlsa
            into l_nam_a, l_nlsa
           from oper
          where ref=p_ref;

        l_recno := l_recno + 1;

        l_value:='/'||l_nlsa||chr(13)||chr(10)||
        bars_swift.StrToSwift(l_nam_a, case when l_currCode=643 then 'RUR6' else 'TRANS' end);

        bars_swift.in_swoperw(l_swRef, '52', 'A', l_recno, 'D', l_value);

        exception when no_data_found then
          null;
        end;
        --Поле 72
        begin
            select nazn
                into l_nazn
               from oper
              where ref=p_ref;

          l_recno := l_recno + 1;

          l_nazn:=bars_swift.StrToSwift(l_nazn, case when l_currCode=643 then 'RUR6' else 'TRANS' end);

          l_value:=replace(str_wrap('/BNF/' || l_nazn, 33), chr(13)||chr(10), chr(13)||chr(10)||'//');

          bars_swift.in_swoperw(l_swRef, '72', 'A', l_recno, null, l_value);

        end;
    end if; -- end l_swRefSrc is not null
        bars_audit.trace('statement message generated swref=%s.', to_char(l_swRef));
        bars_audit.info('Сформирована выписка. Сообщение SwRef=' || to_char(l_swRef));

    end genmsg_stmt_mt900;


    -----------------------------------------------------------------
    -- DOCMSG_ENQUEUE_ERROR()
    --
    --     Процедура внесения документа в очередь документов с
    --     ошибками формирования
    --
    --
    --     Параметры:
    --
    --         p_ref      Референс документа
    --
    --         p_errmsg   Текст ошибки
    --
     procedure docmsg_enqueue_error(
                   p_ref    in  oper.ref%type,
                   p_errmsg in  varchar2       )
     is
     begin

         bars_audit.trace('inserting document into error queue ref=%s...', to_char(p_ref));

         insert into sw_docmsg_err(ref, errmsg)
         values (p_ref, p_errmsg);

         bars_audit.trace('document in error queue ref=%s.', to_char(p_ref));

     end docmsg_enqueue_error;


    -----------------------------------------------------------------
    -- DOCMSG_DEQUEUE_ERROR()
    --
    --     Процедура удаления документа из очередь документов с
    --     ошибками формирования
    --
    --
    --     Параметры:
    --
    --         p_ref      Референс документа
    --
    --
     procedure docmsg_dequeue_error(
                   p_ref    in  oper.ref%type )
     is
     begin

         bars_audit.trace('deleting document from error queue ref=%s...', to_char(p_ref));

         delete from sw_docmsg_err
         where ref = p_ref;

         if (sql%rowcount = 0) then
             bars_audit.trace('document not found in queue ref=%s', to_char(p_ref));
             raise_application_error(-20781, '\110 Документ не найден в очереди Ref=' || to_char(p_ref));
         end if;

         bars_audit.trace('document deleted from error queue ref=%s.', to_char(p_ref));

     end docmsg_dequeue_error;








    -----------------------------------------------------------------
    -- DOCMSG_CHECKMSGFLAG()
    --
    --     Функция проверки флага формирования SWIFT сообщения по
    --     документу. Функция возвращает значение TRUE, если флаг
    --     установлен и  FALSE, если флаг не найден.  Функция  не
    --     выполняет проверку корректности значения данного флага
    --
    --     Параметры:
    --
    --         p_doc    Структура с реквизитами документа
    --
    --
    function docmsg_checkmsgflag(
               p_doc   in  t_doc ) return boolean
    is
    p        constant varchar2(100) := PKG_CODE || '.dmchkmflg';
    --
    l_value  t_docwval;    /* Значение реквизита: тип сообщения */
    l_mt     t_swmt;       /*      Предполагаемый тип сообщения */
    --
    begin
        bars_audit.trace('%s: entry point', p);

        begin
            l_value := p_doc.doclistw('f').value;
            bars_audit.trace('%s: property "f" value is %s', p, l_value);
        exception
            when NO_DATA_FOUND then
                bars_audit.trace('%s: property "f" not found, returning FALSE', p);
                return false;
        end;

        -- Проверяем корректность доп. реквизита
        l_mt := genmsg_document_getmtvld(l_value);
        bars_audit.trace('%s: property mt is %s, returning TRUE', p, to_char(l_mt));
        return true;

    end docmsg_checkmsgflag;






    -----------------------------------------------------------------
    -- DOCMSG_CHECKMSGFLAG()
    --
    --     Функция проверки флага формирования SWIFT сообщения по
    --     документу. Функция возвращает значение TRUE, если флаг
    --     установлен и  FALSE, если флаг не найден.  Функция  не
    --     выполняет проверку корректности значения данного флага
    --
    --     Параметры:
    --
    --         p_ref      Референс документа, для постановки в
    --                    очередь
    --
    function docmsg_checkmsgflag(
               p_ref   in  oper.ref%type ) return boolean
    is
    p        constant varchar2(100) := PKG_CODE || '.dmchkmflg';
    --
     l_ref    oper.ref%type;       /*                Референс документа */
     l_value  operw.value%type;    /* Значение реквизита: тип сообщения */
     l_mt     sw_mt.mt%type;       /*      Предполагаемый тип сообщения */

    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_ref));

        -- Проверяем нужно ли формировать SWIFT-сообщение
        bars_audit.trace('%s: checking document req "f" ...', p);
        begin
            select value into l_value
              from operw
             where ref = p_ref
               and tag = rpad('f', 5, ' ');
            bars_audit.trace('%s: document req "f" => %s', l_value);
        exception
            when NO_DATA_FOUND then
                bars_audit.trace('%s: document req "f" not found, ', p);
                return false;
        end;

        -- Проверяем корректность доп. реквизита
        l_mt := genmsg_document_getmtvld(l_value);
        bars_audit.trace('%s: mt validate completed, return true', p);
        return true;

     end docmsg_checkmsgflag;


    -----------------------------------------------------------------
    -- DOCMSG_PROCESS_DOCUMENT()
    --
    --     Процедура создания сообщения по документу
    --
    --
    --
    --
    --     Параметры:
    --
    --         p_ref      Референс документа
    --
    --         p_flag     Флаги обработки
    --
    --         p_errque   Признак постановки документа
    --                    в очередь ошибочных, при возникновении
    --                    ошибок при формировании сообщения
    --
    --
     procedure docmsg_process_document(
                   p_ref    in  oper.ref%type,
                   p_flag   in  char,
                   p_errque in  boolean       default false)
     is

     l_genmsgerr  varchar2(4000);   /* текст сообщения об ошибке */
     l_mt         number;           /*             тип сообщения */

     begin

         --
         -- Проверяем наличие документа и флаг формирования сообщения
         --
         -- 14/03/2006 dg маскирую ошибку для документов, которым не нужно
         --               формирование сообщения
         --
         if (not docmsg_checkmsgflag(p_ref)) then
             bars_audit.trace('bad document, skip message creation');
             return;
             -- bars_audit.trace('internal queue error - bad document in queue. document ref=%s', to_char(p_ref));
             -- raise_application_error(-20781, '\111 internal queue error - bad document in queue. document Ref=' || to_char(p_ref));
         end if;

         begin

             savepoint sp_docmsg;

             --
             -- Получаем тип сообщения
             --
             l_mt := genmsg_document_getmt(p_ref => p_ref);

             if (l_mt = 103) then

                 if (p_flag = '2') then

                     --
                     -- Создаем сообщение MT103 с покрытием (MT202)
                     --
                     genmsg_document_mt103(
                         p_ref  => p_ref,
                         p_flag => p_flag );

                 else

                     --
                     -- Создаем сообщение по общему принципу
                     --
                     genmsg_document_abstract(
                         p_ref  => p_ref,
                         p_flag => p_flag );

                 end if;


             else

                 --
                 -- Создаем сообщение по общему принципу
                 --
                 genmsg_document_abstract(
                     p_ref  => p_ref,
                     p_flag => p_flag );

             end if;

         exception
             when OTHERS then

                 l_genmsgerr := sqlerrm;

                 rollback to sp_docmsg;

                 bars_audit.trace('error creating message: %s', l_genmsgerr);

                 --
                 -- В зависимости от указанного флага, либо генерируем ошибку,
                 -- либо ставим данный документ в очередь ошибочных
                 --
                 if (p_errque) then

                     --
                     -- ставим в очередь
                     --
                     docmsg_enqueue_error(
                         p_ref    => p_ref,
                         p_errmsg => l_genmsgerr );

                 else
                     raise; -- генерим ошибку
                 end if;

         end;

     end docmsg_process_document;

    -----------------------------------------------------------------
    -- DOCMSG_PROCESS_DOCUMENT2()
    --
    --     Процедура создания сообщения по документу
    --
    --
    --
    --
    --     Параметры:
    --
    --         p_ref      Референс документа
    --
    --         p_flag     Флаги обработки
    --
    --
     procedure docmsg_process_document2(
                   p_ref    in  oper.ref%type,
                   p_flag   in  char           )
     is
     begin
         docmsg_process_document(p_ref, p_flag, false);
     end docmsg_process_document2;



    -----------------------------------------------------------------
    -- DOCSTMT_PROCESS_DOCUMENT()
    --
    --     Процедура создания выписки по документу
    --
    --
    --
    --
    --     Параметры:
    --
    --         p_ref      Референс документа
    --
    --         p_flag     Флаги обработки
    --
    --         p_errque   Признак постановки документа
    --                    в очередь ошибочных, при возникновении
    --                    ошибок при формировании выписки
    --
    --
     procedure docstmt_process_document(
                   p_stmt   in  sw_stmt.mt%type,
                   p_ref    in  oper.ref%type,
                   p_flag   in  char,
                   p_errque in  boolean       default false)
     is

     l_genmsgerr  varchar2(4000);   /* текст сообщения об ошибке */
     l_docSos     oper.sos%type;    /*       состояние документа */
     l_cnt        number;           /*                   счетчик */

     begin

         --
         -- Проверяем состояние документа
         --
         bars_audit.trace('checking document status ref=%s...', to_char(p_ref));

         select sos into l_docSos
           from oper
          where ref = p_ref;

         if (l_docSos != 5) then
             bars_audit.error('Состояние документа не соответствует ожидаемому. Ref=' || to_char(p_ref));
             raise_application_error(-20781, '\200 Состояние документа не соответствует ожидаемому. Ref=' || to_char(p_ref));
         end if;

         bars_audit.trace('document ref=%s status ok.', to_char(p_ref));

         --
         -- Проверяем необходимость формирования выписки
         --
        /* select count(*) into l_cnt
           from opldok o, sw_acc_sparam s, sw_oper w
          where o.ref       = p_ref
            and o.acc       = s.acc
            and s.use4mt900 = 1
            and o.ref       = w.ref;
         */
         --06-11-2014 Oleg Muzyka
         --Перевіримо без наявності СВІФТового повідомлення,
         --проаналізуємо це дальше, для того щоб знати,
         --по якому алгоритму формувати додаткові реквізити виписки
         select count(*) into l_cnt
           from opldok o, sw_acc_sparam s
          where o.ref       = p_ref
            and o.acc       = s.acc
            and s.use4mt900 = 1;

         if (l_cnt = 0) then
             bars_audit.trace('statement 900/910 not defined for this accounts. Ref=%s', to_char(p_ref));
             return;
         end if;

         --
         -- Формируем выписку для каждого счета, который затрагивается
         -- документом
         --
         for i in (select decode(o.dk, 0, 900, 910) stmt, o.fdat, o.acc
                     from opldok o, sw_acc_sparam s
                    where o.ref       = p_ref
                      and o.acc       = s.acc
                      and s.use4mt900 = 1
                   group by decode(o.dk, 0, 900, 910), o.fdat, o.acc)
         loop

             bars_audit.trace('generating statement for account acc=%s...', to_char(i.acc));

             genmsg_stmt_mt900(
                 p_stmt => i.stmt,
                 p_date => i.fdat,
                 p_acc  => i.acc,
                 p_ref  => p_ref  );

             bars_audit.trace('statement for account acc=%s generated.', to_char(i.acc));

         end loop;

     end docstmt_process_document;



--**************************************************************--
--*            Generate SWIFT message from document            *--
--**************************************************************--

    -----------------------------------------------------------------
    -- ENQUEUE_DOCUMENT()
    --
    --     Функция постановки в очередь документа, по которому
    --     необходимо будет сформировать SWIFT сообщение.  При
    --     постановке в очередь в документе  проверяется  доп.
    --     реквизит - флаг формирования SWIFT сообщения
    --
    --     Параметры:
    --
    --         p_ref      Референс документа, для постановки в
    --                    очередь
    --         p_flag     Флаги для создания сообщения, специ-
    --                    фичные для данного типа сообщения
    --
    --         p_priority Приоритет обработки
    --

    procedure enqueue_document(
                  p_ref      in  oper.ref%type,
                  p_flag     in  char          default null,
                  p_priority in  number        default null )
    is


    l_queMsgEnq   dbms_aq.enqueue_options_t;     /*        Опции постановки в очередь */
    l_queMsgProp  dbms_aq.message_properties_t;  /*                   Опции сообщения */
    l_queMsgID    raw(16);                       /* Идентификатор сообщения в очереди */

    begin

        --
        -- Проверка доп. реквизита документа
        --   (флаг формирования сообщения)
        --
        if (not docmsg_checkmsgflag(p_ref)) then
             return;
        end if;

        --
        -- Устанавливаем приоритет (пока фиктивный)
        --
        l_queMsgProp.priority := 1;

        --
        -- Добавляем документ в очередь
        --
        dbms_aq.enqueue(
            queue_name         => 'aq_swdocmsg',
            enqueue_options    => l_queMsgEnq,
            message_properties => l_queMsgProp,
            payload            => t_swdocmsg(p_ref, p_flag),
            msgid              => l_queMsgID          );

    end enqueue_document;



    -----------------------------------------------------------------
    -- PROCESS_DOCUMENT()
    --
    --     Процедура формирования SWIFT сообщения  по  одному
    --     документу из очереди документов.  Данная процедура
    --     предназначена для регистрации как CallBack функция
    --     обработки сообщения очереди.
    --
    --     Параметры:
    --
    --
    --
    procedure process_document
    is
    begin
        raise_application_error(-20999, '\SWT implementation restriction -');
    end process_document;


    -----------------------------------------------------------------
    -- PROCESS_DOCUMENT_QUEUE()
    --
    --     Процедура разбора очереди документов для формирования
    --     SWIFT сообщений.
    --
    --
    --
    --
    --
    procedure process_document_queue
    is

    l_queMsgDeq      dbms_aq.dequeue_options_t;    /*  Параметры извлечения очереди */
    l_queMsgProp     dbms_aq.message_properties_t; /*           Параметры сообщения */
    l_queMsgID       raw(16);                      /*       Идентификатор сообщения */
    l_queMsg         t_swdocmsg;                   /*          Сообщение из очереди */

    l_isMsgExists     boolean  := true;            /*     Признак наличия сообщения */

    no_message_found       exception;
    pragma exception_init  (no_message_found, -25228);

    begin

        --
        -- Устанавливаем начальные значения просмотра очереди
        --
        l_queMsgDeq.wait         := dbms_aq.no_wait;
        l_queMsgDeq.navigation   := dbms_aq.first_message;
        l_queMsgDeq.dequeue_mode := dbms_aq.locked;
        l_queMsgID               := null;

        while (l_isMsgExists)
        loop

            begin

                --
                -- Получаем сообщение из очереди
                --
                dbms_aq.dequeue(
                    queue_name         => 'aq_swdocmsg',
                    dequeue_options    => l_queMsgDeq,
                    message_properties => l_queMsgProp,
                    payload            => l_queMsg,
                    msgid              => l_queMsgID      );

                --
                -- Вызываем процедуру обработки сообщения
                --
                begin
                   savepoint sp_before_procdoc;

                    docmsg_process_document(
                        p_ref    => l_queMsg.ref,
                        p_flag   => l_queMsg.flag,
                        p_errque => true           );

                    --
                    -- Если успешно сформировали сообщение, удаляем из очереди
                    --
                    l_queMsgDeq.dequeue_mode := dbms_aq.remove_nodata;
                    l_queMsgDeq.msgid        := l_queMsgID;

                    dbms_aq.dequeue(
                            queue_name         => 'aq_swdocmsg',
                            dequeue_options    => l_queMsgDeq,
                            message_properties => l_queMsgProp,
                            payload            => l_queMsg,
                            msgid              => l_queMsgID    );

                exception
                    when OTHERS then
                        rollback to sp_before_procdoc;
                end;

                commit;

                --
                -- Устанавливаем параметры продолжения просмотра очереди
                --
                l_queMsgDeq.wait         := dbms_aq.no_wait;
                l_queMsgDeq.navigation   := dbms_aq.next_message;
                l_queMsgDeq.dequeue_mode := dbms_aq.locked;
                l_queMsgDeq.msgid        := null;

            exception
                when NO_MESSAGE_FOUND then l_isMsgExists := false;
            end;

        end loop;

        commit;

    end process_document_queue;

--**************************************************************--
--*           Generate SWIFT statement from document           *--
--**************************************************************--

    --------------------------------------------------------------
    -- ENQUEUE_STMT_DOCUMENT()
    --
    --     Функция постановки в очередь документа, по которому
    --     необходимо  будет  сформировать  SWIFT  выписку (на
    --     данный момент MT900/MT910)
    --
    --
    --     Параметры:
    --
    --         p_stmt     Номер выписки, для формирования кото-
    --                    рой вставляется документ
    --
    --         p_ref      Референс документа, для постановки в
    --                    очередь
    --
    --         p_flag     Флаги для создания сообщения, специ-
    --                    фичные для данного типа выписки
    --
    --         p_priority Приоритет обработки
    --

    procedure enqueue_stmt_document(
                  p_stmt     in  sw_stmt.mt%type,
                  p_ref      in  oper.ref%type,
                  p_flag     in  char          default null,
                  p_priority in  number        default null )
    is

    l_queMsgEnq   dbms_aq.enqueue_options_t;     /*        Опции постановки в очередь */
    l_queMsgProp  dbms_aq.message_properties_t;  /*                   Опции сообщения */
    l_queMsgID    raw(16);                       /* Идентификатор сообщения в очереди */

    begin

        --
        -- Проверка допустимости типа выписки
        -- (необходимо добавить по SW_STMT)
        --
        null;

        bars_audit.trace('Attempt to add document Ref=%s to statement queue AQ_SWDOCSTMT...', to_char(p_ref));
        --
        -- Устанавливаем приоритет (пока фиктивный)
        --
        l_queMsgProp.priority := 1;

        --
        -- Добавляем документ в очередь для выписки
        --
        dbms_aq.enqueue(
            queue_name         => 'bars.aq_swdocstmt',
            enqueue_options    => l_queMsgEnq,
            message_properties => l_queMsgProp,
            payload            => t_swdocstmt(p_stmt, p_ref, p_flag),
            msgid              => l_queMsgID          );

        bars_audit.trace('Document Ref=%s added to statement queue AQ_SWDOCSTMT.', to_char(p_ref));

    end enqueue_stmt_document;


    -----------------------------------------------------------------
    -- PROCESS_STMT_QUEUE()
    --
    --     Процедура разбора очереди документов для формирования
    --     выписок SWIFT.
    --
    --
    --
    --
    --
    procedure process_stmt_queue
    is

    l_queMsgDeq      dbms_aq.dequeue_options_t;    /*  Параметры извлечения очереди */
    l_queMsgProp     dbms_aq.message_properties_t; /*           Параметры сообщения */
    l_queMsgID       raw(16);                      /*       Идентификатор сообщения */
    l_queMsg         t_swdocstmt;                  /*          Сообщение из очереди */
    l_docSos         oper.sos%type;                /*           Состояние документа */

    l_isMsgExists    boolean  := true;             /*     Признак наличия сообщения */
    l_errmsg         varchar2(2048);               /*     Текст сообщения об ошибке */

    no_message_found       exception;
    pragma exception_init  (no_message_found, -25228);

    begin

        bars_audit.trace('Process statement queue AQ_SWDOCSTMT...');

        --
        -- Устанавливаем начальные значения просмотра очереди
        --
        l_queMsgDeq.wait         := dbms_aq.no_wait;
        l_queMsgDeq.navigation   := dbms_aq.first_message;
        l_queMsgDeq.dequeue_mode := dbms_aq.locked;
        l_queMsgID               := null;

        while (l_isMsgExists)
        loop

            begin

                --
                -- Получаем сообщение из очереди
                --
                dbms_aq.dequeue(
                    queue_name         => 'bars.aq_swdocstmt',
                    dequeue_options    => l_queMsgDeq,
                    message_properties => l_queMsgProp,
                    payload            => l_queMsg,
                    msgid              => l_queMsgID      );

                bars_audit.trace('Found request: stmt=%s, ref=%s, process it...', to_char(l_queMsg.stmt), to_char(l_queMsg.ref));

                --
                -- Вызываем процедуру обработки документа
                --
                begin
                   savepoint sp_before_procdoc;

                   --
                   -- Выписки формируем только для STMT=900
                   -- Документ должен быть со статусом 5,
                   -- если у документа статус меньше 0, то
                   -- такой документ убираем из очереди
                   --

                   if (l_queMsg.stmt = 900) then

                       --
                       -- Получаем состояние документа
                       --
                       begin

                           select sos  into l_docSos
                             from oper
                            where ref = l_queMsg.ref;

                           bars_audit.trace('Document Ref=%s status is %s', to_char(l_queMsg.ref), to_char(l_docSos));

                       exception
                           when NO_DATA_FOUND then l_docSos := -1;
                       end;

                       --
                       -- Формируем выписку
                       --
                       if (l_docSos = 5) then

                           -- формируем выписку
                           docstmt_process_document(
                               p_stmt   => l_queMsg.stmt,
                               p_ref    => l_queMsg.ref,
                               p_flag   => l_queMsg.flag,
                               p_errque => false          );

                       else
                           bars_audit.trace('Document status isnt 5, skip document.');
                       end if;

                       --
                       -- удаляем документ из очереди
                       --
                       if (l_docSos = 5 or l_docSos <0) then

                           bars_audit.trace('Delete request from queue...');

                           l_queMsgDeq.dequeue_mode := dbms_aq.remove_nodata;
                           l_queMsgDeq.msgid        := l_queMsgID;

                           dbms_aq.dequeue(
                                   queue_name         => 'bars.aq_swdocstmt',
                                   dequeue_options    => l_queMsgDeq,
                                   message_properties => l_queMsgProp,
                                   payload            => l_queMsg,
                                   msgid              => l_queMsgID    );

                           bars_audit.trace('Request deleted from queue.');

                       end if;

                   else
                       bars_audit.trace('Statement type isnt 900, skip request.');
                   end if;

                exception
                    when OTHERS then

                        l_errmsg := sqlerrm;
                        bars_audit.error('SWT: Ошибка при формировании выписки (MT900): ' || l_errmsg);
                        rollback to sp_before_procdoc;
                end;

                commit;

                --
                -- Устанавливаем параметры продолжения просмотра очереди
                --
                l_queMsgDeq.wait         := dbms_aq.no_wait;
                l_queMsgDeq.navigation   := dbms_aq.next_message;
                l_queMsgDeq.dequeue_mode := dbms_aq.locked;
                l_queMsgDeq.msgid        := null;

            exception
                when NO_MESSAGE_FOUND then l_isMsgExists := false;
            end;

        end loop;

        commit;

    end process_stmt_queue;






--**************************************************************--
--*    Validate document req                                   *--
--**************************************************************--

    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_GETVALUE_OPT()
    --
    --     Функция возвращает значение доп реквизита  документа,
    --     который соответствует  указанному  полю  сообщения  в
    --     случае, когда для этого поля возможно одна из несколь-
    --     ких опций. Функция требует, чтобы при этом соблюдалось
    --     условие уникальности доп. реквизита поля
    --
    --
    --
    function docmsg_document_getvalue_opt(
                  p_ref     in  oper.ref%type,
                  p_mt      in  sw_mt.mt%type,
                  p_tag     in  sw_tag.tag%type ) return sw_operw.value%type
    is

    l_value    sw_operw.value%type;    /* значение доп. реквизита документа */

    begin

        select w.value into l_value
          from operw w
         where w.ref = p_ref
           and w.tag in (select rpad(m.tag || decode(o.opt, '-', null, o.opt), 5, ' ')
                           from sw_model m, sw_model_opt o
                          where m.mt  = p_mt
                            and m.tag = p_tag
                            and m.mt  = o.mt
                            and m.num = o.num );

        return l_value;

    exception
        when NO_DATA_FOUND then return null;
    end docmsg_document_getvalue_opt;


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_GETTAGOPT()
    --
    --     Функция возвращает опцию поля доп реквизита документа,
    --     который соответствует  указанному  полю  сообщения  в
    --     случае, когда для этого поля возможно одна из несколь-
    --     ких опций.
    --
    --
    --
    function docmsg_document_gettagopt(
                  p_ref     in  oper.ref%type,
                  p_mt      in  sw_mt.mt%type,
                  p_tag     in  sw_tag.tag%type ) return sw_opt.opt%type
    is

    l_value    sw_opt.opt%type;    /* значение доп. реквизита документа */

    begin

        select substr(w.tag, 3, 1) into l_value
          from operw w
         where w.ref = p_ref
           and w.tag in (select rpad(m.tag || decode(o.opt, '-', null, o.opt), 5, ' ')
                           from sw_model m, sw_model_opt o
                          where m.mt  = p_mt
                            and m.tag = p_tag
                            and m.mt  = o.mt
                            and m.num = o.num );

        return l_value;

    exception
        when NO_DATA_FOUND then return null;
    end docmsg_document_gettagopt;



    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VLDMSG103()
    --
    --     Процедура реализует специфичные для сообщения МТ103
    --     проверки документа
    --
    --
    --
    --
    procedure docmsg_document_vldmsg103(
                  p_ref     in  oper.ref%type )
    is


    type t_fld23e_p is record (
                        code1   char(4),
                        code2   char(4) );

    -- Локальные типы
    type t_fld23e_seq  is table of number index by varchar2(4);
    type t_fld23e_pair is table of t_fld23e_p index by binary_integer;


    l_fld23e_seq   t_fld23e_seq;        /*      Последовательность кодов в полях 23E */
    l_fld23e_pair  t_fld23e_pair;       /* Недопустимые комбинации кодов в полях 23E */
    l_value        sw_operw.value%type; /*                             Значение поля */
    l_list         t_strlist;           /*   Список значений для повторяющегося поля */


    l_fld56opt     sw_opt.opt%type;     /*                            Опция поля 56a */
    l_fld57opt     sw_opt.opt%type;     /*                            Опция поля 57a */


    l_fld23b       sw_operw.value%type; /*                         Значение поля 23B */
    l_fld33b       sw_operw.value%type; /*                         Значение поля 23E */
    l_fld71a       sw_operw.value%type; /*                         Значение поля 71A */
    l_fld71f       sw_operw.value%type; /*                         Значение поля 71F */
    l_fld71g       sw_operw.value%type; /*                         Значение поля 71G */

    l_curr         tabval.lcv%type;     /*                            ISO-код валюты */

    l_cpos         number;
    l_pos          number;

    begin

        --
        -- Initializing arrays
        --
        l_fld23e_seq('SDVA') :=  1; l_fld23e_seq('INTC') :=  2; l_fld23e_seq('REPA') :=  3;
        l_fld23e_seq('CORT') :=  4; l_fld23e_seq('HOLD') :=  5; l_fld23e_seq('CHQB') :=  6;
        l_fld23e_seq('PHOB') :=  7; l_fld23e_seq('TELB') :=  8; l_fld23e_seq('PHON') :=  9;
        l_fld23e_seq('TELE') := 10; l_fld23e_seq('PHOI') := 11; l_fld23e_seq('TELI') := 12;

        l_fld23e_pair(1).code1  := 'SDVA'; l_fld23e_pair(1).code2  := 'HOLD';
        l_fld23e_pair(2).code1  := 'SDVA'; l_fld23e_pair(2).code2  := 'CHQB';
        l_fld23e_pair(3).code1  := 'INTC'; l_fld23e_pair(3).code2  := 'HOLD';
        l_fld23e_pair(4).code1  := 'INTC'; l_fld23e_pair(4).code2  := 'CHQB';
        l_fld23e_pair(5).code1  := 'CORT'; l_fld23e_pair(5).code2  := 'HOLD';
        l_fld23e_pair(6).code1  := 'CORT'; l_fld23e_pair(6).code2  := 'CHQB';
        l_fld23e_pair(7).code1  := 'HOLD'; l_fld23e_pair(7).code2  := 'CHQB';
        l_fld23e_pair(8).code1  := 'PHOB'; l_fld23e_pair(8).code2 := 'TELB';
        l_fld23e_pair(9).code1  := 'PHON'; l_fld23e_pair(9).code2 := 'TELE';
        l_fld23e_pair(10).code1 := 'PHOI'; l_fld23e_pair(10).code2 := 'TELI';
        l_fld23e_pair(11).code1 := 'REPA'; l_fld23e_pair(11).code2 := 'HOLD';
        l_fld23e_pair(12).code1 := 'REPA'; l_fld23e_pair(12).code2 := 'CHQB';
        l_fld23e_pair(13).code1 := 'REPA'; l_fld23e_pair(13).code2 := 'CORT';


        --
        -- (D98) Коды в полях 23E должны быть в такой последовательности:
        --       SVDA->INTC->REPA->CORT->HOLD->CHQB->PHOB->TELB->
        --       PHON->TELE->PHOI->TELI
        --
        l_value := genmsg_document_getvalue(p_ref, '23E');

        if (l_value is not null) then

            l_list := genmsg_document_getvaluelist(l_value);

            l_cpos := 0;

            for i in 1..l_list.count
            loop

                l_pos := l_fld23e_seq(substr(l_list(i), 1, 4));

                if (l_pos < l_cpos) then
                    raise_application_error(-20782, 'D98: Неверная последовательность кодов в поле 23E');
                elsif (l_pos = l_cpos) then
                    raise_application_error(-20782, 'E46: Найдены повторяющиеся коды в поле 23E');
                else
                    l_cpos := l_pos;
                end if;

            end loop;

            -- Очищаем список
            l_list.delete;

        end if;


        --
        -- (D67) Недопустимые комбинации кодов в полях 23Е
        --
        --
        l_value := genmsg_document_getvalue(p_ref, '23E');

        if (l_value is not null) then

            l_list := genmsg_document_getvaluelist(l_value);

            for i in 1..l_list.count
            loop

                -- Для каждого из полей ищем первый код по списку недопустимых комбинаций
                for j in 1..l_fld23e_pair.count
                loop

                    if (substr(l_list(i), 1, 4) = l_fld23e_pair(j).code1) then

                        -- Нашел совпадение, ищу вхождение второго кода (недопустимого)
                        for k in 1..l_list.count
                        loop

                            if (l_fld23e_pair(j).code2 = substr(l_list(k), 1, 4)) then
                                raise_application_error(-20782, 'D67: Найдено недопустимое сочетание кодов в поле 23E: ' || substr(l_list(i), 1, 4) || '<->' || substr(l_list(k), 1, 4));
                            end if;

                        end loop;

                    end if;
                end loop;

            end loop;

            -- Очищаем список
            l_list.delete;

        end if;

        --
        -- (TXX) Если поле 26T заполнено, то должно быть заполнено поле 77B
        --
        if (genmsg_document_getvalue(p_ref, '26T') is not null) then

            if (genmsg_document_getvalue(p_ref, '77B') is null) then
                raise_application_error(-20782, 'TXX: При заполенном поле 26T не заполнено поле 77B');
            end if;

        end if;




        --
        -- NVR-C1: (D75) Если поле 33B заполнено и код валюты в поле 32A не равен
        --               коду валюты в поле 33B, то поле 36 обязательно
        --
        l_fld33b := genmsg_document_getvalue(p_ref, '33B');

        if (l_fld33b is not null) then

            select t.lcv into l_curr
              from oper o, tabval t
             where o.ref = p_ref
               and o.kv  = t.kv;

            bars_audit.trace('document currency is %s', l_curr);

            if (substr(l_fld33b, 1, 3) != l_curr) then

                if (genmsg_document_getvalue(p_ref, '36') is null) then
                    raise_application_error(-20782, 'D75: Не заполнено поле 36 при различном коде валюты в полях 33B и 32A');
                end if;

            end if;
        else
            if (genmsg_document_getvalue(p_ref, '36') is not null) then
                raise_application_error(-20782, 'D75: Использование поля 36 запрещено без поля 33B');
            end if;
        end if;

        --
        -- NVR-C2: (D49) Если страна отправителя или получателя одна из списка, то поле 33B
        --               обязательно. Наша страна в этот список не входит, а получателя на
        --               момент когда корсчет не подобран и банк получателя не известен мы
        --               мы определить не можем, поэтому проверку пропускаем
        --
        bars_audit.trace('docmsg_vdldoc103: NVR-C2 skipped');

        --
        -- NVR-C3:       Если поле 23B равно SPRI, то для поля 23E разрешены только след.
        --               коды: SDVA, TELB, PHONB, INTC (Ошибка E01)
        --               Если поле 23B равно SSTD или SPAY, то поле 23E не используется
        --               (ошибка E02)
        --
        l_fld23b := genmsg_document_getvalue(p_ref, '23B');

        if (l_fld23b is not null and l_fld23b = 'SPRI') then

            l_value := genmsg_document_getvalue(p_ref, '23E');

            if (l_value is not null) then

                l_list := genmsg_document_getvaluelist(l_value);


                for i in 1..l_list.count
                loop

                    if (l_list(i) not in ('SDVA', 'TELB', 'PHONB', 'INTC')) then
                        raise_application_error(-20782, 'E01: Недопустимый код в поле 23E при значении SPRI в поле 23B');
                    end if;

                end loop;

                -- Очищаем список
                l_list.delete;

            end if;

        elsif (l_fld23b is not null and l_fld23b in ('SSTD', 'SPAY')) then

            if (genmsg_document_getvalue(p_ref, '23E') is not null) then
                raise_application_error(-20782, 'E02: Использование поля 23E запрещено при значенях поля 23B SSTD или SPAY');
            end if;

        end if;

        --
        -- NVR-C4: (E03) Если значение поля 23B SPRI, SSTD или SPAY, то использование
        --               поля 53D запрещено
        --
        l_fld23b := genmsg_document_getvalue(p_ref, '23B');

        if (l_fld23b is not null and l_fld23b in ('SPRI', 'SSTD', 'SPAY')) then

            if (genmsg_document_getvalue(p_ref, '53D') is not null) then
                raise_application_error(-20782, 'E03: Использование поля 53D запрещено при значенях поля 23B SPRI, SSTD или SPAY');
            end if;

        end if;

        --
        -- NVR-C5: (E04) Если значение поля 23B SPRI, SSTD или SPAY, то при использовании
        --               поля 53B обязательно должен быть указан "Party Identifier"
        --
        l_fld23b := genmsg_document_getvalue(p_ref, '23B');

        if (l_fld23b is not null and l_fld23b in ('SPRI', 'SSTD', 'SPAY')) then

            l_value := genmsg_document_getvalue(p_ref, '53B');
            if (l_value is not null and substr(l_value, 1, 1) != '/') then
                raise_application_error(-20782, 'E04: Некорректное использование поля 53B при значенях поля 23B SPRI, SSTD или SPAY');
            end if;

        end if;

        --
        -- NVR-C6: (E05) Если значение поля 23B SPRI, SSTD или SPAY, то при использовании
        --               поля 54а возможна только опция A
        --
        l_fld23b := genmsg_document_getvalue(p_ref, '23B');

        if (l_fld23b is not null and l_fld23b in ('SPRI', 'SSTD', 'SPAY')) then

            l_value := docmsg_document_gettagopt(p_ref, 103, '54');

            if (l_value is not null and l_value != 'A') then
                raise_application_error(-20782, 'E05: Недопустимая опция поля 54a при значении поля 23B SPRI, SSTD или SPAY');
            end if;

        end if;

        --
        -- NVR-C7: (E06) Если заполнено поле 55a, то должны быть заполнены поля 53a и 54a
        --
        if (docmsg_document_getvalue_opt(p_ref, 103, '55') is not null) then

            if (docmsg_document_getvalue_opt(p_ref, 103, '53') is null or
                docmsg_document_getvalue_opt(p_ref, 103, '54') is null    ) then

                raise_application_error(-20782, 'E06: Не заполнено поле 53a или 54a при заполненном поле 55a');

            end if;


        end if;

        --
        -- NVR-C8: (E07) Если значение поля 23B SPRI, SSTD или SPAY, то при использовании
        --               поля 55а возможна только опция A
        --
        l_fld23b := genmsg_document_getvalue(p_ref, '23B');

        if (l_fld23b is not null and l_fld23b in ('SPRI', 'SSTD', 'SPAY')) then

            l_value := docmsg_document_gettagopt(p_ref, 103, '55');

            if (l_value is not null and l_value != 'A') then
                raise_application_error(-20782, 'E07: Недопустимая опция поля 55a при значении поля 23B SPRI, SSTD или SPAY');
            end if;

        end if;

        --
        -- NVR-C9: (С81) Если заполнено поле 56a, то должно быть заполнено поле 57a
        --
        if (docmsg_document_getvalue_opt(p_ref, 103, '56') is not null) then

            if (docmsg_document_getvalue_opt(p_ref, 103, '57') is null) then
                raise_application_error(-20782, 'С81: Не заполнено поле 57a при заполненном поле 56a');
            end if;

        end if;

        --
        -- NVR-C10:      Если значение поля 23B SPRI, то поле 56a должно быть заполнено (ошибка E16)
        --               Если значение поля 23B SSTD или SPAY, то поле 56a должно использоваться с
        --               опциями A или C (ошибка E17)
        --
        l_fld23b := genmsg_document_getvalue(p_ref, '23B');

        if (l_fld23b is not null and l_fld23b = 'SPRI') then

            if (docmsg_document_getvalue_opt(p_ref, 103, '56') is not null) then
                raise_application_error(-20782, 'E16: Незаполнено поле 56a при значении SPRI в поле 23B');
            end if;

        end if;

        if (l_fld23b is not null and l_fld23b in ('SSTD', 'SPAY')) then

            l_fld56opt := docmsg_document_gettagopt(p_ref, 103, '56');

            if (l_fld56opt is not null and l_fld56opt not in ('A', 'C')) then

                raise_application_error(-20782, 'E17: Недопустимая опция поля 56a при значении SSTD или SPAY в поле 23B');

            elsif (l_fld56opt is not null and l_fld56opt = 'C') then

                if (substr(genmsg_document_getvalue(p_ref, '56C'), 1, 2) != '//') then
                    raise_application_error(-20782, 'E17: Недопустимая опция поля 56a при значении SSTD или SPAY в поле 23B (C)');
                end if;

            end if;

        end if;

        --
        -- NVR-C11: (E09) Если значение поля 23B SPRI, SSTD или SPAY, то при использовании
        --                поля 57a должны использоваться опции A, C, D. При использовании
        --                опции D должен быть заполнен "Party Identifier"
        --
        l_fld23b := genmsg_document_getvalue(p_ref, '23B');

        if (l_fld23b is not null and l_fld23b in ('SPRI', 'SSTD', 'SPAY')) then

            l_fld57opt := docmsg_document_gettagopt(p_ref, 103, '57');

            if (l_fld57opt is not null and l_fld57opt not in ('A', 'C', 'D')) then

                raise_application_error(-20782, 'E09: Недопустимая опция поля 57a при значении SSTD или SPAY в поле 23B');

            elsif (l_fld57opt is not null and l_fld57opt = 'D') then

                if (substr(docmsg_document_getvalue_opt(p_ref, 103, '57'), 1, 1) != '/') then
                    raise_application_error(-20782, 'E09: Недопустимая опция поля 57a при значении SSTD или SPAY в поле 23B (D)');
                end if;

            end if;

        end if;

        --
        -- NVR-C12: (E10) Если значение поля 23B SPRI, SSTD или SPAY, то в поле 59a
        --                должно присутствовать подполе "Счет"
        --
        l_fld23b := genmsg_document_getvalue(p_ref, '23B');

        if (l_fld23b is not null and l_fld23b in ('SPRI', 'SSTD', 'SPAY')) then

            if (substr(docmsg_document_getvalue_opt(p_ref, 103, '59'), 1, 1) != '/') then
                raise_application_error(-20782, 'E10: Не заполнено подполе "Счет" в поле 59a при значении поля 23B SPRI, SSTD или SPAY');
            end if;

        end if;

        --
        -- NVR-C13: (E18) Если поле 23E содержит код CHQB, то подполе "Счет" в поле 59a
        --                запрещено
        --
        l_value := genmsg_document_getvalue(p_ref, '23E');

        if (l_value is not null) then

            l_list := genmsg_document_getvaluelist(l_value);


            for i in 1..l_list.count
            loop

                if (l_list(i) = 'CHQB') then

                    if (substr(docmsg_document_getvalue_opt(p_ref, 103, '59'), 1, 1) = '/') then
                        raise_application_error(-20782, 'E18: Использование подполя "Счет" в поле 59a запрещено при наличии кода CHQB в поле 23E');
                    end if;

                end if;

            end loop;

            -- Очищаем список
            l_list.delete;

        end if;

        --
        -- NVR-C14: (E12) Поля 70 и 77T взаимоисключающие
        --
        --
        if (genmsg_document_getvalue(p_ref, '70') is not null) then

            if (genmsg_document_getvalue(p_ref, '77T') is not null) then
                raise_application_error(-20782, 'E12: Одновременное использование полей 70 и 77T запрещено');
            end if;

        end if;

        --
        -- NVR-C15: Если поле 71A содержит OUR, то использование поля 71F запрещено,
        --          поле 71G опциональное (ошибка E13)
        --          Если поле 71A содержит SHA, то поле 71F опциональное, использование
        --          поля 71G запрещено (ошибка D50)
        --          Если поле 71A содержит BEN, то поле 71F обязательное, использование
        --          поля 71G запрещено (ошибка E15)
        --
        l_fld71a := genmsg_document_getvalue(p_ref, '71A');
        l_fld71f := genmsg_document_getvalue(p_ref, '71F');
        l_fld71g := genmsg_document_getvalue(p_ref, '71G');

        if    (l_fld71a = 'OUR') then

            if (l_fld71f is not null) then
                raise_application_error(-20782, 'E13: Использование поля 71F запрещено при значении OUR поля 71A');
            end if;

        elsif (l_fld71a = 'SHA') then

            if (l_fld71g is not null) then
                raise_application_error(-20782, 'D50: Использование поля 71G запрещено при значении SHA поля 71A');
            end if;

        elsif (l_fld71a = 'BEN') then

            if (l_fld71f is null) then
                raise_application_error(-20782, 'E15: Поле 71F является обязательным при значении BEN поля 71A');
            end if;

            if (l_fld71g is not null) then
                raise_application_error(-20782, 'E15: Использование поля 71G запрещено при значении BEN поля 71A');
            end if;

        end if;


        --
        -- NVR-C16: (D51) Если присутствует одно из полей 71F или 71G, то поле 33B
        --                обязательно к заполнению
        --
        l_fld33b := genmsg_document_getvalue(p_ref, '33B');
        l_fld71f := genmsg_document_getvalue(p_ref, '71F');
        l_fld71g := genmsg_document_getvalue(p_ref, '71G');

        if ((l_fld71g is not null or l_fld71f is not null) and l_fld33b is null) then
            raise_application_error(-20782, 'D51: Не заполнено поле 33B при заполненном поле 71F или 71G');
        end if;


        --
        -- NVR-C17: (E44) Если поле 56a отсутствует, то в полях 23E не долно быть
        --                кодов TELI или PHOI
        --
        if (docmsg_document_getvalue_opt(p_ref, 103, '56') is null) then

            l_value := genmsg_document_getvalue(p_ref, '23E');

            if (l_value is not null) then

                l_list := genmsg_document_getvaluelist(l_value);

                for i in 1..l_list.count
                loop

                    if (   substr(l_list(i), 1, 4) = 'TELI'
                        or substr(l_list(i), 1, 4) = 'PHOI') then
                        raise_application_error(-20782, 'E44: При отсутствии поля 56a недопустимо использование кодов TELI, PHOI в полях 23E');
                    end if;

                end loop;

                -- Очищаем список
                l_list.delete;

            end if;

        end if;

        --
        -- NVR-C18: (E45) Если поле 57a отсутствует, то в полях 23E не долно быть
        --                кодов TELE или PHON
        --
        if (docmsg_document_getvalue_opt(p_ref, 103, '57') is null) then

            l_value := genmsg_document_getvalue(p_ref, '23E');

            if (l_value is not null) then

                l_list := genmsg_document_getvaluelist(l_value);

                for i in l_list.first..l_list.last
                loop

                    if (   substr(l_list(i), 1, 4) = 'TELE'
                        or substr(l_list(i), 1, 4) = 'PHON')  then
                        raise_application_error(-20782, 'E45: При отсутствии поля 57a недопустимо использование кодов TELE, PHON в полях 23E');
                    end if;

                end loop;

                -- Очищаем список
                l_list.delete;

            end if;

        end if;

        --
        -- NVR-C19: (C02) Код валюты в полях 71G и 32A должен совпадать
        --
        l_fld71g := genmsg_document_getvalue(p_ref, '71G');

        if (l_fld71g is not null) then

            select t.lcv into l_curr
              from oper o, tabval t
             where o.ref = p_ref
               and o.kv  = t.kv;

            bars_audit.trace('document currency is %s', l_curr);

            if (substr(l_fld71g, 1, 3) != l_curr) then
                raise_application_error(-20782, 'C02: Код валюты в полях 71G и 32A должен совпадать');
            end if;

        end if;

    end docmsg_document_vldmsg103;


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VLDMSG202()
    --
    --     Процедура реализует специфичные для сообщения МТ202
    --     проверки документа
    --
    --
    --
    --
    procedure docmsg_document_vldmsg202(
                  p_ref     in  oper.ref%type )
    is

    l_value   sw_operw.value%type;

    begin

        -- NVR-C1:(C81) Если есть поле 56a, то должно быть поле 57a
        bars_audit.trace('validating rule MT202-C1: for error C81...');

        if (docmsg_document_getvalue_opt(p_ref, 202, '56') is not null) then

            bars_audit.trace('field 56a present, checking value in field 57a...');

            l_value := docmsg_document_getvalue_opt(p_ref, 202, '57');

            if (l_value is null) then
                bars_audit.error('C81: Поле 57a должно быть заполнено, если заполнено поле 56a');
                raise_application_error(-20782, 'C81: Поле 57a должно быть заполнено, если заполнено поле 56a');
            end if;

            bars_audit.trace('field 57a present, check MT202-C1 complete.');

        else
            bars_audit.trace('field 56a not present, skip check MT202-C1.');
        end if;

    end docmsg_document_vldmsg202;






    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_GETVALUE()
    --
    --     Процедура получения значения доп. реквизита документа
    --
    --     Параметры:
    --
    --         p_doc      Структура документа
    --
    --         p_docwtag  Код доп.реквизита
    --
    --
    function docmsg_document_getvalue(
                  p_doc      in  t_doc,
                  p_docwtag  in  t_docwtag ) return t_docwval
    is
    p       constant varchar2(100) := PKG_CODE || '.dmdocgetval(s)';
    --
    l_value t_docwval;       /* Значение доп. реквизита */
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>... par[1]=>%s', p, p_docwtag);
        l_value := p_doc.doclistw(p_docwtag).value;
        bars_audit.trace('%s: succ end, return %s', p, l_value);
        return l_value;
    exception
        when NO_DATA_FOUND then
            bars_audit.trace('%s: succ end, return null (docwtag "%s" not found)', p, p_docwtag);
            return null;
    end docmsg_document_getvalue;





    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_GETSPECVALUE()
    --
    --     Процедура получения значения для поля сообщения,
    --     для которого используется спец. обработка
    --
    --     Параметры:
    --
    --         p_doc        Структура документа
    --
    --         p_modelrec   Строка модели сообщения
    --
    --         p_opt        Возвр. значение. Опция поля
    --
    --         p_docwtag    Возвр. значение. Код доп. реквизита
    --
    --
    function docmsg_document_getspecvalue(
                  p_doc      in  t_doc,
                  p_modelrec in  t_swmodelrec,
                  p_opt      out t_swmsg_tagopt,
                  p_docwtag  out t_docwtag       ) return t_docwval
    is
    p       constant varchar2(100) := PKG_CODE || '.dmdocgetspval';
    --
    l_value     t_docwval;       /* Значение доп. реквизита */
    l_docacca   oper.nlsa%type;  /*     Номер счета клиента */
    l_amount    number;
    l_accnostro number;
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, p_modelrec.tag, p_modelrec.opt);

        -- Поле 32A
        if   (    p_modelrec.mt in (103, 200, 202)
              and p_modelrec.tag = '32'
              and p_modelrec.opt = 'A'             ) then

             if (p_doc.docrec.ref is null) then
                 l_amount := p_doc.docrec.s;
             else

                 begin
                     select to_number(value) into l_accnostro
                       from operw
                      where ref = p_doc.docrec.ref
                        and tag = 'NOS_A';
                 exception
                     when NO_DATA_FOUND then l_accnostro := 0;
                 end;

                 -- Если корсчет еще не подобран, то значение реквизита NOS_A=0
                 -- и сумму проверяем по сумме документа

                 if (l_accnostro > 0) then

                      select s into l_amount
                        from opldok
                       where ref = p_doc.docrec.ref
                         and dk  = 1
                         and acc = l_accNostro;

                 else
                     l_amount := p_doc.docrec.s;
                 end if;

             end if;
            l_value := to_char(p_doc.docrec.vdat, 'yymmdd') || bars_swift.amounttoswift(l_amount, p_doc.docrec.kv, true, true);

        elsif (    p_modelrec.mt  = 103
               and p_modelrec.tag = '23'
               and p_modelrec.opt = 'B' ) then

             -- Получаем значение доп.реквизита
             l_value := docmsg_document_getvalue(p_doc, trim(p_modelrec.dtmtag));
             bars_audit.trace('%s: document property %s value is %s', p, p_modelrec.dtmtag, l_value);

             -- Подставляем умолчательное значение
             if (l_value is null) then
                 l_value := 'CRED';
                 bars_audit.trace('%s: default value %s is set', p, l_value);
             end if;

        elsif (    p_modelrec.mt  = 103
               and p_modelrec.tag = '70'
               and p_modelrec.opt is null ) then

             -- Получаем значение доп.реквизита
             l_value := docmsg_document_getvalue(p_doc, trim(p_modelrec.dtmtag));
             bars_audit.trace('%s: document property %s value is %s', p, p_modelrec.dtmtag, l_value);

             -- Если доп.реквизита нет, берем из назначения платежа
             if (l_value is null) then
                l_value := str_wrap(substr(p_doc.docrec.nazn, 1, 120), 30);
                bars_audit.trace('%s: value get from payment description %s', p, l_value);
            end if;

        elsif (    p_modelrec.mt = 103
               and p_modelrec.tag = '50'
               and p_modelrec.opt = 'a' ) then

            -- Получаем значения по возможным опциям
            l_value := docmsg_document_getvalue(p_doc, '50A');
            p_opt   := 'A';

            if (l_value is null) then
                l_value := docmsg_document_getvalue(p_doc, '50K');
                p_opt   := 'K';
            else
                -- Проверяем отсутствие опции K
                if (docmsg_document_getvalue(p_doc, '50K') is not null) then
                    bars_audit.trace('%s: error detected - two or more options found', p);
                    bars_error.raise_nerror(MODCODE, 'DOCMSG_TOOMANYOPTIONS_FOUND', p_modelrec.tag);
                end if;
            end if;

            if (l_value is null) then
                l_value := docmsg_document_getvalue(p_doc, '50F');
                p_opt   := 'F';
            else
                -- Проверяем отсутствие опции F
                if (docmsg_document_getvalue(p_doc, '50F') is not null) then
                    bars_audit.trace('%s: error detected - two or more options found', p);
                    bars_error.raise_nerror(MODCODE, 'DOCMSG_TOOMANYOPTIONS_FOUND', p_modelrec.tag);
                end if;
            end if;

            -- Получаем клиента из номер счета
            if (l_value is null) then

                -- Если документ не наш, то значение должно
                -- передаваться как доп. реквизит
                if (p_doc.docrec.mfoa != gl.aMFO or p_doc.docrec.ref is null) then
                    return null;
                end if;

                -- По номеру счета и коду валюты находим
                -- клиента и его параметры
                select o.nlsa, substr(c.nmkk, 1, 30) || ' ' || substr(c.adr, 1, 90)
                  into l_docacca, l_value
                  from oper o, accounts a, cust_acc ca, customer c
                 where o.ref = p_doc.docrec.ref
                   and a.nls = o.nlsa
                   and a.kv  = o.kv
                   and a.acc = ca.acc
                   and c.rnk = ca.rnk;

                l_value := '/' || l_docacca || CRLF || str_wrap(l_value, 30);
                p_opt := 'K';

            end if;

        elsif (    p_modelrec.mt  = 202
               and p_modelrec.tag = '21'
               and p_modelrec.opt is null ) then

             -- Получаем значение доп.реквизита
             l_value := docmsg_document_getvalue(p_doc, trim(p_modelrec.dtmtag));
             bars_audit.trace('%s: document property %s value is %s', p, p_modelrec.dtmtag, l_value);

             -- Подставляем умолчательное значение
             if (l_value is null) then
                 l_value := 'NONREF';
                 bars_audit.trace('%s: default value %s is set', p, l_value);
             end if;

        else
            bars_audit.trace('%s: error detected - unknown spec tag %s opt %s', p, p_modelrec.tag, p_modelrec.opt);
            bars_error.raise_nerror(MODCODE, 'DOCMSG_UNKNOWN_SPECTAG', p_modelrec.tag || p_modelrec.opt);
        end if;

        bars_audit.trace('%s: succ end, return %s', p, l_value);
        return l_value;

    end docmsg_document_getspecvalue;












    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_GETVALUE()
    --
    --     Процедура получения значения для поля сообщения
    --
    --     Параметры:
    --
    --         p_doc        Структура документа
    --
    --         p_modelrec   Строка модели сообщения
    --
    --         p_opt        Возвр. значение. Опция поля
    --
    --         p_docwtag    Возвр. значение. Код доп. реквизита
    --
    --
    function docmsg_document_getvalue(
                  p_doc      in  t_doc,
                  p_modelrec in  t_swmodelrec,
                  p_opt      out t_swmsg_tagopt,
                  p_docwtag  out t_docwtag       ) return t_docwval
    is
    p       constant varchar2(100) := PKG_CODE || '.dmdocgetval';
    --
    l_existopt  boolean := false;    /* признак наличия опции (для списка возможных) */
    l_value     t_docwval;           /* значение доп. реквизита */
    --
    begin
        bars_audit.trace('%s: entry point', p);


        -- Если указана спец.обработка, то вызываем функцию
        if (p_modelrec.spec is not null and p_modelrec.spec = 'Y') then

            l_value := docmsg_document_getspecvalue(p_doc, p_modelrec, p_opt, p_docwtag);

            if (p_modelrec.opt != lower(p_modelrec.opt) or p_modelrec.opt is null) then
                  p_opt := trim(p_modelrec.opt);
            end if;

        else

            -- Если возможна только одна опция, то получаем значение
            if (p_modelrec.opt != lower(p_modelrec.opt) or p_modelrec.opt is null) then

                l_value   := docmsg_document_getvalue(p_doc, trim(p_modelrec.dtmtag));
                p_opt     := trim(p_modelrec.opt);
                p_docwtag := trim(p_modelrec.dtmtag);
                bars_audit.trace('%s: fixed option %s, value is %s', p, p_opt, l_value);

            else

                -- Ищем среди доступных опций, опцию представленную в этом документе
                for c in (select decode(o.opt, '-', null, o.opt) opt
                            from sw_model_opt o
                           where o.mt  = p_modelrec.mt
                             and o.num = p_modelrec.num )
                loop
                    bars_audit.trace('%s: looking for option %s...', p, c.opt);

                    begin
                        l_value   := p_doc.doclistw(p_modelrec.tag || c.opt).value;
                        p_opt     := trim(c.opt);
                        p_docwtag := p_modelrec.tag || c.opt;   -- possible error, i use concat, but need DTMTAG
                        bars_audit.trace('%s: found option "%s", value is %s', p, p_opt, l_value);

                        if (l_existopt) then
                            bars_audit.trace('%s: error detected - two or more options found', p);
                            bars_error.raise_nerror(MODCODE, 'DOCMSG_TOOMANYOPTIONS_FOUND', p_modelrec.tag);
                        else
                            l_existopt := true;
                        end if;

                    exception
                        when NO_DATA_FOUND then
                            bars_audit.trace('%s: option %s not found', p, c.opt);
                    end;
                    bars_audit.trace('%s: option %s processed.', p, c.opt);

                end loop;

            end if;

        end if;

        bars_audit.trace('%s: succ end, value %s', p, l_value);
        return l_value;

    end docmsg_document_getvalue;


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_GETVALUE()
    --
    --     Процедура получения значения для поля сообщения по типу
    --     сообщения и коду поля
    --
    --     Параметры:
    --
    --         p_doc        Структура документа
    --
    --         p_mt         Код типа сообщения
    --
    --         p_tag        Код поля
    --
    --         p_opt        Опция поля
    --
    --         p_tagopt     Возвращаемое значение. Представленная
    --                      опция
    --
    function docmsg_document_getvalue(
                  p_doc      in  t_doc,
                  p_mt       in  t_swmt,
                  p_tag      in  t_swmsg_tag,
                  p_opt      in  t_swmsg_tagopt,
                  p_tagopt   out t_swmsg_tagopt ) return t_docwval
    is
    p       constant varchar2(100) := PKG_CODE || '.dmdocgetval(tagopt)';
    --
    l_modelrec  t_swmodelrec;     /*           Описание поля сообщения */
    l_opt       t_swmsg_tagopt;   /*         Представленная опция поля */
    l_docwtag   t_docwtag;        /*      Код доп. реквизита документа */
    l_docwval   t_docwval;        /* Значение доп. реквизита документа */
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s', p, to_char(p_mt), p_tag, p_opt);

        -- Получаем описание поля сообщения
        begin
            select * into l_modelrec
              from sw_model
             where mt  = p_mt
               and tag = p_tag
               and nvl(trim(opt), '-') = nvl(trim(p_opt), '-');
        exception
            when NO_DATA_FOUND then
                bars_audit.trace('%s: error detected - tag not found for this message type', p);
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGMODEL_TAGNOTFOUND', to_char(p_mt), p_tag || p_opt);
            when TOO_MANY_ROWS then
                bars_audit.trace('%s: error detected - multiple tags found for this criteria', p);
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGMODEL_TAGNOTFOUND', to_char(p_mt), p_tag || p_opt);
        end;
        bars_audit.trace('%s: model rec got', p);

        -- Получаем значение
        l_docwval := docmsg_document_getvalue(p_doc, l_modelrec, p_tagopt, l_docwtag);
        bars_audit.trace('%s: succ end, value %s tagopt %s', p, l_docwval, p_tagopt);
        return l_docwval;

    end docmsg_document_getvalue;


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_GETVALUE()
    --
    --     Процедура получения значения для поля сообщения по типу
    --     сообщения и коду поля
    --
    --     Параметры:
    --
    --         p_doc        Структура документа
    --
    --         p_mt         Код типа сообщения
    --
    --         p_tag        Код поля
    --
    --         p_opt        Опция поля
    --
    function docmsg_document_getvalue(
                  p_doc      in  t_doc,
                  p_mt       in  t_swmt,
                  p_tag      in  t_swmsg_tag,
                  p_opt      in  t_swmsg_tagopt ) return t_docwval
    is
    p       constant varchar2(100) := PKG_CODE || '.dmdocgetval(tag)';
    --
    l_tagopt    t_swmsg_tagopt;   /*         Представленная опция поля */
    l_docwval   t_docwval;        /* Значение доп. реквизита документа */
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s', p, to_char(p_mt), p_tag, p_opt);
        l_docwval := docmsg_document_getvalue(p_doc, p_mt, p_tag, p_opt, l_tagopt);
        bars_audit.trace('%s: succ end, value %s, tagopt %s', p, l_docwval, l_tagopt);
        return l_docwval;
   end docmsg_document_getvalue;



    -----------------------------------------------------------------
    -- DOCMSG_VALIDATE_FIELD()
    --
    --     Процедура проверки корректности значения тега сообщения
    --     (тег сформирован из доп. реквизита документа)
    --
    --
    --
    --
    --
    procedure docmsg_validate_field(
                  p_tag      in t_swmsg_tag,
                  p_tagopt   in t_swmsg_tagopt,
                  p_tagrpblk in t_swmsg_tagrpblk,
                  p_value    in t_swmsg_tagvalue )
    is
    p       constant varchar2(100) := PKG_CODE || '.dmvldfld';
    --
    l_list  t_swmsg_tagvallist;  /* список значений */
    --
    begin
        bars_audit.trace('%s: entry poing par[0]=>%s par[1]=>%s par[2]=>%s par[3]=>%s', p, p_tag, p_tagopt, p_tagrpblk, p_value);

        if (p_tagrpblk = 'RI') then

            -- Получаем список значений из значения поля
            l_list := genmsg_document_getvaluelist(p_value);
            bars_audit.trace('%s: value list count is %s', p, to_char(l_list.count));

            -- Проходим по всем значениям
            for j in l_list.first..l_list.last
            loop
                bars_swift.validate_field(p_tag, p_tagopt, l_list(j), 1, 0);
                bars_audit.trace('value item %s validated.', p, to_char(j));
            end loop;

        else
            bars_swift.validate_field(p_tag, p_tagopt, p_value, 1, 0);
        end if;
        bars_audit.trace('%s: succ end, value validated', p);

    end docmsg_validate_field;


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VLDMSG103()
    --
    --     Процедура реализует специфичные для сообщения МТ103
    --     проверки документа
    --
    --
    --
    --
    procedure docmsg_document_vldmsg103(
                  p_doc     in      t_doc )
    is
    p          constant varchar2(100) := PKG_CODE || '.dmdocvldmsg103';
    --
    l_value23b   t_docwval;      /* Значение поля 23B */
    l_value23e   t_docwval;      /* Значение поля 23E */
    l_value32a   t_docwval;      /* Значение поля 32A */
    l_value33b   t_docwval;      /* Значение поля 33B */
    l_value53a   t_docwval;      /* Значение поля 53A */
    l_value54a   t_docwval;      /* Значение поля 54A */
    l_value55a   t_docwval;      /* Значение поля 55A */
    l_value56a   t_docwval;      /* Значение поля 56A */
    l_value57a   t_docwval;      /* Значение поля 57A */
    l_value71a   t_docwval;      /* Значение поля 71A */
    l_value71g   t_docwval;      /* Значение поля 71G */
    l_value71f   t_docwval;      /* Значение поля 71F */
    --
    l_list23e    t_strlist;      /* Список для поля 23E */
    l_tagopt     t_swmsg_tagopt; /* Опция поля */
    --

    type t_fld23e_p is record (
                        code1   char(4),
                        code2   char(4) );
    -- Локальные типы
    type t_fld23e_seq  is table of number index by varchar2(4);
    type t_fld23e_pair is table of t_fld23e_p index by binary_integer;
    --
    l_fld23e_seq   t_fld23e_seq;        /*      Последовательность кодов в полях 23E */
    l_fld23e_pair  t_fld23e_pair;       /* Недопустимые комбинации кодов в полях 23E */
    l_pos          number;
    l_cpos         number;
    --
    begin
        bars_audit.trace('%s: entry point', p);

        -- Initializing arrays
        l_fld23e_seq('SDVA') :=  1; l_fld23e_seq('INTC') :=  2; l_fld23e_seq('REPA') :=  3;
        l_fld23e_seq('CORT') :=  4; l_fld23e_seq('HOLD') :=  5; l_fld23e_seq('CHQB') :=  6;
        l_fld23e_seq('PHOB') :=  7; l_fld23e_seq('TELB') :=  8; l_fld23e_seq('PHON') :=  9;
        l_fld23e_seq('TELE') := 10; l_fld23e_seq('PHOI') := 11; l_fld23e_seq('TELI') := 12;

        l_fld23e_pair(1).code1  := 'SDVA'; l_fld23e_pair(1).code2  := 'HOLD';
        l_fld23e_pair(2).code1  := 'SDVA'; l_fld23e_pair(2).code2  := 'CHQB';
        l_fld23e_pair(3).code1  := 'INTC'; l_fld23e_pair(3).code2  := 'HOLD';
        l_fld23e_pair(4).code1  := 'INTC'; l_fld23e_pair(4).code2  := 'CHQB';
        l_fld23e_pair(5).code1  := 'CORT'; l_fld23e_pair(5).code2  := 'HOLD';
        l_fld23e_pair(6).code1  := 'CORT'; l_fld23e_pair(6).code2  := 'CHQB';
        l_fld23e_pair(7).code1  := 'HOLD'; l_fld23e_pair(7).code2  := 'CHQB';
        l_fld23e_pair(8).code1  := 'PHOB'; l_fld23e_pair(8).code2  := 'TELB';
        l_fld23e_pair(9).code1  := 'PHON'; l_fld23e_pair(9).code2  := 'TELE';
        l_fld23e_pair(10).code1 := 'PHOI'; l_fld23e_pair(10).code2 := 'TELI';
        l_fld23e_pair(11).code1 := 'REPA'; l_fld23e_pair(11).code2 := 'HOLD';
        l_fld23e_pair(12).code1 := 'REPA'; l_fld23e_pair(12).code2 := 'CHQB';
        l_fld23e_pair(13).code1 := 'REPA'; l_fld23e_pair(13).code2 := 'CORT';

        --
        -- (D98) Коды в полях 23E должны быть в такой последовательности:
        --       SVDA->INTC->REPA->CORT->HOLD->CHQB->PHOB->TELB->
        --       PHON->TELE->PHOI->TELI
        --
        bars_audit.trace('%s: validate rule D98...', p);

        l_value23e := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'E');
        bars_audit.trace('%s: value for tag 23E is %s', p, l_value23e);

        if (l_value23e is not null) then

            l_list23e := genmsg_document_getvaluelist(l_value23e);
            bars_audit.trace('%s: list of values created, count %s', p, to_char(l_list23e.count));

            -- Проходим по всем значениям
            l_cpos := 0;
            for i in 1..l_list23e.count
            loop
                l_pos := l_fld23e_seq(substr(l_list23e(i), 1, 4));

                if (l_pos < l_cpos) then
                    bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_D98');
                elsif (l_pos = l_cpos) then
                    bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E46');
                else
                    l_cpos := l_pos;
                end if;
            end loop;

            -- Очищаем список
            l_list23e.delete;
        end if;
        bars_audit.trace('%s: rule D98 validated.', p);



        --
        -- (D67) Недопустимые комбинации кодов в полях 23Е
        --
        --
        bars_audit.trace('%s: validate rule D67...', p);

        l_value23e := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'E');
        bars_audit.trace('%s: value for tag 23E is %s', p, l_value23e);

        if (l_value23e is not null) then

            l_list23e := genmsg_document_getvaluelist(l_value23e);
            bars_audit.trace('%s: list of values created, count %s', p, to_char(l_list23e.count));

            -- Проходим по всем значениям
            for i in l_list23e.first..l_list23e.last
            loop
                -- Для каждого из полей ищу его вхождение в список недопустимых комбинаций
                for j in 1..l_fld23e_pair.count
                loop
                    if (substr(l_list23e(i), 1, 4) = l_fld23e_pair(j).code1) then
                        -- По списку значений поля 23Е ищу вхождение второго кода (недопустимого)
                        for k in 1..l_list23e.count
                        loop
                            if (l_fld23e_pair(j).code2 = substr(l_list23e(k), 1, 4)) then
                                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_D67', l_list23e(i), l_list23e(k));
                            end if;
                        end loop;
                    end if;
                end loop;
            end loop;
            bars_audit.trace('%s: list of values validated.', p);

            -- Очищаем список
            l_list23e.delete;
        end if;
        bars_audit.trace('%s: rule D67 validated.', p);


        --
        -- (TXX) Если поле 26T заполнено, то должно быть заполнено поле 77B
        --
        bars_audit.trace('%s: validate rule TXX...', p);
        if (docmsg_document_getvalue(p_doc, MSG_MT103, '26', 'T') is not null) then
            bars_audit.trace('%s: looking for tag 77B...', p);
            if (docmsg_document_getvalue(p_doc, MSG_MT103, '77', 'B') is null) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_TXX');
            else
                bars_audit.trace('%s: tag 77B present, done', p);
            end if;
        end if;
        bars_audit.trace('%s: rule TXX validated.', p);

        --
        -- NVR-C1: (D75) Если поле 33B заполнено и код валюты в поле 32A не равен
        --               коду валюты в поле 33B, то поле 36 обязательно
        --
        bars_audit.trace('%s: validate rule MT103-C01...', p);

        l_value33b := docmsg_document_getvalue(p_doc, MSG_MT103, '33', 'B');
        bars_audit.trace('%s: value for tag 33B is %s', p, l_value33b);

        if (l_value33b is not null) then

            bars_audit.trace('%s: looking for tag 32A value...', p);
            l_value32a := docmsg_document_getvalue(p_doc, MSG_MT103, '32', 'A');
            bars_audit.trace('%s: value for tag 32A is %s', p, l_value32a);

            if (substr(l_value33b, 1, 3) != substr(l_value32a, 7, 3)) then

                bars_audit.trace('%s: looking for tag 36...', p);
                if (docmsg_document_getvalue(p_doc, MSG_MT103, '36', '') is null) then
                    bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_D75');
                else
                    bars_audit.trace('%s: tag 36 present, done.', p);
                end if;
            end if;
        else
            if (docmsg_document_getvalue(p_doc, MSG_MT103, '36', '') is not null) then
                    bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_D75');
            end if;
        end if;
        bars_audit.trace('%s: rule MT103-C01 validated.', p);


        --
        -- NVR-C2: (D49) Если страна отправителя или получателя одна из списка, то поле 33B
        --               обязательно. Наша страна в этот список не входит, а получателя на
        --               момент когда корсчет не подобран и банк получателя не известен мы
        --               мы определить не можем, поэтому проверку пропускаем
        --
        bars_audit.trace('%s: validattion rule MT103-C2 skipped', p);


        --
        -- NVR-C3:       Если поле 23B равно SPRI, то для поля 23E разрешены только след.
        --               коды: SDVA, TELB, PHONB, INTC (Ошибка E01)
        --               Если поле 23B равно SSTD или SPAY, то поле 23E не используется
        --               (ошибка E02)
        --
        bars_audit.trace('%s: validate rule MT103-C03...', p);

        l_value23b := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'B');
        bars_audit.trace('%s: value for tag 23B is %s', p, l_value23b);

        if (l_value23b is not null and l_value23b = 'SPRI') then

            l_value23e := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'E');
            bars_audit.trace('%s: value for tag 23E is %s', p, l_value23e);

            if (l_value23e is not null) then

                l_list23e := genmsg_document_getvaluelist(l_value23e);
                bars_audit.trace('%s: list of values created, count %s', p, to_char(l_list23e.count));

                -- Проходим по всем значениям
                for i in l_list23e.first..l_list23e.last
                loop
                    if (l_list23e(i) not in ('SDVA', 'TELB', 'PHONB', 'INTC')) then
                        bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E01');
                    end if;
                end loop;
                bars_audit.trace('%s: list of values validated.', p);

                -- Очищаем список
                l_list23e.delete;
            end if;

        elsif (l_value23b is not null and l_value23b in ('SSTD', 'SPAY')) then
            if (docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'E') is not null) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E02');
            end if;
        end if;
        bars_audit.trace('%s: rule MT103-C03 validated.', p);


        --
        -- NVR-C4: (E03) Если значение поля 23B SPRI, SSTD или SPAY, то использование
        --               поля 53D запрещено
        --
        bars_audit.trace('%s: validate rule MT103-C04...', p);

        l_value23b := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'B');
        bars_audit.trace('%s: value for tag 23B is %s', p, l_value23b);

        if (l_value23b is not null and l_value23b in ('SPRI', 'SSTD', 'SPAY')) then

            l_value53a := docmsg_document_getvalue(p_doc, MSG_MT103, '53', 'a', l_tagopt);
            bars_audit.trace('%s: tag 53B  value %s', p, l_value53a);

            if (l_value53a is not null and l_tagopt = 'D') then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E03');
            end if;
        end if;
        bars_audit.trace('%s: rule MT103-C04 validated.', p);


        --
        -- NVR-C5: (E04) Если значение поля 23B SPRI, SSTD или SPAY, то при использовании
        --               поля 53B обязательно должен быть указан "Party Identifier"
        --
        bars_audit.trace('%s: validate rule MT103-C05...', p);

        l_value23b := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'B');
        bars_audit.trace('%s: value for tag 23B is %s', p, l_value23b);

        if (l_value23b is not null and l_value23b in ('SPRI', 'SSTD', 'SPAY')) then

            l_value53a := docmsg_document_getvalue(p_doc, MSG_MT103, '53', 'a', l_tagopt);
            bars_audit.trace('%s: tag 53B  value %s', p, l_value53a);

            if (l_value53a is not null and l_tagopt = 'B' and substr(l_value53a, 1, 1) != '/') then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E04');
            end if;
        end if;
        bars_audit.trace('%s: rule MT103-C05 validated.', p);


        --
        -- NVR-C6: (E05) Если значение поля 23B SPRI, SSTD или SPAY, то при использовании
        --               поля 54а возможна только опция A
        --
        bars_audit.trace('%s: validate rule MT103-C06...', p);

        l_value23b := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'B');
        bars_audit.trace('%s: value for tag 23B is %s', p, l_value23b);

        if (l_value23b is not null and l_value23b in ('SPRI', 'SSTD', 'SPAY')) then

            l_value54a := docmsg_document_getvalue(p_doc, MSG_MT103, '54', 'a', l_tagopt);
            bars_audit.trace('%s: tag 54a option %s, value %s', p, l_tagopt, l_value54a);

            if (l_value54a is not null and l_tagopt != 'A') then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E05');
            end if;
        end if;
        bars_audit.trace('%s: rule MT103-C06 validated.', p);


        --
        -- NVR-C7: (E06) Если заполнено поле 55a, то должны быть заполнены поля 53a и 54a
        --
        bars_audit.trace('%s: validate rule MT103-C07...', p);

        if (docmsg_document_getvalue(p_doc, MSG_MT103, '55', 'a') is not null) then

            bars_audit.trace('%s: tag 55a present, looking for tags 53a and 54a...', p);
            if (docmsg_document_getvalue(p_doc, MSG_MT103, '53', 'a') is null or
                docmsg_document_getvalue(p_doc, MSG_MT103, '54', 'a') is null    ) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E06');
            else
                bars_audit.trace('%s: tags 53a and 54a present, done.', p);
            end if;
        end if;
        bars_audit.trace('%s: rule MT103-C07 validated.', p);


        --
        -- NVR-C8: (E07) Если значение поля 23B SPRI, SSTD или SPAY, то при использовании
        --               поля 55а возможна только опция A
        --
        bars_audit.trace('%s: validate rule MT103-C08...', p);

        l_value23b := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'B');
        bars_audit.trace('%s: value for tag 23B is %s', p, l_value23b);

        if (l_value23b is not null and l_value23b in ('SPRI', 'SSTD', 'SPAY')) then

            l_value55a := docmsg_document_getvalue(p_doc, MSG_MT103, '55', 'a', l_tagopt);
            bars_audit.trace('%s: tag 55a option %s, value %s', p, l_tagopt, l_value55a);

            if (l_value55a is not null and l_tagopt != 'A') then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E07');
            end if;
        end if;
        bars_audit.trace('%s: rule MT103-C08 validated.', p);


        --
        -- NVR-C9: (С81) Если заполнено поле 56a, то должно быть заполнено поле 57a
        --
        bars_audit.trace('%s: validate rule MT103-C09...', p);

        if (docmsg_document_getvalue(p_doc, MSG_MT103, '56', 'a') is not null) then
            bars_audit.trace('%s: tag 56a present, looking for tag 57a...', p);
            if (docmsg_document_getvalue(p_doc, MSG_MT103, '57', 'a') is null) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_C81');
            else
                bars_audit.trace('%s: tag 57a present, done', p);
            end if;
        end if;
        bars_audit.trace('%s: rule MT103-C09 validated.', p);


        --
        -- NVR-C10:      Если значение поля 23B SPRI, то поле 56a должно быть заполнено (ошибка E16)
        --               Если значение поля 23B SSTD или SPAY, то поле 56a должно использоваться с
        --               опциями A или C (ошибка E17)
        --
        bars_audit.trace('%s: validate rule MT103-C10...', p);

        l_value23b := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'B');
        bars_audit.trace('%s: value for tag 23B is %s', p, l_value23b);

        if (l_value23b is not null and l_value23b = 'SPRI') then
            if (docmsg_document_getvalue(p_doc, MSG_MT103, '56', 'a') is null) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E16');
            end if;
        end if;

        if (l_value23b is not null and l_value23b in ('SSTD', 'SPAY')) then

            l_value56a := docmsg_document_getvalue(p_doc, MSG_MT103, '56', 'a', l_tagopt);
            bars_audit.trace('%s: tag 56a option %s, value %s', p, l_tagopt, l_value56a);

            if    (l_value56a is not null and l_tagopt not in ('A', 'C')) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E17');
            elsif (l_value56a is not null and l_tagopt = 'C') then
                if (substr(l_value56a, 1, 2) != '//') then
                    bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E17');
                end if;
            end if;
        end if;
        bars_audit.trace('%s: rule MT103-C10 validated.', p);


        --
        -- NVR-C11: (E09) Если значение поля 23B SPRI, SSTD или SPAY, то при использовании
        --                поля 57a должны использоваться опции A, C, D. При использовании
        --                опции D должен быть заполнен "Party Identifier"
        --
        bars_audit.trace('%s: validate rule MT103-C11...', p);

        l_value23b := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'B');
        bars_audit.trace('%s: value for tag 23B is %s', p, l_value23b);

        if (l_value23b is not null and l_value23b in ('SPRI', 'SSTD', 'SPAY')) then

            bars_audit.trace('%s: looking for tag 57a...', p);
            l_value57a := docmsg_document_getvalue(p_doc, MSG_MT103, '57', 'a', l_tagopt);
            bars_audit.trace('%s: tag 57a option %s, value %s', p, l_tagopt, l_value57a);

            if (l_value57a is not null and l_tagopt not in ('A', 'C', 'D')) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E09');
            elsif (l_value57a is not null and l_tagopt = 'D') then
                if (substr(l_value57a, 1, 1) != '/') then
                    bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E09');
                end if;
            end if;

        end if;
        bars_audit.trace('%s: rule MT103-C11 validated.', p);


        --
        -- NVR-C12: (E10) Если значение поля 23B SPRI, SSTD или SPAY, то в поле 59a
        --                должно присутствовать подполе "Счет"
        --
        bars_audit.trace('%s: validate rule MT103-C12...', p);

        l_value23b := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'B');
        bars_audit.trace('%s: value for tag 23B is %s', p, l_value23b);

        if (l_value23b is not null and l_value23b in ('SPRI', 'SSTD', 'SPAY')) then
            if (substr(docmsg_document_getvalue(p_doc, MSG_MT103, '59', 'a'), 1, 1) != '/') then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E10');
            end if;
        end if;
        bars_audit.trace('%s: rule MT103-C12 validated.', p);


        --
        -- NVR-C13: (E18) Если поле 23E содержит код CHQB, то подполе "Счет" в поле 59a
        --                запрещено
        --
        bars_audit.trace('%s: validate rule MT103-C13...', p);

        l_value23e := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'E');
        bars_audit.trace('%s: value for tag 23E is %s', p, l_value23e);

        if (l_value23e is not null) then

            l_list23e := genmsg_document_getvaluelist(l_value23e);
            bars_audit.trace('%s: list of values created, count %s', p, to_char(l_list23e.count));

            -- Проходим по всем значениям
            for i in l_list23e.first..l_list23e.last
            loop
                if (l_list23e(i) = 'CHQB') then
                    if (substr(docmsg_document_getvalue(p_doc, MSG_MT103, '59', 'a'), 1, 1) = '/') then
                        bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E18');
                    end if;
                end if;
            end loop;
            bars_audit.trace('%s: list of values validated.', p);

            -- Очищаем список
            l_list23e.delete;

        end if;
        bars_audit.trace('%s: rule MT103-C13 validated.', p);


        --
        -- NVR-C14: (E12) Поля 70 и 77T взаимоисключающие
        --
        --
        bars_audit.trace('%s: validate rule MT103-C14...', p);

        if (docmsg_document_getvalue(p_doc, MSG_MT103, '70', '') is not null) then

            bars_audit.trace('%s: tag 70 present, looking for tag 77T...', p);
            if (docmsg_document_getvalue(p_doc, MsG_MT103,  '77', 'T') is not null) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E12');
            else
                bars_audit.trace('%s: tag 77T not present, continue', p);
            end if;

        end if;
        bars_audit.trace('%s: rule MT103-C14 validated.', p);


        --
        -- NVR-C15: Если поле 71A содержит OUR, то использование поля 71F запрещено,
        --          поле 71G опциональное (ошибка E13)
        --          Если поле 71A содержит SHA, то поле 71F опциональное, использование
        --          поля 71G запрещено (ошибка D50)
        --          Если поле 71A содержит BEN, то поле 71F обязательное, использование
        --          поля 71G запрещено (ошибка E15)
        --
        bars_audit.trace('%s: validate rule MT103-C15...', p);

        l_value71a := docmsg_document_getvalue(p_doc, MSG_MT103, '71', 'A');
        l_value71f := docmsg_document_getvalue(p_doc, MSG_MT103, '71', 'F');
        l_value71g := docmsg_document_getvalue(p_doc, MSG_MT103, '71', 'G');
        bars_audit.trace('%s: values for tag 71A is %s, tag 71F is %s, tag 71G is %s', p, l_value71a, l_value71f, l_value71g);

        if    (l_value71a = 'OUR') then

            if (l_value71f is not null) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E13');
            end if;

        elsif (l_value71a = 'SHA') then

            if (l_value71g is not null) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_D50');
            end if;

        elsif (l_value71a = 'BEN') then

            if (l_value71f is null or l_value71g is not null) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E15');
            end if;

        end if;
        bars_audit.trace('%s: rule MT103-C15 validated.', p);


        --
        -- NVR-C16: (D51) Если присутствует одно из полей 71F или 71G, то поле 33B
        --                обязательно к заполнению
        --
        bars_audit.trace('%s: validate rule MT103-C16...', p);

        l_value71f := docmsg_document_getvalue(p_doc, MSG_MT103, '71', 'F');
        l_value71g := docmsg_document_getvalue(p_doc, MSG_MT103, '71', 'G');
        bars_audit.trace('%s: values for tag 71F is %s, tag 71G is %s', p, l_value71f, l_value71g);

        if (l_value71f is not null or l_value71g is not null) then

            l_value33b := docmsg_document_getvalue(p_doc, MSG_MT103, '33', 'B');
            bars_audit.trace('%s: value for tag 33B is %s', p, l_value33b);

            if (l_value33b is null) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_D51');
            end if;

        end if;
        bars_audit.trace('%s: rule MT103-C16 validated.', p);


        --
        -- NVR-C17: (E44) Если поле 56a отсутствует, то в полях 23E не долно быть
        --                кодов TELI или PHOI
        --
        bars_audit.trace('%s: validate rule MT103-C17...', p);

        if (docmsg_document_getvalue(p_doc, MSG_MT103, '56', 'a') is null) then

            -- Получаем значение поля 23E
            l_value23e := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'E');
            bars_audit.trace('%s: value for tag 23E is %s', p, l_value23e);

            if (l_value23e is not null) then

                l_list23e := genmsg_document_getvaluelist(l_value23e);
                bars_audit.trace('%s: list of values created, count %s', p, to_char(l_list23e.count));

                -- Проходим по всем значениям
                for i in l_list23e.first..l_list23e.last
                loop
                    if (substr(l_list23e(i), 1, 4) in ('TELI', 'PHOI'))  then
                        bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E44');
                    end if;
                end loop;
                bars_audit.trace('%s: list of values validated.', p);

                -- Очищаем список
                l_list23e.delete;

            end if;
        end if;
        bars_audit.trace('%s: rule MT103-C17 validated.', p);


        --
        -- NVR-C18: (E45) Если поле 57a отсутствует, то в полях 23E не долно быть
        --                кодов TELE или PHON
        --
        bars_audit.trace('%s: validate rule MT103-C18...', p);

        if (docmsg_document_getvalue(p_doc, MSG_MT103, '57', 'a') is null) then

            -- Получаем значение поля 23E
            l_value23e := docmsg_document_getvalue(p_doc, MSG_MT103, '23', 'E');
            bars_audit.trace('%s: value for tag 23E is %s', p, l_value23e);

            if (l_value23e is not null) then

                l_list23e := genmsg_document_getvaluelist(l_value23e);
                bars_audit.trace('%s: list of values created, count %s', p, to_char(l_list23e.count));

                -- Проходим по всем значениям
                for i in l_list23e.first..l_list23e.last
                loop
                    if (substr(l_list23e(i), 1, 4) in ('TELE', 'PHON'))  then
                        bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_E45');
                    end if;
                end loop;
                bars_audit.trace('%s: list of values validated.', p);

                -- Очищаем список
                l_list23e.delete;

            end if;

        end if;
        bars_audit.trace('%s: rule MT103-C18 validated.', p);

        --
        -- NVR-C19: (C02) Код валюты в полях 71G и 32A должен совпадать
        --
        bars_audit.trace('%s: validate rule MT103-C19...', p);

        l_value71g := docmsg_document_getvalue(p_doc, MSG_MT103, '71', 'G');
        bars_audit.trace('%s: value for tag 71G is %s', p, l_value71g);

        if (l_value71g is not null) then

            -- Получаем значение для поля 32A
            l_value32a := docmsg_document_getvalue(p_doc, MSG_MT103, '32', 'A');
            bars_audit.trace('%s: value for tag 32A is %s', p, l_value32a);

            -- Сравниваем код валюты в полях 32A и 71G
            if (substr(l_value71g, 1, 3) != substr(l_value32a, 7, 3)) then
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_C02');
            end if;

        end if;
        bars_audit.trace('%s: rule MT103-C19 validated.', p);


        bars_audit.trace('%s: succ end', p);

    end docmsg_document_vldmsg103;


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VLDMSG202()
    --
    --     Процедура реализует специфичные для сообщения МТ202
    --     проверки документа
    --
    --
    --
    --
    procedure docmsg_document_vldmsg202(
                  p_doc     in      t_doc )
    is
    p          constant varchar2(100) := PKG_CODE || '.dmdocvldmsg202';
    begin
        bars_audit.trace('%s: entry point', p);

        --
        -- NVR-C1:(C81) Если есть поле 56a, то должно быть поле 57a
        --
        bars_audit.trace('%s: validate rule MT202-C1...', p);

        if (docmsg_document_getvalue(p_doc, MSG_MT202, '56', 'a') is not null) then

            bars_audit.trace('%s: tag 56a present, looking for tag 57a...', p);
            if (docmsg_document_getvalue(p_doc, MSG_MT202, '57', 'a') is null) then
                bars_audit.trace('%s: error detected - tag 57a not found', p);
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MSGCHK_C81');
            end if;
            bars_audit.trace('%s: tag 57a present, check MT202-C1 completed.', p);

        else
            bars_audit.trace('%s: tag 56a not present, skip check MT202-C1.', p);
        end if;
        bars_audit.trace('%s: rule MT202-C1 validated.', p);

        bars_audit.trace('%s: succ end', p);

    end docmsg_document_vldmsg202;



    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VALIDATE()
    --
    --     Процедура проверки корректности доп. реквизитов документа
    --     из которого будет формироваться сообщение SWIFT
    --
    --
    --
    --
    --
    procedure docmsg_document_validate(
                  p_doc    in     t_doc )
    is
    p       constant varchar2(100) := PKG_CODE || '.dmdocvld';
    --
    l_mt    t_swmt;   /* тип сообщения */

    --
    ERR     constant number := -20782;


    p_ref   number;  -- может не существовать, необходим другой подход


    -- l_mt    sw_mt.mt%type;        /* тип сообщения */
    -- l_opt   varchar2(1);          /* опция поля */
    -- l_value sw_operw.value%type;  /* значение поля */
    -- l_list  t_strlist;            /* список значений */

    l_docwtag    t_docwtag;       /*      Имя доп. реквизита */
    l_docwval    t_docwval;       /* Значение доп. реквизита */
    l_opt        t_swmsg_tagopt;  /*              Опция поля */


    begin
        bars_audit.trace('%s: entry poing par[0]=>%s', p, to_char(p_doc.docrec.ref));

        -- Получаем доп. реквизит - признак формирования сообщения
        if (not docmsg_checkmsgflag(p_doc)) then
             bars_audit.trace('%s: swift flag not set, document ref %s not validated.', p, to_char(p_doc.docrec.ref));
             return;
        end if;

        -- Получаем тип сообщения, которое нужно будет формировать
        l_mt := genmsg_document_getmt(p_doc);
        bars_audit.trace('%s: document message type is %s', p, to_char(l_mt));

        --
        -- Проверка документа:
        --
        --  Проверка реквизитов:
        --
        --    Этап 1. Проверка наличия обязательных полей и их формат
        --    Этап 2. Проверка значений в необязательных полях
        --    Этап 3. Специфичные проверки в зависимости от типа сообщения
        --

        bars_audit.trace('%s: document validation step 1...', p);

        -- Идем по метаописанию обязательных полей
        for c in (select *
                    from sw_model
                   where mt     = l_mt
                     and status = TAGSTATE_MANDATORY
                     and tag || opt != '20'           )
        loop
            bars_audit.trace('%s: processing tag=%s opt=%s...', p, c.tag, c.opt);

            -- Получаем значение
            l_docwval := docmsg_document_getvalue(p_doc, c, l_opt, l_docwtag);
            bars_audit.trace('%s: document property %s value is %s', p, l_docwtag, l_docwval);

            if (l_docwval is null) then
                bars_audit.trace('%s: error - mandatory document property %s is NULL', p);
                bars_error.raise_nerror(MODCODE, 'DOCMSG_MANDATORYFIELD_NOTFOUND', l_docwtag);
            end if;

            -- Выполняем проверку значения поля
            docmsg_validate_field(c.tag, l_opt, c.rpblk, l_docwval);
            bars_audit.trace('%s: value for tag %s%s succesfully validated.', p, c.tag, l_opt);
            bars_audit.trace('%s: tag=%s opt=%s processed.', p, c.tag, c.opt);

        end loop;
        bars_audit.trace('%s: document validation step 1 completed.', p);


        bars_audit.trace('document validation step 2...');
        -- Проходим по необязательным полям
        for c in (select *
                    from sw_model
                   where mt     = l_mt
                     and status = 'O' )
        loop
            bars_audit.trace('%s: processing tag=%s opt=%s...', p, c.tag, c.opt);

            -- Получаем значение
            l_docwval := docmsg_document_getvalue(p_doc, c, l_opt, l_docwtag);
            bars_audit.trace('%s: document property %s value is %s', l_docwtag, l_docwval);

            if (l_docwval is not null) then
                -- Выполняем проверку значения поля
                docmsg_validate_field(c.tag, l_opt, c.rpblk, l_docwval);
                bars_audit.trace('%s: value for tag %s%s succesfully validated.', p, c.tag, l_opt);
            end if;
            bars_audit.trace('%s: tag=%s opt=%s processed.', c.tag, c.opt);
        end loop;
        bars_audit.trace('%s: document validation step 2 completed.', p);

        bars_audit.trace('document validation step 3...');
        -- Для каждого типа сообщения будет своя процедура проверки
        if    (l_mt = 103) then docmsg_document_vldmsg103(p_doc);
        elsif (l_mt = 200) then bars_audit.trace('NVR not present for message type 200, skip this step.');
        elsif (l_mt = 202) then docmsg_document_vldmsg202(p_doc);
        else                    bars_audit.trace('NVR not implemented for message type ' || to_char(l_mt) || ', skip this step.');
        end if;
        bars_audit.trace('document validation step 3 complete.');
        bars_audit.trace('%s: succ end', p);

    end docmsg_document_validate;






    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VALIDATE()
    --
    --     Процедура проверки корректности доп. реквизитов документа
    --     из которого будет формироваться сообщение SWIFT
    --
    --
    --
    --
    --
    procedure docmsg_document_validate(
                  p_ref     in  oper.ref%type )
    is
    p       constant varchar2(100) := PKG_CODE || '.dmdocvld0';
    --
    l_doc   t_doc;
    --
/*
    ERR     constant number := -20782;
    l_mt    sw_mt.mt%type;
    l_opt   varchar2(1);
    l_value sw_operw.value%type;
    l_list  t_strlist;
*/
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_ref));

        -- Получаем структуру из документа
        select * into l_doc.docrec
          from oper where ref = p_ref;

        for c in (select trim(tag) tag, value
                    from operw where ref = p_ref )
        loop
            l_doc.doclistw(c.tag).value := c.value;
        end loop;

        -- Вызываем процедуру проверки
        docmsg_document_validate(l_doc);

/*

        -- Получаем доп. реквизит - признак формирования сообщения
        if (not docmsg_checkmsgflag(p_ref)) then
             bars_audit.trace('swift flag not set, document ref=%s not validated.', to_char(p_ref));
             return;
        end if;

        -- Получаем тип сообщения, которое нужно будет формировать
        l_mt := genmsg_document_getmt(
                    p_ref    =>      p_ref);

        bars_audit.trace('document message type is %s', to_char(l_mt));

        --
        -- Проверка документа:
        --
        --  Проверка заголовка:
        --
        --    Проверяем флаги заголовка
        --
        --  Проверка реквизитов:
        --
        --    Этап 1. Проверка наличия обязательных полей и их формат
        --    Этап 2. Проверка значений в необязательных полях
        --    Этап 3. Специфичные проверки в зависимости от типа сообщения
        --

        bars_audit.trace('document msg header validation...');

        -- Получаем флаги сообщения
        l_value := genmsg_document_getmsgflg(
                                   p_ref  => p_ref,
                                   p_tag  => 'SWAHF' );

        bars_audit.trace('application header flags (SWAHF) =>%s', l_value);

        if (l_value is not null) then
            bars_swift.genmsg_validate_apphdrflags(l_value, l_mt);
        end if;

        bars_audit.trace('document msg header validated.');


        bars_audit.trace('document validation step 1...');


        for i in (select *
                    from sw_model
                   where mt     = l_mt
                     and status = 'M'
                     and tag || opt not in ('20', '32A'))
        loop

            if (i.spec is not null and i.spec = 'Y') then

                l_value := genmsg_document_getvalue_ex(
                               p_model =>  i,
                               p_swref => null,
                               p_ref   => p_ref,
                               p_recno => null,
                               p_opt   => l_opt );

                if (i.opt != lower(i.opt) or i.opt is null) then
                    l_opt := trim(i.opt);
                end if;

            else

                if (i.opt != lower(i.opt) or i.opt is null) then

                    l_value := genmsg_document_getvalue(
                                   p_ref  => p_ref,
                                   p_tag  => i.tag || i.opt );

                    l_opt := trim(i.opt);

                else

                    -- Получаем представленную опцию
                    begin
                        select trim(substr(tag, 3, 1)) into l_opt
                          from operw w
                         where w.ref = p_ref
                           and trim(w.tag) in (select m.tag || decode(o.opt, '-', null, o.opt)
                                                 from sw_model m, sw_model_opt o
                                                where m.mt  = i.mt
                                                  and m.num = i.num
                                                  and m.mt  = o.mt
                                                  and m.num = o.num );

                    exception
                        when NO_DATA_FOUND then
                            raise_application_error(ERR, '\930 Нет обязательного поля ' || i.tag || 'a');
                        when TOO_MANY_ROWS then
                            raise_application_error(ERR, '\931 Дублируется поле ' || i.tag || 'a');
                    end;

                    -- Получаем значение
                    l_value := genmsg_document_getvalue(
                                   p_ref  => p_ref,
                                   p_tag  => i.tag || l_opt );

                end if;

            end if;

            bars_audit.trace('value for tag %s =>%s', i.tag || l_opt, l_value);

            if (l_value is null) then
                raise_application_error(ERR, '\930 Нет обязательного поля ' || i.tag || l_opt);
            end if;

            -- Проверяем значение поля
            docmsg_validate_field(i.tag, l_opt, i.rpblk, l_value);
            bars_audit.trace('field %s%s succesfully validated.', i.tag, l_opt);

        end loop;

        bars_audit.trace('document validation step 1 complete.');

        bars_audit.trace('document validation step 2...');

        for i in (select *
                    from sw_model
                   where mt     = l_mt
                     and status = 'O' )
        loop

            if (i.spec is not null and i.spec = 'Y') then

                l_value := genmsg_document_getvalue_ex(
                               p_model =>  i,
                               p_swref => null,
                               p_ref   => p_ref,
                               p_recno => null,
                               p_opt   => l_opt );

                if (i.opt != lower(i.opt) or i.opt is null) then
                    l_opt := trim(i.opt);
                end if;

            else

                if (i.opt != lower(i.opt) or i.opt is null) then

                    l_value := genmsg_document_getvalue(
                                   p_ref  => p_ref,
                                   p_tag  => i.tag || i.opt );

                    l_opt := trim(i.opt);

                else

                    -- Получаем представленную опцию
                    begin
                        select trim(substr(tag, 3, 1)) into l_opt
                          from operw w
                         where w.ref = p_ref
                           and trim(w.tag) in (select m.tag || decode(o.opt, '-', null, o.opt)
                                                 from sw_model m, sw_model_opt o
                                                where m.mt  = i.mt
                                                  and m.num = i.num
                                                  and m.mt  = o.mt
                                                  and m.num = o.num );

                    exception
                        when NO_DATA_FOUND then null;
                        when TOO_MANY_ROWS then
                            raise_application_error(ERR, '\931 Дублируется поле ' || i.tag || 'a');
                    end;

                    -- Получаем значение
                    l_value := genmsg_document_getvalue(
                                   p_ref  => p_ref,
                                   p_tag  => i.tag || l_opt );

                end if;

            end if;

            bars_audit.trace('value for tag %s =>%s', i.tag || l_opt, l_value);

            -- Проверяем значение поля
            if (l_value is not null) then
                docmsg_validate_field(i.tag, l_opt, i.rpblk, l_value);
            end if;
            bars_audit.trace('field %s%s succesfully validated.', i.tag, l_opt);

        end loop;

        bars_audit.trace('document validation step 2 complete.');



        bars_audit.trace('document validation step 3...');

        -- Для каждого типа сообщения будет своя процедура проверки
        if    (l_mt = 103) then
            docmsg_document_vldmsg103(p_ref=>p_ref);
        elsif (l_mt = 200) then
            bars_audit.trace('Network validation rules not present for message type 200, skip this step.');
        elsif (l_mt = 202) then
            docmsg_document_vldmsg202(p_ref=>p_ref);
        else
            bars_audit.trace('Network validation rules not implemented for message type ' || to_char(l_mt) || ', skip this step.');
        end if;

        bars_audit.trace('document validation step 3 complete.');

*/

        bars_audit.trace('%s: succ end', p);

    end docmsg_document_validate;



    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VLDTRANS()
    --
    --     Процедура проверки корректности доп. реквизитов документа
    --     после выполнения транслитерации полей
    --
    --
    --
    --
    --
    procedure docmsg_document_vldtrans(
                  p_ref     in  oper.ref%type )
    is

    type t_list_chrtab is table of sw_chrsets.setid%type;

    l_listChrTab  t_list_chrtab;       /*         список таблиц транслитерации */
    l_mt          sw_mt.mt%type;       /*                        тип сообщения */
    l_opt         varchar2(1);         /*                           опция поля */
    l_value       sw_operw.value%type; /*                        значение поля */
    l_transvalue  sw_operw.value%type; /*   значение поля после транслитерации */
    l_cnt         number;              /*                              счетчик */
    l_istrans     boolean;             /*          признак транслитерации поля */

    begin


        bars_audit.trace('validating translation document ref=%s...', to_char(p_ref));

        -- Получаем доп. реквизит - признак формирования сообщения
        if (not docmsg_checkmsgflag(p_ref)) then
             bars_audit.trace('swift flag not set, document ref=%s not validated.', to_char(p_ref));
             return;
        end if;

        -- Получаем тип сообщения, которое нужно будет формировать
        l_mt := genmsg_document_getmt(
                    p_ref    =>      p_ref);

        bars_audit.trace('document message type is %s', to_char(l_mt));

        --
        -- Если в документе есть доп.реквизит 20="+", то ничего не делаем
        --
        if (genmsg_document_getvalue(p_ref, '20') = '+') then
            bars_audit.trace('document is alredy translated, validation skipped...');
            return;
        end if;

        --
        -- Получаем список таблиц транслитерации
        --
        select setid  bulk collect into l_listChrTab
          from sw_chrsets;

        --
        -- Идем по всем полям, которые требуют транслитерации, транслитерируем по
        -- всем возможным таблицам и проверяем формат
        --
        for i in (select *
                    from sw_model
                   where mt = l_mt
                  order by num     )
        loop

            l_value   := null;
            l_istrans := false;

            --
            -- Если опция определена, то просто проверяем признак транслитерации
            --
            if (i.opt is not null and i.opt = lower(i.opt)) then

                select count(*) into l_cnt
                  from sw_model_opt
                 where mt    = l_mt
                   and num   = i.num
                   and trans = 'Y';

                if (l_cnt > 0) then
                    l_istrans := true;
                end if;

            else

                if (i.trans = 'Y') then
                    l_istrans := true;
                end if;

            end if;

            --
            -- Получаем значение доп. реквизита
            --

            if (l_istrans) then

                if (i.spec is not null and i.spec = 'Y') then

                    l_value := genmsg_document_getvalue_ex(
                                   p_model => i,
                                   p_swref => null,
                                   p_ref   => p_ref,
                                   p_recno => null,
                                   p_opt   => l_opt );

                    if (i.opt != lower(i.opt) or i.opt is null) then
                        l_opt := i.opt;
                    end if;

                elsif (i.opt = lower(i.opt)) then

                    begin

                        select substr(tag, 3, 1), value into l_opt, l_value
                          from operw
                         where ref = p_ref
                           and trim(tag) in (select tag || opt
                                               from sw_model_opt
                                              where mt  = l_mt
                                                and num = i.num );

                    exception
                        when NO_DATA_FOUND then null;
                    end;

                else

                    l_value := genmsg_document_getvalue(p_ref, i.tag || i.opt);
                    l_opt   := i.opt;

                end if;

                --
                -- Если опцию нужно было выбирать проверяем полученную опцию
                -- на предмет необходимости транслитерации
                --
                if (i.opt = lower(i.opt)) then

                    select count(*)  into l_cnt
                      from sw_model_opt
                     where mt    = l_mt
                       and num   = i.num
                       and opt   = decode(l_opt, null, '-', l_opt)
                       and trans = 'Y';

                    if (l_cnt = 0) then
                        l_value := null;
                    end if;

                end if;

            end if;


            if (l_value is not null) then

                bars_audit.trace('tag=%s opt=%s doc value=%s', i.tag, i.opt, l_value);

                for t in 1..l_listChrTab.count
                loop

                    l_transvalue := genmsg_translate_value(l_mt, i.tag, l_opt, l_value, l_listChrTab(t));
                    bars_audit.trace('tag=%s opt=%s trans=%s value=%s', i.tag, l_opt, l_listChrTab(t), l_transvalue);

                    bars_swift.validate_field(i.tag, l_opt, l_transvalue, 1, 0);
                    bars_audit.trace('tag=%s opt=%s trans=%s validation complete');

                end loop;

                bars_audit.trace('tag=%s opt=%s successfully validated.', i.tag, i.opt);

            end if;

        end loop;

    end docmsg_document_vldtrans;


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_TRANSLATE()
    --
    --     Процедура транслитерации доп. реквизитов документа
    --
    --     Параметры:
    --
    --         p_docref    Реф. документа
    --
    --
    procedure docmsg_document_translate(
                  p_docref    in     t_docref )
    is
    p       constant varchar2(100) := PKG_CODE || '.dmdoctransl';
    --
    l_mt          sw_mt.mt%type;       /*                        тип сообщения */
    l_kv          oper.kv%type;        /*                           Код валюты */
    l_value       operw.value%type;    /*   Значение доп. реквизита (транслит) */
    l_trans       boolean := false;
    l_transrur    sw_chrsets.setid%type;
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_docref));

        -- Проверяем наличие флага формирования сообщения по документу
        if (not docmsg_checkmsgflag(p_docref)) then
             bars_audit.trace('swift flag not set, document ref=%s not translated.', to_char(p_docref));
             return;
        end if;

        -- Получаем тип сообщения, которое нужно будет формировать
        l_mt := genmsg_document_getmt(p_ref => p_docref);
        bars_audit.trace('document message type is %s', to_char(l_mt));

        if (genmsg_document_getvalue(p_docref, '20') = '+') then l_transrur := 'RUR6';
        else l_transrur := 'TRANS';
        end if;

        -- Транслитерация только для рос. рублей
        select kv into l_kv from oper where ref = p_docref;
        bars_audit.trace('document kv is %s', to_char(l_kv));

        -- Все доп. реквизиты должны быть транслитерированы
        for c in (select w.tag dtag, substr(w.tag, 1, 2) tag, substr(trim(w.tag), 3, 1) opt, w.value
                    from operw w
                   where ref = p_docref
                     and w.value is not null
                     and exists (select 1
                                   from sw_model
                                  where mt            = l_mt
                                    and tag           = substr(w.tag, 1, 2)
                                    and nvl(decode(opt, 'a', substr(trim(w.tag), 3, 1), opt), '-') = nvl(substr(trim(w.tag), 3, 1), '-')
                                    and mtdtag is not null
                                    ) )
        loop
            bars_audit.trace('checking tag %s ...', c.dtag);

            if (l_kv not in (810, 643)) then
                if (c.value != bars_swift.strverify2(c.value, 'TRANS')) then
                    raise_application_error(-20782, '\932 Найдены недопустимые символы в поле ' || c.tag || c.opt);
                end if;
            else
                if (c.value != nvl(bars_swift.strverify2(c.value, l_transrur), '<null>')) then
                    bars_audit.trace('starting translation for tag %s...', c.dtag);
                    l_value := genmsg_translate_value(l_mt, c.tag, trim(c.opt), c.value, 'RUR6');
                    bars_audit.trace('tag %s after translation=>%s', c.dtag, l_value);
                    l_trans := true;
                    update operw set value = l_value where ref = p_docref and tag = c.dtag;
                    bars_audit.trace('document tag %s stored after translation', c.dtag);
                end if;
            end if;
            bars_audit.trace('tag %s check completed.', c.dtag);
        end loop;

        if (l_trans) then
            bars_audit.trace('some tags was translated, store tag 20');

            begin
                insert into operw(ref, tag, value) values (p_docref, '20', '+');
            exception
                when DUP_VAL_ON_INDEX then null;
            end;
        else
            bars_audit.trace('tags wasnt translated, dont store tag 20');
        end if;

    end docmsg_document_translate;












    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VLDLISTRST()
    --
    --     Процедура очистки списка документов для проверки
    --
    --
    --
    --
    procedure docmsg_document_vldlistrst
    is
    p       constant varchar2(100) := PKG_CODE || '.dmvldrst';
    begin
        bars_audit.trace('%s: entry point', p);
        g_vldlist.delete;
        bars_audit.trace('%s: succ end', p);
    end;


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VLDLISTADD()
    --
    --     Процедура добавления документа в список документов для
    --     проверки
    --
    --
    --
    procedure docmsg_document_vldlistadd(
                   p_docref     in   t_docref )
    is
    p       constant varchar2(100) := PKG_CODE || '.dmvldadd';
    --
    l_isfound    boolean := false;   /* признак наличия документа в списке */
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_docref));

        -- Проверяем наличие документа в списке
        for i in 1..g_vldlist.count
        loop
            if (g_vldlist(i) = p_docref) then l_isfound := true;
            end if;
        end loop;

        if (not l_isfound) then
            g_vldlist.extend;
            g_vldlist(g_vldlist.count) := p_docref;
            bars_audit.trace('%s: document %s added in list', p, to_char(p_docref));
        else
            bars_audit.trace('%s: document %s already in list', p, to_char(p_docref));
        end if;
        bars_audit.trace('%s: succ end', p);

    end docmsg_document_vldlistadd;


    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_VLDLISTPRC()
    --
    --     Процедура выполнения проверки над документами в списке
    --     документов для проверки
    --
    --
    --
    procedure docmsg_document_vldlistprc
    is
    p       constant varchar2(100) := PKG_CODE || '.dmvldprc';
    --
    l_cnt   number;   /* признак наличия документа */
    --
    begin
        bars_audit.trace('%s: entry point', p);

        -- Проходим по списку
        for i in 1..g_vldlist.count
        loop
            bars_audit.trace('%s: processing document %s...', p, to_char(g_vldlist(i)));

            -- Проверяем наличие документа
            select count(*) into l_cnt
              from oper
             where ref = g_vldlist(i);
            bars_audit.trace('%s: document exists status is %s', p, to_char(l_cnt));

            if (l_cnt = 0) then
                bars_audit.trace('%s: document %s does not exists - nothing to check', p, to_char(g_vldlist(i)));
            else
                docmsg_document_validate(g_vldlist(i));
                bars_audit.trace('%s: document %s tags validated.', p, to_char(g_vldlist(i)));

                -- В зависимости от параметра, либо выполняем проверку, либо транслитерируем
                if (get_param_value(MODPAR_MSGTRANSLATE) = MODVAL_MSGTRANSLATE_YES) then
                    docmsg_document_translate(g_vldlist(i));
                    bars_audit.trace('%s: document %s tags translated', p, to_char(g_vldlist(i)));
                else
                    docmsg_document_vldtrans(g_vldlist(i));
                    bars_audit.trace('%s: document %s tags translation validated', p, to_char(g_vldlist(i)));
                end if;
                bars_audit.trace('%s: document %s processed.', p, to_char(g_vldlist(i)));
            end if;

        end loop;
        bars_audit.trace('%s: succ end', p);

    end docmsg_document_vldlistprc;



    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_GET103COVHDR()
    --
    --     Получение отправителей/получателей МТ103 и МТ202
    --
    --     Параметры:
    --
    --         p_docref        Референс документа
    --
    --         p_senderbic     BIC-код отправителя
    --
    --         p_sendername    Наименование отправителя
    --
    --         p_rcv103bic     BIC-код получателя МТ103
    --
    --         p_rcv103name    Наименование получателя МТ103
    --
    --         p_rcv202bic     BIC-код получателя МТ202
    --
    --         p_rcv202name    Наименование получателя МТ202
    --
    --
    procedure docmsg_document_get103covhdr(
                  p_docref       in   oper.ref%type,
                  p_senderbic    out  varchar2,
                  p_sendername   out  varchar2,
                  p_rcv103bic    out  varchar2,
                  p_rcv103name   out  varchar2,
                  p_rcv202bic    out  varchar2,
                  p_rcv202name   out  varchar2      )
    is
    p       constant varchar2(100) := PKG_CODE || '.dmdocg103hdr';
    --
    l_fld57a   operw.value%type;
    l_pos      number;

    --
    -- TODO: Перенести функцию в пакет BARS_SWIFT
    --
    function get_bank_name(p_bic in varchar2) return varchar2
    is
    l_name   varchar2(254);
    begin
        select substr(name, 1, 254) into l_name
          from sw_banks
         where bic = p_bic;
        return l_name;
    exception
        when NO_DATA_FOUND then return null;
    end get_bank_name;
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_docref));

        -- Отправитель всегда мы
        p_senderbic  := bars_swift.get_ourbank_bic;
        p_sendername := get_bank_name(p_senderbic);

        -- Получатель МТ103 находится в поле 57А
        l_fld57a := genmsg_document_getvalue(p_docref, '57A');

        -- Убираем счет, если он есть в поле
        if (substr(l_fld57a, 1, 1) = '/') then
            l_pos := instr(l_fld57a, CRLF);
            l_fld57a := substr(l_fld57a, l_pos+2);
        end if;

        p_rcv103bic  := l_fld57a;
        p_rcv103name := get_bank_name(p_rcv103bic);

        -- Получатель МТ202 банк, корсчет которого подобрали
        select value into p_rcv202bic
          from operw
         where ref = p_docref
           and tag = 'NOS_B';

        p_rcv202name := get_bank_name(p_rcv202bic);
        bars_audit.trace('%s: succ end, rcv103=% rcv202=%', p, p_rcv103bic, p_rcv202bic);

    end docmsg_document_get103covhdr;



    -----------------------------------------------------------------
    -- DOCMSG_DOCUMENT_SET103COVHDR()
    --
    --     Установка получателей для сообщений МТ103 и МТ202
    --
    --     Параметры:
    --
    --         p_docref        Референс документа
    --
    --         p_rcv103bic     BIC-код получателя МТ103
    --
    --         p_rcv202bic     BIC-код получателя МТ202
    --
    --
    procedure docmsg_document_set103covhdr(
                  p_docref       in  oper.ref%type,
                  p_rcv103bic    in  varchar2,
                  p_rcv202bic    in  varchar2     )
    is
    p       constant varchar2(100) := PKG_CODE || '.dmdocset103hdr';
    --
    begin
        bars_audit.trace('%s: entry point: par[0]=>%s par[1]=>%s par[2]=>%s', p, to_char(p_docref), p_rcv103bic, p_rcv202bic);

        begin
            insert into operw(ref, tag, value)
            values (p_docref, 'SWRCV', p_rcv103bic);
        exception
            when DUP_VAL_ON_INDEX then
                update operw
                   set value = p_rcv103bic
                 where ref = p_docref
                   and tag = 'SWRCV';
        end;
        bars_audit.trace('%s: succ end', p);

    end docmsg_document_set103covhdr;

    -----------------------------------------------------------------
    -- GENMSG_MT199()
    --
    --     Генерация MT199 - статус свифт сообщения в GPI
    --
    --     Параметры:
    --
    --         p_swref        Референс родительской свифтовки
    --
    --         p_statusid     Ид статуса из справочника SW_STATUSES
    --
 
--    procedure genmsg_mt199(p_swref    in sw_journal.swref%type,
--                           p_statusid in number)
--    is
--       cursor cursModel(p_mt in number)
--        is
--        select *
--          from sw_model
--         where mt = p_mt;
--      l_sw_journal sw_journal%rowtype;
--      l_swref_new sw_journal.swref%type;
--      l_ret number;
--      l_mt          sw_mt.mt%type  := 199;     /*           Тип сообщения */
--      l_recModel    sw_model%rowtype;          /*               Строка модели сообщния */
--      l_cnt         number;                    /*                       просто счетчик */
--      l_useTrans    boolean;                   /*     Флаг использования перекодировки */
--      l_transTable  sw_chrsets.setid%type;     /*            Код таблицы перекодировки */
--      l_20fld       sw_operw.value%type;
--      l_value       sw_operw.value%type;       /*                        Значение тега */
--      l_recno       sw_operw.n%type;           /*              Порядковый номер записи */
--      l_opt         sw_operw.opt%type;         /*                    Опция тега записи */
--      l_pos         number;                    /*                              позиция */
--      l_currCode    tabval.kv%type;            /*                 Код валюты документа */
--      l_status      sw_statuses.value%type;
--    begin
--        --
--        -- Проверяем есть ли метаописание
--        --
--        select count(*) into l_cnt
--          from sw_model
--         where mt = l_mt;
--
--        if (l_cnt = 0) then
--            bars_audit.trace('Error! message description not found');
--            raise_application_error(-20781, '\998 Нет метаописания сообщения MT199');
--        end if;
--
--        bars_audit.trace('message MT199 description found.');
--            
--        select s.* into l_sw_journal from sw_journal s where s.swref=p_swref;
--            
--        begin
--        select t.value into l_20fld from sw_operw t where t.swref=p_swref and t.tag='20';
--        exception when no_data_found then 
--        raise_application_error(-20782, 'Нет поля 20 для SwRef='||to_char(p_swref));
--        end;
--            
--        begin
--            select value into l_status from sw_statuses where id = p_statusid;
--        exception when no_data_found then 
--        raise_application_error(-20782, 'Не найден статус'||to_char(p_statusid));    
--        end;
--            
--        begin
--        select kv into l_currCode from tabval where lcv = l_sw_journal.currency;
--        exception when no_data_found then 
--        raise_application_error(-20782, 'Не найдена валюта '||l_sw_journal.currency);
--        end;
--           --
--           -- Нормальный метод определения перекодировки - по банку
--           -- получателю сообщения определяем таблицу перекодировки
--           --
--         l_transTable := 'TRANS';
--         l_useTrans   := true;
--            
--
--            BARS_SWIFT.In_SwJournalInt(ret_      => l_ret,
--                        swref_    => l_swref_new,
--                        mt_       => '199',
--                        mid_      => null,
--                        page_     => null,
--                        io_       => 'I',
--                        sender_   => l_sw_journal.receiver,
--                        receiver_ => 'TRCKCHZZXXX',
--                        transit_  => l_sw_journal.transit,
--                        payer_    => null,
--                        payee_    => l_sw_journal.payee,
--                        ccy_      => l_sw_journal.currency,
--                        amount_   => l_sw_journal.amount,
--                        accd_     => l_sw_journal.accd,
--                        acck_     => null,
--                        vdat_     => null,
--                        idat_     => to_char(sysdate,  'YYYY-MM-DD HH24:MI'),
--                        flag_     => 'L',
--                        sti_      => '001',
--                        uetr_     => l_sw_journal.uetr 
--                        );
--          update sw_journal set date_pay = sysdate, date_out = null where swref=l_swref_new;
--              
--          bars_audit.trace('message MT199 header created SwRef=> %s', to_char(l_swref_new));
--              
--          --------------------------------------------------------------
--          bars_audit.trace('write message MT199 details ...');
--
--        -- Открываем модель сообщения
--        open cursModel(l_mt);
--        l_recno := 1;
--
--        loop
--            fetch cursModel into l_recModel;
--            exit when cursModel%notfound;
--
--
--            --
--            -- Отдельно формируем поля
--            --
--            if    (l_recModel.tag = '20') then
--
--                l_opt   := '';
--                l_value := l_20fld||'A';
--                genmsg_document_instag(l_recModel, l_swref_new, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
--            --
--            elsif (l_recModel.tag = '21') then
--                
--                l_opt   := '';
--                l_value := l_20fld;
--                genmsg_document_instag(l_recModel, l_swref_new, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
--                    
--            elsif (l_recModel.tag = '79') then
--                    
--                l_opt   := '';
--                    
--                l_value:='//'||to_char(sysdate,'YYMMDDHH24MI')||replace(sessiontimezone,':','')||CRLF
--                ||'//'||l_status||CRLF
--                ||'//'||l_sw_journal.sender||'/'||l_sw_journal.receiver||CRLF
--                ||'//'||bars_swift.AmountToSwift(l_sw_journal.amount, l_currCode, true, true);
--                    
--                 genmsg_document_instag(l_recModel, l_swref_new, null, l_recno, l_opt, l_value, true, l_useTrans, l_transTable);
--
--            end if;
--
--        end loop;
--
--        close cursModel;
--
--        bars_audit.trace('message MT199 generated swref=%s.', to_char(l_swref_new));
--        bars_audit.info('Сформировано сообщение SwRef=' || to_char(l_swref_new));
--          --------------------------------------------------------------
--              
--    end genmsg_mt199;
--        
--        
--        procedure job_send_mt199
--        is
--        begin
--        bc.go(300465);
--        for c in(select s.swref, o.ref, o.sos from sw_oper_queue s, oper o
--                    where s.ref=o.ref
--                    and o.pdat>=sysdate-5
--                    and o.sos in(5,-1,-2)
--                    and nvl(s.send_mt199,0)!=1)
--            loop
--                bars_swift_msg.genmsg_mt199(c.swref,case c.sos when 5 then 1 else 2 end);
--                update sw_oper_queue set send_mt199=1 where swref=c.swref;
--            end loop;
--        bc.home();    
--        end job_send_mt199;






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
        return 'package header BARS_SWIFT_MSG ' || VERSION_HEADER || chr(10) ||
               'package header definition(s):' || chr(10) || VERSION_HEADER_DEFS;
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
        return 'package body BARS_SWIFT_MSG ' || VERSION_BODY || chr(10) ||
               'package body definition(s):' || chr(10) || VERSION_BODY_DEFS;
    end body_version;


begin
    bars_audit.trace('%s: package init entry point', PKG_CODE);

    -- Инициализируем список
    g_vldlist := t_reflist();
    bars_audit.trace('%s: package init succ end', PKG_CODE);

end bars_swift_msg;
/