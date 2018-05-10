------------------------------------------------------------------
--
-- 1). —оздаем новый доп.реквизит операции:
--          VVOD - "¬вод було вiдкладено на пiсл€ќп„ас" 
--
-- 2). ¬кл. доп.рекв. VVOD в операции '001','002'                              
--
------------------------------------------------------------------


-- 1). —оздаем новый доп.реквизит операции:
--          VVOD - "¬вод було вiдкладено на пiсл€ќп„ас"

Begin
  INSERT INTO OP_FIELD 
      ( TAG, NAME, 
        FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH
      )
  VALUES  
      ( 'VVOD', '¬вод було вiдкладено на пiсл€ќп„ас',  
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1 
      ); 
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/
commit;

------------------------------------------------------------------

-- 2). ƒобавл€ем доп.реквизит в операции 001,002.  
--     ƒоп.реквизит VVOD:  "об€зательный", по умолч. = 0 	 
                                       
Begin 

  For k in (Select TT from TTS 
            where  TT in ( '001','002') 
           )
  Loop

    begin
      insert into op_rules(TAG,     TT  , OPT, USED4INPUT, ORD, VAL , NOMODIFY)
                 values   ('VVOD', k.TT, 'M',  1,          0 , '0' , null    );

    exception WHEN OTHERS THEN 

      update op_rules set OPT='M', VAL='0' where TT=k.TT and TAG='VVOD';

    end;

  End loop;

end;
/
commit;

