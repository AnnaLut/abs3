CREATE OR REPLACE VIEW V_VISALIST_XRM AS
SELECT o.REF AS REF,                                            -- ��� ����
          0 AS Counter,
          0 AS Sqnc,
          '��� ��������' AS Mark,
          0 AS MarkID,
          NULL AS CheckGroup_id,
          NULL AS CheckGroup,
          s.active_directory_name AS UserName,
          pdat AS Dat,
          0 AS Incharge
     FROM oper o, staff_ad_user s
    WHERE o.userid = s.user_id 
   UNION ALL
   SELECT o.REF AS REF,                                     -- ���������� ����
          ct.priority AS Counter,
          ov.sqnc AS Sqnc,
          DECODE (status,
                  1, '³�����',
                  2, '�������',
                  3, '���������',
                  NULL)
             AS Mark,
          DECODE (status,  1, 1,  2, 2,  3, 3,  NULL) AS MarkID,
          ov.groupid AS CheckGroup_id,
          ov.groupname AS CheckGroup,
          s.active_directory_name AS UserName,
          ov.dat AS Dat,
          ov.F_IN_CHARGE AS Incharge
     FROM oper o, oper_visa ov, chklist_tts ct, staff_ad_user s
    WHERE     o.REF = ov.REF
          AND ov.passive IS NULL
          AND ov.status IN (1, 2, 3)
          AND ov.GROUPID = ct.IDCHK
          AND o.tt = ct.TT
          and s.user_id = ov.userid
   UNION ALL
   SELECT o.REF AS REF,                 -- ���� �� ���. �/�, ��� �������������
          NULL AS Counter,
          ov.sqnc AS Sqnc,
          DECODE (status,
                  1, '³�����',
                  2, '³�����',
                  3, '���������',
                  NULL)
             AS Mark,
          DECODE (status,  1, 1,  2, 2,  3, 3,  NULL) AS MarkID,
          ov.groupid AS CheckGroup_id,
          ov.groupname AS CheckGroup,
          s.active_directory_name AS UserName,
          ov.dat AS Dat,
          ov.F_IN_CHARGE AS Incharge
     FROM oper o, oper_visa ov, staff_ad_user s
    WHERE     o.REF = ov.REF
          AND ov.passive IS NULL
          AND ov.status IN (1, 2, 3)
          and s.user_id = ov.userid
          AND (   ov.groupid IS NULL
               OR ov.groupid NOT IN (SELECT idchk
                                       FROM chklist_tts
                                      WHERE tt = o.tt))
   UNION ALL
   SELECT o.REF AS REF,                                      -- ��������� ����
          ct.priority AS Counter,
          999999999999999 AS Sqnc,
          '�����' AS Mark,
          4 AS MarkID,
          c.idchk AS CheckGroup_id,
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
          AND chk.doc_is_valid (o.REF, ct.SQLVAL) = 1
;
