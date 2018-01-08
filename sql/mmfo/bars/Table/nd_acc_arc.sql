

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_ACC_ARC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ND_ACC_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_ACC_ARC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ND_ACC_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ND_ACC_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_ACC_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_ACC_ARC 
   (	ND NUMBER(*,0), 
	ACC NUMBER(*,0), 
	MDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ND_ACC_ARC ***
 exec bpa.alter_policies('ND_ACC_ARC');


COMMENT ON TABLE BARS.ND_ACC_ARC IS 'Архив привязки счетов и договоров';
COMMENT ON COLUMN BARS.ND_ACC_ARC.ND IS 'Реф. договора';
COMMENT ON COLUMN BARS.ND_ACC_ARC.ACC IS 'ACC счета';
COMMENT ON COLUMN BARS.ND_ACC_ARC.MDAT IS 'Дата среза.';

exec bars_policy_adm.add_column_kf(p_table_name => 'ND_ACC_ARC');
exec bars_policy_adm.alter_policy_info(p_table_name => 'ND_ACC_ARC', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
exec bars_policy_adm.alter_policy_info(p_table_name => 'ND_ACC_ARC', p_policy_group => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'M', p_update_policy => 'M', p_delete_policy => 'M');
exec bars_policy_adm.alter_policies(p_table_name => 'ND_ACC_ARC');

PROMPT *** Create  constraint PK_NDACCARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC_ARC ADD CONSTRAINT PK_NDACCARC PRIMARY KEY (MDAT, ND, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NDACCARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NDACCARC ON BARS.ND_ACC_ARC (MDAT, ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ND_ACC_ARC ***
grant SELECT                                                                 on ND_ACC_ARC      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ND_ACC_ARC      to BARS_DM;
grant SELECT                                                                 on ND_ACC_ARC      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_ACC_ARC.sql =========*** End *** ==
PROMPT ===================================================================================== 
