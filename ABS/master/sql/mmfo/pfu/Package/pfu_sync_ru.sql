
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/PFU/package/pfu_sync_ru.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE PFU_SYNC_RU is

  -- Author  : IVAN.GALISEVYCH
  -- Created : 25.05.2016 12:06:45
  -- old name: pfu_sync_ru

  g_header_version constant varchar2(64) := 'version 1.00 25/05/2016';

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2;
  -- body_version - возвращает версию тела пакета
  function body_version return varchar2;

  -- Public type declarations
  --type <TypeName> is <Datatype>;

  -- Public constant declarations
  --<ConstantName> constant <Datatype> := <Value>;

  -- Public variable declarations
  --<VariableName> <Datatype>;

  function get_packsize return pls_integer;

  procedure save_pensioner_data(p_kf           in pfu_pensioner.kf%type,
                                p_branch       in pfu_pensioner.branch%type,
                                p_rnk          in pfu_pensioner.rnk%type,
                                p_nmk          in pfu_pensioner.nmk%type,
                                p_okpo         in pfu_pensioner.okpo%type,
                                p_adr          in pfu_pensioner.adr%type,
                                p_date_on      in pfu_pensioner.date_on%type,
                                p_date_off     in pfu_pensioner.date_off%type,
                                p_passp        in pfu_pensioner.passp%type,
                                p_ser          in pfu_pensioner.ser%type,
                                p_numdoc       in pfu_pensioner.numdoc%type,
                                p_pdate        in pfu_pensioner.pdate%type,
                                p_organ        in pfu_pensioner.organ%type,
                                p_bday         in pfu_pensioner.bday%type,
                                p_bplace       in pfu_pensioner.bplace%type,
                                p_cellphone    in pfu_pensioner.cellphone%type,
                                p_last_idupd   in pfu_pensioner.last_ru_idupd%type,
                                p_last_chgdate in pfu_pensioner.last_ru_chgdate%type,
                                p_res          out integer);

  procedure save_pensacc_data(p_kf           in pfu_pensacc.kf%type,
                              p_branch       in pfu_pensacc.branch%type,
                              p_rnk          in pfu_pensacc.rnk%type,
                              p_acc          in pfu_pensacc.acc%type,
                              p_nls          in pfu_pensacc.nls%type,
                              p_kv           in pfu_pensacc.kv%type,
                              p_ob22         in pfu_pensacc.ob22%type,
                              p_daos         in pfu_pensacc.daos%type,
                              p_dapp         in pfu_pensacc.dapp%type,
                              p_dazs         in pfu_pensacc.dazs%type,
                              p_last_idupd   in pfu_pensacc.last_ru_idupd%type,
                              p_last_chgdate in pfu_pensacc.last_ru_chgdate%type,
                              p_res          out integer);

  procedure save_pensacc_pack(p_pensacc_tab in bars.t_pfu_pensacc,
                              p_objid_tab   out bars.t_pfu_obj_id);

  procedure save_pensioner_pack(p_pensioner_tab in bars.t_pfu_pensioner,
                                p_objid_tab     out bars.t_pfu_obj_id);

  function save_pensioner_pack(p_pensioner_tab in bars.t_pfu_pensioner)
    return bars.t_pfu_obj_id;

  procedure set_pensioner_state_blocked(p_id   in pfu_pensioner.id%type,
                                        p_comm in pfu_pensioner.comm%type,
                                        p_block_type in pfu_pensioner.block_type%type);

  procedure set_filerec_state_blocked(p_id   in pfu_file_records.id%type,
                                      p_comm in pfu_file_records.err_mess_trace%type,
                                      p_block_type in pfu_file_records.state%type);

  procedure start_protocol(p_mfo           in pfu_syncru_protocol.kf%type,
                           p_url           in pfu_syncru_protocol.url%type,
                           p_transfer_type in pfu_syncru_protocol.transfer_type%type,
                           p_id            in out pfu_syncru_protocol.id%type);

  procedure stop_protocol(p_id            in pfu_syncru_protocol.id%type,
                          p_transfer_rows in pfu_syncru_protocol.transfer_rows%type);

  procedure error_protocol(p_id   in pfu_syncru_protocol.id%type,
                           p_comm in pfu_syncru_protocol.comm%type);

