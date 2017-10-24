

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/View/V_UPL_FILES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_FILES ***

  CREATE OR REPLACE FORCE VIEW BARSUPL.V_UPL_FILES ("FILE_ID", "FILE_ORDER", "FILENAME", "DOMAIN_CODE", "ISACTIVE", "DESCRIPT", "UPL_TYPE", "COL_ID", "COL_NAME", "COL_DESC", "COL_TYPE", "COL_LENGTH", "COL_FORMAT", "NULLABLE") AS 
  select f.file_id,
       f.order_id      file_order,
       f.filename_prfx filename,
       f.domain_code,
       f.isactive,
       f.descript,
       f.data_type upl_type,
	   c.col_id,
       c.col_name,
       c.col_desc,
       c.col_type,
       c.col_length,
       c.col_format,
       c.nullable
from upl_files f, upl_columns c
where  f.file_id = c.file_id
order by domain_code, f.order_id, c.col_id;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/View/V_UPL_FILES.sql =========*** End ***
PROMPT ===================================================================================== 
