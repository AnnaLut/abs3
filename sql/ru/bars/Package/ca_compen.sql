create or replace package body ca_compen
as
  version_body  constant  varchar2(64) := 'version 1.15 28.02.2017 17:50';

--

  procedure rebran_deposit (p_summa        in varchar2,
                            p_ob22         in varchar2,
                            p_branchfrom   in varchar2,
                            p_branchto     in varchar2,
                            p_err         out varchar2,
                            p_ret         out int)
  is
    REF_      int;
    TT_       char(3);
    VOB_      int;
    nmsfr_    varchar2(64);
    nmsto_    varchar2(64);
    okpofr_   varchar2(32);
    okpoto_   varchar2(32);
    R9760fr_  varchar2(15);
    R9760to_  varchar2(15);
    l_branch  varchar2(30);

  begin

    tokf;
    bars_audit.info('ca_compen.rebran_deposit: begin');

    p_err    := '';
    p_ret    := 0;
    l_branch := sys_context('bars_context','user_branch');

--  TT_  := 'АСВ';
    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CA_TT'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   TT_;
    exception when others then
      TT_ := GetGlobalOption('CA_TT');
    end;
    if trim(TT_) is null then
      TT_ := 'АСВ';
    end if;
    VOB_ := 6;

--  R9760fr_ := vkrzn(f_ourmfo_g,'976000'||p_ob22||substr(p_branchfrom,2,6));
--  R9760to_ := vkrzn(f_ourmfo_g,'976000'||p_ob22||substr(p_branchto,2,6));

    bars_audit.info('ca_compen.rebran_deposit: mask nls branchfrom('||p_branchfrom||')='||'9760_0'||p_ob22||substr(p_branchfrom,2,6));

    begin
      select a.nls                   ,
             trim(substr(a.nms,1,38)),
             c.okpo
      into   R9760fr_,
             nmsfr_  ,
             okpofr_
      from   accounts a,
             customer c
      where  a.nls like '9760_0'||p_ob22||substr(p_branchfrom,2,6) and
             a.kv=980                                              and
             a.dazs is null                                        and
             c.rnk=a.rnk;
    exception when no_data_found then
      p_err := 'ЦА-ГРЦ, Рахунок 9760_0'||p_ob22||substr(p_branchfrom,2,6)||
               ' не знайдений (закритий або не існує)...';
      p_ret := -4;
      rollback;
      return;
    end;

    begin
      select a.nls                   ,
             trim(substr(a.nms,1,38)),
             c.okpo
      into   R9760to_,
             nmsto_  ,
             okpoto_
      from   accounts a,
             customer c
      where  a.nls like '9760_0'||p_ob22||substr(p_branchto,2,6) and
             a.kv=980                                            and
             a.dazs is null                                      and
             c.rnk=a.rnk;
    exception when no_data_found then
      p_err := 'ЦА-ГРЦ, Рахунок 9760_0'||p_ob22||substr(p_branchto,2,6)||
               ' не знайдений (закритий або не існує)...';
      p_ret := -5;
      rollback;
      return;
    end;

    GL.REF
         (REF_);

    GL.IN_DOC3
         (REF_  , TT_     , VOB_    , REF_, SYSDATE           , GL.BDATE, 1,
          980   , to_number(p_summa), 980 , to_number(p_summa),
          NULL  , GL.BDATE, GL.BDATE,
          nmsto_, R9760to_, gl.AMFO ,
          nmsfr_, R9760fr_, gl.AMFO ,
          'Ребранчінг компенсаційних коштів переданих до ЦРКР',
          NULL, okpoto_, okpofr_, NULL, NULL, 0, NULL, null);
    begin
      GL.PAYV
           (0, REF_, GL.BDATE, TT_, 1, 980, R9760to_, to_number(p_summa),
                                       980, R9760fr_, to_number(p_summa));
    exception when OTHERS then
      p_err := 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
      p_ret := -2;
      rollback;
      return;
    end;

    begin
      GL.PAY
           (2, REF_, GL.BDATE);
      p_ret := REF_;
    exception when OTHERS then
      p_err := 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
      p_ret := -3;
      rollback;
      return;
    end;

    bars_audit.info('ca_compen.rebran_deposit: end');

  end rebran_deposit;

--

  procedure make_tran_tvbv (p_summa        in varchar2,
                            p_nls          in varchar2,
                            p_ob22         in varchar2,
                            p_kv           in varchar2,
                            p_branch       in varchar2,
                            p_tvbv         in varchar2,
                            p_date_import  in varchar2,
                            p_err         out varchar2,
                            p_ret         out int)
  is
    REF_      int;
    TT_       char(3);
    VOB_      int;
    nms7_     varchar2(64);
    nms9_     varchar2(64);
    okpo7_    varchar2(32);
    okpo9_    varchar2(32);
    R9760_    varchar2(15);
    R9910_    varchar2(15);
    l_branch  varchar2(30);
  begin

    tokf;
    bars_audit.info('ca_compen.make_tran_tvbv: begin');

--  bars_audit.info('p_summa      ='||p_summa      );
--  bars_audit.info('p_nls        ='||p_nls        );
--  bars_audit.info('p_kv         ='||p_kv         );
--  bars_audit.info('p_branch     ='||p_branch     );
--  bars_audit.info('p_tvbv       ='||p_tvbv       );
--  bars_audit.info('p_date_import='||p_date_import);

    p_err := '';
    p_ret := 0;

    l_branch := sys_context('bars_context','user_branch');

--  TT_  := 'АСВ';
    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CA_TT'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   TT_;
    exception when others then
      TT_ := GetGlobalOption('CA_TT');
    end;
    if trim(TT_) is null then
      TT_ := 'АСВ';
    end if;
    VOB_ := 6;

--  R9760_ := GetGlobalOption('R9760'); -- ??
--  R9910_ := GetGlobalOption('R9910');
    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''R9910'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   R9910_;
    exception when others then
      R9910_ := GetGlobalOption('R9910');
    end;
    if R9910_ is null then
      R9910_ := '99109876543210';
    end if;

--  begin
--    select nls
--    into   R9760_
--    from   compen9760
--    where  MFO=substr(p_branch,2,6);
--  exception when no_data_found then
--    p_err := 'В ЦА не визначений рахунок 9760 для МФО='||substr(p_branch,2,6)||'...';
--    p_ret := -1;
--    return;
--  end;

--  R9760_ := vkrzn(f_ourmfo_g,'976000'||p_ob22||substr(p_branch,2,6));

    begin
      select a.nls                   ,
             trim(substr(a.nms,1,38)),
             c.okpo
      into   R9760_,
             nms7_ ,
             okpo7_
      from   accounts a,
             customer c
      where  a.nls like '9760_0'||p_ob22||substr(p_branch,2,6) and
--           a.nls=R9760_                                      and
             a.kv=980                                          and
             a.dazs is null                                    and
             c.rnk=a.rnk;
    exception when no_data_found then
--    nms7_  := 'найменування рахунку 9760 невизначене';
--    okpo7_ := 'невизначене';
      p_err := 'ЦА-ГРЦ, Рахунок 9760_0'||p_ob22||substr(p_branch,2,6)||
               ' не знайдений (закритий або не існує)...';
      p_ret := -4;
      rollback;
      return;
    end;

    begin
      select trim(substr(a.nms,1,38)),
             c.okpo
      into   nms9_,
             okpo9_
      from   accounts a,
             customer c
      where  a.nls=R9910_   and
             a.kv=980       and
             a.dazs is null and
             c.rnk=a.rnk;
    exception when no_data_found then
--    nms9_  := 'найменування рахунку 9910 невизначене';
--    okpo7_ := 'невизначене';
      p_err := 'ЦА-ГРЦ, Рахунок '||R9910_||' не знайдений (закритий або не існує)...';
      p_ret := -5;
      rollback;
      return;
    end;

    bars_audit.info('ca_compen.make_tran_tvbv: TT_ = '||TT_);

    GL.REF
         (REF_);

