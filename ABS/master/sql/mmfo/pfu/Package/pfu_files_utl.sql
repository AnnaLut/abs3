
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/PFU/package/pfu_files_utl.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE PFU.PFU_FILES_UTL is

  function BlobToClobUTF8(p_src blob) return clob;

  procedure parse_file(p_fileid in pfu_file.id%type);

  -- procedure parse_file_slow(p_fileid in integer);

  function get_record_buffer(p_id_rec in pfu_file_records.id%type)
    return varchar2;

  procedure sign_record_buffer(p_id_rec in pfu_file_records.id%type,
                               p_sign   in pfu_file_records.sign%type);

  function get_death_record_buffer(p_id_rec in pfu_death_record.id%type)
    return varchar2;

  procedure sign_death_record_buffer(p_id_rec in pfu_death_record.id%type,
                                     p_sign in pfu_death_record.sign%type);

  procedure set_envelope_sign_failure(p_request_id    in integer,
                                      p_error_message in varchar2,
                                      p_error_stack   in varchar2);

  procedure set_envelope_process_failure(p_request_id    in integer,
                                         p_error_message in varchar2,
                                         p_error_stack   in varchar2);

  procedure set_envelope_parsed(p_request_id    in integer);

  procedure set_env_state_for_pay(p_env_id in integer);

  procedure set_file_state_for_pay(p_file_id in integer);

  procedure set_rec_unerror(p_rec_id in integer);
  
  procedure set_death_state_send_match(p_death_id in integer);
  procedure check_set_file_state_payed(p_file_id in integer);
  
/*  procedure set_death_debet_ref(p_recid in pfu_death_record.id%type,
                                  p_ref_debet in pfu_death_record.ref_debet%type);*/
  
  procedure set_file_record_state(p_file_rec_id in integer,
                                    p_state       in varchar2);

  procedure checking_record(p_rec         in out pfu.pfu_file_records%rowtype,
                              p_err_code    in out number,
                              p_err_message in out varchar2);

  procedure checking_record2(p_file_id in pfu_file.id%type);

  procedure set_file_state_checking_pay(p_file_id in integer, p_doc_ref in number);

  procedure form_parse_receipt(p_id_request pfu_envelope_request.id%type);

  procedure r_checkstate_procesing(p_file_data in clob,
                                   p_file_id   in number);

  procedure r_checkbackstate_procesing(p_file_data in clob,
                                         p_file_id   in number);

  procedure r_get_report_procesing(p_file_data in clob,
                                   p_file_id   in number,
                                   p_mfo       in varchar2);

  procedure r_getebp_procesing(p_file_data in clob,
                               p_file_id   in number);

  procedure r_create_paym_procesing(p_file_data in clob,
                                    p_file_id   in number);

  procedure r_getcardkill_procesing(p_file_data in clob,
                                    p_file_id   in number);

  procedure r_getacc_rest_procesing(p_file_data in clob,
                                      p_file_id   in number);

  procedure r_branch_procesing(p_file_data in clob,
                                      p_file_id   in number);
