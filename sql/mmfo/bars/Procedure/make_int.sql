

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MAKE_INT.sql =========*** Run *** 
PROMPT ===================================================================================== 


  CREATE OR REPLACE PROCEDURE BARS.MAKE_INT 
( p_dat2      in date,             -- ��������� ���� ���������� ���������
  p_runmode   in number default 0, -- ����� ������� (0 - ����������,1 - ������)
  p_runid     in number default 0, -- � �������
  p_intamount out number,          -- ����� ����������� ��������� (��� 1-�� �����)
  p_errflg    out boolean          -- ���� ������                 (��� 1-�� �����)
) is
  -- ====================================================================================
  -- ��������� ���������� ��������� (������� +/- ������) version 1.8.8 14.11.2017
  -- dptweb - ����������� ���������� ���������� �������
  -- acr_dat - � ������������ ������ ���������
  -- sber - ��������� ���������
  -- tax - ������������� ���������� ������ ��
  -- ====================================================================================
  --
  -- ���������
  --
  modcode    constant char(3)    not null := 'INT';
  title      constant char(4)    not null := 'INT:';
  errmsgdim  constant number(38) not null := 3000;
  rowslimit  constant number(38) not null := 1000;
  autocommit constant number(38) not null := 1000;

  --
  -- ��������������� ���������� ������
  --
  tax_tt     constant varchar2(3) := '%15';
  tax_mil_tt constant varchar2(3) := 'MIL';
  l_tax_method            int    := F_GET_PARAMS('TAX_METHOD', 2); -- 2 - ������ ������� �� ����� � ������ / 3 - ���� ����� � ��������
  l_tax_required          int    := 0; -- ���������� ��� ����������� ������������� ������ ������ �� ���� ���������
  l_tax_socfactor         int    := 1; -- ���������� ��� ����������� ������������� ������ ������ � ������ ������������ �������
  l_tax_s                 number := 0; -- ��������� ���������� ��� ������������ ������ �� �������� � �����
  l_tax_sq                number := 0; -- ��������� ���������� ��� ������������ ������ �� �������� � ����� (� �����������)
  l_tax_mil_s             number := 0; -- ��������� ���������� ��� ������������ ������ �� �������� � �����
  l_tax_mil_sq            number := 0; -- ��������� ���������� ��� ������������ ������ �� �������� � ����� (� �����������)
  l_taxrow_tax_base_s     number := 0; -- ���� ��������������� ��� ����
  l_taxrow_mil_tax_base_s number := 0; -- ���� ��������������� ��� �������� �����

  l_tax_base_soc          number := 0; -- ����� ����������� %% �� ������ "����������� �������"
  l_tax_base_soc_sq       number := 0; -- ����� ����������� (���) %% �� ������ "����������� �������"

  l_tmp_s_soc             number := 0;
  l_tmp_sq_soc            number := 0;
  l_tmp_mil_s_soc         number := 0;
  l_tmp_mil_sq_soc        number := 0;

  l_tax_s_soc             number := 0;
  l_tax_sq_soc            number := 0;
  l_tax_mil_s_soc         number := 0;
  l_tax_mil_sq_soc        number := 0;

  type t_tax_settings is record(
    tax_type          number, --
    tax_int           number, -- % ������;
    tax_date_begin    date,   -- ������ �������� ������� ���������������;
    tax_date_end      date    -- �����  �������� ������� ��������������� ���� 4110; ���� ���� ����� �������� ��������� �� �����������, �� ���������, +1 ����� �� �������
    );

  type t_taxdata is table of t_tax_settings;

  type t_soc_turns_rec is record(
    accd       number,
    soc_factor number, -- ����������� ���������� ������������ �������;
    date_begin date,   -- ������ �������� ������� ������������ �������;
    date_end   date    -- �����  �������� ������� ������������ �������;
    );

  type t_soc_turns_data is table of t_soc_turns_rec;

  l_taxrow     dpt_15log%rowtype;
  l_taxrow_mil dpt_15log%rowtype;

  type t_taxnls is table of accounts.nls%type index by accounts.branch%type;

  g_taxnls_list          t_taxnls;
  g_taxnls_list_military t_taxnls;

  --
  -- ����
  --
  type t_rwdata is table of rowid;

  type t_intrec is record(
    kf          varchar2(12),
    branch      varchar2(30),
    deal_id     number(38),
    deal_num    varchar2(35),
    deal_dat    date,
    cust_id     number(38),
    int_id      number(1),
    acc_id      number(38),
    acc_num     varchar2(15),
    acc_cur     number(3),
    acc_nbs     char(4),
    acc_name    varchar2(38),
    acc_iso     char(3),
    acc_open    date,
    acc_amount  number(38),
    int_details varchar2(160),
    int_tt      char(3),
    mod_code    char(3),
    rw          rowid);

  type t_intdata is table of t_intrec;

  --
  -- ����������
  --
  expt_int exception;

  --
  -- ����������
  --
  l_bdate          date := gl.bdate;
  l_userid         staff.id%type := gl.auid;
  l_basecur        tabval.kv%type := gl.baseval;
  l_rwlist         t_rwdata := t_rwdata();
  l_intlist        t_intdata;
  l_taxlist        t_taxdata;
  l_soc_turns_data t_soc_turns_data;
  l_taxlist_mil    t_taxdata; -- ��������� ���
  l_docrec         oper%rowtype;
  l_cardrow        int_accn%rowtype;
  l_cleared        boolean;
  l_errmsg         varchar2(3000);
  l_acrdat         date;
  l_stpdat         date;
  l_cnt            number(38) := 0;
  l_is8            number := 0;

  --
  -- ������������� ������ "��������� �������"
  --

  procedure init_docrec(p_docrec in out oper%rowtype) is
  begin
    p_docrec.ref    := null;
    p_docrec.dk     := null;
    p_docrec.vob    := null;
    p_docrec.tt     := null;
    p_docrec.nazn   := null;
    p_docrec.userid := null;
    p_docrec.vdat   := null;
    p_docrec.s      := null;
    p_docrec.s2     := null;
    p_docrec.kv     := null;
    p_docrec.kv2    := null;
    p_docrec.nlsa   := null;
    p_docrec.nlsb   := null;
    p_docrec.mfoa   := null;
    p_docrec.mfob   := null;
    p_docrec.nam_a  := null;
    p_docrec.nam_b  := null;
    p_docrec.id_a   := null;
    p_docrec.id_b   := null;
    p_docrec.tobo   := null;
  end init_docrec;

  --
  -- ������ ������� ����������
  --
  procedure get_dates(p_acrdat  in out int_accn.acr_dat%type,
                      p_stpdat  in out int_accn.stp_dat%type,
                      p_dat2    in date,
                      p_opendat in accounts.daos%type,
                      p_intid   in int_accn.id%type,
                      p_amount  in number) is
  begin
    bars_audit.trace('%s get_dates: ������, (acr,stp,bd,open)=(%s,%s,%s,%s),id=%s, amount=%s',
                     title,
                     to_char(p_acrdat, 'dd/mm/yy'),
                     to_char(p_stpdat, 'dd/mm/yy'),
                     to_char(p_dat2, 'dd/mm/yy'),
                     to_char(p_opendat, 'dd/mm/yy'),
                     to_char(p_intid),
                     to_char(p_amount));

    bars_audit.info(title || ' get_dates: ������, (acr,stp,bd,open)=(' ||
                    to_char(p_acrdat, 'dd/mm/yy') || ',' ||
                    to_char(p_stpdat, 'dd/mm/yy') || ',' ||
                    to_char(p_dat2, 'dd/mm/yy') || ',' ||
                    to_char(p_opendat, 'dd/mm/yy') || '),id=' ||
                    to_char(p_intid) || ', amount=' || to_char(p_amount));

    if (p_acrdat is null) or
       (p_acrdat is not null and p_acrdat < p_dat2 and p_stpdat is null) or
       (p_acrdat is not null and p_acrdat < p_dat2 and p_acrdat < p_stpdat)
    then -- ��������� ���� ���������� (���� "�")
      p_acrdat := case
                  when (p_acrdat is not null)
                  then p_acrdat + 1
                  when (p_intid in (0, 2))
                  then p_opendat
                  when (p_amount is null)
                  then p_opendat
                  else p_opendat + 1
                  end;
      -- �������� ���� ���������� (���� "��")
      p_stpdat := case
                  when (p_stpdat is null)
                  then p_dat2
                  when (p_dat2 < p_stpdat)
                  then p_dat2
                  else p_stpdat
                  end;
    else
      p_acrdat := null;
      p_stpdat := null;
    end if;

    bars_audit.trace('%s get_dates: ������ ���������� %s-%s',
                     title,
                     to_char(p_acrdat, 'dd/mm/yy'),
                     to_char(p_stpdat, 'dd/mm/yy'));
    bars_audit.info(title || ' get_dates: ������ ���������� ' ||
                    to_char(p_acrdat, 'dd/mm/yy') || '-' ||
                    to_char(p_stpdat, 'dd/mm/yy'));
  end get_dates;

  --
  -- ����������� ������ ��� ������������ ������� (���������� "��������� �������")
  --
  procedure get_docaccs(p_acra   in int_accn.acra%type,
                        p_acrb   in int_accn.acrb%type,
                        p_docrec in out oper%rowtype) is
  begin

    bars_audit.trace('%s get_docaccs: ������, {acra, acrb} = {%s, %s}',
                     title, to_char(p_acra), to_char(p_acrb) );

    -- ���������� ���� � ��������� �������/��������
    select case -- ��� ������� ���. ��
             when ap.nbs = '8618' then
              ap.nlsalt
             else
              ap.nls
           end,
           ap.kv,
           substr(ap.nms, 1, 38),
           cp.okpo,
           ae.nls,
           ae.kv,
           substr(ae.nms, 1, 38),
           ce.okpo
      into p_docrec.nlsa,
           p_docrec.kv,
           p_docrec.nam_a,
           p_docrec.id_a,
           p_docrec.nlsb,
           p_docrec.kv2,
           p_docrec.nam_b,
           p_docrec.id_b
      from bars.accounts ap,
           bars.customer cp,
           bars.accounts ae,
           bars.customer ce
     where ap.acc = p_acra
       and ae.acc = p_acrb
       and ap.rnk = cp.rnk
       and ae.rnk = ce.rnk;

    bars_audit.trace( '%s get_docaccs: ����� = {%s, %s}', title, p_docrec.nlsa, p_docrec.nlsb );

  exception
    when no_data_found then
      bars_audit.trace('%s get_docaccs: ����� �� �������',
                       title);
      bars_audit.info(title || ' get_docaccs: ����� �� �������');
  end get_docaccs;

  --
  -- ����������� ���������� ������� (���������� "��������� �������")
  --
  procedure get_docparams(p_intrec in t_intrec,
                          p_fdat   in date,
                          p_tdat   in date,
                          p_tt     in oper.tt%type,
                          p_metr   in int_accn.metr%type,
                          p_docrec in out oper%rowtype) is
    -- l_rato  number;
    -- l_ratb  number;
    -- l_rats  number;
  begin
    bars_audit.trace('%s get_docparams: ������, � %s �� %s, �������� %s, ����� %s, ����� %s, ���-� %s, ���-� %s',
                     title,
                     to_char(p_fdat, 'dd.mm.yy'),
                     to_char(p_tdat, 'dd.mm.yy'),
                     p_tt,
                     to_char(p_metr),
                     to_char(p_docrec.s),
                     to_char(p_docrec.kv),
                     to_char(p_docrec.kv2));

    p_docrec.dk := case
                     when p_docrec.s > 0 then
                      0
                     else
                      1
                   end;

    if p_metr in (3, 4, 5) then
      p_docrec.dk := 1 - p_docrec.dk;
    end if;

    p_docrec.vob := case
                    when p_docrec.kv = p_docrec.kv2
                    then 6
                    else 16
                    end;

    p_docrec.s := abs(p_docrec.s);

    if (p_docrec.kv = p_docrec.kv2) then
      p_docrec.s2 := p_docrec.s;
    else
      -- gl.x_rat(l_rato, l_ratb, l_rats, p_docrec.kv, p_docrec.kv2, p_docrec.vdat);
      -- p_docrec.s2 := round(p_docrec.s * l_rato);
      p_docrec.s2 := gl.p_icurval(p_docrec.kv, p_docrec.s, p_docrec.vdat);
    end if;

    p_docrec.s2 := abs(p_docrec.s2);

    p_docrec.tt := nvl(p_intrec.int_tt, p_tt);

    if p_intrec.int_details is not null then
      p_docrec.nazn := substr(p_intrec.int_details, 1, 160);
    else
      if p_intrec.mod_code in ('DPT', 'SOC') then
        -- �������� ��
        p_docrec.nazn := substr(bars_msg.get_msg(modcode,
                                                 'INT_DETAILS_TITLE_DPT1') || ' ' ||
                                p_intrec.deal_num || ' ' ||
                                bars_msg.get_msg(modcode,
                                                 'INT_DETAILS_TITLE_DPT2') || ' ' ||
                                to_char(p_intrec.deal_dat, 'dd/mm/yyyy'),
                                1,
                                160);
      else
        -- �� ����
        p_docrec.nazn := substr(bars_msg.get_msg(modcode,
                                                 'INT_DETAILS_TITLE') || ' ' ||
                                p_intrec.acc_num || '/' || p_intrec.acc_iso,
                                1,
                                160);
      end if;
    end if;

    p_docrec.nazn := substr(p_docrec.nazn || ' ' ||
                            bars_msg.get_msg(modcode, 'INT_DETAILS_FROM') || ' ' ||
                            to_char(p_fdat, 'dd.mm.yy') || ' ' ||
                            bars_msg.get_msg(modcode, 'INT_DETAILS_TILL') || ' ' ||
                            to_char(p_tdat, 'dd.mm.yy') || ' ' ||
                            bars_msg.get_msg(modcode, 'INT_DETAILS_INCLUDE'),
                            1,
                            160);

    bars_audit.trace('%s get_docparams: (��,���,����,���,���,����) = {%s,%s,%s,%s,%s,%s}',
                     title,
                     to_char(p_docrec.dk),
                     to_char(p_docrec.vob),
                     p_docrec.tt,
                     to_char(p_docrec.s),
                     to_char(p_docrec.s2),
                     p_docrec.nazn);
  end get_docparams;

  --
  -- ������ ���������
  --
  function make_doc(p_docrec in oper%rowtype) return oper.ref%type is
    l_ref oper.ref%type := null;
  begin
    bars_audit.trace('%s make_doc: ������, %s -> %s, %s %s %s',
                     title,
                     p_docrec.nlsa || ' (' || to_char(p_docrec.s) || '/' ||
                     to_char(p_docrec.kv) || ')',
                     p_docrec.nlsb || ' (' || to_char(p_docrec.s2) || '/' ||
                     to_char(p_docrec.kv2) || ')',
                     p_docrec.tt,
                     to_char(p_docrec.vdat, 'dd.mm.yy'),
                     p_docrec.nazn);

    bars_audit.info(title || ' make_doc: ������ ' || p_docrec.nazn);

    --if (p_docrec.branch <> sys_context ('bars_context', 'user_branch'))
    --then                                    -- ������� ��� ������ ���������
    -- ��� ����������� ������ ������� �� ������ � ������ ��������
    --   bars_context.subst_branch (p_docrec.branch);
    --end if;

    gl.ref(l_ref);

    gl.in_doc3(ref_   => l_ref,
               tt_    => p_docrec.tt,
               vob_   => p_docrec.vob,
               nd_    => substr(to_char(l_ref), 1, 10),
               pdat_  => sysdate,
               vdat_  => p_docrec.vdat,
               dk_    => p_docrec.dk,
               kv_    => p_docrec.kv,
               s_     => p_docrec.s,
               kv2_   => p_docrec.kv2,
               s2_    => p_docrec.s2,
               sk_    => null,
               data_  => p_docrec.vdat,
               datp_  => p_docrec.vdat,
               nam_a_ => p_docrec.nam_a,
               nlsa_  => p_docrec.nlsa,
               mfoa_  => p_docrec.mfoa,
               nam_b_ => p_docrec.nam_b,
               nlsb_  => p_docrec.nlsb,
               mfob_  => p_docrec.mfob,
               nazn_  => p_docrec.nazn,
               d_rec_ => null,
               id_a_  => p_docrec.id_a,
               id_b_  => p_docrec.id_b,
               id_o_  => null,
               sign_  => null,
               sos_   => 0,
               prty_  => null,
               uid_   => p_docrec.userid);

    paytt(null,
          l_ref,
          p_docrec.vdat,
          p_docrec.tt,
          p_docrec.dk,
          p_docrec.kv,
          p_docrec.nlsa,
          p_docrec.s,
          p_docrec.kv2,
          p_docrec.nlsb,
          p_docrec.s2);

    bars_audit.trace('%s make_doc: ref = %s', title, to_char(l_ref));
    bars_audit.info(title || ' make_doc: ref = ' || to_char(l_ref));
    -- bars_audit.financial(title||' '||bars_msg.get_msg(modcode, 'INTDOC_CREATED', to_char(l_ref)));

    return l_ref;
  end make_doc;

  --
  -- ������������ ��������� �������.��������
  --
  procedure fill_log(p_intrec in t_intrec,
                     p_runid  in dpt_jobs_log.run_id%type,
                     p_ref    in dpt_jobs_log.ref%type,
                     p_amount in dpt_jobs_log.int_sum%type,
                     p_errmsg in dpt_jobs_log.errmsg%type) is
    l_dptid dpt_jobs_log.dpt_id%type;
    l_socid dpt_jobs_log.contract_id%type;
  begin
    bars_audit.trace('%s fill_log: ������, %s, deal = %s, run = %s, ref = %s, sum = %s, %s',
                     title,
                     p_intrec.mod_code,
                     to_char(p_intrec.deal_id),
                     to_char(p_runid),
                     to_char(p_ref),
                     to_char(p_amount),
                     p_errmsg);

    bars_audit.info(title || ' fill_log: ������, ' || p_intrec.mod_code ||
                    ', deal = ' || to_char(p_intrec.deal_id) || ', run = ' ||
                    to_char(p_runid) || ', ref = ' || to_char(p_ref) ||
                    ', sum = ' || to_char(p_amount) || ', ' ||
                    to_char(p_amount));

    if (p_intrec.mod_code = 'DPT' or p_intrec.mod_code = 'DPU') then
      l_dptid := p_intrec.deal_id;
    end if;

    if p_intrec.mod_code = 'SOC' then
      l_socid := p_intrec.deal_id;
    end if;

    dpt_jobs_audit.p_save2log(p_intrec.mod_code,
                              p_runid,
                              l_dptid,
                              p_intrec.deal_num,
                              p_intrec.branch,
                              p_ref,
                              p_intrec.cust_id,
                              p_intrec.acc_num,
                              p_intrec.acc_cur,
                              null,
                              p_amount,
                              (case when p_errmsg is null then 1 else - 1 end),
                              p_errmsg,
                              l_socid);

    bars_audit.trace('%s fill_log: ���������', title);
    bars_audit.info(title || ' fill_log: ���������');
  end fill_log;

  --
  -- ����� ������� ��� ������ �������
  --
  procedure INIT_TAXNLS_LIST
  ( p_kf in accounts.kf%type
  ) is
  begin
    bars_audit.info(title || 'INIT_TAXNLS_LIST: Entry.');

    for k in ( with tab as ( select nls, branch
                               from ACCOUNTS
                              where KF   = p_kf
                                and NBS  = '3622'
                                and KV   = 980
                                and OB22 = '37'
                                and DAZS is null )
                select BRANCH, NLS
                  from tab
                 union
                select SubStr(BRANCH,1,15), NLS
                  from tab
                 where branch like '/______/______/06____/' )
    loop
      g_taxnls_list(k.branch) := k.nls;
      -- bars_audit.trace( '%s INIT_TAXNLS_LIST (branch = %s, nls = %s).', title, k.branch, k.nls );
    end loop;

    bars_audit.trace( '%s INIT_TAXNLS_LIST: exit with %s accounts.',
                     title,
                     to_char(g_taxnls_list.count));

    bars_audit.info( title || ' INIT_TAXNLS_LIST: exit with ' || to_char(g_taxnls_list.count) || ' accounts.');

    for n in ( with tab as ( select NLS, BRANCH
                               from ACCOUNTS
                              where KF   = p_kf
                                and NBS  = '3622'
                                and KV   = 980
                                and OB22 = '36'
                                and DAZS is null )
                       select BRANCH, NLS
                         from tab
                        union
                       select SubStr(BRANCH,1,15), NLS
                         from tab
                        where branch like '/______/______/06____/' )
    loop
      g_taxnls_list_military(n.branch) := n.nls;
    end loop;

    bars_audit.trace( '%s INIT_TAXNLS_LIST(MILITARY): exit with %s accounts.',
                      title, to_char(g_taxnls_list_military.count));

