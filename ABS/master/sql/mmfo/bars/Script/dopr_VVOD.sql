------------------------------------------------------------------
--
-- 1). ������� ����� ���.�������� ��������:
--          VVOD - "���� ���� �i�������� �� �i��������" 
--
-- 2). ���. ���.����. VVOD � �������� '001','002'                              
--
------------------------------------------------------------------


-- 1). ������� ����� ���.�������� ��������:
--          VVOD - "���� ���� �i�������� �� �i��������"

Begin
  INSERT INTO OP_FIELD 
      ( TAG, NAME, 
        FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH
      )
  VALUES  
      ( 'VVOD', '���� ���� �i�������� �� �i��������',  
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1 
      ); 
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/
commit;

------------------------------------------------------------------

-- 2). ��������� ���.�������� � �������� 001,002.  
--     ���.�������� VVOD:  "������������", �� �����. = 0 	 
                                       
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

