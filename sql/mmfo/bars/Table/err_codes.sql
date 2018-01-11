

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR_CODES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR_CODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ERR_CODES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ERR_CODES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ERR_CODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR_CODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR_CODES 
   (	ERRMOD_CODE VARCHAR2(3), 
	ERR_CODE NUMBER(5,0), 
	ERR_EXCPNUM NUMBER(5,0), 
	ERR_NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 1 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR_CODES ***
 exec bpa.alter_policies('ERR_CODES');


COMMENT ON TABLE BARS.ERR_CODES IS 'Коды ошибок';
COMMENT ON COLUMN BARS.ERR_CODES.ERRMOD_CODE IS 'Код модуля';
COMMENT ON COLUMN BARS.ERR_CODES.ERR_CODE IS 'Код ошибки';
COMMENT ON COLUMN BARS.ERR_CODES.ERR_EXCPNUM IS '';
COMMENT ON COLUMN BARS.ERR_CODES.ERR_NAME IS '';




PROMPT *** Create  constraint PK_ERRCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_CODES ADD CONSTRAINT PK_ERRCODES PRIMARY KEY (ERRMOD_CODE, ERR_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_ERRCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_CODES ADD CONSTRAINT UK_ERRCODES UNIQUE (ERRMOD_CODE, ERR_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRCODES_ERRMODCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_CODES MODIFY (ERRMOD_CODE CONSTRAINT CC_ERRCODES_ERRMODCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRCODES_ERRCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_CODES MODIFY (ERR_CODE CONSTRAINT CC_ERRCODES_ERRCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRCODES_ERREXCPNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_CODES MODIFY (ERR_EXCPNUM CONSTRAINT CC_ERRCODES_ERREXCPNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ERRCODES_ERRNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ERR_CODES MODIFY (ERR_NAME CONSTRAINT CC_ERRCODES_ERRNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ERRCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ERRCODES ON BARS.ERR_CODES (ERRMOD_CODE, ERR_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ERRCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ERRCODES ON BARS.ERR_CODES (ERRMOD_CODE, ERR_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ERR_CODES ***
grant REFERENCES,SELECT                                                      on ERR_CODES       to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on ERR_CODES       to BARSAQ_ADM with grant option;
grant SELECT                                                                 on ERR_CODES       to BARSREADER_ROLE;
grant SELECT                                                                 on ERR_CODES       to BARS_DM;
grant SELECT                                                                 on ERR_CODES       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ERR_CODES       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR_CODES.sql =========*** End *** ===
PROMPT ===================================================================================== 