--  bars_audit.info( title || ' INIT_TAXNLS_LIST(MILITARY): exit with ' ||
--                   to_char(g_taxnls_list_military.count) || ' accounts.');
  end INIT_TAXNLS_LIST;

  --
  --
  --
  function GET_TAXNLS
  ( p_branch   accounts.branch%type
  ) return accounts.nls%type
  is
  begin

    if ( g_taxnls_list.exists( p_branch ) )
    then
      return g_taxnls_list( p_branch );
    else
      if ( length( p_branch ) > 15 and g_taxnls_list.exists( Substr(p_branch,1,15) ) )
      then
        return g_taxnls_list( SubStr(p_branch,1,15) );
      else
        raise_application_error( -20666, '�� ������� ������� ��������� ������������ ������� ��� �������� '||p_branch, true );
      end if;
    end if;

  end GET_TAXNLS;

  --
  --
  --
  function GET_MILNLS
  ( p_branch   accounts.branch%type
  ) return accounts.nls%type
  is
  begin

    if ( g_taxnls_list_military.exists( p_branch ) )
    then
      return g_taxnls_list_military( p_branch );
    else
      if ( length( p_branch ) > 15 and g_taxnls_list_military.exists( Substr(p_branch,1,15) ) )
      then
        return g_taxnls_list_military( SubStr(p_branch,1,15) );
      else
        raise_application_error( -20666, '�� ������� ������� ��������� ������������ ������� ��� �������� '||p_branch, true );
      end if;
    end if;

  end GET_MILNLS;

  function get_content_of_tax_accounts
  return clob
  is
      l_clob clob;
      l accounts.branch%type;
  begin
      dbms_lob.createtemporary(l_clob, false);
      dbms_lob.append(l_clob, 'Content of tax account collection' || chr(13) || chr(10));

      l := g_taxnls_list.first;
      while (l is not null) loop
          dbms_lob.append(l_clob, rpad(l, 30) || ' ' || g_taxnls_list(l) || chr(13) || chr(10));
          l := g_taxnls_list.next(l);
      end loop;

      dbms_lob.append(l_clob, 'Content of military tax account collection' || chr(13) || chr(10));

      l := g_taxnls_list_military.first;
      while (l is not null) loop
          dbms_lob.append(l_clob, rpad(l, 30) || ' ' || g_taxnls_list_military(l) || chr(13) || chr(10));
          l := g_taxnls_list_military.next(l);
      end loop;

      return l_clob;
  end;


  --
  --
  -- ====================================================================================
