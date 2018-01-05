BEGIN
  FOR rec IN (SELECT a.blkd
                    ,a.daos
                    ,a.dazs
                    ,r.*
                FROM bars.ree_tmp   r
                    ,bars.accounts  a
                    ,bars.ACCOUNTSW aw
               WHERE a.acc = aw.acc
                 AND aw.tag = 'PRIM_CL'
                 AND r.nls = a.nls
                 AND r.kv = a.kv
                 AND fn_o IS NULL)
  LOOP
    bc.go(rec.kf);
     -- исправить дату закрытия счёта на отправку в ДПА
    UPDATE ree_tmp ree
       SET ree.odat = rec.dazs
     WHERE ree.nls = rec.nls
       AND ree.kv = rec.kv
       AND ree.ot = 5;
    -- удалить счета на открытие, пользователь случайно создал
    DELETE FROM ree_tmp ree
     WHERE ree.nls = rec.nls
       AND ree.kv = rec.kv
       AND ree.ot = 1;
  END LOOP;
  COMMIT;
END;
