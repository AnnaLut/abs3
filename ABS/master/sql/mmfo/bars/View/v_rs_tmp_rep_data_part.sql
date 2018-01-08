

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RS_TMP_REP_DATA_PART.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RS_TMP_REP_DATA_PART ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RS_TMP_REP_DATA_PART ("TABLE_NAME", "PARTITION_NAME", "HIGH_VALUE_IN_DATE_FORMAT") AS 
  select table_name,
       partition_name,
       to_date (
          trim (
             '''' from regexp_substr (
                          extractvalue (
                             dbms_xmlgen.
                             getxmltype (
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
  from all_tab_partitions
 where table_name = 'RS_TMP_REPORT_DATA' and table_owner = 'BARS';

PROMPT *** Create  grants  V_RS_TMP_REP_DATA_PART ***
grant SELECT                                                                 on V_RS_TMP_REP_DATA_PART to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RS_TMP_REP_DATA_PART.sql =========***
PROMPT ===================================================================================== 