begin
  bars_audit.trace('%s �����, ���������� �� %s, ����� %s, ������ � %s',
                   title,
                   to_char(p_dat2, 'dd.mm.yy'),
                   to_char(p_runmode),
                   to_char(p_runid));

  bars_audit.info(title || ' �����, ���������� �� ' ||
                  to_char(p_dat2, 'dd.mm.yy') || ', ����� ' ||
                  to_char(p_runmode) || ', ������ � ' || to_char(p_runid));

  if ((p_runmode = 1) and (l_tax_method = 2 or l_tax_method = 3))
  then -- ����������� ������ ������� ��� ������ �������
    INIT_TAXNLS_LIST( sys_context('bars_context','user_mfo') );
  end if;

  loop
    select kf,
           branch,
           deal_id,
           deal_num,
           deal_dat,
           cust_id,
           int_id,
           acc_id,
           acc_num,
           acc_cur,
           acc_nbs,
           acc_name,
           acc_iso,
           acc_open,
           acc_amount,
           int_details,
           int_tt,
           mod_code,
           rowid rw
      bulk collect
      into l_intlist
      from int_queue
     where rownum <= rowslimit
     order by branch;

    exit when l_intlist.count = 0;

    l_rwlist.extend(l_intlist.count);

    for i in 1 .. l_intlist.count loop
      begin
        l_taxrow.tax_s      := 0;
        l_taxrow.tax_sq     := 0;
        l_tax_s             := 0;
        l_tax_sq            := 0;
        l_taxrow_mil.tax_s  := 0;
        l_taxrow_mil.tax_sq := 0;
        l_tax_mil_s         := 0;
        l_tax_mil_sq        := 0;
        savepoint sp_beforeintdoc;

        -- ���������� ���������
        l_rwlist(i) := l_intlist(i).rw;

        p_intamount := null;
        p_errflg    := false;
        l_cleared   := false; -- ���� ������� ��������� ����������� ���������
        l_errmsg    := null; -- ��������� �� ������

        bars_audit.trace('%s ���� %s/%s',
                         title,
                         l_intlist         (i).acc_num,
                         l_intlist         (i).acc_iso);
        bars_audit.info(title || ' ���� ' || l_intlist(i).acc_num || '/' || l_intlist(i)
                        .acc_iso);
        -- ������ � ���������� ���������� ��������
        begin
          select *
            into l_cardrow
            from int_accn
           where acc = l_intlist(i).acc_id
             and id = l_intlist(i).int_id
             for update nowait;
        exception
          when no_data_found then
            -- �� ������� ����.�������� � %s �� ����� %s/%s
            l_errmsg := substr(bars_msg.get_msg(modcode,
                                                'INTCARD_NOT_FOUND',
                                                to_char(l_intlist(i).int_id),
                                                l_intlist(i).acc_num,
                                                l_intlist(i).acc_iso),
                               1,
                               errmsgdim);
            raise expt_int;
          when others then
            -- ������ ������ � ���������� ����.�������� � %s �� ����� %s/%s : %s
            l_errmsg := substr(bars_msg.get_msg(modcode,
                                                'INTCARD_READ_FAILED',
                                                to_char(l_intlist(i).int_id),
                                                l_intlist(i).acc_num,
                                                l_intlist(i).acc_iso,
                                                sqlerrm || chr(10) || dbms_utility.format_error_backtrace()),
                               1,
                               errmsgdim);
            raise expt_int;
        end;

        bars_audit.trace('%s (acra, acrb, acrdat, stpdat) = (%s, %s, %s, %s)',
                         title,
                         to_char(l_cardrow.acra),
                         to_char(l_cardrow.acrb),
                         to_char(l_cardrow.acr_dat, 'dd.mm.yy'),
                         to_char(l_cardrow.stp_dat, 'dd.mm.yy'));

        bars_audit.info(title || '������ � ���������� ���������� ��������');

        -- �������� ������ ����������
        if l_cardrow.metr not in (0, 1, 2, 4, 5) then
          -- ����� ���������� � %s �� ����� %s/%s �� �������������� ����������
          l_errmsg := substr(bars_msg.get_msg(modcode,
                                              'INTMETHOD_INVALID',
                                              to_char(l_cardrow.metr),
                                              l_intlist(i).acc_num,
                                              l_intlist(i).acc_iso),
                             1,
                             errmsgdim);
          raise expt_int;
        end if;

        -- ������ ������� ����������
        l_acrdat := l_cardrow.acr_dat;
        l_stpdat := l_cardrow.stp_dat;

        get_dates(p_acrdat  => l_acrdat,
                  p_stpdat  => l_stpdat,
                  p_dat2    => p_dat2,
                  p_opendat => l_intlist(i).acc_open,
                  p_intid   => l_intlist(i).int_id,
                  p_amount  => l_intlist(i).acc_amount);

        if (l_acrdat is null or l_stpdat is null)
        then
          -- ������ %s - %s ������ ��� ����� %s/%s
          bars_audit.trace( '%s ��������� ������ ������ ��� ���������� ��� %s/%s'
                          , title, l_intlist(i).acc_num, l_intlist(i).acc_iso );
          l_errmsg := null;
          raise expt_int;
        end if;

        -- ������ ����� ����������� ���������

        --delete from tmp_intn;
        --delete from tmp_intcn;

        delete from acr_intn;

        if (l_intlist(i).mod_code = 'DPT' and l_intlist(i).int_id = 3 and
            l_cardrow.stp_dat <= l_stpdat) then
          -- ������������� ����������� ��������� �� ���������� ������
          bars_audit.trace( '%s �������.����������� �� �����.������...', title );

          begin
            select ostb
              into p_intamount
              from accounts
             where pap = 1
               and acc = l_cardrow.acra;

            bars_audit.trace( '%s ������� �� ����� ����������� - %s', title, to_char(p_intamount) );

            if (p_intamount != 0) then
              insert into acr_intn
                (acc, id, fdat, tdat, ir, br, osts, acrd, remi)
              values
                (l_intlist(i).acc_id,
                 l_intlist(i).int_id,
                 l_acrdat,
                 l_stpdat,
                 acrn.fproc(l_intlist(i).acc_id, l_stpdat),
                 0,
                 fost(l_intlist(i).acc_id, l_stpdat),
                 abs(p_intamount),
                 0);
            end if;
          exception
            when no_data_found then
              -- ������ ������������ ��������� ����������� ��������� �� ����� %s/%s: %s
              l_errmsg := substr(bars_msg.get_msg(modcode,
                                                  'INTCALC_FAILED',
                                                  l_intlist                              (i)
                                                  .acc_num,
                                                  l_intlist                              (i)
                                                  .acc_iso,
                                                  'no active saldo for amortization found'),
                                 1,
                                 errmsgdim);
              raise expt_int;
          end;
        else
          -- ������������ ������ ����� ����������� ���������
          begin
            acrn.p_int(l_intlist  (i).acc_id, -- �����.����� ��������� �����
                       l_intlist  (i).int_id, -- ��� ���������� ��������
                       l_acrdat, -- ��������� ���� ����������
                       l_stpdat, -- �������� ���� ����������
                       p_intamount, -- ����� ����������� ��������� out
                       l_intlist  (i).acc_amount, -- ����� ����������
                       1); -- ����� ����������
          exception
            when others then
              -- ������ ������������ ��������� ����������� ��������� �� ����� %s/%s: %s
              l_errmsg := substr(bars_msg.get_msg(modcode,
                                                  'INTCALC_FAILED',
                                                  l_intlist      (i).acc_num,
                                                  l_intlist      (i).acc_iso,
                                                  sqlerrm || chr(10) || dbms_utility.format_error_backtrace()),
                                 1,
                                 errmsgdim);
              raise expt_int;
          end;

          bars_audit.trace( '%s ����� ����������� ��������� - %s', title, to_char(p_intamount) );

          -- ������ ��������� ����������� ���������
          begin
            acrn.p_cnds;
          exception
            when others then
              -- ������ ������ ��������� ����������� ��������� �� ����� %s/%s: %s
              l_errmsg := substr(bars_msg.get_msg(modcode,
                                                  'INTCNDSC_FAILED',
                                                  l_intlist       (i).acc_num,
                                                  l_intlist       (i).acc_iso,
                                                  sqlerrm || chr(10) || dbms_utility.format_error_backtrace()),
                                 1,
                                 errmsgdim);
              raise expt_int;
          end;
        end if;

        p_intamount := round(p_intamount);

        -- ���������� ������ ����� ����������� ��������� ��������.
        -- ���������� ������������ ���������� �� ���������� ���������
        if (p_runmode = 1)
        then -- ������ ��������� ����������� ��������� �� �����
          for acr_list in (select acc,
                                  id,
                                  fdat,
                                  tdat,
                                  ir,
                                  br,
                                  acrd,
                                  remi,
                                  osts
                             from acr_intn
                            where acc = l_intlist(i).acc_id
                              and id = l_intlist(i).int_id
                            order by fdat) loop
            bars_audit.trace('%s ������ %s-%s �� ������ %s/%s => %s',
                             title,
                             to_char(acr_list.fdat, 'dd.mm.yy'),
                             to_char(acr_list.tdat, 'dd.mm.yy'),
                             to_char(acr_list.ir),
                             to_char(acr_list.br),
                             to_char(acr_list.acrd));

            -- �������� ���� ���������� ����������
            begin
              update int_accn
                 set acr_dat = acr_list.tdat, s = acr_list.remi
               where acc = acr_list.acc
                 and id = acr_list.id;
            exception
              when others then
                -- ������ ������ ���� ���������� ���������� �� ����� %s/%s: %s
                l_errmsg := substr(bars_msg.get_msg(modcode,
                                                    'INTDAT_FIX_FAILED',
                                                    l_intlist         (i)
                                                    .acc_num,
                                                    l_intlist         (i)
                                                    .acc_iso,
                                                    sqlerrm || chr(10) || dbms_utility.format_error_backtrace()),
                                   1,
                                   errmsgdim);
                raise expt_int;
            end;

            -- ������� ��������� ����������� ��������� �� ���������� �������
            if (not l_cleared) then
              delete from tmp_intarc
               where acc = acr_list.acc
                 and id = acr_list.id
                 and fdat >= acr_list.fdat;

              l_cleared := true;
            end if;

            -- ���������� ��������� ����������� ���������
            begin
              insert into tmp_intarc
                (id,
                 acc,
                 fdat,
                 tdat,
                 ir,
                 br,
                 osts,
                 acrd,
                 nls,
                 nbs,
                 kv,
                 lcv,
                 nms,
                 userid,
                 bdat)
              values
                (acr_list.id,
                 acr_list.acc,
                 acr_list.fdat,
                 acr_list.tdat,
                 acr_list.ir,
                 acr_list.br,
                 acr_list.osts,
                 acr_list.acrd,
                 l_intlist    (i).acc_num,
                 l_intlist    (i).acc_nbs,
                 l_intlist    (i).acc_cur,
                 l_intlist    (i).acc_iso,
                 l_intlist    (i).acc_name,
                 l_userid,
                 l_bdate);
            exception
              when others then
                -- ������ ���������� ��������� ����������� ��������� �� ����� %s/%s: %s
                l_errmsg := substr(bars_msg.get_msg(modcode,
                                                    'INTLIST_FIX_FAILED',
                                                    l_intlist          (i)
                                                    .acc_num,
                                                    l_intlist          (i)
                                                    .acc_iso,
                                                    sqlerrm || chr(10) || dbms_utility.format_error_backtrace()),
                                   1,
                                   errmsgdim);
                raise expt_int;
            end;

            -- ������
            if (acr_list.acrd != 0) then
              bars_audit.trace('%s ���� ������� = %s',
                               title,
                               to_char(acr_list.acrd));

              -- ������������� ����������
              init_docrec(l_docrec);

              -- ����������� ���������� ���������
              l_docrec.s      := acr_list.acrd;
              l_docrec.vdat   := l_bdate;
              l_docrec.mfoa   := l_intlist(i).kf;
              l_docrec.mfob   := l_intlist(i).kf;
              l_docrec.tobo   := l_intlist(i).branch;
              l_docrec.branch := l_intlist(i).branch;

              -- ����� ������� (� = ���. �������, � = ���. �������)
              get_docaccs(l_cardrow.acra, l_cardrow.acrb, l_docrec);

              if (l_docrec.nlsa is null) then
                -- �� ������ ���������� � (���) �����.���� �� ����� %s/%s
                l_errmsg := substr(bars_msg.get_msg(modcode,
                                                    'INTPAYACC_NOT_FOUND',
                                                    l_intlist           (i)
                                                    .acc_num,
                                                    l_intlist           (i)
                                                    .acc_iso),
                                   1,
                                   errmsgdim);
                raise expt_int;
              end if;

              -- ���������� �� ��������� ������� � ����������� �������
              if (l_tax_method = 2 or l_tax_method = 3) then
                begin
                  select 1,
                         case
                           when a.nbs = '2620' and a.ob22 in ('20', '21') then
                            1
                           else
                            0
                         end
                    into l_tax_required, l_tax_socfactor
                    from bars.accounts a
                    join bars.customer c
                      on (c.rnk = a.rnk)
                   where a.acc = l_intlist(i).acc_id
                     and ( (a.nbs = '2630') or
                           (a.nbs = '2620' and a.ob22 not in ('14', '17', '20', '21')) or -- �� (��������)
                           (a.nbs in ('2600','2610','8610') and c.sed = '91' and c.ise in ('14200','14201','14100', '14101')) -- ���
                         );
                exception
                  when no_data_found then
                    l_tax_required  := 0;
                    l_tax_socfactor := 0;
                end;

                bars_audit.trace( '%s l_tax_required='     ||to_char(l_tax_required)         ||
                                  ', l_intlist(i).acc_id=' ||to_char(l_intlist(i).acc_id)    ||
                                  ', l_tax_socfactor='     ||to_char(l_tax_socfactor), title );

                if (l_tax_required = 1)
                then -- ������ ����� ��� ��������������� �� ��� (������� ���������� ����������� �������� ������� 01/08/2014)
                  l_taxrow.tax_s      := 0;
                  l_taxrow.tax_sq     := 0;
                  l_tax_s             := 0;
                  l_tax_sq            := 0;
                  l_taxrow_mil.tax_s  := 0;
                  l_taxrow_mil.tax_sq := 0;
                  l_tax_mil_s         := 0;
                  l_tax_mil_sq        := 0;
                  l_taxrow.tax_type   := 1;

                  l_taxrow.dpt_id         := nvl(l_intlist(i).deal_id, 0);
                  l_taxrow.acra           := l_cardrow.acra;
                  l_taxrow.kv             := l_intlist(i).acc_cur;
                  l_taxrow.int_date_begin := acr_list.fdat;
                  l_taxrow.int_date_end   := acr_list.tdat;
                  l_taxrow.int_s          := acr_list.acrd;
                  l_taxrow.int_sq         := GL.p_icurval( l_taxrow.kv, acr_list.acrd, l_bdate );
                  l_taxrow.tax_nls        := GET_TAXNLS( l_intlist(i).branch );
                  l_taxrow.tax_date_begin := acr_list.fdat;
                  l_taxrow.tax_date_end   := acr_list.tdat;
                  l_taxrow.userid         := user_id;
                  l_taxrow.dwhen          := systimestamp;
                  l_taxrow.bdate          := l_bdate;

                  l_taxrow_mil.dpt_id         := nvl(l_intlist(i).deal_id,
                                                     0);
                  l_taxrow_mil.acra           := l_cardrow.acra;
                  l_taxrow_mil.kv             := l_intlist(i).acc_cur;
                  l_taxrow_mil.int_date_begin := acr_list.fdat;
                  l_taxrow_mil.int_date_end   := acr_list.tdat;
                  l_taxrow_mil.int_s          := acr_list.acrd;
                  l_taxrow_mil.int_sq         := gl.p_icurval( l_taxrow_mil.kv, acr_list.acrd, l_bdate );
                  l_taxrow_mil.tax_nls        := GET_MILNLS( l_intlist(i).branch );

                  l_taxrow_mil.tax_date_begin := acr_list.fdat;
                  l_taxrow_mil.tax_date_end   := acr_list.tdat;
                  l_taxrow_mil.userid         := user_id;
                  l_taxrow_mil.dwhen          := systimestamp;
                  l_taxrow_mil.bdate          := l_bdate;
                  l_taxrow_mil.tax_type       := 2;

                  select tax_type, tax_int, dat_begin, dat_end
                    bulk collect
                    into l_taxlist
                    from tax_settings
                   where tax_type = l_taxrow.tax_type -- 1 ����� �� ��������� ������ ��
                     and (dat_end >= l_acrdat or dat_end is null);

                  select tax_type, tax_int, dat_begin, dat_end
                    bulk collect
                    into l_taxlist_mil
                    from tax_settings
                   where tax_type = l_taxrow_mil.tax_type -- 2 ��������� ���
                     and (dat_end >= l_acrdat or dat_end is null);

                  bars_audit.trace( '%s ���������� �������� ��������������� = %s.', title, to_char(l_taxlist.count) );

                  for j in 1 .. l_taxlist.count loop
                    bars_audit.trace( '%s ������� ����� �� ������ � ' ||to_char(greatest(l_acrdat,l_taxlist(j).tax_date_begin),'dd/mm/yyyy')
                                                            || ' �� ' ||to_char(nvl(l_taxlist(j).tax_date_end,l_stpdat),'dd/mm/yyyy'), title );

                    begin
                      acrn.p_int(l_intlist(i).acc_id, -- �����.����� ��������� �����
                                 l_intlist(i).int_id, -- ��� ���������� ��������
                                 greatest(acr_list.fdat,
                                          l_taxlist(j).tax_date_begin), -- ��������� ���� ����������, ��� ������� ��������������� �� l_taxlist (tax_settings)
                                 nvl(l_taxlist(j).tax_date_end,
                                     acr_list.tdat), -- �������� ���� ����������, ��� ������� ��������������� �� l_taxlist (tax_settings)
                                 l_taxrow.tax_base_s, -- ����� ����������� ��������� out ��� ������� ��������������� �� l_taxlist (tax_settings)
                                 l_intlist(i).acc_amount, -- ����� ����������
                                 0); -- ����� ���������� - ������ ������ ����� ���������, ��� ������� ��������������� �� l_taxlist (tax_settings)
                    exception
                      when others then
                        -- ������ ������������ ��������� ����������� ��������� �� ����� %s/%s: %s
                        l_errmsg := substr(bars_msg.get_msg(modcode,
                                                            'INTCALC_TAX_FAILED',
                                                            l_intlist(i).acc_num || ' - ' || l_taxrow.tax_nls,
                                                            l_intlist(i).acc_iso,
                                                            sqlerrm || chr(10) || dbms_utility.format_error_backtrace()),
                                           1,
                                           errmsgdim);
                        raise expt_int;
                    end;

                    l_taxrow.tax_base_s  := round(l_taxrow.tax_base_s, 0); -- ��� ��� � �������� ������� ����������� �����������, ������� ->> acr_docs.int_rest
                    l_taxrow.tax_base_sq := GL.p_icurval( l_taxrow.kv, l_taxrow.tax_base_s, l_taxrow.bdate );
                    l_taxrow.tax_s       := round( l_taxrow.tax_base_s * l_taxlist(j).tax_int, 0 );
                    l_taxrow.tax_sq      := GL.p_icurval( l_taxrow.kv, l_taxrow.tax_s, l_taxrow.bdate );
                    l_taxrow.round_err   := l_taxrow.tax_base_s * l_taxlist(j).tax_int - l_taxrow.tax_s;

                    bars_audit.trace('%s ����� ����������� c ' ||
                                     to_char(greatest(acr_list.fdat,
                                                      l_taxlist(j)
                                                      .tax_date_begin),
                                             'dd/mm/yyyy') || ' �� ' ||
                                     to_char(nvl(l_taxlist(j).tax_date_end,
                                                 acr_list.tdat),
                                             'dd/mm/yyyy') ||
                                     ' (���� ��� ��������������� = ' ||
                                     to_char(l_taxrow.tax_base_s) || ') (' ||
                                     to_char(l_taxlist(j).tax_int * 100) ||
                                     '%) ��������� = %s',
                                     title,
                                     '>>' || to_char(l_taxrow.tax_s));

                    l_tax_s             := nvl(l_tax_s, 0)             + nvl(l_taxrow.tax_s, 0);
                    l_tax_sq            := nvl(l_tax_sq, 0)            + nvl(l_taxrow.tax_sq, 0);
                    l_taxrow_tax_base_s := nvl(l_taxrow_tax_base_s, 0) + nvl(l_taxrow.tax_base_s, 0);

                    if l_tax_socfactor = 1 then
                      begin
                        select acc,
                               case
                                 when (nvl(ost_real, 0) + nvl(kos_real, 0) - nvl(dos_real, 0)) = 0 then
                                  0
                                 else
                                  nvl(ost_for_tax, 0) /
                                  (nvl(ost_real, 0) + nvl(kos_real, 0) - nvl(dos_real, 0))
                               end,
                               greatest(date1, l_acrdat),
                               nvl(date2 - 1,
                                   nvl(l_taxlist(j).tax_date_end, l_stpdat))
                          bulk collect
                          into l_soc_turns_data
                          from dpt_soc_turns
                         where acc = l_intlist(i).acc_id
                           and (date1 between l_acrdat and acr_list.tdat or
                               (nvl(date2 - 1,
                                     nvl(l_taxlist(j).tax_date_end, l_stpdat)) between
                               l_acrdat and acr_list.tdat));
                      exception
                        when others then
                          bars_audit.trace('%s_SOC' || sqlcode ||
                                           ' +�� ��������� ������ ��� ������ �� �������� � dpt_soc_turns �� ����� ��� = ' ||
                                           to_char(l_intlist(i).acc_id),
                                           title);
                      end;

                      bars_audit.trace('%s_SOC ���������� �������� �������� (��� ������� ����������� �������)= ' ||
                                       to_char(l_soc_turns_data.count),
                                       title);

                      l_tax_s_soc       := 0;
                      l_tax_sq_soc      := 0;
                      l_tax_base_soc    := 0;
                      l_tax_base_soc_sq := 0;
                      l_tmp_s_soc       := 0;
                      l_tmp_sq_soc      := 0;

                      for si in 1 .. l_soc_turns_data.count loop

                        bars_audit.trace('INT:_SOC' ||
                                         ' soc_date_begin = ' ||
                                         to_char(l_soc_turns_data(si)
                                                 .date_begin,
                                                 'dd/mm/yyyy') ||
                                         ' , soc_date_end = ' ||
                                         to_char(l_soc_turns_data(si)
                                                 .date_end,
                                                 'dd/mm/yyyy') ||
                                         ' , soc_factor = ' ||
                                         to_char(l_soc_turns_data(si)
                                                 .soc_factor));

                        begin
                          acrn.p_int(l_intlist(i).acc_id, -- �����.����� ��������� �����
                                     l_intlist(i).int_id, -- ��� ���������� ��������
                                     greatest(l_soc_turns_data(si)
                                              .date_begin,
                                              l_taxlist       (j)
                                              .tax_date_begin), -- ��������� ���� ����������, ��� ������� ��������������� �� l_taxlist (tax_settings)
                                     nvl(l_taxlist       (j).tax_date_end,
                                         l_soc_turns_data(si).date_end), -- �������� ���� ����������, ��� ������� ��������������� �� l_taxlist (tax_settings)
                                     l_tax_base_soc, -- ����� ����������� ��������� out ��� ������� ��������������� �� l_taxlist (tax_settings)
                                     l_intlist(i).acc_amount, -- ����� ����������
                                     0); -- ����� ���������� - ������ ������ ����� ���������, ��� ������� ��������������� �� l_taxlist (tax_settings)
                        exception
                          when others then
                            -- ������ ������������ ��������� ����������� ��������� �� ����� %s/%s: %s
                            l_errmsg := substr(bars_msg.get_msg(modcode,
                                                                'INTCALC_TAX_FAILED',
                                                                l_intlist          (i)
                                                                .acc_num,
                                                                l_intlist          (i)
                                                                .acc_iso,
                                                                sqlerrm || chr(10) || dbms_utility.format_error_backtrace()),
                                               1,
                                               errmsgdim);
                            raise expt_int;
                        end;

                        l_tax_base_soc    := round(l_tax_base_soc, 0); -- ��� ��� � �������� ������� ����������� �����������, ������� ->> acr_docs.int_rest
                        l_tax_base_soc_sq := gl.p_icurval(l_taxrow.kv,
                                                          l_tax_base_soc,
                                                          l_taxrow.bdate);

                        --������ ������� (����� � �����������)- (����� ��� ����������) ����� ����� ��������� � ����� ������ �� ���� ������
                        if l_soc_turns_data(si).soc_factor < 1 then
                          l_tmp_s_soc := round((l_tax_base_soc * l_taxlist(j)
                                               .tax_int * l_soc_turns_data(si)
                                               .soc_factor) - (l_tax_base_soc * l_taxlist(j)
                                               .tax_int),
                                               0);
                        else
                          l_tmp_s_soc := 0;
                        end if;

                        l_tax_s_soc  := nvl(l_tax_s_soc, 0) +
                                        nvl(l_tmp_s_soc, 0);
                        l_tax_sq_soc := nvl(l_tax_sq_soc, 0) +
                                        gl.p_icurval(l_taxrow.kv,
                                                     l_tmp_s_soc,
                                                     l_taxrow.bdate);

                        bars_audit.trace('l_tax_base_soc = ' ||
                                         to_char(l_tax_base_soc) ||
                                         ' for --->' ||
                                         to_char(greatest(l_soc_turns_data(si)
                                                          .date_begin,
                                                          l_taxlist       (j)
                                                          .tax_date_begin),
                                                 'dd/mm/yyyy') || ' - ' ||
                                         to_char(nvl(l_taxlist       (j)
                                                     .tax_date_end,
                                                     l_soc_turns_data(si)
                                                     .date_end),
                                                 'dd/mm/yyyy'));
                        bars_audit.trace('l_tmp_s_soc = ' ||
                                         to_char(l_tmp_s_soc) ||
                                         'l_tax_s_soc = ' ||
                                         to_char(l_tax_s_soc) ||
                                         ', l_tax_sq_soc = ' ||
                                         to_char(l_tax_sq_soc));

                        l_taxrow.tax_socinfo := substr(nvl(l_taxrow.tax_socinfo,
                                                           '') ||
                                                       to_char(l_soc_turns_data(si)
                                                               .soc_factor) || ' (' ||
                                                       to_char(l_soc_turns_data(si)
                                                               .date_begin,
                                                               'dd/mm/yyyy') || '-' ||
                                                       to_char(l_soc_turns_data(si)
                                                               .date_end,
                                                               'dd/mm/yyyy') ||
                                                       ') base =' ||
                                                       to_char(l_tax_base_soc) ||
                                                       ', l_tmp_s_soc=' ||
                                                       to_char(l_tmp_s_soc) || ';',
                                                       2000);
                      end loop;
                    end if;
                  end loop;
                  for z in 1 .. l_taxlist_mil.count loop
                    bars_audit.trace('%s ������� ������� ���� �� ������ � ' ||
                                     to_char(greatest(l_acrdat,
                                                      l_taxlist_mil(z)
                                                      .tax_date_begin),
                                             'dd/mm/yyyy') || ' �� ' ||
                                     to_char(nvl(l_taxlist_mil(z)
                                                 .tax_date_end,
                                                 l_stpdat),
                                             'dd/mm/yyyy'),
                                     title);

                    begin
                      acrn.p_int(l_intlist(i).acc_id, -- �����.����� ��������� �����
                                 l_intlist(i).int_id, -- ��� ���������� ��������
                                 greatest(acr_list.fdat,
                                          l_taxlist_mil(z).tax_date_begin), -- ��������� ���� ����������, ��� ������� ��������������� �� l_taxlist (tax_settings)
                                 nvl(l_taxlist_mil(z).tax_date_end,
                                     acr_list.tdat), -- �������� ���� ����������, ��� ������� ��������������� �� l_taxlist (tax_settings)
                                 l_taxrow_mil.tax_base_s, -- ����� ����������� ��������� out ��� ������� ��������������� �� l_taxlist (tax_settings)
                                 l_intlist(i).acc_amount, -- ����� ����������
                                 0); -- ����� ���������� - ������ ������ ����� ���������, ��� ������� ��������������� �� l_taxlist (tax_settings)
                    exception
                      when others then
                        -- ������ ������������ ��������� ����������� ��������� �� ����� %s/%s: %s
                        l_errmsg := substr(bars_msg.get_msg(modcode,
                                                            'INTCALC_TAX_FAILED',
                                                            l_intlist          (i)
                                                            .acc_num,
                                                            l_intlist          (i)
                                                            .acc_iso,
                                                            sqlerrm || chr(10) || dbms_utility.format_error_backtrace()),
                                           1,
                                           errmsgdim);
                        raise expt_int;
                    end;

                    l_taxrow_mil.tax_base_s  := round(l_taxrow_mil.tax_base_s,0); -- ��� ��� � �������� ������� ����������� �����������, ������� ->> acr_docs.int_rest
                    l_taxrow_mil.tax_base_sq := gl.p_icurval(l_taxrow_mil.kv,
                                                             l_taxrow_mil.tax_base_s,
                                                             l_taxrow_mil.bdate);
                    l_taxrow_mil.tax_s       := round(l_taxrow_mil.tax_base_s * l_taxlist_mil(z).tax_int,0);
                    l_taxrow_mil.tax_sq      := gl.p_icurval(l_taxrow_mil.kv,
                                                             l_taxrow_mil.tax_s,
                                                             l_taxrow_mil.bdate);
                    l_taxrow_mil.round_err   := l_taxrow_mil.tax_base_s * l_taxlist_mil(z).tax_int -l_taxrow_mil.tax_s;

                    bars_audit.trace('%s ����� ����������� c ' ||
                                     to_char(greatest(acr_list.fdat,
                                                      l_taxlist_mil(z)
                                                      .tax_date_begin),
                                             'dd/mm/yyyy') || ' �� ' ||
                                     to_char(nvl(l_taxlist_mil(z)
                                                 .tax_date_end,
                                                 acr_list.tdat),
                                             'dd/mm/yyyy') ||
                                     ' (���� ��� ��������������� = ' ||
                                     to_char(l_taxrow_mil.tax_base_s) ||
                                     ') (' ||
                                     to_char(l_taxlist_mil(z).tax_int * 100) ||
                                     '%) ��������� = %s',
                                     title,
                                     '>>' || to_char(l_taxrow_mil.tax_s));

                    l_tax_mil_s             := nvl(l_tax_mil_s, 0)            + nvl(l_taxrow_mil.tax_s, 0);
                    l_tax_mil_sq            := nvl(l_tax_mil_sq, 0)           + nvl(l_taxrow_mil.tax_sq, 0);
                    l_taxrow_mil_tax_base_s := nvl(l_taxrow_mil_tax_base_s,0) + nvl(l_taxrow_mil.tax_base_s,0);

                    if l_tax_socfactor = 1 then
                      begin
                        select acc,
                               case
                                 when (nvl(ost_real, 0) + nvl(kos_real, 0) - nvl(dos_real, 0)) = 0 then
                                  0
                                 else
                                  nvl(ost_for_tax, 0) /
                                  (nvl(ost_real, 0) + nvl(kos_real, 0) - nvl(dos_real, 0))
                               end,
                               greatest(date1, l_acrdat),
                               nvl(date2 - 1,
                                   nvl(l_taxlist_mil(z).tax_date_end,
                                       l_stpdat))
                          bulk collect
                          into l_soc_turns_data
                          from dpt_soc_turns
                         where acc = l_intlist(i).acc_id
                           and (date1 between l_acrdat and acr_list.tdat or
                               (nvl(date2 - 1,
                                     nvl(l_taxlist_mil(z).tax_date_end,
                                         l_stpdat)) between l_acrdat and
                               acr_list.tdat));
                      exception
                        when others then
                          bars_audit.trace('%s_SOC' || sqlcode ||
                                           ' +�� ��������� ������ ��� ������ �� �������� � dpt_soc_turns �� ����� ��� = ' ||
                                           to_char(l_intlist(i).acc_id),
                                           title);
                      end;

                      bars_audit.trace('%s_SOC ���������� �������� �������� (��� ������� ����������� �������)= ' ||
                                       to_char(l_soc_turns_data.count),
                                       title);
                      l_tax_mil_s_soc  := 0;
                      l_tax_mil_sq_soc := 0;
                      l_tmp_mil_s_soc  := 0;
                      l_tmp_mil_s_soc  := 0;

                      for si in 1 .. l_soc_turns_data.count loop
                        bars_audit.trace('INT:_SOC' ||
                                         ' soc_date_begin = ' ||
                                         to_char(l_soc_turns_data(si)
                                                 .date_begin,
                                                 'dd/mm/yyyy') ||
                                         ' , soc_date_end = ' ||
                                         to_char(l_soc_turns_data(si)
                                                 .date_end,
                                                 'dd/mm/yyyy') ||
                                         ' , soc_factor = ' ||
                                         to_char(l_soc_turns_data(si)
                                                 .soc_factor));

                        begin
                          acrn.p_int(l_intlist(i).acc_id, -- �����.����� ��������� �����
                                     l_intlist(i).int_id, -- ��� ���������� ��������
                                     greatest(l_soc_turns_data(si)
                                              .date_begin,
                                              l_taxlist_mil   (z)
                                              .tax_date_begin), -- ��������� ���� ����������, ��� ������� ��������������� �� l_taxlist (tax_settings)
                                     nvl(l_taxlist_mil   (z).tax_date_end,
                                         l_soc_turns_data(si).date_end), -- �������� ���� ����������, ��� ������� ��������������� �� l_taxlist (tax_settings)
                                     l_tax_base_soc, -- ����� ����������� ��������� out ��� ������� ��������������� �� l_taxlist (tax_settings)
                                     l_intlist(i).acc_amount, -- ����� ����������
                                     0); -- ����� ���������� - ������ ������ ����� ���������, ��� ������� ��������������� �� l_taxlist (tax_settings)
                        exception
                          when others then
                            -- ������ ������������ ��������� ����������� ��������� �� ����� %s/%s: %s
                            l_errmsg := substr(bars_msg.get_msg(modcode,
                                                                'INTCALC_TAX_FAILED',
                                                                l_intlist          (i)
                                                                .acc_num,
                                                                l_intlist          (i)
                                                                .acc_iso,
                                                                sqlerrm || chr(10) || dbms_utility.format_error_backtrace()),
                                               1,
                                               errmsgdim);
                            raise expt_int;
                        end;

                        l_tax_base_soc    := round(l_tax_base_soc, 0); -- ��� ��� � �������� ������� ����������� �����������, ������� ->> acr_docs.int_rest
                        l_tax_base_soc_sq := nvl(l_tax_base_soc_sq, 0) +
                                             gl.p_icurval(l_taxrow_mil.kv,
                                                          l_tax_base_soc,
                                                          l_taxrow_mil.bdate);

                        --������ ������� (����� � �����������)- (����� ��� ����������) ����� ����� ��������� � ����� ������ �� ���� ������
                        if l_soc_turns_data(si).soc_factor < 1 then
                          l_tmp_mil_s_soc := round((l_tax_base_soc * l_taxlist_mil(z)
                                                   .tax_int * l_soc_turns_data(si)
                                                   .soc_factor) - (l_tax_base_soc * l_taxlist_mil(z)
                                                   .tax_int),
                                                   0);
                        else
                          l_tmp_mil_s_soc := 0;
                        end if;

                        l_tax_mil_s_soc  := nvl(l_tax_mil_s_soc, 0) +
                                            nvl(l_tmp_mil_s_soc, 0);
                        l_tax_mil_sq_soc := nvl(l_tax_mil_sq_soc, 0) +
                                            gl.p_icurval(l_taxrow_mil.kv,
                                                         l_tmp_mil_s_soc,
                                                         l_taxrow_mil.bdate);

                        bars_audit.trace('l_tax_base_soc = ' ||
                                         to_char(l_tax_base_soc) ||
                                         ' for --->' ||
                                         to_char(greatest(l_soc_turns_data(si)
                                                          .date_begin,
                                                          l_taxlist       (z)
                                                          .tax_date_begin),
                                                 'dd/mm/yyyy') || ' - ' ||
                                         to_char(nvl(l_taxlist       (z)
                                                     .tax_date_end,
                                                     l_soc_turns_data(si)
                                                     .date_end),
                                                 'dd/mm/yyyy'));
                        bars_audit.trace('l_tmp_mil_s_soc = ' ||
                                         to_char(l_tmp_mil_s_soc) ||
                                         'l_tax_mil_s_soc = ' ||
                                         to_char(l_tax_mil_s_soc) ||
                                         ', l_tax_mil_sq_soc = ' ||
                                         to_char(l_tax_mil_sq_soc));

                        l_taxrow_mil.tax_socinfo := substr(l_taxrow.tax_socinfo ||
                                                           to_char(l_soc_turns_data(si).soc_factor)              || ' ('      ||
                                                           to_char(l_soc_turns_data(si).date_begin,'dd/mm/yyyy') || '-'       ||
                                                           to_char(l_soc_turns_data(si).date_end,'dd/mm/yyyy')   ||') base =' ||
                                                           to_char(l_tax_base_soc)  ||', l_tmp_mil_s_soc=' ||
                                                           to_char(l_tmp_mil_s_soc) || ';',1,2000);
                      end loop;
                    else
                      l_tax_s_soc      := 0;
                      l_tax_sq_soc     := 0;
                      l_tax_mil_s_soc  := 0;
                      l_tax_mil_sq_soc := 0;
                    end if;
                  end loop;

                  l_taxrow.tax_s := case
                                    when (l_tax_s + l_tax_s_soc) >= 0
                                    then l_tax_s + l_tax_s_soc
                                    else 0
                                    end;
                  l_taxrow.tax_sq := case
                                     when (l_tax_sq + l_tax_sq_soc) >= 0
                                     then l_tax_sq + l_tax_sq_soc
                                     else 0
                                     end;
                  l_taxrow_mil.tax_s := case
                                          when (l_tax_mil_s + l_tax_mil_s_soc) >= 0 then
                                           l_tax_mil_s + l_tax_mil_s_soc
                                          else
                                           0
                                        end;
                  l_taxrow_mil.tax_sq := case
                                           when (l_tax_mil_sq + l_tax_mil_sq_soc) >= 0 then
                                            l_tax_mil_sq + l_tax_mil_sq_soc
                                           else
                                            0
                                         end;

                  bars_audit.trace( '%s l_taxrow.tax_sq = %s', title, to_char(l_taxrow.tax_sq) );
                  bars_audit.trace( '%s l_taxrow_mil.tax_sq = %s', title, to_char(l_taxrow_mil.tax_sq) );

                  -- ������ ������ ����������
                  if l_tax_base_soc_sq = l_taxrow.tax_base_s and
                     (l_taxrow.tax_s = 1 or l_taxrow.tax_sq = 1)
                  then
                    l_taxrow.tax_s  := 0;
                    l_taxrow.tax_sq := 0;
                  end if;

                  if l_tax_base_soc_sq = l_taxrow_mil.tax_base_s and
                     (l_taxrow_mil.tax_s = 1 or l_taxrow_mil.tax_sq = 1)
                  then
                    l_taxrow_mil.tax_s  := 0;
                    l_taxrow_mil.tax_sq := 0;
                  end if;

                  l_taxrow.tax_socinfo     := substr(l_taxrow.tax_socinfo,1,1500);
                  l_taxrow_mil.tax_socinfo := substr(l_taxrow_mil.tax_socinfo,1,1500);

                  insert into bars.dpt_15log values l_taxrow;

                  insert into bars.dpt_15log values l_taxrow_mil;

                  bars_audit.trace( '%s TAX ���� (l_taxrow.tax_s) = %s, (l_taxrow.tax_sq)= %s',
                                    title, to_char(l_taxrow.tax_s), to_char(l_taxrow.tax_sq) );
                  bars_audit.trace( '%s TAX ������� ���� (l_taxrow_mil.tax_s) = %s,(l_taxrow_mil.tax_sq) = %s',
                                    title, to_char(l_taxrow_mil.tax_s), to_char(l_taxrow_mil.tax_sq) );

                end if;

                -- ������
                begin
                  if (l_intlist(i).mod_code = 'DPU')
                  then
                    l_docrec.nazn := substr( dpu.get_intdetails( l_intlist(i).acc_num, l_intlist(i).acc_cur) || ' ' ||
                                             bars_msg.get_msg(modcode,'INT_DETAILS_FROM') || ' ' ||
                                             to_char(acr_list.fdat,'dd.mm.yy')            || ' ' ||
                                             bars_msg.get_msg(modcode,'INT_DETAILS_TILL') || ' ' ||
                                             to_char(acr_list.tdat,'dd.mm.yy')            || ' ' ||
                                             bars_msg.get_msg(modcode,'INT_DETAILS_INCLUDE'),1,160 );

                    -- ��������� ������ �������� �������� ����������� ������ ��
                    dpu.pay_doc_int(p_dpuid => l_intlist(i).deal_id,
                                    p_tt    => nvl(l_intlist(i).int_tt,l_cardrow.tt),
                                    p_dk    => 0,
                                    p_bdat  => l_bdate,
                                    p_acc_a => l_cardrow.acra,
                                    p_acc_b => l_cardrow.acrb,
                                    p_sum_a => l_docrec.s,
                                    p_nazn  => l_docrec.nazn,
                                    p_ref   => l_docrec.ref,
                                    p_tax   => (nvl(l_taxrow.tax_s, 0) + nvl(l_taxrow_mil.tax_s, 0)));

                  else
                    -- ����, � �.�. dpt
                    -- ����������� ���������� ���������
                    get_docparams(l_intlist(i),
                                  acr_list.fdat,
                                  acr_list.tdat,
                                  l_cardrow.tt,
                                  l_cardrow.metr,
                                  l_docrec);

                    l_docrec.ref := make_doc(l_docrec);

                    if (l_intlist(i).deal_id is not null and l_intlist(i).mod_code = 'DPT')
                    then -- ���������� ��������� ���������� �� ��������� ��
                      dpt_web.fill_dpt_payments( l_intlist(i).deal_id, l_docrec.ref );
                    end if;

                  end if;

                  if (l_tax_method = 2) and (l_tax_required = 1) then
                    -- ������ �������

                    l_taxrow.ref := l_docrec.ref;

                    if (nvl(l_taxrow.tax_sq, 0) > 0) then

