DECLARE
   g67_new    VARCHAR2 (15);
   v67_new    VARCHAR2 (15);
   g67n_new   VARCHAR2 (15);
   v67n_new   VARCHAR2 (15);

   FUNCTION get_nls_new (p_nls VARCHAR2)
      RETURN VARCHAR2
   IS
      L_NLS   VARCHAR2 (15);
   BEGIN
      L_NLS := p_nls;

      SELECT nls
        INTO L_NLS
        FROM accounts
       WHERE nlsalt = p_nls AND dat_alt IS NOT NULL AND dazs IS NULL;

      RETURN l_nls;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         L_NLS := p_nls;
         RETURN l_nls;
   END;

BEGIN
   FOR k IN (SELECT kf FROM mv_kf)
   LOOP
      bc.go (k.kf);

      FOR c IN (SELECT rowid as ri, d.*
                  FROM proc_dr$base d
                 WHERE d.nbs LIKE '390_' AND d.sour = 4)
      LOOP
         g67_new := get_nls_new (c.g67);
         v67_new := get_nls_new (c.v67);
         g67n_new := get_nls_new (c.g67n);
         v67n_new := get_nls_new (c.v67n);

         UPDATE proc_dr$base
            SET g67 = g67_new,
                v67 = v67_new,
                g67n = g67n_new,
                v67n = v67n_new
          WHERE rowid = c.ri;

      END LOOP;                                                           -- c
   END LOOP;                                                              -- k

   bc.home;
END;
/

COMMIT;