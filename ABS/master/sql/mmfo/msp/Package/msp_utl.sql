PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/package/msp_utl.sql =========*** Run *** 
PROMPT ===================================================================================== 
 
create or replace package msp_utl is

  gc_header_version constant varchar2(64)  := 'version 1.2 18.01.2018';

  type r_file_array is record (
    file_name    varchar2(50),
    file_buff    blob
    );
  type t_file_array is table of r_file_array;

  type r_match_array is record (
    id     msp_envelopes.id%type,
    bvalue blob
    );
  type t_match_array is table of r_match_array;

  -----------------------------------------------------------------------------------------
  --  add_text_node_utl
  --
  --    ������� �������� ��� � xml ��������, � ������� ���� ��������� dbms_xmldom.DOMNode
  --
  function add_text_node_utl(p_document  in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node in out nocopy dbms_xmldom.DOMNode,
                             p_node_name in varchar2,
                             p_node_text in varchar2) return dbms_xmldom.DOMNode;

  -----------------------------------------------------------------------------------------
  --  add_txt_node_utl
  --
  --    ����� �������� ��� � xml ��������
  --
  procedure add_txt_node_utl(p_document  in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node in out nocopy dbms_xmldom.DOMNode,
                             p_node_name in varchar2,
                             p_node_text in varchar2);

  -----------------------------------------------------------------------------------------
  --  add_clob_node_utl
  --
  --    ������� �������� ��� ������� clob � xml ��������, � ������� ���� ��������� dbms_xmldom.DOMNode
  --
  function add_clob_node_utl(p_document       in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node      in out nocopy dbms_xmldom.DOMNode,
                             p_node_name      in varchar2,
                             p_node_text_clob in clob) return dbms_xmldom.DOMNode;

  -----------------------------------------------------------------------------------------
  --  add_clb_node_utl
  --
  --    ����� �������� ��� ������� clob � xml ��������
  --
  procedure add_clb_node_utl(p_document       in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node      in out nocopy dbms_xmldom.DOMNode,
                             p_node_name      in varchar2,
                             p_node_text_clob in clob);

  -----------------------------------------------------------------------------------------
  --  header_version
  --
  --    ����� ��������� ������
  --
  function header_version return varchar2;

  -----------------------------------------------------------------------------------------
  --  body_version
  --
  --    ����� ��� ������
  --
  function body_version return varchar2;

  -----------------------------------------------------------------------------------------
  --  replace_ukrsmb2dos
  --
  --    ����� ��� ������� ��� cp OEM 866
  --
  function replace_ukrsmb2dos(l_txt clob) return clob;

  --procedure set_state_request(p_id in number, p_state in number, p_comment in varchar2 default null);
  --procedure set_state_envelope(p_id number, p_state in number, p_comm in varchar2 default null);
  procedure set_state (p_id in number, p_state in number, p_comm in varchar2, p_obj in number);

  -----------------------------------------------------------------------------------------
  --  set_file_state
  --
  --    ��������� ������� �����
  --
  procedure set_file_state(p_file_id  in msp_files.id%type,
                           p_state_id in msp_files.state_id%type,
                           p_comment  in msp_files.comm%type default null);

  -----------------------------------------------------------------------------------------
  --  create_parsing_file
  --
  --    ������� � ����� ��������� ����� �����
  --
  procedure create_parsing_file(p_envelope_file_id in msp_envelope_files_info.id%type,
                                p_id_file          in msp_envelope_files_info.id_file%type);

  -----------------------------------------------------------------------------------------
  --  set_file_record_state
  --
  --    ��������� ������� �������������� ����� �����
  --
  /*procedure set_file_record_state(p_file_record_id  in msp_file_records.id%type,
                                  p_state_id        in msp_file_records.state_id%type,
                                  p_comment        in msp_file_records.comm%type default null);*/

  -----------------------------------------------------------------------------------------
  --  make_matching
  --
  --    ������� ����� �� ������� ZIP ����� ��������� 1/2
  --
  --      p_envelope_id - id ��������
  --      p_matching_tp - ��� ��������� (1/2)
  --      p_is_convert2dos - ������ 1 - ������������ � cp866 / 0 - �
  --
  function make_matching(p_envelope_id    in msp_envelopes.id%type,
                         p_matching_tp    in simple_integer default 1,
                         p_is_convert2dos in simple_integer default 1
                         ) return blob;

  -----------------------------------------------------------------------------------------
  --  get_matching2sign
  --
  --    ������� ����� �� ������� ������� ZIP ����� ��������� 1/2
  --
  --      p_stage          - ����     - 1 - ��������� �����, 2 - ���������� ���
  --      p_is_convert2dos - ������ 1 - ������������ � cp866 / 0 - �
  --
  function get_matching2sign(p_stage          in simple_integer,
                             p_is_convert2dos in simple_integer default 1) return t_match_array pipelined;

  -----------------------------------------------------------------------------------------
  --  save_matching
  --
  --    ��������� ������ ������������ ����� ��������� 1/2
  --
  --      p_envelope_id - id ��������
  --      p_file_buff   - clob ����� �����
  --      p_ecp         - ��������������� � ������� ���������� ��� 2 �� ������� ���� �� ��������
  --
  procedure save_matching(p_envelope_id in msp_envelopes.id%type,
                          p_file_buff   in clob,
                          p_ecp         in clob default null);

  -----------------------------------------------------------------------------------------
  --  set_match_processing
  --
  --    ��������� ����� "��������� 1/2 � ������ ����������" ��� ��������
  --
  procedure set_match_processing(p_envelope_id in msp_envelopes.id%type,
                                 p_matching_tp in simple_integer);

  -----------------------------------------------------------------------------------------
  --  get_matching
  --
  --    ��������� ��������� 1/2
  --
  --function get_matching(p_file_id     in msp_files.id%type,
  --                      p_matching_tp in simple_integer default 1) return clob;

  -----------------------------------------------------------------------------------------
  --  create_parsing_file
  --
  --    ������� � ����� ��������� ����� �����
  --
  --procedure create_parsing_file(p_envelope_file_id in msp_envelope_files_info.id%type);

  -----------------------------------------------------------------------------------------
  --  process_file
  --
  --    ������ �� �������� ����� �����
  --
  procedure process_files;

  -----------------------------------------------------------------------------------------
  --  decodeclobfrombase64
  --
  --    decodeclobfrombase64
  --
  procedure encode_data(p_data in out nocopy clob);
  procedure decode_data(p_data in out nocopy clob);
  /*function decodeclobfrombase64(p_clob clob) return clob;
  function encodeclobtobase64(p_clob clob) return clob;*/
  function utf8todeflang(p_clob in clob) return clob;

  -----------------------------------------------------------------------------------------
  --  set_file_record2pay
  --
  --    ��������� �������������� ����� � ������
  --
  procedure set_file_record2pay(p_file_record_id in msp_file_records.id%type);

  -----------------------------------------------------------------------------------------
  --  set_file_for_pay
  --
  --    �������� ����� �� ������
  --
  procedure set_file_for_pay(p_file_id in msp_files.id%type);

  -----------------------------------------------------------------------------------------
  --  set_file_record_blocked
  --
  --    ��������� ������������� ����� � ������
  --
  procedure set_file_record_blocked(p_file_record_id in msp_file_records.id%type,
                                    p_comment        in msp_file_records.comm%type,
                                    p_block_type_id  in msp_file_records.block_type_id%type);

  --function decode_request_data(p_request_id in msp_requests.id%type) return clob;

  -----------------------------------------------------------------------------------------
  --  prepare_request_xml
  --
  --    ������� ���� xml ������� �� �����
  --
  --function prepare_request_xml(p_request_id in msp_requests.id%type) return clob;

  -----------------------------------------------------------------------------------------
  --  create_request
  --
  --    ��������� ������ ����� � ���� ����� � ����� �������
  --
  procedure create_request(p_req_xml  in clob,
                           p_act_type in number,
                           p_xml      out clob);

  -----------------------------------------------------------------------------------------
  --  prepare_check_state
  --
  --    ��������� ������ �� �������� ����� ������ ��������� �� ���
  --
  procedure prepare_check_state;

  -----------------------------------------------------------------------------------------
  --  prepare_get_rest_request
  --
  --    ��������� ������ �� �������� ����� ������ ��������� �� ���
  --
  procedure prepare_get_rest_request(p_acc    in msp_acc_trans_2909.acc_num%type,
                                     p_fileid in msp_files.id%type,
                                     p_kf     in msp_acc_trans_2909.kf%type);

  procedure create_envelope(p_id in number, p_idenv in number default null, p_code in varchar2 default null, p_sender in varchar2 default null,
                                              p_recipient in varchar2 default null, p_part_number in number default null, p_part_total in number default null, p_ecp in clob default null,
                                              p_data in clob default null, p_data_decode in clob default null);

  procedure create_envelope_file(p_id in number, p_id_msp in number, p_filedata in clob, p_filename in varchar2, p_filedate in varchar2, p_filepath in varchar2);

  procedure process_receipt;

  function prepare_request_xml(p_request_id in msp_requests.id%type) return clob;

