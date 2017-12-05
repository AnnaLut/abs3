exec bpa.alter_policy_info( 'TRANSFER_2017', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'TRANSFER_2017', 'FILIAL', null, null, null, null );

begin    execute immediate ' CREATE TABLE BARS.TRANSFER_2017( R020_OLD CHAR(4), OB_OLD CHAR(2),  R020_NEW CHAR(4), OB_NEW CHAR(2) , DAT_BEG DATE, DAT_END DATE, COMM VARCHAR2(100) , COL INT) ' ;
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

exec  bpa.alter_policies('TRANSFER_2017'); 

COMMENT ON TABLE  BARS.TRANSFER_2017          IS '	';
COMMENT ON COLUMN BARS.TRANSFER_2017.R020_OLD IS 'Бал~OLD';
COMMENT ON COLUMN BARS.TRANSFER_2017.OB_OLD   IS 'Ан~OLD  ';
COMMENT ON COLUMN BARS.TRANSFER_2017.R020_NEW IS 'Бал~NEW';
COMMENT ON COLUMN BARS.TRANSFER_2017.OB_NEW   IS 'Ан~NEW  ';
COMMENT ON COLUMN BARS.TRANSFER_2017.DAT_BEG  IS 'Дата поч~зміни';
COMMENT ON COLUMN BARS.TRANSFER_2017.DAT_END  IS 'Дата кін~зміни';
COMMENT ON COLUMN BARS.TRANSFER_2017.COMM     IS 'Коментар~';
COMMENT ON COLUMN BARS.TRANSFER_2017.COL      IS 'Інд~кол';

begin  EXECUTE IMMEDIATE 'ALTER TABLE  TRANSFER_2017 ADD  (id1 number) ' ;
exception when others then   if SQLCODE = - 01430 then null;   else raise; end if; -- ORA-01430: column being added already exists in table
end;
/

begin  EXECUTE IMMEDIATE 'ALTER TABLE  bars.accounts  ADD  (DAT_ALT date ) ' ;
exception when others then   if SQLCODE = - 01430 then null;   else raise; end if; -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.ACCOUNTS.DAT_ALT IS 'Дата заміни NLS->NLSALT';



begin  EXECUTE IMMEDIATE 'ALTER TABLE  bars.specparam ADD  (Ob22_alt char(2) ) ' ;
exception when others then   if SQLCODE = - 01430 then null;   else raise; end if; -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.SPECPARAM.OB22_alt IS 'Ob22 для рах NLSALT';


------------------------------
exec bpa.alter_policy_info( 'NLS_2017', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'NLS_2017', 'FILIAL', null, null, null, null );

begin  execute immediate ' CREATE TABLE BARS.NLS_2017      ( nls_old varchar2(15), nls_new varchar2(15), KF varchar2(6) ) ' ;
       EXECUTE IMMEDIATE ' ALTER TABLE  BARS.NLS_2017 ADD   CONSTRAINT XPK_NLS2017  PRIMARY KEY  (KF, NLS_old) ' ;
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

exec  bpa.alter_policies('NLS_2017'); 

COMMENT ON TABLE  BARS.NLS_2017          IS 'Майбутны рах	';

---------------------
begin  EXECUTE IMMEDIATE 'ALTER TABLE  bars.CCK_OB22 ADD  (D_Close date ) ' ;
exception when others then   if SQLCODE = - 01430 then null;   else raise; end if; -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.CCK_OB22.D_Close IS 'Дата закриття продукту';

