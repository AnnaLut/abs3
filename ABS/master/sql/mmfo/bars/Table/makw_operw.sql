

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MAKW_OPERW.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MAKW_OPERW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MAKW_OPERW'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MAKW_OPERW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MAKW_OPERW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MAKW_OPERW ***
begin 
  execute immediate '
  CREATE TABLE BARS.MAKW_OPERW 
   (	ID NUMBER, 
	TAG VARCHAR2(5 CHAR), 
	VALUE VARCHAR2(200 CHAR)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MAKW_OPERW ***
 exec bpa.alter_policies('MAKW_OPERW');


COMMENT ON TABLE BARS.MAKW_OPERW IS '';
COMMENT ON COLUMN BARS.MAKW_OPERW.ID IS 'ID ПЛАТЕЖУ';
COMMENT ON COLUMN BARS.MAKW_OPERW.TAG IS 'ТЕГ';
COMMENT ON COLUMN BARS.MAKW_OPERW.VALUE IS 'ЗНАЧЕННЯ';




PROMPT *** Create  constraint SYS_C008946 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_OPERW MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008947 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_OPERW MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008948 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_OPERW MODIFY (VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_MAKW_OPERW ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_OPERW ADD CONSTRAINT PK_MAKW_OPERW PRIMARY KEY (ID, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MAKW_OPERW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MAKW_OPERW ON BARS.MAKW_OPERW (ID, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MAKW_OPERW ***
grant SELECT                                                                 on MAKW_OPERW      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MAKW_OPERW      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MAKW_OPERW      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MAKW_OPERW.sql =========*** End *** ==
PROMPT ===================================================================================== 
