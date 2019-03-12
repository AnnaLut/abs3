CREATE OR REPLACE PACKAGE "BARS"."SUBSIDY" is

  -- Author  : VITALII.KHOMYDA
  -- Created : 27.11.2018 10:24:43 AM
  -- Purpose : ����������� �������

  type t_sybsidy_list is table of subsidy_data%rowtype index by pls_integer;
  def_sybsidy_list t_sybsidy_list;
  --����� ����������� ������� ��� ������ �� ��������
  g_sub_nbs constant char(4) := '2560';
  g_sub_tip constant char(3) := 'SBD';

  -- �������� ������
  g_tt_outer constant char(3) := 'OSP';

  -- �������� ��������
  g_tt_inner constant char(3) := 'ISP';

  type t_ticket_line is record(
    extid       number,
    status      number,
    statusmsg   varchar2(1000),
    ref         number,
    nd          varchar2(10),
    nlsk        varchar2(15),
    s           number(38),
    statusk     number,
    mfok        varchar2(6),
    bdate       date
    );
  type t_ticket_list is table of t_ticket_line;

  procedure getaccbalance(p_datefrom       in date,
                          p_dateto         in date,
                          p_nls            in varchar2,
                          p_mfo            in varchar2,
                          p_accnum         out varchar2,
                          p_currentbalance out number,
                          p_creditturnover out number,
                          p_errcode        out number,
                          p_errmsg         out varchar2);

  procedure householdpayments(p_ext_id       in varchar2,
                              p_request_data in clob,
                              p_hash         in varchar2,
                              p_state        out number,
                              p_msg          out varchar2,
                              p_bulkid       out varchar2);

  PROCEDURE householdreceive(p_bulkid IN varchar2,
                             p_state  OUT NUMBER,
                             p_msg    OUT VARCHAR2,
                             p_ticket OUT CLOB);

  function parse_data(p_id in varchar2, p_file_data in clob)
    return t_sybsidy_list;
  function form_ticket(p_id in varchar2) return clob;

  procedure processing_payments;

  -- ��������� ������� ��� �������
  procedure get_doc_buffers(p_ref in integer, p_key in varchar2, p_int_buf out varchar2, p_sep_buf out varchar2);

  -- ��������� �������� �� ��������
  procedure put_doc_sign(p_ref in integer, p_key in varchar2, p_int_sign in varchar2, p_sep_sign in varchar2);

end subsidy;
/
  GRANT EXECUTE ON "BARS"."SUBSIDY" TO "BARS_ACCESS_DEFROLE";
  
