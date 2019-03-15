
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/bars_docsync.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSAQ.BARS_DOCSYNC is

  -- Copyryight : UNITY-BARS
  -- Author     : SERG
  -- Created    : 26.09.2007
  -- Purpose    : ����� �������� ��� ������� ����������

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.07 08/06/2018';
  
  -- ��� ������ ��������� (� ����������� �������� ������� �����������, ��� �������������� ����� ��������)
  G_PAYTYPE_AUTO   constant smallint  := 0;
  G_PAYTYPE_MANUAL constant smallint  := 1; 
  G_ERRMOD         constant varchar2(3)  := 'DOC'; 
  G_TRACE          constant varchar2(50)  := 'bars_docsync.';
  ----
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2;

  ----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2;

  ----
  -- import_documents - ��������� ���������� ������ ����������
  --
  procedure import_documents;

  ----
  -- verify_document - ������������ ��������
  -- @p_ext_ref - ������� �������� ���������
  --
  procedure verify_document(p_ext_ref in varchar2);

  ----
  -- confirm_document - ������������ ������ ���������
  -- @p_ext_ref - ������� �������� ���������
  --
  procedure confirm_document(p_ext_ref in varchar2);

  ----
  -- mark_document_to_remove - �������� �������� � ��������
  -- @p_ext_ref - ������� �������� ���������
  -- @p_removal_date - ���� ����� ������� �������� ���������� �������
  procedure mark_document_to_remove(p_ext_ref in varchar2, p_removal_date in date default sysdate);

  ----
  -- is_bankdate_open - ���������� true/false - ���� ��������� ����������� ���
  --
  function is_bankdate_open return boolean;

  
  -----------------------------------
  -- PAY_DOCUMENT
  --
  -- ���������� ���� ��������
  --
  procedure pay_document(p_ext_ref number, p_ref number);
  
  ----
  -- async_pay_documents - ��������� ����������� ������ ����������
  --
  procedure async_pay_documents;

  ----
  -- reset_booking_info - ���������� ���������� �� ������ ���������
  -- @p_ext_ref - ������� �������� ���������
  --
  procedure reset_booking_info(p_ext_ref in varchar2);

  ----
  -- async_remove_documents - ������� ���������� � �������� ��������� � ����������� ����� ��������
  --
  procedure async_remove_documents;

  ----
  -- extract_app_error - ���������� ��� ���������� ������
  --
  function extract_app_error(p_err_msg in varchar2) return integer;

  -----------------------------------
  -- GET_DOC_BUFFER
  --
  -- �������� ������� ��� �������
  --
   
   procedure get_doc_buffer ( p_ref     in integer,
                              p_key     in varchar2,
                              p_int_buf out varchar2,
                              p_sep_buf out varchar2);
  ------------------------------------
  -- ASYNC_AUTO_PAY 
  --
  -- ��������� ��� ������������� ���������� ����2 ���������
  -- ������������ ��������� � ��� ������
  --
  procedure async_auto_pay (p_ext_ref number, p_ref out number);


  ------------------------------------
  -- ASYNC_AUTO_VISA 
  -- 
  -- ��������� ��� ������������� ���������� ����2 ���������
  -- ��������� ��� � ���������, ������ ��-�����
  --
  procedure async_auto_visa (p_ref      in number,
                             p_ext_ref  in number,
                             p_key      in varchar2,
                             p_int_sign in varchar2,
                             p_sep_sign in varchar2);
    
  ------------------------------------
  --  POST_ERROR_PROC 
  --
  --  ����� �������� ��� ���������� ����� ���������� ��������� ��������� 
  --
  procedure post_error_proc(p_ext_ref number, p_sqlerr_code number, p_sqlerr_stack varchar2);

  ------------------------------------
  -- GET_BIS_COUNT 
  -- 
  -- ��������� ������� ��� �����
  --
  function get_bis_count(p_ref      in number) return number;
  
  
  -----------------------------------
  -- GET_SIGN_FOR_VERIFIVCATION
  --
  -- �������� ������� �� ��������, ������� ������������� ��������� �� ����2 ��������������� ��������.
  --
  procedure get_extsign_for_verification(p_ext_ref      in    number, 
                                         p_key          out   varchar2,
                                         p_buff         out   varchar2,
                                         p_sign         out   varchar2);
  
  
  

end bars_docsync;
/
show err

