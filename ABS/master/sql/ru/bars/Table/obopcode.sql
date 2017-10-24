

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBOPCODE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBOPCODE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBOPCODE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBOPCODE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBOPCODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBOPCODE 
   (	TRANSCODE VARCHAR2(7), 
	KOD_NNN NUMBER(2,0), 
	TRANSDESC VARCHAR2(110), 
	KIND VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBOPCODE ***
 exec bpa.alter_policies('OBOPCODE');


COMMENT ON TABLE BARS.OBOPCODE IS '';
COMMENT ON COLUMN BARS.OBOPCODE.TRANSCODE IS '';
COMMENT ON COLUMN BARS.OBOPCODE.KOD_NNN IS '';
COMMENT ON COLUMN BARS.OBOPCODE.TRANSDESC IS '';
COMMENT ON COLUMN BARS.OBOPCODE.KIND IS '';





PROMPT *** Create SYNONYM  to OBOPCODE ***

  CREATE OR REPLACE PUBLIC SYNONYM OBOPCODE FOR BARS.OBOPCODE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBOPCODE.sql =========*** End *** ====
PROMPT ===================================================================================== 
