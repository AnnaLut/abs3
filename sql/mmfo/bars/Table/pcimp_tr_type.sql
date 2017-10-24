

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PCIMP_TR_TYPE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PCIMP_TR_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PCIMP_TR_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PCIMP_TR_TYPE 
   (	TRAN_TYPE VARCHAR2(2), 
	TRAN_NAME VARCHAR2(40), 
	TRAN_RUSS VARCHAR2(40), 
	SERV VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PCIMP_TR_TYPE ***
 exec bpa.alter_policies('PCIMP_TR_TYPE');


COMMENT ON TABLE BARS.PCIMP_TR_TYPE IS '';
COMMENT ON COLUMN BARS.PCIMP_TR_TYPE.TRAN_TYPE IS '';
COMMENT ON COLUMN BARS.PCIMP_TR_TYPE.TRAN_NAME IS '';
COMMENT ON COLUMN BARS.PCIMP_TR_TYPE.TRAN_RUSS IS '';
COMMENT ON COLUMN BARS.PCIMP_TR_TYPE.SERV IS '';



PROMPT *** Create  grants  PCIMP_TR_TYPE ***
grant SELECT                                                                 on PCIMP_TR_TYPE   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PCIMP_TR_TYPE.sql =========*** End ***
PROMPT ===================================================================================== 
