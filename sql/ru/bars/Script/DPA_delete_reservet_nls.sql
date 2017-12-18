BEGIN
  FOR rec IN (-- зарезервированняе счета, которые попали на отправку в ДПА
              SELECT ree.*
                FROM bars.accounts a
                    ,bars.ree_tmp  ree
               WHERE a.nls = ree.nls
                 AND a.kv = ree.kv
                 AND a.nbs IS NULL
                 AND a.daos = a.dazs
                 AND ree.fn_o IS NULL)
  LOOP
    bc.go(rec.kf);
    DELETE FROM ree_tmp r
     WHERE r.kf = rec.kf
       AND r.nls = rec.nls
       AND r.kv = rec.kv
       AND r.odat = rec.odat
       AND r.fn_o IS NULL;
  END LOOP;
  COMMIT;
END;
/