CREATE OR REPLACE PACKAGE BODY BARSAQ.BARS_DOCSYNC is

  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 1.7 24/11/2018';

  G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := 'KF - ����� � ����� kf';



  ----
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2 is
  begin
    return 'Package header '||G_HEADER_VERSION;
  end header_version;

  ----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2 is
  begin
    return 'Package body '||G_BODY_VERSION||'awk: '||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||G_AWK_BODY_DEFS;
  end body_version;

  ----
  -- is_bankdate_open - ���������� true/false - ���� ��������� ����������� ���
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
  --  �������� ������ ��������� �� doc_import
  --
  function read_corp_doc(p_ext_ref number) return doc_import%rowtype
  is
     l_doc doc_import%rowtype;
  begin
     select * into l_doc from doc_import where ext_ref = to_char(p_ext_ref);
     return l_doc;
  exception when no_data_found then
     raise_application_error(-20000, '�������� �� ������  EXT_REF='||p_ext_ref, TRUE);
  end;

  ------------------------------------
  --  READ_BARS_DOC
  --
  --  �������� ������ ��������� �� oper
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
       raise_application_error(-20000, '�������� �� ������ REF='||p_ref, TRUE);
     end if;
  end;


  ----
  -- reset_bankdate - ������������� ���������� ����
  --
  procedure reset_bankdate is
  begin
    bars.gl.pl_dat(bars.bankdate_g);
  end reset_bankdate;

  ----
  -- import_documents - ��������� ������ ����������
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
    -- �������� � ����� ���������� ����
    reset_bankdate;
    l_errmod := 'DOC';
    l_bankdate := bars.gl.bDATE;
    -- ���� �� ����������
    for d in (select * from tmp_doc_import where ref is null for update skip locked order by ext_ref) loop
        savepoint sp_before_pay;
        begin
            -- ������������� ����, �� ������� ������ ���� ��������� �� ������
            bars.bars_error.set_lang(d.err_lang, bars.bars_error.SCOPE_SESSION);
            -- ��������: �������� d.tt ���������� ?
            begin
                select * into l_tt from bars.tts where tt=d.tt;
            exception when no_data_found then
                bars.bars_error.raise_nerror(l_errmod, 'TRANSACTION_DOES_NOT_EXIST', d.tt);
            end;
            -- ��������: ������������ ��������� �������� d.tt ?
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
            -- ��������: ������� ����� ��-����� � ��� ������
            if l_tt.fli=1 and substr(l_tt.flags,38,1)='1' then
                bars.bars_error.raise_nerror(l_errmod, 'SEP_TRANS_VISA_REQ', d.tt);
            end if;
            -- ��������� ��������
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
            -- ��������� ext_ref ��� ���-��������
            insert into bars.operw(ref,tag,value) values(l_ref,'EXREF',to_char(d.ext_ref));
            -- ��������� ���������� ���. ���������
            for r in (select * from tmp_doc_import_props where ext_ref=d.ext_ref) loop
                begin
                    select * into l_tag_info from bars.op_field where tag=r.tag;
                exception when no_data_found then
                    bars.bars_error.raise_nerror(l_errmod, 'TAG_NOT_FOUND', r.tag);
                end;
                if l_tag_info.chkr is not null then
                    -- �������� ���. ��������� �� ������������
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
            -- ��������� ���. ��������� � ���
            if l_tt.fli=1 then
                l_d_rec := '';
                for s in (select w.tag, w.value, f.vspo_char from bars.operw w, bars.op_field f
                            where w.ref=l_ref and w.tag=f.tag
                            and f.vspo_char is not null and f.vspo_char not in ('f','F','C','�')
                          )
                loop
                    l_d_rec := l_d_rec || '#'||s.vspo_char||s.value;
                end loop;
                if l_d_rec is not null and length(l_d_rec)>0 then
                    l_d_rec := l_d_rec || '#';
                end if;
                update bars.oper set d_rec=l_d_rec where ref=l_ref;
            end if;
            -- ��������: ������� ������������ ���. ����������
            for c in (select * from bars.op_rules where tt=d.tt and opt='M') loop
                begin
                    select ref into l_needless from bars.operw where ref=l_ref and tag=c.tag;
                exception when no_data_found then
                    bars.bars_error.raise_nerror(l_errmod, 'MANDATORY_TAG_ABSENT', c.tag, d.tt);
                end;
            end loop;
            -- ������
            bars.gl.dyntt2 (
                  l_sos, to_number(substr(l_tt.flags,38,1)), 1,
                  l_ref, d.vdat, null, d.tt, d.dk,
                  d.kv,  d.mfo_a, d.nls_a, d.s,
                  d.kv2, d.mfo_b, d.nls_b, d.s2, l_sq, null);
            --
            -- � ����� ����������� �������� ���������, ��� ������� �������� ������
            update tmp_doc_import set ref=l_ref where ext_ref=d.ext_ref;
            -- ����������� ���������� ��� ��������� ��� ����������� ������ �� ���
            if d.tt in ('IBB','IBO','IBS') then
                update bars.sw_template set ref=l_ref, user_id=d.userid where doc_id=d.ext_ref;
            end if;
            bars.bars_audit.info('������� ��������. REF='||l_ref||', EXT_REF='||d.ext_ref);
        exception when others then
            rollback to sp_before_pay;
            -- ������� ���������� � ���������
            if d.tt in ('IBB','IBO','IBS') then
                delete from bars.sw_template where doc_id=d.ext_ref;
            end if;
            bars.bars_audit.error('DOCSYNC: '||substr(SQLERRM, 1, 3900));
            -- ��������� ���������� �� ������
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
              -- ���� ������ '\' (ascci('\') = 92)
              l_slash_pos := instr(l_sqlerrm, chr(92));
			  
              if l_slash_pos>0 then
                -- ��������� ��� ������
                l_subcode_str := ''; i := 1;
                while substr(l_sqlerrm, l_slash_pos+i, 1) in ('0','1','2','3','4','5','6','7','8','9') loop
                  l_subcode_str := l_subcode_str || substr(l_sqlerrm, l_slash_pos+i, 1);
                  i := i + 1;
                end loop;
                l_subcode := to_number(l_subcode_str);
                -- ��������� �������� ����� ������� #
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
  -- verify_document - ������������ ��������
  -- @p_ext_ref - ������� �������� ���������
  --
  procedure verify_document(p_ext_ref in varchar2) is
  begin
    update doc_import set verification_flag='Y', verification_date=sysdate
    where ext_ref=p_ext_ref and verification_flag is null or verification_flag='N';
    if sql%rowcount=0 then
        raise_application_error(-20000, '�������� �� ������ ��� �������� EXT_REF='
                                        ||p_ext_ref||' ��������������� ������.', TRUE);
    end if;
    bars.bars_audit.info('����������� ��������� EXT_REF='||p_ext_ref||' ������� ���������.');
  end verify_document;

  ----
  -- confirm_document - ������������ ������ ���������
  -- @p_ext_ref - ������� �������� ���������
  --
  procedure confirm_document(p_ext_ref in varchar2) is
  begin
    update doc_import set confirmation_flag='Y', confirmation_date=sysdate
    where ext_ref=p_ext_ref and confirmation_flag is null;
    if sql%rowcount=0 then
        raise_application_error(-20000, '�������� �� ������ ��� ������������� ������ ��������� EXT_REF='
                                        ||p_ext_ref||' ����������� ������.', TRUE);
    end if;
    bars.bars_audit.info('������������� ������ ��������� EXT_REF='||p_ext_ref||' ������� ���������.');
  end confirm_document;

  ----
  -- mark_document_to_remove - �������� �������� � ��������
  -- @p_ext_ref - ������� �������� ���������
  -- @p_removal_date - ���� ����� ������� �������� ���������� �������
  procedure mark_document_to_remove(p_ext_ref in varchar2, p_removal_date in date default sysdate) is
  begin
    update doc_import set removal_flag='Y', removal_date=p_removal_date
    where ext_ref=p_ext_ref and removal_flag is null;
    if sql%rowcount=0 then
        raise_application_error(-20000, '�������� �� ������ ��� ������� � �������� ��������� EXT_REF='
                                        ||p_ext_ref||' ��������������� ������.', TRUE);
    end if;
    bars.bars_audit.info('������� � �������� ��������� EXT_REF='||p_ext_ref||' ������� �����������.');
  end mark_document_to_remove;

  ----
  -- extract_app_error - ���������� ��� ���������� ������
  --
  function extract_app_error(p_err_msg in varchar2) return integer is
    l_str   varchar2(40) := '';
    i       integer;
  begin
    if substr(p_err_msg, 12, 1)= chr(92)  then  --'\' 
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
  -- lock_document4pay - ��������� �������� ��� ������
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
        bars.bars_audit.error('�������� ext_ref='||p_extref||' �� ����� ���� ������������, �.�. '
        ||'confirmation_flag='||nvl(l_confirmation_flag,'null')
        ||', booking_flag='||nvl(l_booking_flag,'null')
        ||', removal_flag='||nvl(l_removal_flag,'null'));
        return false;
    end if;
  exception when l_doc_locked then
    rollback to sp;
    bars.bars_audit.error('�������� ext_ref='||p_extref||' ������������ ������ �������������');
    return false;
  end lock_document4pay;


  -----------------------------------
  -- GET_SIGN_FOR_VERIFIVCATION
  --
  -- �������� ������� �� ��������, ������� ������������� ��������� �� ����2 ��������������� ��������.
  --
  procedure get_extsign_for_verification(p_ext_ref      in    number, 
                                         p_key          out   varchar2,
                                         p_buff         out   varchar2,
                                         p_sign         out   varchar2 ) is
     l_doc doc_import%rowtype;
     l_trace         varchar2(1000) := G_TRACE||'get_extsign_for_verification: ';
     l_hexbuff       varchar2(1000);
     l_asciibuff     varchar2(1000);
  begin
     l_doc := read_corp_doc(p_ext_ref);  
	 l_asciibuff := case when  bars.gl.amfo='300465' then 
							  nvl(rpad(l_doc.nd,10),rpad(' ',10))||nvl(to_char(l_doc.datd,'YYMMDD'),rpad(' ',6))
							||nvl(lpad(to_char(l_doc.dk),1),' ')
							||nvl(lpad(l_doc.mfo_a,9),rpad(' ',9))||nvl(lpad(l_doc.nls_a,14),rpad(' ',14))
							||nvl(lpad(to_char(l_doc.kv),3),rpad(' ',3))||nvl(lpad(to_char(l_doc.s),16),rpad(' ',16))
							||nvl(lpad(l_doc.mfo_b,9),rpad(' ',9))||nvl(lpad(l_doc.nls_b,14),rpad(' ',14))
							||nvl(lpad(to_char(nvl(l_doc.kv2,l_doc.kv)),3),rpad(' ',3))||nvl(lpad(to_char(nvl(l_doc.s2,l_doc.s)),16),rpad(' ',16))
			else				
							  nvl(rpad(l_doc.nd,10),rpad(' ',10))||nvl(to_char(l_doc.datd,'YYMMDD'),rpad(' ',6))
							||nvl(lpad(to_char(l_doc.dk),1),' ')
							||nvl(lpad(l_doc.mfo_a,9),rpad(' ',9))||nvl(lpad(l_doc.nls_a,14),rpad(' ',14))
							||nvl(lpad(to_char(l_doc.kv),3),rpad(' ',3))||nvl(lpad(to_char(l_doc.s),16),rpad(' ',16))
							||nvl(rpad(l_doc.nam_a,38),rpad(' ',38))||lpad(nvl(l_doc.id_a,' '), 14)
							||nvl(lpad(l_doc.mfo_b,9),rpad(' ',9))||nvl(lpad(l_doc.nls_b,14),rpad(' ',14))
							||nvl(lpad(to_char(nvl(l_doc.kv2,l_doc.kv)),3),rpad(' ',3))||nvl(lpad(to_char(nvl(l_doc.s2,l_doc.s)),16),rpad(' ',16))
							||nvl(rpad(l_doc.nam_b,38),rpad(' ',38))||lpad(nvl(l_doc.id_b,' '), 14)
							||nvl(rpad(l_doc.nazn,160),rpad(' ',160))
                       end;

     l_hexbuff := rawtohex(utl_raw.cast_to_raw(l_asciibuff));
     p_buff := l_hexbuff;
     p_key  := l_doc.id_o;
     p_sign := l_doc.sign;

     bars.bars_audit.info(l_trace||'extref = '||p_ext_ref||', buffer = '||l_asciibuff ||' hex buff='||l_hexbuff||', sign='||p_sign);
             
  end;  
									  


  -----------------------------------
  -- POST_DOCUMENT
  --
  -- �������� ��������
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

    bars.bars_audit.info('bars_docsync.post_document: ������ ������� ���������. EXT_REF='||p_ext_ref);

    d := read_corp_doc(p_ext_ref);

    -- ���� ���������� ���� ������, ������� �� ���������
    if not is_bankdate_open() then
        bars.bars_audit.trace('���������� ���� ������, ������ ����������');
        return;
    end if;
    -- �������� � ����� ���������� ����
    reset_bankdate;
    l_errmod := 'DOC';
    l_bankdate := bars.gl.bDATE;
    -- ��������: �������� d.tt ���������� ?
    begin
        select * into l_tt from bars.tts where tt=d.tt;
    exception when no_data_found then
        bars.bars_error.raise_nerror(l_errmod, 'TRANSACTION_DOES_NOT_EXIST', d.tt);
    end;

    -- ��������: ������� ����� ��-����� � ��� ������
    if l_tt.fli=1 and substr(l_tt.flags,38,1)='1' then
        bars.bars_error.raise_nerror(l_errmod, 'SEP_TRANS_VISA_REQ', d.tt);
    end if;
    -- ��������� ��������
    l_vdat := nvl(d.vdat, l_bankdate);
    l_sq := case
            when d.kv=bars.gl.baseval then null
            else bars.gl.p_icurval(d.kv, d.s, l_vdat)
            end;

    bars.gl.ref(l_ref);

    bars.bars_audit.trace('bars_docsync.post_document: ������� ��� ���������: '||l_ref);

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

    bars.bars_audit.trace('bars_docsync.post_document: �������� ������� � ���� c ��� ='||l_ref);

    -- ��������� ext_ref ��� ���-��������
    insert into bars.operw(ref,tag,value) values(l_ref,'EXREF',to_char(d.ext_ref));

    bars.bars_audit.trace('bars_docsync.post_document: ����� ������������ ���. ����������');

    -- ��������� ���������� ���. ���������
    for r in (select * from doc_import_props where ext_ref = d.ext_ref) loop
        begin
            select * into l_tag_info from bars.op_field where tag=r.tag;
        exception when no_data_found then
            bars.bars_error.raise_nerror(l_errmod, 'TAG_NOT_FOUND', r.tag);
        end;
        if l_tag_info.chkr is not null then
            -- �������� ���. ��������� �� ������������
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

    -- ���������� ������� BIS=1 ��� �������������
        
    if get_bis_count(l_ref) > 0 then
       update bars.oper set bis = 1
       where ref=l_ref;
       bars.bars_audit.trace('bars_docsync.post_document: ������� ��� ������');     
    end if;     
        

    bars.bars_audit.trace('bars_docsync.post_document: ����� ������������ ���. ���������� � ���');
    -- ��������� ���. ��������� � ���
    if l_tt.fli=1 then
        l_d_rec := '';
        for s in (select w.tag, w.value, f.vspo_char
                    from bars.operw w, bars.op_field f
                    where w.ref = l_ref
                      and w.tag = f.tag
                      and f.vspo_char is not null
                      and f.vspo_char not in ('F','C','�')
                  )
        loop
            -- ��� ���������  SWIFT
            if s.vspo_char = 'f' and d.mfo_a = '300465' then continue;
            end if;

            l_d_rec := l_d_rec || '#'||s.vspo_char||s.value;
        end loop;

        if l_d_rec is not null and length(l_d_rec)>0 then
            l_d_rec := l_d_rec || '#';
        end if;
        update bars.oper set d_rec = l_d_rec where ref=l_ref;
    end if;

    -- ��������: ������� ������������ ���. ����������
    for c in (select * from bars.op_rules where tt=d.tt and opt='M') loop
        begin
            select ref into l_needless from bars.operw where ref=l_ref and tag=c.tag;
        exception when no_data_found then
            bars.bars_error.raise_nerror(l_errmod, 'MANDATORY_TAG_ABSENT', c.tag, d.tt);
        end;
    end loop;


    p_ref := l_ref;

    bars.bars_audit.info('bars_docsync.post_document: �������� ������� ����������� � REF='|| p_ref);
  end;


  -----------------------------------
  -- GET_DOC_BUFFER
  --
  -- �������� ������� ��� �������
  --

   procedure get_doc_buffer ( p_ref     in integer,
                              p_key     in varchar2,
                              p_int_buf out varchar2,
                              p_sep_buf out varchar2) is
    l_buffer varchar2(4000);
  begin
    -- ��������� ��� ������
    bars.docsign.retrievesepbuffer(p_ref, p_key, l_buffer);
    p_sep_buf := rawtohex(utl_raw.cast_to_raw(l_buffer));
    bars.chk.make_int_docbuf(p_ref, l_buffer);
    p_int_buf := rawtohex(utl_raw.cast_to_raw(l_buffer));
  end;


  -----------------------------------
  -- PAY_DOCUMENT
  --
  -- ���������� ���� ��������
  --
  procedure pay_document(p_ext_ref number, p_ref  number) is
    --l_ref           bars.oper.ref%type;
    l_sos           bars.oper.sos%type;
    l_vdat          date;
    l_sq            number;
    l_doc           doc_import%rowtype;
    l_tt_flags      bars.tts.flags%type;
  begin
     bars.bars_audit.info('bars_docsync.pay_document: ������ ������ ���������. EXT_REF='||p_ext_ref||', REF='||p_ref);
     l_doc := read_corp_doc(p_ext_ref);

     l_vdat := nvl(l_doc.vdat, bars.gl.bdate);
     l_sq := case
             when l_doc.kv = bars.gl.baseval then null
             else bars.gl.p_icurval(l_doc.kv, l_doc.s, l_vdat)
             end;

    select flags into l_tt_flags from bars.tts where tt = l_doc.tt;

    -- ������
    bars.gl.dyntt2 (
          l_sos, to_number(substr(l_tt_flags,38,1)), 1,
          p_ref, l_vdat,
          null, l_doc.tt, l_doc.dk,
          l_doc.kv,  l_doc.mfo_a, l_doc.nls_a, l_doc.s,
          l_doc.kv2, l_doc.mfo_b, l_doc.nls_b, l_doc.s2, l_sq, null);


    --
    -- � ����� ����������� �������� ���������, ���� ������ � ����
    bars.bars_audit.info('bars_docsync.pay_document_document: ������������� ������� ��������� � doc_import');
    update doc_import
      set ref = p_ref,
          booking_flag='Y',
          booking_date = sysdate,
          booking_err_code = null,
          booking_err_msg = null
    where ext_ref = l_doc.ext_ref;

    -- ����������� ���������� ��� ��������� ��� ����������� ������ �� ���
    if l_doc.tt in ('IBB','IBO','IBS') then
        update bars.sw_template
           set ref = p_ref,
               user_id = l_doc.userid
         where doc_id = l_doc.ext_ref;
    end if;

    bars.bars_audit.info('bars_docsync.pay_document: �������� EXT_REF='||p_ext_ref||', REF='||p_ref||' �������, oper.sos= '||l_sos);


  end pay_document;

  
  

  ------------------------------------
  --  POST_ERROR_PROC
  --
  --  ����� �������� ��� ���������� ����� ���������� ��������� ���������
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

     bars.bars_audit.error('bars_docsync.post_error_proc: ��������� ������ ������: errcode='||p_sqlerr_code||', errmsg='||substr(p_sqlerr_stack, 1, 3900));
     l_doc := read_corp_doc(p_ext_ref);
     --l_bars_doc := read_bars_doc(l_doc.ref);
     
     -- ������� ���������� � ��������� �� ����������� sw_template � ���
     if l_doc.tt in ('IBB','IBO','IBS') then
        delete from bars.sw_template where doc_id = l_doc.ext_ref;
     end if;


     -- ��������� ���������� �� ������
     l_err_code := p_sqlerr_code;
     l_err_msg  := substr(p_sqlerr_stack, 1, 3900);

     -- ���������� ������ ���������� ��� ������������� ��� ������� ���-�� � ���������� ���������� ���-� �������
     
     -- �� ������ �� �����:    
     -- ���� ������ ��� ���������� �������� � ������� ���������� �����  ORA-20203: \9301 broken limit on accounts
     -- ����� ��� �� ������������ (�.�. �� ������������� booking_flag = N), � ��������� �� ��������� ������ � ���� ����, 
     -- � ������ � ��������� ���������� ���� - ��������� ��� (�.�. �� ������������� booking_flag = N) 
     
     if   l_err_code >-21000 and l_err_code<=-20000 then
         -- ��� ������� �� ����� � ���� ���� = �������������  - �������� ��������� �� ��������� ������
        l_doc_vdat := nvl(l_doc.vdat, bars.gl.bdate);
        
        bars.bars_audit.info(l_trace||'vdat='|| to_date(l_doc_vdat,'dd/mm/yyyy') ||' bars.gl.bdate='||to_date(bars.gl.bdate,'dd/mm/yyyy')||', instr ='||instr(l_err_msg, '\9301') );

     -- ��������� ���������� ������, ������� ������ ���� ��������� ������ 
        
     -- ���� ������ ��� ���������� �������� � ������� ���������� �����  ORA-20203: \9301 broken limit on accounts
     -- ����� ��� �� ������������ , � ��������� �� ��������� ������ � ���� ����
      if ( (l_err_code = -20203 and instr(l_err_msg, '\9301') > 0 and  l_doc_vdat = bars.gl.bdate) 
            or
           (l_err_code = -20060)   -- ������� ���� ������������� (������� � ������� ������ DOC)
         )   
         then 
            -- ������ ����� ��������� � ��������� �����
            update doc_import
              set system_err_code = l_err_code,
                  system_err_msg  = l_err_msg,
                  system_err_date = sysdate
            where ext_ref = l_doc.ext_ref;
          bars.bars_audit.info(l_trace||'�������� ����� �� ����� - �������� ������� ������ � ��������� ����� ���������' );     
        else 
            -- ��������� ����������� �������, ���� "���� �������" � ��.
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

                 bars.bars_audit.info(l_trace||'������ ���������� - �������� ���������� ��� ���������� ������' );
             end if;
        end if;
     else
            -- ��������� ������ ����������� ��� �������
            -- ������ ����� ��������� � ��������� �����
            update doc_import
              set system_err_code = l_err_code,
                  system_err_msg  = l_err_msg,
                  system_err_date = sysdate
            where ext_ref = l_doc.ext_ref;
          bars.bars_audit.info(l_trace||'������ ��������� - �������� ������� ������ � ��������� ����� ���������' );
     end if;

  end;




  ------------------------------------
  --  SUBST_NEDDED_BRANCH
            --
  --  ���������� ������ ����� ��� �������� ��������� � ���
            --
  procedure subst_nedded_branch(p_ext_ref number) is
     l_branch_isp    varchar2(30);
     l_branch        varchar2(30);
     l_doc           doc_import%rowtype;
            begin

      l_doc := read_corp_doc(p_ext_ref);

                -- ����: ������������ ��� � ����� �������� ��������
      if sys_context('bars_context','user_mfo') <> l_doc.mfo_a then
         bars.bars_context.subst_mfo(l_doc.mfo_a);
                end if;

      select branch into l_branch
        from bars.accounts
       where nls = l_doc.nls_a
         and kv = l_doc.kv
         and kf = l_doc.mfo_a;

                --COBUMMFO-4647 �������� ������ ������� ��������� � ������ �������� �����. ����� ����������� �� �����������(��� ���������������)
                --COBUMMFO-4647 �������� ������ ������� ��������� � ������ �������� �����. ����� ����������� �� �����������(��� ���������������)
                -- ���� ����� ������������-�������������
                -- select branch into l_branch_isp from bars.staff$base where id=d.userid;
                -- ��� ������������ �� '/' ����� ������������� ��� �����������
     --select case when branch='/' then '/'||l_doc.mfo_a||'/' else branch end
       --into l_branch_isp
       --from bars.staff$base
      --where id = l_doc.userid;

                -- ���� ������ ����� ������������ �� ���� ��� �����
     --if l_branch_isp like l_branch||'%' then
                    -- ������������ ������� ���������� �����������
                    bars.bars_context.subst_branch(l_branch);
     /*else
                    -- ������������ ������� ���������� �����������
                    bars.bars_context.subst_branch(l_branch_isp);
     end if; */

     bars.bars_audit.trace('bars_docsync.subst_nedded_branch: ������������� ������� - '|| sys_context('bars_context','user_branch'));
  end;



  ------------------------------------
  -- ASYNC_AUTO_PAY
                --
  -- ��������� ��� ������������� ���������� ����2 ���������
  -- ������������ ��������� � ��� ������
                --
  procedure async_auto_pay (p_ext_ref number, p_ref out number)
  is
     l_ref number;
     l_errmod varchar2(3) := 'DOC';
     l_errtxt varchar2(4000);
     
  begin
      
      bars.bars_audit.info('bars_docsync.async_auto_pay: ����� ������������ � ������ ��������� EXT_REF='||p_ext_ref);
      
      --savepoint sp_before_pay;
      --���������� ������ ����� ��� �������� ��������� � ���
      subst_nedded_branch( p_ext_ref => p_ext_ref );

      -- ������� ��������� � ���. �����������
      post_document ( p_ext_ref => p_ext_ref , p_ref => l_ref );

      -- ������ ��������� (��� ��������� ���)
      pay_document( p_ext_ref => p_ext_ref , p_ref => l_ref);

      -- ��������� ��� � ������������� ������ ����� ������������

      p_ref := l_ref;

      bars.bars_audit.trace('bars_docsync.async_auto_pay: ����������� � ������ ��������� EXT_REF='||p_ext_ref||' ��������� c REF = '||l_ref);
            exception when others then
          
          --��������������, ��� ������������� ������ (��������� ������ � �.�.) ����� ��������� ���������
          l_errtxt := substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 3900);
          bars_audit.error('bars_docsync.async_auto_pay: ������ ���������� ��� EXT_REF=:'||p_ext_ref||': '||l_errtxt); 
          -- ����� �������� ��������� ������. ��������� � ������������� ���� ������ ���� ������:
          --  ���� ��������� - ���� ������� ������
          --  ���� ����������, �������� ��������������� � ������
          raise;
  end;

  ------------------------------------
  -- GET_BIS_COUNT
  --
  -- ��������� ������� ��� �����
  --
  function get_bis_count(p_ref      in number) return number
  is
     l_cnt number;
  begin
     select count(*) into l_cnt
                 from bars.operw w, bars.op_field v
                where w.ref = p_ref
                  and w.tag = v.tag
                  and v.vspo_char in ('F','�','C')
                order by v.vspo_char,w.tag; 
     return l_cnt;
  end;



  ------------------------------------
  -- POST_SEP_ROWS
  --
  -- �������� ������ � arc_rrp
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
     
     bars.bars_audit.info(l_trace||'����� ������� ����� � arc_rrp EXT_REF='||p_ext_ref);
     -- ���� ��� ���� ������ - ���������� ������ ���������� �������
     for c in (select w.tag, w.value, v.vspo_char
                 from bars.operw w, bars.op_field v
                where w.ref = l_doc.ref
                  and w.tag = v.tag
                  and v.vspo_char in ('F','�','C')
                order by v.vspo_char,w.tag
               ) loop

          -- � ��������� ������� ��� ������ ����� ���� � ����� ������ ����� ������� ������� (�� ������ CHK)
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
     bars.bars_audit.trace(l_trace||'���-�� ��� �����: '||l_bis_count);

     l_bis_curr := 0;  -- ����� ������� ������ � arc_rrp, �������� � 0
     l_arc.rec  := 0;
     --l_arc_count := l_bis_count + 1;
     --l_arc_curr  := 
     -- �������� ����������� ������ ��� arc_rrp
     -- �������� �� ���� ������ ������� � arc_rrp
     while l_bis_curr <= l_bis_count loop
           if l_bis_curr = 0 then -- ������ ������ � arc_rr
              l_arc.d_rec := case when l_bis_count > 0 then '#B' || lpad(l_bis_count + 1, 2, '0') || nvl(l_doc.d_rec, '#') else l_doc.d_rec end; 
              l_arc.nazns := case when l_bis_count > 0 then '11' else  '10' end;
              l_arc.bis   := case when l_bis_count = 0 then 0 else 1 end;
              l_arc.sign  := l_doc.sign;
           else              -- ��������� ������
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
     bars.bars_audit.info('bars_docsync.async_auto_visa: �������� EXT_REF='||p_ext_ref||',  REF = '||l_doc.ref||' �������� � arc_rrp, l_sep_err=<'||l_sep_err||'>, ���-�� ��� ����� = '||l_bis_count);
  end;

  
  
  ------------------------------------
  -- ASYNC_AUTO_VISA
  --
  -- ��������� ��� ������������� ���������� ����2 ���������
  -- ��������� ��� � ���������, ������ ��-�����
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
     bars.bars_audit.info('bars_docsync.async_auto_visa: ����� ������������ �������� � ������ ��-����� ��� ��������� EXT_REF='||p_ext_ref||',  REF = '||p_ref);
     l_doc     := read_bars_doc(p_ref);
     l_ext_doc := read_corp_doc(p_ext_ref);

     -- �������� ������� ������� ������ � ���������� ����� � oper_visa.sign � ������ �����
     bars.chk.put_visa( ref_    => p_ref ,
                       tt_     => l_doc.tt,
                       grp_    => null,
                       status_ => 0,
                       keyid_  => l_ext_doc.id_o,
                       sign1_  => l_ext_doc.sign,
                       sign2_  => null);

     bars.bars_audit.info('bars_docsync.async_auto_visa: ��������� ���� � ���������� �������� ������������');


    -- ������ ��������� ����
     select idchk into l_chk_group
         from bars.chklist_tts
        where priority = 1
          and tt = l_doc.tt;

    -- �������� �������, ��������� ��� ��� ���
    if ( l_doc.mfoa <> l_doc.mfob and l_doc.tt in ('IB2','IB4')) then

    -- �������� ������ � ��������� ���� �� ��� � �������� �������� ����-���
       bars.chk.put_visa(ref_     => p_ref ,
                          tt_     => l_doc.tt,
                          grp_    => l_chk_group,
                          status_ => 2,
                          keyid_  => p_key,
                          sign1_  => p_int_sign,
                          sign2_  => p_sep_sign);

       bars.bars_audit.info('bars_docsync.async_auto_visa: ��� �������� ��������� ���� � ������� �������� ������������ � ������� ����������� '||l_chk_group);

       -- ���������� �������� ������������� �� ��������� "�������"
       bars.bars_audit.info('bars_docsync.async_auto_visa: ����� ������ ��������� ��-����� � ����� ������������� '||to_char(l_doc.vdat,'dd/mm/yyyy'));
       bars.gl.pay( p_flag => 2,
                    p_ref  => p_ref,
                    p_vdat => l_doc.vdat);
       
       l_doc     := read_bars_doc(p_ref);

       bars.bars_audit.info('bars_docsync.async_auto_visa: �������� EXT_REF='||p_ext_ref||',  REF = '||p_ref||' ������� ������� ��-����� � oper, sos='||l_doc.sos );
       
       -- ��� - �� ������� ��� (��������, ���� ������������� ������ ��� ������� - ����� �������� ��������� ����� ���� �������������. � ���� ������ ������ ���������������� ������.)
       if (l_doc.sos <> 5 ) then
            -- �� ������� ������� �������� �� ���� ���������� ��-�����. ��� ���� ������(exception) ����� �� ����.
            -- ��������, ������� ���� �������������. ��-����� ���������� ���������� ������
            if l_doc.vdat > bars.gl.bDATE then
               bars.bars_error.raise_nerror( G_ERRMOD, 'FUTURE_VALUE_DATE', p_ext_ref, p_ref, to_char(l_doc.vdat,'dd/mm/yyyy')); 
                    end if;
            
            bars.bars_error.raise_nerror( G_ERRMOD, 'FAILED_TO_PAY_BY_FACT', p_ext_ref, p_ref);
             
       end if;
       
       bars.bars_audit.info('bars_docsync.async_auto_visa: �������� EXT_REF='||p_ext_ref||',  REF = '||p_ref||' ������� ������� ��-����� � oper, sos='||l_doc.sos );
       -- ���� ������� ��������
       if (l_doc.sos = 5 ) then
           -- ������ ������ � arc_rrp (��� �� ����)
           post_sep_rows (p_ext_ref => p_ext_ref, p_doc => l_doc);
                else
           bars.bars_audit.info('bars_docsync.async_auto_visa: ��� ������� ���������� ���/��� ���������, �������� EXT_REF='||p_ext_ref||',  REF = '||p_ref||' �� ��� ������� ��-�����, sos='||l_doc.sos);
                end if;

     
    else
       
      -- �������� ������ � ��������� ���� ��� ����������� ��������� 
      bars.chk.put_visa(ref_    => p_ref         ,
                        tt_     => l_doc.tt      ,
                        grp_    => l_chk_group   ,
                        status_ => 2             ,
                        keyid_  => l_ext_doc.id_o,
                        sign1_  => l_ext_doc.sign,
                        sign2_  => null);


