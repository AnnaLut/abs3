begin
   update cc_vidd set CUSTTYPE = 2, tipd=2, NAME = '��������� 2700 - ����������.������� �� ������� �� �����. �� ��.���.' where vidd =2700;
   IF SQL%ROWCOUNT=0 then
      Insert into BARS.CC_VIDD (VIDD, CUSTTYPE, TIPD, NAME) Values (2700, 2, 2, '��������� 2700 - ����������.������� �� ������� �� �����. �� ��.���.');
   end if; 

   update cc_vidd set CUSTTYPE = 2, tipd=2, NAME = '��������� 2701 - ��������.������� ������� �� ������.' where vidd =2701; 
   IF SQL%ROWCOUNT=0 then
      Insert into BARS.CC_VIDD (VIDD, CUSTTYPE, TIPD, NAME) Values (2701, 2, 2, '��������� 2701  - ��������.������� ������� �� ������.');
   end if; 

   update cc_vidd set CUSTTYPE = 2, tipd=2, NAME = '��������� 3660 - ������������. ����' where vidd =3660;
   IF SQL%ROWCOUNT=0 then
      Insert into BARS.CC_VIDD (VIDD, CUSTTYPE, TIPD, NAME) Values (3660, 2, 2, '��������� 3660 - ������������. ����');
   end if; 
   commit;
end;
/