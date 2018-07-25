SET DEFINE OFF;
Begin
MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Депозити овернайт, що розмiщенi в iнших банках' as NAME,
  1510 as VIDD,
  '151000' as SS,
  '151302' as SP,
  '601101' as SD_N,
  '601102' as SD_I,
  '151804' as SN,
  '151804' as SPN,
  1 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Короткостроковi вклади (депозити), що розмiщенi в iнших банках' as NAME,
  1512 as VIDD,
  '151301' as SS,
  '151302' as SP,
  '601201' as SD_N,
  '601203' as SD_I,
  '151801' as SN,
  '151801' as SPN,
  1 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Вклади (депозити), що розміщені в інших банках' as NAME,
  1513 as VIDD,
  '151300' as SS,
  '151302' as SP,
  '601201' as SD_N,
  '601203' as SD_I,
  '151802' as SN,
  '151802' as SPN,
  1 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Кредити овернайт, що наданi iншим банкам' as NAME,
  1521 as VIDD,
  '152101' as SS,
  '152102' as SP,
  '601401' as SD_N,
  '601402' as SD_I,
  '152804' as SN,
  '152809' as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Кредити, що наданi iншим банкам за операцiями репо' as NAME,
  1522 as VIDD,
  '152201' as SS,
  '152201' as SP,
  '601501' as SD_N,
  '601502' as SD_I,
  '152806' as SN,
  '152809' as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Довгостроковi кредити, якi наданi iншим банкам' as NAME,
  1524 as VIDD,
  '152401' as SS,
  '152405' as SP,
  '601301' as SD_N,
  '601302' as SD_I,
  '152802' as SN,
  '152809' as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Короткострокові кредити, що надані іншим банкам' as NAME,
  1523 as VIDD,
  '152403' as SS,
  '152404' as SP,
  '601303' as SD_N,
  '601304' as SD_I,
  '152801' as SN,
  '152809' as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Депозити овернайт iнших банкiв' as NAME,
  1610 as VIDD,
  '161000' as SS,
  '161000' as SP,
  '701101' as SD_N,
  '701102' as SD_I,
  '161801' as SN,
  '161801' as SPN,
  1 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Довгостроковi вклади (депозити) мiжнародних та iнвестицiйних банкiв' as NAME,
  1614 as VIDD,
  '161302' as SS,
  '161302' as SP,
  '701207' as SD_N,
  '701208' as SD_I,
  '161804' as SN,
  '161804' as SPN,
  1 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Короткострокові вклади (депозити) мiжнародних та iнвестицiйних банкiв' as NAME,
  1611 as VIDD,
  '161304' as SS,
  '161304' as SP,
  '701203' as SD_N,
  '701204' as SD_I,
  '161802' as SN,
  '161802' as SPN,
  1 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Довгострокові вклади (депозити) iнших банкiв' as NAME,
  1613 as VIDD,
  '161301' as SS,
  '161301' as SP,
  '701205' as SD_N,
  '701206' as SD_I,
  '161803' as SN,
  '161803' as SPN,
  1 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Кредити овернайт, що отримані від інших банків' as NAME,
  1621 as VIDD,
  '162101' as SS,
  '162101' as SP,
  '701401' as SD_N,
  '701402' as SD_I,
  '162801' as SN,
  '162801' as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Кредити, що отриманi вiд iнших банкiв за операцiями репо' as NAME,
  1622 as VIDD,
  '162201' as SS,
  '162305' as SP,
  NULL as SD_N,
  NULL as SD_I,
  NULL as SN,
  NULL as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Короткострокові кредити, що отриманi вiд iнших банкiв' as NAME,
  1623 as VIDD,
  '162301' as SS,
  '162305' as SP,
  '701706' as SD_N,
  '701705' as SD_I,
  '162802' as SN,
  '162802' as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Короткі кредити, що отриманi вiд мiжнародних та iнвестицiйних банкiв
' as NAME,
  1625 as VIDD,
  '162302' as SS,
  '162305' as SP,
  '701707' as SD_N,
  '701708' as SD_I,
  '162803' as SN,
  '162803' as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Довгостроковi кредити, що отриманi вiд iнших банкiв' as NAME,
  1624 as VIDD,
  '162303' as SS,
  '162305' as SP,
  '701702' as SD_N,
  '701701' as SD_I,
  '162805' as SN,
  '162805' as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Довгострокові кредити, що отримані від міжнародних та інвестиційних банків' as NAME,
  1626 as VIDD,
  '162304' as SS,
  '162305' as SP,
  '701703' as SD_N,
  '701704' as SD_I,
  '162807' as SN,
  '162807' as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Короткі кредити, що отриманi вiд мiжнародних та iнших органiзацiй
