
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ow_utl.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.OW_UTL is

  -- Author  : VITALII.KHOMIDA
  -- Created : 11.08.2016 13:01:00
  -- Purpose :
procedure rebranch_file_processing(p_filename in varchar2,
                                   p_filebody in blob,
                                   p_fileid   out number,
                                   p_msg      out varchar2);

procedure get_nd(p_rnk in number);
function get_filefromzip(p_zipped_blob blob) return blob;
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.OW_UTL is

  type t_rebranch is table of ow_rebranch_data%rowtype index by pls_integer;

  c_END_OF_CENTRAL_DIRECTORY constant raw(4) := hextoraw( '504B0506' ); -- End of central directory signature for zip

  procedure parse_rebranch_file(p_fileid   in number,
                                p_filebody in clob) is
    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_row    dbms_xmldom.domnode;
    l_lines  t_rebranch;
    l_tmp    number;
  begin
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_filebody);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'ROW');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
    loop
      begin
        l_row := dbms_xmldom.item(l_rows, i);

        l_lines(i).kf := sys_context('bars_context','user_mfo');
        l_lines(i).id := s_ow_rebranch_data.nextval;
        l_lines(i).fileid := p_fileid;
        l_lines(i).idn := i + 1;
        l_lines(i).rnk := to_number(dbms_xslprocessor.valueof(l_row,
                                                              'RNK/text()'));
        l_lines(i).nls := dbms_xslprocessor.valueof(l_row, 'NLS/text()');
        l_lines(i).branch := dbms_xslprocessor.valueof(l_row,
                                                       'BRANCH/text()');
        l_lines(i).state := 0;

      exception
        when others then
          l_lines(i).kf := sys_context('bars_context','user_mfo');
          l_lines(i).state := 10;
          l_lines(i).msg := 'Помилка парсінгу строки :' ||
                            dbms_utility.format_error_stack() || chr(10) ||
                            dbms_utility.format_error_backtrace();

      end;

    end loop;

    forall j in l_lines.first .. l_lines.last
      insert into ow_rebranch_data values l_lines (j);
    l_tmp := l_lines.count;
    update ow_files
       set file_n      = l_tmp,
           file_status = 1,
           err_text    = null
     where id = p_fileid;
  end;

  procedure upd_branch(p_acc_list in number_list,
                       p_branch   in varchar2) is
  begin
    forall i in p_acc_list.first .. p_acc_list.last
      update accounts t
         set t.tobo   = p_branch,
             t.branch = p_branch
       where t.acc = p_acc_list(i) and t.branch <> p_branch;
  end;

  procedure rebranch_data_procesing(p_fileid in number) is
    l_lines    t_rebranch;
    l_acc_list number_list;
    l_nd       w4_acc.nd%type;
  begin
    select t.* bulk collect
      into l_lines
      from ow_rebranch_data t
     where t.fileid = p_fileid and t.state = 0;
    if l_lines.count > 0 then
      for i in l_lines.first .. l_lines.last
      loop
        begin
          savepoint befor_upd;

          select nd
            into l_nd
            from w4_acc w
            join accounts a
              on w.acc_pk = a.acc and a.nls = l_lines(i).nls and
                 a.rnk = l_lines(i).rnk;

          select atr_vallue bulk collect
            into l_acc_list
            from w4_acc unpivot(atr_vallue for attribute_name in(acc_2207,
                                                                  acc_2208,
                                                                  acc_2209,
                                                                  acc_2625d,
                                                                  acc_2625x,
                                                                  acc_2627,
                                                                  acc_2627x,
                                                                  acc_2628,
                                                                  acc_3570,
                                                                  acc_3579,
                                                                  acc_9129,
                                                                  acc_ovr,
                                                                  acc_pk))
           where nd = l_nd;

          upd_branch(l_acc_list, l_lines(i).branch);

          -- формуємо заявку в СМ на зміну бранча
          begin
            bars_ow.add_deal_to_cmque(l_nd, 7);
            l_lines(i).state := 1;
            l_lines(i).msg := 'Успішно';
          exception
            when others then
              l_lines(i).state := 10;
              l_lines(i).msg := 'Помилка при відрпавці запиту в СМ:' ||
                                dbms_utility.format_error_stack() ||
                                chr(10) ||
                                dbms_utility.format_error_backtrace();
          end;

        exception
          when no_data_found then
            rollback to befor_upd;
            l_lines(i).state := 10;
            l_lines(i).msg := 'Рахунок у клієнта не знайдено';
          when others then
            rollback to befor_upd;
            l_lines(i).state := 10;
            l_lines(i).msg := dbms_utility.format_error_stack() || chr(10) ||
                              dbms_utility.format_error_backtrace();
        end;
      end loop;

      forall ii in l_lines.first .. l_lines.last
        update ow_rebranch_data t
           set t.state = l_lines(ii).state,
               t.msg   = l_lines(ii).msg
         where t.id = l_lines(ii).id;
      update ow_files
         set file_status = 2,
             err_text    = null
       where id = p_fileid;
    end if;
  end;

  procedure rebranch_file_processing(p_filename in varchar2,
                                     p_filebody in blob,
                                     p_fileid   out number,
                                     p_msg      out varchar2) is
    l_filename     varchar2(100);
    l_filetype     varchar2(8) := 'REBRANCH';
    l_id           number := null;
    i              number;
    l_blob         blob;
    l_clob         clob;
    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    h              varchar2(100) := 'ow_files_utl.rebranch_file_processing. ';

  begin

    bars_audit.info(h || 'Start.');

    l_blob := utl_compress.lz_uncompress(p_filebody);
    dbms_lob.createtemporary(l_clob, false);

    dbms_lob.converttoclob(dest_lob     => l_clob,
                           src_blob     => l_blob,
                           amount       => dbms_lob.lobmaxsize,
                           dest_offset  => l_dest_offset,
                           src_offset   => l_src_offset,
                           blob_csid    => l_blob_csid,
                           lang_context => l_lang_context,
                           warning      => l_warning);

    bars_audit.info(h || 'File converted to clob');

    l_id := bars_sqnc.get_nextval('S_OWFILES');

    insert into ow_files
      (id, file_type, file_name, file_body, file_status, origin)
    values
      (l_id, l_filetype, p_filename, empty_blob(), 0, 0);
    p_fileid := l_id;

    parse_rebranch_file(p_fileid, l_clob);

    rebranch_data_procesing(p_fileid);

    bars_audit.info(h || 'Finish.' || 'p_msg=>' || p_msg);
  exception
    when others then
      update ow_files
         set file_status = 3,
             err_text    = dbms_utility.format_error_stack() || chr(10) ||
                           dbms_utility.format_error_backtrace()
       where id = p_fileid;

  end;
   procedure get_nd(p_rnk in number)
     is

  begin
   for z in (select w.nd
     from w4_acc w, accounts a
     where
        w.acc_pk = a.acc
       and W.DAT_CLOSE is null
       and a.dazs is null
       and rnk =p_rnk)
     loop
     begin
        bars.bars_ow.add_deal_to_cmque(z.nd,3);
     exception when OTHERS then
        bars_audit.info('Помилка при відправці № дог=' || to_char(z.nd));
     end;
     end loop;

   end;
  function little_endian( p_big number, p_bytes pls_integer := 4 )
  return raw
  is
    t_big number := p_big;
  begin
    if t_big > 2147483647
    then
      t_big := t_big - 4294967296;
    end if;
    return utl_raw.substr( utl_raw.cast_from_binary_integer( t_big, utl_raw.little_endian ), 1, p_bytes );
  end;

  function blob2num(p_blob blob,
                    p_len  integer,
                    p_pos  integer) return number is
    rv number;
  begin
    rv := utl_raw.cast_to_binary_integer(dbms_lob.substr(p_blob,
                                                         p_len,
                                                         p_pos),
                                         utl_raw.little_endian);
    if rv < 0 then
      rv := rv + 4294967296;
    end if;
    return rv;
  end;
  function get_filefromzip(p_zipped_blob blob) return blob is
    t_tmp      blob;
    t_ind      integer;
    t_hd_ind   integer;
    t_fl_ind   integer;
    t_len      integer;
  begin
    t_ind := nvl(dbms_lob.getlength(p_zipped_blob), 0) - 21;
    loop
      exit when t_ind < 1 or dbms_lob.substr(p_zipped_blob, 4, t_ind) = c_end_of_central_directory;
      t_ind := t_ind - 1;
    end loop;
    --
    if t_ind <= 0 then
      return null;
    end if;
    --
    t_hd_ind := blob2num(p_zipped_blob, 4, t_ind + 16) + 1;
    for i in 1 .. blob2num(p_zipped_blob, 2, t_ind + 8)
    loop
        t_len := blob2num(p_zipped_blob, 4, t_hd_ind + 24); -- uncompressed length
        if t_len = 0 then
            -- empty file
            return empty_blob();
        end if;
        --
        if dbms_lob.substr(p_zipped_blob, 2, t_hd_ind + 10) in
           (hextoraw('0800') -- deflate
           ,
            hextoraw('0900') -- deflate64
            ) then
          t_fl_ind := blob2num(p_zipped_blob, 4, t_hd_ind + 42);
          t_tmp    := hextoraw('1F8B0800000000000003'); -- gzip header
          dbms_lob.copy(t_tmp,
                        p_zipped_blob,
                        blob2num(p_zipped_blob, 4, t_hd_ind + 20),
                        11,
                        t_fl_ind + 31 +
                        blob2num(p_zipped_blob, 2, t_fl_ind + 27) -- File name length
                        + blob2num(p_zipped_blob, 2, t_fl_ind + 29) -- Extra field length
                        );
          dbms_lob.append(t_tmp,
                          utl_raw.concat(dbms_lob.substr(p_zipped_blob,
                                                         4,
                                                         t_hd_ind + 16) -- CRC32
                                        ,
                                         little_endian(t_len) -- uncompressed length
                                         ));
          return utl_compress.lz_uncompress(t_tmp);
        end if;
        --
        if dbms_lob.substr(p_zipped_blob, 2, t_hd_ind + 10) =
           hextoraw('0000') -- The file is stored (no compression)
         then
          t_fl_ind := blob2num(p_zipped_blob, 4, t_hd_ind + 42);
          dbms_lob.createtemporary(t_tmp, true);
          dbms_lob.copy(t_tmp,
                        p_zipped_blob,
                        t_len,
                        1,
                        t_fl_ind + 31 +
                        blob2num(p_zipped_blob, 2, t_fl_ind + 27) -- File name length
                        + blob2num(p_zipped_blob, 2, t_fl_ind + 29) -- Extra field length
                        );
          return t_tmp;
        end if;
      t_hd_ind := t_hd_ind + 46 + blob2num(p_zipped_blob, 2, t_hd_ind + 28) -- File name length
                  + blob2num(p_zipped_blob, 2, t_hd_ind + 30) -- Extra field length
                  + blob2num(p_zipped_blob, 2, t_hd_ind + 32); -- File comment length
    end loop;
    --
    return null;
  end;
end;
/
 show err;
 
PROMPT *** Create  grants  OW_UTL ***
grant EXECUTE                                                                on OW_UTL          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OW_UTL          to BARS_ACCESS_USER;
grant EXECUTE                                                                on OW_UTL          to PUBLIC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ow_utl.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 