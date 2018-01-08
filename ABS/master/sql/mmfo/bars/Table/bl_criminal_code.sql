

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_CRIMINAL_CODE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_CRIMINAL_CODE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_CRIMINAL_CODE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BL_CRIMINAL_CODE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_CRIMINAL_CODE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_CRIMINAL_CODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_CRIMINAL_CODE 
   (	CRIMINAL_CODE_ID NUMBER, 
	DATE_OF_CODE DATE, 
	CODE_NUM NUMBER, 
	CODE_PART NUMBER, 
	CODE_RISK NUMBER, 
	CODE_TEXT VARCHAR2(2000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_CRIMINAL_CODE ***
 exec bpa.alter_policies('BL_CRIMINAL_CODE');


COMMENT ON TABLE BARS.BL_CRIMINAL_CODE IS 'Справочник Криминального Кодекса Украины';
COMMENT ON COLUMN BARS.BL_CRIMINAL_CODE.CRIMINAL_CODE_ID IS 'Уникльный идентификатор';
COMMENT ON COLUMN BARS.BL_CRIMINAL_CODE.DATE_OF_CODE IS 'либо 28.12.1960, либо 05.04.2001';
COMMENT ON COLUMN BARS.BL_CRIMINAL_CODE.CODE_NUM IS 'Номер статьи';
COMMENT ON COLUMN BARS.BL_CRIMINAL_CODE.CODE_PART IS 'Часть статьи';
COMMENT ON COLUMN BARS.BL_CRIMINAL_CODE.CODE_RISK IS '1 - отсекающая, 0 - не отсекающая статья';
COMMENT ON COLUMN BARS.BL_CRIMINAL_CODE.CODE_TEXT IS 'Текст статьи';




PROMPT *** Create  constraint NN_BL_CRIMINAL_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_CRIMINAL_CODE MODIFY (CODE_RISK CONSTRAINT NN_BL_CRIMINAL_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_CRIMINAL_CODE ***
grant SELECT                                                                 on BL_CRIMINAL_CODE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BL_CRIMINAL_CODE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BL_CRIMINAL_CODE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BL_CRIMINAL_CODE to START1;
grant SELECT                                                                 on BL_CRIMINAL_CODE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_CRIMINAL_CODE.sql =========*** End 
PROMPT ===================================================================================== 
