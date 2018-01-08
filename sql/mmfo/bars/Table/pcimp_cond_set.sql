

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PCIMP_COND_SET.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PCIMP_COND_SET ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PCIMP_COND_SET ***
begin 
  execute immediate '
  CREATE TABLE BARS.PCIMP_COND_SET 
   (	CARD_TYPE VARCHAR2(1), 
	COND_SET NUMBER(4,0), 
	NAME VARCHAR2(8), 
	CURRENCY VARCHAR2(3), 
	C_VALIDITY NUMBER(2,0), 
	BL_10 VARCHAR2(1), 
	DEB_INTR NUMBER(6,2), 
	OLIM_INTR NUMBER(6,2), 
	CRED_INTR NUMBER(6,2), 
	LATE_INTR NUMBER(6,2), 
	CARD_FEE NUMBER(9,2), 
	CARD_FEE1 NUMBER(9,2), 
	NOTE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PCIMP_COND_SET ***
 exec bpa.alter_policies('PCIMP_COND_SET');


COMMENT ON TABLE BARS.PCIMP_COND_SET IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.CARD_TYPE IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.COND_SET IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.NAME IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.CURRENCY IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.C_VALIDITY IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.BL_10 IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.DEB_INTR IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.OLIM_INTR IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.CRED_INTR IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.LATE_INTR IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.CARD_FEE IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.CARD_FEE1 IS '';
COMMENT ON COLUMN BARS.PCIMP_COND_SET.NOTE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PCIMP_COND_SET.sql =========*** End **
PROMPT ===================================================================================== 
