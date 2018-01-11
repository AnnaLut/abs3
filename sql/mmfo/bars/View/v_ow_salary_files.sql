

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_SALARY_FILES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_SALARY_FILES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_SALARY_FILES ("ID", "FILE_NAME", "FILE_DATE", "FILE_N", "FILE_DEAL", "CARD_CODE", "BRANCH", "ISP") AS 
  select f.id, f.file_name, f.file_date, f.file_n,
       (select count(*) from ow_salary_data where id = f.id and nd is not null) file_deal,
       f.card_code, f.branch, f.isp
  from ow_salary_files f
 where exists ( select 1 from ow_salary_data where id = f.id )
union all
select f.id, f.file_name, f.file_date, file_n,
       null file_deal,
       f.card_code, f.branch, f.isp
  from ow_salary_files f
 where not exists ( select 1 from ow_salary_data where id = f.id );

PROMPT *** Create  grants  V_OW_SALARY_FILES ***
grant SELECT                                                                 on V_OW_SALARY_FILES to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_SALARY_FILES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_SALARY_FILES to OW;
grant SELECT                                                                 on V_OW_SALARY_FILES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_SALARY_FILES.sql =========*** End 
PROMPT ===================================================================================== 
