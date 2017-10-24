-------------
prompt ####################################################################################
prompt ... Дополнения к справочнику типов счетов  D:\K\MMFO\kwt_2924\Sql\Data\ATM_dat.sql 
prompt ..........................................

declare tt tips%rowtype ;
begin   Suda;         tt.name := 'Нестача в АТМ';   tt.tip  := 'AT7'; 
        update  tips set name = tt.name where tip = tt.tip ; if SQL%rowcount = 0 then    Insert into tips (tip,NAME) values (tt.tip, tt.name) ; end if;
                      tt.name := 'Надлишки в АТМ';  tt.tip  := 'AT8';  
        update  tips set name = tt.name where tip = tt.tip ; if SQL%rowcount = 0 then    Insert into tips (tip,NAME) values (tt.tip, tt.name) ; end if;
        COMMIT;
end;
/
commit; 