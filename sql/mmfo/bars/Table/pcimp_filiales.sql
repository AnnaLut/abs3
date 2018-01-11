

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PCIMP_FILIALES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PCIMP_FILIALES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PCIMP_FILIALES ***
begin 
  execute immediate '
  CREATE TABLE BARS.PCIMP_FILIALES 
   (	CODE VARCHAR2(5), 
	NAME VARCHAR2(31), 
	CITY VARCHAR2(15), 
	STREET VARCHAR2(27), 
	MFO NUMBER(6,0), 
	CLIENT_0 VARCHAR2(7), 
	CLIENT_1 VARCHAR2(7), 
	ABVR_NAME VARCHAR2(27)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PCIMP_FILIALES ***
 exec bpa.alter_policies('PCIMP_FILIALES');


COMMENT ON TABLE BARS.PCIMP_FILIALES IS '';
COMMENT ON COLUMN BARS.PCIMP_FILIALES.CODE IS '';
COMMENT ON COLUMN BARS.PCIMP_FILIALES.NAME IS '';
COMMENT ON COLUMN BARS.PCIMP_FILIALES.CITY IS '';
COMMENT ON COLUMN BARS.PCIMP_FILIALES.STREET IS '';
COMMENT ON COLUMN BARS.PCIMP_FILIALES.MFO IS '';
COMMENT ON COLUMN BARS.PCIMP_FILIALES.CLIENT_0 IS '';
COMMENT ON COLUMN BARS.PCIMP_FILIALES.CLIENT_1 IS '';
COMMENT ON COLUMN BARS.PCIMP_FILIALES.ABVR_NAME IS '';



PROMPT *** Create  grants  PCIMP_FILIALES ***
grant SELECT                                                                 on PCIMP_FILIALES  to BARSREADER_ROLE;
grant SELECT                                                                 on PCIMP_FILIALES  to BARS_DM;
grant SELECT                                                                 on PCIMP_FILIALES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PCIMP_FILIALES.sql =========*** End **
PROMPT ===================================================================================== 
