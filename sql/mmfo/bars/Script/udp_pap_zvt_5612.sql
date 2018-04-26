BEGIN

UPDATE pap_zvt
      SET PRN = 4
    where tema in (20,
                                    13,
                                    15,
                                    19,
                                    29,
                                    30,
                                    35,
                                    45,
                                    36);                                
                                    
END;
/

COMMIT;