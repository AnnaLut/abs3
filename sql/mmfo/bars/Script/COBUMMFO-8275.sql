MERGE INTO BARS.CHKLIST_TTS A USING
 (SELECT
  'PKR' as TT,
  7 as IDCHK,
  2 as PRIORITY,
  NULL as F_BIG_AMOUNT,
  '( f_is_resident(kv, nlsa, ref) = 0 '||CHR(13)||CHR(10)||'    or kv<>980 '||CHR(13)||CHR(10)||'    and '||CHR(13)||CHR(10)||'    ( substr(NLSA,1,4) = ''2600'' '||CHR(13)||CHR(10)||'        and (substr(NLSB,1,4) = ''2605'' or (substr(NLSB,1,4) = ''2600'' and nvl(f_get_ob22(KV, NLSB), ''14'')=''14'') or (substr(NLSB,1,4) = ''2650'' and nvl(f_get_ob22(KV, NLSB), ''12'')=''12'') ) '||CHR(13)||CHR(10)||'        or ( substr(NLSA,1,4) in ( ''2620'', ''2909'', ''3739'', ''2924'' ) ) '||CHR(13)||CHR(10)||'        and( substr(NLSB,1,4) = ''2625'' or (substr(NLSB,1,4) = ''2620'' and nvl(f_get_ob22(KV, NLSB), ''36'')=''36''))'||CHR(13)||CHR(10)||'        or ( substr(NLSA,1,4) in (''2520'',''2541'',''2542'') ) '||CHR(13)||CHR(10)||'        and ( substr(NLSB,1,4)=''2520'' '||CHR(13)||CHR(10)||'                and nvl(f_get_ob22(KV, NLSB), ''02'')=''02'' '||CHR(13)||CHR(10)||'                or ( substr(NLSB,1,4) in (''2541'',''2542'') ) '||CHR(13)||CHR(10)||'                and nvl(f_get_ob22(KV, NLSB), ''01'')=''01'' '||CHR(13)||CHR(10)||'            ) '||CHR(13)||CHR(10)||'    ) '||CHR(13)||CHR(10)||') and (F_CHECK_NLS_OKPO(KV,NLSA,NLSB)=1)' as SQLVAL,
  NULL as F_IN_CHARGE,
  NULL as FLAGS
  FROM DUAL) B
ON (A.TT = B.TT and A.IDCHK = B.IDCHK)
WHEN NOT MATCHED THEN 
INSERT (
  TT, IDCHK, PRIORITY, F_BIG_AMOUNT, SQLVAL, 
  F_IN_CHARGE, FLAGS)
VALUES (
  B.TT, B.IDCHK, B.PRIORITY, B.F_BIG_AMOUNT, B.SQLVAL, 
  B.F_IN_CHARGE, B.FLAGS)
WHEN MATCHED THEN
UPDATE SET 
  A.PRIORITY = B.PRIORITY,
  A.F_BIG_AMOUNT = B.F_BIG_AMOUNT,
  A.SQLVAL = B.SQLVAL,
  A.F_IN_CHARGE = B.F_IN_CHARGE,
  A.FLAGS = B.FLAGS;

COMMIT;