--  bars_audit.info(                  'REF_   ='||REF_   ||
--                  chr(13)||chr(10)||'TT_    ='||TT_    ||
--                  chr(13)||chr(10)||'VOB_   ='||VOB_   ||
--                  chr(13)||chr(10)||'P_KV   ='||P_KV   ||
--                  chr(13)||chr(10)||'p_summa='||p_summa||
--                  chr(13)||chr(10)||'nms7_  ='||nms7_  ||
--                  chr(13)||chr(10)||'R9760_ ='||R9760_ ||
--                  chr(13)||chr(10)||'nms9_  ='||nms9_  ||
--                  chr(13)||chr(10)||'R9910_ ='||R9910_ ||
--                  chr(13)||chr(10)||'okpo7_ ='||okpo7_ ||
--                  chr(13)||chr(10)||'okpo9_ ='||okpo9_);

    GL.IN_DOC3
         (REF_ , TT_     , VOB_    , REF_    , SYSDATE        , GL.BDATE,        1,
          to_number(p_KV), to_number(p_summa), to_number(p_KV), to_number(p_summa),
          NULL , GL.BDATE, GL.BDATE,
          nms7_, R9760_  , gl.AMFO ,
          nms9_, R9910_  , gl.AMFO ,
          'Зарахування сум компенсаційних коштів переданих ТВБВ ('||p_tvbv||') '||
          p_branch||' до ЦРКР',
          NULL, okpo7_, okpo9_, NULL, NULL, 0, NULL, null);
    begin
      GL.PAYV
           (0, REF_, GL.BDATE, TT_, 1, to_number(p_KV), R9760_, to_number(p_summa),
                                       to_number(p_KV), R9910_, to_number(p_summa));
    exception when OTHERS then
      p_err := 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
      p_ret := -2;
      rollback;
      return;
    end;

    begin
      GL.PAY
           (2, REF_, GL.BDATE);
    exception when OTHERS then
      p_err := 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
      p_ret := -3;
      rollback;
      return;
    end;

    begin
      insert
      into   operw (ref,
                    tag,
                    value)
            values (REF_   ,
                    'TVBV ',
                    p_tvbv);        -- доп.реквизит1 для отката
      insert
      into   operw (ref,
                    tag,
                    value)
            values (REF_   ,
                    'BRNCH',
                    p_branch);      -- доп.реквизит2 для отката
      insert
      into   operw (ref,
                    tag,
                    value)
            values (REF_   ,
                    'NLSRU',
                    p_nls);         -- доп.реквизит3 для отката
      insert
      into   operw (ref,
                    tag,
                    value)
            values (REF_   ,
                    'D_IMP',
                    p_date_import); -- доп.реквизит4 для отката
    exception when OTHERS then
      p_err := 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
      p_ret := -1;
      rollback;
      return;
    end;

--  for report_tvbv
    update tmp_crkr_report_tvbv
    set    ss=ss+to_number(p_summa)
    where  mfo=substr(p_branch,2,6) and
           tvbv=p_tvbv              and
           branch=p_branch          and
           ob22=p_ob22;
    if sql%rowcount=0 then
      begin
        insert
        into   tmp_crkr_report_tvbv (mfo   ,
                                     branch,
                                     tvbv  ,
                                     ob22  ,
                                     ss)
                        values (substr(p_branch,2,6),
                                p_branch            ,
                                p_tvbv              ,
                                p_ob22              ,
                                to_number(p_summa));
      exception when OTHERS then
        p_err := 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
        p_ret := -8;
        rollback;
        return;
      end;
    end if;

--  for report
    update tmp_crkr_report
    set    ss=ss+to_number(p_summa)
    where  mfo=substr(p_branch,2,6) and
           ob22=p_ob22;
    if sql%rowcount=0 then
      begin
        insert
        into   tmp_crkr_report (mfo ,
                                ob22,
                                ss)
                        values (substr(p_branch,2,6),
                                p_ob22              ,
                                to_number(p_summa));
      exception when OTHERS then
        p_err := 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
        p_ret := -7;
        rollback;
        return;
      end;
    end if;

    bars_audit.info('ca_compen.make_tran_tvbv: end');

  end make_tran_tvbv;

--

  procedure back_ref       (p_ref          in varchar2,
                            p_out         out varchar2)
  is
    l_sos  int;
    l_num  number;
    l_str  varchar2(1024);
  begin
    tokf;
    bars_audit.info('ca_compen.back_ref: begin for ref = '||p_ref);
    begin
      begin
        select sos
        into   l_sos
        from   oper
        where  ref=to_number(p_ref);
      exception when others then
        p_out := '* '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
        rollback;
        bars_audit.error('ca_compen.back_ref: NO get sos for ref = '||p_ref||' '||p_out);
        return;
      end;
      if l_sos>=5 then
        p_out := to_char(l_sos);
--      no back
        bars_audit.info('ca_compen.back_ref: end, NO back ref = '||p_ref||', sos = '||p_out);
        return;
      end if;
    end;
    begin
      bars_audit.info('ca_compen.back_ref: start back ref = '||p_ref);
--    ful_bak(to_number(p_ref));
      p_back_dok(to_number(p_ref),5,null,l_num,l_str,0);
      insert
      into   oper_visa (ref   ,
                        dat   ,
                        userid,
                        status)
                values (to_number(p_ref),
                        SYSDATE         ,
                        user_id         ,
                        3);
      p_out := '-1';
      bars_audit.info('ca_compen.back_ref: end back ref = '||p_ref||', sos = '||p_out);
    exception when others then
      p_out := '* '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
      bars_audit.error('ca_compen.back_ref: no back ref = '||p_ref||' '||p_out);
      rollback;
      return;
    end;
  end back_ref;

--

  procedure drop_tran_tvbv (p_tvbv         in varchar2,
                            p_kf           in varchar2,
                            p_date_import  in varchar2,
                            p_err         out varchar2,
                            p_ret         out int)
  is
    TT_       char(3);
    l_branch  varchar2(30);
    l_num     number;
    l_str     varchar2(1024);
  begin

    tokf;
    bars_audit.info('ca_compen.drop_tran_tvbv: begin');

    p_err    := '';
    p_ret    := 0;
    l_branch := sys_context('bars_context','user_branch');

--  TT_ := 'АСВ';
    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CA_TT'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   TT_;
    exception when others then
      TT_ := GetGlobalOption('CA_TT');
    end;
    if trim(TT_) is null then
      TT_ := 'АСВ';
    end if;
    bars_audit.info('ca_compen.drop_tran_tvbv: p_date_import = '||p_date_import);

    for k in (select o.ref                  ,
                     o.s                    ,
                     substr(o.nlsa,7,2) ob22,
                     w2.value           branch
              from   oper  o ,
                     operw w1,
                     operw w2
              where  o.sos>0                                                         and
                     o.tt=TT_                                                        and
                     o.nazn like 'Зарахування сум компенсаційних коштів переданих %' and
                     o.pdat>=to_date(p_date_import,'YYYY-MM-DD')                     and
                     w1.ref=o.ref                                                    and
                     w1.tag='TVBV '                                                  and
                     w1.value=p_tvbv                                                 and
                     w2.ref=o.ref                                                    and
                     w2.tag='BRNCH'                                                  and
                     substr(w2.value,2,6)=p_kf
             )
    loop
      begin
        bars_audit.info('ca_compen.drop_tran_tvbv: k.ref = '||k.ref);
--      ful_bak(k.ref);
        p_back_dok(k.ref,5,null,l_num,l_str,0);
