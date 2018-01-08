

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOCIAL_AGENCY_TYPE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOCIAL_AGENCY_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOCIAL_AGENCY_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_AGENCY_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_AGENCY_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOCIAL_AGENCY_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOCIAL_AGENCY_TYPE 
   (	TYPE_ID NUMBER(38,0), 
	TYPE_NAME VARCHAR2(100), 
	TARIF_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOCIAL_AGENCY_TYPE ***
 exec bpa.alter_policies('SOCIAL_AGENCY_TYPE');


COMMENT ON TABLE BARS.SOCIAL_AGENCY_TYPE IS 'Типы органов соц.защиты';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_TYPE.TYPE_ID IS 'Код типа ОСЗ';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_TYPE.TYPE_NAME IS 'Название типа ОСЗ';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY_TYPE.TARIF_ID IS 'Код тарифа за РКО';




PROMPT *** Create  constraint PK_SOCAGNTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_TYPE ADD CONSTRAINT PK_SOCAGNTYPE PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCAGNTYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY_TYPE MODIFY (TYPE_NAME CONSTRAINT CC_SOCAGNTYPE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOCAGNTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOCAGNTYPE ON BARS.SOCIAL_AGENCY_TYPE (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOCIAL_AGENCY_TYPE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_AGENCY_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SOCIAL_AGENCY_TYPE to BARS_CONNECT;
grant SELECT                                                                 on SOCIAL_AGENCY_TYPE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_AGENCY_TYPE to DPT_ADMIN;
grant SELECT                                                                 on SOCIAL_AGENCY_TYPE to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_AGENCY_TYPE to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SOCIAL_AGENCY_TYPE to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOCIAL_AGENCY_TYPE.sql =========*** En
PROMPT ===================================================================================== 
