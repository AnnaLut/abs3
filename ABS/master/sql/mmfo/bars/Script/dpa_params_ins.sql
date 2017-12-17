BEGIN
  FOR rec IN (SELECT *
                FROM MV_KF)
  LOOP
    bc.go(rec.kf);
    INSERT INTO DPA_PARAMS
      (PAR
      ,VAL
      ,COMM)
    VALUES
      ('prt_' || rec.kf
      ,'c:\bars_dpa\' || rec.kf || '\prints'
      ,'Директорія для друкованих файлів');
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -1 THEN
      NULL;
    ELSE
      RAISE;
    END IF;
END;
/
COMMIT;