/*                      bars_audit.log_trace('make_int (tax paytt call)',
                                           'l_taxrow.ref        : ' || l_taxrow.ref     || chr(10) ||
                                           'l_docrec.vdat       : ' || l_docrec.vdat    || chr(10) ||
                                           'tax_tt              : ' || tax_tt           || chr(10) ||
                                           'l_docrec.kv         : ' || l_docrec.kv      || chr(10) ||
                                           'l_docrec.nlsa       : ' || l_docrec.nlsa    || chr(10) ||
                                           'l_taxrow.tax_s      : ' || l_taxrow.tax_s   || chr(10) ||
                                           'l_basecur           : ' || l_basecur        || chr(10) ||
                                           'l_taxrow.tax_nls    : ' || l_taxrow.tax_nls || chr(10) ||
                                           'l_taxrow.tax_sq     : ' || l_taxrow.tax_sq  || chr(10) ||
                                           'gl.bd               : ' || gl.bd()          || chr(10) ||
                                           'l_intlist(i).branch : ' || l_intlist(i).branch,
                                           p_make_context_snapshot => true);
*/
                      begin
                          paytt(null,
                                l_taxrow.ref,
                                l_docrec.vdat,
                                tax_tt,
                                1,
                                l_docrec.kv,
                                l_docrec.nlsa,
                                l_taxrow.tax_s,
                                l_basecur,
                                l_taxrow.tax_nls,
                                l_taxrow.tax_sq);
                      exception
                          when others then
                               bars_audit.log_error('make_int (tax paytt call exception)',
                                                    'l_taxrow.ref        : ' || l_taxrow.ref        || chr(10) ||
                                                    'l_docrec.vdat       : ' || l_docrec.vdat       || chr(10) ||
                                                    'tax_tt              : ' || tax_tt              || chr(10) ||
                                                    'l_docrec.kv         : ' || l_docrec.kv         || chr(10) ||
                                                    'l_docrec.nlsa       : ' || l_docrec.nlsa       || chr(10) ||
                                                    'l_taxrow.tax_s      : ' || l_taxrow.tax_s      || chr(10) ||
                                                    'l_basecur           : ' || l_basecur           || chr(10) ||
                                                    'l_taxrow.tax_nls    : ' || l_taxrow.tax_nls    || chr(10) ||
                                                    'l_taxrow.tax_sq     : ' || l_taxrow.tax_sq     || chr(10) ||
                                                    'gl.bd               : ' || gl.bd()             || chr(10) ||
                                                    'l_intlist(i).branch : ' || l_intlist(i).branch || chr(10) ||
                                                    sqlerrm || chr(10) || dbms_utility.format_error_backtrace(),
                                                    p_auxiliary_info => get_content_of_tax_accounts(),
                                                    p_make_context_snapshot => true);
                          raise;
                      end;

                      bars_audit.trace( title ||' �� ����� � %s �� %s ���� ������� = %s ���� ������� = %s.',
                                        to_char(l_taxrow.tax_date_begin,'dd/mm/yyyy'),
                                        to_char(l_taxrow.tax_date_end,'dd/mm/yyyy'),
                                        to_char(l_taxrow_tax_base_s),
                                        to_char(l_taxrow.tax_s));
                    end if;

                    if (nvl(l_taxrow_mil.tax_sq, 0) > 0) then
