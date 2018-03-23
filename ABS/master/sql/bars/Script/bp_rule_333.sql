BEGIN
   FOR k IN (SELECT kf
               FROM mv_kf)
   LOOP
      bc.go (k.kf);

      BEGIN
         INSERT INTO BARS.BP_RRP (RULE,
                                  FA,
                                  BODY,
                                  NAME)
                 VALUES (
                           333,
                           '0',
                           'F_STOP_DPT_SEP(NLSB,KV,S, GL.BD)=1 AND MFOB=GL.KF and REGEXP_LIKE(NLSB, ''^263'')',
                           'Блокування депозитів на поповнення'); --, k.kf);
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            NULL;
      END;
   END LOOP;

   bc.home;
END;
/
COMMIT;
