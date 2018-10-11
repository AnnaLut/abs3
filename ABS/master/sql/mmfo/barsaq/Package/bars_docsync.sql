
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/bars_docsync.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSAQ.BARS_DOCSYNC is

  -- Copyryight : UNITY-BARS
  -- Author     : SERG
  -- Created    : 26.09.2007
  -- Purpose    : Пакет процедур для импорта документов

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.07 08/06/2018';
  
  -- Тип оплаты документа (с последующей цепочкой ручного визирования, или автоматическая через вертушку)
  G_PAYTYPE_AUTO   constant smallint  := 0;
  G_PAYTYPE_MANUAL constant smallint  := 1; 
  G_ERRMOD         constant varchar2(3)  := 'DOC'; 
  G_TRACE          constant varchar2(50)  := 'bars_docsync.';
  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  ----
  -- import_documents - выполняет синхронный импорт документов
  --
  procedure import_documents;

  ----
  -- verify_document - верифицирует документ
  -- @p_ext_ref - внешний референс документа
  --
  procedure verify_document(p_ext_ref in varchar2);

  ----
  -- confirm_document - подтверждает оплату документа
  -- @p_ext_ref - внешний референс документа
  --
  procedure confirm_document(p_ext_ref in varchar2);

  ----
  -- mark_document_to_remove - помечает документ к удалению
  -- @p_ext_ref - внешний референс документа
  -- @p_removal_date - дата после которой документ необходимо удалить
  procedure mark_document_to_remove(p_ext_ref in varchar2, p_removal_date in date default sysdate);

  ----
  -- is_bankdate_open - возвращает true/false - флаг открытого банковского дня
  --
  function is_bankdate_open return boolean;

  
  -----------------------------------
  -- PAY_DOCUMENT
  --
  -- Оплачивает один документ
  --
  procedure pay_document(p_ext_ref number, p_ref number);
  
  ----
  -- async_pay_documents - процедура асинхронной оплаты документов
  --
  procedure async_pay_documents;

  ----
  -- reset_booking_info - сбрасывает информацию об оплате документа
  -- @p_ext_ref - внешний референс документа
  --
  procedure reset_booking_info(p_ext_ref in varchar2);

  ----
  -- async_remove_documents - удаляет помеченные к удалению документы с наступившей датой удаления
  --
  procedure async_remove_documents;

  ----
  -- extract_app_error - возвращает код прикладной ошибки
  --
  function extract_app_error(p_err_msg in varchar2) return integer;

  -----------------------------------
  -- GET_DOC_BUFFER
  --
  -- Получить буффера для подписи
  --
   
   procedure get_doc_buffer ( p_ref     in integer,
                              p_key     in varchar2,
                              p_int_buf out varchar2,
                              p_sep_buf out varchar2);
  ------------------------------------
  -- ASYNC_AUTO_PAY 
  --
  -- Процедура для автообработки докумнетов корп2 вертушкой
  -- Формирование документа и его оплата
  --
  procedure async_auto_pay (p_ext_ref number, p_ref out number);


  ------------------------------------
  -- ASYNC_AUTO_VISA 
  -- 
  -- Процедура для автообработки докумнетов корп2 вертушкой
  -- Установка виз с подписями, оплата по-факту
  --
  procedure async_auto_visa (p_ref      in number,
                             p_ext_ref  in number,
                             p_key      in varchar2,
                             p_int_sign in varchar2,
                             p_sep_sign in varchar2);
    
  ------------------------------------
  --  POST_ERROR_PROC 
  --
  --  Набор операций для выполнения после неуспешной обработки докумнета 
  --
  procedure post_error_proc(p_ext_ref number, p_sqlerr_code number, p_sqlerr_stack varchar2);

  ------------------------------------
  -- GET_BIS_COUNT 
  -- 
  -- Проверить наличие бис строк
  --
  function get_bis_count(p_ref      in number) return number;
  

end bars_docsync;
/
show err

