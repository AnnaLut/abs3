

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_RCIF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_RCIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_RCIF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_RCIF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_RCIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_RCIF 
   (	RCIF NUMBER(38,0), 
	CUST_TYPE VARCHAR2(1), 
	SEND NUMBER(1,0), 
	 CONSTRAINT PK_EBKC_RCIF PRIMARY KEY (RCIF, SEND) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_RCIF ***
 exec bpa.alter_policies('EBKC_RCIF');


COMMENT ON TABLE BARS.EBKC_RCIF IS 'Таблица идентификатора мастер-карточки на уровне РУ, равен РНК';
COMMENT ON COLUMN BARS.EBKC_RCIF.RCIF IS '';
COMMENT ON COLUMN BARS.EBKC_RCIF.CUST_TYPE IS '';
COMMENT ON COLUMN BARS.EBKC_RCIF.SEND IS '';




PROMPT *** Create  constraint PK_EBKC_RCIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_RCIF ADD CONSTRAINT PK_EBKC_RCIF PRIMARY KEY (RCIF, SEND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EBKC_RCIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EBKC_RCIF ON BARS.EBKC_RCIF (RCIF, SEND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_RCIF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_RCIF       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_RCIF.sql =========*** End *** ===
PROMPT ===================================================================================== 