end msp_utl;
/
create or replace package body msp_utl is

  gc_body_version constant varchar2(64) := 'version 1.2 18.01.2018';
  gc_mod_code     constant varchar2(3)  := 'MSP';
  -----------------------------------------------------------------------------------------

  ex_no_file exception;

  -----------------------------------------------------------------------------------------
  --  header_version
  --
  --    ����� ��������� ������
  --
  function header_version return varchar2
  is
  begin
     return 'package header msp_utl: ' || gc_header_version;
  end header_version;

  -----------------------------------------------------------------------------------------
  --  body_version
  --
  --    ����� ��� ������
  --
  function body_version return varchar2
  is
  begin
     return 'package body msp_utl: ' || gc_body_version || chr(10);
  end body_version;

  -----------------------------------------------------------------------------------------
  --  add_text_node_utl
  --
  --    ������� �������� ��� � xml ��������, � ������� ���� ��������� dbms_xmldom.DOMNode
  --
  function add_text_node_utl(p_document  in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node in out nocopy dbms_xmldom.DOMNode,
                             p_node_name in varchar2,
                             p_node_text in varchar2)
    return dbms_xmldom.DOMNode is
    l_node dbms_xmldom.DOMNode;
  begin
    l_node := dbms_xmldom.appendChild(p_host_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(p_document, p_node_name)));
    l_node := dbms_xmldom.appendChild(l_node, dbms_xmldom.makeNode(dbms_xmldom.createTextNode(p_document, p_node_text)));
    return l_node;
  end add_text_node_utl;

  -----------------------------------------------------------------------------------------
  --  add_txt_node_utl
  --
  --    ����� �������� ��� � xml ��������
  --
  procedure add_txt_node_utl(p_document  in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node in out nocopy dbms_xmldom.DOMNode,
                             p_node_name in varchar2,
                             p_node_text in varchar2)
  is
    l_node dbms_xmldom.DOMNode;
  begin
    l_node := add_text_node_utl(p_document,
                                p_host_node,
                                p_node_name,
                                p_node_text);
  end add_txt_node_utl;

  -----------------------------------------------------------------------------------------
  --  add_clob_node_utl
  --
  --    ������� �������� ��� ������� clob � xml ��������, � ������� ���� ��������� dbms_xmldom.DOMNode
  --
  function add_clob_node_utl(p_document       in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node      in out nocopy dbms_xmldom.DOMNode,
                             p_node_name      in varchar2,
                             p_node_text_clob in clob)
    return dbms_xmldom.DOMNode is
    l_node      dbms_xmldom.DOMNode;
    l_textclob  clob := p_node_text_clob;
    l_node_text clob := '';
    l_domnode   xmldom.DOMNode;
    l_count     integer;
  begin
    l_node    := dbms_xmldom.appendChild(p_host_node,
                                         dbms_xmldom.makeNode(dbms_xmldom.createElement(p_document,
                                                                                        p_node_name)));
    l_domnode := dbms_xmldom.makeNode(dbms_xmldom.createTextNode(p_document,
                                                                 l_node_text));
    l_node    := dbms_xmldom.appendChild(l_node, l_domnode);
    loop
      l_count     := dbms_lob.getlength(l_textclob);
      l_node_text := substr(l_textclob, 1, 32767);
      l_textclob  := substr(l_textclob, 32768, l_count - 32767);
      xmldom.appendData(xmldom.makeCharacterData(l_domnode), l_node_text);
      EXIT WHEN l_count < 32767 or l_count is null;
    end loop;
    return l_node;
  end add_clob_node_utl;

  -----------------------------------------------------------------------------------------
  --  add_clb_node_utl
  --
  --    ����� �������� ��� ������� clob � xml ��������
  --
  procedure add_clb_node_utl(p_document       in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node      in out nocopy dbms_xmldom.DOMNode,
                             p_node_name      in varchar2,
                             p_node_text_clob in clob) is
    l_node dbms_xmldom.DOMNode;
  begin
    l_node := add_clob_node_utl(p_document,
                                p_host_node,
                                p_node_name,
                                p_node_text_clob);
  end add_clb_node_utl;

  -----------------------------------------------------------------------------------------
  --  replace_ukrsmb2dos
  --
  --    ����� ��� ������� ��� cp OEM 866
  --
  function replace_ukrsmb2dos(l_txt clob) return clob
  is
  begin
    return
      replace(replace(replace(replace(
      replace(replace(replace(replace(
        l_txt,
        '�', chr(ascii('�')+239)),
        '�', chr(ascii('�')+239)),
        '�', chr(ascii('�')+1)),
        '�', chr(ascii('�')+248)),
        '�', chr(ascii('�')+5)),
        '�', chr(ascii('�')+5)),
        '�', chr(ascii('�')+5)),
        '�', chr(ascii('�')+6));
  end replace_ukrsmb2dos;

  procedure set_state_request(p_id in number, p_state in number, p_comment in varchar2 default null)
  is
  begin
    update msp_requests mr
       set mr.state = p_state,
           mr.comm = p_comment
     where mr.id = p_id;

  end set_state_request;

  procedure set_state_envelope(p_id number, p_state in number, p_comm in varchar2 default null)
  is
  begin
    update msp_envelopes e
       set e.state = p_state,
           e.comm = p_comm
     where e.id = p_id;
  end set_state_envelope;

  procedure set_state_envelope_async(p_id number, p_state in number, p_comm in varchar2 default null)
  is
    pragma autonomous_transaction;
  begin
    update msp_envelopes e
       set e.state = p_state,
           e.comm = p_comm
     where e.id = p_id;
     commit;
  end set_state_envelope_async;

  procedure set_state (p_id in number, p_state in number, p_comm in varchar2, p_obj in number)
  is -- 0 - request, 1 - envelope
  begin
    if p_obj = 0 then
      set_state_request(p_id, p_state, p_comm);
    elsif p_obj = 1 then
      set_state_envelope(p_id, p_state, p_comm);
    end if;
  end set_state;

  -----------------------------------------------------------------------------------------
  --  set_envelope_file
  --
  --    ��������� ����� ������� envelope_files
  --
  procedure set_envelope_file_state(p_envelope_id in msp_envelope_files_info.id%type,
                                    p_state       in msp_envelope_files_info.state%type,
                                    p_comment     in msp_envelope_files_info.comm%type default null)
  is
  begin
    update msp_envelope_files_info set state = p_state, comm = p_comment where id = p_envelope_id;
    if sql%rowcount = 0 then
      raise no_data_found;
    end if;
  exception
    when no_data_found then
      raise_application_error(-20000, '�� �������� ��������� ���� � ����� ����� p_envelope_file_id='||to_char(p_envelope_id));
    when others then
      raise_application_error(-20000, '������� ������ ����� ���������� ����� p_envelope_file_id='||to_char(p_envelope_id)||'. '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end set_envelope_file_state;

  -----------------------------------------------------------------------------------------
  --  set_file_state
  --
  --    ��������� ������� �����
  --
  procedure set_file_state(p_file_id  in msp_files.id%type,
                           p_state_id in msp_files.state_id%type,
                           p_comment  in msp_files.comm%type default null)
  is
  begin
    update msp_files set state_id = p_state_id, comm = p_comment where id = p_file_id;
    if sql%rowcount = 0 then
      raise ex_no_file;
    end if;
  exception
    when ex_no_file then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_FILE_STATUS', to_char(p_file_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERRUPD_FILE_STATUS', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end set_file_state;

  -----------------------------------------------------------------------------------------
  --  set_file_record_state
  --
  --    ��������� ������� �������������� ����� �����
  --
  procedure set_file_record_state(p_file_record_id in msp_file_records.id%type,
                                  p_state_id       in msp_file_records.state_id%type,
                                  p_comment        in msp_file_records.comm%type default null)
  is
  begin
    update msp_file_records set state_id = p_state_id, comm = coalesce(p_comment, comm) where id = p_file_record_id;

    if sql%rowcount = 0 then
      raise ex_no_file;
    end if;
  exception
    when ex_no_file then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_FILEREC_STATUS', to_char(p_file_record_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERRUPD_FILEREC_STATUS', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end set_file_record_state;

  -----------------------------------------------------------------------------------------
  --  checking_record2
  --
  --    �������� 2
  --
  /*procedure checking_record2(p_file_id in _file.id%type) is
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

  end checking_record2;*/

  -----------------------------------------------------------------------------------------
  --  checking_file_record
  --
  --    ��������� �������� ������ �����
  --
  procedure check_file_record(p_file_record_id in msp_file_records.id%type,
                              p_numident       in msp_file_records.numident%type,
                              p_deposit_acc    in msp_file_records.deposit_acc%type,
                              p_full_name      in msp_file_records.full_name %type,
                              p_receiver_mfo   in msp_files.receiver_mfo%type)
  is
    ex_err_record       exception;
    l_err_code          number;
    l_pensioner_row     pfu.pfu_pensioner%rowtype;
    l_pensacc_row       pfu.pfu_pensacc%rowtype;
    l_c_pens            pls_integer;
    l_block_type_id     msp_file_records.block_type_id%type;
  begin
    -- �������� ���������
    select count(1) into l_c_pens from pfu.pfu_pensioner p
    where p.okpo = p_numident and p.kf   = to_char(p_receiver_mfo) and p.date_off is null;
    if (p_numident is not null) then
      if (l_c_pens = 0) then
         l_err_code := 5;
         --l_err_message := '��������� �� �������� �� ����';
         raise ex_err_record;
      end if;
    end if;

    -- �������� �������
    begin
      select * into l_pensacc_row from pfu.pfu_pensacc pa
      where pa.nls = to_char(p_deposit_acc) and pa.kf = to_char(p_receiver_mfo);
    exception
      when no_data_found then
        l_err_code    := 4;
        --l_err_message := '������� �� ��������';
        raise ex_err_record;
      when others then
        raise;
    end;

    -- ������� ��������
    if l_pensacc_row.dazs is not null then
      l_err_code := 3;
      --l_err_message := '������� ��������';
      raise ex_err_record;
    end if;

    -- �������� ��������� (�� �������)
    begin
      select * into l_pensioner_row from pfu.pfu_pensioner p
      where p.rnk = l_pensacc_row.rnk and p.kf = l_pensacc_row.kf;
    exception
      when no_data_found then
        l_err_code := 1;
        --l_err_message := '��������� �� �������� (�� �������)';
        raise ex_err_record;
      when others then
        raise;
    end;

    -- �������� ����������
    /*
    if l_pensioner_row.block_type is not null then -- if l_pensioner_row.state = 'BLOCKED' then
      l_block_type_id := l_pensioner_row.block_type;
      l_err_code := 0; -- TODO: ���� ���������� ����� �����������
      --l_err_message := '�������� ����������';
      raise ex_err_record;
    end if;
    */

    -- ������������ ����
    if l_pensioner_row.okpo != p_numident then
      l_err_code    := 1;
      --l_err_message := '������� �� ������� �� ����';
      raise ex_err_record;
    end if;

    -- ������������ ϲ�
    if utl_match.edit_distance_similarity(UPPER(l_pensioner_row.nmk),UPPER(p_full_name)) < 80 then
      l_err_code    := 2;
      --l_err_message := '������� �� ������� �� ϲ�';
      raise ex_err_record;
    end if;

    update msp_file_records set state_id = 0, comm = null where id = p_file_record_id;
  exception
    when ex_err_record then
      update msp_file_records set state_id = l_err_code, comm = null, block_type_id = l_block_type_id where id = p_file_record_id;
    when others then
      raise_application_error(-20000, '������� ��������: ' || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end check_file_record;

  -----------------------------------------------------------------------------------------
  --  create_parsing_file
  --
  --    ������� � ����� ��������� ����� �����
  --
  procedure create_parsing_file(p_envelope_file_id in msp_envelope_files_info.id%type,
                                p_id_file          in msp_envelope_files_info.id_file%type)
  is
    l_filedata msp_envelope_files.filedata%type;
  begin
    -- �������� �������� ���� ��� ��������
    select filedata into l_filedata from msp_envelope_files t where id = p_envelope_file_id;
    bars.import_flat_file(l_filedata);
    
    insert into tmp_imp_file select * from bars.tmp_imp_file;

    delete from msp_file_records where file_id = p_id_file;
    delete from msp_files where id = p_id_file;

    -- insert into msp_files
    insert into msp_files (id, state_id, envelope_file_id,
                           file_bank_num, file_filia_num, file_pay_day, file_separator, file_upszn_code, header_lenght, file_date,
                           rec_count, payer_mfo, payer_acc, receiver_mfo, receiver_acc, debit_kredit, pay_sum, pay_type, pay_oper_num,
                           attach_flag, payer_name, receiver_name, payment_purpose, filia_num, deposit_code, process_mode, checksum)
    select p_id_file, -1, p_envelope_file_id,
           trim(substr(line,  1, 5)), --file_bank_num,
           trim(substr(line,  6, 5)), --file_filia_num,
           trim(substr(line, 11, 2)), --file_pay_day,
           trim(substr(line, 13, 1)), --file_separator,
           trim(substr(line, 14, 3)), --file_upszn_code,
           to_number(trim(substr(line, 17, 3))), --header_lenght,
           trim(substr(line, 20, 8)), --file_date,
           to_number(trim(substr(line, 28, 6))), --rec_count,
           to_number(trim(substr(line, 34, 9))), --payer_mfo,
           to_number(trim(substr(line, 43, 14))), --payer_acc,
           to_number(trim(substr(line, 57, 9))), --receiver_mfo,
           to_number(trim(substr(line, 66, 14))), --receiver_acc,
           trim(substr(line, 80, 1)), --debit_kredit,
           to_number(trim(substr(line, 81, 19))), --pay_sum,
           to_number(trim(substr(line, 100, 2))), --pay_type,
           trim(substr(line, 102, 10)), --pay_oper_num,
           trim(substr(line, 112, 1)), --attach_flag,
           trim(substr(line, 113, 27)), --payer_name,
           trim(substr(line, 140, 27)), --receiver_name,
           trim(substr(line, 167, 160)), --payment_purpose,
           to_number(trim(substr(line, 327, 5))), --filia_num,
           to_number(trim(substr(line, 332, 3))), --deposit_code,
           trim(substr(line, 335, 10)), --process_mode,
           trim(substr(line, 345, 32)) --checksum
    from bars.tmp_imp_file t where id = 0;

    -- insert into msp_file_records
    insert into msp_file_records (id, file_id, state_id, block_type_id, block_comment, rec_no,
                                  deposit_acc, filia_num, deposit_code, pay_sum,
                                  full_name, numident, pay_day, displaced, pers_acc_num)
    select msp_file_record_seq.nextval, p_id_file, -1, null, null, id,
           to_number(trim(substr(line, 1, 19))), --deposit_acc,
           to_number(trim(substr(line, 20, 5))), --filia_num,
           to_number(trim(substr(line, 25, 3))), --deposit_code,
           to_number(trim(substr(line, 28, 19))), --pay_sum,
           trim(substr(line, 47, 100)), --full_name,
           trim(substr(line, 147, 10)), --numident,
           trim(substr(line, 157, 2)), --pay_day,
           trim(substr(line, 159, 1)), --displaced
           trim(substr(line, 160, 6)) --pers_acc_num
    from bars.tmp_imp_file t where id <> 0;
  exception
    when others then
      raise_application_error(-20000, '��������� ���������� ����. �� �������� ��������� �����. ' || chr(10) || chr(10) || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end create_parsing_file;

  -----------------------------------------------------------------------------------------
  --  parse_files
  --
  --    ������� ����� �����
  --
  procedure parse_files
  is
    l_err_state msp_envelope_files_info.state%type;
  begin
    -- set status 1 IN_PARSE ���������� �������
    for r in (select distinct id from msp_envelope_files_info where state in (-1))
    loop
      set_envelope_file_state(r.id, 1);-- 1 IN_PARSE ���������� �������
    end loop;

    commit;

    -- parse and insert data
    for r in (select distinct id from msp_envelope_files_info where state in (1))
    loop
      l_err_state := null;

      for i in (select id_file from msp_envelope_files_info where id = r.id)
      loop
        begin
          create_parsing_file(p_envelope_file_id => r.id, p_id_file => i.id_file);
        exception
          when others then
            l_err_state := 2; -- 2 PARSE_ERROR ������� ��������
        end;
      end loop;

      set_envelope_file_state(r.id, coalesce(l_err_state, 3), sqlerrm); -- 2 PARSE_ERROR ������� �������� / 3 PARSED ���� ���������
      commit;
    end loop;
  end parse_files;

  -----------------------------------------------------------------------------------------
  --  validate_file_records
  --
  --    �������� ������ �����
  --
  procedure validate_file_records
  is
    l_check_state simple_integer := 0; -- ������ ��������
  begin
    -- check file_records
    for ef in (select distinct ef.id
               from msp_envelope_files_info ef
               where ef.state in (3,5)
               order by ef.id)
    loop
      for i in (select f.receiver_mfo, f.id file_id
                from msp_files f
                where f.envelope_file_id = ef.id
                      and f.state_id in (-1,5) -- -1 - NEW / 5 - ���� �������� ������� �������� �� �������� ������ ��������
                order by ef.id)
      loop
        begin
          set_envelope_file_state(ef.id, 4);-- 4  IN_CHECK ���������� ��������
          set_file_state(i.file_id, 4);    -- 4 IN_CHECK ���������� ��������
          commit;

          for rec in (select * from msp_file_records where file_id = i.file_id)
          loop
            check_file_record(p_file_record_id => rec.id,
                              p_numident       => rec.numident,
                              p_deposit_acc    => rec.deposit_acc,
                              p_full_name      => rec.full_name,
                              p_receiver_mfo   => i.receiver_mfo);
          end loop;
          set_file_state(i.file_id, 0);    -- 0 CHECKED ���������
        exception
          when others then
            set_file_state(i.file_id, 5, sqlerrm); -- 5 CHECK_ERROR �������� ������� ��������
            l_check_state := 5;
        end;
      end loop;

      set_envelope_file_state(ef.id, l_check_state); -- 0 CHECKED ��������� / 5  CHECK_ERROR �������� ������� ��������
      commit;
    end loop;

  end validate_file_records;

  -----------------------------------------------------------------------------------------
  --  process_file
  --
  --    ������ �� �������� ����� �����
  --
  procedure process_files
  is
  begin
    parse_files;
    validate_file_records;
  end process_files;


  -----------------------------------------------------------------------------------------
  --  do_matching1_header
  --
  --    �������� ��������� ����� ��������� 1
  --
  procedure do_matching1_header(
    p_file_id   in msp_files.id%type,
    p_file_buff in out nocopy clob
    )
  is
    l_file        msp_files%rowtype;
    l_create_date char(8) := to_char(sysdate,'dd\mm\yy');
    l_crlp        char(2) := chr(13)||chr(10);
    l_file_name   varchar2(17 char);
  begin
    select * into l_file from msp_files where id = p_file_id;
    --l_file_name := substr(lpad(l_file.file_bank_num,5,'0'),1,5)||'\'||substr(lpad(l_file.file_filia_num,5,'0'),1,5)||substr(lpad(l_file.file_pay_day,2,'0'),1,2)||'.'||substr(lpad(l_file.file_upszn_code,3,'0'),1,3);
    l_file_name   := lpad(coalesce(trim(l_file.file_bank_num),'0'),5,'0')||'\'||lpad(coalesce(trim(l_file.file_filia_num),'0'),5,'0')||lpad(coalesce(trim(l_file.file_pay_day),'0'),2,'0')||coalesce(trim(l_file.file_separator),'.')||lpad(coalesce(trim(l_file.file_upszn_code),'0'),3,'0');

    p_file_buff := replace(l_file_name, '\', '')||
      to_char(l_file.header_lenght,'FM000')||
      l_create_date||
      to_char(l_file.rec_count,'FM000000')||
      to_char(l_file.payer_mfo,'FM000000000')||
      --to_char(l_file.payer_acc,'FM000000000')||
      to_char(l_file.payer_acc,'FM00000000000000')||
      to_char(l_file.receiver_mfo,'FM000000000')||
      --to_char(l_file.receiver_acc,'FM000000000')||
      to_char(l_file.receiver_acc,'FM00000000000000')||
      coalesce(l_file.debit_kredit,' ')||
      to_char(l_file.pay_sum,'FM0000000000000000000')||
      to_char(l_file.pay_type,'FM00')||
      rpad(coalesce(l_file.pay_oper_num,' '),10,' ')||
      coalesce(l_file.attach_flag,' ')||
      rpad(coalesce(l_file.payer_name,' '),27,' ')||
      rpad(coalesce(l_file.receiver_name,' '),27,' ')||
      rpad(coalesce(l_file.payment_purpose,' '),160,' ')||
      to_char(l_file.filia_num,'FM00000')||
      rpad(coalesce(to_char(l_file.deposit_code),' '),3,' ')||
      rpad(coalesce(l_file.process_mode,' '),10,' ')||
      rpad(coalesce(l_file.checksum,' '),32,' ')||
      l_crlp;
  exception
    when no_data_found then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_MATCHING_HEADER', to_char(p_file_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERROR_MATCHING_HEADER', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end do_matching1_header;

  -----------------------------------------------------------------------------------------
  --  do_matching1_body
  --
  --    �������� ����� ��������� 1
  --
  procedure do_matching1_body(
    p_file_id        in msp_files.id%type,
    p_file_buff      in out nocopy clob
    )
  is
    l_crlp char(2) := chr(13)||chr(10);
  begin
    for c_rec in (select * from msp_file_records where file_id = p_file_id order by id)
      loop
        p_file_buff := p_file_buff||
          to_char(c_rec.deposit_acc,'FM0000000000000000000')||
          to_char(c_rec.filia_num,'FM00000')||
          to_char(c_rec.deposit_code,'FM000')||
          to_char(c_rec.pay_sum,'FM0000000000000000000')||
          rpad(coalesce(c_rec.full_name,' '),100,' ')||
          rpad(coalesce(c_rec.numident,' '),10,' ')||
          rpad(coalesce(c_rec.pay_day,' '),2,' ')||
          coalesce(c_rec.displaced,' ')||
          to_char(c_rec.pers_acc_num,'FM000000')||
          to_char(case when c_rec.state_id < 6 then c_rec.state_id else 0 end ,'FM0')||
          l_crlp;
      end loop;
  exception
    when no_data_found then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_MATCHING_BODY', to_char(p_file_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERROR_MATCHING_BODY', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end do_matching1_body;

  -----------------------------------------------------------------------------------------
  --  do_matching2_header
  --
  --    �������� ��������� ����� ��������� 2
  --
  procedure do_matching2_header(
    p_file_id   in msp_files.id%type,
    p_file_buff in out nocopy clob
    )
  is
    l_file            msp_files%rowtype;
    l_create_date     char(8) := to_char(sysdate,'dd\mm\yy');
    l_crlp            char(2) := chr(13)||chr(10);
    l_file_name       varchar2(17 char);
    l_count_payed     number(6);
    l_sum_payed       number(14);
    l_count_not_payed number(6);
    l_sum_not_payed   number(14);
  begin
    select * into l_file from msp_files where id = p_file_id;

    select sum(case when state_id in (0) then 1 else 0 end) count_payed,
           sum(case when state_id in (0) then pay_sum else 0 end) sum_payed,
           sum(case when state_id not in (0) then 1 else 0 end) count_not_payed,
           sum(case when state_id not in (0) then pay_sum else 0 end) sum_not_payed
    into l_count_payed, l_sum_payed, l_count_not_payed, l_sum_not_payed
    from msp_file_records
    where file_id = p_file_id;

    --l_file_name := substr(lpad(l_file.file_bank_num,5,'0'),1,5)||'\'||substr(lpad(l_file.file_filia_num,5,'0'),1,5)||substr(lpad(l_file.file_pay_day,2,'0'),1,2)||'.'||substr(lpad(l_file.file_upszn_code,3,'0'),1,3);
    l_file_name   := lpad(trim(l_file.file_bank_num),5,'0')||'\'||lpad(trim(l_file.file_filia_num),5,'0')||lpad(trim(l_file.file_pay_day),2,'0')||coalesce(trim(l_file.file_separator),'.')||lpad(trim(l_file.file_upszn_code),3,'0');

    p_file_buff := replace(l_file_name, '\', '')||
      to_char(l_file.header_lenght,'FM000')||
      l_create_date||
      to_char(l_file.rec_count,'FM000000')||
      to_char(l_file.payer_mfo,'FM000000000')||
      --to_char(l_file.payer_acc,'FM000000000')||
      to_char(l_file.payer_acc,'FM00000000000000')||
      to_char(l_file.receiver_mfo,'FM000000000')||
      --to_char(l_file.receiver_acc,'FM000000000')||
      to_char(l_file.receiver_acc,'FM00000000000000')||
      coalesce(l_file.debit_kredit,' ')||
      to_char(l_file.pay_sum,'FM0000000000000000000')||
      to_char(l_file.pay_type,'FM00')||
      rpad(coalesce(l_file.pay_oper_num,' '),10,' ')||
      coalesce(l_file.attach_flag,' ')||
      rpad(coalesce(l_file.payer_name,' '),27,' ')||
      rpad(coalesce(l_file.receiver_name,' '),27,' ')||
      rpad(coalesce(l_file.payment_purpose,' '),160,' ')||
      to_char(l_file.filia_num,'FM00000')||
      rpad(coalesce(to_char(l_file.deposit_code),' '),3,' ')||
      rpad(coalesce(l_file.process_mode,' '),10,' ')||
      rpad(coalesce(l_file.checksum,' '),32,' ')||
      to_char(l_count_payed,'FM000000')||           -- number(6)  -- ���������� �������
      to_char(l_sum_payed,'FM00000000000000')||     -- number(14) -- ���������� ���� (� ���.)
      to_char(l_count_not_payed,'FM000000')||       -- number(6)  -- �� ���������� �������
      to_char(l_sum_not_payed,'FM00000000000000')|| -- number(14) -- �� ���������� ���� (� ���.)
      --
      l_crlp;
  exception
    when no_data_found then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_MATCHING_HEADER', to_char(p_file_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERROR_MATCHING_HEADER', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end do_matching2_header;

  -----------------------------------------------------------------------------------------
  --  do_matching2_body
  --
  --    �������� ����� ��������� 2
  --
  procedure do_matching2_body(
    p_file_id        in msp_files.id%type,
    p_file_buff      in out nocopy clob
    )
  is
    l_crlp char(2) := chr(13)||chr(10);
  begin
    for c_rec in (select * from msp_file_records where file_id = p_file_id and state_id in (10,14,17) order by id)
      loop
        p_file_buff := p_file_buff||
          to_char(c_rec.deposit_acc,'FM0000000000000000000')||
          to_char(c_rec.filia_num,'FM00000')||
          to_char(c_rec.deposit_code,'FM000')||
          to_char(c_rec.pay_sum,'FM0000000000000000000')||
          rpad(coalesce(c_rec.full_name,' '),100,' ')||
          rpad(coalesce(c_rec.numident,' '),10,' ')||
          rpad(coalesce(c_rec.pay_day,' '),2,' ')||
          coalesce(c_rec.displaced,' ')||
          to_char(c_rec.pers_acc_num,'FM000000')||
          to_char(case c_rec.state_id 
                    when 10 then 0
                    when 14 then 4
                    when 17 then 6
                  end,'FM0')||-- VARCHAR(1) -- ������� �� �����������
          coalesce(to_char(c_rec.fact_pay_date,'ddmmyyyy'),'        ')||-- �������� ���� ����������� �����
          --
          l_crlp;
      end loop;
  exception
    when no_data_found then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_MATCHING_BODY', to_char(p_file_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERROR_MATCHING_BODY', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end do_matching2_body;

  -----------------------------------------------------------------------------------------
  --  get_matching
  --
  --    ��������� 1,2
  --
  procedure do_matching(
    p_file_id     in msp_files.id%type,
    p_file_buff   in out nocopy blob,
    p_matching_tp in simple_integer default 1,
    p_is_convert2dos in simple_integer default 1
    )
  is
    ex_unknown_matching exception;
    l_buff clob;
  begin
    if p_matching_tp = 1 then -- ��������� 1
      do_matching1_header(p_file_id, l_buff);
      do_matching1_body(p_file_id, l_buff);
    elsif p_matching_tp = 2 then -- ��������� 2
      do_matching2_header(p_file_id, l_buff);
      do_matching2_body(p_file_id, l_buff);
    else
      raise ex_unknown_matching;
    end if;

    -- ������������� � OEM 866
    if p_is_convert2dos = 1 then
      l_buff := convert(replace_ukrsmb2dos(l_buff), 'RU8PC866', 'CL8MSWIN1251');
    end if;

    p_file_buff := bars.lob_utl.clob_to_blob(l_buff);
  exception
    when ex_unknown_matching then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_MATCHING', to_char(p_matching_tp));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERROR_MATCHING', to_char(p_matching_tp), dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end do_matching;

  -----------------------------------------------------------------------------------------
  --  set_file_content
  --
  --    ����� ����������� ����� �� �����
  --
  --      p_content_id      - id ������
  --      p_value           - blob ����
  --      p_content_type_id - ��� ��������
  --      p_file_id         - id �����
  --
  procedure set_file_content(p_content_id       in out msp_file_content.id%type,
                             p_value            in blob,
                             p_content_type_id  in msp_file_content.type_id%type default null,
                             p_file_id          in msp_file_content.file_id%type default null)
  is
    ex_no_parameter exception;
  begin
    if coalesce(p_content_id, 0) <= 0 then
      if p_content_type_id is null or p_file_id is null then
        raise ex_no_parameter;
      end if;

      insert into msp_file_content (id, type_id, file_id, bvalue)
      values (msp_file_content_seq.nextval, p_content_type_id, p_file_id, p_value)
      returning id into p_content_id;
    else
      update msp_file_content set bvalue = p_value where id = p_content_id;
      if sql%rowcount = 0 then
        raise ex_no_file;
      end if;
    end if;
  exception
    when ex_no_file then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_FILE_CONTENT', to_char(p_content_id));
    when ex_no_parameter then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_FILECONTENT_PARAMETER', to_char(p_content_type_id), to_char(p_file_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERRWRITE_FILE_CONTENT', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end set_file_content;

  -----------------------------------------------------------------------------------------
  --  set_env_content
  --
  --    ����� ����������� ����� �� �����
  --
  --      p_content_id      - id ������
  --      p_value           - clob ����
  --      p_content_type_id - ��� ��������
  --
  procedure set_env_content(p_id      in msp_env_content.id%type,
                            p_value   in clob,
                            p_type_id in msp_env_content.type_id%type,
                            p_ecp     in clob)
  is
    ex_no_parameter exception;
    ct_fname        constant varchar2(20 char) := '_OBU_[FNAME].ZIP.P7S';
    l_filename      msp_env_content.filename%type := case p_type_id when 1 then 'CTLPAY'||ct_fname when 2 then 'RESPAY'||ct_fname else null end;
  begin
    if p_type_id is null then
      raise ex_no_parameter;
    end if;

    merge into msp_env_content e
    using (select * from msp_envelopes t where t.id = p_id) t on (e.id = t.id and e.type_id = p_type_id)
    when matched then
      update set e.cvalue = p_value, e.ecp = p_ecp
    when not matched then
      insert values (p_id, p_type_id, null, replace(l_filename, '[FNAME]',substr(upper(t.filename),12,25)), sysdate, p_ecp, p_value); -- replace(replace(upper(t.filename), 'REQPAY', 'CTLPAY'), '.P7S.P7S', '.P7S')

    if sql%rowcount = 0 then
      raise ex_no_file;
    end if;
  exception
    when ex_no_file then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_FILE_CONTENT', to_char(p_id));
    when ex_no_parameter then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_FILECONTENT_PARAMETER', to_char(p_type_id));
    when others then
      bars.bars_error.raise_nerror (gc_mod_code, 'ERRWRITE_FILE_CONTENT', dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end set_env_content;

  -----------------------------------------------------------------------------------------
  --  read_env_content
  --
  --    ������ ������� ����� ���������� ����� �� ��������
  --
  function read_env_content(p_id      in msp_env_content.id%type,
                            p_type_id in msp_env_content.type_id%type) return msp_env_content%rowtype
  is
    l_msp_env_content msp_env_content%rowtype;
  begin
    select * into l_msp_env_content from msp_env_content where id = p_id and type_id = p_type_id;
    return l_msp_env_content;
  end read_env_content;

  -----------------------------------------------------------------------------------------
  --  set_file_record2pay
  --
  --    ��������� �������������� ����� � ������
  --
  procedure set_file_record2pay(p_file_record_id in msp_file_records.id%type)
  is
    l_state_id           msp_file_records.state_id%type;
    ex_include_violation exception;
  begin
    select state_id into l_state_id from msp_file_records where id = p_file_record_id;

    if l_state_id in (0) then
      raise ex_include_violation;
    else
      set_file_record_state(p_file_record_id => p_file_record_id, p_state_id => 0);
      bars_audit.info('msp.msp_utl.set_file_record2pay, p_file_record_id='||to_char(p_file_record_id)||', l_state_id='||to_char(l_state_id));
    end if;
  exception
    when ex_include_violation then
      raise_application_error(-20000, '���������� �������� � ������ ����� �� �������� '||to_char(l_state_id));
    when no_data_found then
      bars.bars_error.raise_nerror (gc_mod_code, 'UNKNOWN_FILEREC_STATUS', to_char(p_file_record_id));
    when others then
      raise;
  end set_file_record2pay;

  -----------------------------------------------------------------------------------------
  --  set_file_for_pay
  --
  --    �������� ����� �� ������
  --
  procedure set_file_for_pay(p_file_id in msp_files.id%type)
  is
    l_state_id           msp_file_records.state_id%type;
    ex_include_violation exception;
  begin
    update msp_file_records set state_id = 19 where file_id = p_file_id and state_id = 0;
    set_file_state(p_file_id  => p_file_id,
                   p_state_id => 8);
    bars_audit.info('msp.msp_utl.set_file_for_pay, p_file_id='||to_char(p_file_id));
  exception
    when no_data_found then
      raise_application_error(-20000, '³����� ��� ��� ������ ��� ����� file_id='||to_char(p_file_id));
    when others then
      raise_application_error(-20000, '������� ������ file_id='||to_char(p_file_id)||' '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end set_file_for_pay;

  -----------------------------------------------------------------------------------------
  --  set_file_record_blocked
  --
  --    ��������� ������������� ����� � ������
  --
  procedure set_file_record_blocked(p_file_record_id in msp_file_records.id%type,
                                    p_comment        in msp_file_records.comm%type,
                                    p_block_type_id  in msp_file_records.block_type_id%type)
  is
  begin
    set_file_record_state(p_file_record_id => p_file_record_id,
                          p_state_id       => case p_block_type_id when 5 then 14 else 0 end,
                          p_comment        => p_comment);
  end set_file_record_blocked;

  -----------------------------------------------------------------------------------------
  --  set_match_create
  --
  --    ��������� ����� "��������� 1/2 ����������" ��� ��������
  --
  procedure set_match_create(p_envelope_id in msp_envelopes.id%type,
                             p_matching_tp in number)
  is
  begin
    set_state_envelope(p_id    => p_envelope_id,
                       p_state => case p_matching_tp when 1 then msp_const.st_env_MATCH1_CREATED/*11 - ��������� 1 ����������*/
                                                     when 2 then msp_const.st_env_MATCH2_CREATED/*16 - ��������� 2 ����������*/
                                  end);
  end set_match_create;

  -----------------------------------------------------------------------------------------
  --  set_match_processing
  --
  --    ��������� ����� "��������� 1/2 � ������ ����������" ��� ��������
  --
  procedure set_match_processing(p_envelope_id in msp_envelopes.id%type,
                                 p_matching_tp in simple_integer)
  is
    l_state      msp_envelopes.state%type;
    l_state_name msp_envelope_state.name%type;
    l_new_state  msp_envelopes.state%type;
    l_cnt        number;
    l_cnt_10     number;
  begin
    select s.id, s.name
    into l_state, l_state_name
    from msp_envelopes e
         inner join msp_envelope_state s on s.id = e.state
    where e.id = p_envelope_id;

    --dbms_output.put_line('l_state='||to_char(l_state));
    --dbms_output.put_line('l_state_name='||l_state_name);

    select sum(case when f.state_id in (9) then 1 else 0 end) cnt_10,
           count(1) cnt
    into l_cnt_10, l_cnt
    from msp_envelope_files_info fi
         inner join msp_files f on f.id = fi.id_file
    where fi.id = p_envelope_id;

    --dbms_output.put_line('l_cnt_10='||to_char(l_cnt_10));
    --dbms_output.put_line('l_cnt='||to_char(l_cnt));

    case
      when p_matching_tp = 1 and l_state in (0,11,13,15) and l_cnt_10 = 0 /*������ ������� ������*/ then
        l_new_state := msp_const.st_env_MATCH1_PROCESSING; /*9 - ��������� 1 � ������ ����������*/
      when p_matching_tp = 2 and l_state in (0,11,14,16,18,20) and l_cnt_10 = l_cnt /*�� ������ �������*/ then
        l_new_state := msp_const.st_env_MATCH2_PROCESSING; /*10 - ��������� 2 � ������ ����������*/
      else
        raise_application_error(-20000, '���������� ��������� ���������� � ������ ������ �������� ("' || l_state_name || '")');
    end case;

    set_state_envelope(p_id    => p_envelope_id,
                       p_state => l_new_state);
  end set_match_processing;

  -----------------------------------------------------------------------------------------
  --  make_zip
  --
  --    ���������� ������ �� ������ �����
  --
  --
  function make_zip(p_files in t_file_array) return blob
  is
    l_buff blob;
  begin
    for i in p_files.first..p_files.last
    loop
      bars.as_zip.add1file(p_zipped_blob => l_buff,
                           p_name        => p_files(i).file_name,
                           p_content     => p_files(i).file_buff);
    end loop;
    bars.as_zip.finish_zip(p_zipped_blob => l_buff);
    return l_buff;
  end;


  -----------------------------------------------------------------------------------------
  --  make_matching
  --
  --    ������� ����� �� ������� ZIP ����� ��������� 1/2
  --
  --      p_envelope_id - id ��������
  --      p_matching_tp - ��� ��������� (1/2)
  --      p_is_convert2dos - ������ 1 - ������������ � cp866 / 0 - �
  --
  function make_matching(p_envelope_id    in msp_envelopes.id%type,
                         p_matching_tp    in simple_integer default 1,
                         p_is_convert2dos in simple_integer default 1
                         ) return blob
  is
    l_buff blob;
    --l_content_id msp_file_content.id%type;
    l_file_array t_file_array := t_file_array();
  begin
    dbms_lob.createtemporary(l_buff, true);

    for i in (select id_file id, filename, filepath from msp_envelope_files_info t where t.id = p_envelope_id)
    loop
      do_matching(p_file_id        => i.id,
                  p_file_buff      => l_buff,
                  p_matching_tp    => p_matching_tp,
                  p_is_convert2dos => p_is_convert2dos);

      l_file_array.extend;
      l_file_array(l_file_array.last).file_name := i.filepath;
      l_file_array(l_file_array.last).file_buff := l_buff;
    end loop;

    if l_file_array.count = 0 then
      raise no_data_found;
    else
      l_buff := make_zip(p_files => l_file_array);
    end if;

    return l_buff;
  exception
    when no_data_found then
      raise_application_error(-20000, '������� ���������� ������ ��������� '||to_char(p_matching_tp)||' ³����� ��� ��� ���������� ���������.');
    when others then
      raise_application_error(-20000, '������� ���������� ������ ��������� '||to_char(p_matching_tp)||' '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end make_matching;

  -----------------------------------------------------------------------------------------
  --  get_matching2encode
  --
  --    ������� ���� xml ���� ��������� ��� ����������
  --
  function get_matching_xml(p_matching_tp    in simple_integer,
                            p_id_msp         in msp_envelopes.id_msp_env%type,
                            p_filename       in varchar2,
                            p_file           in clob,
                            p_filedate       in date,
                            p_ecp            in clob,
                            p_count_verified in number,
                            p_count_total    in number default null,
                            p_count_error    in number default null,
                            p_count_paid     in number default null
                            ) return blob
  is
    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_item_element dbms_xmldom.domelement;
    l_item_node    dbms_xmldom.domnode;
    l_item_text    dbms_xmldom.domtext;
    l_head_node    dbms_xmldom.domnode;
    l_item_tnode   dbms_xmldom.domnode;
    --
    l_buff         clob;
    l_retval       blob;
    --
    l_code         varchar2(30);
    l_from         varchar2(30);
    l_to           varchar2(30);
    l_partnumber   number(2);
    l_parttotal    number(2);
    l_filedate     varchar2(14) := to_char(p_filedate,'ddmmyyyy')||'000000';--18122017000000
  begin
    dbms_lob.createtemporary(l_buff, true, 12);
    l_buff := p_file;
    --l_buff := bars.lob_utl.blob_to_clob(p_file);

    l_domdoc    := dbms_xmldom.newdomdocument;
    l_root_node := dbms_xmldom.makenode(l_domdoc);
    l_head_node := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'upszn_issuess')));

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'id_mcp',
                     p_node_text => p_id_msp);

    add_clb_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'file',
                     p_node_text_clob => l_buff);

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'filename',
                     p_node_text => p_filename);

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'filedate',
                     p_node_text => l_filedate);

    add_clb_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'file_ecp',
                     p_node_text_clob => p_ecp);

    if p_matching_tp in (1) then
      add_txt_node_utl(p_document  => l_domdoc,
                       p_host_node => l_head_node,
                       p_node_name => 'count_total',
                       p_node_text => to_char(p_count_total));

      add_txt_node_utl(p_document  => l_domdoc,
                       p_host_node => l_head_node,
                       p_node_name => 'count_error',
                       p_node_text => to_char(p_count_error));

    elsif p_matching_tp in (2) then
      add_txt_node_utl(p_document  => l_domdoc,
                       p_host_node => l_head_node,
                       p_node_name => 'count_paid',
                       p_node_text => to_char(p_count_paid));
    end if;

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'count_verified',
                     p_node_text => to_char(p_count_verified));

    dbms_lob.createtemporary(l_buff, true, 12);

    dbms_xmldom.writetoclob(l_domdoc, l_buff);
    dbms_xmldom.freedocument(l_domdoc);

    l_buff := '<?xml version="1.0" encoding="utf-8"?>'||l_buff;

    l_retval := bars.lob_utl.clob_to_blob(l_buff);

    return l_retval;
  end get_matching_xml;

  -----------------------------------------------------------------------------------------
  --  get_matching2sign
  --
  --    ������� ����� �� ������� ������� ZIP ����� ��������� 1/2
  --
  --      p_stage          - ����     - 1 - ��������� �����, 2 - ���������� �����
  --      p_is_convert2dos - ������ 1 - ������������ � cp866 / 0 - �
  --
  function get_matching2sign(p_stage          in simple_integer,
                             p_is_convert2dos in simple_integer default 1) return t_match_array pipelined
  is
    l_buff            blob;
    --l_content_id msp_file_content.id%type;
    l_file_array      t_file_array;
    l_match_array     t_match_array := t_match_array();
    l_msp_env_content msp_env_content%rowtype;
    l_count_total     number(38,0);
    l_count_error     number(38,0);
    l_count_verified  number(38,0);
    l_count_paid      number(38,0);
  begin
    dbms_lob.createtemporary(l_buff, true);
    for r in (select e.id,
                     case when e.state in (msp_const.st_env_MATCH1_PROCESSING/*9*/, msp_const.st_env_MATCH1_SIGN_WAIT/*12*/) then 1
                          when e.state in (msp_const.st_env_MATCH2_PROCESSING/*10*/, msp_const.st_env_MATCH2_SIGN_WAIT/*17*/) then 2
                     end matching_tp,
                     case e.state when msp_const.st_env_MATCH1_PROCESSING/*9*/ then msp_const.st_env_MATCH1_CREATE_ERROR /*13*/
                                  when msp_const.st_env_MATCH1_SIGN_WAIT /*12*/ then msp_const.st_env_MATCH1_ENV_CREATE_ERROR /*15*/
                                  when msp_const.st_env_MATCH2_PROCESSING/*10*/ then msp_const.st_env_MATCH2_CREATE_ERROR /*18*/
                                  when msp_const.st_env_MATCH2_SIGN_WAIT /*17*/ then msp_const.st_env_MATCH2_ENV_CREATE_ERROR /*20*/
                     end errst,
                     e.state,
                     e.id_msp_env
              from msp_envelopes e
                   inner join msp_envelope_state s on s.id = e.state
              where lower(e.code) in ('payment_data')
                    and e.state in (case p_stage when 1 then 9
                                                 when 2 then 12
                                    end,
                                    case p_stage when 1 then 10
                                                 when 2 then 17
                                    end)
              /*select e.id,
                     case when p_stage = 1 and p_matching_tp = 1 then msp_const.st_env_MATCH1_CREATE_ERROR/ *13* /
                          when p_stage = 2 and p_matching_tp = 1 then msp_const.st_env_MATCH1_ENV_CREATE_ERROR/ *15* /
                          when p_stage = 1 and p_matching_tp = 2 then msp_const.st_env_MATCH2_CREATE_ERROR/ *18* /
                          when p_stage = 2 and p_matching_tp = 2 then msp_const.st_env_MATCH2_ENV_CREATE_ERROR/ *20* /
                     end errst,
                     e.state,
                     e.id_msp_env
              from msp_envelopes e
                   inner join msp_envelope_state s on s.id = e.state
              where lower(e.code) in ('payment_data')
                    and (p_matching_tp = 1 and (p_stage = 1 and e.state in (0,11,13) or p_stage = 2 and e.state in (12,15))
                      or p_matching_tp = 2 and (p_stage = 1 and e.state in (0,11,14,16,18) or p_stage = 2 and e.state in (17,20))
                        )*/
             )
    loop
      l_file_array := t_file_array();

      -- ��������� 1/2 - ��������� zip � �����
      if p_stage = 1 and r.state in (9,10) then --(0,11,13,14,16,18) then
        begin
          for i in (select id_file, filename, filepath
                    from msp_envelope_files_info t
                    where id = r.id)
          loop
            do_matching(p_file_id        => i.id_file,
                        p_file_buff      => l_buff,
                        p_matching_tp    => r.matching_tp,
                        p_is_convert2dos => p_is_convert2dos);

            l_file_array.extend;
            l_file_array(l_file_array.last).file_name := i.filepath;
            l_file_array(l_file_array.last).file_buff := l_buff;
          end loop;
        exception
          when others then
            set_state_envelope_async(r.id, r.errst, dbms_utility.format_error_backtrace || ' ' || sqlerrm); -- ������� ���������� ��������� 1 -- MATCH1_CREATE_ERROR
            l_file_array := t_file_array();
        end;

        if l_file_array.count = 0 then
          l_buff := null;
        else
          l_buff := make_zip(p_files => l_file_array);
        end if;
      -- 12 -- ������� ��������� 1 ������� �� ���������� �����
      -- 17 -- ������� ��������� 2 ������� �� ���������� �����
      elsif p_stage = 2 and r.state in (12,17) then --(12,15,17,20) then
        l_msp_env_content := read_env_content(p_id      => r.id,
                                              p_type_id => r.matching_tp);
        select count(1) count_total, 
               case when r.matching_tp in (1) then 
                 sum(case when fr.state_id between 1 and 6 then 1 else 0 end) 
                 else 0 end count_error,
               sum(case when r.matching_tp in (1) and fr.state_id not in (-1,1,2,3,4,5,6) /*in (0,19,20)*/  then 1 -- (1) ʳ������ ����� �����, �� ����������� ������. ������ ���������������� �� ����� ������
                        when r.matching_tp in (2) and fr.state_id in (10,17,14) then 1 -- (2) ʳ������ ����� �����, �� ���� ������������ ������
                   else 0 end) count_verified, 
               case when r.matching_tp in (2) then sum(case when fr.state_id in (10) then 1 else 0 end) else 0 end count_paid
        into l_count_total, 
             l_count_error, 
             l_count_verified,
             l_count_paid
        from msp_envelope_files_info fi
             inner join msp_file_records fr on fr.file_id = fi.id_file
        where fi.id = r.id;

        l_buff := get_matching_xml(p_matching_tp    => r.matching_tp,
                                   p_id_msp         => r.id_msp_env,
                                   p_filename       => l_msp_env_content.filename,
                                   p_file           => l_msp_env_content.cvalue,
                                   p_filedate       => l_msp_env_content.insert_dttm,
                                   p_ecp            => l_msp_env_content.ecp,
                                   p_count_verified => l_count_verified,
                                   p_count_total    => l_count_total,
                                   p_count_error    => l_count_error,
                                   p_count_paid     => l_count_paid);
      end if;

      l_match_array.extend;
      l_match_array(l_match_array.last).id := r.id;
      l_match_array(l_match_array.last).bvalue := l_buff;

      pipe row(l_match_array(l_match_array.last));
    end loop;
  exception
    when others then
      raise_application_error(-20000, '������� � ������� get_matching. '||' '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end get_matching2sign;

  -----------------------------------------------------------------------------------------
  --  save_matching
  --
  --    ��������� ������ ������������ ����� ��������� 1/2
  --
  --      p_envelope_id - id ��������
  --      p_file_buff   - clob ����� �����
  --      p_ecp         - ��������������� � ������� ���������� ��� 2 �� ������� ���� �� ��������
  --
  procedure save_matching(p_envelope_id in msp_envelopes.id%type,
                          p_file_buff   in clob,
                          p_ecp         in clob default null)
  is
    l_state       msp_envelopes.state%type;
    l_matching_tp number;
    l_errst       number;
    l_new_state   number;
    ex_unknown_matching exception;
    l_buff        blob;
  begin
    select state into l_state from msp_envelopes where id = p_envelope_id;

    l_errst := case when l_state = msp_const.st_env_MATCH1_PROCESSING then msp_const.st_env_MATCH1_CREATE_ERROR
                    when l_state = msp_const.st_env_MATCH1_SIGN_WAIT then msp_const.st_env_MATCH1_ENV_CREATE_ERROR
                    when l_state = msp_const.st_env_MATCH2_PROCESSING then msp_const.st_env_MATCH2_CREATE_ERROR
                    when l_state = msp_const.st_env_MATCH2_SIGN_WAIT then msp_const.st_env_MATCH2_ENV_CREATE_ERROR
               end;

    if l_state = msp_const.st_env_MATCH1_PROCESSING then
      l_new_state   := msp_const.st_env_MATCH1_SIGN_WAIT; -- 12 -- ��������� 1 ������ �� ���������
      l_matching_tp := 1;
    elsif l_state = msp_const.st_env_MATCH1_SIGN_WAIT then -- 12
      l_new_state   := msp_const.st_env_MATCH1_CREATED; -- 11 -- ��������� 1 ����������
      l_matching_tp := 1;
    elsif l_state = msp_const.st_env_MATCH2_PROCESSING then
      l_new_state   := msp_const.st_env_MATCH2_SIGN_WAIT; -- 17 -- ��������� 2 ������ �� ���������
      l_matching_tp := 2;
    elsif l_state = msp_const.st_env_MATCH2_SIGN_WAIT then -- 17
      l_new_state   := msp_const.st_env_MATCH2_CREATED; -- 16 -- ��������� 2 ����������
      l_matching_tp := 2;
    else
      raise ex_unknown_matching;
    end if;

    set_env_content(p_id      => p_envelope_id,
                    p_value   => p_file_buff,
                    p_type_id => l_matching_tp,
                    p_ecp     => p_ecp);

    set_state_envelope(p_envelope_id,l_new_state);
  exception
    when ex_unknown_matching then
      -- ������ �� ���� ��� ���� ��������
      set_state_envelope(p_envelope_id, l_state, '������� ���������� ����� ���������. �������� ������ (state='||to_char(l_state)||') �������� �� �������� �������� ����.');
    when others then
      -- ���� ������ � ���� ��������
      set_state_envelope(p_envelope_id, l_errst, '������� ���������� ����� ���������. '||' '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end save_matching;

  -----------------------------------------------------------------------------------------
  --  decodeclobfrombase64
  --
  --    decodeclobfrombase64
  --
  function decodeclobfrombase64(p_clob clob) return clob is
    l_clob   clob;
    l_len    number;
    l_pos    number := 1;
    l_buf    varchar2(32767);
    l_amount number := 16000;
  begin
    l_len := dbms_lob.getlength(p_clob);
    dbms_lob.createtemporary(l_clob, true);

    while l_pos <= l_len
    loop
      dbms_lob.read(p_clob, l_amount, l_pos, l_buf);
      l_buf := utl_encode.text_decode(l_buf, encoding => utl_encode.base64);
      l_pos := l_pos + l_amount;
      dbms_lob.writeappend(l_clob, length(l_buf), l_buf);
    end loop;

    return l_clob;
  end decodeclobfrombase64;

  function encodeclobtobase64(p_clob clob) return clob is
    l_clob   clob;
    l_len    number;
    l_pos    number := 1;
    l_buf    varchar2(32767);
    l_amount number := 32767;
  begin
    l_len := dbms_lob.getlength(p_clob);
    dbms_lob.createtemporary(l_clob, true);

    while l_pos <= l_len
    loop
      dbms_lob.read(p_clob, l_amount, l_pos, l_buf);
      l_buf := utl_encode.text_encode(l_buf, encoding => utl_encode.base64);
      l_pos := l_pos + l_amount;
      dbms_lob.writeappend(l_clob, length(l_buf), l_buf);
    end loop;

    return l_clob;
  end encodeclobtobase64;

    function base64decode_to_blob(p_clob clob)
      return blob
    is
      l_blob    blob;
      l_raw     raw(32767);
      l_amt     number := 7700;
      l_offset  number := 1;
      l_temp    varchar2(32767);
    begin
      begin
        dbms_lob.createtemporary (l_blob, false, dbms_lob.call);
        loop
          dbms_lob.read(p_clob, l_amt, l_offset, l_temp);
          l_offset := l_offset + l_amt;
          l_raw    := utl_encode.base64_decode(utl_raw.cast_to_raw(l_temp));
          dbms_lob.append (l_blob, to_blob(l_raw));
        end loop;
      exception
        when no_data_found then
          null;
      end;
      return l_blob;
    end;

    function utf8todeflang(p_clob in    clob) return clob is
      l_blob blob;
      l_clob clob;
      l_dest_offset   integer := 1;
      l_source_offset integer := 1;
      l_lang_context  integer := DBMS_LOB.DEFAULT_LANG_CTX;
      l_warning       integer := DBMS_LOB.WARN_INCONVERTIBLE_CHAR;
    BEGIN
      DBMS_LOB.CREATETEMPORARY(l_blob, FALSE);
      DBMS_LOB.CONVERTTOBLOB
      (
       dest_lob    =>l_blob,
       src_clob    =>p_clob,
       amount      =>DBMS_LOB.LOBMAXSIZE,
       dest_offset =>l_dest_offset,
       src_offset  =>l_source_offset,
       blob_csid   =>0,
       lang_context=>l_lang_context,
       warning     =>l_warning
      );
      l_dest_offset   := 1;
      l_source_offset := 1;
      l_lang_context  := DBMS_LOB.DEFAULT_LANG_CTX;
      DBMS_LOB.CREATETEMPORARY(l_clob, FALSE);
      DBMS_LOB.CONVERTTOCLOB
      (
       dest_lob    =>l_clob,
       src_blob    =>l_blob,
       amount      =>DBMS_LOB.LOBMAXSIZE,
       dest_offset =>l_dest_offset,
       src_offset  =>l_source_offset,
       blob_csid   =>NLS_CHARSET_ID ('UTF8'),
       lang_context=>l_lang_context,
       warning     =>l_warning
      );
      return l_clob;
    end;

  -----------------------------------------------------------------------------------------
  --  read_request
  --
  --    ������� ������� ����� ������� msp_requests
  --
  function read_request(p_request_id in msp_requests.id%type) return msp_requests%rowtype
  is
    l_request msp_requests%rowtype;
  begin
    select * into l_request from msp_requests where id = p_request_id;
    return l_request;
  end read_request;

  -----------------------------------------------------------------------------------------
  --  read_request_xml
  --
  --    ������� ������� ����� ������� msp_requests
  --
  function read_request_xml(p_request_id in msp_requests.id%type) return msp_requests.req_xml%type
  is
    l_req_xml msp_requests.req_xml%type;
  begin
    select req_xml into l_req_xml from msp_requests where id = p_request_id;
    return l_req_xml;
  end read_request_xml;

  -----------------------------------------------------------------------------------------
  --  read_request_xml
  --
  --    ������� ���� xml-���� � ������� ��������� ��������� ����
  --
  function read_request_xml(p_request_data in clob) return dbms_xmldom.domnode
  is
    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_root_node varchar2(30) := 'request';
  begin
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_request_data);
    l_doc    := dbms_xmlparser.getdocument(l_parser);
    l_rows   := dbms_xmldom.getelementsbytagname(l_doc, l_root_node);
    return dbms_xmldom.item(l_rows, 0);
  end read_request_xml;

  -----------------------------------------------------------------------------------------
  --  get_request_data
  --
  --    ������� ������� ���� ���� "data" xml ������
  --
  function get_request_data(p_request_id in msp_requests.id%type) return clob
  is
    l_req_xml clob;
    l_data    clob;
    l_parser  dbms_xmlparser.parser;
    l_doc     dbms_xmldom.domdocument;
    l_rows    dbms_xmldom.domnodelist;
    l_row     dbms_xmldom.domnode;
  begin
    l_req_xml := read_request_xml(p_request_id);

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_req_xml);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'request');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
    loop
      l_row  := dbms_xmldom.item(l_rows, i);
      l_data := dbms_xslprocessor.valueof(l_row, 'data/text()');
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
    end loop;

    return l_data;
  exception
    when others then
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      raise;
  end get_request_data;

  -----------------------------------------------------------------------------------------
  --  get_request_data
  --
  --    ������� ������� ���� ���� "data" xml ������
  --
  function get_request_data(p_request_xml in clob) return clob
  is
    l_data    clob;
    l_parser  dbms_xmlparser.parser;
    l_doc     dbms_xmldom.domdocument;
    l_rows    dbms_xmldom.domnodelist;
    l_row     dbms_xmldom.domnode;
  begin
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_request_xml);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'request');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
    loop
      l_row  := dbms_xmldom.item(l_rows, i);
      l_data := dbms_xslprocessor.valueof(l_row, 'data/text()');
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
    end loop;

    return l_data;
  exception
    when others then
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      raise;
  end get_request_data;

  -----------------------------------------------------------------------------------------
  --  decode_request_data
  --
  --    ������� ������� ������������� ���� ����� ������ ��������
  --
  procedure decode_data(p_data in out nocopy clob)
  is
  begin
    -- fix
    p_data := replace(p_data, ' ', '+');
    -- decode
    p_data := decodeclobfrombase64(p_data);
    p_data := utf8todeflang(p_data);
  end decode_data;

  -----------------------------------------------------------------------------------------
  --  encode_data
  --
  --    ������� ������� ���������� ���� ����� ������ ��������
  --
  procedure encode_data(p_data in out nocopy clob)
  is
  begin
    --p_data := replace(replace(replace(p_data, chr(10), ''), chr(13), ''),' ', '');
    -- decode
    p_data := encodeclobtobase64(p_data);
    -- fix
    --p_data := replace(p_data, '+', ' ');
    --p_data := replace(replace(replace(p_data, '+', ' '), chr(10), ''), chr(13), '');
    --p_data := utf8todeflang(p_data);
  end encode_data;


  -----------------------------------------------------------------------------------------
  --  read_request_data
  --
  --    ������� ���� xml-���� � ������� ��������� ��������� ����
  --
  function read_request_data(p_request_data in clob,
                             p_act_type in msp_requests.act_type%type) return dbms_xmldom.domnode
  is
    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_root_node varchar2(30) := case p_act_type when msp_const.req_PAYMENT_DATA     then 'request' 
                                                when msp_const.req_DATA_STATE       then 'data_state_ask' 
                                                when msp_const.req_VALIDATION_STATE then 'validation_state_ask' 
                                                                                    else 'root' 
                                end;
  begin
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_request_data);
    l_doc    := dbms_xmlparser.getdocument(l_parser);
    l_rows   := dbms_xmldom.getelementsbytagname(l_doc, l_root_node);
    return dbms_xmldom.item(l_rows, 0);
  end read_request_data;

  -----------------------------------------------------------------------------------------
  --  read_states
  --
  --    ��������� ������ ����� ��'���� msp_requests, msp_envelopes, msp_files
  --
  procedure get_rq_st(p_idenv        in msp_envelopes.id_msp_env%type,
                      p_rq_st        in out nocopy varchar2, -- varchar2(1)
                      p_rq_st_detail in out nocopy number,   -- number(1)
                      p_rq_ecp_error in out nocopy varchar2,
                      p_id_msp       in out nocopy msp_envelope_files_info.id_msp%type) -- varchar2(1000)
  is
    l_env_state  msp_envelopes.state%type;
    l_req_state  msp_requests.state%type;
    l_req_id     msp_requests.id%type;
    l_file_state msp_files.state_id%type;
    l_env_comm   msp_envelopes.comm%type;
    l_req_comm   msp_requests.comm%type;
    l_file_comm  msp_files.comm%type;
    --
    ex_error_xml_envelope     exception; -- 3 -- ������� � �������� xml
    ex_error_ecp_envelope     exception; -- 1 -- ������� ��� ��� �����
    ex_error_ecp_request      exception; -- 6 � ������� ��� ��� ��������
    ex_error_unique_envelope  exception; -- 7 � ������� ���������� ��������
    ex_error_decrypt_envelope exception; -- 2 -- ������� ������������� ����� ��������
    ex_error_unpack_envelope  exception; -- 4 -- ������� ��� ������������� �����
    ex_parse_error            exception; -- 5 �- ������� ��� ������ �����
    ex_r                      exception;
    ex_s                      exception;
    ex_d                      exception;
    --
    procedure retval(rq_st_        in varchar2,
                     rq_st_detail_ in number default null,
                     rq_ecp_error_ in varchar2 default null)
    is
    begin
      p_rq_st        := rq_st_;
      p_rq_st_detail := rq_st_detail_;
      p_rq_ecp_error := rq_ecp_error_;
      return;
    end retval;
    --
  begin
    -- read msp_envelopes state
    begin
      select e.state, substrb(e.comm, 1000), e.id into l_env_state, l_env_comm, l_req_id from msp_envelopes e where e.id_msp_env = p_idenv;
    exception
      when no_data_found then
        -- ������� �� ���� �� ��������� ����� �� idenv �� ������ �����, ��� �� ������� � �������� xml ������������ � ������ ������ �������
        raise ex_d;
        --raise ex_error_xml_envelope;
      when others then
        raise;
    end;

    -- read msp_requests state
    begin
      select r.state, substrb(r.comm,1000) into l_req_state, l_req_comm from msp_requests r where r.id = l_req_id;
    exception
      when others then
        raise;
    end;

    if l_req_state = msp_const.st_req_ERROR_UNIQUE_ENVELOPE then -- 5
        -- 5 �- ������� ���������� ��������
        raise ex_error_unique_envelope;
    end if;

    -- read msp_files state
    begin
      select state, comm, id_msp
      into l_file_state, l_file_comm, p_id_msp
      from (
        select f.state, substrb(f.comm,1000) comm, f.id_msp,
               -- �������� ���� ������� ������ ����� ��� ���������� ������
               row_number() over (order by case when f.state in (2) then 1 when f.state in (-1,1,3,4) then 2 when f.state in (0) then 3 else 4 end) rn
        from msp_envelope_files_info f
        where f.id = l_req_id
        ) t where rn = 1;
    exception
      when others then
        raise;
    end;

    if l_req_state = msp_const.st_req_PARSED and l_env_state not in (-1,1,2,3,4) then
      if l_file_state = 0 then
        -- 0 �- ����� ��������� ������
        raise ex_s;
      elsif l_file_state = 2 then
        -- 2 -- PARSE_ERROR ������� ��������
        raise ex_parse_error;
      elsif l_file_state in (-1,1,3,4) then
        -- R �- ������� �� ������
        raise ex_r;
      end if;
    elsif l_req_state = msp_const.st_req_ERROR_ECP_REQUEST then -- 1
      -- 6 � ������� ��� ��� ��������
      raise ex_error_ecp_request;
    elsif l_req_state = msp_const.st_req_ERROR_DECRYPT_ENVELOPE then -- 2
      -- 2 -- ������� ������������� ����� ��������
      raise ex_error_decrypt_envelope;
    elsif l_req_state = msp_const.st_req_ERROR_UNPACK_ENVELOPE then -- 4
      -- 4 -- ������� ��� ������������� �����
      raise ex_error_unpack_envelope;
    elsif l_env_state = msp_const.st_env_ERROR_ECP_ENVELOPE then -- 1
      -- 1 -- ������� ��� ��� �����
      raise ex_error_ecp_envelope;
    else
      -- R �- ������� �� ������
      raise ex_r;
    end if;

  exception
    /*when ex_error_xml_envelope then
      retval(_rq_st => 'S', _rq_st_detail => 3);*/
    when ex_d then
      retval(rq_st_ => 'D');
    when ex_r then
      retval(rq_st_ => 'R');
    when ex_s then
      retval(rq_st_ => 'S', rq_st_detail_ => 0);
    when ex_error_ecp_request then
      retval(rq_st_ => 'S', rq_st_detail_ => 6, rq_ecp_error_ => l_req_comm);
    when ex_error_decrypt_envelope then
      retval(rq_st_ => 'S', rq_st_detail_ => 2/*, rq_ecp_error_ => l_req_comm*/);
    when ex_error_unpack_envelope then
      retval(rq_st_ => 'S', rq_st_detail_ => 4/*, rq_ecp_error_ => l_req_comm*/);
    when ex_error_ecp_envelope then
      retval(rq_st_ => 'S', rq_st_detail_ => 1, rq_ecp_error_ => l_env_comm);
    when ex_parse_error then
      retval(rq_st_ => 'S', rq_st_detail_ => 5/*, rq_ecp_error_ => l_file_comm*/);
    when ex_error_unique_envelope then
      retval(rq_st_ => 'S', rq_st_detail_ => 7/*, rq_ecp_error_ => l_file_comm*/);
    when others then
      raise_application_error(-20000, '������� � �������� ��������� data_state_answer. '|| chr(10) || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end get_rq_st;

  -----------------------------------------------------------------------------------------
  --  payment_data_answer
  --
  --    ������� ���� xml-���� ������ �� ����� payment_data
  --
  function get_payment_data_xml(p_idenv        in msp_envelopes.id_msp_env%type,
                                --p_id_msp       in msp_envelope_files_info.id_msp%type,
                                p_is_bad_xml   in simple_integer default 0) return clob
  is
    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_item_element dbms_xmldom.domelement;
    l_item_node    dbms_xmldom.domnode;
    l_item_text    dbms_xmldom.domtext;
    l_head_node    dbms_xmldom.domnode;
    l_item_tnode   dbms_xmldom.domnode;
    l_buff         clob;
    l_rq_st        varchar2(1) := 'S';
    l_rq_st_detail number(1);
  begin
    dbms_lob.createtemporary(l_buff, true, 12);

    l_domdoc    := dbms_xmldom.newdomdocument;
    l_root_node := dbms_xmldom.makenode(l_domdoc);

    if p_is_bad_xml in (0) then
      l_rq_st_detail := 0;
    else
      l_rq_st_detail := 3;
    end if;

    l_head_node    := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'request_transport_answer')));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'id_env');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, p_idenv);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'rq_st');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, l_rq_st);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'rq_st_detail');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, l_rq_st_detail);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    dbms_xmldom.writetoclob(l_domdoc, l_buff);
    dbms_xmldom.freedocument(l_domdoc);

    return '<?xml version="1.0" encoding="utf-8"?>'||l_buff;
  end get_payment_data_xml;

  -----------------------------------------------------------------------------------------
  --  data_state_answer
  --
  --    ������� ���� xml-���� ������ �� �����
  --
  function get_data_state_xml(--p_idenv        in msp_envelopes.id_msp_env%type,
                              p_id_msp       in msp_envelope_files_info.id_msp%type,
                              p_rq_st        in varchar2,
                              p_rq_st_detail in number,
                              p_rq_ecp_error in varchar2) return clob
  is
    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_item_element dbms_xmldom.domelement;
    l_item_node    dbms_xmldom.domnode;
    l_item_text    dbms_xmldom.domtext;
    l_head_node    dbms_xmldom.domnode;
    l_item_tnode   dbms_xmldom.domnode;
    l_buff         clob;
  begin
    dbms_lob.createtemporary(l_buff, true, 12);

    l_domdoc    := dbms_xmldom.newdomdocument;
    l_root_node := dbms_xmldom.makenode(l_domdoc);

    l_head_node    := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'data_state_answer')));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'id_msp');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, p_id_msp);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'rq_st');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, p_rq_st);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'rq_st_detail');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, p_rq_st_detail);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    l_item_element := dbms_xmldom.createelement(l_domdoc, 'rq_ecp_error');
    l_item_node    := dbms_xmldom.appendchild(l_head_node, dbms_xmldom.makenode(l_item_element));
    l_item_text    := dbms_xmldom.createtextnode(l_domdoc, p_rq_ecp_error);
    l_item_tnode   := dbms_xmldom.appendchild(l_item_node, dbms_xmldom.makenode(l_item_text));

    dbms_xmldom.writetoclob(l_domdoc, l_buff);
    dbms_xmldom.freedocument(l_domdoc);

    return '<?xml version="1.0" encoding="utf-8"?>'||l_buff;
  end get_data_state_xml;

  -----------------------------------------------------------------------------------------
  --  make_request_data
  --
  --    ������� ���� ���� ������ �� �����
  --
  function make_request_data(p_request_data in clob,
                             p_act_type     in msp_requests.act_type%type,
                             p_id_env       in out nocopy msp_envelopes.id_msp_env%type,
                             p_is_bad_xml   in simple_integer default 0,
                             p_env_rq_st    out varchar2) return clob
  is
    l_buff         clob;
    l_row          dbms_xmldom.domnode;
    l_rq_st        varchar2(1);
    l_rq_st_detail number(1);
    l_rq_ecp_error varchar2(1000);
    l_id_msp       msp_envelope_files_info.id_msp%type;
    l_envelope_id  msp_envelopes.id%type;
    l_isencode64   boolean := true;
    -- �������� �� ���������� ��������� 2, ���� ��� �� ��������� ������ �������� 'D', ������ 'R'
    function get_match_rq_st return varchar2
    is
      l_cnt number;
    begin
      select count(1) 
      into l_cnt 
      from msp_env_content c 
      where id = p_id_env and type_id = 2;
      
      if l_cnt > 0 then
        return 'D';
      else 
        return 'R';
      end if;
    end get_match_rq_st;
    --
  begin
    begin
      -- ����� ��������� ������
      l_row := read_request_data(p_request_data, p_act_type);
      p_id_env := coalesce(to_number(dbms_xslprocessor.valueof(l_row, 'idenv/text()')), p_id_env);

      --dbms_output.put_line('p_id_env='||p_id_env);
      --dbms_output.put_line('p_request_data='||p_request_data);

      if p_act_type = msp_const.req_PAYMENT_DATA /*1*/ then
        -- ��������� xml ������
        l_buff := get_payment_data_xml(p_idenv        => p_id_env,
                                       p_is_bad_xml   => p_is_bad_xml);
      elsif p_act_type = msp_const.req_DATA_STATE /*3*/ then
        begin
          -- �������� ��������� ������
          get_rq_st(p_idenv        => p_id_env,
                    p_rq_st        => l_rq_st,
                    p_rq_st_detail => l_rq_st_detail,
                    p_rq_ecp_error => l_rq_ecp_error,
                    p_id_msp       => l_id_msp);
          -- ��������� xml ������
          l_buff := get_data_state_xml(p_id_msp       => l_id_msp,
                                       p_rq_st        => l_rq_st,
                                       p_rq_st_detail => l_rq_st_detail,
                                       p_rq_ecp_error => l_rq_ecp_error);
        exception
          when others then
            if sqlcode = -31011 then -- ������� ��������� ���������� xml �����
              l_buff := get_data_state_xml(p_id_msp       => null,
                                           p_rq_st        => 'S',
                                           p_rq_st_detail => 3,
                                           p_rq_ecp_error => null);
            else
              raise;
            end if;
        end;
      elsif p_act_type = msp_const.req_VALIDATION_STATE /*4*/ then
        begin
          select id into l_envelope_id from msp_envelopes e where e.id_msp_env = p_id_env;
          -- ��������� xml ������
          --dbms_output.put_line('p_envelope_id='||to_char(p_envelope_id));
          select cvalue
                 --bars.lob_utl.blob_to_clob(bvalue) 
          into l_buff 
          from msp_env_content c 
          where id = l_envelope_id and type_id = 1;

          p_env_rq_st  := 'S';
          l_isencode64 := false;
        exception
          when no_data_found then
            p_env_rq_st := get_match_rq_st;
        end;
      elsif p_act_type = msp_const.req_PAYMENT_STATE /*5*/ then
        begin
          select id into l_envelope_id from msp_envelopes e where e.id_msp_env = p_id_env;
          -- ��������� xml ������
          select cvalue
          into l_buff 
          from msp_env_content c 
          where id = l_envelope_id and type_id = 2;

          p_env_rq_st  := 'S';
          l_isencode64 := false;
        exception
          when no_data_found then
            p_env_rq_st := 'R';
        end;
      end if;
    exception
      when others then
        raise;
    end;
    dbms_output.put_line(l_buff);
    -- ������������ � base64
    if l_buff is not null and l_isencode64 then
      encode_data(l_buff);
    end if;

    return l_buff;
  end make_request_data;

  -----------------------------------------------------------------------------------------
  --  make_envelope
  --
  --    ������� ���� xml ������� �� �����
  --
  function make_envelope(p_action_name in varchar2,
                         p_idenv       in number,
                         p_data        in clob default null,
                         p_env_rq_st   in varchar2 default null) return clob
  is
    l_domdoc       dbms_xmldom.domdocument;
    l_root_node    dbms_xmldom.domnode;
    l_item_element dbms_xmldom.domelement;
    l_item_node    dbms_xmldom.domnode;
    l_item_text    dbms_xmldom.domtext;
    l_head_node    dbms_xmldom.domnode;
    l_item_tnode   dbms_xmldom.domnode;
    --
    l_buff         clob;
    --
    l_code         varchar2(30);
    l_from         varchar2(30);
    l_to           varchar2(30);
    l_partnumber   number(2);
    l_parttotal    number(2);
  begin
    dbms_lob.createtemporary(l_buff, true, 12);

    l_domdoc    := dbms_xmldom.newdomdocument;
    l_root_node := dbms_xmldom.makenode(l_domdoc);
    l_head_node := dbms_xmldom.appendchild(l_root_node, dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc, 'request')));

    l_from       := 'Bars';
    l_to         := 'IOC';
    l_partnumber := 1;
    l_parttotal  := 1;

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'code',
                     p_node_text => p_action_name);

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'idenv',
                     p_node_text => to_char(p_idenv));

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'from',
                     p_node_text => l_from);

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'to',
                     p_node_text => l_to);

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'partnumber',
                     p_node_text => to_char(l_partnumber));

    add_txt_node_utl(p_document  => l_domdoc,
                     p_host_node => l_head_node,
                     p_node_name => 'parttotal',
                     p_node_text => to_char(l_parttotal));

    add_clb_node_utl(p_document       => l_domdoc,
                     p_host_node      => l_head_node,
                     p_node_name      => 'data',
                     p_node_text_clob => p_data);

    if p_env_rq_st is not null then
      add_txt_node_utl(p_document  => l_domdoc,
                       p_host_node => l_head_node,
                       p_node_name => 'rq_st',
                       p_node_text => p_env_rq_st);
    end if;

    dbms_xmldom.writetoclob(l_domdoc, l_buff);
    dbms_xmldom.freedocument(l_domdoc);

    return '<?xml version="1.0" encoding="utf-8"?>'||l_buff;
  end make_envelope;

  -----------------------------------------------------------------------------------------
  --  check_xml
  --
  --    �������� ���������� xml ������
  --
  function check_is_bad_xml(p_xml in clob) return simple_integer
  is
    l_data    clob;
    l_parser  dbms_xmlparser.parser;
  begin
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_xml);

    return 0;
  exception
    when others then
      dbms_xmlparser.freeparser(l_parser);
      return 1;
  end check_is_bad_xml;

  -----------------------------------------------------------------------------------------
  --  payment_data_ans
  --
  --    ϳ�������� ������ �� ����� payment_data
  --
  function payment_data_ans(p_request    in msp_requests%rowtype,
                            p_id_env     in out nocopy msp_envelopes.id_msp_env%type,
                            p_is_bad_xml in simple_integer) return clob
  is
    l_buff      clob;
    l_env_rq_st varchar2(1);
  begin
    l_buff := make_request_data(p_request.req_xml, p_request.act_type, p_id_env, p_is_bad_xml, l_env_rq_st);
    l_buff := make_envelope(p_action_name => 'payment_data_ans',
                            p_idenv       => p_id_env,
                            p_data        => l_buff);
    return l_buff;
  end payment_data_ans;

  -----------------------------------------------------------------------------------------
  --  data_state_ans
  --
  --    ϳ�������� ������ �� ����� data_state
  --
  function data_state_ans(p_request    in msp_requests%rowtype,
                          p_id_env     in out nocopy msp_envelopes.id_msp_env%type,
                          p_is_bad_xml in simple_integer) return clob
  is
    l_buff      clob;
    l_env_rq_st varchar2(1);
  begin
    l_buff := get_request_data(p_request.req_xml);
    -- ������������ �� base64
    decode_data(l_buff);
    -- ��������� ����� ������
    l_buff := make_request_data(l_buff, p_request.act_type, p_id_env, p_is_bad_xml, l_env_rq_st);
    -- ��������� ��������
    l_buff := make_envelope(p_action_name => 'data_state_ans',
                            p_idenv       => p_id_env,
                            p_data        => l_buff);
    -- set_state_request = 0
    msp_utl.set_state_request(p_request.id, 0);
    return l_buff;
  end data_state_ans;

  -----------------------------------------------------------------------------------------
  --  validation_state_ans
  --
  --    ϳ�������� ������ �� ����� validation_state
  --
  function validation_state_ans(p_request    in msp_requests%rowtype,
                                p_id_env     in out nocopy msp_envelopes.id_msp_env%type,
                                p_is_bad_xml in simple_integer) return clob
  is
    l_buff      clob;
    l_env_rq_st varchar2(1);
  begin
    l_buff := get_request_data(p_request.req_xml);
    -- ������������ �� base64
    decode_data(l_buff);
    -- ��������� ����� ������
    l_buff := make_request_data(l_buff, p_request.act_type, p_id_env, p_is_bad_xml, l_env_rq_st);
    -- ��������� ��������
    l_buff := make_envelope(p_action_name => 'validation_state_answer',
                            p_idenv       => p_id_env,
                            p_data        => l_buff,
                            p_env_rq_st   => l_env_rq_st);
    -- set_state_request = 0
    msp_utl.set_state_request(p_request.id, 0);
    return l_buff;
  end validation_state_ans;

  -----------------------------------------------------------------------------------------
  --  payment_state_ans
  --
  --    ϳ�������� ������ �� ����� payment_state
  --
  function payment_state_ans(p_request    in msp_requests%rowtype,
                             p_id_env     in out nocopy msp_envelopes.id_msp_env%type,
                             p_is_bad_xml in simple_integer) return clob
  is
    l_buff      clob;
    l_env_rq_st varchar2(1);
  begin
    l_buff := get_request_data(p_request.req_xml);
    -- ������������ �� base64
    decode_data(l_buff);
    -- ��������� ����� ������
    l_buff := make_request_data(l_buff, p_request.act_type, p_id_env, p_is_bad_xml, l_env_rq_st);
    -- ��������� ��������
    l_buff := make_envelope(p_action_name => 'payment_state_answer',
                            p_idenv       => p_id_env,
                            p_data        => l_buff,
                            p_env_rq_st   => l_env_rq_st);
    -- set_state_request = 0
    msp_utl.set_state_request(p_request.id, 0);
    return l_buff;
  end payment_state_ans;

  -----------------------------------------------------------------------------------------
  --  prepare_request_xml
  --
  --    ������� ���� xml ������� �� �����
  --
  function prepare_request_xml(p_request_id in msp_requests.id%type) return clob
  is
    l_buff       clob;
    l_request    msp_requests%rowtype;
    l_id_env     msp_envelopes.id_msp_env%type;
    l_row        dbms_xmldom.domnode;
    l_is_bad_xml simple_integer := 0;
  begin
    -- ������� ������
    l_request := read_request(p_request_id);

    -- �������� xml
    l_is_bad_xml := check_is_bad_xml(l_request.req_xml);

    -- ������ �������� idenv ��������, �� ������� ���� xml-data �����
    if l_is_bad_xml = 0 then
      l_row := read_request_xml(l_request.req_xml);
      l_id_env := to_number(dbms_xslprocessor.valueof(l_row, 'idenv/text()'));
    end if;

    if l_request.act_type = msp_const.req_PAYMENT_DATA then -- 1
      -- ��������� ����� ������ payment_data_ans
      l_buff := payment_data_ans(p_request    => l_request,
                                 p_id_env     => l_id_env,
                                 p_is_bad_xml => l_is_bad_xml);
    elsif l_request.act_type = msp_const.req_DATA_STATE then -- 3
      -- ��������� ����� ������ data_state_ans
      l_buff := data_state_ans(p_request    => l_request,
                               p_id_env     => l_id_env,
                               p_is_bad_xml => l_is_bad_xml);
    elsif l_request.act_type = msp_const.req_VALIDATION_STATE then -- 4
      -- ��������� ����� ������ validation_state_ans
      l_buff := validation_state_ans(p_request    => l_request,
                                     p_id_env     => l_id_env,
                                     p_is_bad_xml => l_is_bad_xml);
    elsif l_request.act_type = msp_const.req_PAYMENT_STATE then -- 5
      -- ��������� ����� ������ payment_state_ans
      l_buff := payment_state_ans(p_request    => l_request,
                                  p_id_env     => l_id_env,
                                  p_is_bad_xml => l_is_bad_xml);
    end if;

    return l_buff;
  end prepare_request_xml;

  -----------------------------------------------------------------------------------------
  --  track_request
  --
  --    ��� ������ �� �����
  --
  procedure track_request(p_request_id  in msp_request_tracking.id%type,
                          p_response    in msp_request_tracking.response%type,
                          p_stack_trace in msp_request_tracking.stack_trace%type default null)
  is
  begin
    insert into msp_request_tracking (id, response, stack_trace, state)
    values (p_request_id, p_response, p_stack_trace, case when p_stack_trace is null then null else 1 end);
  exception
    when others then
      raise_application_error(-20000, '������� � �������� msp_utl.track_request. '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end track_request;

  -----------------------------------------------------------------------------------------
  --  create_request
  --
  --    ��������� ������ ����� � ���� ����� � ����� �������
  --
  procedure create_request(p_req_xml  in clob,
                           p_act_type in number,
                           p_xml      out clob)
  is
    l_id     msp_requests.id%type;
    l_errmsg clob;
  begin
    begin
      l_id := msp_request_seq.nextval;

      insert into msp_requests(id, req_xml, state, act_type)
      values (l_id, p_req_xml, -1, p_act_type);

      p_xml := prepare_request_xml(l_id);
    exception
      when others then
        l_errmsg := dbms_utility.format_error_backtrace || chr(10) || sqlerrm;
    end;

    track_request(p_request_id  => l_id,
                  p_response    => p_xml,
                  p_stack_trace => l_errmsg);
    commit;
    
    if l_errmsg is not null then
      raise_application_error(-20001, l_errmsg);
    end if;
  exception
    when others then
      raise_application_error(-20000, '������� � �������� create_request. ' || chr(10) || dbms_utility.format_error_backtrace || chr(10) || sqlerrm);
  end create_request;

  -----------------------------------------------------------------------------------------
  --  prepare_check_state
  --
  --    ��������� ������ �� �������� ����� ������ ��������� �� ���
  --
  procedure prepare_check_state
   is
    l_file_lines        bars.number_list;
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l_count             integer;
    l_date              date;
    l_idr               number;
  begin
    -- ������� ����� ����� ��������
--    bars.bc.go('300465');
    for rec_mfo in (select p.kf mfo from pfu.pfu_syncru_params p) loop
      select count(*)
        into l_count
        from v_msp_file_records t
       where t.state_id = 20
         and t.mfo = rec_mfo.mfo;
      if (l_count > 0) then
        l_doc       := dbms_xmldom.newDomDocument;
        l_root_node := dbms_xmldom.makeNode(l_doc);
        l_root_node := dbms_xmldom.appendChild(l_root_node,
                                               dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                              'root')));

        l_header_node := dbms_xmldom.appendChild(l_root_node,
                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                'header')));
        l_body_node   := dbms_xmldom.appendChild(l_root_node,
                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                'body')));

        select t.ref
          bulk collect
          into l_file_lines
          from v_msp_file_records t
         where t.state_id = 20
           and t.mfo = rec_mfo.mfo;

        if (l_file_lines is not empty) then
          for i in (select column_value ref from table(l_file_lines)) loop

            select O.PDAT
              into l_date
              from bars.oper o
             where o.ref = i.ref;

            select f.id
              into l_idr
              from v_msp_file_records f
             where f.ref = i.ref;

              l_row_node := dbms_xmldom.appendChild(l_body_node,
                                                    dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                   'row')));
              add_txt_node_utl(l_doc,
                                l_row_node,
                                'ref',
                                MOD(i.ref, 1000000000));
              add_txt_node_utl(l_doc, l_row_node, 'pdat', to_char(l_date,'dd.mm.yyyy'));
              add_txt_node_utl(l_doc, l_row_node, 'idr', l_idr);


          end loop;
          --TRANS_TYPE_CHECKSTATE ������������ ���  4    CHECKPAYMSTATE  ���������� ������� �������
          l_transport_unit_id := pfu.transport_utl.create_transport_unit(pfu.transport_utl.TRANS_TYPE_CHECKSTATE,
                                                                     rec_mfo.mfo,
                                                                     pfu.transport_utl.get_receiver_url(rec_mfo.mfo),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());
        end if;
      end if;
    end loop;
    commit;
  end prepare_check_state;

  -----------------------------------------------------------------------------------------
  --  prepare_get_rest_request
  --
  --    ��������� ������ �� �������� ����� ������ ��������� �� ���
  --
  procedure prepare_get_rest_request(
                               p_acc    in msp_acc_trans_2909.acc_num%type,
                               p_fileid in msp_files.id%type,
                               p_kf     in msp_acc_trans_2909.kf%type)
     is
      l_doc               dbms_xmldom.DOMDocument;
      l_root_node         dbms_xmldom.DOMNode;
      l_header_node       dbms_xmldom.DOMNode;
      l_body_node         dbms_xmldom.DOMNode;
      l_transport_unit_id integer;
    begin
      -- ������� ����� ����� ��������
      l_doc       := dbms_xmldom.newDomDocument;
      l_root_node := dbms_xmldom.makeNode(l_doc);
      l_root_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'root')));

      l_header_node := dbms_xmldom.appendChild(l_root_node,
                                               dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                              'header')));
      l_body_node   := dbms_xmldom.appendChild(l_root_node,
                                               dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                              'body')));

      add_txt_node_utl(l_doc, l_body_node, 'acc', p_acc);
      add_txt_node_utl(l_doc, l_body_node, 'fileid', p_fileid);

      merge into msp_acc_rest ar
      using dual
      ON (ar.fileid = p_fileid)
      when matched then
        update set ar.rest = null, ar.restdate = sysdate, ar.acc = p_acc
      when not matched then
        insert values (p_acc, null, sysdate, p_fileid);
      begin
        l_transport_unit_id := pfu.transport_utl.create_transport_unit(pfu.transport_utl.TRANS_TYPE_MSP_GET_ACC_RST,
                                                                   p_kf,
                                                                   pfu.transport_utl.get_receiver_url(ltrim(p_kf,
                                                                                                        '0')),
                                                                   dbms_xmldom.getXmlType(l_doc)
                                                                   .getClobVal());
      end;
  end prepare_get_rest_request;

  procedure create_envelope(p_id          in number,
                            p_idenv       in number default null,
                            p_code        in varchar2 default null,
                            p_sender      in varchar2 default null,
                            p_recipient   in varchar2 default null,
                            p_part_number in number default null,
                            p_part_total  in number default null,
                            p_ecp         in clob default null,
                            p_data        in clob default null,
                            p_data_decode in clob default null)
  is
    l_clob              clob;
    l_domdoc            dbms_xmldom.domdocument;
    l_root_node         dbms_xmldom.domnode;
    l_supp_element      dbms_xmldom.domelement;
    l_supp_node         dbms_xmldom.domnode;
    l_supp_text         dbms_xmldom.domtext;
    l_sup_node          dbms_xmldom.domnode;
    l_supp_tnode        dbms_xmldom.domnode;
  begin
    dbms_lob.createtemporary(l_clob, true, 12);

    merge into msp_envelopes e
    using dual on (e.id = p_id)
    when matched then
      update set e.id_msp_env  = coalesce(p_idenv, e.id_msp_env),
                 e.code        = coalesce(p_code, e.code),
                 e.sender      = coalesce(p_sender, e.sender),
                 e.recipient   = coalesce(p_recipient, e.recipient),
                 e.partnumber  = coalesce(p_part_number, e.partnumber),
                 e.parttotal   = coalesce(p_part_total, e.parttotal),
                 e.ecp         = coalesce(p_ecp, e.ecp),
                 e.data        = coalesce(p_data, e.data),
                 e.data_decode = coalesce(p_data_decode, e.data_decode),
                 e.state       = -1,
                 e.filename    = null
    when not matched then
      insert values (p_id, p_idenv, p_code, p_sender, p_recipient, p_part_number, p_part_total, p_ecp, p_data, p_data_decode, -1, null, sysdate, null);

    /*insert into msp_envelopes (id, id_msp_env, code, sender, recipient, partnumber, parttotal, ecp, data, data_decode, state, comm)
    values(p_id, p_idenv, p_code, p_sender, p_recipient, p_part_number, p_part_total, p_ecp, p_data, p_data_decode, -1, null);*/

    msp_utl.set_state_request(p_id, 0);
  exception
    when others then
      if sqlcode in (-1) then -- ORA-00001: unique constraint
        msp_utl.set_state_request(p_id, 5, sqlerrm);
      else
        raise_application_error(-20000, '������� ��������� ��������. '|| chr(10) || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
      end if;
  end create_envelope;

  procedure create_envelope_file(p_id in number, p_id_msp in number, p_filedata in clob, p_filename in varchar2, p_filedate in varchar2, p_filepath in varchar2)
   is
  begin
    insert into msp_envelope_files_info(id, id_msp, filename, filedate, state, comm, filepath,id_file)
    values (p_id, p_id_msp, p_filename, to_date(p_filedate,'ddmmyyyyhh24miss'), -1, null, p_filepath, msp_file_seq.nextval);

    insert into msp_envelope_files(id, filedata)
    values (p_id, p_filedata);

    update msp_envelopes set filename = p_filename where id = p_id;

    msp_utl.set_state_envelope(p_id, 0);

  end create_envelope_file;


  
  procedure set_file_rest(p_file_data in clob,
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

      merge into msp_acc_rest ar
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

      pfu.transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => pfu.transport_utl.trans_state_done,
                                        p_tracking_comment => '���� ���������',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      commit;
      exception
        when others then
            pfu.transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => pfu.transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => '������ ���������',
                                        p_stack_trace      => dbms_utility.format_error_backtrace());

    end;
    
    procedure check_state          (p_file_data in clob,
                                   p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_ref      number;
      l_state    number;
      l_cnt      number;
      l_cnt2     number;
      l_fileid   msp_file_records.file_id%type;
      l_idr      msp_file_records.id%type;
      l_mfo      pfu.pfu_syncru_params.kf%type;
      l_arr_fileid   bars.number_list := bars.number_list();
      l_i            number;
    begin

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      select t.kf
        into l_mfo
        from pfu.transport_unit t
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

        update msp_file_records mfr
           set mfr.state_id = case when l_state != 0
                                then 99
                                when l_state = 0  -- ������ ������
                                then 10
                                else mfr.state_id
                                end,
               mfr.fact_pay_date = sysdate
         where mfr.id = l_idr
         returning mfr.file_id into l_fileid;

         if l_fileid not member of l_arr_fileid then
           l_arr_fileid.extend;
           l_arr_fileid(l_arr_fileid.last) := l_fileid;
         end if;
      end loop;

         -- ���� ��� ����������� ��� ����� ������ �������

      update msp_files mf
         set mf.state_id = 9 --'PAYED'
       where mf.id in (select column_value
                         from table(l_arr_fileid))
         and not exists (select 1
                           from msp_file_records mfr
                          where mfr.file_id = mf.id
                            and mfr.state_id = 20);

      pfu.transport_utl.set_transport_state(p_id               => p_file_id,
                                            p_state_id         => pfu.transport_utl.trans_state_done,
                                            p_tracking_comment => '���� ���������',
                                            p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            pfu.transport_utl.set_transport_state(p_id               => p_file_id,
                                                  p_state_id         => pfu.transport_utl.TRANS_STATE_FAILED,
                                                  p_tracking_comment => '������ ���������',
                                                  p_stack_trace      => dbms_utility.format_error_backtrace());

    end;

    procedure process_receipt is

    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;

  begin
    for c0 in (select t.*, tt.transport_type_code
                 from pfu.transport_unit t
                 join pfu.transport_unit_type tt
                   on t.unit_type_id = tt.id
                  and tt.transport_type_code in
                      (pfu.transport_utl.TRANS_TYPE_MSP_GET_ACC_RST,
                       pfu.transport_utl.TRANS_TYPE_CHECKSTATE_MSP)
                  and t.state_id = pfu.transport_utl.TRANS_STATE_RESPONDED) loop
      declare
        l_clob         clob;
        l_tmpb         blob;
        l_warning      integer;
        l_dest_offset  integer := 1;
        l_src_offset   integer := 1;
        l_blob_csid    number := dbms_lob.default_csid;
        l_lang_context number := dbms_lob.default_lang_ctx;

      begin
        dbms_lob.createtemporary(l_clob, false);
        savepoint before_transaction;

        l_tmpb := utl_compress.lz_uncompress(c0.response_data);

        dbms_lob.converttoclob(dest_lob     => l_clob,
                               src_blob     => l_tmpb,
                               amount       => dbms_lob.lobmaxsize,
                               dest_offset  => l_dest_offset,
                               src_offset   => l_src_offset,
                               blob_csid    => l_blob_csid,
                               lang_context => l_lang_context,
                               warning      => l_warning);


        if c0.transport_type_code = pfu.transport_utl.TRANS_TYPE_MSP_GET_ACC_RST then
          set_file_rest(l_clob, c0.id);
        elsif c0.transport_type_code = pfu.transport_utl.TRANS_TYPE_CHECKSTATE_MSP then
          check_state(l_clob,c0.id);
        end if;
        dbms_lob.freetemporary(l_clob);
      exception
        when others then
          dbms_lob.freetemporary(l_clob);
          rollback to before_transaction;
      end;
    end loop;
  end;

begin
  -- Initialization
  null;
end msp_utl;
/

show err;
 
PROMPT *** Create  grants  msp_utl ***
grant execute on msp_utl to bars_access_defrole;
  
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/package/msp_utl.sql =========*** End *** 
PROMPT ===================================================================================== 
 
