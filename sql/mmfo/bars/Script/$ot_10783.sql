--------------------------------------------------------------------- 
--
--  ������� ����� ���.�������� �������� VOVDP:  
--         = 1 - ���� � ���
--         = 2 - ���� � ���
---------------------------------------------------------------------

Begin
  INSERT INTO OP_FIELD 
      ( TAG, NAME, 
        FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH
      )
  VALUES  
      ( 'VOVDP', '������ ����: 1 - ���, 2 - ���',  
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1 
      ); 
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/

commit;

---------------------------------------------------------------------


