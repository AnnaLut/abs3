-------------
prompt ####################################################################################
prompt ... ���������� � ����������� ����� ������  D:\K\MMFO\kwt_2924\Sql\Data\ATM_dat.sql 
prompt ..........................................

declare tt tips%rowtype ;
begin   Suda;         tt.name := '������� � ���';   tt.tip  := 'AT7'; 
        update  tips set name = tt.name where tip = tt.tip ; if SQL%rowcount = 0 then    Insert into tips (tip,NAME) values (tt.tip, tt.name) ; end if;
                      tt.name := '�������� � ���';  tt.tip  := 'AT8';  
        update  tips set name = tt.name where tip = tt.tip ; if SQL%rowcount = 0 then    Insert into tips (tip,NAME) values (tt.tip, tt.name) ; end if;
        COMMIT;
end;
/
commit; 