--      p_back_dok(Ref_      => k.ref,
--                 ReasonId_ => -1   ,
--                 Par2_     => p_ret,
--                 Par3_     => p_err);
        insert
        into   oper_visa (ref   ,
                          dat   ,
                          userid,
                          status)
                  values (k.ref  ,
                          SYSDATE,
                          user_id,
                          3);
      exception when others then
        p_err := 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
        p_ret := -1;
        rollback;
        return;
      end;

      begin
        update tmp_crkr_report
        set    ss=ss-k.s
        where  mfo=p_kf and
               ob22=k.ob22;
      exception when others then
        p_err := 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
        p_ret := -2;
        rollback;
        return;
      end;

      begin
        update tmp_crkr_report_tvbv
        set    ss=ss-k.s
        where  mfo=p_kf    and
               ob22=k.ob22 and
               tvbv=p_tvbv and
               branch=k.branch;
      exception when others then
        p_err := 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
        p_ret := -3;
        rollback;
        return;
      end;

    end loop;
    bars_audit.info('ca_compen.drop_tran_tvbv: end');

  end drop_tran_tvbv;

--

  procedure verify_compen (p_branch in varchar2)
  is
    l_url_wapp           varchar2(256);
    l_Authorization_val  varchar2(256);
    l_walett_path        varchar2(256);
    l_walett_pass        varchar2(256);
    l_action             varchar2(32);
    g_response           wsm_mgr.t_response;
    l_result             varchar2(32767);
    l_clob               clob;
    l_timeout            number;
    l_tt                 char(3);
    l_err                varchar2(32767);
    l_branch             varchar2(30);
    l_login              varchar2(30);
    l_pass               varchar2(30);
    l_timeouts           varchar2(8);
  begin

    l_branch := sys_context('bars_context','user_branch');
--  l_tt     := 'АСВ';

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CA_TT'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_tt;
    exception when others then
      l_tt := GetGlobalOption('CA_TT');
    end;
    if trim(l_tt) is null then
      l_tt := 'АСВ';
    end if;

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CRKR_URL'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_url_wapp;
    exception when others then
      l_url_wapp := GetGlobalOption('CRKR_URL');
    end;
    if l_url_wapp is null then
--    l_url_wapp := 'http://url_undefined';
      l_url_wapp := 'http://10.10.10.83:9081/barsroot/api/crkr/';
    end if;
    if substr(l_url_wapp,-1)<>'/' then
      l_url_wapp := l_url_wapp||'/';
    end if;

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CRKR_LOGIN'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_login;
    exception when others then
      l_login := GetGlobalOption('CRKR_LOGIN');
    end;

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CRKR_PASS'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_pass;
    exception when others then
      l_pass := GetGlobalOption('CRKR_PASS');
    end;

    l_Authorization_val := 'Basic '||utl_raw.cast_to_varchar2(utl_encode.base64_encode(
                           utl_raw.cast_to_raw(l_login||':'||l_pass)));

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CRKR_WALLET_PATH'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_walett_path;
    exception when others then
      l_walett_path := GetGlobalOption('CRKR_WALLET_PATH');
    end;

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CRKR_WALLET_PASS'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_walett_pass;
    exception when others then
      l_walett_pass := GetGlobalOption('CRKR_WALLET_PASS');
    end;

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CRKR_TIMEOUT'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_timeouts;
    exception when others then
      l_timeouts := GetGlobalOption('CRKR_TIMEOUT');
    end;

    if l_timeouts is not null then
      begin
        l_timeout := greatest(to_number(l_timeouts),60);
      exception when others then
        l_timeout := 300;
      end;
    else
      l_timeout := 300;
    end if;

--  проверка, не украл ли кто-нибудь что-нибудь в базе ЦРКР

    l_action := 'verifycompen';

    begin  
      bars_audit.info('service '||l_action||' start');
      utl_http.set_transfer_timeout(l_timeout);
      wsm_mgr.prepare_request(p_url          => l_url_wapp         ,
                              p_action       => l_action           ,
                              p_http_method  => wsm_mgr.G_HTTP_POST,
                              p_content_type => wsm_mgr.g_ct_json  ,
                              p_wallet_path  => l_walett_path      ,
                              p_wallet_pwd   => l_walett_pass);
      wsm_mgr.add_header     (p_name => 'Authorization', p_value => l_Authorization_val);
      wsm_mgr.add_parameter  (p_name => 'mode'         , p_value => 'CA'               );
      wsm_mgr.add_parameter  (p_name => 'tvbv'         , p_value => null               );
      wsm_mgr.add_parameter  (p_name => 'brmf'         , p_value => p_branch           );
      wsm_mgr.execute_request(g_response);
      l_result := g_response.cdoc; -- если есть ответ - в clob будет  
      bars_audit.info('service '||l_action||' end - '||substr(l_result,1,3000));
      if substr(l_result,1,4) in ('400 ','401 ','404 ','500 ') and length(l_result)>4 then
        raise_application_error(-20036,'Ошибка выполнения ca_compen.verify_compen !!! '||
                                replace(substr(l_result,1,3000),chr(10),chr(13)||chr(10)));
        return;
      else
        bars_audit.info('service '||l_action||' end '||l_result);
--      нарисовать код сличения людей из ЦРКР и коров из РУ
        delete
        from   tmp_verify_compen
        where  branch=p_branch;
        l_result := replace(l_result,'"');
        l_err    := '';
        for k in (select coalesce(a.ob22,b.ob22,ac.ob22)  ob22,
                         nvl(a.suma,0)               provodoki,
                         nvl(b.suma,0)               vkladai  ,
                         nvl(a.suma,0)-nvl(b.suma,0) diff     ,
                         -ac.ostc                    zalca    ,
                         -ac.ostc-nvl(b.suma,0)      diffca
                  from       (select ob22, ss   suma from   tmp_crkr_report  where  mfo=p_branch) a
				         full join 
							 (select extractValue(value(dtl),'Rec/OB22')   ob22,  to_number(extractValue(value(dtl),'Rec/SUMA')) suma
							  from   (select XMLType(l_result) xml from dual) s, table(XMLSequence(s.xml.extract('crkr/Rec'))) dtl) b    on (a.ob22 = b.ob22)
                         full join 
						    (Select * from  accounts where nls like '9760_0%'||p_branch and kv=980) ac  on (ac.ob22 = coalesce(a.ob22,b.ob22))
                  order  by 1
                 )
        loop
          insert
          into   tmp_verify_compen (branch ,
                                    ob22   ,
                                    sumCA  ,
                                    sumCRKR,
                                    zalca  ,
                                    diffca ,
                                    diff)
                            values (p_branch   ,
                                    k.ob22     ,
                                    k.provodoki,
                                    k.vkladai  ,
                                    k.zalca    ,
                                    k.diffca   ,
                                    k.diff);
        end loop;
      end if;
    exception when others then
      raise_application_error(-20037,'Ошибка выполнения ca_compen.verify_compen !!! '
                              ||sqlerrm||' - '||dbms_utility.format_error_backtrace);
      return;
    end;
    commit;

  end verify_compen;

--

  procedure verify_compen_tvbv (p_branch in varchar2)
  is
    l_url_wapp           varchar2(256);
    l_Authorization_val  varchar2(256);
    l_walett_path        varchar2(256);
    l_walett_pass        varchar2(256);
    l_action             varchar2(32);
    g_response           wsm_mgr.t_response;
    l_result             clob; -- varchar2(32767);
    l_clob               clob;
    l_timeout            number;
    l_tt                 char(3);
    l_err                varchar2(32767);
    l_branch             varchar2(30);
    l_login              varchar2(30);
    l_pass               varchar2(30);
    l_timeouts           varchar2(8);
  begin

    l_branch := sys_context('bars_context','user_branch');
--  l_tt     := 'АСВ';

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CA_TT'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_tt;
    exception when others then
      l_tt := GetGlobalOption('CA_TT');
    end;
    if trim(l_tt) is null then
      l_tt := 'АСВ';
    end if;

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CRKR_URL'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_url_wapp;
    exception when others then
      l_url_wapp := GetGlobalOption('CRKR_URL');
    end;
    if l_url_wapp is null then
