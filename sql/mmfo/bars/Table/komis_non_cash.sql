

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOMIS_NON_CASH.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOMIS_NON_CASH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOMIS_NON_CASH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOMIS_NON_CASH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOMIS_NON_CASH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOMIS_NON_CASH ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOMIS_NON_CASH 
   (	REF NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOMIS_NON_CASH ***
 exec bpa.alter_policies('KOMIS_NON_CASH');


COMMENT ON TABLE BARS.KOMIS_NON_CASH IS '';
COMMENT ON COLUMN BARS.KOMIS_NON_CASH.REF IS '';
COMMENT ON COLUMN BARS.KOMIS_NON_CASH.KF IS '';




PROMPT *** Create  constraint PK_KOMISNONCASH ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOMIS_NON_CASH ADD CONSTRAINT PK_KOMISNONCASH PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KOMISNONCASH_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOMIS_NON_CASH MODIFY (REF CONSTRAINT CC_KOMISNONCASH_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KOMISNONCASH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOMIS_NON_CASH MODIFY (KF CONSTRAINT CC_KOMISNONCASH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KOMISNONCASH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KOMISNONCASH ON BARS.KOMIS_NON_CASH (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KOMIS_NON_CASH ***
grant DELETE,INSERT,SELECT                                                   on KOMIS_NON_CASH  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT                                                   on KOMIS_NON_CASH  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOMIS_NON_CASH.sql =========*** End **
PROMPT ===================================================================================== 