CREATE OR REPLACE PACKAGE BODY BARSAQ.BARS_DOCSYNC is

  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 1.6 12/08/2018';

  G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := 'KF - схема с полем kf';



  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header '||G_HEADER_VERSION;
  end header_version;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body '||G_BODY_VERSION||'awk: '||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||G_AWK_BODY_DEFS;
  end body_version;

  ----
  -- is_bankdate_open - возвращает true/false - флаг открытого банковского дня
  --
  function is_bankdate_open return boolean is
    l_is_open     integer;
  begin
    select to_number(val) into l_is_open from bars.params where par='RRPDAY';
    if l_is_open=1 then
        return true;
    else
        return false;
    end if;
  end is_bankdate_open;

  ------------------------------------
  --  READ_CORP_DOC
  --
  --  Получить строку документа из doc_import
  --
  function read_corp_doc(p_ext_ref number) return doc_import%rowtype
  is
     l_doc doc_import%rowtype;
  begin
     select * into l_doc from doc_import where ext_ref = to_char(p_ext_ref);
     return l_doc;
  exception when no_data_found then
     raise_application_error(-20000, 'Документ не найден  EXT_REF='||p_ext_ref, TRUE);
  end;

  ------------------------------------
  --  READ_BARS_DOC
  --
  --  Получить строку документа из oper
  --
  function read_bars_doc(p_ref number, p_silent number default 1) return bars.oper%rowtype
  is
     l_doc bars.oper%rowtype;
  begin
     select * into l_doc from bars.oper where ref = p_ref;
     return l_doc;
  exception when no_data_found then
     if p_silent = 1 then 
        return null;  
     else 
       raise_application_error(-20000, 'Документ не найден REF='||p_ref, TRUE);
     end if;
  end;


  ----
  -- reset_bankdate - переустановка банковской даты
  --
  procedure reset_bankdate is
  begin
    bars.gl.pl_dat(bars.bankdate_g);
  end reset_bankdate;

  ----
  -- import_documents - выполняет импорт документов
  --
  procedure import_documents is
    l_errmod        bars.err_codes.errmod_code%type;
    l_tt            bars.tts%rowtype;
    l_ref           bars.oper.ref%type;
    l_bankdate      date;
    l_vdat          date;
    l_d_rec         bars.oper.d_rec%type;
    l_tag_info      bars.op_field%rowtype;
    l_chkr          bars.op_field.chkr%type;
    l_result        number;
    l_sos           bars.oper.sos%type;
    l_needless      number;
    l_sq            integer;
  begin
    bars.bars_audit.trace('bars_docsync.import_documents() start');
    -- проверка и сброс банковской даты
    reset_bankdate;
    l_errmod := 'DOC';
    l_bankdate := bars.gl.bDATE;
    -- цикл по документам
    for d in (select * from tmp_doc_import where ref is null for update skip locked order by ext_ref) loop
        savepoint sp_before_pay;
        begin
            -- устанавливаем язык, на котором должно быть сообщение об ошибке
            bars.bars_error.set_lang(d.err_lang, bars.bars_error.SCOPE_SESSION);
            -- проверка: операция d.tt существует ?
            begin
                select * into l_tt from bars.tts where tt=d.tt;
            exception when no_data_found then
                bars.bars_error.raise_nerror(l_errmod, 'TRANSACTION_DOES_NOT_EXIST', d.tt);
            end;
            -- проверка: пользователю разрешена операция d.tt ?
            begin
                select t.* into l_tt from bars.tts t, bars.staff_tts s
                where t.tt=d.tt and t.tt=s.tt and t.fli<3 and substr(flags,1,1)='1'
                      and s.id in (select bars.user_id from dual
                                   union all
                                   select id_whom from bars.staff_substitute where id_who=bars.user_id
                                   and bars.date_is_valid(date_start, date_finish, null, null)=1
                                  )
                      and rownum=1;
            exception when no_data_found then
                bars.bars_error.raise_nerror(l_errmod, 'TRANSACTION_NOT_ALLOWED', d.tt);
            end;
            -- проверка: платить сразу по-факту в СЭП нельзя
            if l_tt.fli=1 and substr(l_tt.flags,38,1)='1' then
                bars.bars_error.raise_nerror(l_errmod, 'SEP_TRANS_VISA_REQ', d.tt);
            end if;
            -- порождаем документ
            l_vdat := nvl(d.vdat, l_bankdate);
            l_sq := case
                    when d.kv=bars.gl.baseval then null
                    else bars.gl.p_icurval(d.kv, d.s, l_vdat)
                    end;
            bars.gl.ref(l_ref);
            bars.gl.in_doc2(
                ref_    => l_ref,
                tt_     => d.tt,
                vob_    => d.vob,
                nd_     => d.nd,
                pdat_   => sysdate,
                vdat_   => l_vdat,
                dk_     => d.dk,
                kv_     => d.kv,
                s_      => d.s,
                kv2_    => nvl(d.kv2,d.kv),
                s2_     => nvl(d.s2,d.s),
                sq_     => l_sq,
                sk_     => d.sk,
                --data_   => least(nvl(d.datd,trunc(sysdate)),l_bankdate),
                --datp_   => least(nvl(d.datp,trunc(sysdate)),l_bankdate),
                data_   => trunc(nvl(d.datd,sysdate)),
                datp_   => trunc(nvl(d.datp,sysdate)),
                nam_a_  => d.nam_a,
                nlsa_   => d.nls_a,
                mfoa_   => d.mfo_a,
                nam_b_  => d.nam_b,
                nlsb_   => d.nls_b,
                mfob_   => d.mfo_b,
                nazn_   => d.nazn,
                d_rec_  => null,
                id_a_   => d.id_a,
                id_b_   => d.id_b,
                id_o_   => d.id_o,
                sign_   => d.sign,
                sos_    => 0,
                prty_   => 0,
                uid_    => d.userid
            );
            -- сохраняем ext_ref как доп-реквизит
            insert into bars.operw(ref,tag,value) values(l_ref,'EXREF',to_char(d.ext_ref));
            -- сохраняем переданные доп. реквизиты
            for r in (select * from tmp_doc_import_props where ext_ref=d.ext_ref) loop
                begin
                    select * into l_tag_info from bars.op_field where tag=r.tag;
                exception when no_data_found then
                    bars.bars_error.raise_nerror(l_errmod, 'TAG_NOT_FOUND', r.tag);
                end;
                if l_tag_info.chkr is not null then
                    -- проверка доп. реквизита на корректность
                    l_result := bars.bars_alien_privs.check_op_field(
                        r.tag, r.value,
                        d.s, d.s2, d.kv, d.kv2, d.nls_a, d.nls_b, d.mfo_a, d.mfo_b, d.tt
                    );
                    if l_result=0 then
                        bars.bars_error.raise_nerror(l_errmod, 'TAG_INVALID_VALUE', r.tag);
                    end if;
                end if;
                insert into bars.operw(ref,tag,value) values(l_ref,r.tag,r.value);
            end loop;
            -- формируем доп. реквизиты в СЭП
            if l_tt.fli=1 then
                l_d_rec := '';
                for s in (select w.tag, w.value, f.vspo_char from bars.operw w, bars.op_field f
                            where w.ref=l_ref and w.tag=f.tag
                            and f.vspo_char is not null and f.vspo_char not in ('f','F','C','П')
                          )
                loop
                    l_d_rec := l_d_rec || '#'||s.vspo_char||s.value;
                end loop;
                if l_d_rec is not null and length(l_d_rec)>0 then
                    l_d_rec := l_d_rec || '#';
                end if;
                update bars.oper set d_rec=l_d_rec where ref=l_ref;
            end if;
            -- контроль: наличие обязательных доп. реквизитов
            for c in (select * from bars.op_rules where tt=d.tt and opt='M') loop
                begin
                    select ref into l_needless from bars.operw where ref=l_ref and tag=c.tag;
                exception when no_data_found then
                    bars.bars_error.raise_nerror(l_errmod, 'MANDATORY_TAG_ABSENT', c.tag, d.tt);
                end;
            end loop;
            -- оплата
            bars.gl.dyntt2 (
                  l_sos, to_number(substr(l_tt.flags,38,1)), 1,
                  l_ref, d.vdat, null, d.tt, d.dk,
                  d.kv,  d.mfo_a, d.nls_a, d.s,
                  d.kv2, d.mfo_b, d.nls_b, d.s2, l_sq, null);
            --
            -- в конце проставляем референс документа, как признак успешной оплаты
            update tmp_doc_import set ref=l_ref where ext_ref=d.ext_ref;
            -- дозаполняем справочник для свифтовок для возможности печати из АБС
            if d.tt in ('IBB','IBO','IBS') then
                update bars.sw_template set ref=l_ref, user_id=d.userid where doc_id=d.ext_ref;
            end if;
            bars.bars_audit.info('Оплачен документ. REF='||l_ref||', EXT_REF='||d.ext_ref);
        exception when others then
            rollback to sp_before_pay;
            -- удаляем информацию о свифтовке
            if d.tt in ('IBB','IBO','IBS') then
                delete from bars.sw_template where doc_id=d.ext_ref;
            end if;
            bars.bars_audit.error('DOCSYNC: '||substr(SQLERRM, 1, 3900));
            -- сохраняем информацию об ошибке
            declare
                l_sqlerrm       varchar2(4000);
                l_errumsg       varchar2(4000);
                l_erracode      varchar2(9);
                l_erramsg       varchar2(4000);
                l_errahlp       varchar2(4000);
                l_modcode       varchar2(3);
                l_modname       varchar2(100);
                l_errmsg        varchar2(4000);
                l_slash_pos     number;
                l_sharp_pos     number;
                l_subcode_str   varchar2(40);
                l_subcode       number;
                i               number;
                l_param         varchar2(4000);
                l_db_sqlcode    number;
                l_db_sqlerrm    varchar2(4000);
                l_src_sqlcode   number;
                l_src_sqlerrm   varchar2(4000);
            begin
              l_src_sqlcode := SQLCODE;
              l_src_sqlerrm := substr(SQLERRM, 1, 4000);
              l_sqlerrm := substr(SQLERRM, 1, 4000);
              l_sqlerrm := substr(l_sqlerrm, 1, instr(l_sqlerrm, chr(10))-1);
              -- ищем символ '\' (ascci('\') = 92)
              l_slash_pos := instr(l_sqlerrm, chr(92));
			  
              if l_slash_pos>0 then
                -- вычленяем код ошибки
                l_subcode_str := ''; i := 1;
                while substr(l_sqlerrm, l_slash_pos+i, 1) in ('0','1','2','3','4','5','6','7','8','9') loop
                  l_subcode_str := l_subcode_str || substr(l_sqlerrm, l_slash_pos+i, 1);
                  i := i + 1;
                end loop;
                l_subcode := to_number(l_subcode_str);
                -- вычленяем параметр после решетки #
                l_param := '';
                l_sharp_pos := instr(l_sqlerrm, '#');
                if l_sharp_pos>0 then
                    l_param := substr(l_sqlerrm, l_sharp_pos+1);
                end if;
                bars.bars_error.raise_error('BRS', l_subcode, l_param);
              else
                raise;
              end if;
            exception when others then
              l_sqlerrm := substr(SQLERRM, 1, 4000);
              i := instr(l_sqlerrm, chr(10));
              if i>0 then
                l_sqlerrm := substr(l_sqlerrm, 1, i-1);
              end if;
              l_db_sqlcode := SQLCODE;
              l_db_sqlerrm := substr(SQLERRM, 1, 4000);
              bars.bars_error.get_error_info(
                p_errtxt    => l_sqlerrm,
                p_errumsg   => l_errumsg,
                p_erracode  => l_erracode,
                p_erramsg   => l_erramsg,
                p_errahlp   => l_errahlp,
                p_modcode   => l_modcode,
                p_modname   => l_modname,
                p_errmsg    => l_errmsg
              );
              if l_erracode='BRS-99801' then
                l_db_sqlcode := l_src_sqlcode;
                l_db_sqlerrm := l_src_sqlerrm;
              end if;
              update tmp_doc_import set
                err_usr_msg  = l_errumsg,
                err_app_code = l_erracode,
                err_app_msg  = l_erramsg,
                err_app_act  = l_errahlp,
                err_db_code  = l_db_sqlcode,
                err_db_msg   = l_db_sqlerrm
              where ext_ref=d.ext_ref;
            end;
        end;
    end loop;
    bars.bars_audit.trace('bars_docsync.import_documents() finish');
  end import_documents;

  ----
  -- verify_document - верифицирует документ
  -- @p_ext_ref - внешний референс документа
  --
  procedure verify_document(p_ext_ref in varchar2) is
  begin
    update doc_import set verification_flag='Y', verification_date=sysdate
    where ext_ref=p_ext_ref and verification_flag is null or verification_flag='N';
    if sql%rowcount=0 then
        raise_application_error(-20000, 'Документ не найден или документ EXT_REF='
                                        ||p_ext_ref||' верифицировался раньше.', TRUE);
    end if;
    bars.bars_audit.info('Верификация документа EXT_REF='||p_ext_ref||' успешно проведена.');
  end verify_document;

  ----
  -- confirm_document - подтверждает оплату документа
  -- @p_ext_ref - внешний референс документа
  --
  procedure confirm_document(p_ext_ref in varchar2) is
  begin
    update doc_import set confirmation_flag='Y', confirmation_date=sysdate
    where ext_ref=p_ext_ref and confirmation_flag is null;
    if sql%rowcount=0 then
        raise_application_error(-20000, 'Документ не найден или подтверждение оплаты документа EXT_REF='
                                        ||p_ext_ref||' выполнялось раньше.', TRUE);
    end if;
    bars.bars_audit.info('Подтверждение оплаты документа EXT_REF='||p_ext_ref||' успешно проведено.');
  end confirm_document;

  ----
  -- mark_document_to_remove - помечает документ к удалению
  -- @p_ext_ref - внешний референс документа
  -- @p_removal_date - дата после которой документ необходимо удалить
  procedure mark_document_to_remove(p_ext_ref in varchar2, p_removal_date in date default sysdate) is
  begin
    update doc_import set removal_flag='Y', removal_date=p_removal_date
    where ext_ref=p_ext_ref and removal_flag is null;
    if sql%rowcount=0 then
        raise_application_error(-20000, 'Документ не найден или пометка к удалению документа EXT_REF='
                                        ||p_ext_ref||' устанавливалась раньше.', TRUE);
    end if;
    bars.bars_audit.info('Пометка к удалению документа EXT_REF='||p_ext_ref||' успешно установлена.');
  end mark_document_to_remove;

  ----
  -- extract_app_error - возвращает код прикладной ошибки
  --
  function extract_app_error(p_err_msg in varchar2) return integer is
    l_str   varchar2(40) := '';
    i       integer;
  begin
    if substr(p_err_msg, 12, 1)='\' then
        l_str := ''; i := 1;
        while substr(p_err_msg, 12+i, 1) in ('0','1','2','3','4','5','6','7','8','9') loop
            l_str := l_str || substr(p_err_msg, 12+i, 1);
            i := i + 1;
        end loop;
        return to_number(l_str);
    else
        return null;
    end if;
  end extract_app_error;

  ----
  -- lock_document4pay - блокирует документ для оплаты
  --
  function lock_document4pay(p_extref in doc_import.ext_ref%type) return boolean is
    l_confirmation_flag      doc_import.confirmation_flag%type;
    l_booking_flag           doc_import.booking_flag%type;
    l_removal_flag           doc_import.removal_flag%type;
    l_doc_locked  exception;
    pragma        exception_init(l_doc_locked, -54);
  begin
    savepoint sp;

    select confirmation_flag, booking_flag, removal_flag
    into l_confirmation_flag, l_booking_flag, l_removal_flag
    from doc_import where ext_ref=p_extref for update nowait;

    if l_confirmation_flag='Y' and l_booking_flag is null and l_removal_flag is null then
        return true;
    else
        rollback to sp;
        bars.bars_audit.error('Документ ext_ref='||p_extref||' не может быть заблокирован, т.к. '
        ||'confirmation_flag='||nvl(l_confirmation_flag,'null')
        ||', booking_flag='||nvl(l_booking_flag,'null')
        ||', removal_flag='||nvl(l_removal_flag,'null'));
        return false;
    end if;
  exception when l_doc_locked then
    rollback to sp;
    bars.bars_audit.error('Документ ext_ref='||p_extref||' заблокирован другим пользователем');
    return false;
  end lock_document4pay;


  -----------------------------------
  -- POST_DOCUMENT
  --
  -- вставить документ
  --
  procedure post_document (p_ext_ref number, p_ref out number) is
    d               doc_import%rowtype;
    l_errmod        bars.err_codes.errmod_code%type;
    l_tt            bars.tts%rowtype;
    l_ref           bars.oper.ref%type;
    l_bankdate      date;
    l_vdat          date;
    l_d_rec         bars.oper.d_rec%type;
    l_tag_info      bars.op_field%rowtype;
    l_chkr          bars.op_field.chkr%type;
    l_result        number;
    l_needless      number;
    l_sq            integer;
    l_bis           integer;
  begin

    bars.bars_audit.info('bars_docsync.post_document: начало вставки документа. EXT_REF='||p_ext_ref);

    d := read_corp_doc(p_ext_ref);

    -- если банковский день закрыт, выходим из процедуры
    if not is_bankdate_open() then
        bars.bars_audit.trace('Банковский день закрыт, оплата невозможна');
        return;
    end if;
    -- проверка и сброс банковской даты
    reset_bankdate;
    l_errmod := 'DOC';
    l_bankdate := bars.gl.bDATE;
    -- проверка: операция d.tt существует ?
    begin
        select * into l_tt from bars.tts where tt=d.tt;
    exception when no_data_found then
        bars.bars_error.raise_nerror(l_errmod, 'TRANSACTION_DOES_NOT_EXIST', d.tt);
    end;

    -- проверка: платить сразу по-факту в СЭП нельзя
    if l_tt.fli=1 and substr(l_tt.flags,38,1)='1' then
        bars.bars_error.raise_nerror(l_errmod, 'SEP_TRANS_VISA_REQ', d.tt);
    end if;
    -- порождаем документ
    l_vdat := nvl(d.vdat, l_bankdate);
    l_sq := case
            when d.kv=bars.gl.baseval then null
            else bars.gl.p_icurval(d.kv, d.s, l_vdat)
            end;

    bars.gl.ref(l_ref);

    bars.bars_audit.trace('bars_docsync.post_document: получен реф документа: '||l_ref);

    bars.gl.in_doc2(
        ref_    => l_ref,
        tt_     => d.tt,
        vob_    => d.vob,
        nd_     => d.nd,
        pdat_   => sysdate,
        vdat_   => l_vdat,
        dk_     => d.dk,
        kv_     => d.kv,
        s_      => d.s,
        kv2_    => nvl(d.kv2,d.kv),
        s2_     => nvl(d.s2,d.s),
        sq_     => l_sq,
        sk_     => d.sk,
        --data_   => least(nvl(d.datd,trunc(sysdate)),l_bankdate),
        --datp_   => least(nvl(d.datp,trunc(sysdate)),l_bankdate),
        data_   => trunc(nvl(d.datd,sysdate)),
        datp_   => trunc(nvl(d.datp,sysdate)),
        nam_a_  => d.nam_a,
        nlsa_   => d.nls_a,
        mfoa_   => d.mfo_a,
        nam_b_  => d.nam_b,
        nlsb_   => d.nls_b,
        mfob_   => d.mfo_b,
        nazn_   => d.nazn,
        d_rec_  => null,
        id_a_   => d.id_a,
        id_b_   => d.id_b,
        id_o_   => null,
        sign_   => null,
        sos_    => 0,
        prty_   => nvl(d.prty,0),
        uid_    => d.userid
    );

    bars.bars_audit.trace('bars_docsync.post_document: документ записан в базу c реф ='||l_ref);

    -- сохраняем ext_ref как доп-реквизит
    insert into bars.operw(ref,tag,value) values(l_ref,'EXREF',to_char(d.ext_ref));

    bars.bars_audit.trace('bars_docsync.post_document: старт формирования доп. реквизитов');

    -- сохраняем переданные доп. реквизиты
    for r in (select * from doc_import_props where ext_ref = d.ext_ref) loop
        begin
            select * into l_tag_info from bars.op_field where tag=r.tag;
        exception when no_data_found then
            bars.bars_error.raise_nerror(l_errmod, 'TAG_NOT_FOUND', r.tag);
        end;
        if l_tag_info.chkr is not null then
            -- проверка доп. реквизита на корректность
            l_result := bars.bars_alien_privs.check_op_field(
                r.tag, r.value,
                d.s, d.s2, d.kv, d.kv2, d.nls_a, d.nls_b, d.mfo_a, d.mfo_b, d.tt
            );
            if l_result=0 then
                bars.bars_error.raise_nerror(l_errmod, 'TAG_INVALID_VALUE', r.tag);
            end if;
        end if;
        begin
            insert into bars.operw(ref,tag,value) values(l_ref,r.tag,r.value);
        exception when dup_val_on_index then
            update bars.operw set value=r.value where ref=l_ref and tag=r.tag;
        end;
    end loop;

    -- выставляем признак BIS=1 при необходимости
        
    if get_bis_count(l_ref) > 0 then
       update bars.oper set bis = 1
       where ref=l_ref;
       bars.bars_audit.trace('bars_docsync.post_document: найдены бис строки');     
    end if;     
        

    bars.bars_audit.trace('bars_docsync.post_document: старт формирования доп. реквизитов в СЕП');
    -- формируем доп. реквизиты в СЭП
    if l_tt.fli=1 then
        l_d_rec := '';
        for s in (select w.tag, w.value, f.vspo_char
                    from bars.operw w, bars.op_field f
                    where w.ref = l_ref
                      and w.tag = f.tag
                      and f.vspo_char is not null
                      and f.vspo_char not in ('F','C','П')
                  )
        loop
            -- тип сообщения  SWIFT
            if s.vspo_char = 'f' and d.mfo_a = '300465' then continue;
            end if;

            l_d_rec := l_d_rec || '#'||s.vspo_char||s.value;
        end loop;

        if l_d_rec is not null and length(l_d_rec)>0 then
            l_d_rec := l_d_rec || '#';
        end if;
        update bars.oper set d_rec = l_d_rec where ref=l_ref;
    end if;

    -- контроль: наличие обязательных доп. реквизитов
    for c in (select * from bars.op_rules where tt=d.tt and opt='M') loop
        begin
            select ref into l_needless from bars.operw where ref=l_ref and tag=c.tag;
        exception when no_data_found then
            bars.bars_error.raise_nerror(l_errmod, 'MANDATORY_TAG_ABSENT', c.tag, d.tt);
        end;
    end loop;


    p_ref := l_ref;

    bars.bars_audit.info('bars_docsync.post_document: документ успешно сформирован с REF='|| p_ref);
  end;


  -----------------------------------
  -- GET_DOC_BUFFER
  --
  -- Получить буффера для подписи
  --

   procedure get_doc_buffer ( p_ref     in integer,
                              p_key     in varchar2,
                              p_int_buf out varchar2,
                              p_sep_buf out varchar2) is
    l_buffer varchar2(4000);
  begin
    -- отримання СЕП буферу
    bars.docsign.retrievesepbuffer(p_ref, p_key, l_buffer);
    p_sep_buf := rawtohex(utl_raw.cast_to_raw(l_buffer));
    bars.chk.make_int_docbuf(p_ref, l_buffer);
    p_int_buf := rawtohex(utl_raw.cast_to_raw(l_buffer));
  end;


  -----------------------------------
  -- PAY_DOCUMENT
  --
  -- Оплачивает один документ
  --
  procedure pay_document(p_ext_ref number, p_ref  number) is
    --l_ref           bars.oper.ref%type;
    l_sos           bars.oper.sos%type;
    l_vdat          date;
    l_sq            number;
    l_doc           doc_import%rowtype;
    l_tt_flags      bars.tts.flags%type;
  begin
     bars.bars_audit.info('bars_docsync.pay_document: начало оплаты документа. EXT_REF='||p_ext_ref||', REF='||p_ref);
     l_doc := read_corp_doc(p_ext_ref);

     l_vdat := nvl(l_doc.vdat, bars.gl.bdate);
     l_sq := case
             when l_doc.kv = bars.gl.baseval then null
             else bars.gl.p_icurval(l_doc.kv, l_doc.s, l_vdat)
             end;

    select flags into l_tt_flags from bars.tts where tt = l_doc.tt;

    -- оплата
    bars.gl.dyntt2 (
          l_sos, to_number(substr(l_tt_flags,38,1)), 1,
          p_ref, l_vdat,
          null, l_doc.tt, l_doc.dk,
          l_doc.kv,  l_doc.mfo_a, l_doc.nls_a, l_doc.s,
          l_doc.kv2, l_doc.mfo_b, l_doc.nls_b, l_doc.s2, l_sq, null);


    --
    -- в конце проставляем референс документа, флаг оплаты и дату
    bars.bars_audit.info('bars_docsync.pay_document_document: устанваливаем статусы документа в doc_import');
    update doc_import
      set ref = p_ref,
          booking_flag='Y',
          booking_date = sysdate,
          booking_err_code = null,
          booking_err_msg = null
    where ext_ref = l_doc.ext_ref;

    -- дозаполняем справочник для свифтовок для возможности печати из АБС
    if l_doc.tt in ('IBB','IBO','IBS') then
        update bars.sw_template
           set ref = p_ref,
               user_id = l_doc.userid
         where doc_id = l_doc.ext_ref;
    end if;

    bars.bars_audit.info('bars_docsync.pay_document: документ EXT_REF='||p_ext_ref||', REF='||p_ref||' оплачен, oper.sos= '||l_sos);


  end pay_document;

  
  

  ------------------------------------
  --  POST_ERROR_PROC
  --
  --  Набор операций для выполнения после неуспешной обработки докумнета
  --
  procedure post_error_proc(p_ext_ref number, p_sqlerr_code number, p_sqlerr_stack varchar2) is     
     l_app_err       varchar2(4000);
     l_err_count     number;
     l_ignore_error  boolean;
     l_ignore_count  number;
    l_err_code      number;
    l_err_msg       varchar2(4000);
     l_doc           doc_import%rowtype;
     l_bars_doc      bars.oper%rowtype;
     l_doc_vdat date;
     l_trace         varchar2(1000) := 'bars_docsync.post_error_proc: ';
  begin

     bars.bars_audit.error('bars_docsync.post_error_proc: обработка ошибки оплаты: errcode='||p_sqlerr_code||', errmsg='||substr(p_sqlerr_stack, 1, 3900));
     l_doc := read_corp_doc(p_ext_ref);
     --l_bars_doc := read_bars_doc(l_doc.ref);
     
     -- удаляем информацию о свифтовке со справочника sw_template в АБС
     if l_doc.tt in ('IBB','IBO','IBS') then
        delete from bars.sw_template where doc_id = l_doc.ext_ref;
     end if;


     -- сохраняем информацию об ошибке
     l_err_code := p_sqlerr_code;
     l_err_msg  := substr(p_sqlerr_stack, 1, 3900);

     -- прикладные ошибки трактуются как неустраняемые для данного док-та и передаются породившей док-т стороне
     
     -- По заказу от банка:    
     -- Если платеж при автооплате вылетает с ошибкой нелдостачи денег  ORA-20203: \9301 broken limit on accounts
     -- Тогда его не сторнировать (т.е. не устанавливать booking_flag = N), а оставлять на повторную оплату в этот день, 
     -- и только в следующий банковский день - браковать его (т.е. не устанавливать booking_flag = N) 
     
     if   l_err_code >-21000 and l_err_code<=-20000 then
         -- нет средств на счете и банк дата = валютировнаию  - документ отправить на повторную оплату
        l_doc_vdat := nvl(l_doc.vdat, bars.gl.bdate);
        
        bars.bars_audit.info(l_trace||'vdat='|| to_date(l_doc_vdat,'dd/mm/yyyy') ||' bars.gl.bdate='||to_date(bars.gl.bdate,'dd/mm/yyyy')||', instr ='||instr(l_err_msg, '\9301') );

     -- Обработка прикладных ошибок, которые должны дать повторную оплату 
        
     -- Если платеж при автооплате вылетает с ошибкой нелдостачи денег  ORA-20203: \9301 broken limit on accounts
     -- Тогда его не сторнировать , а оставлять на повторную оплату в этот день
      if ( (l_err_code = -20203 and instr(l_err_msg, '\9301') > 0 and  l_doc_vdat = bars.gl.bdate) 
            or
           (l_err_code = -20060)   -- Будущая дата валютирования (описана в ошибках модуля DOC)
         )   
         then 
            -- оплата будет повторена в следующем цикле
            update doc_import
              set system_err_code = l_err_code,
                  system_err_msg  = l_err_msg,
                  system_err_date = sysdate
            where ext_ref = l_doc.ext_ref;
          bars.bars_audit.info(l_trace||'нехватка денег на счете - документ ожидает оплаты в следующем цикле обработки' );     
        else 
            -- обработка специальных случаев, типа "счет залочен" и пр.
            l_app_err  := extract_app_error(l_err_msg);

             begin
                select ignore_count into l_ignore_count
                  from doc_error_behavior
                 where ora_error = l_err_code
                   and (app_error is null and l_app_err is null or app_error = l_app_err);

                l_err_count := nvl(l_doc.ignore_count, 0) + 1;

                update doc_import
                   set ignore_err_code = l_err_code,
                       ignore_err_msg  = l_err_msg,
                       ignore_count    = l_err_count,
                       ignore_date     = sysdate
                 where ext_ref = l_doc.ext_ref;

                l_ignore_error := true;

             exception when no_data_found then
                 l_ignore_error := false;
             end;


             if not l_ignore_error or l_ignore_error and l_err_count > l_ignore_count then
                update doc_import
                   set booking_flag = 'N',
                       booking_date = sysdate,
                       booking_err_code = l_err_code,
                       booking_err_msg = l_err_msg
                 where ext_ref = l_doc.ext_ref;

                 bars.bars_audit.info(l_trace||'ошибка прикладная - документ остановлен для дальнейшей оплаты' );
             end if;
        end if;
     else
            -- системные ошибки сохраняются для анализа
            -- оплата будет повторена в следующем цикле
            update doc_import
              set system_err_code = l_err_code,
                  system_err_msg  = l_err_msg,
                  system_err_date = sysdate
            where ext_ref = l_doc.ext_ref;
          bars.bars_audit.info(l_trace||'ошибка системная - документ ожидает оплаты в следующем цикле обработки' );
     end if;

  end;




  ------------------------------------
  --  SUBST_NEDDED_BRANCH
            --
  --  Установить нужный бранч для создания документа в нем
            --
  procedure subst_nedded_branch(p_ext_ref number) is
     l_branch_isp    varchar2(30);
     l_branch        varchar2(30);
     l_doc           doc_import%rowtype;
            begin

      l_doc := read_corp_doc(p_ext_ref);

                -- ММФО: встановлюємо МФО з якого отримано документ
      if sys_context('bars_context','user_mfo') <> l_doc.mfo_a then
         bars.bars_context.subst_mfo(l_doc.mfo_a);
                end if;

      select branch into l_branch
        from bars.accounts
       where nls = l_doc.nls_a
         and kv = l_doc.kv
         and kf = l_doc.mfo_a;

                --COBUMMFO-4647 согласно заявки докмент создается в бранче привязки счета. Бранч исполнителя не проверяется(код заккоментирован)
                --COBUMMFO-4647 согласно заявки докмент создается в бранче привязки счета. Бранч исполнителя не проверяется(код заккоментирован)
                -- Ищем бранч пользователя-операциониста
                -- select branch into l_branch_isp from bars.staff$base where id=d.userid;
                -- Для пользователя на '/' будет подставляться МФО плательщика
     --select case when branch='/' then '/'||l_doc.mfo_a||'/' else branch end
       --into l_branch_isp
       --from bars.staff$base
      --where id = l_doc.userid;

                -- Если только бранч пользователя не выше чем счета
     --if l_branch_isp like l_branch||'%' then
                    -- представимся текущим отделением плательщика
                    bars.bars_context.subst_branch(l_branch);
     /*else
                    -- представимся текущим отделением исполнителя
                    bars.bars_context.subst_branch(l_branch_isp);
     end if; */

     bars.bars_audit.trace('bars_docsync.subst_nedded_branch: представление бранчем - '|| sys_context('bars_context','user_branch'));
  end;



  ------------------------------------
  -- ASYNC_AUTO_PAY
                --
  -- Процедура для автообработки докумнетов корп2 вертушкой
  -- Формирование документа и его оплата
                --
  procedure async_auto_pay (p_ext_ref number, p_ref out number)
  is
     l_ref number;
     l_errmod varchar2(3) := 'DOC';
     l_errtxt varchar2(4000);
     
  begin
      
      bars.bars_audit.info('bars_docsync.async_auto_pay: старт формирования и оплаты документа EXT_REF='||p_ext_ref);
      
      --savepoint sp_before_pay;
      --Установить нужный бранч для создания документа в нем
      subst_nedded_branch( p_ext_ref => p_ext_ref );

      -- вставка документа с доп. реквизитами
      post_document ( p_ext_ref => p_ext_ref , p_ref => l_ref );

      -- оплата документа (без установки виз)
      pay_document( p_ext_ref => p_ext_ref , p_ref => l_ref);

      -- установка виз и окончательная оплата будет производится

      p_ref := l_ref;

      bars.bars_audit.trace('bars_docsync.async_auto_pay: формировани и оплата документа EXT_REF='||p_ext_ref||' выполнена c REF = '||l_ref);
            exception when others then
          
          --Предполагается, что постобработка ошибки (установка флагов и т.д.) будет выполнена вертушкой
          l_errtxt := substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 3900);
          bars_audit.error('bars_docsync.async_auto_pay: Ошибка выполнения для EXT_REF=:'||p_ext_ref||': '||l_errtxt); 
          -- нужно выкинуть первичную ошибку. Поскольку в постобработке идет анализ кода ошибки:
          --  если системная - идет повторн оплаты
          --  если прикладная, докумнет останавливается в оплате
          raise;
  end;

  ------------------------------------
  -- GET_BIS_COUNT
  --
  -- Проверить наличие бис строк
  --
  function get_bis_count(p_ref      in number) return number
  is
     l_cnt number;
  begin
     select count(*) into l_cnt
                 from bars.operw w, bars.op_field v
                where w.ref = p_ref
                  and w.tag = v.tag
                  and v.vspo_char in ('F','П','C')
                order by v.vspo_char,w.tag; 
     return l_cnt;
  end;



  ------------------------------------
  -- POST_SEP_ROWS
  --
  -- Вставить строки в arc_rrp
  --
  --
  procedure post_sep_rows (p_ext_ref number, p_doc bars.oper%rowtype)
  is
     l_arc        bars.arc_rrp%rowtype;    
     l_doc        bars.oper%rowtype;
     l_err        number;
     l_bis_count  number;
     l_bis_curr   number;
     l_sep_err    number;
     l_seperr_text varchar2(1024);
     l_sep_rec    number;
     l_arc_count  number;
     l_arc_curr   number;
     l_nazn_list  bars.tt_str_array;
     l_req_value  varchar2(1024);
     l_trace      varchar2(2000) := G_TRACE||'post_sep_rows: ';
  begin
     l_nazn_list :=  bars.tt_str_array(null);
     l_doc := p_doc;
     l_bis_curr  := 0;
     
     bars.bars_audit.info(l_trace||'старт вставки строк в arc_rrp EXT_REF='||p_ext_ref);
     -- если ест ьбис строки - сформируем массив назанчений платежа
     for c in (select w.tag, w.value, v.vspo_char
                 from bars.operw w, bars.op_field v
                where w.ref = l_doc.ref
                  and w.tag = v.tag
                  and v.vspo_char in ('F','П','C')
                order by v.vspo_char,w.tag
               ) loop

          -- в некоторых случаях бис строки могут быть в однос строке через перевод каретки (из пакета CHK)
          for v in (select regexp_substr(c.value ,'[^'|| chr(13)||chr(10) ||']+', 1, level) value
                      from dual
                   connect by regexp_substr(c.value , '[^'|| chr(13)||chr(10) ||']+', 1, level) is not null)
                  loop
                    l_bis_curr := l_bis_curr + 1;
                    if c.vspo_char = 'F' then
                       l_req_value := '#F' || trim(c.tag) || ':' || rpad(trim(v.value) || '#', 158);
                    else
                       l_req_value := '#' || c.vspo_char || rpad(trim(v.value) || '#', 218);
                end if;
                    l_nazn_list(l_nazn_list.last) := l_req_value;
                  end loop;
     end loop;
     l_bis_count := l_bis_curr;    
     bars.bars_audit.trace(l_trace||'кол-во бис строк: '||l_bis_count);

     l_bis_curr := 0;  -- номер текущей строки в arc_rrp, начинаем с 0
     l_arc.rec  := 0;
     --l_arc_count := l_bis_count + 1;
     --l_arc_curr  := 
     -- начинаем формировать строки для arc_rrp
     -- пройтись по всем нужным строкам в arc_rrp
     while l_bis_curr <= l_bis_count loop
           if l_bis_curr = 0 then -- первая строка в arc_rr
              l_arc.d_rec := case when l_bis_count > 0 then '#B' || lpad(l_bis_count + 1, 2, '0') || nvl(l_doc.d_rec, '#') else l_doc.d_rec end; 
              l_arc.nazns := case when l_bis_count > 0 then '11' else  '10' end;
              l_arc.bis   := case when l_bis_count = 0 then 0 else 1 end;
              l_arc.sign  := l_doc.sign;
           else              -- остальные строки
              l_arc.nazns := '33';
              l_doc.s     := 0;
              l_arc.bis   := l_bis_curr + 1; 
              l_doc.dk := case l_doc.dk when 0 then 2 when 1 then 3 else l_doc.dk end;
              l_arc.sign  := null;
              l_req_value := l_nazn_list(l_bis_curr);

              if length(l_req_value) > 160 then
                 l_arc.d_rec := substr(l_req_value, 161, 60);
                 l_doc.nazn := substr(l_req_value, 1, 160);
              else
                 l_arc.d_rec := '';
                 l_doc.nazn := substr(l_req_value, 1, 160);
              end if;
           end if;

            bars.sep.in_sep(
                  err_   => l_sep_err,
                  rec_   => l_sep_rec,
                  mfoa_  => l_doc.mfoa,
                  nlsa_  => l_doc.nlsa,
                  mfob_  => l_doc.mfob,
                  nlsb_  => l_doc.nlsb,
                  dk_    => l_doc.dk,
                  s_     => l_doc.s,
                  vob_   => l_doc.vob,
                  nd_    => l_doc.nd,
                  kv_    => l_doc.kv,
                  data_  => l_doc.datd,
                  datp_  => l_doc.datp,
                  nam_a_ => l_doc.nam_a,
                  nam_b_ => l_doc.nam_b,
                  nazn_  => l_doc.nazn,
                  naznk_ => null,
                  nazns_ => l_arc.nazns,
                  id_a_  => l_doc.id_a,
                  id_b_  => l_doc.id_b,
                  id_o_  => l_doc.id_o,
                  ref_a_ => l_doc.ref_a,
                  bis_   => l_arc.bis,
                  sign_  => l_arc.sign,
                  fn_a_  => null,
                  rec_a_ => null,
                  dat_a_ => null,
                  d_rec_ => l_arc.d_rec,
                  otm_i  => 0,
                  ref_i  => l_doc.ref,
                  blk_i  => 0,
                  ref_swt_ => null);
           
                  l_bis_curr := l_bis_curr + 1;
                  
                  if (l_sep_err <> '0') then
                    begin
                          select  l_sep_err||': '||n_er into l_seperr_text from bars.s_er where k_er = l_sep_err;
                    exception when no_data_found then
                          l_seperr_text := l_sep_err;
                    end;
                      bars.bars_error.raise_nerror( G_ERRMOD, 'SDO_AUTO_PAY_INSEP_ERROR', l_seperr_text, p_ext_ref, l_doc.ref);
                  end if; 
                  
     end loop;
     bars.bars_audit.info('bars_docsync.async_auto_visa: документ EXT_REF='||p_ext_ref||',  REF = '||l_doc.ref||' вставлен в arc_rrp, l_sep_err=<'||l_sep_err||'>, кол-во бис строк = '||l_bis_count);
  end;

  
  
  ------------------------------------
  -- ASYNC_AUTO_VISA
  --
  -- Процедура для автообработки докумнетов корп2 вертушкой
  -- Установка виз с подписями, оплата по-факту
  --
  procedure async_auto_visa (p_ref      in number,
                             p_ext_ref  in number,
                             p_key      in varchar2,
                             p_int_sign in varchar2,
                             p_sep_sign in varchar2)
  is
     l_doc bars.oper%rowtype;
     l_ext_doc barsaq.doc_import%rowtype;
     l_chk_group    number;
     l_errtxt       varchar2(4000);
     l_bis_count    number;
     l_curr_bis     number;
     l_arc_row      bars.arc_rrp%rowtype;

  begin
     bars.bars_audit.info('bars_docsync.async_auto_visa: старт формирования подписей и оплаты по-факту для документа EXT_REF='||p_ext_ref||',  REF = '||p_ref);
     l_doc     := read_bars_doc(p_ref);
     l_ext_doc := read_corp_doc(p_ext_ref);

     -- наложить нулевую подпись только с внутренней визой в oper_visa.sign и ключем корпа
     bars.chk.put_visa( ref_    => p_ref ,
                       tt_     => l_doc.tt,
                       grp_    => null,
                       status_ => 0,
                       keyid_  => l_ext_doc.id_o,
                       sign1_  => l_ext_doc.sign,
                       sign2_  => null);

     bars.bars_audit.info('bars_docsync.async_auto_visa: первичная виза с внутренней подписью сформирована');


    -- найдем последнюю визу
     select idchk into l_chk_group
         from bars.chklist_tts
        where priority = 1
          and tt = l_doc.tt;

    -- документ внешний, требующий СЕП или ВПС
    if ( l_doc.mfoa <> l_doc.mfob and l_doc.tt in ('IB2','IB4')) then

    -- наложить вторую и последнюю визу но уже с подписью вертушки авто-СДО
       bars.chk.put_visa(ref_     => p_ref ,
                          tt_     => l_doc.tt,
                          grp_    => l_chk_group,
                          status_ => 2,
                          keyid_  => p_key,
                          sign1_  => p_int_sign,
                          sign2_  => p_sep_sign);

       bars.bars_audit.info('bars_docsync.async_auto_visa: для внешнего докумнета виза с внешней подписью сформирована с группой визировнаия '||l_chk_group);

       -- оплачиваем документ принудительно до состяения "оплачен"
       bars.bars_audit.info('bars_docsync.async_auto_visa: старт оплаты документа по-факту с датой валютировнаия '||to_char(l_doc.vdat,'dd/mm/yyyy'));
       bars.gl.pay( p_flag => 2,
                    p_ref  => p_ref,
                    p_vdat => l_doc.vdat);
       
       l_doc     := read_bars_doc(p_ref);

       bars.bars_audit.info('bars_docsync.async_auto_visa: документ EXT_REF='||p_ext_ref||',  REF = '||p_ref||' успешно оплачен по-факту в oper, sos='||l_doc.sos );
       
       -- что - то пошлоне так (например, дата валютирования больше чем текущая - тогда документ останется ждать даты валютировнаия. В этом случае вообще приостанавливаем оплату.)
       if (l_doc.sos <> 5 ) then
            -- по какойто причине документ не смог оплатиться по-факту. При этом ошибки(exception) могло не быть.
            -- Например, будущая дата валютировнаия. По-этому выкидываем прикладную ошибку
            if l_doc.vdat > bars.gl.bDATE then
               bars.bars_error.raise_nerror( G_ERRMOD, 'FUTURE_VALUE_DATE', p_ext_ref, p_ref, to_char(l_doc.vdat,'dd/mm/yyyy')); 
                    end if;
            
            bars.bars_error.raise_nerror( G_ERRMOD, 'FAILED_TO_PAY_BY_FACT', p_ext_ref, p_ref);
             
       end if;
       
       bars.bars_audit.info('bars_docsync.async_auto_visa: документ EXT_REF='||p_ext_ref||',  REF = '||p_ref||' успешно оплачен по-факту в oper, sos='||l_doc.sos );
       -- если удалось оплатить
       if (l_doc.sos = 5 ) then
           -- внести записи в arc_rrp (тут же бисы)
           post_sep_rows (p_ext_ref => p_ext_ref, p_doc => l_doc);
                else
           bars.bars_audit.info('bars_docsync.async_auto_visa: при попытке автооплаты СЕП/ВПС документа, документ EXT_REF='||p_ext_ref||',  REF = '||p_ref||' не был оплачен по-факту, sos='||l_doc.sos);
                end if;

     
    else
       
      -- наложить вторую и последнюю визу для внутреннего документа 
      bars.chk.put_visa(ref_    => p_ref         ,
                        tt_     => l_doc.tt      ,
                        grp_    => l_chk_group   ,
                        status_ => 2             ,
                        keyid_  => l_ext_doc.id_o,
                        sign1_  => l_ext_doc.sign,
                        sign2_  => null);