CREATE OR REPLACE PACKAGE BODY "BARS"."SUBSIDY" is

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

  function get_sybsidy_nls return varchar2 is
    l_nls accounts.nls%type;
  begin
    select t.nls
      into l_nls
      from accounts t
     where t.tip = g_sub_tip
       and t.dazs is null
       and t.nbs = g_sub_nbs
       and kv = 980;
    return l_nls;
  exception
    when no_data_found then
      return null;
    when too_many_rows then
      return null;
  end;

  --���������� ������� ������������ ������� 2560 � ����� sbd(�����䳿)
  procedure getaccbalance(p_datefrom       in date,
                          p_dateto         in date,
                          p_nls            in varchar2,
                          p_mfo            in varchar2,
                          p_accnum         out varchar2,
                          p_currentbalance out number,
                          p_creditturnover out number,
                          p_errcode        out number,
                          p_errmsg         out varchar2) is
    l_acc number;
  begin
    p_errcode := 0;
    p_errmsg  := 'OK';
    begin
      select t.nls, t.ostc, t.acc
        into p_accnum, p_currentbalance, l_acc
        from accounts t
       where t.tip = g_sub_tip
         and t.kf = p_mfo
         and t.nls = p_nls
         and t.dazs is null
         --and t.nbs = g_sub_nbs
         and kv = 980;
    exception
      when no_data_found then
        p_errcode := 1;
        p_errmsg  := '�� �������� �������� �������(' || p_nls || '/' || p_mfo || '/' ||
                     g_sub_tip || ')��� ������� �������';
        return;
      when too_many_rows then
        p_errcode := 2;
        p_errmsg  := '�������� ����� �� ���� �������� �������(' ||
                     p_nls || '/' || g_sub_tip ||
                     ')��� ������� �������';
        return;
    end;
    -- ��������� ���������� ������ �����
    select nvl(sum(kos), 0)
      into p_creditturnover
      from saldoa
     where acc = l_acc
       and fdat between nvl(p_datefrom, gl.bd) and nvl(p_dateto, gl.bd);
  end;

  procedure householdpayments(p_ext_id       in varchar2,
                              p_request_data in clob,
                              p_hash         in varchar2,
                              p_state        out number,
                              p_msg          out varchar2,
                              p_bulkid       out varchar2) is
    /*state = 0 ������
      state = 1 �� ������� ���������� ����
      state = 2 � ��������������� '|| p_ext_id|| ' ��� ������������ ����� �� ������� �������
      state = 10 ����-��� �������
    */
  begin
    p_bulkid := barstrans.transport_utl.create_transport_unit_sub(p_unit_type_code => 'HOUSEHOLDPAYMENTS',
                                                                  p_ext_id         => p_ext_id,
                                                                  p_receiver_url   => null,
                                                                  p_request_data   => p_request_data,
                                                                  p_hash           => p_hash,
                                                                  p_state          => p_state,
                                                                  p_msg            => p_msg);

  end;

  procedure householdreceive(p_bulkid in varchar2,
                             p_state  out number,
                             p_msg    out varchar2,
                             p_ticket out clob) is
    l_transport_unit_row barstrans.transport_unit%rowtype;
    l_cnt number;
  begin

    begin
      l_transport_unit_row := barstrans.transport_utl.read_unit(p_bulkid);
    exception
      when others then
        p_state := 10;
        p_msg   := sqlerrm;
        return;
    end;

    if l_transport_unit_row.state_id = barstrans.transport_utl.trans_state_new or
       l_transport_unit_row.state_id in
       (barstrans.transport_utl.trans_state_failed,
        barstrans.transport_utl.trans_state_broken_file) and
       l_transport_unit_row.failures_count <
       barstrans.transport_utl.marginal_tries_count then
      p_state := 1;
      p_msg   := '����� ����� �������';
    elsif l_transport_unit_row.state_id = barstrans.transport_utl.trans_state_done then
      select count(*)
        into l_cnt
        from subsidy_data sd, oper o
       where o.ref = sd.ref 
         and o.ref is not null
         and sd.extreqid = l_transport_unit_row.external_file_id
         and sos not in (5,-1);
      if l_cnt = 0 then 
        p_state := 0;
        p_msg   := '������ ���������';
      else 
        p_state := 3;
        p_msg   := '������� ������� ��������';        
      end if;
    else
      p_state := 10;
      p_msg   := '������� �������. ��������� �� ������������ �������.';
    end if;

    if p_state in (0,3) then
      --TODO ������� ��������� �� �������������� �����, ��� ������� ��������� ����������
      p_ticket :=  lob_utl.encode_base64(utl_compress.lz_compress(lob_utl.clob_to_blob(form_ticket(l_transport_unit_row.external_file_id))));
    end if;

  end;

  function parse_data(p_id in varchar2, p_file_data in clob)
    return t_sybsidy_list is
    l_parser       dbms_xmlparser.parser;
    l_doc          dbms_xmldom.domdocument;
    l_rows         dbms_xmldom.domnodelist;
    l_row          dbms_xmldom.domnode;
    l_sybsidy_list t_sybsidy_list;
  begin

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_file_data);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'ROW');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1 loop
      l_row := dbms_xmldom.item(l_rows, i);
      l_sybsidy_list(i).extreqid := p_id;
      l_sybsidy_list(i).payeraccnum := substr(dbms_xslprocessor.valueof(l_row,
                                                                                 'PAYERACCNUM/text()'),
                                                       1,
                                                       29);
      l_sybsidy_list(i).payerbankcode := substr(dbms_xslprocessor.valueof(l_row,
                                                                               'PAYERBANKCODE/text()'),
                                                     1,
                                                     12);
      l_sybsidy_list(i).receiveraccnum := substr(dbms_xslprocessor.valueof(l_row,
                                                                                 'RECEIVERACCNUM/text()'),
                                                       1,
                                                       29);
      l_sybsidy_list(i).receivername := substr(dbms_xslprocessor.valueof(l_row,
                                                                               'RECEIVERNAME/text()'),
                                                     1,
                                                     38);
      l_sybsidy_list(i).RECEIVERRNK := to_number(dbms_xslprocessor.valueof(l_row,
                                                                      'RECEIVERRNK/text()'));

      l_sybsidy_list(i).PAYTYPE := to_number(dbms_xslprocessor.valueof(l_row,
                                                                      'PAYTYPE/text()'));

      l_sybsidy_list(i).receiveridentcode := substr(dbms_xslprocessor.valueof(l_row,
                                                                                    'RECEIVERIDENTCODE/text()'),
                                                          1,
                                                          14);
      l_sybsidy_list(i).receiverbankcode := substr(dbms_xslprocessor.valueof(l_row,
                                                                                   'RECEIVERBANKCODE/text()'),
                                                         1,
                                                         12);
      l_sybsidy_list(i).amount := to_number(dbms_xslprocessor.valueof(l_row,
                                                                      'AMOUNT/text()'));
      l_sybsidy_list(i).purpose := substr(dbms_xslprocessor.valueof(l_row,
                                                                          'PURPOSE/text()'),
                                                1,
                                                160);
      l_sybsidy_list(i).feerate := to_number(dbms_xslprocessor.valueof(l_row,
                                                                      'FEERATE/text()'))*100;
      l_sybsidy_list(i).signature := substr(dbms_xslprocessor.valueof(l_row,
                                                                            'SIGNATURE/text()'),
                                                  1,
                                                  64);
      l_sybsidy_list(i).extrowid := to_number(dbms_xslprocessor.valueof(l_row,
                                                                        'EXTID/text()'));
    end loop;

    forall x in indices of l_sybsidy_list
      insert into subsidy_data(EXTREQID,RECEIVERACCNUM,RECEIVERNAME,RECEIVERIDENTCODE,RECEIVERBANKCODE,AMOUNT,PURPOSE,
                               SIGNATURE,EXTROWID,FEERATE,RECEIVERRNK,PAYERACCNUM,PAYERBANKCODE,PAYTYPE)
      values (l_sybsidy_list(x).EXTREQID,l_sybsidy_list(x).RECEIVERACCNUM,l_sybsidy_list(x).RECEIVERNAME,
              l_sybsidy_list(x).RECEIVERIDENTCODE,l_sybsidy_list(x).RECEIVERBANKCODE, l_sybsidy_list(x).AMOUNT,
              l_sybsidy_list(x).PURPOSE,l_sybsidy_list(x).SIGNATURE,l_sybsidy_list(x).EXTROWID,l_sybsidy_list(x).FEERATE,
              l_sybsidy_list(x).RECEIVERRNK,l_sybsidy_list(x).PAYERACCNUM,l_sybsidy_list(x).PAYERBANKCODE,
              l_sybsidy_list(x).PAYTYPE);
    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);
    return l_sybsidy_list;
  end;

  function pay_data(p_sybsidy_list in t_sybsidy_list) return t_sybsidy_list is
    l_nls           accounts.nls%type;-- := get_sybsidy_nls;
    l_nls_3570      accounts.nls%type;
    l_acc_6510      accounts.acc%type;
    l_bdate         date;
    l_mfo           varchar2(6);
    l_sos           oper.sos%type;
    l_mfok          varchar2(6);
    l_kv            char(3) := 980;
    l_ref           oper.ref%type;
    l_refk          oper.ref%type;
    l_accounts_line accounts%rowtype;
    l_acc_line_3570 accounts%rowtype;
    l_acc_line_6510 accounts%rowtype;
    l_branch        accounts.branch%type;
    l_branchk       customer.branch%type;
    l_okpo          customer.okpo%type;
    l_okpo_3570     customer.okpo%type;
    l_okpo_6510     customer.okpo%type;
    l_tt            tts.tt%type;
    l_ttk           tts.tt%type := 'SM2';
    l_dk            oper.dk%type := 1;
    l_sybsidy_list  t_sybsidy_list;
    l_errumsg       varchar2(1000);
    l_erracode      varchar2(1000);
    l_erramsg       varchar2(1000);
    l_buf           varchar2(32000);
  begin


    if p_sybsidy_list.count > 0 then
      l_sybsidy_list  := p_sybsidy_list;

      l_bdate         := gl.bdate;



      for i in l_sybsidy_list.first .. l_sybsidy_list.last loop
        begin
          savepoint before_pay;

          l_nls           := l_sybsidy_list(i).payeraccnum;
          l_mfo           := l_sybsidy_list(i).payerbankcode;
          l_accounts_line := account_utl.read_account(p_account_number => l_nls,
                                                  p_currency_id    => 980,
                                                  p_mfo            => l_mfo);
          l_okpo          := customer_utl.get_customer_okpo(l_accounts_line.rnk);
          l_branch        := l_accounts_line.branch;

          bc.subst_branch(l_branch);

          if l_sybsidy_list(i).paytype = 1 then
            if substr(l_sybsidy_list(i).receiveraccnum, 1, 4) = '2603' then
              l_tt := 'SM3';
            elsif substr(l_mfo,2,6) != l_sybsidy_list(i).receiverbankcode then
              l_tt := 'RSM';
            else
              l_tt := 'SM1';
            end if;
          elsif l_sybsidy_list(i).paytype = 2 then
            if substr(l_mfo,2,6) != l_sybsidy_list(i).receiverbankcode then
              l_tt := 'PXR';
            else
              l_tt := 'PXS';
            end if;
          else
            raise_application_error(-20000, '���� ������ '||l_sybsidy_list(i).paytype|| '�� ��������!');
          end if;


          l_buf := convert(
                   (l_sybsidy_list(i).payeraccnum || l_sybsidy_list(i).payerbankcode || l_sybsidy_list(i).receiveraccnum ||
                   l_sybsidy_list(i).receivername || l_sybsidy_list(i).receiverrnk || l_sybsidy_list(i).receiveridentcode ||
                   l_sybsidy_list(i).receiverbankcode || l_sybsidy_list(i).amount || l_sybsidy_list(i).purpose), 'UTF8','CL8MSWIN1251') /*||
                   to_char(l_sybsidy_list(i).feerate/100)*/;
          --���������� ��������, ������� �������� �������� ���������, �� ������������� Win1251
          if crypto_utl.check_mac_sh1(p_src     => l_buf,
                                      p_key     => crypto_utl.get_key_value(sysdate, 'SUBSIDY'),
                                                   p_sign => l_sybsidy_list(i).signature,
                                      p_charset => null) then

            gl.ref(l_ref);

            gl.in_doc3(ref_   => l_ref,
                       tt_    => l_tt,
                       vob_   => 6,
                       nd_    => to_char(l_ref),
                       pdat_  => sysdate,
                       vdat_  => l_bdate,
                       dk_    => l_dk,
                       kv_    => l_kv,
                       s_     => l_sybsidy_list(i).amount,
                       kv2_   => l_kv,
                       s2_    => l_sybsidy_list(i).amount,
                       sk_    => null,
                       data_  => l_bdate,
                       datp_  => l_bdate,
                       nam_a_ => substr(l_accounts_line.nms,1,38),
                       nlsa_  => l_nls,
                       mfoa_  => l_mfo,
                       nam_b_ => substr(l_sybsidy_list(i).receivername,1,38),
                       nlsb_  => l_sybsidy_list(i).receiveraccnum,
                       mfob_  => l_sybsidy_list(i).receiverbankcode,
                       nazn_  => l_sybsidy_list(i).purpose,
                       d_rec_ => null,
                       id_a_  => l_okpo,
                       id_b_  => l_sybsidy_list(i).receiveridentcode,
                       id_o_  => null,
                       sign_  => null,
                       sos_   => null,
                       prty_  => 0,
                       uid_   => user_id);


                      paytt(null,
                      l_ref,
                      l_bdate,
                      l_tt,
                      l_dk,
                      l_kv,
                      l_nls,
                      l_sybsidy_list(i).amount,
                      l_kv,
                      l_sybsidy_list(i).receiveraccnum,
                      l_sybsidy_list(i).amount);


            -- ��������
            if nvl(l_sybsidy_list(i).feerate,0) > 0 and l_sybsidy_list(i).paytype = 1 then
              l_ttk      := 'SM2';

              bc.go('/');

			  begin
                select c.rnk
                  into l_sybsidy_list(i).receiverrnk
                  from customer c
                 where c.okpo = l_sybsidy_list(i).receiveridentcode
                   and c.rnk like l_sybsidy_list(i).receiverrnk||'%';
              exception when no_data_found then
                 raise_application_error(-20000, '�볺��� � ����� ��� �� �������� - '||l_sybsidy_list(i).receiverrnk);
              end;

              select substr(branch,1,15),
                     okpo
                into l_branchk,
                     l_okpo_3570
                from customer
               where rnk = l_sybsidy_list(i).receiverrnk;

              if length(l_branchk) = 8 then
                l_branchk := l_branchk||'000000/';
              end if;

              bc.subst_branch(l_branchk);
              l_mfok := gl.amfo;
              l_nls_3570 := get_acc_3570_subsidy(l_sybsidy_list(i).receiverrnk);
              l_acc_line_3570 := account_utl.read_account(p_account_number => l_nls_3570,
                                                          p_currency_id    => l_kv);
              l_acc_6510 := nbs_ob22_null('6510', 'H7', l_branchk);
              if l_acc_6510 is null then
                OP_BS_OB1(l_branchk, '6510H7');
              end if;
              l_acc_6510 := nbs_ob22_null('6510', 'H7',l_branchk);
              l_acc_line_6510 := account_utl.read_account(p_account_number => l_acc_6510, p_currency_id => 980);
              l_okpo_6510 := customer_utl.get_customer_okpo(l_acc_line_6510.rnk);

              gl.ref(l_refk);

              gl.in_doc3(ref_   => l_refk,
                         tt_    => l_ttk,
                         vob_   => 6,
                         nd_    => to_char(l_refk),
                         pdat_  => sysdate,
                         vdat_  => l_bdate,
                         dk_    => l_dk,
                         kv_    => l_kv,
                         s_     => l_sybsidy_list(i).feerate/100 * l_sybsidy_list(i).amount/100,
                         kv2_   => l_kv,
                         s2_    => l_sybsidy_list(i).feerate/100 * l_sybsidy_list(i).amount/100,
                         sk_    => null,
                         data_  => l_bdate,
                         datp_  => l_bdate,
                         nam_a_ => l_acc_line_3570.nms,
                         nlsa_  => l_nls_3570,
                         mfoa_  => l_mfok,
                         nam_b_ => substr(l_acc_line_6510.nms,1,38),
                         nlsb_  => l_acc_line_6510.nls,
                         mfob_  => l_mfok,
                         nazn_  => '����������� ���� �� ������� ������� �������� ������� ����� ������',
                         d_rec_ => null,
                         id_a_  => l_okpo_3570,
                         id_b_  => l_okpo_6510,
                         id_o_  => null,
                         sign_  => null,
                         sos_   => null,
                         prty_  => 0,
                         uid_   => user_id);

              gl.payv(flg_  => 0,
                      ref_  => l_refk,
                      dat_  => l_bdate,
                      tt_   => l_ttk,
                      dk_   => l_dk,
                      kv1_  => l_kv,
                      nls1_ => l_nls_3570,
                      sum1_ => l_sybsidy_list(i).feerate/100 * l_sybsidy_list(i).amount/100,
                      kv2_  => l_kv,
                      nls2_ => l_acc_line_6510.nls,
                      sum2_ => l_sybsidy_list(i).feerate/100 * l_sybsidy_list(i).amount/100);
               gl.pay(2,
                      l_refk,
                      l_bdate);
               insert into operw (ref,tag,value,kf)
               values (l_refk, 'REF92', l_ref, gl.aMFO);
            end if;


            bc.subst_branch(l_branch);

            if l_refk is not null then
              insert into operw (ref,tag,value,kf)
              values (l_ref, 'REF92', l_refk, gl.aMFO);
            end if;
            l_sybsidy_list(i).ref := l_ref;
          else
            l_sybsidy_list(i).err := 'ϳ���� �� ������� ��������';
          end if;
        exception
          when others then
            bc.home;
            /*
            bars_error.get_error_info(p_errtxt   => sqlerrm,
                                      p_errumsg  => l_errumsg,
                                      p_erracode => l_erracode,
                                      p_erramsg  => l_erramsg);*/

            l_sybsidy_list(i).err := dbms_utility.format_error_stack()||chr(10)||chr(13)||dbms_utility.format_call_stack();
            rollback to before_pay;

        end;
        bc.go('/');
      end loop;

      forall x in indices of l_sybsidy_list
        update subsidy_data t
           set t.ref = l_sybsidy_list(x).ref,
               t.err = l_sybsidy_list(x).err
         where t.extreqid = l_sybsidy_list(x).extreqid
           and t.extrowid = l_sybsidy_list(x).extrowid;

    end if;
    return l_sybsidy_list;
  end;

  function form_ticket(p_id in varchar2) return clob is
    l_clob      clob;
    l_domdoc    dbms_xmldom.domdocument;
    l_root_node dbms_xmldom.domnode;

    l_supp_element dbms_xmldom.domelement;

    l_supp_node dbms_xmldom.domnode;

    l_supp_tnode dbms_xmldom.domnode;

    l_supp_text dbms_xmldom.domtext;

    l_supplier_element dbms_xmldom.domelement;
    l_supplier_node    dbms_xmldom.domnode;
    l_sup_node         dbms_xmldom.domnode;
    l_suppp_node       dbms_xmldom.domnode;
    l_ticket_list      t_ticket_list;
  begin
    dbms_lob.createtemporary(l_clob, true, 12);
    select t.extrowid,
           case
             when o.sos = 5 then
              1
             when o.sos < 0 or o.sos is null then
              2
             else
              0
           end,
           case
             when o.sos = 5 then
              '���������'
             when o.sos < 0 then
              '����������'
             when o.sos is null then
              t.err
             else
              '����� ������'
           end,
           t.ref,
           o.nd,
           o2.nlsa,
           o2.s,
           case
             when o2.sos = 5 then
              1
             when o2.sos < 0 or o2.sos is null then
              2
             else
              0
           end statusk,
           o2.kf mfok,
           case when o.sos = 5 then o.sos_change_time else null end bdate
      bulk collect
      into l_ticket_list
      from subsidy_data t
      left join oper o
        on t.ref = o.ref
      left join oper o2
        on o2.refl = t.ref
     where t.extreqid = p_id;

    if l_ticket_list.count > 0 then

      -- Create an empty XML document
      l_domdoc := dbms_xmldom.newdomdocument;

      -- Create a root node
      l_root_node := dbms_xmldom.makenode(l_domdoc);

      -- Create a new Supplier Node and add it to the root node
      l_sup_node   := dbms_xmldom.appendchild(l_root_node,
                                              dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                             'ROOT')));
      l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                                              dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                             'ROWS')));
      for i in l_ticket_list.first .. l_ticket_list.last loop
        l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'ROW');
        l_supplier_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                      dbms_xmldom.makenode(l_supplier_element));
        --³������ �������� ��������� ExtId ������ ������ HouseholdPayments
        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'EXTID');
        l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, l_ticket_list(i).EXTID);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));

        --������ ���������
        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'STATUS');
        l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                     l_ticket_list(i).STATUS);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,

                                                  dbms_xmldom.makenode(l_supp_text));

        -- ���� �������
        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'STATUSMSG');
        l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                     l_ticket_list(i).STATUSMSG);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));
        --�������� ���������
        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'REF');
        l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                     l_ticket_list(i).REF);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));
        --����� ���������
        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'ND');
        l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                     l_ticket_list(i).ND);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));
        --��� ����� �����
        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'FEEBANKCODE');
        l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                     l_ticket_list(i).MFOK);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,

                                                  dbms_xmldom.makenode(l_supp_text));
         --����� ������� ����
        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'FEEACCNUM');
        l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                     l_ticket_list(i).NLSK);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,

                                                  dbms_xmldom.makenode(l_supp_text));
         --����� ����
        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'FEEAMOUNT');
        l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                     l_ticket_list(i).S);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,

                                                  dbms_xmldom.makenode(l_supp_text));

        --���� ���������� �������
        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'BDAT');
        l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                     to_char(l_ticket_list(i).bdate,'ddmmyyyy'));
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,

                                                  dbms_xmldom.makenode(l_supp_text));


      end loop;
      dbms_xmldom.writeToClob(l_domdoc, l_clob);
      dbms_xmldom.freedocument(l_domdoc);

    end if;
    return l_clob;
  end;

  procedure processing_payments is
    l_request_data_tmp blob;
    l_request_data     clob;
    l_sybsidy_list     t_sybsidy_list;
    l_ticketdata       clob;
  begin

    for i in (SELECT t.id,
                     t.unit_type_id,
                     t.external_file_id external_file_id,
                     t.request_data,
                     t.state_id,
                     t.failures_count,
                     tt.compressed
                FROM barstrans.transport_unit t
                JOIN barstrans.transport_unit_type tt
                  on tt.id = t.unit_type_id
               WHERE (t.state_id = barstrans.transport_utl.trans_state_new or
                     (t.state_id =
                     barstrans.transport_utl.trans_state_failed AND
                     t.failures_count <
                     barstrans.transport_utl.marginal_tries_count))
                 and tt.transport_type_code = 'HOUSEHOLDPAYMENTS') loop
      begin
        savepoint before_work;
        -- ������������ ����
        l_request_data_tmp := i.request_data;
        if i.compressed = 1 then
          l_request_data_tmp := utl_compress.lz_uncompress(l_request_data_tmp);
        end if;

        --������������ blob � clob, ��� ������ �������
        l_request_data := lob_utl.blob_to_clob(l_request_data_tmp);

        --�����������
        l_request_data := utf8todeflang(l_request_data);

        --������ �����
        l_sybsidy_list := parse_data(i.external_file_id, l_request_data);
        --��������� ���������
        l_sybsidy_list := pay_data(l_sybsidy_list);
        -- ���������� ���������
        l_ticketdata := form_ticket(i.id);
        -- ���������� ���������
        barstrans.transport_utl.save_response(p_id        => i.id,
                                              p_resp_data => utl_compress.lz_compress(lob_utl.clob_to_blob(l_ticketdata)));
        -- ���������� ������ �� ������� ����������� �������
        barstrans.transport_utl.set_transport_state(p_id               => i.id,
                                                    p_state_id         => barstrans.transport_utl.trans_state_done,
                                                    p_tracking_comment => 'OK',
                                                    p_stack_trace      => null);
        commit;
      exception
        when others then
          rollback to before_work;
          barstrans.transport_utl.set_transport_failure(p_id            => i.id,
                                                        p_error_message => SQLERRM,
                                                        p_stack_trace   => dbms_utility.format_error_stack() ||
                                                                           chr(10) ||
                                                                           dbms_utility.format_error_backtrace());
      end;

    end loop;

  end;

  procedure get_doc_buffers(p_ref     in integer,
                            p_key     in varchar2,
                            p_int_buf out varchar2,
                            p_sep_buf out varchar2) is
    l_buffer varchar2(4000);
  begin
    -- ��������� ��� ������
    docsign.retrievesepbuffer(p_ref, p_key, l_buffer);
    p_sep_buf := rawtohex(utl_raw.cast_to_raw(l_buffer));
    chk.make_int_docbuf(p_ref, l_buffer);
    p_int_buf := rawtohex(utl_raw.cast_to_raw(l_buffer));
  end;

  -- ��������� �������� �� ��������
    procedure put_doc_sign(p_ref      in integer,
                         p_key      in varchar2,
                         p_int_sign in varchar2,
                         p_sep_sign in varchar2) is
    l_tt oper.tt%type;

    g_grc_nls_trans accounts.nls%type;
    g_grc_nls_t00 accounts.nls%type;


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
    
    l_cnt number;


  begin

    select o.tt, o.mfob into l_tt, mfob_ from oper o where o.ref = p_ref;
    if (mfob_ != 300465 and l_tt != 'PXS') then
       select count(*)
         into l_cnt
         from oper_visa ov
        where ov.ref = p_ref;
       
       if (l_cnt = 0) then
           chk.put_visa(p_ref, l_tt, null, 0, p_key, p_int_sign, p_sep_sign);

           SELECT datp
             INTO datp_
             FROM oper WHERE ref=p_ref;

           p_fm_intdoccheck(p_ref);

           chk.put_visa(p_ref, l_tt, 5, 2, p_key, p_int_sign, p_sep_sign);
       end if;    
           

       gl.pay( 2,p_ref,datp_);

       SELECT mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
              datd, datp, nam_a, nam_b, nazn, id_a, id_b,
              id_o, sign, d_rec, sos, ref_a, prty
         INTO mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
              datd_,datp_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
              id_o_,sign_,d_rec_, sos_, refA_, prty_
         FROM oper WHERE ref=p_ref;

       if (sos_ = 5 ) then
          IF LENGTH(TRIM(NVL(d_rec_,'')))>0 THEN
             nazns_ := '11';
          ELSE
             nazns_ := '10';
          END IF;

          sep.in_sep(err_,rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,
                     vob_,nd_,kv_,datD_,datP_,nam_a_,nam_b_,nazn_,
                     NULL,nazns_,id_a_,id_b_,id_o_,refA_,0,sign_,
                     NULL,NULL,datA_,d_rec_,0,p_ref,0);

       end if;

       p_fm_extdoccheck(rec_);
    else
--     chk.put_visa(p_ref, l_tt, 5, 2, p_key, p_int_sign, p_sep_sign);
       gl.pay( 2,p_ref,datp_);
    end if;

    exception
        when others then
        commit;
		bars_audit.error(sqlerrm);
--		raise_application_error (-20000, dbms_utility.format_error_backtrace);
  end;

end subsidy;
/
  GRANT EXECUTE ON "BARS"."SUBSIDY" TO "BARS_ACCESS_DEFROLE";