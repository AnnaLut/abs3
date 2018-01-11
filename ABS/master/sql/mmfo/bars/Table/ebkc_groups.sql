

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_GROUPS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_GROUPS 
   (	ID NUMBER(1,0), 
	NAME VARCHAR2(50), 
	CUST_TYPE VARCHAR2(1), 
	 CONSTRAINT PK_EBKC_GROUPS PRIMARY KEY (ID, CUST_TYPE) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_GROUPS ***
 exec bpa.alter_policies('EBKC_GROUPS');


COMMENT ON TABLE BARS.EBKC_GROUPS IS 'Таблица групп клиентов по продуктам';
COMMENT ON COLUMN BARS.EBKC_GROUPS.ID IS '';
COMMENT ON COLUMN BARS.EBKC_GROUPS.NAME IS '';
COMMENT ON COLUMN BARS.EBKC_GROUPS.CUST_TYPE IS '';




PROMPT *** Create  constraint PK_EBKC_GROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_GROUPS ADD CONSTRAINT PK_EBKC_GROUPS PRIMARY KEY (ID, CUST_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EBKC_GROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EBKC_GROUPS ON BARS.EBKC_GROUPS (ID, CUST_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_GROUPS ***
grant SELECT                                                                 on EBKC_GROUPS     to BARSREADER_ROLE;
grant SELECT                                                                 on EBKC_GROUPS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_GROUPS     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_GROUPS.sql =========*** End *** =
PROMPT ===================================================================================== 
