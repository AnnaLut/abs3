

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_BANKDATES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_BANKDATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_BANKDATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_BANKDATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_BANKDATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_BANKDATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_BANKDATES 
   (	LOGNAME VARCHAR2(30), 
	BANKDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_BANKDATES ***
 exec bpa.alter_policies('STAFF_BANKDATES');


COMMENT ON TABLE BARS.STAFF_BANKDATES IS '';
COMMENT ON COLUMN BARS.STAFF_BANKDATES.LOGNAME IS '';
COMMENT ON COLUMN BARS.STAFF_BANKDATES.BANKDATE IS '';



PROMPT *** Create  grants  STAFF_BANKDATES ***
grant SELECT                                                                 on STAFF_BANKDATES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_BANKDATES to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_BANKDATES to START1;
grant SELECT                                                                 on STAFF_BANKDATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_BANKDATES.sql =========*** End *
PROMPT ===================================================================================== 