--    l_url_wapp := 'http://url_undefined';
      l_url_wapp := 'http://10.10.10.83:9081/barsroot/api/crkr/';
    end if;
    if substr(l_url_wapp,-1)<>'/' then
      l_url_wapp := l_url_wapp||'/';
    end if;

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CRKR_LOGIN'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_login;
    exception when others then
      l_login := GetGlobalOption('CRKR_LOGIN');
    end;

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CRKR_PASS'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_pass;
    exception when others then
      l_pass := GetGlobalOption('CRKR_PASS');
    end;

    l_Authorization_val := 'Basic '||utl_raw.cast_to_varchar2(utl_encode.base64_encode(
                           utl_raw.cast_to_raw(l_login||':'||l_pass)));

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CRKR_WALLET_PATH'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_walett_path;
    exception when others then
      l_walett_path := GetGlobalOption('CRKR_WALLET_PATH');
    end;

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CRKR_WALLET_PASS'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_walett_pass;
    exception when others then
      l_walett_pass := GetGlobalOption('CRKR_WALLET_PASS');
    end;

    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''CRKR_TIMEOUT'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   l_timeouts;
    exception when others then
      l_timeouts := GetGlobalOption('CRKR_TIMEOUT');
    end;

    if l_timeouts is not null then
      begin
        l_timeout := greatest(to_number(l_timeouts),60);
      exception when others then
        l_timeout := 300;
      end;
    else
      l_timeout := 300;
    end if;

--  проверка, не украл ли кто-нибудь что-нибудь в базе ЦРКР

    l_action := 'verifycompen';

    begin
      bars_audit.info('service '||l_action||' start');
      utl_http.set_transfer_timeout(l_timeout);
      wsm_mgr.prepare_request(p_url          => l_url_wapp         ,
                              p_action       => l_action           ,
                              p_http_method  => wsm_mgr.G_HTTP_POST,
                              p_content_type => wsm_mgr.g_ct_json  ,
                              p_wallet_path  => l_walett_path      ,
                              p_wallet_pwd   => l_walett_pass);
      wsm_mgr.add_header     (p_name => 'Authorization', p_value => l_Authorization_val);
      wsm_mgr.add_parameter  (p_name => 'mode'         , p_value => 'CN'               );
      wsm_mgr.add_parameter  (p_name => 'tvbv'         , p_value => null               );
      wsm_mgr.add_parameter  (p_name => 'brmf'         , p_value => p_branch           );
      wsm_mgr.execute_request(g_response);
      l_result := g_response.cdoc; -- если есть ответ - в clob будет
      bars_audit.info('service '||l_action||' end - '||substr(l_result,1,3000));
      if substr(l_result,1,4) in ('400 ','401 ','404 ','500 ') and length(l_result)>4 then
        raise_application_error(-20036,'Ошибка выполнения ca_compen.verify_compen_tvbv !!! '||
                                replace(substr(l_result,1,3000),chr(10),chr(13)||chr(10)));
        return;
      else
        bars_audit.info('service '||l_action||' end');
--      нарисовать код сличения людей из ЦРКР и коров из РУ
        delete
        from   tmp_verify_compen_tvbv
        where  mfo=p_branch;
        l_result := replace(l_result,'"');
        l_err    := '';
/*
        for k in (select b.ob22                        ,
                         nvl(a.suma,0)        provodoki,
                         b.suma               vkladai  ,
                         nvl(a.suma,0)-b.suma diff
                  from   (select ob22,sum(suma) suma
                          from   (select a.ob22  ,
                                         o.s    suma
                                       --,
                                       --o.branch,
                                       --o.ref
                                  from   oper     o,
                                         operw    w,
                                         accounts a
                                  where  o.tt in (l_tt,'024')                                             and
                                         o.vdat>trunc(sysdate)-90                                         and
                                         o.nazn='Зарахування сум компенсаційних коштів переданих до ЦРКР' and
                                         o.sos>=1                                                         and
                                         w.ref=o.ref                                                      and
                                         w.tag='BRNCH'                                                    and
                                         substr(w.value,2,6)=p_branch                                     and
                                         a.nls=o.nlsa                                                     and
                                         a.kv=980)
                          group by ob22)                                            a,
                         (select extractValue(value(dtl),'Rec/OB22')            ob22,
                                 to_number(extractValue(value(dtl),'Rec/SUMA')) suma
                          from   (select XMLType(l_result) xml from dual)           s,
                                 table(XMLSequence(s.xml.extract('crkr/Rec'))) dtl) b
                          where  decode(b.ob22,'23','01',b.ob22)=A.OB22(+)
                 )
*/
/*
        for k in (select b.ob22                               ,
                         nvl(a.suma,0)               provodoki,
                         nvl(b.suma,0)               vkladai  ,
                         nvl(a.suma,0)-nvl(b.suma,0) diff
                  from   (select ob22,
                                 ss   suma
                          from   tmp_crkr_report
                          where  mfo=p_branch)                                      a,
                         (select extractValue(value(dtl),'Rec/OB22')            ob22,
                                 to_number(extractValue(value(dtl),'Rec/SUMA')) suma
                          from   (select XMLType(l_result) xml from dual) s,
                                 table(XMLSequence(s.xml.extract('crkr/Rec'))) dtl) b
                          where  b.ob22=A.OB22(+)
                 )
*/

        for k in (select coalesce(a.ob22,b.ob22)                ob22     ,
                         coalesce(a.tvbv,b.tvbv)                tvbv     ,
                         coalesce(a.branch,b.branch)            branch   ,
                         nvl(a.suma,0)                          provodoki,
                         nvl(to_number(b.suma),0)               vkladai  ,
                         nvl(a.suma,0)-nvl(to_number(b.suma),0) diff
                  from   (select ob22  ,
                                 tvbv  ,
                                 branch,
                                 ss suma
                          from   tmp_crkr_report_tvbv
                          where  mfo=p_branch)                                      a
                  full
                  outer
                  join
                         (select extractValue(value(dtl),'Rec/OB22')   ob22  ,
                                 extractValue(value(dtl),'Rec/TVBV')   tvbv  ,
                                 extractValue(value(dtl),'Rec/BRANCH') branch,
                                 extractValue(value(dtl),'Rec/SUMA')   suma
                          from   (select XMLType(l_result) xml from dual) s,
                                 table(XMLSequence(s.xml.extract('crkr/Rec'))) dtl) b
                  on     b.ob22=A.OB22 and
                         b.tvbv=a.tvbv and
                         b.branch=a.branch
                  order  by 2,3,1
                 )
/*
        for k in (select coalesce(a.ob22,b.ob22)     ob22     ,
                         coalesce(a.tvbv,b.tvbv)     tvbv     ,
                         coalesce(a.branch,b.branch) branch   ,
                         nvl(a.suma,0)               provodoki,
                         nvl(b.suma,0)               vkladai  ,
                         nvl(a.suma,0)-nvl(b.suma,0) diff
                  from   (select ob22  ,
                                 tvbv  ,
                                 branch,
                                 ss suma
                          from   tmp_crkr_report_tvbv
                          where  mfo=p_branch)                                      a
                  full
                  outer
                  join
                         (select extractValue(value(dtl),'Rec/OB22')            ob22  ,
                                 extractValue(value(dtl),'Rec/TVBV')            tvbv  ,
                                 extractValue(value(dtl),'Rec/BRANCH')          branch,
                                 to_number(extractValue(value(dtl),'Rec/SUMA')) suma
                          from   (select XMLType(l_result) xml from dual) s,
                                 table(XMLSequence(s.xml.extract('crkr/Rec'))) dtl) b
                  on     b.ob22=A.OB22 and
                         b.tvbv=a.tvbv and
                         b.branch=a.branch
                  order  by 2,3,1
*/
        loop
          insert
          into   tmp_verify_compen_tvbv (mfo    ,
                                         tvbv   ,
                                         branch ,
                                         ob22   ,
                                         sumCA  ,
                                         sumCRKR,
                                         diff)
                                 values (p_branch   ,
                                         k.tvbv     ,
                                         k.branch   ,
                                         k.ob22     ,
                                         k.provodoki,
                                         k.vkladai  ,
                                         k.diff);
        end loop;
      end if;
    exception when others then
      raise_application_error(-20038,'Ошибка выполнения ca_compen.verify_compen_tvbv !!! '
                              ||sqlerrm||' - '||dbms_utility.format_error_backtrace);
      return;
    end;
    commit;

  end verify_compen_tvbv;

