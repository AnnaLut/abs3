--COBUMMFO-8386

--������� ����� ��� CPYCL 
MERGE INTO OP_FIELD A USING
 (SELECT
  'CPYCL' as TAG,
  '��������� ����. �볺���' as NAME,
  NULL as FMT,
  'TagBrowse("SELECT name,name id FROM fm_yesno")' as BROWSER,
  NULL as NOMODIFY,
  NULL as VSPO_CHAR,
  NULL as CHKR,
  null as DEFAULT_VALUE,
  NULL as TYPE,
  0 as USE_IN_ARCH
  FROM DUAL) B
ON (A.TAG = B.TAG)
WHEN NOT MATCHED THEN 
INSERT (
  TAG, NAME, FMT, BROWSER, NOMODIFY, 
  VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH)
VALUES (
  B.TAG, B.NAME, B.FMT, B.BROWSER, B.NOMODIFY, 
  B.VSPO_CHAR, B.CHKR, B.DEFAULT_VALUE, B.TYPE, B.USE_IN_ARCH)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.FMT = B.FMT,
  A.BROWSER = B.BROWSER,
  A.NOMODIFY = B.NOMODIFY,
  A.VSPO_CHAR = B.VSPO_CHAR,
  A.CHKR = B.CHKR,
  A.DEFAULT_VALUE = B.DEFAULT_VALUE,
  A.TYPE = B.TYPE,
  A.USE_IN_ARCH = B.USE_IN_ARCH;

COMMIT;
--��������� ��� � ��������� ��������
BEGIN
    FOR k IN (SELECT TT FROM TTS WHERE TT IN ('045','AA3','AA4','AA5','AA6','AA7','AA8','AA9','AA0','AAB','AAC','AAE','AAK','AAL','AAM','AAN') )
    LOOP
        bars_ttsadm.set_rules(p_tag=>'CPYCL',p_tt=>k.TT,p_opt=>'M',p_ord=>8,p_used=>1,p_val=>null);
    END LOOP;

    COMMIT;
END;
/
--��������� ����� �������� COPY_CLIENT ��� ������
MERGE INTO TICKETS_PAR A USING
 (SELECT
  'DEFAULT' as REP_PREFIX,
  'COPY_CLIENT' as PAR,
  'select value from operw where ref=:nRecID and tag=''CPYCL'' and value<>''ͳ''' as TXT,
  '��������� ����. �볺��� (���/ͳ)' as COMM,
  'TIC' as MOD_CODE
  FROM DUAL) B
ON (A.REP_PREFIX = B.REP_PREFIX and A.PAR = B.PAR)
WHEN NOT MATCHED THEN 
INSERT (
  REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
VALUES (
  B.REP_PREFIX, B.PAR, B.TXT, B.COMM, B.MOD_CODE)
WHEN MATCHED THEN
UPDATE SET 
  A.TXT = B.TXT,
  A.COMM = B.COMM,
  A.MOD_CODE = B.MOD_CODE;

COMMIT;