end;
/
CREATE OR REPLACE PACKAGE BODY PFU.PFU_FILES_UTL as

  function blobtoclobutf8(p_src blob) return clob is
    l_result  clob;
    l_len     integer := dbms_lob.lobmaxsize;
    l_srcoffs integer := 1;
    l_dstoffs integer := 1;
    l_csid    integer := nls_charset_id('ru8pc866'); -- dbms_lob.default_csid;
    l_lang    integer := dbms_lob.default_lang_ctx;
    l_warn    integer;
  begin
    if not ((p_src is null) or (dbms_lob.getlength(p_src) = 0)) then
      dbms_lob.createtemporary(l_result, true);
      dbms_lob.converttoclob(l_result,
                             p_src,
                             l_len,
                             l_srcoffs,
                             l_dstoffs,
                             l_csid,
                             l_lang,
                             l_warn);
    else
      l_result := null;
    end if;
    return(l_result);
  end blobtoclobutf8;

  function pib(p_str in varchar2, p_pos in integer) return varchar2
    is
  l_str varchar2(4000);
  begin
    l_str := regexp_substr(p_str, '\S+', 1, p_pos);
    return l_str;
  end;

  /*
  procedure parse_file_slow(p_fileid in integer) is
    l_fileb blob;
    l_filec clob;

    c pls_integer;

    l_row pfu_file_records%rowtype;
  begin
    begin
      select file_data into l_fileb from pfu_file where id = p_fileid;
    exception
      when no_data_found then
        return;
    end;

    l_row.file_id := p_fileid;

    l_filec := BlobToClobUTF8(l_fileb);

    --c:=instr(cc,chr(10));
    --len:= dbms_lob.getlength(cc);

    FOR rec IN (
                -- повільно
                  WITH clob_table(c) as
                   (SELECT l_filec as c FROM DUAL)
                  SELECT regexp_substr(c, '.+', 1, level) text, level line
                    FROM clob_table
                  CONNECT BY LEVEL <= regexp_count(c, '.+')) LOOP
      -- розбор рядка
      -- rec.line = 1 заголовок
      if rec.line != 1 then
        l_row.id        := PFU_flines_SEQ.nextval;
        l_row.rec_id    := rec.line;
        l_row.num_acc   := substr(rec.text, 1, 19);
        l_row.num_filia := substr(rec.text, 20, 5);
        l_row.code_vkl  := substr(rec.text, 25, 3);
        l_row.sum_pay   := to_number(substr(rec.text, 28, 19));
        l_row.full_name := substr(rec.text, 47, 100);
        l_row.numident  := substr(rec.text, 147, 10);
        l_row.date_enr  := substr(rec.text, 157, 2);
        l_row.state     := 0;
        l_row.sys_date  := sysdate;
        l_row.full_rec  := rec.text;

        -- save
        insert into pfu_file_records values l_row;
      end if;
      --dbms_output.put_line(to_char(sysdate,'mi:ss')||' #'||rec.line||' '||replace(replace(rec.text,chr(10),''),chr(13),''));
    END LOOP;

  end parse_file_slow;
  */

    procedure checking_record(p_rec         in out pfu.pfu_file_records%rowtype,
                              p_err_code    in out number,
                              p_err_message in out varchar2) is
      err_record exception;
      l_err_code          number;
      l_err_message       varchar2(1024);
      l_count_doc_id      number;
      l_total_debt_amount number;
      l_pensioner_row     pfu_pensioner%rowtype;
      l_pensacc_row       pfu_pensacc%rowtype;
      l_c_pens            pls_integer;
    begin
      -- наявність пенсіонера
      select count(1) into l_c_pens from pfu_pensioner p
       where p.okpo = p_rec.numident and p.kf   = p_rec.mfo and p.date_off is null;
      if (p_rec.numident is not null) then
        if (l_c_pens = 0) then
           l_err_code    := 5;
           l_err_message := 'Пенсіонера не знайдено по ОКПО';
           raise err_record;
        end if;
      end if;

      -- наявність рахунку
      begin
        select * into l_pensacc_row from pfu_pensacc pa
         where pa.nls = p_rec.num_acc and pa.kf = p_rec.mfo /*and pa.kv = 980*/;
      exception
        when no_data_found then
          l_err_code    := 9;
          l_err_message := 'Рахунок не знайдено';
          raise err_record;
      end;

      -- рахунок закритий
      if l_pensacc_row.dazs is not null then
        l_err_code    := 3;
        l_err_message := 'Рахунок закритий';
        raise err_record;
      end if;

      -- наявність пенсіонера (по рахунку)
      begin
        select * into l_pensioner_row from pfu_pensioner p
         where p.rnk= l_pensacc_row.rnk and p.kf = l_pensacc_row.kf;
      exception
        when no_data_found then
          l_err_code    := 8;
          l_err_message := 'Пенсіонера не знайдено (по рахунку)';
          raise err_record;
      end;

      -- Пенсіонер блокований
      if l_pensioner_row.block_type is not null then
        l_err_code    := 4;
        l_err_message := 'Пенсіонер блокований';
        raise err_record;
      end if;

      -- невідповідність ОКПО
      if l_pensioner_row.okpo != p_rec.numident then
        l_err_code    := 1;
        l_err_message := 'Рахунок не відповідає по ОКПО';
        raise err_record;
      end if;

      -- невідповідність ПІБ
      -- або utl_match.jaro_winkler_similarity
      if utl_match.edit_distance_similarity(UPPER(l_pensioner_row.nmk),UPPER(p_rec.full_name)) < 80 then
