PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_OB22_TIP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_OB22_TIP ***


BEGIN 
   execute immediate  
      'begin  
          bpa.alter_policy_info(''NBS_OB22_TIP'', ''FILIAL'' , null, null, null, null);
          bpa.alter_policy_info(''NBS_OB22_TIP'', ''WHOLE'' , null, null, null, null);
          null;
       end; 
       '; 
END; 
/

PROMPT *** Create  table NBS_OB22_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_OB22_TIP 
   (	NBS CHAR(4), 
	OB22 VARCHAR2(2), 
	TIP  VARCHAR2(3)   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to NBS_OB22_TIP ***
 exec bpa.alter_policies('NBS_OB22_TIP');

PROMPT *** Create  index XPK_SREZ_OB22_F ***

begin
  EXECUTE IMMEDIATE 
 'ALTER TABLE NBS_OB22_TIP ADD CONSTRAINT XPK_NBS_OB22_TIP PRIMARY KEY (NBS, OB22)';
exception when others then
  -- ORA-02260: table can have only one primary key
  if SQLCODE = -02260 then null;   else raise; end if; 
end;
/

PROMPT *** Create  index I1_NBS_OB22_TIP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_NBS_OB22_TIP ON BARS.NBS_OB22_TIP (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

exec bars_policy_adm.alter_policy_info(p_table_name => 'REZ_DEB', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => null, p_update_policy => null, p_delete_policy => null); 
exec bars_policy_adm.alter_policy_info(p_table_name => 'REZ_DEB', p_policy_group => 'FILIAL', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');   
exec bars_policy_adm.alter_policies(p_table_name => 'REZ_DEB');

PROMPT *** Create  grants  NBS_OB22_TIP ***
grant DELETE,INSERT,SELECT,UPDATE   on NBS_OB22_TIP    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE   on NBS_OB22_TIP    to START1;
grant DELETE,INSERT,SELECT,UPDATE   on NBS_OB22_TIP    to WR_ALL_RIGHTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_OB22_TIP.sql =========*** End *** 
PROMPT ===================================================================================== 