--

  procedure payments_compen_xml (p_clob in out clob)
  is
    l_clob                  clob; --відповідь
--  type t_compen_payment   is record (id      compen_payments_registry.id%type,
--                                     amount  compen_payments_registry.amount%type,
--                                     kv      compen_payments_registry.kv%type,
--                                     mfo     compen_payments_registry.mfo%type,
--                                     nls     compen_payments_registry.nls%type
--                                    );
--  type t_a_compen_payment is table of t_compen_payment;
--  l_compen_payments       t_a_compen_payment := t_a_compen_payment();

    type t_compen_oper      is record (id   number,
                                       ref  oper.ref%type,
                                       err  varchar2(4000)
                                      );
    type t_a_compen_oper    is table of t_compen_oper;
    l_compen_oper           t_a_compen_oper := t_a_compen_oper();

    l_parser                dbms_xmlparser.parser;
    l_doc                   dbms_xmldom.domdocument;
    l_rows                  dbms_xmldom.domnodelist;
    l_row                   dbms_xmldom.domnode;

    l_root_node             dbms_xmldom.domnode;
    l_supp_element          dbms_xmldom.domelement;
    l_sup_node              dbms_xmldom.domnode;
    l_supp_node             dbms_xmldom.domnode;
    l_suppp_node            dbms_xmldom.domnode;
    l_supplier_node         dbms_xmldom.domnode;
    l_supp_text             dbms_xmldom.domtext;
--  l_start                 number default dbms_utility.get_time;--debug

    r_oper                  oper%rowtype;
    s_                      number;
    id_                     number;
    ctype_                  number; -- (1-выплата,2-выплата на поховання)
    kv_                     number;
    mfo_                    varchar2(12);
    nls_                    accounts.nls%type;
    nls2906_                accounts.nls%type;
    nls2906_ru              accounts.nls%type;
    nls9910_                accounts.nls%type;
    nls9760_                accounts.nls%type;
    nms2906_                accounts.nms%type;
    nms2906_ru              accounts.nms%type;
    nls2924_                accounts.nls%type;
    nms2924_                accounts.nms%type;
    nazn_                   oper.nazn%type;
    ser_                    varchar2(32);--або серія або ЄДДР, якщо ФД картка
    docnum_                 varchar2(32);
    fio_                    varchar2(100);
    okpo_                   varchar2(10);
    okpo_bank               varchar2(8);
    l_branch                varchar2(30);
    l_tts                   char(3);
    l_grc_nls_t00           accounts.nls%type;
    l_rec_                  VARCHAR2(80);   -- Additional parameters
    nazns_                  CHAR(2);        -- Narrative contens type
    err_                    NUMBER;    -- Return code
    rec_                    NUMBER;    -- Record number
    
    l_transit               accounts.nls%type;

/*    уже не нужно
    procedure get_2924(p_nls out accounts.nls%type, p_nms out accounts.nms%type) is
    begin
            select nls,
                   trim(substr(nms,1,38))
            into   p_nls,
                   p_nms
            from   accounts
            where  nls like '2924%' and
                   ob22='23'        and
                   dazs is null     and
                   rownum<2;
    end;  */

  begin
    tokf;
