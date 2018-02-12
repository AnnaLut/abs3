prompt PACKAGE FM_UTL

create or replace package fm_utl
is
/* created 26.12.2017
  ������������ ��������� ������ �� ������� � ���� ����� */
g_header_version constant varchar2(64) := 'version 1.0   26.12.2017';

-- ���������� ������ ��������� ������ FM_UTL
function header_version return varchar2;

-- ���������� ������ ���� ������ FM_UTL
function body_version   return varchar2;

-- ������� �������� �� ��� / �������� �� ��������� � ���������� ����������� � ����������� Hash-�������
-- ���������� ��� ���������� � ����������� V_FINMON_REFT ��� 0 � ������ ���������� ����������
function get_terrorist_code (p_txt varchar2) return number;

-- �������� ������� �� ������������ ������ ����������� �� ��� / ��������
-- ���������� � ������ ���������� ����� � ������, ���� p_mode = 1; 1 - ���� p_mode = 0; 0 - ���� �� �������
function get_public_code (p_name   in varchar2,
                          p_mode   in int default 0) return number;
                          
-- �������� ������� �� ������������ ������ ����������� �� ���
-- ���������� � ������ ���������� ����� � ������, ���� p_mode = 1; 1 - ���� p_mode = 0; 0 - ���� �� �������
function get_public_code (p_rnk    in number,
                          p_mode   in int default 0) return number;

-- �������� �������� ����� �� ������������ ������������ ������ ����������� � ����������� ���
-- ��������� ���������� �������������� �������� - fm_klient
procedure check_terrorists;

-- �������� �������� ����� �� ������������ ������ ��������� ��������
-- ��������� ���������� ��������-��� - finmon_public_customers
procedure check_public;

-- ��������� ��������� � �����, ������� �� ���������� �������� ��������� p_success_message ������������ ������������ � ������������
procedure run_deferred_task(p_procname        varchar2, 
                            p_success_message varchar2);

-- �������� ������������ ���������� ��
-- ����������� ���� ����� ����� ��������, �� � �� �� ���� ������ ��������
procedure set_fm_params_bulk(p_refs     in number_list,                  -- ��������� ����������
                             p_opr_vid1 in finmon_que.opr_vid1%type,     -- ��� ���� ��������
                             p_opr_vid2 in finmon_que.opr_vid2%type,     -- ��� ��
                             p_comm2    in finmon_que.comm_vid2%type,    -- ����������� � ��
                             p_opr_vid3 in finmon_que.opr_vid3%type,     -- ��� ��
                             p_comm3    in finmon_que.comm_vid3%type,    -- ����������� � ��
                             p_mode     in finmon_que.monitor_mode%type, -- ����� �����������
                             p_vid2     in string_list,                  -- ���. ���� �� (���������)
                             p_vid3     in string_list                   -- ���. ���� �� (���������)
                             );

-- �������� �������� �� ������ �� ������������ �������� ��
-- ��������� ������� tmp_fm_checkrules ��� ���������� ������������
procedure check_fm_rules (p_dat1 date, p_dat2 date, p_rules varchar2);

-- �������� �������� (�������������) �� ������ �����������
-- ���������� 0 � ������ ���������� ����������, -1 � ������ ������ ��� ����� � ����������� �����������
function ref_check(p_ref oper.ref%type) return number;

-- �������� (�����������) ���������� �������� ��� ���� �������� � �������
-- � ������ ���������� ���������� � ������� ��� ��������� �� � ��������� ����� ��
procedure ref_block(p_ref in oper.ref%type default null);

end fm_utl;
/
create or replace package body fm_utl
is
g_body_version constant varchar2(64)  := 'version 1.0   26.12.2017';
g_trace constant varchar2(16) := 'FM_UTL';

-------------------------------------------------------------------------------------------------
-- header_version - ���������� ������ ��������� ������ FM_UTL
-------------------------------------------------------------------------------------------------
FUNCTION header_version
RETURN VARCHAR2
IS
BEGIN
   RETURN 'Package header '||g_trace|| ' ' || G_HEADER_VERSION;
END header_version;

-------------------------------------------------------------------------------------------------
-- body_version - ���������� ������ ���� ������ FM_UTL
-------------------------------------------------------------------------------------------------
FUNCTION body_version
   RETURN VARCHAR2
IS
BEGIN
   RETURN 'Package body '||g_trace|| ' ' || G_BODY_VERSION;
END body_version;

-------------------------------------------------------------------------------------------------
-- get_terrorist_code - ������� �������� �� ��� / �������� �� ��������� � ���������� ����������� � ����������� Hash-�������
-- ���������� ��� ���������� � ����������� V_FINMON_REFT ��� 0 � ������ ���������� ����������
-------------------------------------------------------------------------------------------------
function get_terrorist_code (p_txt varchar2) return number
is
  l_ret         number := 0;
