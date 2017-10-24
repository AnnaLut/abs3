BEGIN
   UPDATE tickets_par p
      SET p.rep_prefix = 'DEFAULT'
    WHERE txt like '%BMC%';
END;
/

COMMIT;