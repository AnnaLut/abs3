--------------------------------------------------------------------------------------------- 
--  ������� ����� ���.�������� �������� KMVIP - "������� ����� � VIP (1-���,2-ͳ)"  
---------------------------------------------------------------------------------------------

Begin
  INSERT INTO OP_FIELD 
      ( TAG, NAME, 
        FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH
      )
  VALUES  
      ( 'KMVIP', '������� ����� � VIP (1-���,2-ͳ)',  
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1 
      ); 
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/

COMMIT;

---------------------------------------------------------------------

Begin
  Insert into BARS.VOB
    (VOB, NAME, FLV, REP_PREFIX)
  Values
    (480, '����� �� ������ ���. + ����.��' , 1, 'ORDER80');
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/

COMMIT;
---------------------------------------------------------------------

Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'VIP_KD9', 'select distinct (tt) from opldok where ref=:nRecID and tt=''KD9''', '��� ���������� KD9', 'TIC');

COMMIT;
----------------------------------------------------------------------


