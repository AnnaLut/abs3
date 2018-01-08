

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_CUSSEG.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_CUSSEG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_CUSSEG'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CCK_CUSSEG'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_CUSSEG ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_CUSSEG 
   (	CUSSEG_ID NUMBER, 
	CUSSEG_NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_CUSSEG ***
 exec bpa.alter_policies('CCK_CUSSEG');


COMMENT ON TABLE BARS.CCK_CUSSEG IS 'Сегмент клієнта';
COMMENT ON COLUMN BARS.CCK_CUSSEG.CUSSEG_ID IS 'Код сегменту';
COMMENT ON COLUMN BARS.CCK_CUSSEG.CUSSEG_NAME IS 'Найменування сегменту';




PROMPT *** Create  constraint PK_CCKCUSSEG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_CUSSEG ADD CONSTRAINT PK_CCKCUSSEG PRIMARY KEY (CUSSEG_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCCUSSEGID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_CUSSEG MODIFY (CUSSEG_ID CONSTRAINT CC_CCCUSSEGID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKCUSSEG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKCUSSEG ON BARS.CCK_CUSSEG (CUSSEG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_CUSSEG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_CUSSEG      to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CCK_CUSSEG      to BARSREADER_ROLE;
grant SELECT                                                                 on CCK_CUSSEG      to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_CUSSEG      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_CUSSEG      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_CUSSEG      to RCC_DEAL;
grant SELECT                                                                 on CCK_CUSSEG      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_CUSSEG.sql =========*** End *** ==
PROMPT ===================================================================================== 
