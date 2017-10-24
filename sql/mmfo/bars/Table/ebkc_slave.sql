

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_SLAVE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_SLAVE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_SLAVE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_SLAVE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_SLAVE ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_SLAVE 
   (	GCIF VARCHAR2(30), 
	SLAVE_KF VARCHAR2(6), 
	CUST_TYPE VARCHAR2(1), 
	SLAVE_RNK NUMBER(38,0), 
	 CONSTRAINT PK_EBKC_SLAVE PRIMARY KEY (GCIF, SLAVE_KF, SLAVE_RNK, CUST_TYPE) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_SLAVE ***
 exec bpa.alter_policies('EBKC_SLAVE');


COMMENT ON TABLE BARS.EBKC_SLAVE IS 'Таблица привязанных карточек  к gcif';
COMMENT ON COLUMN BARS.EBKC_SLAVE.GCIF IS '';
COMMENT ON COLUMN BARS.EBKC_SLAVE.SLAVE_KF IS '';
COMMENT ON COLUMN BARS.EBKC_SLAVE.CUST_TYPE IS '';
COMMENT ON COLUMN BARS.EBKC_SLAVE.SLAVE_RNK IS '';




PROMPT *** Create  constraint PK_EBKC_SLAVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_SLAVE ADD CONSTRAINT PK_EBKC_SLAVE PRIMARY KEY (GCIF, SLAVE_KF, SLAVE_RNK, CUST_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_EBKCSLAVE_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_SLAVE ADD CONSTRAINT FK_EBKCSLAVE_CUSTTYPE FOREIGN KEY (CUST_TYPE)
	  REFERENCES BARS.EBKC_CUST_TYPES (CUST_TYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EBKC_SLAVE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EBKC_SLAVE ON BARS.EBKC_SLAVE (GCIF, SLAVE_KF, SLAVE_RNK, CUST_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_SLAVE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_SLAVE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_SLAVE      to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_SLAVE.sql =========*** End *** ==
PROMPT ===================================================================================== 