' as NAME,
  2700 as VIDD,
  '270102' as SS,
  '270102' as SP,
  '706001' as SD_N,
  '706001' as SD_I,
  '270803' as SN,
  '270803' as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Кошти, що надані Національному банку України за операціями репо                                     ' as NAME,
  1211 as VIDD,
  NULL as SS,
  NULL as SP,
  NULL as SD_N,
  NULL as SD_I,
  NULL as SN,
  NULL as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Кредити овернайт, що отримані від Національного банку України шляхом рефінансування                 ' as NAME,
  1310 as VIDD,
  NULL as SS,
  NULL as SP,
  NULL as SD_N,
  NULL as SD_I,
  NULL as SN,
  NULL as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Інші кредити, що отримані від Національного банку України шляхом рефінансування                     ' as NAME,
  1312 as VIDD,
  NULL as SS,
  NULL as SP,
  NULL as SD_N,
  NULL as SD_I,
  NULL as SN,
  NULL as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Інші кредити, що отримані від Національного банку України                                           ' as NAME,
  1322 as VIDD,
  NULL as SS,
  NULL as SP,
  NULL as SD_N,
  NULL as SD_I,
  NULL as SN,
  NULL as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Довгі кредити, що отримані від міжнародних та інших організацій' as NAME,
  2701 as VIDD,
  '270101' as SS,
  '270101' as SP,
  '706003' as SD_N,
  '706003' as SD_I,
  '270801' as SN,
  '270801' as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Субординований борг банку                                                                           ' as NAME,
  3660 as VIDD,
  '366000' as SS,
  '366000' as SP,
  '714001' as SD_N,
  '714001' as SD_I,
  '366001' as SN,
  '366001' as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Грошове покриття в iнших банках' as NAME,
  1502 as VIDD,
  '150202' as SS,
  NULL as SP,
  NULL as SD_N,
  NULL as SD_I,
  NULL as SN,
  NULL as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Гарантiйнi депозити в iнших банках' as NAME,
  1501 as VIDD,
  '150201' as SS,
  NULL as SP,
  NULL as SD_N,
  NULL as SD_I,
  NULL as SN,
  NULL as SPN,
  1 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Кредити (депозити), що наданi (розмiщенi) на умовах субординованого боргу' as NAME,
  1514 as VIDD,
  '356000' as SS,
  '356000' as SP,
  '614000' as SD_N,
  '614000' as SD_I,
  '356800' as SN,
  '356800' as SPN,
  1 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Гарантiйнi депозити iнших банкiв' as NAME,
  1601 as VIDD,
  '160201' as SS,
  NULL as SP,
  NULL as SD_N,
  NULL as SD_I,
  NULL as SN,
  NULL as SPN,
  1 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Грошове покриття iнших банкiв' as NAME,
  1602 as VIDD,
  '160202' as SS,
  NULL as SP,
  NULL as SD_N,
  NULL as SD_I,
  NULL as SN,
  NULL as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Кошти iноземних iнвесторiв - iноземних банкiв' as NAME,
  1603 as VIDD,
  NULL as SS,
  NULL as SP,
  NULL as SD_N,
  NULL as SD_I,
  NULL as SN,
  NULL as SPN,
  0 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;

MERGE INTO BARS.MBDK_OB22 A USING
 (SELECT
  NULL as D_CLOSE,
  'Короткострокові вклади (депозити) інших банків' as NAME,
  1612 as VIDD,
  '161303' as SS,
  '161303' as SP,
  '701201' as SD_N,
  '701202' as SD_I,
  '161801' as SN,
  '161801' as SPN,
  1 as IO
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  D_CLOSE, NAME, VIDD, SS, SP, 
  SD_N, SD_I, SN, SPN, IO)
VALUES (
  B.D_CLOSE, B.NAME, B.VIDD, B.SS, B.SP, 
  B.SD_N, B.SD_I, B.SN, B.SPN, B.IO)
WHEN MATCHED THEN
UPDATE SET 
  A.D_CLOSE = B.D_CLOSE,
  A.NAME = B.NAME,
  A.SS = B.SS,
  A.SP = B.SP,
  A.SD_N = B.SD_N,
  A.SD_I = B.SD_I,
  A.SN = B.SN,
  A.SPN = B.SPN,
  A.IO = B.IO;
COMMIT;
end;
/
