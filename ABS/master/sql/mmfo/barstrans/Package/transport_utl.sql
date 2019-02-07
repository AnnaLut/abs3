
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/transport_utl.sql =========*** Run
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE "BARSTRANS"."TRANSPORT_UTL" is

  trans_state_new            constant integer := 1;
  trans_state_failed         constant integer := 2;
  trans_state_sent           constant integer := 3;
  trans_state_data_not_ready constant integer := 4;
  trans_state_responded      constant integer := 5;
  trans_state_done           constant integer := 6;
  trans_state_broken_file    constant integer := 7; 

  marginal_tries_count constant integer := 15;

  function create_transport_unit(p_unit_type_id in number,
                                 p_ext_id       in varchar2,
                                 p_receiver_url in varchar2,
                                 p_request_data in clob,
                                 p_hash         in varchar2,
                                 p_state        out number,
                                 p_msg          out varchar2) return varchar2;

  function create_transport_unit(p_unit_type_code in varchar2,
                                 p_ext_id         in varchar2,
                                 p_receiver_url   in varchar2,
                                 p_request_data   in clob,
                                 p_hash           in varchar2,
                                 p_state          out number,
                                 p_msg            out varchar2)return varchar2;

  function create_transport_unit_sub(p_unit_type_code in varchar2,
                                     p_ext_id         in varchar2,
                                     p_receiver_url   in varchar2,
                                     p_request_data   in clob,
                                     p_hash           in varchar2,
                                     p_state          out number,
                                     p_msg            out varchar2)
    return varchar2;

  procedure set_transport_state(p_id               in varchar2,
                                p_state_id         in integer,
                                p_tracking_comment in varchar2,
                                p_stack_trace      in clob);

  procedure set_transport_failure(p_id            in varchar2,
                                  p_error_message in varchar2,
                                  p_stack_trace   in clob);

  procedure set_transport_failure(p_unit_row      in transport_unit%rowtype,
                                  p_error_message in varchar2,
                                  p_stack_trace   in clob);

  function read_unit(p_unit_id in varchar2) return transport_unit%rowtype;

  function get_unit_type_id(p_unit_type_code in varchar2) return number;

  function read_unit_type(p_transport_id in integer)
    return transport_unit_type%rowtype;

  function get_unit_state(p_unit_id in varchar2) return number;

  -- повертає заархівовану квитанцію
  function get_unit_resp(p_unit_id in varchar2) return blob;
  -- повертає заархівовану квитанцію в base64
  function get_unit_respinbase64(p_unit_id in varchar2) return clob;

  procedure save_response(p_id        varchar2,
                          p_resp_data blob);

  procedure get_unit_state_xrm(p_unit_id in varchar2,
                               p_state   out number,
                               p_msg     out varchar2);

end;
/
  GRANT EXECUTE ON "BARSTRANS"."TRANSPORT_UTL" TO "BARS_ACCESS_DEFROLE";
  GRANT EXECUTE ON "BARSTRANS"."TRANSPORT_UTL" TO "BARS";
/  

