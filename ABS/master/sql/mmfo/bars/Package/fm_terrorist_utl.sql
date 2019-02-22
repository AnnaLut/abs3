prompt package FM_TERRORIST_UTL
create or replace package fm_terrorist_utl
is
/*
created by lypskykh 25-OCT-2018
������, ������ �� ������� ����������� (/�������������)
*/

g_version constant varchar2(150) := 'version 1.0  19.11.2018';

--
-- ��������� ������ ������
--
function get_version return varchar2;

--
-- �������� �� ��� / �������� �� ��������� � ���������� ����������� � ����������� Hash-�������
-- ���������� ��� ���������� � ����������� V_FINMON_REFT ��� 0 � ������ ���������� ����������
--
function get_terrorist_code (p_txt varchar2) return number;

--
-- �������� �������� ����� �� ������������ ������������ ������ ����������� � ����������� ���
-- ��������� ���������� �������������� �������� - fm_klient
--
procedure check_terrorists;

--
-- �������� ����� �����������
--
procedure import_XY_file (p_clob in CLOB, p_imported out number);

end  fm_terrorist_utl;
/
create or replace package body fm_terrorist_utl
is

g_trace constant varchar2(150) := 'FM_PUBLIC_UTL';

--
-- ��������� ������ ������
--
function get_version return varchar2
    is
begin
    return g_version;
end get_version;

--
-- �������� �� ��� / �������� �� ��������� � ���������� ����������� � ����������� Hash-�������
-- ���������� ��� ���������� � ����������� V_FINMON_REFT ��� 0 � ������ ���������� ����������
--
function get_terrorist_code (p_txt varchar2) return number
is
  l_ret         number := 0;

  l_fm_hash        varchar2(2000);
begin
    l_fm_hash := f_fm_hash(p_txt => p_txt);
    select c1 into l_ret from v_finmon_reft where name_hash = l_fm_hash and rownum = 1;
    return l_ret;
exception
    when no_data_found then return 0;
end get_terrorist_code;

--
-- �������� �������� ����� �� ������������ ������������ ������ ����������� � ����������� ���
-- ��������� ���������� �������������� �������� - fm_klient
--
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

--
-- �������� ����� �����������
--
procedure import_XY_file (p_clob in CLOB, p_imported out number)
    is
l_clob clob := p_clob;
l_id number := 0;
begin
    /*TODO: ���� ������ �������, ������� ������ ����*/
    finmon_export.importXYToABS(xmlXY => l_clob, id => l_id);
    select count(*) into p_imported from finmon_reft;
end import_XY_file;

end  fm_terrorist_utl;
/
Show errors;
grant execute on bars.fm_terrorist_utl to bars_access_defrole;