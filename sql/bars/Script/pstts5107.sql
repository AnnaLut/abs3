begin
BEGIN
   INSERT INTO BARS.PS_TTS (TT, NBS, DK)
        VALUES ('PR1', '9714', 0);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;

BEGIN
   INSERT INTO BARS.PS_TTS (TT, NBS, DK)
        VALUES ('PR3', '9711', 1);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;

BEGIN
   INSERT INTO BARS.PS_TTS (TT, NBS, DK)
        VALUES ('PR1', '9910', 1);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;

BEGIN
   INSERT INTO BARS.PS_TTS (TT,
                            NBS,
                            DK,
                            ob22)
        VALUES ('053',
                '2924',
                0,
                '33');
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;

end;
/

COMMIT;