

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_RAZ_KOMIS_TYPE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_RAZ_KOMIS_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_RAZ_KOMIS_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_RAZ_KOMIS_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_RAZ_KOMIS_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_RAZ_KOMIS_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_RAZ_KOMIS_TYPE 
   (	TIP NUMBER(*,0), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_RAZ_KOMIS_TYPE ***
 exec bpa.alter_policies('CC_RAZ_KOMIS_TYPE');


COMMENT ON TABLE BARS.CC_RAZ_KOMIS_TYPE IS 'Типы комиссионных тарифов для КД';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS_TYPE.TIP IS 'Код тарифа/комиссии';
COMMENT ON COLUMN BARS.CC_RAZ_KOMIS_TYPE.NAME IS 'Наименование тарифа/комиссии';




PROMPT *** Create  constraint PK_CC_RAZ_KOMIS_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS_TYPE ADD CONSTRAINT PK_CC_RAZ_KOMIS_TYPE PRIMARY KEY (TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RAZ_KOMIS_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RAZ_KOMIS_TYPE MODIFY (TIP CONSTRAINT CC_RAZ_KOMIS_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_RAZ_KOMIS_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_RAZ_KOMIS_TYPE ON BARS.CC_RAZ_KOMIS_TYPE (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_RAZ_KOMIS_TYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_RAZ_KOMIS_TYPE to ABS_ADMIN;
grant SELECT                                                                 on CC_RAZ_KOMIS_TYPE to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_RAZ_KOMIS_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_RAZ_KOMIS_TYPE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_RAZ_KOMIS_TYPE to RCC_DEAL;
grant SELECT                                                                 on CC_RAZ_KOMIS_TYPE to UPLD;
grant FLASHBACK,SELECT                                                       on CC_RAZ_KOMIS_TYPE to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_RAZ_KOMIS_TYPE.sql =========*** End
PROMPT ===================================================================================== 
