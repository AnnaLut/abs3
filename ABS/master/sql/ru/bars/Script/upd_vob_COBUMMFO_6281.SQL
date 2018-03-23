BEGIN
   UPDATE vob
      SET rep_prefix   = 'ORDER24'
    WHERE vob = 230;
END;
/

COMMIT;