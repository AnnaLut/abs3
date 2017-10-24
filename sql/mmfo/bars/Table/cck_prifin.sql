

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_PRIFIN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_PRIFIN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_PRIFIN'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CCK_PRIFIN'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_PRIFIN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_PRIFIN 
   (	PRIFIN_ID NUMBER, 
	PRIFIN_NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_PRIFIN ***
 exec bpa.alter_policies('CCK_PRIFIN');


COMMENT ON TABLE BARS.CCK_PRIFIN IS 'Черговість фінансування';
COMMENT ON COLUMN BARS.CCK_PRIFIN.PRIFIN_ID IS 'Код черговості';
COMMENT ON COLUMN BARS.CCK_PRIFIN.PRIFIN_NAME IS 'Найменування черговості';




PROMPT *** Create  constraint PK_CCKPRIFIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_PRIFIN ADD CONSTRAINT PK_CCKPRIFIN PRIMARY KEY (PRIFIN_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCPRIFINID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_PRIFIN MODIFY (PRIFIN_ID CONSTRAINT CC_CCPRIFINID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKPRIFIN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKPRIFIN ON BARS.CCK_PRIFIN (PRIFIN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_PRIFIN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_PRIFIN      to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CCK_PRIFIN      to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_PRIFIN      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_PRIFIN      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_PRIFIN      to RCC_DEAL;
grant SELECT                                                                 on CCK_PRIFIN      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_PRIFIN.sql =========*** End *** ==
PROMPT ===================================================================================== 
