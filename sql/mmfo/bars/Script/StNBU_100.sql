BEGIN
   FOR k IN (SELECT kf
               FROM mv_kf)
   LOOP
      bc.go (k.kf);

      BEGIN
         INSERT INTO BR_NORMAL_EDIT (BR_ID,
                                     BDATE,
                                     KV,
                                     RATE)
              VALUES (100,
                      TO_DATE ('27/10/2017', 'DD/MM/YYYY'),
                      980,
                      13.5);
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            NULL;
      END;

      BEGIN
         INSERT INTO BR_NORMAL_EDIT (BR_ID,
                                     BDATE,
                                     KV,
                                     RATE)
              VALUES (100,
                      TO_DATE ('27/10/2017', 'DD/MM/YYYY'),
                      840,
                      13.5);
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            NULL;
      END;

      BEGIN
         INSERT INTO BR_NORMAL_EDIT (BR_ID,
                                     BDATE,
                                     KV,
                                     RATE)
              VALUES (100,
                      TO_DATE ('27/10/2017', 'DD/MM/YYYY'),
                      978,
                      13.5);
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            NULL;
      END;

      BEGIN
         INSERT INTO BR_NORMAL_EDIT (BR_ID,
                                     BDATE,
                                     KV,
                                     RATE)
              VALUES (100,
                      TO_DATE ('27/10/2017', 'DD/MM/YYYY'),
                      643,
                      13.5);
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



-