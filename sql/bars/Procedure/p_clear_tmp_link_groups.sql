prompt P_CLEAR_TMP_LINK_GROUPS
create or replace procedure P_CLEAR_TMP_LINK_GROUPS
is
begin
    bars_audit.info('p_clear_tmp_link_groups: видаляємо попередні дані з довідника груп пов''язаних осіб');
    begin
        execute immediate 'truncate table d8_cust_link_groups';
    exception
    when others then
        bars_audit.error('p_clear_tmp_link_groups: помилка при видаленні даних довідника: '||sqlerrm);
        raise;
    end;
end;
/
show errors;
grant execute on bars.p_clear_tmp_link_groups to bars_access_defrole;