

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_VISALIST.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_VISALIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_VISALIST ("REF", "COUNTER", "SQNC", "MARK", "MARKID", "CHECKGROUP", "USERNAME", "DAT", "INCHARGE") AS 
  SELECT o.REF AS REF,                                            -- ��� ����
          0 AS Counter,
          0 AS Sqnc,
          '���� ��������' AS Mark,
          0 AS MarkID,
          NULL AS CheckGroup,
          s.fio AS UserName,
          pdat AS Dat,
          0 AS Incharge
     FROM oper o, staff$base s
    WHERE o.userid = s.id
   UNION ALL
   SELECT o.REF AS REF,                                     -- ���������� ����
          ct.priority AS Counter,
          ov.sqnc AS Sqnc,
          DECODE (status,
                  1, '���������',
                  2, '�������',
                  3, '�����������',
                  NULL)
             AS Mark,
          DECODE (status,  1, 1,  2, 2,  3, 3,  NULL) AS MarkID,
          ov.groupname AS CheckGroup,
          ov.username AS UserName,
          ov.dat AS Dat,
          ov.F_IN_CHARGE AS Incharge
     FROM oper o, oper_visa ov, chklist_tts ct
    WHERE     o.REF = ov.REF
          AND ov.passive IS NULL
          AND ov.status IN (1, 2, 3)
          AND ov.GROUPID = ct.IDCHK
          AND o.tt = ct.TT
   UNION ALL
   SELECT o.REF AS REF,                 -- ���� �� ���. �/�, ��� �������������
          NULL AS Counter,
          ov.sqnc AS Sqnc,
          DECODE (status,
                  1, '���������',
                  2, '���������',
                  3, '�����������',
                  NULL)
             AS Mark,
          DECODE (status,  1, 1,  2, 2,  3, 3,  NULL) AS MarkID,
          ov.groupname AS CheckGroup,
          ov.username AS UserName,
          ov.dat AS Dat,
          ov.F_IN_CHARGE AS Incharge
     FROM oper o, oper_visa ov
    WHERE     o.REF = ov.REF
          AND ov.passive IS NULL
          AND ov.status IN (1, 2, 3)
          AND (   ov.groupid IS NULL
               OR ov.groupid NOT IN (SELECT idchk
                                       FROM chklist_tts
                                      WHERE tt = o.tt))
   UNION ALL
   SELECT o.REF AS REF,                                      -- ��������� ����
          ct.priority AS Counter,
          999999999999999 AS Sqnc,
          '�������' AS Mark,
          4 AS MarkID,
          c.NAME AS CheckGroup,
          NULL AS UserName,
          NULL AS Dat,
          c.F_IN_CHARGE AS Incharge
     FROM oper o, chklist_tts ct, chklist c
    WHERE     o.tt = ct.TT
          AND ct.IDCHK = c.IDCHK
          AND ct.IDCHK NOT IN
                 (SELECT groupid
                    FROM oper_visa
                   WHERE     REF = o.REF
                         AND passive IS NULL
                         AND groupid IS NOT NULL)
          AND o.sos >= 0
          AND o.sos < 5
          AND chk.doc_is_valid (o.REF, ct.SQLVAL) = 1;

PROMPT *** Create  grants  V_VISALIST ***
grant SELECT                                                                 on V_VISALIST      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_VISALIST      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_VISALIST      to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_VISALIST      to WR_CHCKINNR_ALL;
grant SELECT                                                                 on V_VISALIST      to WR_CHCKINNR_CASH;
grant SELECT                                                                 on V_VISALIST      to WR_CHCKINNR_SELF;
grant SELECT                                                                 on V_VISALIST      to WR_CHCKINNR_SUBTOBO;
grant SELECT                                                                 on V_VISALIST      to WR_CHCKINNR_TOBO;
grant SELECT                                                                 on V_VISALIST      to WR_DOCLIST_TOBO;
grant SELECT                                                                 on V_VISALIST      to WR_DOCVIEW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_VISALIST.sql =========*** End *** ===
PROMPT ===================================================================================== 
