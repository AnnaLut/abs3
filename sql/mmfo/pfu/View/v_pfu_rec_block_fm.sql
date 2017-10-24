

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_REC_BLOCK_FM.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_REC_BLOCK_FM ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_REC_BLOCK_FM ("REF", "TT", "DOC_DATE", "FILE_ID", "ID", "MFO", "NLS", "OKPO", "FIO", "SUMA", "SOS", "GROUPID", "USERNAME", "GROUPNAME") AS 
  SELECT o.REF,
          o.tt,
          TO_CHAR (o.pdat, 'dd.mm.yyyy hh:mm:ss') AS doc_DATE,
          pf.file_id,
          pf.id,
          pf.mfo,
          pf.num_acc AS NLS,
          pf.numident AS OKPO,
          pf.full_name AS FIO,
          o.s / 100 AS Suma,
          o.sos,
          ov.groupid,
          ov.username,
          ov.groupname
     FROM bars.oper_visa ov
          LEFT JOIN bars.oper o ON (o.REF = ov.REF)
          INNER JOIN pfu_file_records pf ON (pf.REF = o.REF)
    WHERE ov.groupid = 44 AND pf.REF IS NOT NULL AND o.sos = 1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_REC_BLOCK_FM.sql =========*** End 
PROMPT ===================================================================================== 
