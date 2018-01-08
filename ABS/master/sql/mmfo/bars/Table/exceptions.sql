

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EXCEPTIONS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EXCEPTIONS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EXCEPTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EXCEPTIONS 
   (	ROW_ID UROWID (4000), 
	OWNER VARCHAR2(30), 
	TABLE_NAME VARCHAR2(30), 
	CONSTRAINT VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EXCEPTIONS ***
 exec bpa.alter_policies('EXCEPTIONS');


COMMENT ON TABLE BARS.EXCEPTIONS IS '';
COMMENT ON COLUMN BARS.EXCEPTIONS.ROW_ID IS '';
COMMENT ON COLUMN BARS.EXCEPTIONS.OWNER IS '';
COMMENT ON COLUMN BARS.EXCEPTIONS.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.EXCEPTIONS.CONSTRAINT IS '';



PROMPT *** Create  grants  EXCEPTIONS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EXCEPTIONS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EXCEPTIONS      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EXCEPTIONS      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EXCEPTIONS.sql =========*** End *** ==
PROMPT ===================================================================================== 