end pfu_sync_ru;
/
CREATE OR REPLACE PACKAGE BODY PFU_SYNC_RU is

  -- Версія пакету
  g_body_version constant varchar2(64) := 'version 1.00 25/05/2016';
  g_dbgcode      constant varchar2(20) := 'pfu_sync_ru';

  -- Private type declarations
  --type <TypeName> is <Datatype>;

  -- Private constant declarations
  PAR_SYNC_PACKSIZE_NAME   constant varchar2(20) := 'SYNC_PACKSIZE';
  PAR_SYNC_PACKSIZE_DEFVAL constant pls_integer := 1000;

  -- Private variable declarations
  --<VariableName> <Datatype>;

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header ' || g_dbgcode || ' ' || g_header_version || '.';
  end header_version;
  -- body_version - возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body ' || g_dbgcode || ' ' || g_body_version || '.';
  end body_version;

  function get_packsize return pls_integer is
    l_packsize pls_integer;
  begin
    begin
      l_packsize := to_number(pfu_utl.get_parameter(PAR_SYNC_PACKSIZE_NAME));
      if l_packsize is null then
        l_packsize := PAR_SYNC_PACKSIZE_DEFVAL;
      end if;
    exception
      when others then
        l_packsize := PAR_SYNC_PACKSIZE_DEFVAL;
    end;
    return l_packsize;
  end get_packsize;

  -- sync pensioner data (insert or update) into pfu_pensioner
  procedure save_pensioner_data(p_kf           in pfu_pensioner.kf%type,
                                p_branch       in pfu_pensioner.branch%type,
                                p_rnk          in pfu_pensioner.rnk%type,
                                p_nmk          in pfu_pensioner.nmk%type,
                                p_okpo         in pfu_pensioner.okpo%type,
                                p_adr          in pfu_pensioner.adr%type,
                                p_date_on      in pfu_pensioner.date_on%type,
                                p_date_off     in pfu_pensioner.date_off%type,
                                p_passp        in pfu_pensioner.passp%type,
                                p_ser          in pfu_pensioner.ser%type,
                                p_numdoc       in pfu_pensioner.numdoc%type,
                                p_pdate        in pfu_pensioner.pdate%type,
                                p_organ        in pfu_pensioner.organ%type,
                                p_bday         in pfu_pensioner.bday%type,
                                p_bplace       in pfu_pensioner.bplace%type,
                                p_cellphone    in pfu_pensioner.cellphone%type,
                                p_last_idupd   in pfu_pensioner.last_ru_idupd%type,
                                p_last_chgdate in pfu_pensioner.last_ru_chgdate%type,
                                p_res          out integer) is

    l_dummy  number;
    l_errmsg varchar2(512);
    l_th constant varchar2(100) := g_dbgcode || '.save_pensioner_data';
  begin

    savepoint sp;

    -- lock row for update
    select 1
      into l_dummy
      from pfu_pensioner pp
     where pp.kf = p_kf
       and pp.rnk = p_rnk
       for update nowait;

      update pfu_pensioner pp
         set branch          = p_branch,
             nmk             = p_nmk,
             okpo            = p_okpo,
             adr             = p_adr,
             date_on         = p_date_on,
             date_off        = p_date_off,
             passp           = p_passp,
             ser             = p_ser,
             numdoc          = p_numdoc,
             pdate           = p_pdate,
             organ           = p_organ,
             bday            = p_bday,
             bplace          = p_bplace,
             cellphone       = p_cellphone,
             sys_time        = sysdate,
             is_okpo_well    = case to_char(bars.get_bday_byokpo(p_okpo), 'dd.mm.yyyy') when to_char(p_bday,'dd.mm.yyyy')
                                    then 1
                                    else 0 end,
             last_ru_idupd   = p_last_idupd,
             last_ru_chgdate = p_last_chgdate
       where pp.kf = p_kf
         and pp.rnk = p_rnk;

      p_res := 2;

  exception
    -- acc for update not found, inserting...
    when NO_DATA_FOUND then
      insert into pfu_pensioner
        (id,
         kf,
         branch,
         rnk,
         nmk,
         okpo,
         adr,
         date_on,
         date_off,
         passp,
         ser,
         numdoc,
         pdate,
         organ,
         bday,
         bplace,
         cellphone,
         sys_time,
         is_okpo_well,
         last_ru_idupd,
         last_ru_chgdate)
      values
        (s_pfupens.nextval,
         p_kf,
         p_branch,
         p_rnk,
         p_nmk,
         p_okpo,
         p_adr,
         p_date_on,
         p_date_off,
         p_passp,
         p_ser,
         p_numdoc,
         p_pdate,
         p_organ,
         p_bday,
         p_bplace,
         p_cellphone,
         sysdate,
         case to_char(bars.get_bday_byokpo(p_okpo), 'dd.mm.yyyy')
            when to_char(p_bday,'dd.mm.yyyy')
            then 1
            else 0 end,
         p_last_idupd,
         p_last_chgdate);

      p_res := 2;

    -- error
    when OTHERS then

      p_res := 0;

      l_errmsg := substr(l_th || ' Error: ' ||
                         dbms_utility.format_error_stack() || chr(10) ||
                         dbms_utility.format_error_backtrace(),
                         1,
                         512);
      --bars_audit.error(l_errmsg);
      --logger.info(l_errmsg);
      logger (sysdate,l_errmsg);
      rollback to sp;
      --raise;

  end save_pensioner_data;

  -- sync pensacc data (insert or update) into pfu_pensacc
  procedure save_pensacc_data(p_kf           in pfu_pensacc.kf%type,
                              p_branch       in pfu_pensacc.branch%type,
                              p_rnk          in pfu_pensacc.rnk%type,
                              p_acc          in pfu_pensacc.acc%type,
                              p_nls          in pfu_pensacc.nls%type,
                              p_kv           in pfu_pensacc.kv%type,
                              p_ob22         in pfu_pensacc.ob22%type,
                              p_daos         in pfu_pensacc.daos%type,
                              p_dapp         in pfu_pensacc.dapp%type,
                              p_dazs         in pfu_pensacc.dazs%type,
                              p_last_idupd   in pfu_pensacc.last_ru_idupd%type,
                              p_last_chgdate in pfu_pensacc.last_ru_chgdate%type,
                              p_res          out integer) is

    l_dummy  number;
    l_errmsg varchar2(512);
    l_th constant varchar2(100) := g_dbgcode || '.save_pensacc_data';
  begin

    savepoint sp;

    -- lock row for update
    select 1
      into l_dummy
      from pfu_pensacc pa
     where pa.kf = p_kf
           and (pa.nls = p_nls or pa.nlsalt = p_nls) -- COBUMMFO-7501
       for update nowait;

    update pfu_pensacc pa
       set branch          = p_branch,
           rnk             = p_rnk,
           acc             = p_acc,
           kv              = p_kv,
           ob22            = p_ob22,
           daos            = p_daos,
           dapp            = p_dapp,
           dazs            = p_dazs,
           sys_time        = sysdate,
           last_ru_idupd   = p_last_idupd,
           last_ru_chgdate = p_last_chgdate
     where pa.kf = p_kf
           and (pa.nls = p_nls or pa.nlsalt = p_nls); -- COBUMMFO-7501

    p_res := 2;

  exception
    -- acc for update not found, inserting...
    when NO_DATA_FOUND then
      insert into pfu_pensacc
        (id,
         kf,
         branch,
         rnk,
         acc,
         nls,
         kv,
         ob22,
         daos,
         dapp,
         dazs,
         sys_time,
         last_ru_idupd,
         last_ru_chgdate,
         ispayed)
      values
        (s_pfupensacc.nextval,
         p_kf,
         p_branch,
         p_rnk,
         p_acc,
         p_nls,
         p_kv,
         p_ob22,
         p_daos,
         p_dapp,
         p_dazs,
         sysdate,
         p_last_idupd,
         p_last_chgdate,
         null);

      p_res := 2;

    -- error
    when OTHERS then

      p_res := 0;

      l_errmsg := substr(l_th || ' Error: ' ||
                         dbms_utility.format_error_stack() || chr(10) ||
                         dbms_utility.format_error_backtrace(),
                         1,
                         512);
      --bars_audit.error(l_errmsg);
      rollback to sp;
      --raise;

  end save_pensacc_data;

  procedure save_pensacc_pack(p_pensacc_tab in bars.t_pfu_pensacc,
                              p_objid_tab   out bars.t_pfu_obj_id) is
    l_res pls_integer;
  begin
    p_objid_tab := bars.t_pfu_obj_id();

    for c0 in (select * from table(p_pensacc_tab)) loop
      save_pensacc_data(p_kf           => c0.kf,
                        p_branch       => c0.branch,
                        p_rnk          => c0.rnk,
                        p_acc          => c0.acc,
                        p_nls          => c0.nls,
                        p_kv           => c0.kv,
                        p_ob22         => c0.ob22,
                        p_daos         => c0.daos,
                        p_dapp         => c0.dapp,
                        p_dazs         => c0.dazs,
                        p_last_idupd   => c0.last_idupd,
                        p_last_chgdate => c0.last_chgdate,
                        p_res          => l_res);

      p_objid_tab.extend;
      --p_objid_tab(p_objid_tab.last).obj_id := c0.acc;
      --p_objid_tab(p_objid_tab.last).res := l_res;
      p_objid_tab(p_objid_tab.last) := bars.r_pfu_obj_id(c0.acc, l_res);

    end loop;

  end save_pensacc_pack;

  procedure save_pensioner_pack(p_pensioner_tab in bars.t_pfu_pensioner,
                                p_objid_tab     out bars.t_pfu_obj_id) is
    l_res pls_integer;
  begin
    p_objid_tab := bars.t_pfu_obj_id();

    for c0 in (select * from table(p_pensioner_tab)) loop
      save_pensioner_data(p_kf           => c0.kf,
                          p_branch       => c0.branch,
                          p_rnk          => c0.rnk,
                          p_nmk          => c0.nmk,
                          p_okpo         => c0.okpo,
                          p_adr          => c0.adr,
                          p_date_on      => c0.date_on,
                          p_date_off     => c0.date_off,
                          p_passp        => c0.passp,
                          p_ser          => c0.ser,
                          p_numdoc       => c0.numdoc,
                          p_pdate        => c0.pdate,
                          p_organ        => c0.organ,
                          p_bday         => c0.bday,
                          p_bplace       => c0.bplace,
                          p_cellphone    => c0.cellphone,
                          p_last_idupd   => c0.last_idupd,
                          p_last_chgdate => c0.last_chgdate,
                          p_res          => l_res);

      p_objid_tab.extend;
      p_objid_tab(p_objid_tab.last) := bars.r_pfu_obj_id(c0.rnk, l_res);

    end loop;

  end save_pensioner_pack;

  function save_pensioner_pack(p_pensioner_tab in bars.t_pfu_pensioner)
    return bars.t_pfu_obj_id is
    l_res       pls_integer;
    l_objid_tab bars.t_pfu_obj_id;
  begin
    l_objid_tab := bars.t_pfu_obj_id();

    for c0 in (select * from table(p_pensioner_tab)) loop
      save_pensioner_data(p_kf           => c0.kf,
                          p_branch       => c0.branch,
                          p_rnk          => c0.rnk,
                          p_nmk          => c0.nmk,
                          p_okpo         => c0.okpo,
                          p_adr          => c0.adr,
                          p_date_on      => c0.date_on,
                          p_date_off     => c0.date_off,
                          p_passp        => c0.passp,
                          p_ser          => c0.ser,
                          p_numdoc       => c0.numdoc,
                          p_pdate        => c0.pdate,
                          p_organ        => c0.organ,
                          p_bday         => c0.bday,
                          p_bplace       => c0.bplace,
                          p_cellphone    => c0.cellphone,
                          p_last_idupd   => c0.last_idupd,
                          p_last_chgdate => c0.last_chgdate,
                          p_res          => l_res);

      l_objid_tab.extend;
      l_objid_tab(l_objid_tab.last) := bars.r_pfu_obj_id(c0.rnk, l_res);

    end loop;

    return l_objid_tab;

  end save_pensioner_pack;

  procedure set_pensioner_state(p_id    in pfu_pensioner.id%type,
                                p_state in pfu_pensioner.state%type,
                                p_comm  in pfu_pensioner.comm%type) is

  begin
    update pfu_pensioner p
       set state = p_state, comm = p_comm
     where id = p_id;
  end;

  procedure set_pensioner_state_blocked(p_id   in pfu_pensioner.id%type,
                                        p_comm in pfu_pensioner.comm%type,
                                        p_block_type in pfu_pensioner.block_type%type) is
  begin
    update pfu_pensioner pp
       set pp.block_type = p_block_type,
           pp.comm       = p_comm,
           pp.block_date = sysdate
     where pp.id = p_id;
     commit;
  end;

  procedure set_filerec_state_blocked(p_id   in pfu_file_records.id%type,
                                      p_comm in pfu_file_records.err_mess_trace%type,
                                      p_block_type in pfu_file_records.state%type) is
  begin
    update pfu_file_records fr
       set fr.state = case p_block_type when 4 then 14
                                        when 5 then 15
                                        when 6 then 16
                                        else 0 end,
           fr.err_mess_trace = p_comm
     where fr.id = p_id;
     commit;
  end;

  procedure write_protocol(p_mfo                 in pfu_syncru_protocol.kf%type,
                           p_url                 in pfu_syncru_protocol.url%type,
                           p_transfer_type       in pfu_syncru_protocol.transfer_type%type,
                           p_transfer_date_start in pfu_syncru_protocol.transfer_date_start%type,
                           p_transfer_date_end   in pfu_syncru_protocol.transfer_date_end%type,
                           p_transfer_rows       in pfu_syncru_protocol.transfer_rows%type,
                           p_transfer_result     in pfu_syncru_protocol.transfer_result%type,
                           p_comm                in pfu_syncru_protocol.comm%type,
                           p_id                  in out pfu_syncru_protocol.id%type) is
    l_th constant varchar2(100) := g_dbgcode || '.write_protocol ';
    l_id pfu_syncru_protocol.id%type;

  begin
    --bars_audit.trace(l_th || ': entry point');
    if p_id is null then
      insert into pfu_syncru_protocol
        (id,
         kf,
         url,
         transfer_type,
         transfer_date_start,
         transfer_date_end,
         transfer_rows,
         transfer_result,
         comm)
      values
        (s_pfu_syncruprotocol.nextval,
         p_mfo,
         p_url,
         p_transfer_type,
         p_transfer_date_start,
         p_transfer_date_end,
         p_transfer_rows,
         p_transfer_result,
         p_comm)
      returning id into l_id;
      p_id := l_id;

    else
      update pfu_syncru_protocol
         set transfer_date_end = p_transfer_date_end,
             transfer_rows     = p_transfer_rows,
             transfer_result   = p_transfer_result,
             comm              = p_comm
       where id = p_id;
    end if;

    --bars_audit.trace('%s: user: %s, kf=%s, branch=%s create req=%s', l_th, p_crt_staff, to_char(p_mfo), p_branch, to_char(l_req_id));

    --bars_audit.trace(l_th || ': done');

  end write_protocol;

  procedure start_protocol(p_mfo           in pfu_syncru_protocol.kf%type,
                           p_url           in pfu_syncru_protocol.url%type,
                           p_transfer_type in pfu_syncru_protocol.transfer_type%type,
                           p_id            in out pfu_syncru_protocol.id%type) is
  begin
    write_protocol(p_mfo                 => p_mfo,
                   p_url                 => p_url,
                   p_transfer_type       => p_transfer_type,
                   p_transfer_date_start => sysdate,
                   p_transfer_date_end   => null,
                   p_transfer_rows       => null,
                   p_transfer_result     => 'INPROCESS',
                   p_comm                => null,
                   p_id                  => p_id);
  end;

  procedure stop_protocol(p_id            in pfu_syncru_protocol.id%type,
                          p_transfer_rows in pfu_syncru_protocol.transfer_rows%type) is
    l_id pfu_syncru_protocol.id%type;
  begin
    l_id := p_id;
    write_protocol(p_mfo                 => null,
                   p_url                 => null,
                   p_transfer_type       => null,
                   p_transfer_date_start => null,
                   p_transfer_date_end   => sysdate,
                   p_transfer_rows       => p_transfer_rows,
                   p_transfer_result     => 'SUCCESS',
                   p_comm                => null,
                   p_id                  => l_id);
  end;

  procedure error_protocol(p_id   in pfu_syncru_protocol.id%type,
                           p_comm in pfu_syncru_protocol.comm%type) is
    l_id pfu_syncru_protocol.id%type;
  begin
    l_id := p_id;
    write_protocol(p_mfo                 => null,
                   p_url                 => null,
                   p_transfer_type       => null,
                   p_transfer_date_start => null,
                   p_transfer_date_end   => sysdate,
                   p_transfer_rows       => null,
                   p_transfer_result     => 'ERROR',
                   p_comm                => p_comm,
                   p_id                  => l_id);

  end;

begin
  -- Initialization
  null;
end pfu_sync_ru;
/

 show err;
 
PROMPT *** Create  grants  PFU_SYNC_RU ***
grant EXECUTE                                                                on PFU_SYNC_RU     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/PFU/package/pfu_sync_ru.sql =========*** End *** 
 PROMPT ===================================================================================== 
 