-- оплачиваем документ принудительно до состяения "оплачен"
       bars.gl.pay( p_flag => 2,
                    p_ref  => p_ref,
                    p_vdat => l_doc.datp);
                    
       

    end if;

    bars.bars_audit.info('bars_docsync.async_auto_visa: документ EXT_REF='||p_ext_ref||',  REF = '||p_ref||' успешно оплачен по-факту');
    
            end;






  ------------------------------------
  -- ASYNC_PAY_DOCUMENTS
  --
  -- процедура асинхронной оплаты документов из списка очереди
  --  p_pay_type:
  --  G_PAYTYPE_AUTO   constant smallint  := 0;
  --  G_PAYTYPE_MANUAL constant smallint  := 1;
  --
  --
  procedure async_pay_documents  is
    l_ref number;
	l_doc_count     integer := 0;
  begin
    bars.bars_audit.info('bars_docsync.async_pay_documents: старт процедуры оплаты документов. Системная дата: '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') );
	
    -- цикл по документам
    for d in (select * from doc_import d
              where 
                     -- сделано через case, так как какогото черта, ктото  специально индекс строил под это условие. А других индексов нет, а в таблице около 60 млн записей.
                     case
                         when confirmation_flag='Y' and booking_flag is null and removal_flag is null then 'Y'
                         else null
                    end  = 'Y'
                and d.flg_auto_pay = 0
               order by confirmation_date, ext_ref
             )
    loop
        if lock_document4pay(d.ext_ref) then
            savepoint sp_before_pay;
            begin
               bars.bars_audit.info('bars_docsync.async_pay_documents: старт процедуры оплаты документа EXT_REF='||d.ext_ref);
               --Установить нужный бранч для создания документа в нем
               subst_nedded_branch( p_ext_ref => d.ext_ref );

               -- вставка документа с доп. реквизитами
               post_document ( p_ext_ref => d.ext_ref , p_ref => l_ref );

               -- оплата документа
               pay_document( p_ext_ref => d.ext_ref,  p_ref => l_ref);

               -- устанвока нулевой визы
               bars.chk.put_visa(l_ref,  d.tt, null, 0, d.id_o, d.sign, null);

            exception when others then
                rollback to sp_before_pay;
                post_error_proc(p_ext_ref => d.ext_ref,
                                p_sqlerr_code => SQLCODE,
                                p_sqlerr_stack => substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 3900));
            end;
            -- фиксируем оплату документа
            commit;
            --
			l_doc_count := l_doc_count + 1;
        end if;
    end loop;
    -- возвращаемся в свой контекст для мульти-мфо
    bars_sync.set_context();
    --
    bars.bars_audit.info('bars_docsync.async_pay_documents: финиш процедуры оплаты. Всего обработано документов: '||l_doc_count||'. Системная дата: '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'));
  end async_pay_documents;



  ----
  -- reset_booking_info - сбрасывает информацию об оплате документа
  -- @p_ext_ref - внешний референс документа
  --
  procedure reset_booking_info(p_ext_ref in varchar2) is
  begin
    update doc_import set booking_flag=null, booking_date=null, booking_err_code=null, booking_err_msg=null
    where ext_ref=p_ext_ref and removal_flag is null;
    if sql%rowcount=0 then
        raise_application_error(-20000, 'Документ не найден или документ EXT_REF='
                                        ||p_ext_ref||' уже помечен к удалению.', TRUE);
    end if;
    bars.bars_audit.info('Информация об оплате документа EXT_REF='||p_ext_ref||' успешно сброшена.');
  end reset_booking_info;

  ----
  -- async_remove_documents - удаляет помеченные к удалению документы с наступившей датой удаления
  --
  procedure async_remove_documents is
  begin
    bars.bars_audit.trace('start');
    -- удаляем сначала помеченные к удалению документы
    for c in (select * from doc_import where removal_flag='Y' and removal_date<=sysdate for update skip locked)
    loop
        delete from doc_import_props where ext_ref=c.ext_ref;
        delete from doc_import where ext_ref=c.ext_ref;
        bars.bars_audit.info('Помеченный к удалению документ EXT_REF='||c.ext_ref||' успешно удален.');
    end loop;
    -- удаляем документы висящие больше 15 дней без пометки к удалению
    for c in (select * from doc_import where removal_flag is null and insertion_date<sysdate-15 for update skip locked)
    loop
        delete from doc_import_props where ext_ref=c.ext_ref;
        delete from doc_import where ext_ref=c.ext_ref;
        bars.bars_audit.info('Неоплаченный в течении 15 дней документ EXT_REF='||c.ext_ref||' успешно удален.');
    end loop;
    bars.bars_audit.trace('finish');
  end async_remove_documents;

end bars_docsync;
/
 show err;
 
 
grant execute on barsaq.bars_docsync to bars_access_defrole;
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/bars_docsync.sql =========*** End 
 PROMPT ===================================================================================== 
 