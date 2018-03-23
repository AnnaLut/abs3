---- ----------------------------------------------------------------------------------------------

--   Установка в проц.карточках счетов  2560,2565 ПФУ и 2604/02 Укрпошти % ставки =  1/2 ставки НБУ
--   ==============================================================================================

--   C 02.03.2018 значение % ставки НБУ = 17 %
--   По счетам 2560,2565 ПФУ и 2604/02 Укрпошти ставка должна быть  =  1/2 ставки НБУ
--   Предидущая ставка НБУ:  16 %   
--------------------------------------------------------------------------------------------------


declare
  stvk_    number(20,4);
  bdat_    date;
Begin
  
  TUDA;  

  stvk_ := 8.5 ;                                 ---  Ставкa 17/2 = 8.5 %
  bdat_ := to_date('02/03/2018','dd/mm/yyyy');   ---  C даты

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
                               IR   = 8  and 
                               BDAT = to_date('26/01/2018','dd/mm/yyyy')
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


