

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_SECFIN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_SECFIN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_SECFIN'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CCK_SECFIN'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_SECFIN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_SECFIN 
   (	SECFIN_ID NUMBER, 
	SECFIN_NAME VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_SECFIN ***
 exec bpa.alter_policies('CCK_SECFIN');


COMMENT ON TABLE BARS.CCK_SECFIN IS 'Секція фінансування';
COMMENT ON COLUMN BARS.CCK_SECFIN.SECFIN_ID IS 'Код секції';
COMMENT ON COLUMN BARS.CCK_SECFIN.SECFIN_NAME IS 'Найменування секції';




PROMPT *** Create  constraint PK_CCKSECFIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_SECFIN ADD CONSTRAINT PK_CCKSECFIN PRIMARY KEY (SECFIN_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCSECFINID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_SECFIN MODIFY (SECFIN_ID CONSTRAINT CC_CCSECFINID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKSECFIN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKSECFIN ON BARS.CCK_SECFIN (SECFIN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_SECFIN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_SECFIN      to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CCK_SECFIN      to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_SECFIN      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_SECFIN      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_SECFIN      to RCC_DEAL;
grant SELECT                                                                 on CCK_SECFIN      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_SECFIN.sql =========*** End *** ==
PROMPT ===================================================================================== 
