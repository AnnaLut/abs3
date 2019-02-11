---------------------------------------------------------------------------
--                 COBUMMFO-10483
--
--  Включение доп.реквизита D1#3M - "Код мети для файлу 3МХ" - в 024 и IB1                              
--
--------------------------------------------------------------------------

                                       
Begin 

  For k in (Select TT from TTS 
            where  TT in ( '024','IB1') 
           )
  Loop

    begin
      insert into op_rules(TAG,     TT  , OPT, USED4INPUT, ORD, VAL ,  NOMODIFY)
                 values   ('D1#3M', k.TT, 'O',  1,         11 , null , null    );
    exception WHEN OTHERS THEN 
      null;
    end;

  End loop;

end;
/
commit;

