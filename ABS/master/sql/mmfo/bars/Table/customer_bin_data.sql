

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_BIN_DATA.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_BIN_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_BIN_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_BIN_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_BIN_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_BIN_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_BIN_DATA 
   (	ID NUMBER(38,0), 
	BIN_DATA BLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (BIN_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_BIN_DATA ***
 exec bpa.alter_policies('CUSTOMER_BIN_DATA');


COMMENT ON TABLE BARS.CUSTOMER_BIN_DATA IS 'Графическая информация о клиенте (ID заполняется последовательностью S_CUSTOMER_BIN_DATA)';
COMMENT ON COLUMN BARS.CUSTOMER_BIN_DATA.ID IS 'Идентификатор хранимой графической информации';
COMMENT ON COLUMN BARS.CUSTOMER_BIN_DATA.BIN_DATA IS 'Графическая информация';




PROMPT *** Create  constraint PK_CUSTBINDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_BIN_DATA ADD CONSTRAINT PK_CUSTBINDATA PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTBINDATA_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_BIN_DATA MODIFY (ID CONSTRAINT CC_CUSTBINDATA_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTBINDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTBINDATA ON BARS.CUSTOMER_BIN_DATA (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_BIN_DATA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_BIN_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_BIN_DATA to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_BIN_DATA to CUST001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_BIN_DATA to WR_ALL_RIGHTS;
grant DELETE,SELECT                                                          on CUSTOMER_BIN_DATA to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_BIN_DATA.sql =========*** End
PROMPT ===================================================================================== 
