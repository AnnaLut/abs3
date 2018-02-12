UPDATE op_rules
   SET opt = 'O', nomodify = 1
 WHERE tag IN ('PDV', 'TAROB', 'TARON') AND tt IN ('K20', 'K24','K21');

COMMIT;

DELETE ps_tts
 WHERE tt IN ('428', '429') AND nbs IN ('1001', '1002') AND ob22 = '01';
/

COMMIT;

BEGIN
   INSERT INTO BARS.PS_TTS (TT, NBS, DK)
        VALUES ('428', '1001', 0);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/

BEGIN
   INSERT INTO BARS.PS_TTS (TT, NBS, DK)
        VALUES ('429', '1001', 1);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/

BEGIN
   INSERT INTO BARS.PS_TTS (TT, NBS, DK)
        VALUES ('428', '1002', 0);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/

BEGIN
   INSERT INTO BARS.PS_TTS (TT, NBS, DK)
        VALUES ('429', '1002', 1);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/

COMMIT;