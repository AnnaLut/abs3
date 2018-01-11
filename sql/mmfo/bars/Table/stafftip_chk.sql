

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFFTIP_CHK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFFTIP_CHK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFFTIP_CHK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFFTIP_CHK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAFFTIP_CHK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFFTIP_CHK ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFFTIP_CHK 
   (	ID NUMBER(22,0), 
	CHKID NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFFTIP_CHK ***
 exec bpa.alter_policies('STAFFTIP_CHK');


COMMENT ON TABLE BARS.STAFFTIP_CHK IS 'Типов_ користувач_ <-> Групи контролю';
COMMENT ON COLUMN BARS.STAFFTIP_CHK.ID IS 'Код типового користувача';
COMMENT ON COLUMN BARS.STAFFTIP_CHK.CHKID IS 'Код групи контролю';




PROMPT *** Create  constraint PK_STAFFTIPCHK ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_CHK ADD CONSTRAINT PK_STAFFTIPCHK PRIMARY KEY (ID, CHKID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTIPCHK_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_CHK MODIFY (ID CONSTRAINT CC_STAFFTIPCHK_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTIPCHK_CHKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_CHK MODIFY (CHKID CONSTRAINT CC_STAFFTIPCHK_CHKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFTIPCHK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFTIPCHK ON BARS.STAFFTIP_CHK (ID, CHKID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFFTIP_CHK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFFTIP_CHK    to ABS_ADMIN;
grant SELECT                                                                 on STAFFTIP_CHK    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFFTIP_CHK    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFFTIP_CHK    to BARS_DM;
grant SELECT                                                                 on STAFFTIP_CHK    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFFTIP_CHK.sql =========*** End *** 
PROMPT ===================================================================================== 