CREATE OR REPLACE PACKAGE BODY "BARSTRANS"."TRANSPORT_UTL" is

  function get_unit_type_id(p_unit_type_code in varchar2) return number is
    l_id number;
  begin
    select t.id
      into l_id
      from transport_unit_type t
     where upper(t.transport_type_code) = upper(p_unit_type_code);
    return l_id;
  exception
    when no_data_found then
      return null;
  end;

  procedure track_transport(p_id               in varchar2,
                            p_state_id         in integer,
                            p_tracking_comment in varchar2,
                            p_stack_trace      in clob) is
  begin
    insert into transport_tracking
      (id, unit_id, state_id, tracking_comment, stack_trace, sys_time)
    values
      (s_transport_tracking.nextval, p_id, p_state_id, p_tracking_comment,
       p_stack_trace, sysdate);
  end;

  function is_file_existed(p_unit_type_id in number,
                           p_ext_id       in varchar2)
    return transport_unit%rowtype is
    l_row transport_unit%rowtype;
  begin

    select *
      into l_row
      from transport_unit t
     where t.unit_type_id = p_unit_type_id and
           t.external_file_id = p_ext_id;

    return l_row;
  exception
    when no_data_found then
      return null;
  end;


  function create_transport_unit(p_unit_type_id in number,
                                 p_ext_id       in varchar2,
                                 p_receiver_url in varchar2,
                                 p_request_data in clob,
                                 p_hash         in varchar2,
                                 p_state        out number,
                                 p_msg          out varchar2) return varchar2 is
    l_warning                 integer;
    l_dest_offset             integer := 1;
    l_src_offset              integer := 1;
    l_blob_csid               number := dbms_lob.default_csid;
    l_lang_context            number := dbms_lob.default_lang_ctx;
    l_transport_unit_type_row transport_unit_type%rowtype;
    l_transport_unit_row      transport_unit%rowtype;
  begin
    p_state                   := 1;
    p_msg                     := 'OK';
    l_transport_unit_type_row := read_unit_type(p_unit_type_id);
    l_transport_unit_row      := is_file_existed(p_unit_type_id, p_ext_id);
    if l_transport_unit_row.state_id =
       transport_utl.trans_state_broken_file or
       l_transport_unit_row.state_id is null then
      if l_transport_unit_row.id is null then
        l_transport_unit_row.id := sys_guid;
      end if;

      l_transport_unit_row.unit_type_id     := p_unit_type_id;
      l_transport_unit_row.external_file_id := p_ext_id;
      l_transport_unit_row.receiver_url     := p_receiver_url;
      l_transport_unit_row.kf := sys_context('bars_context','user_mfo');

      -- перевірка цілісності файлу(MD5)
      if (l_transport_unit_type_row.checksum = 1 and
         file_utl.check_hash(p_request_data, p_hash)) or
         l_transport_unit_type_row.checksum = 2 then

        if l_transport_unit_type_row.base64 = 1 then
          l_transport_unit_row.request_data := file_utl.decode_base64(p_clob_in => p_request_data);
        else
          dbms_lob.createtemporary(lob_loc => l_transport_unit_row.request_data,
                                   cache   => true,
                                   dur     => dbms_lob.call);
          dbms_lob.converttoblob(dest_lob     => l_transport_unit_row.request_data,
                                 src_clob     => p_request_data,
                                 amount       => dbms_lob.lobmaxsize,
                                 dest_offset  => l_dest_offset,
                                 src_offset   => l_src_offset,
                                 blob_csid    => l_blob_csid,
                                 lang_context => l_lang_context,
                                 warning      => l_warning);
        end if;

        if l_transport_unit_type_row.compressed = 2 then
          l_transport_unit_row.request_data := utl_compress.lz_compress(l_transport_unit_row.request_data);
        end if;
        l_transport_unit_row.state_id       := transport_utl.trans_state_new;
        l_transport_unit_row.failures_count := 0;
      else
        p_state                             := 2;
        p_msg                               := 'Не співпадає контрольна сума файлу: ' ||
                                               p_ext_id;
        l_transport_unit_row.state_id       := transport_utl.trans_state_broken_file;
        l_transport_unit_row.failures_count := nvl(l_transport_unit_row.failures_count,
                                                   0) + 1;
        if l_transport_unit_row.failures_count >=
           transport_utl.marginal_tries_count then
          p_state := 2;
          p_msg   := 'Перевищена кількість невдалих спроб для файлу з ідентифікатором: ' ||
                     p_ext_id;
          return null;
        end if;
      end if;

      merge into transport_unit t
      using (select l_transport_unit_row.id id,
                    l_transport_unit_row.unit_type_id unit_type_id,
                    l_transport_unit_row.external_file_id external_file_id,
                    l_transport_unit_row.receiver_url receiver_url,
                    l_transport_unit_row.request_data request_data,
                    l_transport_unit_row.state_id state_id,
                    l_transport_unit_row.failures_count failures_count
               from dual) o
      on (t.id = o.id)
      when not matched then
        insert
          (t.id, t.unit_type_id, t.external_file_id, t.receiver_url,
           t.request_data, t.response_data, t.state_id, t.failures_count)
        values
          (o.id, o.unit_type_id, o.external_file_id, o.receiver_url,
           o.request_data, null, o.state_id, o.failures_count)
      when matched then
        update
           set t.state_id       = o.state_id,
               t.failures_count = o.failures_count;

      track_transport(l_transport_unit_row.id,
                      l_transport_unit_row.state_id,
                      null,
                      case l_transport_unit_row.state_id when
                      transport_utl.trans_state_broken_file then
                      'Original data:#' || utl_tcp.crlf || p_request_data ||
                      utl_tcp.crlf || '#Hash:#' || utl_tcp.crlf || p_hash else null end);
    end if;
    return l_transport_unit_row.id;
  exception
    when others then
      p_state := 1;
      p_msg   := 'Системна помилка: ' ||
                 substr(dbms_utility.format_error_stack() || chr(10) ||
                        dbms_utility.format_error_backtrace(),
                        1,
                        4000);
      return null;
  end;

  function create_transport_unit(p_unit_type_code in varchar2,
                                 p_ext_id         in varchar2,
                                 p_receiver_url   in varchar2,
                                 p_request_data   in clob,
                                 p_hash           in varchar2,
                                 p_state          out number,
                                 p_msg            out varchar2)
    return varchar2 is
    l_warning                 integer;
    l_dest_offset             integer := 1;
    l_src_offset              integer := 1;
    l_blob_csid               number := dbms_lob.default_csid;
    l_lang_context            number := dbms_lob.default_lang_ctx;
    l_unit_type_id            number;
    l_transport_unit_type_row transport_unit_type%rowtype;
    l_transport_unit_row      transport_unit%rowtype;
  begin
    p_state := 1;
    p_msg := 'OK';
    l_unit_type_id            := get_unit_type_id(p_unit_type_code);
	l_transport_unit_type_row := read_unit_type(l_unit_type_id);
    l_transport_unit_row      := is_file_existed(l_unit_type_id, p_ext_id);
    if l_transport_unit_row.state_id =
       transport_utl.trans_state_broken_file or
       l_transport_unit_row.state_id is null then
      if l_transport_unit_row.id is null then
        l_transport_unit_row.id := sys_guid;
      end if;

      l_transport_unit_row.unit_type_id     := l_unit_type_id;
      l_transport_unit_row.external_file_id := p_ext_id;
      l_transport_unit_row.receiver_url     := p_receiver_url;
      l_transport_unit_row.kf := sys_context('bars_context','user_mfo');

      -- перевірка цілісності файлу(MD5)
      if (l_transport_unit_type_row.checksum = 1 and
         file_utl.check_hash(p_request_data, p_hash)) or
         l_transport_unit_type_row.checksum = 2 then

        if l_transport_unit_type_row.base64 = 1 then
          l_transport_unit_row.request_data := file_utl.decode_base64(p_clob_in => p_request_data);
        else
          dbms_lob.createtemporary(lob_loc => l_transport_unit_row.request_data,
                                   cache   => true,
                                   dur     => dbms_lob.call);
          dbms_lob.converttoblob(dest_lob     => l_transport_unit_row.request_data,
                                 src_clob     => p_request_data,
                                 amount       => dbms_lob.lobmaxsize,
                                 dest_offset  => l_dest_offset,
                                 src_offset   => l_src_offset,
                                 blob_csid    => l_blob_csid,
                                 lang_context => l_lang_context,
                                 warning      => l_warning);
        end if;

        if l_transport_unit_type_row.compressed = 2 then
          l_transport_unit_row.request_data := utl_compress.lz_compress(l_transport_unit_row.request_data);
        end if;
        l_transport_unit_row.state_id       := transport_utl.trans_state_new;
        l_transport_unit_row.failures_count := 0;
      else
        p_state                             := 2;
        p_msg                               := 'Не співпадає контрольна сума файлу: ' ||
                                               p_ext_id;
        l_transport_unit_row.state_id       := transport_utl.trans_state_broken_file;
        l_transport_unit_row.failures_count := nvl(l_transport_unit_row.failures_count,
                                                   0) + 1;
        if l_transport_unit_row.failures_count >=
           transport_utl.marginal_tries_count then
          p_state := 2;
          p_msg   := 'Перевищена кількість невдалих спроб для файлу з ідентифікатором: ' ||
                     p_ext_id;
          return null;
        end if;
      end if;

      merge into transport_unit t
      using (select l_transport_unit_row.id id,
                    l_transport_unit_row.unit_type_id unit_type_id,
                    l_transport_unit_row.external_file_id external_file_id,
                    l_transport_unit_row.receiver_url receiver_url,
                    l_transport_unit_row.request_data request_data,
                    l_transport_unit_row.state_id state_id,
                    l_transport_unit_row.failures_count failures_count
               from dual) o
      on (t.id = o.id)
      when not matched then
        insert
          (t.id, t.unit_type_id, t.external_file_id, t.receiver_url,
           t.request_data, t.response_data, t.state_id, t.failures_count)
        values
          (o.id, o.unit_type_id, o.external_file_id, o.receiver_url,
           o.request_data, null, o.state_id, o.failures_count)
      when matched then
        update
           set t.state_id       = o.state_id,
               t.failures_count = o.failures_count;

      track_transport(l_transport_unit_row.id,
                      l_transport_unit_row.state_id,
                      null,
                      case l_transport_unit_row.state_id when
                      transport_utl.trans_state_broken_file then
                      'Original data:#' || utl_tcp.crlf || p_request_data ||
                      utl_tcp.crlf || '#Hash:#' || utl_tcp.crlf || p_hash else null end);
    end if;
    return l_transport_unit_row.id;
  exception
    when others then
      p_state := 1;
      p_msg   := 'Системна помилка: ' ||
                 substr(dbms_utility.format_error_stack() || chr(10) ||
                        dbms_utility.format_error_backtrace(),
                        1,
                        4000);
      return null;
  end;

  function create_transport_unit_sub(p_unit_type_code in varchar2,
                                     p_ext_id         in varchar2,
                                     p_receiver_url   in varchar2,
                                     p_request_data   in clob,
                                     p_hash           in varchar2,
                                     p_state          out number,
                                     p_msg            out varchar2)
    return varchar2 is
    l_warning                 integer;
    l_dest_offset             integer := 1;
    l_src_offset              integer := 1;
    l_blob_csid               number := dbms_lob.default_csid;
    l_lang_context            number := dbms_lob.default_lang_ctx;
    l_unit_type_id            number;
    l_transport_unit_type_row transport_unit_type%rowtype;
    l_transport_unit_row      transport_unit%rowtype;
  begin
    p_state := 0;
    p_msg := 'OK';
    l_unit_type_id            := get_unit_type_id(p_unit_type_code);
  	l_transport_unit_type_row := read_unit_type(l_unit_type_id);
    l_transport_unit_row      := is_file_existed(l_unit_type_id, p_ext_id);
    if l_transport_unit_row.id is not null then
      p_state := 2;
      p_msg   := 'З ідентифікатором '|| p_ext_id|| ' вже зареєстровано запит на обробку платежів (RequestId = '||l_transport_unit_row.id||')';
      return l_transport_unit_row.id;      
    end if;
    if l_transport_unit_row.state_id =
       transport_utl.trans_state_broken_file or
       l_transport_unit_row.state_id is null then
      if l_transport_unit_row.id is null then
        l_transport_unit_row.id := sys_guid;
      end if;

      l_transport_unit_row.unit_type_id     := l_unit_type_id;
      l_transport_unit_row.external_file_id := p_ext_id;
      l_transport_unit_row.receiver_url     := p_receiver_url;
      l_transport_unit_row.kf := sys_context('bars_context','user_mfo');

      -- перевірка цілісності файлу(MD5)
      if (l_transport_unit_type_row.checksum = 1 and
         file_utl.check_hash(p_request_data, p_hash)) or
         l_transport_unit_type_row.checksum = 2 then

        if l_transport_unit_type_row.base64 = 1 then
          l_transport_unit_row.request_data := file_utl.decode_base64(p_clob_in => p_request_data);
        else
          dbms_lob.createtemporary(lob_loc => l_transport_unit_row.request_data,
                                   cache   => true,
                                   dur     => dbms_lob.call);
          dbms_lob.converttoblob(dest_lob     => l_transport_unit_row.request_data,
                                 src_clob     => p_request_data,
                                 amount       => dbms_lob.lobmaxsize,
                                 dest_offset  => l_dest_offset,
                                 src_offset   => l_src_offset,
                                 blob_csid    => l_blob_csid,
                                 lang_context => l_lang_context,
                                 warning      => l_warning);
        end if;

        if l_transport_unit_type_row.compressed = 2 then
          l_transport_unit_row.request_data := utl_compress.lz_compress(l_transport_unit_row.request_data);
        end if;
        l_transport_unit_row.state_id       := transport_utl.trans_state_new;
        l_transport_unit_row.failures_count := 0;
      else
        p_state                             := 1;
        p_msg                               := 'Не співпадає контрольна сума файлу: ' ||
                                               p_ext_id;
        l_transport_unit_row.state_id       := transport_utl.trans_state_broken_file;
        l_transport_unit_row.failures_count := nvl(l_transport_unit_row.failures_count,
                                                   0) + 1;
        dbms_lob.createtemporary(lob_loc => l_transport_unit_row.request_data,
                                 cache   => true,
                                 dur     => dbms_lob.call);
        dbms_lob.converttoblob(dest_lob     => l_transport_unit_row.request_data,
                               src_clob     => p_request_data,
                               amount       => dbms_lob.lobmaxsize,
                               dest_offset  => l_dest_offset,
                               src_offset   => l_src_offset,
                               blob_csid    => l_blob_csid,
                               lang_context => l_lang_context,
                               warning      => l_warning);
      end if;

      merge into transport_unit t
      using (select l_transport_unit_row.id id,
                    l_transport_unit_row.unit_type_id unit_type_id,
                    l_transport_unit_row.external_file_id external_file_id,
                    l_transport_unit_row.receiver_url receiver_url,
                    l_transport_unit_row.request_data request_data,
                    l_transport_unit_row.state_id state_id,
                    l_transport_unit_row.failures_count failures_count
               from dual) o
      on (t.id = o.id)
      when not matched then
        insert
          (t.id, t.unit_type_id, t.external_file_id, t.receiver_url,
           t.request_data, t.response_data, t.state_id, t.failures_count)
        values
          (o.id, o.unit_type_id, o.external_file_id, o.receiver_url,
           o.request_data, null, o.state_id, o.failures_count)
      when matched then
        update
           set t.state_id       = o.state_id,
               t.failures_count = o.failures_count;

      track_transport(l_transport_unit_row.id,
                      l_transport_unit_row.state_id,
                      null,
                      case l_transport_unit_row.state_id when
                      transport_utl.trans_state_broken_file then
                      'Original data:#' || utl_tcp.crlf || p_request_data ||
                      utl_tcp.crlf || '#Hash:#' || utl_tcp.crlf || p_hash else null end);
    end if;
    return l_transport_unit_row.id;
  exception
    when others then
      p_state := 10;
      p_msg   := 'Системна помилка: ' ||
                 substr(dbms_utility.format_error_stack() || chr(10) ||
                        dbms_utility.format_error_backtrace(),
                        1,
                        4000);
      return null;
  end;

  procedure set_transport_state(p_id               in varchar2,
                                p_state_id         in integer,
                                p_tracking_comment in varchar2,
                                p_stack_trace      in clob) is
  begin

    update transport_unit t set t.state_id = p_state_id where t.id = p_id;

    track_transport(p_id, p_state_id, p_tracking_comment, p_stack_trace);
  end;

  procedure set_transport_failure(p_unit_row      in transport_unit%rowtype,
                                  p_error_message in varchar2,
                                  p_stack_trace   in clob) is
    l_failures_count integer;
  begin
    l_failures_count := nvl(p_unit_row.failures_count, 0) + 1;
    if (p_unit_row.failures_count >= marginal_tries_count) then
      set_transport_state(p_unit_row.id,
                          transport_utl.trans_state_failed,
                          p_error_message,
                          p_stack_trace);
    else
      update transport_unit t
         set t.failures_count = l_failures_count
       where t.id = p_unit_row.id;

      track_transport(p_unit_row.id,
                      transport_utl.trans_state_failed,
                      p_error_message,
                      p_stack_trace);
    end if;
  end;

  procedure set_transport_failure(p_id            in varchar2,
                                  p_error_message in varchar2,
                                  p_stack_trace   in clob) is
    l_failures_count integer;
    l_unit_row       transport_unit%rowtype;
  begin
    l_unit_row       := read_unit(p_id);
    l_failures_count := nvl(l_unit_row.failures_count, 0) + 1;
    if (l_unit_row.failures_count >= marginal_tries_count) then
      set_transport_state(l_unit_row.id,
                          transport_utl.trans_state_failed,
                          p_error_message,
                          p_stack_trace);
    else
      update transport_unit t
         set t.failures_count = l_failures_count
       where t.id = l_unit_row.id;

      track_transport(l_unit_row.id,
                      transport_utl.trans_state_failed,
                      p_error_message,
                      p_stack_trace);
    end if;
  end;

  function read_unit_type(p_transport_id in integer)
    return transport_unit_type%rowtype is
    l_transport_unit_type_row transport_unit_type%rowtype;
  begin
    select *
      into l_transport_unit_type_row
      from transport_unit_type t
     where t.id = p_transport_id;

    return l_transport_unit_type_row;
  exception
    when no_data_found then
      raise_application_error(-20000,
                              'Тип файлу з ідентифікатором {' ||
                              p_transport_id || '} не знайдений');
  end;

  function read_unit(p_unit_id in varchar2) return transport_unit%rowtype is
    l_transport_unit_row transport_unit%rowtype;
  begin
    select *
      into l_transport_unit_row
      from transport_unit t
     where t.id = p_unit_id;

    return l_transport_unit_row;
  exception
    when no_data_found then
      raise_application_error(-20000,
                              'Файл з ідентифікатором {' || p_unit_id ||
                              '} не знайдений');
  end;

  function get_unit_type_code(p_transport_id in integer) return varchar2 is
  begin
    return read_unit_type(p_transport_id).transport_type_code;
  end;

  function get_unit_state(p_unit_id in varchar2) return number is
    l_transport_unit_row transport_unit%rowtype;
  begin
    l_transport_unit_row := read_unit(p_unit_id);
    return l_transport_unit_row.state_id;
  end;

  procedure get_unit_state_xrm(p_unit_id in varchar2,
                               p_state   out number,
                               p_msg     out varchar2) is
    l_transport_unit_row transport_unit%rowtype;
  begin
    l_transport_unit_row := read_unit(p_unit_id);
    if l_transport_unit_row.state_id = transport_utl.trans_state_new or
       l_transport_unit_row.state_id in
       (transport_utl.trans_state_failed,
        transport_utl.trans_state_broken_file) and
       l_transport_unit_row.failures_count <
       transport_utl.marginal_tries_count then
      p_state := 0;
      p_msg   := 'В процесі';
    elsif l_transport_unit_row.state_id = transport_utl.trans_state_done then
      p_state := 1;
      p_msg   := 'Успішно оброблено';
    else
      p_state := 2;
      p_msg   := 'Помилка обробки';
    end if;
  end;

  function get_unit_resp(p_unit_id in varchar2) return blob is
    l_transport_unit_row transport_unit%rowtype;
  begin
    l_transport_unit_row := read_unit(p_unit_id);
    return l_transport_unit_row.response_data;
  end;

  -- повертає заархівовану квитанцію в base64
  function get_unit_respinbase64(p_unit_id in varchar2) return clob is
    l_transport_unit_row transport_unit%rowtype;
    l_clob               clob;
  begin
    l_transport_unit_row := read_unit(p_unit_id);
    l_clob               := file_utl.encode_base64(l_transport_unit_row.response_data);
    return l_clob;
  end;

  procedure save_response(p_id        varchar2,
                          p_resp_data blob) is
  begin
    update transport_unit t
       set t.response_data = p_resp_data
     where t.id = p_id;
  end;
end;
/
  show err;
 
  GRANT EXECUTE ON "BARSTRANS"."TRANSPORT_UTL" TO "BARS_ACCESS_DEFROLE";
  GRANT EXECUTE ON "BARSTRANS"."TRANSPORT_UTL" TO "BARS";

 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/transport_utl.sql =========*** End
 PROMPT ===================================================================================== 
 