CREATE OR REPLACE VIEW V_VISALIST_XRM AS
SELECT o.REF AS REF,                                            -- кто ввел
          0 AS Counter,
          0 AS Sqnc,
          'Ввів документ' AS Mark,
          0 AS MarkID,
          NULL AS CheckGroup_id,
          NULL AS CheckGroup,
          s.fio AS UserName,
          pdat AS Dat,
          0 AS Incharge
     FROM oper o, staff$base s
    WHERE o.userid = s.id
   UNION ALL
   SELECT o.REF AS REF,                                     -- наложенные визы
          ct.priority AS Counter,
          ov.sqnc AS Sqnc,
          DECODE (status,
                  1, 'Візував',
                  2, 'Оплатив',
                  3, 'Сторнував',
                  NULL)
             AS Mark,
          DECODE (status,  1, 1,  2, 2,  3, 3,  NULL) AS MarkID,
          ov.groupid AS CheckGroup_id,
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
   SELECT o.REF AS REF,                 -- визы на упр. к/с, при сторнировании
          NULL AS Counter,
          ov.sqnc AS Sqnc,
          DECODE (status,
                  1, 'Візував',
                  2, 'Візував',
                  3, 'Сторнував',
                  NULL)
             AS Mark,
          DECODE (status,  1, 1,  2, 2,  3, 3,  NULL) AS MarkID,
          ov.groupid AS CheckGroup_id,
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
   SELECT o.REF AS REF,                                      -- ожидающие визы
          ct.priority AS Counter,
          999999999999999 AS Sqnc,
          'Очікує' AS Mark,
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
