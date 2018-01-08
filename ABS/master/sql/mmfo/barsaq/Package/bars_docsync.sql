
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/bars_docsync.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSAQ.BARS_DOCSYNC is

  -- Copyryight : UNITY-BARS
  -- Author     : SERG
  -- Created    : 26.09.2007
  -- Purpose    : ����� �������� ��� ������� ����������

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.06 15/09/2009';

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

  ----
  -- pay_document - ���������� ���� ��������
  --
  procedure pay_document(p_doc in doc_import%rowtype);

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

end bars_docsync;
/
CREATE OR REPLACE PACKAGE BODY BARSAQ.BARS_DOCSYNC is

  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 1.23 05/08/2013';

  G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := ''

    ||'KF - ����� � ����� ''kf''' || chr(10)
  ;

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
              -- ���� ������ '\'
              l_slash_pos := instr(l_sqlerrm, '\');
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

  ----
  -- pay_document - ���������� ���� ��������
  --
  procedure pay_document(p_doc in doc_import%rowtype) is
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
    l_sos           bars.oper.sos%type;
    l_needless      number;
    l_sq            integer;
    l_bis           integer;
  begin
    d := p_doc;
    bars.bars_audit.info('������ ������ ���������. EXT_REF='||d.ext_ref);
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
    -- ��������� ��� ��������, �.�. ������ ������ �� ������������
    /*
    -- ��������: ������������ ��������� �������� d.tt ?
    begin
        select t.* into l_tt from bars.tts t, bars.staff_tts s
        where t.tt=d.tt and t.tt=s.tt and t.fli<3 and substr(flags,1,1)='1'
              and s.id in (select d.userid from dual
                           union all
                           select id_whom from bars.staff_substitute where id_who=d.userid
                           and bars.date_is_valid(date_start, date_finish, null, null)=1
                          )
              and rownum=1;
    exception when no_data_found then
        bars.bars_error.raise_nerror(l_errmod, 'TRANSACTION_NOT_ALLOWED', d.tt);
    end;
    */
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
        id_o_   => null,
        sign_   => null,
        sos_    => 0,
        prty_   => nvl(d.prty,0),
        uid_    => d.userid
    );
    -- ��������� ext_ref ��� ���-��������
    insert into bars.operw(ref,tag,value) values(l_ref,'EXREF',to_char(d.ext_ref));
    -- ��������� ���������� ���. ���������
    for r in (select * from doc_import_props where ext_ref=d.ext_ref) loop
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
    begin
        select 1 into l_bis from doc_import_props
        where ext_ref=d.ext_ref and tag in ('C01','�01');
        update bars.oper set bis=l_bis where ref=l_ref;
    exception when no_data_found then
        null;
    end;
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
          l_ref, l_vdat, null, d.tt, d.dk,
          d.kv,  d.mfo_a, d.nls_a, d.s,
          d.kv2, d.mfo_b, d.nls_b, d.s2, l_sq, null);
    --
    -- ������ ������� ���� � ��������
    bars.chk.put_visa(l_ref, d.tt, null, 0, d.id_o, d.sign, null);
    --
    -- � ����� ����������� �������� ���������, ���� ������ � ����
    update doc_import set ref=l_ref, booking_flag='Y', booking_date=sysdate,
    booking_err_code=null, booking_err_msg=null where ext_ref=d.ext_ref;
    -- ����������� ���������� ��� ��������� ��� ����������� ������ �� ���
    if d.tt in ('IBB','IBO','IBS') then
        update bars.sw_template set ref=l_ref, user_id=d.userid where doc_id=d.ext_ref;
    end if;

    bars.bars_audit.info('�������� ��������. EXT_REF='||d.ext_ref||', REF='||l_ref);
  end pay_document;

  ----
  -- async_pay_documents - ��������� ����������� ������ ����������
  --
  procedure async_pay_documents is
    l_err_code      number;
    l_err_msg       varchar2(4000);
    l_app_err       integer;
    l_ignore_count  integer;
    l_err_count     integer;
    l_ignore_error  boolean;
    l_branch        varchar2(30);
    l_branch_isp    varchar2(30);
  begin
    bars.bars_audit.trace('bars_docsync.async_pay_documents: start');
    -- ���� �� ����������
    for d in (select * from doc_import where
              case
              when confirmation_flag='Y' and booking_flag is null and removal_flag is null then 'Y'
              else null
              end
              = 'Y'
              order by confirmation_date, ext_ref)
    loop
        if lock_document4pay(d.ext_ref) then
            --
            savepoint sp_before_pay;
            --
            begin
                -- ����: ������������ ��� � ����� �������� ��������
                if sys_context('bars_context','user_mfo') <> d.mfo_a then
                    bars.bars_context.subst_mfo(d.mfo_a);
                end if;

                select branch into l_branch from bars.accounts
                where nls = d.nls_a and kv = d.kv and kf = d.mfo_a;
                
                -- ���� ����� ������������-�������������
                -- select branch into l_branch_isp from bars.staff$base where id=d.userid;
                -- ��� ������������ �� '/' ����� ������������� ��� �����������
                select case when branch='/' then '/'||d.mfo_a||'/' else branch end into l_branch_isp from bars.staff$base where id=d.userid;
                
                -- ���� ������ ����� ������������ �� ���� ��� �����
                if l_branch_isp like l_branch||'%' then
                    -- ������������ ������� ���������� �����������
                    bars.bars_context.subst_branch(l_branch);
                else
                    -- ������������ ������� ���������� �����������
                    bars.bars_context.subst_branch(l_branch_isp);
                end if;
                --
                pay_document(d);
                --
            exception when others then
                rollback to sp_before_pay;
                -- ������� ���������� � ��������� �� ����������� sw_template � ���
                if d.tt in ('IBB','IBO','IBS') then
                    delete from bars.sw_template where doc_id=d.ext_ref;
                end if;
                bars.bars_audit.error('DOCSYNC: '||substr(dbms_utility.format_error_stack(), 1, 3900));
                -- ��������� ���������� �� ������
                l_err_code := SQLCODE;
                l_err_msg  := substr(dbms_utility.format_error_stack()||chr(10)
        ||dbms_utility.format_error_backtrace()
        , 1, 3900);
                -- ���������� ������ ���������� ��� ������������� ��� ������� ���-��
                -- � ���������� ���������� ���-� �������
                if l_err_code>-21000 and l_err_code<=-20000 then
                    -- ��������� ����������� �������, ���� "���� �������" � ��.
                    l_app_err  := extract_app_error(l_err_msg);
                    begin
                        select ignore_count into l_ignore_count from doc_error_behavior where ora_error=l_err_code
                        and (app_error is null and l_app_err is null or app_error=l_app_err);
                        l_err_count := nvl(d.ignore_count, 0) + 1;
                        update doc_import set ignore_err_code=l_err_code, ignore_err_msg=l_err_msg, ignore_count=l_err_count, ignore_date=sysdate
                        where ext_ref=d.ext_ref;
                        l_ignore_error := true;
                    exception when no_data_found then
                        l_ignore_error := false;
                    end;
                    if not l_ignore_error or l_ignore_error and l_err_count>l_ignore_count then
                        update doc_import set booking_flag='N', booking_date=sysdate,
                        booking_err_code=l_err_code, booking_err_msg=l_err_msg where ext_ref=d.ext_ref;
                    end if;
                else
                    -- ��������� ������ ����������� ��� �������
                    -- ������ ����� ��������� � ��������� �����
                    update doc_import set system_err_code=l_err_code, system_err_msg=l_err_msg, system_err_date=sysdate
                    where ext_ref=d.ext_ref;
                end if;
            end;
            -- ��������� ������ ���������
            commit;
            --
        end if;
    end loop;
    -- ������������ � ���� �������� ��� ������-���
    bars_sync.set_context();
    --
    bars.bars_audit.trace('bars_docsync.async_pay_documents: finish');
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
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/bars_docsync.sql =========*** End 
 PROMPT ===================================================================================== 
 