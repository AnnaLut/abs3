begin

     execute immediate 'begin bpa.alter_policy_info(''REZ_PAR_9200'', ''WHOLE'' , null , null, null, null ); end;'; 
     execute immediate 'begin bpa.alter_policy_info(''REZ_PAR_9200'', ''FILIAL'', null , null, null, null ); end;';

     EXECUTE IMMEDIATE 'create table BARS.REZ_PAR_9200'||
      '(rnk     integer,
        nd      integer,
        fin     number,
        VKR     VARCHAR2(3),
        PD      number)
        tablespace BRSMDLD';

exception when others then
  -- ORA-00955: name is already used by an existing object
  if SQLCODE = -00955 then null;   else raise; end if; 
end;
/

begin
  if getglobaloption('HAVETOBO') = 2 then    
     execute immediate 'begin   bpa.alter_policies(''REZ_PAR_9200''); end;'; 
   end if;
end;
/
commit;
-------------------------------------------------------------
COMMENT ON TABLE  BARS.REZ_PAR_9200         IS '��������� �������';
COMMENT ON COLUMN BARS.REZ_PAR_9200.rnk     IS '���';
COMMENT ON COLUMN BARS.REZ_PAR_9200.nd      IS '��� ��������';
COMMENT ON COLUMN BARS.REZ_PAR_9200.fin     IS '���� �����������';
COMMENT ON COLUMN BARS.REZ_PAR_9200.pd      IS '�������� ����������� ��������� ������� ';
COMMENT ON COLUMN BARS.REZ_PAR_9200.vkr     IS '���';

begin
  EXECUTE IMMEDIATE 
 'ALTER TABLE REZ_PAR_9200 ADD (CONSTRAINT PK_REZ_PAR_9200 PRIMARY KEY (RNK,ND))';
exception when others then
  -- ORA-02260: table can have only one primary key
  if SQLCODE = -02260 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table REZ_PAR_9200 add (COMM  varchar2(254)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_PAR_9200.COMM  IS 'ϳ������';

begin
 execute immediate   'alter table REZ_PAR_9200 add (fdat  date) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN REZ_PAR_9200.fdat  IS '����� ����';


exec bars_policy_adm.add_column_kf(p_table_name => 'REZ_PAR_9200');
exec bars_policy_adm.alter_policy_info(p_table_name => 'REZ_PAR_9200', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
exec bars_policy_adm.alter_policy_info(p_table_name => 'REZ_PAR_9200', p_policy_group => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'M', p_update_policy => 'M', p_delete_policy => 'M');
exec bars_policy_adm.alter_policies(p_table_name => 'REZ_PAR_9200');

GRANT SELECT ON BARS.REZ_PAR_9200 TO RCC_DEAL;
GRANT SELECT ON BARS.REZ_PAR_9200 TO START1;
GRANT SELECT ON BARS.REZ_PAR_9200 TO BARS_ACCESS_DEFROLE;

COMMIT;