--  nls9910_ := GetGlobalOption('R9910');
    l_branch := sys_context('bars_context','user_branch');
    begin
      execute immediate 'select branch_attribute_utl.get_attribute_value(
                                p_branch_code    => '''||l_branch||''',
                                p_attribute_code => ''R9910'',
                                p_raise_expt     => 0,
                                p_parent_lookup  => 1,
                                p_check_exist    => 0,
                                p_def_value      => '''')
                         from   dual'
                         into   nls9910_;
    exception when others then
      nls9910_ := GetGlobalOption('R9910');
    end;
    if nls9910_ is null then
      nls9910_ := '99109876543210';
    end if;
--
    /* 04.01.2017: Бух. модель описана в ТЗ, потім була уточнена Возович Л. листом.
                   Спочатку хотіли через 2906 (09 або 16 ОБ22). Після перемовин Сухова Т. і Мережко Ю.
                   зарахування на клієнта стандартним сособом, тобіш без використання 2906 на РУ, а для
                   однообразія тоді і на ГРЦ. Виплата на поховання або Виплата звичайна по коду операції:
                     SSP - Виплата в ГРЦ              (нова)
                     SSB - Виплата на поховання в ГРЦ (нова)
                   --  SSR - Виплата на РУ              (була, змінена віза 43 на 23)
                   --  SS^ - Виплата на поховання на РУ (була, змінена віза 43 на 23)
    */
    nls2906_ := '290642012'; -- Банк в бух моделі вказав цей рахунок
    select a.nms into nms2906_ from accounts a where a.nls = nls2906_;

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_clob);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc,'row');
    for i in 0..dbms_xmldom.getlength(l_rows)-1
    loop
      l_row   := dbms_xmldom.item(l_rows,i);
      id_     := to_number(dbms_xslprocessor.valueof(l_row,'id/text()'));
      ctype_  := to_number(dbms_xslprocessor.valueof(l_row,'ctype/text()'));
      s_      := to_number(dbms_xslprocessor.valueof(l_row,'amount/text()'));
      kv_     := to_number(dbms_xslprocessor.valueof(l_row,'kv/text()'));
      mfo_    := dbms_xslprocessor.valueof(l_row,'mfo/text()');
      nls_    := dbms_xslprocessor.valueof(l_row,'nls/text()');
      ser_    := dbms_xslprocessor.valueof(l_row,'ser/text()');
      docnum_ := dbms_xslprocessor.valueof(l_row,'docnum/text()');
      okpo_   := dbms_xslprocessor.valueof(l_row,'okpo/text()');
      fio_    := dbms_xslprocessor.valueof(l_row,'fio/text()');
      l_compen_oper.extend;
      l_compen_oper(l_compen_oper.last).id := id_;
      --тут потрібно перевірити чи є вже створений документ по реєстру в таблиці crkr_ca_transfer
      begin
        select c.ref_id into l_compen_oper(l_compen_oper.last).ref from crkr_ca_transfer c where c.reg_id = id_;
        exception
          when no_data_found then null;
      end;
      if l_compen_oper(l_compen_oper.last).ref is null then
        begin
          nls9760_ := vkrzn(f_ourmfo,'97600023'||mfo_);
          l_rec_   := '#ф'||ser_||docnum_||'#';
  /*        select okpo into okpo_bank
          from banks_ru where mfo = mfo_;*/
          if    ctype_=1 then
       --     if mfo_ = '300465' then
              l_tts := 'SSP';
       --       get_2924(nls2924_, nms2924_); уже не нужно
       --       else
       --         l_tts := 'SSR';--по СЄП
       --     end if;
           /* уже не нужно
            begin
              --невірно. підібрати після відповіді банку
              select nls,
                     trim(substr(nms,1,38))
              into   nls2906_ru,
                     nms2906_ru
              from   accounts
              where  nls like '2906%' and
                     ob22='16'        and
                     dazs is null     and
                     rownum<2;
            exception when no_data_found then
              null;
            end;*/
            nazn_ := 'W;'||nls_||';'||okpo_||';'||ser_||' '||docnum_||';'||fio_||';';
          elsif ctype_=2 then
       --     if mfo_ = '300465' then
              l_tts := 'SSB';
              --get_2924(nls2924_, nms2924_);
       --       else
       --         l_tts := 'SS^';--по СЄП
       --     end if;
  /*          begin
              --невірно. підібрати після відповіді банку
              select nls,
                     trim(substr(nms,1,38))
              into   nls2906_ru,
                     nms2906_ru
              from   accounts
              where  nls like '2906%' and
                     ob22='09'        and
                     dazs is null     and
                     rownum<2;

            exception when no_data_found then
              null;
            end;*/
            nazn_ := 'W;'||nls_||';'||okpo_||';'||ser_||' '||docnum_||';'||fio_||';'||'На поховання;';
          end if;
          savepoint vi;
          gl.ref(r_oper.REF);
          gl.in_doc3(ref_   => r_oper.REF,
                     tt_    => l_tts     ,
                     vob_   => 6         ,
                     nd_    => r_oper.REF,
                     pdat_  => SYSDATE   ,
                     vdat_  => gl.bdate  ,
                     dk_    => 1         ,
                     kv_    => kv_       ,
                     s_     => s_        ,
                     kv2_   => kv_       ,
                     s2_    => s_        ,
                     sk_    => null      ,
                     data_  => gl.BDATE  ,
                     datp_  => gl.bdate  ,
                     nam_a_ => nms2906_  ,
                     nlsa_  => nls2906_  ,
                     mfoa_  => gl.aMfo   ,
                     nam_b_ => fio_      ,--nms2906_ru,
                     nlsb_  => nls_      ,--nls2906_ru,
                     mfob_  => mfo_      ,
                     nazn_  => nazn_     ,
                     d_rec_ => l_rec_,
                     id_a_  => gl.aOKPO  ,
                     id_b_  => okpo_     ,--okpo_bank ,--gl.aOKPO  ,
                     id_o_  => null      ,
                     sign_  => null      ,
                     sos_   => 1         ,
                     prty_  => null      ,
                     uid_   => NULL);
  /*        вже непотрібно
          paytt(  0, r_oper.REF, gl.bDATE, l_tts, 1, 980, nls2906_, s_, 980, nls2906_ru, s_);
          if l_tts = 'SSP' then
            paytt(  0, r_oper.REF, gl.bDATE, l_tts, 1, 980, nls2906_ru, s_, 980, nls2924_, s_);
          end if;  */

          gl.payv(0, r_oper.REF, gl.bDATE, '086', 1, 980, nls9910_, s_, 980, nls9760_, s_);
          if (mfo_ != '300465') then
              select get_proc_nls('T00',980) into l_grc_nls_t00 from dual;
              gl.payv(0,
                      r_oper.REF,
                      gl.bDATE,
                      l_tts,
                      1,
                      980,
                      nls2906_,
                      s_,
                      980,
                      l_grc_nls_t00,
                      s_);
              --gl.pay( 2,r_oper.REF,gl.bDATE);
          else
            --Тест. Віталік каже що можна так попробувати
            l_transit := bpk_get_transit('1X',nls2906_,nls_,980);
            gl.payv(0,
                      r_oper.REF,
                      gl.bDATE,
                      l_tts,
                      1,
                      980,
                      l_transit,
                      s_,
                      980,
                      nls_,
                      s_);
            --Тест.          
            
            paytt(flg_  => 0,
                  ref_  => r_oper.REF,
                  datv_ => gl.bDATE,
                  tt_   => l_tts,
                  dk0_  => 1,
                  kva_  => 980,
                  nls1_ => nls2906_,
                  sa_   => s_,
                  kvb_  => 980,
                  nls2_ => nls_,
                  sb_   => s_);
          end if;
          /*if ser_ is not null and docnum_ is not null then
            insert
            into   operw (ref,
                          tag,
                          value)
                  values (r_oper.REF,
                          'PASPN'   ,
                          ser_||' '||docnum_);
          end if;*/

/*          if (\*sos_ = 5 and *\mfo_ != '300465') then
            if LENGTH(TRIM(NVL(l_rec_,'')))>0 then
              nazns_ := '11';
            else
              nazns_ := '10';
            end if;

            sep.in_sep(err_,                  -- OUT INTEGER,-- Return code
                       rec_,                  -- OUT INTEGER, -- Record number
                       gl.aMfo,               -- VARCHAR2,  -- Sender's MFOs
                       nls2906_,              -- VARCHAR2,  -- Sender's account number
                       mfo_,                  -- VARCHAR2,  -- Destination MFO
                       nls_,                  -- VARCHAR2,  -- Target account number
                       1,                     -- SMALLINT, -- Debet/Credit code
                       s_,                    -- DECIMAL,  -- Amount
                       6,                     -- SMALLINT, -- Document type
                       r_oper.REF,            -- VARCHAR2, -- Document number
                       980,                   -- SMALLINT, -- Currency code
                       gl.bDATE,              -- DATE,     -- Posting date
                       gl.bDATE,              -- DATE,     -- Document date
                       nms2906_,              -- VARCHAR2, -- Sender's customer name
                       fio_,                  -- VARCHAR2, -- Target customer name
                       nazn_,                 -- VARCHAR2, -- Narrative
                       NULL,                  -- CHAR,     -- Narrative code
                       nazns_,                -- CHAR,     -- Narrative contens type
                       gl.aOKPO,              -- VARCHAR2, -- Sender's customer identifier
                       okpo_,                 -- VARCHAR2, -- Target customer identifier
                       null,                  -- VARCHAR2, -- Teller identifier
                       substr('000000000' || r_oper.REF, -9),--VARCHAR2,-- Sender's reference
                       0,                     --  SMALLINT,    -- BIS number
                       null,                  -- VARCHAR2,    -- Signature
                       NULL,                  -- CHAR,        -- Input file name
                       NULL,                  --- SMALLINT,   -- Input file record number
                       gl.bDATE,              --  DATE,       -- Input file date/time
                       l_rec_,
                       0,                     -- SMALLINT,    -- Processing flag
                       r_oper.REF,            -- INTEGER    DEFAULT NULL, -- PreAssigned Reference
                       0);                    -- SMALLINT   DEFAULT NULL, -- Blocking code

          end if; */
          insert into crkr_ca_transfer(reg_id, ref_id) values(id_, r_oper.REF);--записати що документ вже створений, щоб неможливо було реєстр оплачувати повторно
          commit;
          l_compen_oper(l_compen_oper.last).ref := r_oper.REF;
          l_compen_oper(l_compen_oper.last).err := '';
        exception when others then
          rollback to savepoint vi;
          l_compen_oper(l_compen_oper.last).ref := -1;
          l_compen_oper(l_compen_oper.last).err := sqlerrm;
        end;
      end if;
    end loop;

--  dbms_output.put_line(round( (dbms_utility.get_time-l_start)/100, 2 ) || ' seconds...');--debug
--  dbms_output.put_line('Всього елементів '||l_compen_payments.count||' Перший: '||l_compen_payments(1).id||' на суму '||l_compen_payments(1).amount||' рахунок '||l_compen_payments(1).nls);

    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);
    commit;

--  тут зформувати відповідь xml (l_clob) з колекції l_compen_oper
    dbms_lob.createtemporary(l_clob, true, dbms_lob.call);
--  Create an empty XML document
    l_doc := dbms_xmldom.newdomdocument;
--  Create a root node
    l_root_node := dbms_xmldom.makenode(l_doc);
--  Create a new Supplier Node and add it to the root node
    l_sup_node   := dbms_xmldom.appendchild(l_root_node,
                    dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc,'root')));
    l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                    dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc,'body')));
    for indx in 1..l_compen_oper.count
    loop
      l_supplier_node := dbms_xmldom.appendchild(l_suppp_node,
                                                    dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc, 'row')));

      l_supp_element  := dbms_xmldom.createelement(l_doc,'id');
      l_supp_node     := dbms_xmldom.appendchild(l_supplier_node,
                         dbms_xmldom.makenode(l_supp_element));
      l_supp_text     := dbms_xmldom.createtextnode(l_doc, l_compen_oper(indx).id);
      l_supp_node     := dbms_xmldom.appendchild(l_supp_node,
                         dbms_xmldom.makenode(l_supp_text));

      l_supp_element  := dbms_xmldom.createelement(l_doc,'ref');
      l_supp_node     := dbms_xmldom.appendchild(l_supplier_node,
                         dbms_xmldom.makenode(l_supp_element));
      l_supp_text     := dbms_xmldom.createtextnode(l_doc, l_compen_oper(indx).ref);
      l_supp_node     := dbms_xmldom.appendchild(l_supp_node,
                         dbms_xmldom.makenode(l_supp_text));

      l_supp_element  := dbms_xmldom.createelement(l_doc,'err');
      l_supp_node     := dbms_xmldom.appendchild(l_supplier_node,
                         dbms_xmldom.makenode(l_supp_element));
      l_supp_text     := dbms_xmldom.createtextnode(l_doc, l_compen_oper(indx).err);
      l_supp_node     := dbms_xmldom.appendchild(l_supp_node,
                         dbms_xmldom.makenode(l_supp_text));
    end loop;
    dbms_xmldom.writetoclob(l_doc, l_clob);
    dbms_xmldom.freedocument(l_doc);

    p_clob := l_clob; --відповідь
  end payments_compen_xml;

--

  procedure get_sos_ref (p_clob in out clob)
  is
    l_clob                clob; --відповідь
    type t_compen_oper    is record (ref oper.ref%type,
                                     sos oper.sos%type);
    type t_a_compen_oper  is table of t_compen_oper;
    l_compen_oper         t_a_compen_oper := t_a_compen_oper();

    l_parser              dbms_xmlparser.parser;
    l_doc                 dbms_xmldom.domdocument;
    l_rows                dbms_xmldom.domnodelist;
    l_row                 dbms_xmldom.domnode;

    l_root_node           dbms_xmldom.domnode;
    l_supp_element        dbms_xmldom.domelement;
    l_sup_node            dbms_xmldom.domnode;
    l_supp_node           dbms_xmldom.domnode;
    l_suppp_node          dbms_xmldom.domnode;
    l_supplier_node       dbms_xmldom.domnode;
    l_supp_text           dbms_xmldom.domtext;

    ref_                  oper.ref%type;
    l_sos                 oper.sos%type;
  begin
    tokf;
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_clob);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc,'row');
    for i in 0..dbms_xmldom.getlength(l_rows)-1
    loop
      l_row  := dbms_xmldom.item(l_rows,i);
      ref_   := to_number(dbms_xslprocessor.valueof(l_row,'ref/text()'));
      l_compen_oper.extend;
      l_compen_oper(l_compen_oper.last).ref := ref_;
      begin
        select sos
        into   l_sos
        from   oper
        where  ref=ref_;
        l_compen_oper(l_compen_oper.last).sos := l_sos;
      exception when others then
        l_compen_oper(l_compen_oper.last).sos := -9;
      end;
    end loop;

    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);
    commit;

--  тут зформувати відповідь xml (l_clob) з колекції l_compen_oper
    dbms_lob.createtemporary(l_clob, true, dbms_lob.call);
--  Create an empty XML document
    l_doc := dbms_xmldom.newdomdocument;
--  Create a root node
    l_root_node := dbms_xmldom.makenode(l_doc);
--  Create a new Supplier Node and add it to the root node
    l_sup_node   := dbms_xmldom.appendchild(l_root_node,
                    dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc,'root')));
    l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                    dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc,'body')));
    for indx in 1..l_compen_oper.count
    loop
      l_supplier_node := dbms_xmldom.appendchild(l_suppp_node,
                                                 dbms_xmldom.makenode(dbms_xmldom.createelement(l_doc,'row')));

      l_supp_element  := dbms_xmldom.createelement(l_doc,'ref');
      l_supp_node     := dbms_xmldom.appendchild(l_supplier_node,
                         dbms_xmldom.makenode(l_supp_element));
      l_supp_text     := dbms_xmldom.createtextnode(l_doc, l_compen_oper(indx).ref);
      l_supp_node     := dbms_xmldom.appendchild(l_supp_node,
                         dbms_xmldom.makenode(l_supp_text));

      l_supp_element  := dbms_xmldom.createelement(l_doc,'sos');
      l_supp_node     := dbms_xmldom.appendchild(l_supplier_node,
                         dbms_xmldom.makenode(l_supp_element));
      l_supp_text     := dbms_xmldom.createtextnode(l_doc, l_compen_oper(indx).sos);
      l_supp_node     := dbms_xmldom.appendchild(l_supp_node,
                         dbms_xmldom.makenode(l_supp_text));

    end loop;
    dbms_xmldom.writetoclob(l_doc, l_clob);
    dbms_xmldom.freedocument(l_doc);
    p_clob := l_clob; --відповідь
  end get_sos_ref;

--

  procedure payment_for_actual(
    p_branch_from branch.branch%type,
    p_branch_to   branch.branch%type,
    p_type        varchar2          , --DEP або BUR
    p_s           number            ,
    p_ref     out number
  )
  is
  /*

  Операційна модель роботи ПРИ АКТУАЛІЗАЦІЇ ВКЛАДУ:

     Призначення платежу Опис
    Дт
    Кт 9910/01
    9760/01
     списання сум компенсаційних коштів в окрему картотеку
    Дт
    Кт 9760/23
    9910/01
    У разі здійснення обслуговування клієнта відбувається перенесення вкладу з одного РУ в інше: зарахування сум компенсаційних коштів актуалізованих вкладників

    Дт
    Кт Міжфіліальне обслуговування
    9910/01
    9760/23 (відповідного РУ)
    списання сум компенсаційних коштів
    Дт
    Кт 9760/23 (відповідне РУ)
    9910/01
     зарахування сум компенсаційних коштів актуалізованих вкладників
  */
    l_ref  oper.ref%type;
    l_tt   tts.tt%type := 'АСВ';
--  NLS
    l_nls9910     accounts.nls%type;
    l_nls976001   accounts.nls%type;
    l_nls976023   accounts.nls%type;
    l_nls976023b  accounts.nls%type;
--  NMS
    l_nms9910     accounts.nms%type;
    l_nms976001   accounts.nms%type;
    l_nms976023   accounts.nms%type;
    l_nms976023b  accounts.nms%type;
--  MFO
    l_mfoa    varchar2(6) := substr(p_branch_from,2,6);
    l_mfob    varchar2(6) := substr(p_branch_to,2,6);
    l_branch  varchar2(30);

  begin
--      l_nls9910 := GetGlobalOption('R9910');
        l_branch  := sys_context('bars_context','user_branch');
        begin
          execute immediate 'select branch_attribute_utl.get_attribute_value(
                                    p_branch_code    => '''||l_branch||''',
                                    p_attribute_code => ''R9910'',
                                    p_raise_expt     => 0,
                                    p_parent_lookup  => 1,
                                    p_check_exist    => 0,
                                    p_def_value      => '''')
                             from   dual'
                             into   l_nls9910;
        exception when others then
          l_nls9910 := GetGlobalOption('R9910');
        end;
        if l_nls9910 is null then
          l_nls9910 := '99109876543210';
        end if;
        l_nms9910:='Контрахунок 9910/01';

        begin
            select nls, nms into l_nls976001,l_nms976001 from accounts
                    where nbs='9760' and ob22='01'
                    and kv=980
                    and dazs is null
                    and nls like '%'||l_mfoa
                    and rownum<2;
         exception when no_data_found then
            raise_application_error(-20000, 'Не знайдено рахунок 9760/01 для МФО '||l_mfoa);
        end;

        begin
                    select nls, nms into l_nls976023, l_nms976023 from accounts
                    where nbs='9760' and ob22='23'
                    and kv=980
                    and dazs is null
                    and nls like '%'||l_mfoa
                    and rownum<2;
         exception when no_data_found then
            raise_application_error(-20000, 'Не знайдено рахунок 9760/23 для МФО '||l_mfoa);
        end;

        begin
                    select nls, nms into l_nls976023b, l_nms976023b from accounts
                    where nbs='9760' and ob22='23'
                    and kv=980
                    and dazs is null
                    and nls like '%'||l_mfob
                    and rownum<2;
         exception when no_data_found then
            raise_application_error(-20000, 'Не знайдено рахунок 9760/23 для МФО '||l_mfob);
        end;


    --Робимо запис в опер,а платимо так як треба !!!
    --Дт 9760/01
    --Кт 9750/23

    gl.ref(l_ref);

    gl.in_doc3
         (l_ref,
          l_tt,
          6,
          case when length(l_ref)>10 then substr(l_ref, -10) else l_ref end,
          sysdate,
          gl.bdate,
          1,
          980,
          p_s,
          980 ,
          p_s,
          null ,
          gl.bdate,
          gl.bdate,
          substr(l_nms976001,1,38),
          l_nls976001,
          gl.amfo ,
          substr(l_nms976023,1,38),
          l_nls976023,
          gl.amfo ,
          'Списання сум компенсаційних коштів в окрему картотеку',
          null,
          gl.aOKPO,
          gl.aOKPO,
          null,
          null,
          1,
          null,
          null);

          /*
            Дт9910/01
             Кт 9760/01

          */
          gl.payv(0, l_ref, gl.bdate, l_tt, 1, 980, l_nls9910, p_s, 980, l_nls976001, p_s);
          /*
           Дт 9760/23
           Кт 9910/01
           */
           gl.payv(0, l_ref, gl.bdate, l_tt, 1, 980, l_nls976023, p_s, 980, l_nls9910, p_s);


           --якщо потрібно міжфілійне перекриття, тобто якщо актуалізація іде в іншому МФО
           if(l_mfoa!=l_mfob) then
              /*
                Дт 9910/01
                Кт 9760/23 (відповідного РУ)
               */
                 gl.payv(0, l_ref, gl.bdate, l_tt, 1, 980, l_nls9910, p_s, 980, l_nls976023, p_s);


               /*
                 Дт 9760/23 (відповідне РУ)
                Кт 9910/01
                */
                gl.payv(0, l_ref, gl.bdate, l_tt, 1, 980, l_nls976023b , p_s, 980, l_nls9910, p_s);
           end if;

    begin
      GL.PAY
           (2, l_ref, GL.BDATE);
      --p_ret := l_ref;
    exception when OTHERS then
      --p_err := 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
     raise_application_error(-20000, 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace);
      --p_ret := -3;
      rollback;
      return;
    end;


  p_ref:=l_ref;

  end payment_for_actual;

