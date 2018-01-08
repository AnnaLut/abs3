begin 
  execute immediate 'ALTER TABLE BARS.REZ_DEB_KOL_FIN_PD DROP PRIMARY KEY CASCADE';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/


begin 
  execute immediate 'DROP TABLE BARS.REZ_DEB_KOL_FIN_PD CASCADE CONSTRAINTS';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/

begin

  if getglobaloption('HAVETOBO') = 2 then   

     execute immediate 'begin bpa.alter_policy_info(''REZ_DEB_KOL_FIN_PD'', ''WHOLE'' , null , null, null, null ); end;'; 
     execute immediate 'begin bpa.alter_policy_info(''REZ_DEB_KOL_FIN_PD'', ''FILIAL'', null , null, null, null ); end;';

     EXECUTE IMMEDIATE 'create table BARS.REZ_DEB_KOL_FIN_PD'||
      '(deb     integer,
        kol_min number,
        kol_max number,
        fin     integer,
        PD      number)';

  end if;

exception when others then
  -- ORA-00955: name is already used by an existing object
  if SQLCODE = -00955 then null;   else raise; end if; 
end;
/

begin
  if getglobaloption('HAVETOBO') = 2 then    
     execute immediate 'begin   bpa.alter_policies(''REZ_DEB_KOL_FIN_PD''); end;'; 
   end if;
end;
/
commit;
-------------------------------------------------------------
COMMENT ON TABLE  BARS.REZ_DEB_KOL_FIN_PD         IS 'Довідник груп формування резерву';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD.kol_min IS 'К-ть днів просрочення від';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD.kol_max IS 'К-ть днів просрочення до';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD.fin     IS 'Клас контрагента';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD.pd      IS 'Значення коефіцієнту імовірності дефолту ';
COMMENT ON COLUMN BARS.REZ_DEB_KOL_FIN_PD.deb     IS 'Тип дебиторки 1-фин. 2-хоз';

Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1,  0, 0.99, 1,0);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1,  1,  5, 1,0.03);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1,  6, 10, 1,0.05);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1, 11, 15, 1,0.08);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1, 16, 20, 1,0.14);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1, 21, 25, 1,0.20);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1, 26, 30, 1,0.27);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1, 31, 40, 1,0.35);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1, 41, 50, 1,0.50);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1, 51, 60, 1,0.65);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1, 61, 75, 1,0.85);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1, 76, 90, 1,0.99);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (1, 91,9999999,2,1);

Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (2,  0,     90,1,0);
Insert into BARS.REZ_DEB_KOL_FIN_PD (deb, kol_min, kol_max, fin, pd) Values (2, 91,9999999,2,1);
COMMIT;

begin
   execute immediate 'CREATE INDEX I1_REZ_DEB_KOL_FIN_PD ON REZ_DEB_KOL_FIN_PD (deb)';
   exception when others then if (sqlcode = -00955 or sqlcode = -54) then null; else raise; end if;    
end;
/

exec bars_policy_adm.alter_policy_info(p_table_name => 'REZ_DEB_KOL_FIN_PD', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => null, p_update_policy => null, p_delete_policy => null); 
exec bars_policy_adm.alter_policy_info(p_table_name => 'REZ_DEB_KOL_FIN_PD', p_policy_group => 'FILIAL', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');   
exec bars_policy_adm.alter_policies(p_table_name => 'REZ_DEB_KOL_FIN_PD');

GRANT SELECT ON BARS.REZ_DEB_KOL_FIN_PD TO RCC_DEAL;
GRANT SELECT ON BARS.REZ_DEB_KOL_FIN_PD TO START1;
GRANT SELECT ON BARS.REZ_DEB_KOL_FIN_PD TO BARS_ACCESS_DEFROLE;

COMMIT;

