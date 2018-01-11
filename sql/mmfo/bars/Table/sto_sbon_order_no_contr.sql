

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_SBON_ORDER_NO_CONTR.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_SBON_ORDER_NO_CONTR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_SBON_ORDER_NO_CONTR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_SBON_ORDER_NO_CONTR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_SBON_ORDER_NO_CONTR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_SBON_ORDER_NO_CONTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_SBON_ORDER_NO_CONTR 
   (	ID NUMBER(10,0), 
	CUSTOMER_ACCOUNT VARCHAR2(30 CHAR), 
	REGULAR_AMOUNT NUMBER(22,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_SBON_ORDER_NO_CONTR ***
 exec bpa.alter_policies('STO_SBON_ORDER_NO_CONTR');


COMMENT ON TABLE BARS.STO_SBON_ORDER_NO_CONTR IS '';
COMMENT ON COLUMN BARS.STO_SBON_ORDER_NO_CONTR.ID IS '';
COMMENT ON COLUMN BARS.STO_SBON_ORDER_NO_CONTR.CUSTOMER_ACCOUNT IS '';
COMMENT ON COLUMN BARS.STO_SBON_ORDER_NO_CONTR.REGULAR_AMOUNT IS '';




PROMPT *** Create  constraint PK_STO_SBON_ORDER_NO_CONTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_ORDER_NO_CONTR ADD CONSTRAINT PK_STO_SBON_ORDER_NO_CONTR PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005465 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_ORDER_NO_CONTR MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_SBON_ORDER_NO_CONTR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_SBON_ORDER_NO_CONTR ON BARS.STO_SBON_ORDER_NO_CONTR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_SBON_ORDER_NO_CONTR ***
grant SELECT                                                                 on STO_SBON_ORDER_NO_CONTR to BARSREADER_ROLE;
grant SELECT                                                                 on STO_SBON_ORDER_NO_CONTR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_SBON_ORDER_NO_CONTR to SBON;
grant SELECT                                                                 on STO_SBON_ORDER_NO_CONTR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_SBON_ORDER_NO_CONTR.sql =========*
PROMPT ===================================================================================== 
