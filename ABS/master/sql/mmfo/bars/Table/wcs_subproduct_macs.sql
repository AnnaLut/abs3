

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_MACS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_MACS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_MACS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_MACS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_MACS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_MACS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_MACS 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	MAC_ID VARCHAR2(100), 
	BRANCH VARCHAR2(30) DEFAULT ''/'', 
	VAL_TEXT VARCHAR2(4000), 
	VAL_NUMB NUMBER, 
	VAL_DECIMAL NUMBER, 
	VAL_DATE DATE, 
	VAL_LIST NUMBER, 
	VAL_REFER VARCHAR2(4000), 
	VAL_FILE BLOB, 
	VAL_BOOL NUMBER(1,0), 
	APPLY_DATE DATE DEFAULT trunc(sysdate) + 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (VAL_FILE) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_MACS ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_MACS');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_MACS IS 'МАКи субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_MACS.SUBPRODUCT_ID IS 'Идентификатор субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_MACS.MAC_ID IS 'Идентификатор МАКа';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_MACS.BRANCH IS 'Идентификатор отделения';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_MACS.VAL_TEXT IS 'Текстовый';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_MACS.VAL_NUMB IS 'Целочисленный';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_MACS.VAL_DECIMAL IS 'Дробное число';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_MACS.VAL_DATE IS 'Дата';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_MACS.VAL_LIST IS 'Список';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_MACS.VAL_REFER IS 'Справочник';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_MACS.VAL_FILE IS 'Файл';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_MACS.VAL_BOOL IS 'Булевый';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_MACS.APPLY_DATE IS 'Дата применения';




PROMPT *** Create  constraint PK_SBPMACS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_MACS ADD CONSTRAINT PK_SBPMACS PRIMARY KEY (SUBPRODUCT_ID, MAC_ID, BRANCH, APPLY_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SBPMACS_VALBOOL ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_MACS ADD CONSTRAINT CC_SBPMACS_VALBOOL CHECK (val_bool in (0, 1) or val_bool is null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SBPMACS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_MACS ADD CONSTRAINT CC_SBPMACS CHECK (nvl2(val_text, 1, 0) + nvl2(val_numb, 1, 0) + nvl2(val_decimal, 1, 0)
                                                                + nvl2(val_date, 1, 0) + nvl2(val_list, 1, 0) + nvl2(val_refer, 1, 0)
                                                                + nvl2(val_file, 1, 0) + nvl2(val_bool, 1, 0) = 1) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPMACS_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_MACS ADD CONSTRAINT FK_SBPMACS_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPMACS_MID_MACS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_MACS ADD CONSTRAINT FK_SBPMACS_MID_MACS_ID FOREIGN KEY (MAC_ID)
	  REFERENCES BARS.WCS_MACS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPMACS_B_BRANCH_B ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_MACS ADD CONSTRAINT FK_SBPMACS_B_BRANCH_B FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SBPMACS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SBPMACS ON BARS.WCS_SUBPRODUCT_MACS (SUBPRODUCT_ID, MAC_ID, BRANCH, APPLY_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_MACS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SUBPRODUCT_MACS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_MACS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SUBPRODUCT_MACS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_MACS.sql =========*** E
PROMPT ===================================================================================== 
