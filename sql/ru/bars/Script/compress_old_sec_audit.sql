prompt —жатие старых секций sec_audit

begin
    for rec in (
        WITH parts AS (
        select table_name,
               partition_name,
               to_date (
                  trim (
                  '''' from regexp_substr (
                             extractvalue (
                               dbms_xmlgen.getxmltype (
                               'select high_value from all_tab_partitions where table_name='''
                                        || table_name
                                        || ''' and table_owner = '''
                                        || table_owner
                                        || ''' and partition_name = '''
                                        || partition_name
                                        || ''''),
                                     '//text()'),
                                  '''.*?''')),
                  'syyyy-mm-dd hh24:mi:ss')
                  high_value_in_date_format
          FROM all_tab_partitions
         WHERE table_name = 'SEC_AUDIT' AND table_owner = 'BARS'
         )
        SELECT * FROM parts p
        where p.high_value_in_date_format < trunc(sysdate)
        order by p.high_value_in_date_format
        )
        loop
            bars_audit_adm.compress_partition(partname => rec.partition_name, silent_mode => true);
        end loop;
end;
/
prompt done     

