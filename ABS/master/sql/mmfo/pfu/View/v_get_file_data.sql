

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_GET_FILE_DATA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GET_FILE_DATA ***

  CREATE OR REPLACE FORCE VIEW PFU.V_GET_FILE_DATA ("ID", "FILE_NAME", "FILE_DATA") AS 
  SELECT f.id,
          f.file_name,
          f.file_data
     FROM pfu_file f
    WHERE file_data is not null;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_GET_FILE_DATA.sql =========*** End ***
PROMPT ===================================================================================== 
