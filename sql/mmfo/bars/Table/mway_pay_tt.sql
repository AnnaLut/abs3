

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MWAY_PAY_TT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MWAY_PAY_TT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MWAY_PAY_TT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MWAY_PAY_TT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MWAY_PAY_TT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MWAY_PAY_TT ***
begin 
  execute immediate '
  CREATE TABLE BARS.MWAY_PAY_TT 
   (	TT CHAR(3), 
	SERVICE_CODE VARCHAR2(100), 
	SERVICE_NAME VARCHAR2(400), 
	IS_FEE NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MWAY_PAY_TT ***
 exec bpa.alter_policies('MWAY_PAY_TT');


COMMENT ON TABLE BARS.MWAY_PAY_TT IS 'Справочник кодов операций для платежных сервисов кл.банк WAY';
COMMENT ON COLUMN BARS.MWAY_PAY_TT.TT IS 'Код операции';
COMMENT ON COLUMN BARS.MWAY_PAY_TT.SERVICE_CODE IS 'Код платежного сервиса';
COMMENT ON COLUMN BARS.MWAY_PAY_TT.SERVICE_NAME IS 'Описание сервиса';
COMMENT ON COLUMN BARS.MWAY_PAY_TT.IS_FEE IS '';




PROMPT *** Create  constraint SYS_C0035375 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MWAY_PAY_TT MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035376 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MWAY_PAY_TT MODIFY (SERVICE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035377 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MWAY_PAY_TT ADD PRIMARY KEY (TT, SERVICE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0035377 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0035377 ON BARS.MWAY_PAY_TT (TT, SERVICE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MWAY_PAY_TT ***
grant SELECT                                                                 on MWAY_PAY_TT     to BARSREADER_ROLE;
grant SELECT                                                                 on MWAY_PAY_TT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MWAY_PAY_TT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MWAY_PAY_TT.sql =========*** End *** =
PROMPT ===================================================================================== 
