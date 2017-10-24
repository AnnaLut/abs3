

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_ORDER_EXTRA_ATTRIBUTES.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_ORDER_EXTRA_ATTRIBUTES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_ORDER_EXTRA_ATTRIBUTES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_ORDER_EXTRA_ATTRIBUTES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_ORDER_EXTRA_ATTRIBUTES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_ORDER_EXTRA_ATTRIBUTES ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_ORDER_EXTRA_ATTRIBUTES 
   (	ORDER_ID NUMBER(10,0), 
	EXTRA_ATTRIBUTES CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (EXTRA_ATTRIBUTES) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_ORDER_EXTRA_ATTRIBUTES ***
 exec bpa.alter_policies('STO_ORDER_EXTRA_ATTRIBUTES');


COMMENT ON TABLE BARS.STO_ORDER_EXTRA_ATTRIBUTES IS '';
COMMENT ON COLUMN BARS.STO_ORDER_EXTRA_ATTRIBUTES.ORDER_ID IS '';
COMMENT ON COLUMN BARS.STO_ORDER_EXTRA_ATTRIBUTES.EXTRA_ATTRIBUTES IS '';




PROMPT *** Create  constraint PK_STO_ORDER_EXTRA_ATTRIBUTES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_EXTRA_ATTRIBUTES ADD CONSTRAINT PK_STO_ORDER_EXTRA_ATTRIBUTES PRIMARY KEY (ORDER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STO_ORDE_REFERENCE_STO_ORDE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_EXTRA_ATTRIBUTES ADD CONSTRAINT FK_STO_ORDE_REFERENCE_STO_ORDE FOREIGN KEY (ORDER_ID)
	  REFERENCES BARS.STO_ORDER (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010402 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_EXTRA_ATTRIBUTES MODIFY (ORDER_ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010403 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_EXTRA_ATTRIBUTES MODIFY (EXTRA_ATTRIBUTES NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_ORDER_EXTRA_ATTRIBUTES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_ORDER_EXTRA_ATTRIBUTES ON BARS.STO_ORDER_EXTRA_ATTRIBUTES (ORDER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_ORDER_EXTRA_ATTRIBUTES ***
grant SELECT                                                                 on STO_ORDER_EXTRA_ATTRIBUTES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_ORDER_EXTRA_ATTRIBUTES.sql =======
PROMPT ===================================================================================== 
