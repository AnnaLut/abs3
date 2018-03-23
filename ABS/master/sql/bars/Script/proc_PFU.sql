---- ------------------------------------------------------------------------
--   C 27.10.2017 значение % ставки НБУ = 13.5
--
--   По счетам 2560,2565 ПФУ ставка должна быть равна 1/2 ставки НБУ
--
----------------------------------------------------------------------------


declare
  stvk_    number(20,4);
  bdat_    date;
Begin


  
  TUDA;  



  stvk_ := 6.75 ;      ---  ставкa 13.5/2 = 6.75

  bdat_ := to_date('27/10/2017','dd/mm/yyyy'); ---  c даты


  FOR k in ( Select ACC from Accounts where           
                   KV=980     and  DAZS is NULL   and                      
                   (  NBS='2560'  and                                          
                      RNK in (Select RNK from RNKP_KOD where KODK=1)
                    or
                      NBS='2604' and  
                      RNK in (Select RNK from RNKP_KOD where KODK=2)
                   )
                   and
                   ACC in ( Select ACC from INT_RATN where
                               ID   = 1     and 
                               IR   = 6.25  and 
                               BDAT = to_date('28/07/2017','dd/mm/yyyy')
                          )
           )

  LOOP

  begin
    Insert into INT_RATN 
      ( ACC  , ID, BDAT , IR   , IDU )
    VALUES
      ( k.ACC, 1 , bdat_, stvk_,  1  ) ;
  exception when dup_val_on_index then null;
  end;

  END LOOP; 
  
END;
/

COMMIT;


