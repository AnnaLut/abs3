

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_RCIF_OLD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_RCIF_OLD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_RCIF_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_RCIF_OLD 
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




PROMPT *** ALTER_POLICIES to EBKC_RCIF_OLD ***
 exec bpa.alter_policies('EBKC_RCIF_OLD');


COMMENT ON TABLE BARS.EBKC_RCIF_OLD IS '������� �������������� ������-�������� �� ������ ��, ����� ���';
COMMENT ON COLUMN BARS.EBKC_RCIF_OLD.RCIF IS '';
COMMENT ON COLUMN BARS.EBKC_RCIF_OLD.CUST_TYPE IS '';
COMMENT ON COLUMN BARS.EBKC_RCIF_OLD.SEND IS '';




PROMPT *** Create  constraint PK_EBKC_RCIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_RCIF_OLD ADD CONSTRAINT PK_EBKC_RCIF PRIMARY KEY (RCIF, SEND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EBKC_RCIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EBKC_RCIF ON BARS.EBKC_RCIF_OLD (RCIF, SEND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_RCIF_OLD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_RCIF_OLD   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_RCIF_OLD   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_RCIF_OLD.sql =========*** End ***
PROMPT ===================================================================================== 
