

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_FILIAL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_FILIAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_FILIAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_FILIAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_FILIAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_FILIAL 
   (	NLS_GOU VARCHAR2(14), 
	MFO VARCHAR2(6), 
	NLS VARCHAR2(14), 
	OKPO VARCHAR2(14), 
	NAME VARCHAR2(38)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_FILIAL ***
 exec bpa.alter_policies('OW_FILIAL');


COMMENT ON TABLE BARS.OW_FILIAL IS 'OpenWay. Межфилиальные расчеты';
COMMENT ON COLUMN BARS.OW_FILIAL.NLS_GOU IS 'Счет ГОУ для межфилиальных расчетов с РУ';
COMMENT ON COLUMN BARS.OW_FILIAL.MFO IS 'МФО РУ';
COMMENT ON COLUMN BARS.OW_FILIAL.NLS IS 'Счет РУ для расчетов с ГОУ';
COMMENT ON COLUMN BARS.OW_FILIAL.OKPO IS 'ОКПО РУ';
COMMENT ON COLUMN BARS.OW_FILIAL.NAME IS 'Наименование счета РУ';




PROMPT *** Create  constraint PK_OWFILIAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILIAL ADD CONSTRAINT PK_OWFILIAL PRIMARY KEY (NLS_GOU)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWFILIAL_NLSGOU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_FILIAL MODIFY (NLS_GOU CONSTRAINT CC_OWFILIAL_NLSGOU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWFILIAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWFILIAL ON BARS.OW_FILIAL (NLS_GOU) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_FILIAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_FILIAL       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_FILIAL       to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_FILIAL.sql =========*** End *** ===
PROMPT ===================================================================================== 
