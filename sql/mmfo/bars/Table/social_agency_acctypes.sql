

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOCIAL_AGENCY_ACCTYPES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOCIAL_AGENCY_ACCTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOCIAL_AGENCY_ACCTYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_AGENCY_ACCTYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_AGENCY_ACCTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOCIAL_AGENCY_ACCTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOCIAL_AGENCY_ACCTYPES 
   (	AGNTYPE NUMBER(38,0), 
	ACCTYPE CHAR(1), 
	ACCMASK CHAR(4), 
	ACCNAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOCIAL_AGENCY_ACCTYPES ***
 exec bpa.alter_policies('SOCIAL_AGENCY_ACCTYPES');


COMMENT ON TABLE BARS.SOCIAL_AGENCY_ACCTYPES IS 'Опис типів рахунків для типів органів соціального захисту';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_ACCTYPES.AGNTYPE IS 'Код типу органу соц.захисту';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_ACCTYPES.ACCTYPE IS 'Код типу рахунку';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_ACCTYPES.ACCMASK IS 'Бал.рахунок';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_ACCTYPES.ACCNAME IS 'Назва рахунку';




PROMPT *** Create  constraint CC_SOCAGENCYACCTYPE_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_ACCTYPES ADD CONSTRAINT CC_SOCAGENCYACCTYPE_TYPE CHECK (acctype in (''D'', ''K'', ''C'', ''M'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SOCAGENCYACCTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_ACCTYPES ADD CONSTRAINT PK_SOCAGENCYACCTYPE PRIMARY KEY (AGNTYPE, ACCTYPE, ACCMASK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCAGENCYACCTYPE_SOCAGNTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_ACCTYPES ADD CONSTRAINT FK_SOCAGENCYACCTYPE_SOCAGNTYPE FOREIGN KEY (AGNTYPE)
	  REFERENCES BARS.SOCIAL_AGENCY_TYPE (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCAGENCYACCTYPE_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_ACCTYPES ADD CONSTRAINT FK_SOCAGENCYACCTYPE_PS FOREIGN KEY (ACCMASK)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCAGENCYACCTYPE_AGNTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_ACCTYPES MODIFY (AGNTYPE CONSTRAINT CC_SOCAGENCYACCTYPE_AGNTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCAGENCYACCTYPE_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_ACCTYPES MODIFY (ACCTYPE CONSTRAINT CC_SOCAGENCYACCTYPE_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCAGENCYACCTYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_ACCTYPES MODIFY (ACCNAME CONSTRAINT CC_SOCAGENCYACCTYPE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCAGENCYACCTYPE_MASK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_ACCTYPES MODIFY (ACCMASK CONSTRAINT CC_SOCAGENCYACCTYPE_MASK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOCAGENCYACCTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOCAGENCYACCTYPE ON BARS.SOCIAL_AGENCY_ACCTYPES (AGNTYPE, ACCTYPE, ACCMASK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOCIAL_AGENCY_ACCTYPES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_AGENCY_ACCTYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SOCIAL_AGENCY_ACCTYPES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_AGENCY_ACCTYPES to DPT_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_AGENCY_ACCTYPES to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SOCIAL_AGENCY_ACCTYPES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOCIAL_AGENCY_ACCTYPES.sql =========**
PROMPT ===================================================================================== 
