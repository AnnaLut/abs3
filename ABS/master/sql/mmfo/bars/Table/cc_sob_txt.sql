

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_SOB_TXT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_SOB_TXT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_SOB_TXT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_SOB_TXT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_SOB_TXT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_SOB_TXT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_SOB_TXT 
   (	ID NUMBER(38,0), 
	TXT VARCHAR2(100), 
	CUSTTYPE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_SOB_TXT ***
 exec bpa.alter_policies('CC_SOB_TXT');


COMMENT ON TABLE BARS.CC_SOB_TXT IS 'Шабони текстів повідомлень у КП';
COMMENT ON COLUMN BARS.CC_SOB_TXT.ID IS 'код ~шаблону';
COMMENT ON COLUMN BARS.CC_SOB_TXT.TXT IS 'Найменування';
COMMENT ON COLUMN BARS.CC_SOB_TXT.CUSTTYPE IS 'Шаблон для null - всіх 2 - ЮО 3 - ФО';




PROMPT *** Create  constraint CC_SOB_TXT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_TXT MODIFY (ID CONSTRAINT CC_SOB_TXT_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOB_TXT_TXT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_TXT MODIFY (TXT CONSTRAINT CC_SOB_TXT_TXT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_SOB_TXT_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOB_TXT ADD CONSTRAINT XPK_SOB_TXT_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SOB_TXT_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SOB_TXT_ID ON BARS.CC_SOB_TXT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_SOB_TXT ***
grant SELECT                                                                 on CC_SOB_TXT      to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SOB_TXT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SOB_TXT      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SOB_TXT      to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_SOB_TXT.sql =========*** End *** ==
PROMPT ===================================================================================== 
