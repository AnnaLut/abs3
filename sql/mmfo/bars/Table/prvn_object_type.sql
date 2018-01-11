

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_OBJECT_TYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_OBJECT_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_OBJECT_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRVN_OBJECT_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRVN_OBJECT_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_OBJECT_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_OBJECT_TYPE 
   (	ID VARCHAR2(5), 
	NAME VARCHAR2(500), 
	PRD_TP NUMBER(2,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_OBJECT_TYPE ***
 exec bpa.alter_policies('PRVN_OBJECT_TYPE');


COMMENT ON TABLE BARS.PRVN_OBJECT_TYPE IS 'Типи об дефолту';
COMMENT ON COLUMN BARS.PRVN_OBJECT_TYPE.ID IS 'Іддентифікатор';
COMMENT ON COLUMN BARS.PRVN_OBJECT_TYPE.NAME IS 'Найменування';
COMMENT ON COLUMN BARS.PRVN_OBJECT_TYPE.PRD_TP IS 'Тип договору в DWH (Ощадбанк)';




PROMPT *** Create  constraint SYS_C0011725 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_OBJECT_TYPE ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRVNOBJECTTYPE_PRDTP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_OBJECT_TYPE MODIFY (PRD_TP CONSTRAINT CC_PRVNOBJECTTYPE_PRDTP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0011725 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0011725 ON BARS.PRVN_OBJECT_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRVN_OBJECT_TYPE ***
grant SELECT                                                                 on PRVN_OBJECT_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on PRVN_OBJECT_TYPE to BARSUPL;
grant SELECT                                                                 on PRVN_OBJECT_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_OBJECT_TYPE to BARS_DM;
grant SELECT                                                                 on PRVN_OBJECT_TYPE to START1;
grant SELECT                                                                 on PRVN_OBJECT_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_OBJECT_TYPE.sql =========*** End 
PROMPT ===================================================================================== 