-- ���������� �������� ������������� �� ��������� "�������"
       bars.gl.pay( p_flag => 2,
                    p_ref  => p_ref,
                    p_vdat => l_doc.datp);
                    
       

    end if;

    bars.bars_audit.info('bars_docsync.async_auto_visa: �������� EXT_REF='||p_ext_ref||',  REF = '||p_ref||' ������� ������� ��-�����');
    
            end;






  ------------------------------------
  -- ASYNC_PAY_DOCUMENTS
  --
  -- ��������� ����������� ������ ���������� �� ������ �������
  --  p_pay_type:
  --  G_PAYTYPE_AUTO   constant smallint  := 0;
  --  G_PAYTYPE_MANUAL constant smallint  := 1;
  --
  --
  procedure async_pay_documents  is
    l_ref number;
	l_doc_count     integer := 0;
  begin
    bars.bars_audit.info('bars_docsync.async_pay_documents: ����� ��������� ������ ����������. ��������� ����: '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') );
	
    -- ���� �� ����������
    for d in (select * from doc_import d
              where 
                     -- ������� ����� case, ��� ��� �������� �����, �����  ���������� ������ ������ ��� ��� �������. � ������ �������� ���, � � ������� ����� 60 ��� �������.
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
               bars.bars_audit.info('bars_docsync.async_pay_documents: ����� ��������� ������ ��������� EXT_REF='||d.ext_ref);
               --���������� ������ ����� ��� �������� ��������� � ���
               subst_nedded_branch( p_ext_ref => d.ext_ref );

               -- ������� ��������� � ���. �����������
               post_document ( p_ext_ref => d.ext_ref , p_ref => l_ref );

               -- ������ ���������
               pay_document( p_ext_ref => d.ext_ref,  p_ref => l_ref);

               -- ��������� ������� ����
               bars.chk.put_visa(l_ref,  d.tt, null, 0, d.id_o, d.sign, null);

            exception when others then
                rollback to sp_before_pay;
                post_error_proc(p_ext_ref => d.ext_ref,
                                p_sqlerr_code => SQLCODE,
                                p_sqlerr_stack => substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 3900));
            end;
            -- ��������� ������ ���������
            commit;
            --
			l_doc_count := l_doc_count + 1;
        end if;
    end loop;
    -- ������������ � ���� �������� ��� ������-���
    bars_sync.set_context();
    --
    bars.bars_audit.info('bars_docsync.async_pay_documents: ����� ��������� ������. ����� ���������� ����������: '||l_doc_count||'. ��������� ����: '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'));
  end async_pay_documents;



  ----
  -- reset_booking_info - ���������� ���������� �� ������ ���������
  -- @p_ext_ref - ������� �������� ���������
  --
  procedure reset_booking_info(p_ext_ref in varchar2) is
  begin
    update doc_import set booking_flag=null, booking_date=null, booking_err_code=null, booking_err_msg=null
    where ext_ref=p_ext_ref and removal_flag is null;
    if sql%rowcount=0 then
        raise_application_error(-20000, '�������� �� ������ ��� �������� EXT_REF='
                                        ||p_ext_ref||' ��� ������� � ��������.', TRUE);
    end if;
    bars.bars_audit.info('���������� �� ������ ��������� EXT_REF='||p_ext_ref||' ������� ��������.');
  end reset_booking_info;

  ----
  -- async_remove_documents - ������� ���������� � �������� ��������� � ����������� ����� ��������
  --
  procedure async_remove_documents is
  begin
    bars.bars_audit.trace('start');
    -- ������� ������� ���������� � �������� ���������
    for c in (select * from doc_import where removal_flag='Y' and removal_date<=sysdate for update skip locked)
    loop
        delete from doc_import_props where ext_ref=c.ext_ref;
        delete from doc_import where ext_ref=c.ext_ref;
        bars.bars_audit.info('���������� � �������� �������� EXT_REF='||c.ext_ref||' ������� ������.');
    end loop;
    -- ������� ��������� ������� ������ 15 ���� ��� ������� � ��������
    for c in (select * from doc_import where removal_flag is null and insertion_date<sysdate-15 for update skip locked)
    loop
        delete from doc_import_props where ext_ref=c.ext_ref;
        delete from doc_import where ext_ref=c.ext_ref;
        bars.bars_audit.info('������������ � ������� 15 ���� �������� EXT_REF='||c.ext_ref||' ������� ������.');
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
 