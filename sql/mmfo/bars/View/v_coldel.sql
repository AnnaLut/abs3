

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_COLDEL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_COLDEL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_COLDEL ("TABNAME", "COLNAME", "COLSEMANTIC", "COLTYPE", "COLLENGTH", "POSITION") AS 
  select b.table_name, substr(b.column_name,1,30),
       nvl(c.colsemantic, substr(b.column_name,1,30)),
       decode(d.data_type, 'NUMBER','N','DATE','D','C'),
       d.data_length, b.position
from all_constraints a, all_cons_columns b, v_meta_tables c,
     all_tab_columns d, v_tabldel e
where a.constraint_type='P'
  and a.table_name=b.table_name
  and a.constraint_name=b.constraint_name
  and a.table_name=d.table_name
  and b.column_name=d.column_name
  and b.table_name=c.tabname(+) and b.column_name=c.colname(+)
  and b.table_name=e.tabname
 ;

PROMPT *** Create  grants  V_COLDEL ***
grant SELECT                                                                 on V_COLDEL        to ABS_ADMIN;
grant SELECT                                                                 on V_COLDEL        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_COLDEL        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_COLDEL.sql =========*** End *** =====
PROMPT ===================================================================================== 
