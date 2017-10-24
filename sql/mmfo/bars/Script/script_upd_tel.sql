--prompt Актуализируем поле tel в skrynka_nd из таблицы person
BEGIN
  
    FOR rec IN (SELECT DISTINCT (n.branch)
                  from skrynka_nd n
                 where n.sos <> 15)
    
     LOOP
      bc.go(rec.branch);

      BEGIN
        SAVEPOINT sp1;
      
        UPDATE skrynka_nd n
           SET n.tel = safe_deposit.f_get_cust_tel(n.rnk)
         where n.nd in (select n.nd
                        from skrynka_nd n,customer c 
                        where n.sos <> 15
                        and n.rnk is not null
                        and c.rnk = n.rnk
                        and c.custtype = 3)
           AND n.branch = rec.branch;
      
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK TO sp1;
        
      END;
      bc.home;

    END LOOP;
COMMIT;    

EXCEPTION
  WHEN OTHERS THEN
    NULL;
  
END;
/