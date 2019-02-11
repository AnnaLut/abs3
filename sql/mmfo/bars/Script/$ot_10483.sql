---------------------------------------------------------------------------
--                 COBUMMFO-10483
--
--  ��������� ���.��������� D1#3M - "��� ���� ��� ����� 3��" - � 024 � IB1                              
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