--

 procedure payment_for_deactual(
  p_branch_from  branch.branch%type,
  p_branch_to    branch.branch%type,
  p_s number                       ,
  p_ref      out number
  )
 is

   l_ref  oper.ref%type;
   l_tt   tts.tt%type := 'АСВ';
-- NLS
   l_nls9910     accounts.nls%type;
   l_nls976001   accounts.nls%type;
   l_nls976023   accounts.nls%type;
   l_nls976023b  accounts.nls%type;
--NMS
   l_nms9910     accounts.nms%type;
   l_nms976001   accounts.nms%type;
   l_nms976023   accounts.nms%type;
   l_nms976023b  accounts.nms%type;
--MFO
   l_mfoa    varchar2(6) := substr(p_branch_from,2,6);
   l_mfob    varchar2(6) := substr(p_branch_to,2,6);
   l_branch  varchar2(30);

  begin
--      l_nls9910 := GetGlobalOption('R9910');
        l_branch  := sys_context('bars_context','user_branch');
        begin
          execute immediate 'select branch_attribute_utl.get_attribute_value(
                                    p_branch_code    => '''||l_branch||''',
                                    p_attribute_code => ''R9910'',
                                    p_raise_expt     => 0,
                                    p_parent_lookup  => 1,
                                    p_check_exist    => 0,
                                    p_def_value      => '''')
                             from   dual'
                             into   l_nls9910;
        exception when others then
          l_nls9910 := GetGlobalOption('R9910');
        end;
        if l_nls9910 is null then
          l_nls9910 := '99109876543210';
        end if;
        l_nms9910:='Контрахунок 9910/01';

        begin
            select nls, nms into l_nls976001,l_nms976001 from accounts
                    where nbs='9760' and ob22='01'
                    and kv=980
                    and dazs is null
                    and nls like '%'||l_mfoa
                    and rownum<2;
         exception when no_data_found then
            raise_application_error(-20000, 'Не знайдено рахунок 9760/01 для МФО '||l_mfoa);
        end;

        begin
                    select nls, nms into l_nls976023, l_nms976023 from accounts
                    where nbs='9760' and ob22='23'
                    and kv=980
                    and dazs is null
                    and nls like '%'||l_mfoa
                    and rownum<2;
         exception when no_data_found then
            raise_application_error(-20000, 'Не знайдено рахунок 9760/23 для МФО '||l_mfoa);
        end;

        begin
                    select nls, nms into l_nls976023b, l_nms976023b from accounts
                    where nbs='9760' and ob22='23'
                    and kv=980
                    and dazs is null
                    and nls like '%'||l_mfob
                    and rownum<2;
         exception when no_data_found then
            raise_application_error(-20000, 'Не знайдено рахунок 9760/23 для МФО '||l_mfob);
        end;


    gl.ref(l_ref);

    gl.in_doc3
         (l_ref,
          l_tt,
          6,
          case when length(l_ref)>10 then substr(l_ref, -10) else l_ref end,
          sysdate,
          gl.bdate,
          0,
          980,
          p_s,
          980 ,
          p_s,
          null ,
          gl.bdate,
          gl.bdate,
          substr(l_nms976001,1,38),
          l_nls976001,
          gl.amfo ,
          substr(l_nms976023,1,38),
          l_nls976023,
          gl.amfo ,
          'Деактуалізація вкладу',
          null,
          gl.aOKPO,
          gl.aOKPO,
          null,
          null,
          1,
          null,
          null);


           if(l_mfoa!=l_mfob) then

                 gl.payv(0, l_ref, gl.bdate, l_tt, 0, 980, l_nls976023b , p_s, 980, l_nls9910, p_s);
                 gl.payv(0, l_ref, gl.bdate, l_tt, 0, 980, l_nls9910, p_s, 980, l_nls976023, p_s);


           end if;


          gl.payv(0, l_ref, gl.bdate, l_tt, 0, 980, l_nls976023, p_s, 980, l_nls9910, p_s);
          gl.payv(0, l_ref, gl.bdate, l_tt, 0, 980, l_nls9910, p_s, 980, l_nls976001, p_s);

        begin
            GL.PAY
                 (2, l_ref, GL.BDATE);
            --p_ret := l_ref;
        exception when OTHERS then
            --p_err := 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace;
           raise_application_error(-20000, 'ЦА-ГРЦ, '||sqlerrm||' - '||dbms_utility.format_error_backtrace);
            --p_ret := -3;
            rollback;
            return;
        end;


           p_ref:=l_ref;


  end payment_for_deactual;

--

  function header_version return varchar2
  is
  begin
    return 'Package header ca_compen '||version_header;
  end header_version;

--

  function body_version return varchar2
  is
  begin
    return 'Package body ca_compen '||version_body;
  end body_version;

end ca_compen;
/
GRANT execute ON ca_compen TO BARS_ACCESS_DEFROLE;