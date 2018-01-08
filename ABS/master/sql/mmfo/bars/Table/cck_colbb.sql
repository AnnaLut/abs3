

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_COLBB.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_COLBB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_COLBB'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CCK_COLBB'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_COLBB ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_COLBB 
   (	COLBB_ID NUMBER, 
	COLBB_NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_COLBB ***
 exec bpa.alter_policies('CCK_COLBB');


COMMENT ON TABLE BARS.CCK_COLBB IS 'Колегіальний орган Банку';
COMMENT ON COLUMN BARS.CCK_COLBB.COLBB_ID IS 'Код колегіального органа';
COMMENT ON COLUMN BARS.CCK_COLBB.COLBB_NAME IS 'Найменування колегіального органа';




PROMPT *** Create  constraint PK_CCKCOLBB ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_COLBB ADD CONSTRAINT PK_CCKCOLBB PRIMARY KEY (COLBB_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCCOLBBID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_COLBB MODIFY (COLBB_ID CONSTRAINT CC_CCCOLBBID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKCOLBB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKCOLBB ON BARS.CCK_COLBB (COLBB_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_COLBB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_COLBB       to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CCK_COLBB       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_COLBB       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_COLBB       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_COLBB       to RCC_DEAL;
grant SELECT                                                                 on CCK_COLBB       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_COLBB.sql =========*** End *** ===
PROMPT ===================================================================================== 
