prompt package xrm_intg_card

create or replace package xrm_intg_card
is
/*
created by lypskykh 28-JAN-2019
���������� � XRM (���. - WAY4) � ����� ��������� ������
*/

g_version constant varchar2(150) := 'version 1.0  09.04.2019';

g_status_notfound   constant number(1) := -1;
g_status_new        constant number(1) := 0;
g_status_ready      constant number(1) := 1;
g_status_too_many   constant number(1) := -2;

--
-- ��������� ������ ������
--
function version return varchar2;

--
-- ���������� ����� ������ � ������ � ������� �������� ������ ������
--
procedure w4_imp_acc_add_partition (p_exp_id in w4_imp_acc_to_close.exp_id%type);             -- ����� ��������

--
-- ������ ������ ��� ��������, ��������� �� Way4, � ������� � ��� - �������� �� ���������, ����������� ��������
--
procedure check_accounts_to_close (p_exp_id in w4_imp_acc_to_close.exp_id%type default null); -- ����� ��������

end xrm_intg_card;
/
Show errors;

create or replace package body xrm_intg_card
is

g_trace constant varchar2(150) := 'XRM_INTG_CARD';

--
-- ��������� ������ ������
--
function version return varchar2
    is
begin
    return g_version;
end version;

--
-- ��������, ��� �� ��������� ����� ������ (���� �� - ������� ������)
--
procedure check_if_export_processed (p_exp_id in w4_imp_acc_to_close.exp_id%type, -- ����� ��������
                                     p_trace  in varchar2)                        -- ������ ��� ������ �����
    is
    l_prev_check_date w4_imp_acc_to_close_export.check_date%type;
    l_err_message       varchar2(1024);
begin
    -- ���������, ��� �� ��� ��������� ���� ����� ������
    select check_date into l_prev_check_date from w4_imp_acc_to_close_export where exp_id = p_exp_id;
    if l_prev_check_date is not null then
        -- ��� - ������� ������
        l_err_message := '������� ������ � ��� ������������ ������� [P_'||p_exp_id||'], ���� ��������: '||to_char(l_prev_check_date, 'dd.mm.yyyy hh24:mi:ss');
        bars_audit.fatal(p_trace||l_err_message);
        raise_application_error (-20000, l_err_message);
    end if;
exception
    when no_data_found then null;
end check_if_export_processed;

--
-- ���������� ����� ������ � ������ � ������� �������� ������ ������
--
procedure w4_imp_acc_add_partition (p_exp_id in w4_imp_acc_to_close.exp_id%type) -- ����� ��������
    is
    l_trace             varchar2(128) := g_trace || '.'||'w4_imp_acc_add_partition: ';
    already_exists      exception;
    pragma exception_init (already_exists, -6512);
