BEGIN
   INSERT INTO VOB (VOB,
                    NAME,
                    FLV,
                    REP_PREFIX)
        VALUES (406,
                '«¿ﬂ¬¿ Õ¿ œ≈–≈ ¿« √Œ“I¬ »',
                1,
                'ORDER23');
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/
COMMIT;