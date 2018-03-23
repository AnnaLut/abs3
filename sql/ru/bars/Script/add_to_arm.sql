BEGIN
   INSERT INTO REFAPP (TABID,
                       CODEAPP,
                       ACODE,
                       APPROVE,
                       GRANTOR)
        VALUES (get_tabid ('INS_TYPES'),
                'WIAU',
                'RW',
                1,
                1);

   INSERT INTO REFAPP (TABID,
                       CODEAPP,
                       ACODE,
                       APPROVE,
                       GRANTOR)
        VALUES (get_tabid ('INS_EWA_TYPES'),
                'WIAU',
                'RW',
                1,
                1);

   INSERT INTO REFAPP (TABID,
                       CODEAPP,
                       ACODE,
                       APPROVE,
                       GRANTOR)
        VALUES (get_tabid ('INS_EWA_TYPES'),
                'WIAF',
                'RW',
                1,
                1);

   INSERT INTO REFAPP (TABID,
                       CODEAPP,
                       ACODE,
                       APPROVE,
                       GRANTOR)
        VALUES (get_tabid ('INS_TYPES'),
                'WIAF',
                'RW',
                1,
                1);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/

COMMIT;