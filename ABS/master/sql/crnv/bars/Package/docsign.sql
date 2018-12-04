create or replace package docsign is
  /**
    Пакет DOCSIGN содержит функции для работы с буферами документов,
    с визами и ЭЦП на визировании.
  */

  g_header_version constant varchar2(64) := 'version 1.5 04/10/2016';
  
  ATTR_CODE_USER_SIGN_TYPE constant varchar2(30 char) := 'STAFF_USER_SIGN_TYPE';
  ATTR_CODE_USER_KEY_SERIAL constant varchar2(30 char) := 'STAFF_USER_KEY_SERIAL';

  /**
  * header_version - возвращает версию заголовка пакета
  */
  function header_version return varchar2;

  /**
  * body_version - возвращает версию тела пакета
  */
  function body_version return varchar2;

  function userid2digitid(uid in number) return varchar2;

  /**
  * Возвращает тип ЭЦП (NBU, UNI, VEG, PRX, SL2, ...)
  */
  function getsigntype return varchar2;

  /**
  * Возвращает длину буффера документа (зависит от типа ЭЦП)
  */
  function get_signlng return number deterministic;

  /**
  * Возвращает длину буфера документа (зависит от типа ЭЦП)
  */
  function getsignlength return number;

  -- получение идент. ключа операциониста
  function getidoper return varchar2;

  -- допустимый VOB для отправки в СЕП
  function get_sep_vob(p_vob in number) return number;

  -- получение буфера СЭП по референсу и идент. ключа
  -- если ключ не задан, берется из oper.id_o
  procedure retrievesepbuffer(pref    in number,
                              id_oper in varchar2 default null,
                              buf     out varchar2);

  -- сохранение ЭЦП в таблице oper
  procedure storesepsign(pref    in number,
                         buf     in varchar2,
                         id_oper in varchar2,
                         bsign   in raw);
  
  -- получить текущий тип подписи для пользователя (если без параметрров, то для текущего авторизированного пользователя)
  function get_user_sign_type(p_user_id in number default null) return varchar2;

  -- получить идентитифкатор ключа по типу подписи для авторизированного пользователя
  function get_user_keyid(p_sign_type in varchar2 default null, p_user_id in number default null) return varchar2;

end docsign;
/

show err

