

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_ERR_CODES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_ERR_CODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPA_ERR_CODES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_ERR_CODES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPA_ERR_CODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPA_ERR_CODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPA_ERR_CODES 
   (	ERR_CODE VARCHAR2(4), 
	ERR_MSG VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPA_ERR_CODES ***
 exec bpa.alter_policies('DPA_ERR_CODES');


COMMENT ON TABLE BARS.DPA_ERR_CODES IS 'Коды ошибок обработки файлов от ДПА';
COMMENT ON COLUMN BARS.DPA_ERR_CODES.ERR_CODE IS 'Код ошибки';
COMMENT ON COLUMN BARS.DPA_ERR_CODES.ERR_MSG IS 'Описание ошибки';




PROMPT *** Create  constraint PK_DPAERRCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_ERR_CODES ADD CONSTRAINT PK_DPAERRCODES PRIMARY KEY (ERR_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPAERRCODES_ERRCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_ERR_CODES MODIFY (ERR_CODE CONSTRAINT CC_DPAERRCODES_ERRCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPAERRCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPAERRCODES ON BARS.DPA_ERR_CODES (ERR_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPA_ERR_CODES ***
grant SELECT                                                                 on DPA_ERR_CODES   to BARSREADER_ROLE;
grant SELECT                                                                 on DPA_ERR_CODES   to BARS_DM;
grant SELECT                                                                 on DPA_ERR_CODES   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPA_ERR_CODES   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to DPA_ERR_CODES ***

  CREATE OR REPLACE PUBLIC SYNONYM DPA_ERR_CODES FOR BARS.DPA_ERR_CODES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_ERR_CODES.sql =========*** End ***
PROMPT ===================================================================================== 