begin
    select c1 into l_ret from v_finmon_reft where name_hash = f_fm_hash(p_txt) and rownum = 1;
    return l_ret;
exception
    when no_data_found then return 0;
end get_terrorist_code;

-------------------------------------------------------------------------------------------------
-- �������� ������� �� ������������ ������ ����������� �� ��� / ��������
-- ���������� � ������ ���������� ����� � ������, ���� p_mode = 1; 1 - ���� p_mode = 0; 0 - ���� �� �������
-------------------------------------------------------------------------------------------------
function get_public_code (p_name   in varchar2,
                          p_mode   in int default 0)
return number
is
l_public   int;
l_name     varchar2(250);
begin
    l_name := replace(replace(replace(replace(replace(replace(replace(replace(p_name,'/',''),'\',''),'*',''),'~',''),'!',''),'&',''),'?',''),' ','');
    if  l_name is null then
        return 0;
    end if;
    
    begin
        select /*+ index(I_FMN_PUBLIC_RELS) */ 
               case when p_mode = 0 then 1
                    when p_mode = 1 then id
               end
        into l_public
        from finmon_public_rels
        where fullname = upper(l_name)
          and (ADD_MONTHS(termin,36) >= bankdate or termin is null);
    exception 
        when no_data_found then l_public := 0;
        when too_many_rows then l_public := 1;
    end;
    return l_public;
end get_public_code;

-------------------------------------------------------------------------------------------------
-- �������� ������� �� ������������ ������ ����������� �� ���
-- ���������� � ������ ���������� ����� � ������, ���� p_mode = 1; 1 - ���� p_mode = 0; 0 - ���� �� �������
-------------------------------------------------------------------------------------------------
function get_public_code (p_rnk    in number,
                          p_mode   in int default 0)
return number
is
l_name customer.nmk%type;
begin
    if p_rnk is not null then
        begin
            select nmk
            into l_name
            from customer
            where rnk = p_rnk;
        exception 
            when no_data_found then return 0;
        end;
        return get_public_code(l_name, p_mode);
    else
        return 0;
    end if;
end get_public_code;

-------------------------------------------------------------------------------------------------
-- �������� �������� ����� �� ������������ ������������ ������ ����������� � ����������� ���
-- ��������� ���������� �������������� �������� - fm_klient
-------------------------------------------------------------------------------------------------
procedure check_terrorists
/* 
����������� �������-������� �� �������������, �������-������ �� �������������, ��������� ���� (��� �������, ��� � ��-�������) ��������-�����;
����� ������ ��������� ������������ ������ ���������� ���������.
*/    
    is
    l_trace constant varchar2(24) := 'CHECK_TERRORISTS';
    l_bdate date := bankdate_g;
    l_kf varchar2(6) := sys_context('bars_context', 'user_mfo');
begin
    bars_audit.info(g_trace||'.'||l_trace||': �����. ������� ���������� ������.');
    delete from fm_klient;
    commit;
    
    bars_audit.info(g_trace||'.'||l_trace||': �������� ���������� ������� ����������.');
    for k in (/* ������� */
              select /*+ parallel(8)*/ rnk, nmk, nmkk, nmkv, fr1.c1 as c1, null as c2, null as c3, null as rel_rnk, null as rel_intext
              from customer c,
                   FINMON_REFT_AKALIST fr1
              where (date_off is null or date_off > l_bdate)
              and fr1.name_hash = f_fm_hash(c.nmk)
              union all
              select /*+ parallel(8)*/ rnk, nmk, nmkk, nmkv, null as c1, fr2.c1 as c2, null as c3, null as rel_rnk, null as rel_intext
              from customer c,
                   FINMON_REFT_AKALIST fr2
              where (date_off is null or date_off > l_bdate)
              and fr2.name_hash = f_fm_hash(c.nmkk)
              union all
              select /*+ parallel(8)*/ rnk, nmk, nmkk, nmkv, null as c1, null as c2, fr3.c1 as c3, null as rel_rnk, null as rel_intext
              from customer c,
                   FINMON_REFT_AKALIST fr3
              where (date_off is null or date_off > l_bdate)
              and fr3.name_hash = f_fm_hash(c.nmkv)

              union all

              /* ������ � �� ��������� */

              select /*+ parallel(8)*/ c.rnk, c.nmk, c.nmkk, c.nmkv, fr1.c1 as c1, null as c2, null as c3, r.rel_rnk as rel_rnk, 1 as rel_intext
              from customer c,
                   customer_rel r,
                   customer cr,
                   FINMON_REFT_AKALIST fr1
              where (c.date_off is null or c.date_off > l_bdate)
              and c.custtype = 2
              and c.rnk = r.rnk
              and r.rel_intext = 1
              and cr.rnk = r.rel_rnk
              and fr1.name_hash = f_fm_hash(cr.nmk)

              union all

              select /*+ parallel(8)*/ c.rnk, c.nmk, c.nmkk, c.nmkv, null as c1, fr2.c1 as c2, null as c3, r.rel_rnk as rel_rnk, 1 as rel_intext
              from customer c,
                   customer_rel r,
                   customer cr,
                   FINMON_REFT_AKALIST fr2
              where (c.date_off is null or c.date_off > l_bdate)
              and c.custtype = 2
              and c.rnk = r.rnk
              and r.rel_intext = 1
              and cr.rnk = r.rel_rnk
              and fr2.name_hash = f_fm_hash(cr.nmkk)

              union all

              select /*+ parallel(8)*/ c.rnk, c.nmk, c.nmkk, c.nmkv, null as c1, null as c2, fr3.c1 as c3, r.rel_rnk as rel_rnk, 1 as rel_intext
              from customer c,
                   customer_rel r,
                   customer cr,
                   FINMON_REFT_AKALIST fr3
              where (c.date_off is null or c.date_off > l_bdate)
              and c.custtype = 2
              and c.rnk = r.rnk
              and r.rel_intext = 1
              and cr.rnk = r.rel_rnk
              and fr3.name_hash = f_fm_hash(cr.nmkv)

              union all

              /* ��-������� - ��� ����� ����� */
              select /*+ parallel(8)*/ c.rnk, c.nmk, c.nmkk, c.nmkv, null as c1, null as c2, fr3.c1 as c3, r.rel_rnk as rel_rnk, 0 as rel_intext
              from customer c,
                   customer_rel r,
                   customer_extern cre,
                   FINMON_REFT_AKALIST fr3
              where (c.date_off is null or c.date_off > l_bdate)
              and c.custtype = 2
              and c.rnk = r.rnk
              and r.rel_intext = 0
              and r.rel_rnk = cre.id
              and fr3.name_hash = f_fm_hash(cre.name)
    )
    loop
        begin
            if k.c1 is not null then
                insert into fm_klient (rnk, kod, dat, rel_rnk, rel_intext, kf) values (k.rnk, k.c1, l_bdate, k.rel_rnk, k.rel_intext, l_kf);
            elsif k.c2 is not null then
                insert into fm_klient (rnk, kod, dat, rel_rnk, rel_intext, kf) values (k.rnk, k.c2, l_bdate, k.rel_rnk, k.rel_intext, l_kf);
            elsif k.c3 is not null then
                insert into fm_klient (rnk, kod, dat, rel_rnk, rel_intext, kf) values (k.rnk, k.c3, l_bdate, k.rel_rnk, k.rel_intext, l_kf);
            end if;
        exception when dup_val_on_index then null;
        end;
    end loop;
    bars_audit.info(g_trace||'.'||l_trace||': �����. �������� ���������.');
exception 
    when others then
        bars_audit.error(g_trace||'.'||l_trace||': ����������� � �������: '||sqlerrm||' '||dbms_utility.format_error_backtrace);
        rollback; -- ������������ � ������� ������
        raise; 
end check_terrorists;

-------------------------------------------------------------------------------------------------
-- �������� �������� ����� �� ������������ ������ ��������� ��������
-- ��������� ���������� ��������-��� - finmon_public_customers
-------------------------------------------------------------------------------------------------
procedure check_public
is
l_trace constant varchar2(24) := 'CHECK_PUBLIC';
 /*
 RNK,
 ϲ�/����� �볺���,
 � ����� � ������� �������� ���,
 ����� ������,
 ������ ������, � ������� ������� ������ ���������� ���������� ���� ������������ ������� ������ � ������ (Id) 2, 3, 62-65.
 (+) RNK ���'����� �����,
 (+) ϲ�/����� ���'����� �����,
 (+) � ���'��. ����� � ������� �������� ���,
 (+) ��������
 ���� �����;

 � ��� ����������� ���� ���� �볺���
   1) ��� �볺��� � �������� �������� ��� - ���� "RNK ���'����� �����", "ϲ�/����� ���'����� �����", "� ���'��. ����� � ������� �������� ���" ����, ��������="�볺��"
   2) ��� ���'����� ����� (�볺��� �����) �� ���� �����, ������������ � ������ �볺��� - ���� ����� �� �볺��� - ��� �볺��� ���'������� � �������� ������, ���� "� ����� � ������� �������� ���" �����, ���� ���'����� ����� - ������� ��� �� ���� ������� ���, ��������="���'����� ����� (�볺�� �����)"
   3) ��� ���'����� ����� (�� �볺�� �����) �� ���� ����� - ���� ����� �� �볺��� - ��� �볺��� ���'������� � �������� ������, ���� "� ����� � ������� �������� ���" �����, ���� ���'����� ����� - ������� ��� �� ���� ������� ���, ��������="���'����� ����� (�� �볺�� �����)"
 */

begin
    bars_audit.info(g_trace||'.'||l_trace||': �����. ������� ���������� ������');
    delete from FINMON_PUBLIC_CUSTOMERS;
    commit; -- ������� ������ � ����� ������
    
    bars_audit.info(g_trace||'.'||l_trace||': �������� ���������� ������� ����������.');
    
    INSERT INTO FINMON_PUBLIC_CUSTOMERS (ID, RNK, NMK, CRISK, CUST_RISK, CHECK_DATE, RNK_REEL, NMK_REEL, NUM_REEL, COMMENTS)
    /* 1) ��� �볺��� � �������� �������� ���
            ����    "RNK ���'����� �����",
                    "ϲ�/����� ���'����� �����",
                    "� ���'��. ����� � ������� �������� ���" ����,
                    ��������="�볺��"
    */
    SELECT  FINMON_IS_PUBLIC (C.NMK, C.RNK, 1),
         C.RNK,
         C.NMK,
         NVL (CW.VALUE, '�������'),
         CONCATSTR (CR.RISK_ID),
         TRUNC (SYSDATE),
         null,
         '',
         null,
         '�볺��'
    FROM CUSTOMER C,
         (SELECT RNK, RISK_ID
            FROM CUSTOMER_RISK
           WHERE TRUNC (SYSDATE) BETWEEN DAT_BEGIN AND NVL(DAT_END, trunc(sysdate))
             AND RISK_ID IN (2,3,62,63,64,65) order by RISK_ID) CR,
         (SELECT RNK, VALUE
            FROM CUSTOMERW
           WHERE TAG = 'RIZIK') CW
    WHERE FINMON_IS_PUBLIC (NMK, C.RNK, 0) = 1
      AND DATE_OFF IS NULL
      AND CR.RNK(+) = C.RNK
      AND CW.RNK(+) = C.RNK
    GROUP BY C.RNK, C.NMK, CW.VALUE
      /* 2) ��� ���'����� ����� (�볺��� �����) �� ���� �����,
            ������������ � ������ �볺��� - ���� ����� �� �볺��� - ��� �볺��� ���'������� � �������� ������,
            ����    "� ����� � ������� �������� ���" �����,
                    ���� ���'����� ����� - ������� ��� �� ���� ������� ���,
                    ��������="���'����� ����� (�볺�� �����)"
         3) ��� ���'����� ����� (�� �볺�� �����) �� ���� ����� - ���� ����� �� �볺��� - ��� �볺��� ���'������� � �������� ������,
            ����    "� ����� � ������� �������� ���" �����,
                    ���� ���'����� ����� - ������� ��� �� ���� ������� ���,
                    ��������="���'����� ����� (�� �볺�� �����)"
      */
    UNION ALL
    SELECT  NULL,
         C.RNK,
         C.NMK,
         NVL (CW.VALUE, '�������'),
         CONCATSTR (CR.RISK_ID),
         TRUNC (SYSDATE),
         CREL.REL_RNK,
         COALESCE(C2.NMK,CE.NAME),
         FINMON_IS_PUBLIC (COALESCE(C2.NMK,CE.NAME), CREL.REL_RNK, 1),
         CASE   WHEN REL_INTEXT = 1 THEN '���''����� ����� (�볺�� �����)'
                WHEN REL_INTEXT = 0 THEN '���''����� ����� (�� �볺�� �����)'
         END
    FROM CUSTOMER C,
         CUSTOMER_REL CREL,
         CUSTOMER_EXTERN CE,
         (SELECT RNK, RISK_ID
            FROM CUSTOMER_RISK
           WHERE TRUNC (SYSDATE) BETWEEN DAT_BEGIN AND NVL(DAT_END, trunc(sysdate))
             AND RISK_ID IN (2,3,62,63,64,65) order by RISK_ID) CR,
         (SELECT RNK, VALUE
            FROM CUSTOMERW
           WHERE TAG = 'RIZIK') CW,
         CUSTOMER C2
    WHERE     FINMON_IS_PUBLIC (COALESCE(C2.NMK,CE.NAME), CREL.REL_RNK, 0) = 1
         AND CREL.REL_RNK = CE.ID(+)
         AND C.RNK = CREL.RNK
         AND C.DATE_OFF IS NULL
         AND CR.RNK(+) = CREL.RNK
         AND CW.RNK(+) = CREL.RNK
         AND C2.RNK(+) = CREL.REL_RNK
    GROUP BY C.RNK, C.NMK, CW.VALUE, CREL.REL_RNK,CREL.REL_INTEXT,CE.NAME,C2.NMK;
bars_audit.info('finmon_check_public - finished');
exception 
    when others then
        bars_audit.error(g_trace||'.'||l_trace||': ����������� � �������: '||sqlerrm||' '||dbms_utility.format_error_backtrace);
        rollback; -- ������������ � ������� ������
        raise;    
end check_public;

-------------------------------------------------------------------------------------------------
-- ��������� ��������� � �����, ������� �� ���������� �������� ��������� p_success_message ������������ ������������ � ������������
-------------------------------------------------------------------------------------------------
procedure run_deferred_task(p_procname        varchar2, 
                            p_success_message varchar2)
is
l_jobname varchar2(64) := 'FM_'||replace(upper(p_procname), 'FM_UTL.', '')||'_'||f_ourmfo;
l_error_message varchar2(256) := '³�������� ��������� ���������� � ���������. ��������� �� ������������ ��';
l_action varchar2(2000) := 
'begin 
    bars_login.login_user(sys_guid, 1, null, null); 
    bc.go('''||f_ourmfo||'''); 
    '||p_procname||'; 
    commit;
    bms.send_message(p_receiver_id     => '||user_id||',
     p_message_type_id => 1,
     p_message_text    => '''||p_success_message||''',
     p_delay           => 0,
     p_expiration      => 0);
 exception
     when others then
             bms.send_message(p_receiver_id     => '||user_id||',
             p_message_type_id => 1,
             p_message_text    => '''||l_error_message||''',
             p_delay           => 0,
             p_expiration      => 0);
 end;';
begin
    dbms_scheduler.create_job(job_name => l_jobname, 
                              job_type => 'PLSQL_BLOCK', 
                              job_action => l_action, 
                              auto_drop => true, 
                              enabled => true);
exception
    when others then
        -- � ����� ������ ������� ����
        dbms_scheduler.drop_job(l_jobname, force => true);
        raise;
end run_deferred_task;

-------------------------------------------------------------------------------------------------
-- �������� ������������ ���������� ��
-- ����������� ���� ����� ����� ��������, �� � �� �� ���� ������ ��������
-------------------------------------------------------------------------------------------------
procedure set_fm_params_bulk(p_refs     in number_list,                  -- ��������� ����������
                             p_opr_vid1 in finmon_que.opr_vid1%type,     -- ��� ���� ��������
                             p_opr_vid2 in finmon_que.opr_vid2%type,     -- ��� ��
                             p_comm2    in finmon_que.comm_vid2%type,    -- ����������� � ��
                             p_opr_vid3 in finmon_que.opr_vid3%type,     -- ��� ��
                             p_comm3    in finmon_que.comm_vid3%type,    -- ����������� � ��
                             p_mode     in finmon_que.monitor_mode%type, -- ����� �����������
                             p_vid2     in string_list,                  -- ���. ���� �� (���������)
                             p_vid3     in string_list                   -- ���. ���� �� (���������)
                             )
is
/* 
created 12.05.2017
����
*/
g_modcode constant varchar2(3) := 'FMN';
l_refs_to_audit varchar2(2000);
begin
    bars_audit.trace('%s: %s entry', g_modcode, $$PLSQL_UNIT);
    if p_refs.count <= 150 then
        select trim(substr(listagg(column_value, ', ') within group (order by 1), 1, 1500)) into l_refs_to_audit from table(p_refs);
    else l_refs_to_audit := '>150 refs, not shown';
    end if;
    bars_audit.trace('%s: %s merging, refs=>(%s)(1500 substr)', g_modcode, $$PLSQL_UNIT, l_refs_to_audit);

    merge into finmon_que f
    using (select p.column_value as CV
         from table(p_refs) p
         join oper o on p.column_value = o.ref) r
    on (f.ref = r.CV)
    when matched then update
                    set f.opr_vid1 = p_opr_vid1,
                        f.opr_vid2 = p_opr_vid2,
                        f.comm_vid2 = p_comm2,
                        f.opr_vid3 = p_opr_vid3,
                        f.comm_vid3 = p_comm3,
                        f.monitor_mode = p_mode,
                        f.rnk_a = (select c.rnk from customer c
                                   where c.rnk = coalesce(f.rnk_a, -- ���� ��� ��������
                                                         (select a.rnk
                                                          from oper o
                                                          join accounts a on o.nlsa = a.nls and o.kv = a.kv and o.mfoa = a.kf
                                                          where o.ref = r.CV), -- ���� �� �����
                                                         (select max(co.rnk) -- ���� �� ���� � ��������� - ���� ����� ������ ����
                                                          from customer co
                                                          join oper o on co.okpo = o.id_a
                                                          where o.ref = r.CV
                                                          group by co.okpo
                                                          having count(*)=1
                                                         ))
                                   ),
                        f.rnk_b = (select c.rnk from customer c
                                   where c.rnk = coalesce(f.rnk_b, -- ���� ��� ��������
                                                         (select a.rnk
                                                          from oper o
                                                          join accounts a on o.nlsb = a.nls and nvl(o.kv2, o.kv) = a.kv and o.mfob = a.kf
                                                          where o.ref = r.CV), -- ���� �� �����
                                                         (select max(co.rnk) -- ���� �� ���� � ��������� - ���� ����� ������ ����
                                                          from customer co
                                                          join oper o on co.okpo = o.id_b
                                                          where o.ref = r.CV
                                                          group by co.okpo
                                                          having count(*)=1
                                                         ))
                                   )
    when not matched then insert(ref, rec, status, opr_vid1, opr_vid2, comm_vid2, opr_vid3, comm_vid3, monitor_mode, agent_id, rnk_a, rnk_b)
    values (r.CV, null, 'I', p_opr_vid1, p_opr_vid2, p_comm2, p_opr_vid3, p_comm3, p_mode, user_id, coalesce((select a.rnk
                                                                                                                          from oper o
                                                                                                                          join accounts a on o.nlsa = a.nls and o.kv = a.kv and o.mfoa = a.kf
                                                                                                                          where o.ref = r.CV),
                                                                                                                         (select max(co.rnk)
                                                                                                                          from customer co
                                                                                                                          join oper o on co.okpo = o.id_a
                                                                                                                          where o.ref = r.CV
                                                                                                                          group by co.okpo
                                                                                                                          having count(*)=1
                                                                                                                         )),
                                                                                                  coalesce((select a.rnk
                                                                                                                          from oper o
                                                                                                                          join accounts a on o.nlsb = a.nls and nvl(o.kv2, o.kv) = a.kv and o.mfob = a.kf
                                                                                                                          where o.ref = r.CV),
                                                                                                                         (select max(co.rnk)
                                                                                                                          from customer co
                                                                                                                          join oper o on co.okpo = o.id_b
                                                                                                                          where o.ref = r.CV
                                                                                                                          group by co.okpo
                                                                                                                          having count(*)=1
                                                                                                                         ))
    );
    bars_audit.trace('%s: %s merged, refs=>(%s)', g_modcode, $$PLSQL_UNIT, l_refs_to_audit);
    -- ���� ���� ���. ���� ��
    -- ������� ������������
    delete from finmon_que_vid2 where id in (select id from finmon_que where ref in (select * from table(p_refs)));
    if p_vid2 is not null and p_vid2.count > 0 then
        if p_vid2.first is not null then
            bars_audit.trace('%s: %s vids2 is not empty, processing', g_modcode, $$PLSQL_UNIT);
            -- ����������� �����
            forall idx in 1..p_vid2.count
                insert into finmon_que_vid2(id, vid)
                select id, p_vid2(idx)
                from finmon_que where ref in (select * from table(p_refs));
        end if;
    end if;
    -- ���� ���� ���. ���� ��
    -- ������� ������������
    delete from finmon_que_vid3 where id in (select id from finmon_que where ref in (select * from table(p_refs)));
    if p_vid3 is not null and p_vid3.count > 0 then
        if p_vid3.first is not null then
            bars_audit.trace('%s: %s vids3 is not empty, processing', g_modcode, $$PLSQL_UNIT);
            -- ����������� �����
            forall idx in 1..p_vid3.count
                insert into finmon_que_vid3(id, vid)
                select id, p_vid3(idx)
                from finmon_que where ref in (select * from table(p_refs));
        end if;
    end if;

    bars_audit.trace('%s: %s done', g_modcode, $$PLSQL_UNIT);
end set_fm_params_bulk;

-------------------------------------------------------------------------------------------------
-- �������� �������� �� ������ �� ������������ �������� ��;
-- ��������� ������� tmp_fm_checkrules ��� ���������� ������������
-------------------------------------------------------------------------------------------------
procedure check_fm_rules (p_dat1 date, p_dat2 date, p_rules varchar2)
is
l_trace constant varchar2(128):= g_trace || '.check_fm_rules';
l_tmp   pls_integer;
l_rules varchar2(254);
partition_doesnt_exist exception;
resource_busy exception;
pragma exception_init(partition_doesnt_exist, -2149);
pragma exception_init(resource_busy, -54);
begin
    bars_audit.trace(l_trace || ' start for rules: '||p_rules);
    begin
        execute immediate 'alter table bars.tmp_fm_checkrules truncate partition usr' || user_id;
        bars_audit.trace('tmp_fm_checkrules truncated');
    exception
        when partition_doesnt_exist then
            execute immediate 'alter table bars.tmp_fm_checkrules add partition usr'|| user_id || ' values (' || user_id || ')';
        when resource_busy then 
            raise_application_error(-20000, '����� �� ������ ����������� ��� ����������');
        when others then
            bars_audit.error('tmp_fm_checkrules : '||sqlerrm);
            raise;
    end;
/*
TODO: owner="oleksandr.lypskykh" category="Optimize" priority="2 - Medium" created="20.12.2017"
text="�� ������� ������ ������� ���� ������ ��������� ����� ��������.
      ���� ����� ���������� ���������� �� ������ � ����������� - ���� sql, ���� pl/sql ���������.
      �� ��������, �� ����������."
*/
    for z in (select ref, vdat
                from oper
               where vdat between p_dat1 and p_dat2
                 and 
                 (kv = 980 and s >= 10000000
                  or 
                  kv <> 980 and gl.p_icurval (nvl(kv, 980), nvl(s, 0), vdat) >= 10000000)
             )
    loop
        l_rules := null;

        for k in ( select * from fm_rules where ',' || p_rules || ',' like '%,' || id || ',%')
        loop
            begin
                execute immediate 'select 1 from ' || k.v_name || ' where ref = :ref and vdat = :vdat'
                into l_tmp using z.ref, z.vdat;
                l_rules := l_rules || ', ' || k.id;
            exception 
                when no_data_found then null;
            end;
        end loop;

        if l_rules is not null then
            insert into tmp_fm_checkrules(id, ref, rules) values (user_id, z.ref, substr(l_rules, 3));
        end if;
    end loop;
    bars_audit.trace(l_trace || ' finish.');
end check_fm_rules;

-------------------------------------------------------------------------------------------------
-- �������� �������� (�������������) �� ������ �����������
-- ���������� 0 � ������ ���������� ����������, -1 � ������ ������ ��� ����� � ����������� �����������
-------------------------------------------------------------------------------------------------
function ref_check(p_ref oper.ref%type) return number
is
l_trace constant varchar2(150) := g_trace||'.'||'ref_check';
l_datr           date;
l_nazn           oper.nazn%type;
l_nama           oper.nam_a%type;
l_namb           oper.nam_b%type;
l_tt             oper.tt%type;
l_flag           number;
l_otm            fm_ref_que.otm%type := 0;
resource_busy    exception;
pragma exception_init (resource_busy, -54);
begin
    bars_audit.trace(l_trace || ': start. �������� ������ ��������');
    begin
        select o.tt, o.nazn, o.nam_a, o.nam_b
          into l_tt, l_nazn, l_nama, l_namb
          from oper o
         where o.ref = p_ref;
    exception
        when no_data_found then return -1;
        when resource_busy then return -1;
    end;
    bars_audit.trace(l_trace || ': ������� ���� "�� ��������� �� �����������"');
    -- �� ��������� �������� � ������ "�� ������� �� ������� �����������"
    begin
        select nvl(f.value,0) into l_flag from tts_flags f where f.tt = l_tt and f.fcode = 30;
    exception when no_data_found then
        l_flag := 0;
    end;
    if l_flag = 1 then
        return 0;
    end if;
    -- �������� �� ���������� �� ������� �����������
    -- ������������ �����������
    bars_audit.trace(l_trace || ': ��������� ������������ �����������');
    l_otm := get_terrorist_code(l_nama);
    -- ������������ ����������
    if l_otm = 0 then
        bars_audit.trace(l_trace || ': ��������� ������������ ����������');
        l_otm := get_terrorist_code(l_namb);
    end if;
    -- ���������� �������
    if l_otm = 0 then
        bars_audit.trace(l_trace || ': ��������� ���������� �������');
        l_otm := get_terrorist_code(l_nazn);
    end if;

    if l_otm = 0 then
        bars_audit.trace(l_trace || ': ��������� ������������');
        for d in ( select value, tag
                     from operw
                    where ref = p_ref
                      and tag in ('FIO', 'FIO2', 'OTRIM') )
        loop
            bars_audit.trace(l_trace || ': ��������� ������������: '||d.tag);
            l_otm := get_terrorist_code(d.value);
            if l_otm > 0 then
                exit;
            end if;
        end loop;
    end if;

    /*COBUSUPABS-5202
    �� ��������� � ������ CVO, IBO, CVS ��������� ��������� �� �������� ��������� � ������� ���������� ������� �������� "59" �SWT.59 Beneficiare Customer�
    (%TERROR%, �� TERROR - ������������ ������� ��� ϲ� ����� � ������� ���).
    � ������ ��� �������� ����������, ������ �� ϲ� ��������.*/
    if l_otm = 0 and l_tt in ('CVO', 'IBO', 'CVS') then
        begin
            bars_audit.trace(l_trace || ': ��������� ����������� 59');
            with o59 as
            (select f_translate_kmu(o.value) as t59 from bars.operw o where ref = p_ref and tag = '59')
            select c1 into l_otm
            from bars.v_finmon_reft r, o59
            where regexp_like(o59.t59, '[^A-Za-z�-��-�]'||REGEXP_REPLACE ( f_translate_kmu(c6 || ' ' || c7 || ' ' || c8 || ' ' || c9), '([()\:"])', '\\\1', 1, 0)||'[^A-Za-z�-��-�]')
            and rownum = 1;
        exception
            when no_data_found then l_otm := 0;
        end;
    end if;
    /*COBUSUPABS-5202 end*/

    -- ��� �������� ) ���������� � ������. �������� �������, ���� � ��� �� ϲ� - �������� ���������.
    -- ��� ���� �� ������ ��������� ���� ���������� ����� � ������� � � ��������, � ���� ���� �� ���, �� ����� ��� �������� �� ���������.
    if l_otm >= 10000 then
        bars_audit.trace(l_trace||': ����������: l_otm>= 10000 = '||l_otm);
        begin
            select to_date(c13,'dd.mm.yyyy')
              into l_datr
              from finmon_reft
             where c1 = l_otm;
            bars_audit.trace(l_trace||': ���� �������� �� finmon_reft = '||to_char(l_datr,'dd.mm.yyyy'));
        exception when value_error
                  then l_datr := null;
                       bars_audit.trace(l_trace||': ���� �������� �� finmon_reft �� ������� ��� �� � ���e dd.mm.yyyy');
        end;

        if l_datr is not null
        then
            begin
                for dats in ( select to_date(value,'dd/mm/yyyy') value
                             from operw
                            where ref = p_ref
                              and tag in ('DATN', 'DRDAY', 'DT_R') )
                loop
                    if dats.value = l_datr
                    then 
                        bars_audit.trace(l_trace||': ���� �������� �� operw = '||to_char(dats.value,'dd.mm.yyyy'));
                        exit;
                    else 
                        l_otm := 0;
                        bars_audit.trace(l_trace||': ���� �������� �� operw = '||to_char(dats.value,'dd.mm.yyyy')|| ' �� ����� ���� �������� � ������. ���������� �������.');
                    end if;
                end loop;
            exception when value_error
                then bars_audit.trace(l_trace||': ���� �������� �� operw �� ������� ��� �� � ���e dd.mm.yyyy');
            end;
        end if;
    end if;
    return l_otm;
end ref_check;

-------------------------------------------------------------------------------------------------
-- �������� (�����������) ���������� �������� ��� ���� �������� � �������
-- � ������ ���������� ���������� � ������� ��� ��������� �� � ��������� ����� ��
-------------------------------------------------------------------------------------------------
procedure ref_block(p_ref in oper.ref%type default null)
is
-- ��� ������ ����������� "������������� ���.������������"
c_grp   constant number := getglobaloption ('FM_GRP1');
l_otm            fm_ref_que.otm%type := 0;
l_trace constant varchar2(150) := g_trace||'.'||'ref_block';
begin
    bars_audit.trace(l_trace||': �����'||case when p_ref is not null then ' ��� ref='||p_ref else '' end);
    if p_ref is not null then
        /* �������� ������ ��������� */
        for r in (select ref from ref_que where nvl(fmcheck, 0) = 0 and ref = p_ref )
        loop
            bars_audit.trace(l_trace||': loop: ref = '||p_ref);
            l_otm := ref_check(r.ref);
            if l_otm = -1 then 
                continue; /* ���� �������� ������� ������ - ��������� � ��������� �������� */
            end if;
            bars_audit.trace(l_trace||': ������ ������� "���������"');
            update ref_que 
            set fmcheck = 1 
            where ref = p_ref;
            if l_otm > 0 then
                begin
                    bars_audit.trace(l_trace||': ��������� � ������� ��');
                    insert into fm_ref_que (ref, otm)
                    values (p_ref, l_otm);
                exception
                    when dup_val_on_index then null;
                end;

                if c_grp is not null then
                    bars_audit.trace(l_trace||': ��������� ����� ��');
                    insert into oper_visa (ref, dat, userid, groupid, status)
                    values (p_ref, sysdate, user_id, c_grp, 1);
                end if;
            end if;
        end loop;
    else
        /* �������� ���� ���������� � ������� */
        for b in (select kf from mv_kf)
        loop
            -- �������������� ����� ���
            bc.subst_mfo(b.kf);
            for r in (select ref from ref_que where nvl(fmcheck, 0) = 0 )
            loop
                bars_audit.trace(l_trace||': loop: ref = '||p_ref);
                l_otm := ref_check(r.ref);
                if l_otm = -1 then 
                    continue; /* ���� �������� ������� ������ - ��������� � ��������� �������� */
                end if;
                bars_audit.trace(l_trace||': ������ ������� "���������"');
                update ref_que 
                set fmcheck = 1 
                where ref = p_ref;
                if l_otm > 0 then
                    begin
                        bars_audit.trace(l_trace||': ��������� � ������� ��');
                        insert into fm_ref_que (ref, otm)
                        values (p_ref, l_otm);
                    exception
                        when dup_val_on_index then null;
                    end;

                    if c_grp is not null then
                        bars_audit.trace(l_trace||': ��������� ����� ��');
                        insert into oper_visa (ref, dat, userid, groupid, status)
                        values (p_ref, sysdate, user_id, c_grp, 1);
                    end if;
                end if;
            end loop;
            -- ������������ � ����
         end loop;
         bc.set_context;
    end if;

exception when others then
    -- ���� ���� �����, ����� �� ���������� � ����� ������
    -- ������������ � ����
    bc.set_context;
    -- ����������� ����������� ������ ������
    raise_application_error(-20000,
          dbms_utility.format_error_stack() || chr(10) ||
          dbms_utility.format_error_backtrace());
end ref_block;


begin
    null;
end;
/
show errors;
grant execute on bars.fm_utl to bars_access_defrole;