create or replace package body docsign is

  /**
  
  */

  g_body_version constant varchar2(64) := 'version 1.6 20/01/2014';

  -- ----------------------------------------------------------------
  -- Global Declaration
  -- ----------------------------------------------------------------

  g_signtype   varchar2(3); -- тип ЭЦП пользователя (для НБУ у разных пользователей может быть разная ЭЦП)
  g_signlength number; -- длина буффера (зависит от типа ЭЦП)
  g_use_vega2  number;

  /**
  * header_version - возвращает версию заголовка пакета
  */
  function header_version return varchar2 is
  begin
    return 'Package header DOCSIGN ' || g_header_version || '.';
  end header_version;

  /**
  * body_version - возвращает версию тела пакета
  */
  function body_version return varchar2 is
  begin
    return 'Package body DOCSIGN ' || g_body_version || '.';
  end body_version;

  /**
  * Возвращает тип ЭЦП (NBU, UNI, VEG, PRX, SL2, ...)
  */
  function getsigntype return varchar2 is
  begin
    return g_signtype;
  end getsigntype;

  /**
  * Возвращает длину буффера документа (зависит от типа ЭЦП)
  */
  function get_signlng return number deterministic is
  begin
    return g_signlength;
  end get_signlng;

  /**
  * Возвращает длину буффера документа (зависит от типа ЭЦП)
  */
  function getsignlength return number is
  begin
    return g_signlength;
  end getsignlength;

  function userid2digitid(uid in number) return varchar2 is
    vid     number;
    hi_bit  number;
    low_bit number;
  begin
    if uid < 100 then
      return trim(to_char(uid, '00'));
    end if;
    if uid > 25 * 27 + 100 then
      return '';
    end if;
    vid     := uid - 100;
    hi_bit  := trunc(vid / 26);
    low_bit := mod(vid, 26);
    return chr(65 + hi_bit) || chr(65 + low_bit);
  end;

  -- получение идент. ключа операциониста
  function getidoper return varchar2 is
    erm varchar2(256);
    ern constant positive := 041;
    err exception;
    ido varchar2(32);
  begin
    -- добавить блок для нового типа ЭЦП !!!
    case
      when g_signtype = 'NBU' then
        begin
          select substr(sab, 2, 3) || 'O' || userid2digitid(user_id)
            into ido
            from banks
           where mfo = f_ourmfo;
        end;
      when g_signtype in ('UKR', 'VEG', 'UNI', 'PRX', 'SL2', 'SSF') then
        begin
          select tabn into ido from staff$base where id = user_id;
        end;
      else
        begin
          erm := '1 - Неизвестный тип ЭЦП: ' || g_signtype;
          raise err;
        end;
    end case;
    return ido;
  exception
    when err then
      bars_audit.write_message(bars_audit.err_msg,
                               bankdate,
                               'DOCSIGN.GetIdOper(): error: ' || erm);
      raise_application_error(- (20000 + ern), '\' || erm, true);
  end;

  -- допустимый VOB для отправки в СЕП
  function get_sep_vob(p_vob in number) return number is
    l_vob_list params.val%type;
    l_vob      oper.vob%type := p_vob;
  begin
    begin
      select ',' || replace(trim(val), ' ', '') || ','
        into l_vob_list
        from params
       where par = 'VOB2SEP2';
    exception
      when no_data_found then
        l_vob_list := ',1,2,6,33,81,';
    end;
    if instr(l_vob_list, ',' || p_vob || ',') = 0 then
      select nvl(min(to_number(val)), 1)
        into l_vob
        from params
       where par = 'VOB2SEP';
    end if;
    return l_vob;
  end;

  -- получение буфера СЭП по референсу и идент. ключа
  -- если ключ не задан, берется из oper.id_o
  procedure retrievesepbuffer(pref    in number,
                              id_oper in varchar2 default null,
                              buf     out varchar2) is
    erm varchar2(256);
    ern constant positive := 040;
    err exception;
    doc_buf varchar2(444);
    l_oper_id varchar2(8);
  begin
    bars_audit.write_message(bars_audit.deb_msg,
                             bankdate,
                             'DOCSIGN.RetrieveSEPBuffer(): start');
    l_oper_id := rpad(nvl(id_oper, docsign.getidoper), 6);
    logger.info('docsign::1 l_oper_id=[' || l_oper_id || ']');
    if g_use_vega2 = 1 then
      -- ведущие нули до 8 знаков, и потом справа вырезаем 6 знаков в буфер
      l_oper_id := substr(lpad(nvl(id_oper, docsign.getidoper),8, '0'), -6);
    end if;                                          
    logger.info('docsign::2 l_oper_id=[' || l_oper_id || ']');                
    begin
      select lpad(mfoa, 9) || lpad(nlsa, 14) || lpad(mfob, 9) ||
             lpad(nlsb, 14) || lpad(to_char(dk), 1) || lpad(to_char(s), 16) ||
             lpad(to_char(get_sep_vob(vob)), 2) || rpad(nvl(nd, ' '), 10) ||
             lpad(to_char(kv), 3) || nvl(to_char(datd, 'YYMMDD'), '      ') ||
             nvl(to_char(datp, 'YYMMDD'), '      ') || rpad(nam_a, 38) ||
             rpad(nam_b, 38) || rpad(nvl(nazn, ' '), 160) ||
             rpad(nvl(d_rec, ' '), 60) || rpad(' ', 3) ||
             rpad(nvl2(d_rec, '11', '10'), 2) || lpad(nvl(id_a, ' '), 14) ||
             lpad(nvl(id_b, ' '), 14) || lpad(nvl(ref_a, ref), 9) ||
             l_oper_id || lpad('0', 2) ||
             lpad(' ', 8)
        into doc_buf
        from oper
       where ref = pref;
      buf := doc_buf;
      logger.info('docsign::3 doc_buf=[' || doc_buf || ']');                
    exception
      when no_data_found then
        erm := '1 - Документ не найден. REF=' || pref || '.';
        raise err;
    end;
    bars_audit.write_message(bars_audit.deb_msg,
                             bankdate,
                             'DOCSIGN.RetrieveSEPBuffer(): finish');
  exception
    when err then
      bars_audit.write_message(bars_audit.err_msg,
                               bankdate,
                               'DOCSIGN.RetrieveSEPBuffer(): error: ' || erm);
      raise_application_error(- (20000 + ern), '\' || erm, true);
  end;

  -- сохранение ЭЦП в таблице oper
  procedure storesepsign(pref    in number,
                         buf     in varchar2,
                         id_oper in varchar2,
                         bsign   in raw) is
    erm varchar2(256);
    ern constant positive := 041;
    err exception;
    pbuf    varchar2(444);
    doc_buf varchar2(444);
    the_ref number;
    csign   raw(128);
  begin
    bars_audit.write_message(bars_audit.deb_msg,
                             bankdate,
                             'DOCSIGN.StoreSEPSign(): start');
    bars_audit.write_message(bars_audit.deb_msg,
                             bankdate,
                             'DOCSIGN.StoreSEPSign(), id_oper=' || id_oper);
    --bars_audit.write_message(bars_audit.DEB_MSG, bankdate, 'DOCSIGN.StoreSEPSign(), bsign='||bsign);
    -- odp.net тримает концевые пробелы в строках, добавляем
    pbuf := rpad(buf, 444);
    -- лочим строку
    select ref, sign
      into the_ref, csign
      from oper
     where ref = pref
       for update nowait;
    if csign is not null then
      erm := 'Документ уже содержит ЭЦП. REF=' || pref || '.';
      raise err;
    end if;
    retrievesepbuffer(pref, id_oper, doc_buf);
    bars_audit.write_message(bars_audit.deb_msg,
                             bankdate,
                             'DOCSIGN.StoreSEPSign(), pbuf_len    =' ||
                             length(pbuf));
    bars_audit.write_message(bars_audit.deb_msg,
                             bankdate,
                             'DOCSIGN.StoreSEPSign(), doc_buf_len=' ||
                             length(doc_buf));
    bars_audit.write_message(bars_audit.deb_msg,
                             bankdate,
                             'DOCSIGN.StoreSEPSign(), pbuf    =' || pbuf);
    bars_audit.write_message(bars_audit.deb_msg,
                             bankdate,
                             'DOCSIGN.StoreSEPSign(), doc_buf=' || doc_buf);
    if doc_buf <> pbuf then
      erm := 'Буфер подписанного документа и текущий буфер не совпадают. REF=' || pref || '.';
      raise err;
    end if;
    update oper set id_o = id_oper, sign = bsign where ref = pref;
    bars_audit.write_message(bars_audit.deb_msg,
                             bankdate,
                             'DOCSIGN.StoreSEPSign(): finish');
  exception
    when err then
      bars_audit.write_message(bars_audit.err_msg,
                               bankdate,
                               'DOCSIGN.StoreSEPSign(): error: ' || erm);
      raise_application_error(- (20000 + ern), '\' || erm, true);
  end;

  -- получить текущий тип подписи для пользователя (если без параметрров, то для текущего авторизированного пользователя)
  function get_user_sign_type(p_user_id in number default null)
    return varchar2 is
    l_count_flag number;
  begin
    -- проверка наличия старого ключа - если еще не получил пользователь
    select count(sk.key_id)
      into l_count_flag
      from staff_keys sk
     where sk.user_id = nvl(p_user_id, bars.user_id)
       and sk.key_type = 'VEG';
    -- если глобально включена VEGA2  
    if g_use_vega2 = 1 then
      if l_count_flag > 0 then 
        return 'VEG';
      end if;  
      return 'VG2';
    end if;
    return 'VEG';
  end;

  -- получить идентитифкатор ключа по типу подписи для авторизированного пользователя
  function get_user_keyid(p_sign_type in varchar2 default null,
                          p_user_id   in number default null)
    return varchar2 is
    l_user_key_id staff$base.tabn%type;
  begin
    select s.tabn
      into l_user_key_id
      from staff$base s
     where s.id = nvl(p_user_id, bars.user_id);
    if g_use_vega2 = 1 then
       l_user_key_id := lpad(l_user_key_id,8, '0');
    end if;    
    begin
      select sk.key_id
        into l_user_key_id
        from staff_keys sk
       where sk.user_id = nvl(p_user_id, bars.user_id)
         and sk.key_type = nvl(p_sign_type, 'VEG');
      return l_user_key_id;
    exception
      when no_data_found then
        return l_user_key_id;
    end;
  end;

begin
  select nvl(min(val), 'NBU')
    into g_signtype
    from params
   where par = 'SIGNTYPE';
   
  select nvl(min(val), 0)
    into g_use_vega2
    from params
   where par = 'CRYPTO_USE_VEGA2';
  -- добавить блок при появлении нового типа ЭЦП
  g_signlength := case g_signtype
                    when 'NBU' then
                     64
                    when 'VEG' then
                     90
                    when 'PRX' then
                     64
                    when 'UNI' then
                     88
                    when 'SL2' then
                     64
                    when 'SSF' then
                     717
                    else
                     0
                  end;
  if g_signtype = 'SSF' then
    select nvl(to_number(val), 717)
      into g_signlength
      from params
     where par = 'SSF_SLEN';
  end if;
end docsign;
/

show err

GRANT EXECUTE ON DOCSIGN TO BARS_ACCESS_USER;