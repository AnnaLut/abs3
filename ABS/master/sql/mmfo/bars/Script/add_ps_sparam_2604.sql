BEGIN
   FOR c IN (SELECT '2604' AS nbs, spid
               FROM ps_sparam
              WHERE     spid IN (SELECT spid
                                   FROM sparam_list
                                  WHERE semantic LIKE '%SMS.%')
                    AND nbs = '2600')
   LOOP
      BEGIN
         INSERT INTO ps_sparam (nbs, spid)
              VALUES (c.nbs, c.spid);
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            NULL;
      END;
   END LOOP;
END;
/

commit;