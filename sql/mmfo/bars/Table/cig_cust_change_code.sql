

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_CUST_CHANGE_CODE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_CUST_CHANGE_CODE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_CUST_CHANGE_CODE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_CUST_CHANGE_CODE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_CUST_CHANGE_CODE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_CUST_CHANGE_CODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_CUST_CHANGE_CODE 
   (	CUST_KEY VARCHAR2(256), 
	MFO VARCHAR2(6), 
	IS_SYNC NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_CUST_CHANGE_CODE ***
 exec bpa.alter_policies('CIG_CUST_CHANGE_CODE');


COMMENT ON TABLE BARS.CIG_CUST_CHANGE_CODE IS 'Перелік клієнтів по яким відбулась зміна ІНН з 0000000000 на інший';
COMMENT ON COLUMN BARS.CIG_CUST_CHANGE_CODE.CUST_KEY IS '';
COMMENT ON COLUMN BARS.CIG_CUST_CHANGE_CODE.MFO IS 'МФО';
COMMENT ON COLUMN BARS.CIG_CUST_CHANGE_CODE.IS_SYNC IS 'Ознака відправки 0 - не відлявляти, 1 - відправляти';




PROMPT *** Create  constraint PK_CIGCUSTCHANGECODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_CHANGE_CODE ADD CONSTRAINT PK_CIGCUSTCHANGECODE PRIMARY KEY (CUST_KEY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCHNGCODE_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_CHANGE_CODE MODIFY (MFO CONSTRAINT CC_CIGCUSTCHNGCODE_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGCUSTCHNGCODE_SYNC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_CUST_CHANGE_CODE MODIFY (IS_SYNC CONSTRAINT CC_CIGCUSTCHNGCODE_SYNC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGCUSTCHANGECODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGCUSTCHANGECODE ON BARS.CIG_CUST_CHANGE_CODE (CUST_KEY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_CUST_CHANGE_CODE ***
grant SELECT                                                                 on CIG_CUST_CHANGE_CODE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIG_CUST_CHANGE_CODE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_CUST_CHANGE_CODE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIG_CUST_CHANGE_CODE to CIG_ROLE;
grant SELECT                                                                 on CIG_CUST_CHANGE_CODE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_CUST_CHANGE_CODE.sql =========*** 
PROMPT ===================================================================================== 