begin
    -- ���������� ��� ������� - ��������� ������, ��������� ������ ��� ��������
    execute immediate 'alter table w4_imp_acc_to_close add partition p_'||p_exp_id||' values ('''||p_exp_id||''')';
    insert into w4_imp_acc_to_close_export (exp_id)
    values (p_exp_id);
exception
    when already_exists or dup_val_on_index then
        -- ������ ����������
        bars_audit.warning(l_trace||'������ P_'||p_exp_id||' ��� ����������, ��������� ���������');
        -- ���������, ��� �� ��� ��������� ���� ����� ������
        check_if_export_processed(p_exp_id, l_trace);
        -- �� ��� - ������� ����� ������
        execute immediate 'alter table w4_imp_acc_to_close truncate partition p_'||p_exp_id;
    when others then
        bars_audit.fatal(l_trace||dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace);
        raise;
end w4_imp_acc_add_partition;

--
-- ������ ������ ��� ��������, ��������� �� Way4, � ������� � ��� - �������� �� ���������, ����������� ��������
--
procedure check_accounts_to_close (p_exp_id w4_imp_acc_to_close.exp_id%type default null) -- ����� ��������
    is
    l_userid             number                                    := user_id;
    l_ourmfo             varchar2(6)                               := sys_context('bars_context', 'user_mfo');
    l_trace              varchar2(128)                             := g_trace || '.'||'check_accounts_to_close: ';
    l_exp_id             w4_imp_acc_to_close.exp_id%type           := p_exp_id;
    l_rows_checked       w4_imp_acc_to_close_export.checked_rows%type := 0;
    l_blocked_cnt        w4_imp_acc_to_close_export.blocked_rows%type := 0;
    c_reason_for_closure constant accountsw.value%type             := '����� ��������� �������� �886 �� 28.12.2018';
    c_blk                constant rang.rang%type                   := 13; -- ������������, �� ��������, �� ������� �����
    c_rows_to_commit     constant number                           := 1000;
begin
    bars_login.login_user(sys_guid, 1, null, null); -- ����� ����������� �������������
    bars_audit.info(l_trace||'�����'||case when p_exp_id is not null then '[exp_id='||p_exp_id||']' else '' end);
    if p_exp_id is null then
        -- ���������� ������ �������� - �������� ������������
        select max(exp_id) into l_exp_id
        from w4_imp_acc_to_close_export;
        bars_audit.info(l_trace||'����� ����� �� '||case when l_exp_id is not null then '[exp_id='||l_exp_id||']' else '' end);
    end if;
    -- ���������, ��� �� ��� ��������� ���� ����� ������
    check_if_export_processed(p_exp_id, l_trace);
    
    for mfo in (select m.kf from mv_kf m where m.kf = nvl(l_ourmfo, m.kf))
    loop
        bc.go(mfo.kf);    
        for rec in (select w.* from w4_imp_acc_to_close w where exp_id = l_exp_id and kf = mfo.kf)
        loop
            declare
            l_accR              accounts%rowtype;
            l_w4_acc_related    number_list;
            l_ost_linked        number;
            l_ost_overral       number;
            l_dpt_binding_flag  number(1);
            l_counter           number := 1;
            l_ready_to_transfer number(1) := g_status_new;
            l_row_to_close      accounts%rowtype;
            begin
                bars_audit.trace(l_trace||'���� ['||rec.kf||'-'||rec.nls||'('||rec.kv||')]');
                select * into l_accR from accounts a where a.kf = rec.kf and (a.nls = rec.nls or a.nlsalt = rec.nls) and a.kv = rec.kv;
                -- ����� acc ��������� ������
                select atr_value bulk collect into l_w4_acc_related
                from w4_acc unpivot(atr_value for attribute_name in(acc_9129i,
                                                                     acc_2203,
                                                                     acc_2628,
                                                                     acc_2625d,
                                                                     acc_2627x,
                                                                     acc_2625x,
                                                                     acc_2209,
                                                                     acc_3579,
                                                                     acc_2207,
                                                                     acc_2627,
                                                                     acc_2208,
                                                                     acc_3570,
                                                                     acc_9129,
                                                                     acc_ovr))
                where acc_pk = l_accR.acc;
                -- ����� �������� �� ��������� ������:
                -- �����
                select nvl(sum(case when ostc = 0 then abs(ostb) else abs(ostc) end), 0) into l_ost_linked
                from accounts a
                where a.acc in (select column_value from table(l_w4_acc_related)) and a.kf = mfo.kf;
                bars_audit.trace(l_trace||'����� ����� �������� �� ����. ������ l_ost_linked = '||l_ost_linked);
                -- ��������� (������ �����������)
                if abs(l_ost_linked) > 0 then
                    insert into w4_imp_acc_to_close_param (exp_id,
                                                           main_acc,
                                                           tag,
                                                           val)
                    select l_exp_id, l_accR.acc, l_accR.nls||'/'||a.nls, greatest(abs(a.ostc), abs(a.ostb))
                    from table(l_w4_acc_related) t
                    join accounts a on t.column_value = a.acc and a.kf = mfo.kf
                    where a.ostb != 0 or a.ostc != 0;
                end if;
                -- �����������: ������� ��������� �����
                if l_accR.ostc != 0 or l_accR.ostb != 0 then
                    bars_audit.trace(l_trace||'��������� ������� ��������� �����, ostc/ostb = ['||l_accR.ostc||'/'||l_accR.ostb||']');
                    insert into w4_imp_acc_to_close_param (exp_id, main_acc, tag, val)
                    values (l_exp_id, l_accR.acc, l_accR.nls, greatest(abs(l_accR.ostc), abs(l_accR.ostb)));
                end if;
                -- �����������: ����������
                if l_accR.blkk > 0 and l_accR.blkk != c_blk then
                    bars_audit.trace(l_trace||'���������� �� ������� blkk = '||l_accR.blkk);
                    insert into w4_imp_acc_to_close_param (exp_id, main_acc, tag, val)
                    values (l_exp_id, l_accR.acc, l_accR.nls, l_accR.blkk);
                end if;
                if l_accR.blkd > 0 and l_accR.blkd != c_blk then
                    bars_audit.trace(l_trace||'���������� �� ������ blkd = '||l_accR.blkd);
                    insert into w4_imp_acc_to_close_param (exp_id, main_acc, tag, val)
                    values (l_exp_id, l_accR.acc, l_accR.nls, l_accR.blkd);
                end if;
                -- �����������: ���� �������� �� ����� �� ��������� ��� ����
                if l_accR.dapp >= add_months( gl.bd, -12*3 ) then
                    bars_audit.trace(l_trace||'���� ���������� �������� = '||to_char(l_accR.dapp, 'dd.mm.yyyy'));
                    insert into w4_imp_acc_to_close_param (exp_id, main_acc, tag, val)
                    values (l_exp_id, l_accR.acc, l_accR.nls, l_accR.dapp);
                end if;
                -- ������� ��������� ����� (�����)
                l_ost_overral := l_ost_linked + case when l_accR.ostc != 0 then abs(l_accR.ostc) else abs(l_accR.ostb) end;
                bars_audit.trace(l_trace||'����� ������� ��������� ����� = '||l_ost_overral);
                -- �������� � ��������
                select case when exists (select 1
                                         from dpt_deposit d
                                         where d.kf = l_accR.kf and d.acc_d = l_accR.acc)
                                 then 1
                                 else 0 end
                into l_dpt_binding_flag
                from dual;
                bars_audit.trace(l_trace||'�������� � �������� = '||l_dpt_binding_flag);
                -- �������, ��������� � ���������� ��������
                begin
                    select counter + 1 into l_counter
                    from w4_imp_acc_to_close w
                    where w.exp_id = l_exp_id - 1
                    and w.nls = rec.nls
                    and w.kv = rec.kv
                    and w.kf = rec.kf;
                exception
                    when no_data_found then null;
                end;
                bars_audit.trace(l_trace||'������� = '||l_counter);
                
                if l_ost_overral = 0 
                    and greatest(case when l_accR.blkk = c_blk then 0 else l_accR.blkk end, 
                                 case when l_accR.blkd = c_blk then 0 else l_accR.blkd end) = 0 
                    and nvl(l_accR.dapp, l_accR.daos) < add_months(gl.bd, -12*3) 
                    and l_dpt_binding_flag = 0 then	
                    /* ��������� �������� */
                    bars_audit.trace(l_trace||'��������� �������� = '||l_ready_to_transfer);
                    l_ready_to_transfer := g_status_ready;
                    if l_accR.dazs is null then
                        /* �������������� � �������� */
                        /* �������� ���� + ��������� */
                        for rec in (select l_accR.acc as acc from dual
                                    union all
                                    select column_value as acc from table(l_w4_acc_related))
                        loop
                            select * into l_row_to_close from accounts a where a.acc = rec.acc and a.kf = mfo.kf;
                            if l_row_to_close.dazs is null then
                                bars_audit.trace(l_trace||'�������������� � �������� ���� acc = '||rec.acc);
                                accreg.CHG_ACC_ATTR(p_acc    => l_row_to_close.acc,
                                                    p_nms    => l_row_to_close.nms,
                                                    p_isp    => l_row_to_close.isp,
                                                    p_nlsalt => l_row_to_close.nlsalt,
                                                    p_pap    => l_row_to_close.pap,
                                                    p_tip    => l_row_to_close.tip,
                                                    p_pos    => l_row_to_close.pos,
                                                    p_vid    => l_row_to_close.vid,
                                                    p_branch => l_row_to_close.branch,
                                                    p_lim    => l_row_to_close.lim,
                                                    p_ostx   => l_row_to_close.ostx,
                                                    p_blkd   => c_blk,
                                                    p_blkk   => c_blk,
                                                    p_grp    => l_row_to_close.grp);
                                accreg.setAccountwParam(l_row_to_close.acc, 'RCLOS', c_reason_for_closure);
                            end if;
                        end loop;
                    end if;
                else
                    /* ��������� � ��������������� */
                    l_blocked_cnt := l_blocked_cnt + 1;
                end if;
                /* ���������� ���������� ������ */
                update w4_imp_acc_to_close
                set dazs = l_accR.dazs,
                    rnk = l_accR.rnk,
                    branch = l_accR.branch,
                    ost = case when l_ost_overral = 0 then null else l_ost_overral end,
                    blk = case when greatest(case when l_accR.blkk = c_blk then 0 else l_accR.blkk end, 
                                             case when l_accR.blkd = c_blk then 0 else l_accR.blkd end) > 0 
                               then greatest(l_accR.blkd, l_accR.blkk) else null end,
                    dpt_binding = l_dpt_binding_flag,
                    counter = l_counter,
                    dapp = case when l_accR.dapp >= add_months(gl.bd, -12*3) then l_accR.dapp else null end,
                    status = l_ready_to_transfer,
                    nls_abs = l_accR.nls
                where nls = rec.nls
                and   kv = rec.kv
                and   kf = rec.kf
                and   exp_id = rec.exp_id;
                l_rows_checked := l_rows_checked + 1;
            exception
                when no_data_found then
                    /* ���� �� ����� */
                    bars_audit.error (l_trace||' ���� ['||rec.kf||' '||rec.nls||'('||rec.kv||')] �� ������');
                    update w4_imp_acc_to_close
                    set status = g_status_notfound
                    where nls = rec.nls
                    and   kv = rec.kv
                    and   kf = rec.kf
                    and   exp_id = rec.exp_id;
                when too_many_rows then
                    /* ���������� �� nls + nlsalt */
                    bars_audit.error (l_trace||' ��� ����� ['||rec.kf||' '||rec.nls||'('||rec.kv||')] ������� ��������� ���������� (nls/nlsalt)');
                    update w4_imp_acc_to_close
                    set status = g_status_too_many
                    where nls = rec.nls
                    and   kv = rec.kv
                    and   kf = rec.kf
                    and   exp_id = rec.exp_id;
            end;
            if mod(l_rows_checked, c_rows_to_commit) = 0 then
                -- ������������� ������ ������ c_rows_to_commit �������
                commit;
            end if;
        end loop;
    end loop;
    bc.go(nvl(l_ourmfo, '/'));
    -- ���������� ����� ���������� ��������
    update w4_imp_acc_to_close_export
    set check_date = sysdate,
        checked_rows = l_rows_checked,
        blocked_rows = l_blocked_cnt
    where exp_id = l_exp_id;
    
    commit;
    bars_audit.info(l_trace||'����� '||'[exp_id='||l_exp_id||', checked='||l_rows_checked||', blocked='||l_blocked_cnt||']');
    bars_login.login_user(sys_guid, l_userid, null, null); -- ����� �������������, ������� ������
exception
    when others then
        bars_audit.fatal(l_trace||dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace);
        bars_login.login_user(sys_guid, l_userid, null, null); -- ����� �������������, ������� ������
        bc.home;
        raise;
end check_accounts_to_close;

end xrm_intg_card;
/
Show errors;

grant execute on xrm_intg_card to bars_access_defrole;
grant execute on xrm_intg_card to IBMESB;