/*
                      bars_audit.log_trace('make_int (tax paytt call)',
                                           'l_taxrow.ref         : ' || l_taxrow.ref         || chr(10) ||
                                           'l_docrec.vdat        : ' || l_docrec.vdat        || chr(10) ||
                                           'tax_mil_tt           : ' || tax_mil_tt           || chr(10) ||
                                           'l_docrec.kv          : ' || l_docrec.kv          || chr(10) ||
                                           'l_docrec.nlsa        : ' || l_docrec.nlsa        || chr(10) ||
                                           'l_taxrow_mil.tax_s   : ' || l_taxrow_mil.tax_s   || chr(10) ||
                                           'l_basecur            : ' || l_basecur            || chr(10) ||
                                           'l_taxrow_mil.tax_nls : ' || l_taxrow_mil.tax_nls || chr(10) ||
                                           'l_taxrow_mil.tax_sq  : ' || l_taxrow_mil.tax_sq  || chr(10) ||
                                           'gl.bd                : ' || gl.bd()          || chr(10) ||
                                           'l_intlist(i).branch : ' || l_intlist(i).branch,
                                           p_make_context_snapshot => true);
*/
                      begin
                          paytt(null,
                                l_taxrow.ref,
                                l_docrec.vdat,
                                tax_mil_tt,
                                1,
                                l_docrec.kv,
                                l_docrec.nlsa,
                                l_taxrow_mil.tax_s,
                                l_basecur,
                                l_taxrow_mil.tax_nls,
                                l_taxrow_mil.tax_sq);
                      exception
                          when others then
                               bars_audit.log_error('make_int (tax_mil paytt call exception)',
                                                    'l_taxrow.ref         : ' || l_taxrow.ref         || chr(10) ||
                                                    'l_docrec.vdat        : ' || l_docrec.vdat        || chr(10) ||
                                                    'tax_mil_tt           : ' || tax_mil_tt           || chr(10) ||
                                                    'l_docrec.kv          : ' || l_docrec.kv          || chr(10) ||
                                                    'l_docrec.nlsa        : ' || l_docrec.nlsa        || chr(10) ||
                                                    'l_taxrow_mil.tax_s   : ' || l_taxrow_mil.tax_s   || chr(10) ||
                                                    'l_basecur            : ' || l_basecur            || chr(10) ||
                                                    'l_taxrow_mil.tax_nls : ' || l_taxrow_mil.tax_nls || chr(10) ||
                                                    'l_taxrow_mil.tax_sq  : ' || l_taxrow_mil.tax_sq  || chr(10) ||
                                                    'gl.bd                : ' || gl.bd()              || chr(10) ||
                                                    'l_intlist(i).branch  : ' || l_intlist(i).branch  || chr(10) ||
                                                    sqlerrm || chr(10) || dbms_utility.format_error_backtrace(),
                                                    p_auxiliary_info => get_content_of_tax_accounts(),
                                                    p_make_context_snapshot => true);
                          raise;
                      end;

                      bars_audit.trace(title ||
                                       ' �� ����� � %s �� %s ���� ������� = %s ���� ������� (³�������� ���) = %s.',
                                       to_char(l_taxrow_mil.tax_date_begin,'dd/mm/yyyy'),
                                       to_char(l_taxrow_mil.tax_date_end,'dd/mm/yyyy'),
                                       to_char(l_taxrow_mil_tax_base_s),
                                       to_char(l_taxrow_mil.tax_s));
                    end if;

                  else
                    l_taxrow.ref := 0;
                  end if;

                  -- ���������� acr_docs - ��������� ���������� �� ���������� ���������
                  acrn.acr_dati(l_intlist(i).acc_id, -- �����.����� ��������� �����
                                l_intlist(i).int_id, -- ��� ���������� ��������
                                l_docrec.ref, -- �������� ���������
                                (acr_list.fdat - 1), -- ���� ����.����������
                                l_cardrow.s); -- ����� ����������
                exception
                  when others then
                    -- ������ ������ ��������� �� ����� %s/%s : %s
                    l_errmsg := substr(bars_msg.get_msg(modcode,
                                                        'INTPAY_FAILED',
                                                        l_intlist     (i)
                                                        .acc_num,
                                                        l_intlist     (i)
                                                        .acc_iso,
                                                        sqlerrm || chr(10) || dbms_utility.format_error_backtrace()),
                                       1,
                                       errmsgdim);
                    raise expt_int;
                end;

              end if;

            end if; -- (l_docrec.s != 0)

            -- ���������������� �������������� ��������
            if (p_runid > 0 and l_intlist(i).deal_id > 0 and l_intlist(i).mod_code in ('DPT', 'DPU'))
            then
              fill_log(p_intrec => l_intlist(i),
                       p_runid  => p_runid,
                       p_ref    => l_docrec.ref,
                       p_amount => l_docrec.s,
                       p_errmsg => null);
            end if;

          end loop; -- acr_list

          -- �������� ���� ����.���������� ��� ������, �� �������� � acr_list

          update int_accn
             set acr_dat = l_stpdat
           where acc = l_intlist(i).acc_id
             and id = l_intlist(i).int_id;

          -- ������������� ��������
          l_cnt := l_cnt + 1;

          if l_cnt >= autocommit then
            commit;
            l_cnt := 0;
          end if;
        end if;
        -- ��������� ������������ ���������� �� ���������� ���������

      exception
        when expt_int then
          if l_errmsg is not null then
            p_errflg := true;
            bars_audit.error(substr(title || ' ' || l_errmsg, 1, errmsgdim));
          end if;

          rollback to sp_beforeintdoc;

          -- ���������������� �������������� ��������
          if ( p_runmode = 1 and p_runid > 0 and l_intlist(i).deal_id > 0 and
               l_intlist(i).mod_code in ('DPT', 'DPU') and l_errmsg is not null )
          then
            fill_log(p_intrec => l_intlist(i),
                     p_runid  => p_runid,
                     p_ref    => null,
                     p_amount => null,
                     p_errmsg => l_errmsg);
          end if;
      end;
    end loop;

    forall i in 1 .. l_intlist.count
    delete from int_queue where rowid = l_rwlist(i);

    l_rwlist.delete;
  end loop;

  bars_audit.trace( '%s �����, ���������� �� %s, ����� %s, ������ � %s'
                  , title, to_char(p_dat2, 'dd.mm.yy'), to_char(p_runmode), to_char(p_runid) );

end MAKE_INT;
/
