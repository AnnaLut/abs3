

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_RANG_NAME.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_RANG_NAME ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_RANG_NAME'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_RANG_NAME'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_RANG_NAME'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_RANG_NAME ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_RANG_NAME 
   (	RANG NUMBER(38,0), 
	NAME VARCHAR2(100), 
	CUSTTYPE NUMBER, 
	D_CLOSE DATE, 
	BLK NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_RANG_NAME ***
 exec bpa.alter_policies('CC_RANG_NAME');


COMMENT ON TABLE BARS.CC_RANG_NAME IS 'Найменування шаблонів авто розбору рахунку погашення';
COMMENT ON COLUMN BARS.CC_RANG_NAME.RANG IS 'код ~шаблону';
COMMENT ON COLUMN BARS.CC_RANG_NAME.NAME IS 'Найменування';
COMMENT ON COLUMN BARS.CC_RANG_NAME.CUSTTYPE IS 'Шаблон для null - всіх 2 - ЮО 3 - ФО';
COMMENT ON COLUMN BARS.CC_RANG_NAME.D_CLOSE IS 'Дата~закриття';
COMMENT ON COLUMN BARS.CC_RANG_NAME.BLK IS 'Період разбору основного платежу';




PROMPT *** Create  constraint XPK_CC_RANG_NAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG_NAME ADD CONSTRAINT XPK_CC_RANG_NAME PRIMARY KEY (RANG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RANGN_RANG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG_NAME MODIFY (RANG CONSTRAINT CC_RANGN_RANG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RANGN_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG_NAME MODIFY (NAME CONSTRAINT CC_RANGN_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_RANG_NAME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_RANG_NAME ON BARS.CC_RANG_NAME (RANG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_RANG_NAME ***
grant SELECT                                                                 on CC_RANG_NAME    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_RANG_NAME    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_RANG_NAME    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_RANG_NAME    to RCC_DEAL;
grant SELECT                                                                 on CC_RANG_NAME    to UPLD;
grant FLASHBACK,SELECT                                                       on CC_RANG_NAME    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_RANG_NAME.sql =========*** End *** 
PROMPT ===================================================================================== 
