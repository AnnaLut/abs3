

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPR_REG_.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPR_REG_ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPR_REG_'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_REG_'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SPR_REG_'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPR_REG_ ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPR_REG_ 
   (	C_REG NUMBER(2,0), 
	C_DST NUMBER(2,0), 
	C_RAJ NUMBER(2,0), 
	T_STI NUMBER(2,0), 
	C_STI NUMBER(8,0), 
	NAME_STI VARCHAR2(54), 
	NAME_RAJ VARCHAR2(54), 
	ZIP_CODE NUMBER(6,0), 
	TEL_CODE VARCHAR2(8), 
	FAX VARCHAR2(9), 
	ADRESS VARCHAR2(54), 
	TEL_1 VARCHAR2(9), 
	TEL_2 VARCHAR2(9), 
	CHAR_O VARCHAR2(1), 
	MAIL_STA VARCHAR2(11), 
	STATUS VARCHAR2(1), 
	ISOFFICE NUMBER(1,0), 
	TYPE_STI NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPR_REG_ ***
 exec bpa.alter_policies('SPR_REG_');


COMMENT ON TABLE BARS.SPR_REG_ IS '';
COMMENT ON COLUMN BARS.SPR_REG_.C_REG IS '';
COMMENT ON COLUMN BARS.SPR_REG_.C_DST IS '';
COMMENT ON COLUMN BARS.SPR_REG_.C_RAJ IS '';
COMMENT ON COLUMN BARS.SPR_REG_.T_STI IS '';
COMMENT ON COLUMN BARS.SPR_REG_.C_STI IS '';
COMMENT ON COLUMN BARS.SPR_REG_.NAME_STI IS '';
COMMENT ON COLUMN BARS.SPR_REG_.NAME_RAJ IS '';
COMMENT ON COLUMN BARS.SPR_REG_.ZIP_CODE IS '';
COMMENT ON COLUMN BARS.SPR_REG_.TEL_CODE IS '';
COMMENT ON COLUMN BARS.SPR_REG_.FAX IS '';
COMMENT ON COLUMN BARS.SPR_REG_.ADRESS IS '';
COMMENT ON COLUMN BARS.SPR_REG_.TEL_1 IS '';
COMMENT ON COLUMN BARS.SPR_REG_.TEL_2 IS '';
COMMENT ON COLUMN BARS.SPR_REG_.CHAR_O IS '';
COMMENT ON COLUMN BARS.SPR_REG_.MAIL_STA IS '';
COMMENT ON COLUMN BARS.SPR_REG_.STATUS IS '';
COMMENT ON COLUMN BARS.SPR_REG_.ISOFFICE IS '';
COMMENT ON COLUMN BARS.SPR_REG_.TYPE_STI IS '';



PROMPT *** Create  grants  SPR_REG_ ***
grant SELECT                                                                 on SPR_REG_        to BARS_DM;



PROMPT *** Create SYNONYM  to SPR_REG_ ***

  CREATE OR REPLACE PUBLIC SYNONYM SPR_REG_ FOR BARS.SPR_REG_;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPR_REG_.sql =========*** End *** ====
PROMPT ===================================================================================== 
