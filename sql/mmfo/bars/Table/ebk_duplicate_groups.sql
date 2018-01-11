

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_DUPLICATE_GROUPS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_DUPLICATE_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_DUPLICATE_GROUPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_DUPLICATE_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_DUPLICATE_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_DUPLICATE_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_DUPLICATE_GROUPS 
   (	M_RNK NUMBER(38,0), 
	D_RNK NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBK_DUPLICATE_GROUPS ***
 exec bpa.alter_policies('EBK_DUPLICATE_GROUPS');


COMMENT ON TABLE BARS.EBK_DUPLICATE_GROUPS IS '������� �������� �������� � ��������� ��� ������������';
COMMENT ON COLUMN BARS.EBK_DUPLICATE_GROUPS.KF IS '';
COMMENT ON COLUMN BARS.EBK_DUPLICATE_GROUPS.M_RNK IS '';
COMMENT ON COLUMN BARS.EBK_DUPLICATE_GROUPS.D_RNK IS '';




PROMPT *** Create  constraint CC_EBKDUPLICATEGROUPS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_DUPLICATE_GROUPS MODIFY (KF CONSTRAINT CC_EBKDUPLICATEGROUPS_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_EBKDUPLICATEGROUPS ***
begin   
 execute immediate '
  CREATE INDEX BARS.UK_EBKDUPLICATEGROUPS ON BARS.EBK_DUPLICATE_GROUPS (KF, M_RNK, D_RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBK_DUPLICATE_GROUPS ***
grant SELECT                                                                 on EBK_DUPLICATE_GROUPS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EBK_DUPLICATE_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_DUPLICATE_GROUPS to BARS_DM;
grant SELECT                                                                 on EBK_DUPLICATE_GROUPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_DUPLICATE_GROUPS.sql =========*** 
PROMPT ===================================================================================== 
