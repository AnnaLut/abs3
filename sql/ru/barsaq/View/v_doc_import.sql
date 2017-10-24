

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_DOC_IMPORT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOC_IMPORT ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_DOC_IMPORT ("REF", "EXT_REF", "TT", "ND", "VOB", "VDAT", "DATD", "DATP", "DK", "KV", "S", "KV2", "S2", "SQ", "SK", "MFO_A", "NAM_A", "NLS_A", "ID_A", "MFO_B", "NAM_B", "NLS_B", "ID_B", "NAZN", "USERID", "ID_O", "SIGN", "INSERTION_DATE", "VERIFICATION_FLAG", "VERIFICATION_ERR_CODE", "VERIFICATION_ERR_MSG", "VERIFICATION_DATE", "CONFIRMATION_FLAG", "CONFIRMATION_DATE", "BOOKING_FLAG", "BOOKING_ERR_CODE", "BOOKING_ERR_MSG", "BOOKING_DATE", "REMOVAL_FLAG", "REMOVAL_DATE", "IGNORE_ERR_CODE", "IGNORE_ERR_MSG", "IGNORE_COUNT", "IGNORE_DATE", "PRTY", "NOTIFICATION_FLAG", "NOTIFICATION_DATE", "SYSTEM_ERR_CODE", "SYSTEM_ERR_MSG", "SYSTEM_ERR_DATE") AS 
  select
decode(ref,null,null,'<a href=/barsroot/documentview/default.aspx?ref='||REF||'>'||REF||'</a>') AS REF,
EXT_REF, TT, ND, VOB, VDAT, DATD, DATP, DK, KV, S, KV2, S2, SQ, SK, MFO_A, NAM_A, NLS_A, ID_A,
MFO_B, NAM_B, NLS_B, ID_B, NAZN, USERID, ID_O, SIGN, INSERTION_DATE, VERIFICATION_FLAG,
VERIFICATION_ERR_CODE, VERIFICATION_ERR_MSG, VERIFICATION_DATE, CONFIRMATION_FLAG, CONFIRMATION_DATE,
BOOKING_FLAG, BOOKING_ERR_CODE, BOOKING_ERR_MSG, BOOKING_DATE, REMOVAL_FLAG, REMOVAL_DATE,
IGNORE_ERR_CODE, IGNORE_ERR_MSG, IGNORE_COUNT, IGNORE_DATE, PRTY, NOTIFICATION_FLAG,
NOTIFICATION_DATE, SYSTEM_ERR_CODE, SYSTEM_ERR_MSG, SYSTEM_ERR_DATE
from barsaq.doc_import;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_DOC_IMPORT.sql =========*** End ***
PROMPT ===================================================================================== 
