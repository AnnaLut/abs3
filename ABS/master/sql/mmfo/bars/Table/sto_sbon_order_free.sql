

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_SBON_ORDER_FREE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_SBON_ORDER_FREE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_SBON_ORDER_FREE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_SBON_ORDER_FREE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_SBON_ORDER_FREE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_SBON_ORDER_FREE ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_SBON_ORDER_FREE 
   (	ID NUMBER(10,0), 
	REGULAR_AMOUNT NUMBER(22,2), 
	RECEIVER_MFO VARCHAR2(6 CHAR), 
	RECEIVER_ACCOUNT VARCHAR2(34 CHAR), 
	RECEIVER_NAME VARCHAR2(300 CHAR), 
	RECEIVER_EDRPOU VARCHAR2(12 CHAR), 
	PURPOSE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_SBON_ORDER_FREE ***
 exec bpa.alter_policies('STO_SBON_ORDER_FREE');


COMMENT ON TABLE BARS.STO_SBON_ORDER_FREE IS '';
COMMENT ON COLUMN BARS.STO_SBON_ORDER_FREE.ID IS '';
COMMENT ON COLUMN BARS.STO_SBON_ORDER_FREE.REGULAR_AMOUNT IS '';
COMMENT ON COLUMN BARS.STO_SBON_ORDER_FREE.RECEIVER_MFO IS '';
COMMENT ON COLUMN BARS.STO_SBON_ORDER_FREE.RECEIVER_ACCOUNT IS '';
COMMENT ON COLUMN BARS.STO_SBON_ORDER_FREE.RECEIVER_NAME IS '';
COMMENT ON COLUMN BARS.STO_SBON_ORDER_FREE.RECEIVER_EDRPOU IS '';
COMMENT ON COLUMN BARS.STO_SBON_ORDER_FREE.PURPOSE IS '';




PROMPT *** Create  constraint PK_STO_SBON_ORDER_FREE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_ORDER_FREE ADD CONSTRAINT PK_STO_SBON_ORDER_FREE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBON_FREE_REF_STO_ORDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_ORDER_FREE ADD CONSTRAINT FK_SBON_FREE_REF_STO_ORDER FOREIGN KEY (ID)
	  REFERENCES BARS.STO_ORDER (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008871 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_ORDER_FREE MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008872 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_ORDER_FREE MODIFY (RECEIVER_MFO NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008873 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_ORDER_FREE MODIFY (RECEIVER_ACCOUNT NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008874 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_ORDER_FREE MODIFY (RECEIVER_NAME NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008875 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_ORDER_FREE MODIFY (RECEIVER_EDRPOU NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_SBON_ORDER_FREE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_SBON_ORDER_FREE ON BARS.STO_SBON_ORDER_FREE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_SBON_ORDER_FREE ***
grant SELECT                                                                 on STO_SBON_ORDER_FREE to BARSUPL;
grant SELECT                                                                 on STO_SBON_ORDER_FREE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_SBON_ORDER_FREE.sql =========*** E
PROMPT ===================================================================================== 