--      if utl_match.edit_distance_similarity(l_pensioner_row.nmk,p_rec.full_name) < 80 then
        l_err_code    := 2;
        l_err_message := 'Рахунок не відповідає по ПІБ';
        raise err_record;
      end if;

      p_err_code    := 0;
      p_err_message := '';
      p_rec.ebp_nmk := l_pensioner_row.nmk;
      
      update pfu_pensacc pa 
         set pa.ispayed = 1 
       where pa.kf = p_rec.mfo
         and pa.nls = p_rec.num_acc
         and pa.ispayed is null;
      
    exception
      when err_record then
        p_err_code    := l_err_code;
        p_err_message := l_err_message;
        --set_tax_sum_process_result(p_rec_taxsums.rec_id, p_err_code, p_err_message);
      when others then
        p_err_code    := 90; -- Системна помилка
        p_err_message := sqlerrm;
        --set_tax_sum_process_result(p_rec_taxsums.rec_id, p_err_code, p_err_message);
    end;

  procedure checking_record2(p_file_id in pfu_file.id%type) is
    l_dazs date;
    l_ebp_state integer;
    begin
      for rec_frec in (select *
                         from pfu_file_records pfr
                        where pfr.file_id = p_file_id
                          and pfr.state = 0) loop
         begin
            select pp.dazs into l_dazs
              from pfu_pensacc pp
             where pp.nls = ltrim(rec_frec.num_acc, 0)
               and pp.kf = rec_frec.mfo;
            if l_dazs is not null then
               update pfu_file_records pfr
                  set pfr.state = 3
                where pfr.id = rec_frec.id;
            end if;
            exception
               when no_data_found then
                 null;
         end;

         begin
            select pp.block_type into l_ebp_state
              from pfu_pensioner pp
             where pp.okpo = rec_frec.numident
               and pp.kf = rec_frec.mfo
               and pp.rnk = (select pa.rnk from pfu_pensacc pa where pa.nls = rec_frec.num_acc and pa.kf = rec_frec.mfo)
               and pp.date_off is null;
            if l_ebp_state is not null then
               update pfu_file_records pfr
                  set pfr.state = case l_ebp_state when 4 then 14
                                                   when 5 then 15
                                                   when 6 then 16
                                                   end
                where pfr.id = rec_frec.id;
            end if;
            exception
               when no_data_found then
                  null;
         end;
      end loop;

  end;

  procedure parse_file(p_fileid in pfu_file.id%type) is
    l_fileb blob;
    l_filec clob;

    l_offset  number := 1;
    l_amount  number := 32767;
    l_flen    number;
    l_buffer  varchar2(32767);
    l_numline pls_integer := 0;

    l_row          pfu_file_records%rowtype;
    l_envelope_row pfu_envelope_request%rowtype;
    l_file_row     pfu_file%rowtype;

    --l_pfu_envelope_id pfu_file.envelope_request_id%type;
    --l_file_number pfu_file.file_number%type;
  begin

    begin
      select * into l_file_row from pfu_file where id = p_fileid;
    exception
      when no_data_found then
        return;
    end;

    begin
      select *
        into l_envelope_row
        from pfu_envelope_request
       where id = l_file_row.envelope_request_id;
    exception
      when no_data_found then
        return;
    end;

    l_filec := BlobToClobUTF8(l_file_row.file_data);

    l_flen := dbms_lob.getlength(l_filec);

    -- dbms_output.put_line(l_flen);

    if (dbms_lob.isopen(l_filec) != 1) then
      dbms_lob.open(l_filec, 0);
    end if;

    --l_amount := instr(l_filec, CHR(10)||CHR(13), l_offset);

    while (l_offset < l_flen) loop
      begin

        l_row := null;

        l_row.file_id         := p_fileid;
        l_row.pfu_envelope_id := l_envelope_row.pfu_envelope_id;
        l_row.mfo             := ltrim(l_envelope_row.receiver_mfo,0);
        l_row.file_number     := l_file_row.file_number;
        l_row.payment_date    := l_file_row.payment_date;
        l_row.state           := 0;

        -- if no more newlines are found, read till end of clob
        if (instr(l_filec, chr(10), l_offset) = 0) then
          l_amount := l_flen - l_offset + 1;
        else
          l_amount := instr(l_filec, chr(10), l_offset) - l_offset;
        end if;

        -- dbms_output.put_line(l_amount);

        -- this is to catch empty lines, otherwise we get a null error
        if (l_amount = 0) then
          l_buffer := '';
        else
          dbms_lob.read(l_filec, l_amount, l_offset, l_buffer);
          -- розбор рядка
          -- rec.line = 0 заголовок
          if l_numline != 0 then
            l_row.id      := pfu_flines_seq.nextval;
            l_row.rec_id  := l_numline;

            l_row.sys_date  := sysdate;
            l_row.full_rec := l_buffer;
            -- номер рахунку
            l_row.num_acc := trim(ltrim(replace(substr(l_buffer, 1, 19), chr(9), ''), '0')); -- викусити таб, викусити ведучі 0
            /*
            l_row.num_acc := to_number(replace(substr(l_buffer, 1, 19),
                                                 chr(9),'')); -- викусимо таб
              exception when others
                        then l_row.num_acc := null;
                             l_row.state   := -1;
            end;
            */
            l_row.num_filia := substr(l_buffer, 20, 5);
            l_row.code_vkl  := substr(l_buffer, 25, 3);
            l_row.sum_pay   := to_number(substr(l_buffer, 28, 19));
            l_row.full_name := REGEXP_REPLACE(trim(substr(translate(l_buffer,'Ў°Ї','ІЇЄ'), 47, 100)),'  *', ' ');
            l_row.numident  := substr(l_buffer, 147, 10);
            l_row.date_enr  := substr(l_buffer, 157, 2);
            --l_row.state          := 0;
            l_row.sign           := null;
            l_row.err_message    := null;
            l_row.err_mess_trace := null;

            -- validate
            checking_record(l_row, l_row.state, l_row.err_mess_trace);
            -- save
            insert into pfu_file_records values l_row;
          end if;
        end if;
      exception
        when others then
          l_row.err_message    := 'PARSE_ERROR';
          l_row.err_mess_trace := substr(' Error: ' ||
                                         dbms_utility.format_error_stack() ||
                                         chr(10) ||
                                         dbms_utility.format_error_backtrace(),
                                         1,
                                         1000);
          l_row.state          := -1;
          -- save row with error
          insert into pfu_file_records values l_row;

      end;

      l_offset  := l_offset + l_amount + 1;
      l_numline := l_numline + 1;

    end loop;

    if (dbms_lob.isopen(l_filec) = 1) then
      dbms_lob.close(l_filec);
    end if;

  end parse_file;

  function get_record_buffer(p_id_rec in pfu_file_records.id%type) return varchar2 is
    l_buffer varchar2(32000);
  begin
    select mfo || to_char(payment_date, 'DD.MM.YYYY') || num_acc ||
           num_filia || code_vkl || to_char(sum_pay) || full_name ||
           numident || date_enr || full_rec
      into l_buffer
      from pfu_file_records
     where id = p_id_rec;

    return l_buffer;
  end;

  procedure sign_record_buffer(p_id_rec in pfu_file_records.id%type, p_sign in pfu_file_records.sign%type) is

  begin
    update pfu_file_records r
       set r.sign = p_sign
     where r.id   = p_id_rec;
  end;

  function get_death_record_buffer(p_id_rec in pfu_death_record.id%type) return varchar2 is
    l_buffer varchar2(32000);
  begin
    select d.bank_mfo || to_char(d.date_dead, 'DD.MM.YYYY') || d.num_acc ||
           d.bank_num || d.death_akt || to_char(d.sum_over) || d.last_name||' '||d.last_name||' '||d.father_name||
           d.okpo || d.date_akt || d.pfu_num
      into l_buffer
      from pfu_death_record d
     where id = p_id_rec;

    return l_buffer;
  end;

  procedure sign_death_record_buffer(p_id_rec in pfu_death_record.id%type, p_sign in pfu_death_record.sign%type) is

  begin
    update pfu_file_records r
       set r.sign = p_sign
     where r.id   = p_id_rec;
  end;

  function read_pensioner(
        p_pensioner_okpo in pfu_pensioner.okpo%type,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return pfu_pensioner%rowtype
    is
        l_pensioner_row pfu_pensioner%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_pensioner_row
            from   pfu_pensioner p
            where  p.okpo = p_pensioner_okpo
            for update;
        else
            select *
            into   l_pensioner_row
            from   pfu_pensioner p
            where  p.okpo = p_pensioner_okpo;
        end if;

        return l_pensioner_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20001, 'Клієнт з ідентифікатором {' || p_pensioner_okpo || '} не знайдений');
             else return null;
             end if;
    end;

    procedure set_envelope_sign_failure(
        p_request_id in integer,
        p_error_message in varchar2,
        p_error_stack in varchar2)
    is
    begin
        update pfu_envelope_request
           set state = pfu_utl.ENV_STATE_ERROR_SIGN
         where id = p_request_id;
    end;

    procedure set_envelope_process_failure(
        p_request_id in integer,
        p_error_message in varchar2,
        p_error_stack in varchar2)
    is
    begin
        update pfu_envelope_request
           set state = pfu_utl.ENV_STATE_ERROR_PARSE
         where id = p_request_id;
    end;

    procedure set_env_state_for_pay(p_env_id in integer)
      is
    begin
       update pfu_file_records pfr
          set pfr.state = 19
        where pfr.pfu_envelope_id = p_env_id
          and pfr.state = 0;
        commit;
    end;

    procedure set_file_state_for_pay(p_file_id in integer)
      is
    begin
       update pfu_file_records pfr
          set pfr.state = 19
        where pfr.file_id = p_file_id
          and pfr.state = 0;
       update pfu_file set state='IN_PAY' where id=p_file_id;
       commit;
    end;
    
    procedure check_set_file_state_payed(p_file_id in integer)
      is
      l_cnt number;
    begin
       select count(*)
         into l_cnt
         from pfu_file_records pfr
        where pfr.file_id = p_file_id
          and pfr.state in (19,0,20); 
       
       if (l_cnt = 0) then
           update pfu_file pf
              set pf.state = 'PAYED'
            where pf.id = p_file_id;
       end if;
       commit;
    end;
    
    procedure set_file_record_state(p_file_rec_id in integer,
                                    p_state       in varchar2)
      is
    begin
       update pfu_file_records fr 
          set fr.state = Case when p_state = 'Зараховано' then 10
                              when p_state = 'Повернуто ПФУ' then 99 end
        where fr.id = p_file_rec_id;
       commit;
    end;

    procedure set_file_state_checking_pay(p_file_id in integer, p_doc_ref in number)
      is
    begin
       update pfu_file set state='CHECKING_PAY' where id=p_file_id;
       commit;
    end;

    procedure set_rec_unerror(p_rec_id in integer)
      is
    begin
       update pfu_file_records set state = 0 where id=p_rec_id;
       commit;
    end;
    
    procedure set_death_state_send_match(p_death_id in integer)
      is
    begin
      update pfu_death d
         set d.state = 'MATCH_SEND'
       where d.id = p_death_id;
      commit;
    end;

    procedure set_envelope_parsed(
        p_request_id in integer)
    is
    begin
        update pfu_envelope_request
           set state = pfu_utl.ENV_STATE_PARSED
         where id = p_request_id;
        update pfu_file pf
           set pf.state = 'CHECKED'
         where pf.envelope_request_id = p_request_id;
    end;

   procedure form_parse_receipt(p_id_request pfu_envelope_request.id%type) is
     l_row_xml clob;
     l_xml     clob;
     l_ln      varchar2(100);
     l_nm      varchar2(100);
     l_ftn     varchar2(100);
     l_env_row pfu_envelope_request%rowtype;
   begin
     -- заголовок
     --l_xml         := '<?xml version="1.0" encoding="utf-8"?><declar>';

     select * into l_env_row from pfu_envelope_request where id = p_id_request;

     select xmlelement("declarhead", xmlelement("date_time", to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss')), xmlelement("res_file", 0))
            .getclobval()
       into l_row_xml
       from dual;

     l_xml := l_xml || l_row_xml;
     -- тіло
     l_xml := l_xml || '<declarbody>';

     for c0 in (select fr.id,
                       fr.rec_id,
                       f.file_number as num_list,
                       fr.full_name,
                       fr.numident,
                       fr.num_acc,
                       fr.state as result
                --fd.state as result
                  from pfu_file_records fr, pfu_file f
                 where f.id = fr.file_id
                   and f.envelope_request_id = p_id_request
                --and rownum< 100
                 order by f.file_number, fr.rec_id) loop

           l_ln := pib(c0.full_name, 1);
           l_nm := pib(c0.full_name, 2);
           l_ftn:= pib(c0.full_name, 3);

       select XMLELEMENT("row",
                         XMLELEMENT("rownum", c0.rec_id),
                         XMLFOREST(c0.num_list as num_list,
                                   convert(l_ln, 'utf8') as ln,
                                   convert(l_nm, 'utf8') as nm,
                                   convert(l_ftn, 'utf8') as ftn,
                                   c0.numident as numident,
                                   c0.num_acc as num_acc,
                                   c0.result as result))
              .getclobval()
         into l_row_xml
         from dual;

       l_xml := l_xml || l_row_xml;
     end loop;

     -- Закрываем общий xml
     l_xml := l_xml || '</declarbody></declar>';

     insert into pfu_envelope_receipt (id, pfu_envelope_id, receipt_data) values (p_id_request, l_env_row.pfu_envelope_id, l_xml);
   end;

   procedure r_checkstate_procesing(p_file_data in clob,
                                    p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_ref      number;
      l_state    number;
      l_cnt      number;
      l_cnt2     number;
      l_fileid   pfu_file_records.file_id%type;
      l_idr      pfu_file_records.id%type;
      l_mfo      pfu_syncru_params.kf%type;
      l_arr_fileid   number_list := number_list();
      l_i            number;
    begin

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      select t.kf
        into l_mfo
        from transport_unit t
       where t.id = p_file_id;

      select count(*) into l_cnt2
        from bars.mv_kf s
       where s.kf = l_mfo;

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
      loop

        l_row     := dbms_xmldom.item(l_rows, i);
        l_ref     := to_number(dbms_xslprocessor.valueof(l_row, 'ref/text()'));
        l_state   := to_number(dbms_xslprocessor.valueof(l_row, 'state_id/text()'));
        l_idr     := to_number(dbms_xslprocessor.valueof(l_row, 'idr/text()'));

        update pfu_file_records pfr
           set pfr.state = case when l_state != 0
                                then 99
                                when l_state = 0  -- платеж закрыт
                                then 10
                                else pfr.state
                                end,
               pfr.date_pay = sysdate
         where pfr.id = l_idr
         returning pfr.file_id into l_fileid;

         if l_fileid not member of l_arr_fileid then
           l_arr_fileid.extend;
           l_arr_fileid(l_arr_fileid.last) := l_fileid;
         end if;
      end loop;

         -- если все проставляем для файла статус оплачен

      update pfu_file pf
         set pf.state = 'PAYED',
             pf.pay_date = sysdate
       where pf.id in (select column_value
                         from table(l_arr_fileid))
         and not exists (select 1
                           from pfu_file_records pfr
                          where pfr.file_id = pf.id
                            and pfr.state = 20);
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.trans_state_done,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => dbms_utility.format_error_backtrace());

    end;

    procedure r_checkbackstate_procesing(p_file_data in clob,
                                         p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_ref      number;
      l_state    number;
      l_cnt      number;
      l_fileid   pfu_file_records.file_id%type; 
    begin

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
      loop

        l_row     := dbms_xmldom.item(l_rows, i);
        l_ref     := to_number(dbms_xslprocessor.valueof(l_row, 'ref/text()'));
        l_state   := to_number(dbms_xslprocessor.valueof(l_row, 'state_id/text()'));

        update pfu_death_record dr
           set dr.state = case when l_state != 0
                               then 'ERR_PAY'
                               when l_state = 0  -- платеж закрыт
                               then 'PAYED'
                               end,
               dr.date_pay = sysdate
         where dr.ref = l_ref
         returning dr.list_id into l_fileid;

      end loop;
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.trans_state_done,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => dbms_utility.format_error_backtrace());

    end;

    procedure r_create_paym_procesing(p_file_data in clob,
                                      p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;

      l_ref      pfu_death_record.ref%type;
      l_sum      pfu_death_record.sum_payed%type;
      l_typ      varchar2(30);
      l_did      pfu_death_record.id%type;
    begin
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);
      
      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

      l_row := dbms_xmldom.item(l_rows, 0);

      l_ref   := to_number(dbms_xslprocessor.valueof(l_row, 'ref/text()'));
      l_sum   := to_number(dbms_xslprocessor.valueof(l_row, 'sum/text()'));
      l_typ   := dbms_xslprocessor.valueof(l_row, 'typ/text()');
      l_did   := to_number(dbms_xslprocessor.valueof(l_row, 'did/text()'));

      update pfu_death_record dr
         set dr.sum_pay = l_sum,
             dr.ref = l_ref,
             dr.typ = l_typ,
             dr.state = 'IN_PAY'
       where dr.id = l_did;
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.trans_state_done,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => dbms_utility.format_error_backtrace());
    end;

    procedure r_getebp_procesing(p_file_data in clob,
                                 p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_rnk            number;
      l_kf             number;
      l_branchpens     varchar2(4000);
      l_nmk            varchar2(4000);
      l_okpo           varchar2(4000);
      l_adr            varchar2(4000);
      l_date_on        date;
      l_date_off       date;
      l_passp          number;
      l_ser            varchar2(4000);
      l_numdoc         varchar2(4000);
      l_pdate          date;
      l_organ          varchar2(4000);
      l_bday           date;
      l_bplace         varchar2(4000);
      l_cellphone      varchar2(20);
      l_last_ru_idupd  number;

      l_branchacc      varchar2(4000);
      l_acc            number;
      l_nls            number;
      l_kv             number;
      l_ob22           varchar2(20);
      l_daos           date;
      l_dapp           date;
      l_dazs           date;
      l_last_acc_idupd number;

      l_res            number;

    begin

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
      loop

         l_row            := dbms_xmldom.item(l_rows, i);
         l_rnk            := to_number(dbms_xslprocessor.valueof(l_row, 'rnk/text()'));
         l_kf             := dbms_xslprocessor.valueof(l_row, 'kf/text()');
         l_branchpens     := dbms_xslprocessor.valueof(l_row, 'branchpens/text()');
         l_nmk            := utl_raw.cast_to_varchar2(hextoraw(dbms_xslprocessor.valueof(l_row, 'nmk/text()')));
         l_okpo           := dbms_xslprocessor.valueof(l_row, 'okpo/text()');
         l_adr            := utl_raw.cast_to_varchar2(hextoraw(dbms_xslprocessor.valueof(l_row, 'adr/text()')));
         l_date_on        := to_date(dbms_xslprocessor.valueof(l_row, 'date_on/text()'),'dd.mm.yyyy');
         l_date_off       := to_date(dbms_xslprocessor.valueof(l_row, 'date_off/text()'),'dd.mm.yyyy');
         l_passp          := nvl(to_number(dbms_xslprocessor.valueof(l_row, 'passp/text()')),1);
         l_ser            := dbms_xslprocessor.valueof(l_row, 'ser/text()');
         l_numdoc         := dbms_xslprocessor.valueof(l_row, 'numdoc/text()');
         l_pdate          := to_date(dbms_xslprocessor.valueof(l_row, 'pdate/text()'),'dd.mm.yyyy');
         l_organ 		  := substr(trim(utl_raw.cast_to_varchar2(hextoraw(dbms_xslprocessor.valueof(l_row, 'organ/text()')))),1,70);
         l_bday           := to_date(dbms_xslprocessor.valueof(l_row, 'bday/text()'),'dd.mm.yyyy');
         l_bplace         := utl_raw.cast_to_varchar2(hextoraw(dbms_xslprocessor.valueof(l_row, 'bplace/text()')));
         l_cellphone      := dbms_xslprocessor.valueof(l_row, 'cellphone/text()');
         l_last_ru_idupd  := to_number(dbms_xslprocessor.valueof(l_row, 'last_ebp_idupd/text()'));

         --acc attr
         l_acc            := to_number(dbms_xslprocessor.valueof(l_row, 'acc/text()'));
         l_nls            := dbms_xslprocessor.valueof(l_row, 'nls/text()');
         l_branchacc      := dbms_xslprocessor.valueof(l_row, 'branchacc/text()');
         l_kv             := to_number(dbms_xslprocessor.valueof(l_row, 'kv/text()'));
         l_ob22           := dbms_xslprocessor.valueof(l_row, 'ob22/text()');
         l_daos           := to_date(dbms_xslprocessor.valueof(l_row, 'daos/text()'),'dd.mm.yyyy');
         l_dapp           := to_date(dbms_xslprocessor.valueof(l_row, 'dapp/text()'),'dd.mm.yyyy');
         l_dazs           := to_date(dbms_xslprocessor.valueof(l_row, 'dazs/text()'),'dd.mm.yyyy');
         l_last_acc_idupd := to_number(dbms_xslprocessor.valueof(l_row, 'last_acc_idupd/text()'));

         pfu_sync_ru.save_pensioner_data(l_kf,
                                         l_branchpens,
                                         l_rnk,
                                         l_nmk,
                                         nvl(l_okpo,'000000000'),
                                         l_adr,
                                         l_date_on,
                                         l_date_off,
                                         l_passp,
                                         l_ser,
                                         l_numdoc,
                                         l_pdate,
                                         l_organ,
                                         l_bday,
                                         l_bplace,
                                         l_cellphone,
                                         l_last_ru_idupd,
                                         sysdate,
                                         l_res);

         pfu_sync_ru.save_pensacc_data(l_kf,
                                       l_branchacc,
                                       l_rnk,
                                       l_acc,
                                       l_nls,
                                       l_kv,
                                       l_ob22,
                                       l_daos,
                                       l_dapp,
                                       l_dazs,
                                       l_last_acc_idupd,
                                       sysdate,l_res);

      end loop;
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.trans_state_done,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => dbms_utility.format_error_backtrace());

    end;

    procedure r_getcardkill_procesing(p_file_data in clob,
                                    p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_epp_number   varchar2(20);
      l_kill_type    number;
      l_kill_date    date;
      l_cnt          number;
      l_mfo          pfu_epp_line.bank_mfo%type;
    begin

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
      loop

         l_row            := dbms_xmldom.item(l_rows, i);
         l_epp_number     := dbms_xslprocessor.valueof(l_row, 'epp_number/text()');
         l_kill_type      := to_number(dbms_xslprocessor.valueof(l_row, 'kill_type/text()'));
         l_kill_date      := to_date(dbms_xslprocessor.valueof(l_row, 'kill_date/text()'),'dd.mm.yyyy');

         select count(*)
           into l_cnt
           from pfu_epp_killed el
          where el.epp_number = l_epp_number;

         if (l_cnt = 0) then
             insert into pfu_epp_killed(epp_number,
                                        kill_type,
                                        kill_date)
             values(l_epp_number,
                    l_kill_type,
                    l_kill_date);

             update pfu_epp_line t
                set t.state_id = 19,
                    t.destruction_date = l_kill_date
              where t.epp_number = l_epp_number;
         end if;
         select el.bank_mfo
           into l_mfo
           from pfu_epp_line el
          where el.epp_number = l_epp_number;
         pfu_service_utl.prepare_set_destruct(l_epp_number, l_mfo);

      end loop;
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.trans_state_done,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => dbms_utility.format_error_backtrace());

    end;

    procedure r_get_report_procesing(p_file_data in clob,
                                     p_file_id   in number,
                                     p_mfo       in varchar2) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_num_acc  varchar2(20);
      l_datet    date;
      l_mfo      varchar2(10);
      l_rnk      number;
      l_okpo     varchar2(15);
      l_fileid   number;
      l_fullname    varchar2(300);
      l_last_name   varchar2(100);
      l_name        varchar2(100);
      l_father_name varchar2(100);
      l_sernum      varchar2(20);
      l_ispayed     number;

    begin

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);
      
      begin 
           select tl.id 
             into l_fileid
             from pfu_no_turnover_list tl
            where substr(to_char(tl.date_create, 'dd.mm.yyyy'), 4, 2) = substr(to_char(sysdate, 'dd.mm.yyyy'), 4, 2)
              and tl.kf = p_mfo;
         exception 
           when NO_DATA_FOUND 
              then 
                l_fileid := pfu_no_turnover_list_seq.nextval;
                insert into pfu_no_turnover_list(id, 
                                                 id_request, 
                                                 date_create, 
                                                 date_sent, 
                                                 full_lines, 
                                                 user_id, 
                                                 state,
                                                 kf)
                values (l_fileid, 
                        null, 
                        sysdate, 
                        null, 
                        null, 
                        null, 
                        'NEW',
                        p_mfo);
      end;

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
      loop

         l_row          := dbms_xmldom.item(l_rows, i);
         l_num_acc      := dbms_xslprocessor.valueof(l_row, 'acc_num/text()');
         l_rnk          := to_number(dbms_xslprocessor.valueof(l_row, 'rkn/text()'));
         l_mfo          := dbms_xslprocessor.valueof(l_row, 'mfo/text()');
         l_datet        := to_date(dbms_xslprocessor.valueof(l_row, 'date_turn/text()'),'dd.mm.yyyy');
         
         select p.nmk, p.okpo, p.ser||' '||p.numdoc
           into l_fullname, l_okpo, l_sernum 
           from pfu_pensioner p
          where p.rnk = l_rnk
            and p.kf = l_mfo;
            
         select p.ispayed 
           into l_ispayed
           from pfu_pensacc p
          where p.nls = l_num_acc
            and p.kf = l_mfo;
          
         pfu_service_utl.parse_fio(l_fullname, l_last_name, l_name, l_father_name);
         
         if (l_ispayed = 1) then
             insert into pfu_no_turnover(id,
                                         id_file,
                                         last_name,
                                         name,
                                         father_name,
                                         okpo,
                                         ser_num,
                                         num_acc,
                                         kf,
                                         date_last)
             values(pfu_no_turnover_seq.nextval,
                    l_fileid,
                    l_last_name, 
                    l_name, 
                    l_father_name,
                    l_okpo,
                    l_sernum,
                    l_num_acc,
                    l_mfo,
                    l_datet);
         end if;
         
      end loop;
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.trans_state_done,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => dbms_utility.format_error_backtrace());

    end;

    procedure r_branch_procesing(p_file_data in clob,
                                      p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_branch   varchar2(30);
      l_name     varchar2(70);
      l_eppwork  number(1);
      l_dateon   date;
      l_dateoff  date;
    begin

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
      loop

         l_row      := dbms_xmldom.item(l_rows, i);
         l_branch   := dbms_xslprocessor.valueof(l_row, 'branch/text()');
         l_name     := dbms_xslprocessor.valueof(l_row, 'name/text()');
         l_eppwork  := to_number(dbms_xslprocessor.valueof(l_row, 'val/text()'));
         l_dateon   := to_date(dbms_xslprocessor.valueof(l_row, 'date_opened/text()'), 'dd.mm.yyyy');
         l_dateoff  := to_date(dbms_xslprocessor.valueof(l_row, 'date_closed/text()'), 'dd.mm.yyyy');

         merge into pfu_epp_branch eb
         using  dual ON (eb.branch = l_branch)
         when matched then
           update set eb.name = l_name,
                      eb.eppwork = l_eppwork,
                      eb.date_opened = l_dateon,
                      eb.date_closed = l_dateoff
         when not matched then
           insert values(l_branch,
                         l_name,
                         l_eppwork,
                         l_dateon,
                         l_dateon);

      end loop;
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.trans_state_done,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => dbms_utility.format_error_backtrace());

    end;

    procedure r_getacc_rest_procesing(p_file_data in clob,
                                      p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_acc      varchar2(20);
      l_rest     number;
      l_fileid   number;
    begin

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'body');

      l_row := dbms_xmldom.item(l_rows, 0);

      l_rest   := to_number(dbms_xslprocessor.valueof(l_row, 'ostc/text()'));
      l_acc    := to_number(dbms_xslprocessor.valueof(l_row, 'acc/text()'));
      l_fileid := to_number(dbms_xslprocessor.valueof(l_row, 'fileid/text()'));

      merge into pfu_acc_rest ar
      using  dual ON (ar.fileid = l_fileid)
      when matched then
        update set ar.rest = l_rest,
                   ar.restdate = sysdate,
                   ar.acc = l_acc
      when not matched then
        insert values(l_acc,
                      l_rest,
                      sysdate,
                      l_fileid);

      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.trans_state_done,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      commit;
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => dbms_utility.format_error_backtrace());

    end;

begin
    null;
end;
/
 show err;
 
PROMPT *** Create  grants  PFU_FILES_UTL ***
grant EXECUTE                                                                on PFU_FILES_UTL   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/PFU/package/pfu_files_utl.sql =========*** End **
 PROMPT ===================================================================================== 
 
