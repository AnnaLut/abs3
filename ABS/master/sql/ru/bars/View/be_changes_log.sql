

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BE_CHANGES_LOG.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view BE_CHANGES_LOG ***

  CREATE OR REPLACE FORCE VIEW BARS.BE_CHANGES_LOG ("PATH_NAME", "INS_DATE", "INS_USER", "ACTION", "DESCR", "FILE_DATE", "FILE_SIZE", "VERSION") AS 
  SELECT PATH_NAME, INS_DATE, INS_USER, '����������' ACTION, DESCR, FILE_DATE, FILE_SIZE, VERSION
FROM BE_LIBS
WHERE
  PATH_NAME NOT IN (SELECT PATH_NAME FROM BE_LIBS_ARC)
UNION ALL
--���������� ����������� � �������� �������
SELECT PATH_NAME, INS_DATE, INS_USER, '����������' ACTION, DESCR, FILE_DATE, FILE_SIZE, VERSION
FROM BE_LIBS
WHERE
  PATH_NAME IN (SELECT PATH_NAME FROM BE_LIBS_ARC)
UNION ALL
--���������� ������� ����������� � ������
SELECT PATH_NAME, INS_DATE, INS_USER, '����������' ACTION, DESCR, FILE_DATE, FILE_SIZE, VERSION
FROM BE_LIBS_ARC
WHERE
  INS_DATE=(SELECT MIN(INS_DATE) FROM BE_LIBS_ARC A WHERE A.PATH_NAME=PATH_NAME)
UNION ALL
--��������� ����������
SELECT PATH_NAME, INS_DATE, INS_USER, '��������' ACTION, DESCR, FILE_DATE, FILE_SIZE, VERSION
FROM BE_DELETED_LIBS
UNION ALL
--���������� ������� ����������� � ������
SELECT PATH_NAME, INS_DATE, INS_USER, '����������' ACTION, DESCR, FILE_DATE, FILE_SIZE, VERSION
FROM BE_LIBS_ARC
WHERE
  PATH_NAME IN (SELECT PATH_NAME FROM BE_LIBS) AND
  INS_DATE<>(SELECT MIN(INS_DATE) FROM BE_LIBS_ARC A WHERE A.PATH_NAME=PATH_NAME) AND
  (PATH_NAME,INS_DATE) NOT IN (SELECT PATH_NAME, INS_DATE FROM BE_LIBS);

PROMPT *** Create  grants  BE_CHANGES_LOG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BE_CHANGES_LOG  to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on BE_CHANGES_LOG  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BE_CHANGES_LOG  to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BE_CHANGES_LOG  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BE_CHANGES_LOG.sql =========*** End ***
PROMPT ===================================================================================== 
