

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPR_KL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPR_KL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPR_KL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_KL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_KL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPR_KL ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPR_KL 
   (	NAME VARCHAR2(8), 
	TXT VARCHAR2(48), 
	MODE_DEL NUMBER(1,0), 
	PR_SAVE NUMBER(1,0), 
	POLE_IND VARCHAR2(30), 
	NAME_IND VARCHAR2(12), 
	DLSTRN NUMBER(3,0), 
	FORMFEED NUMBER(1,0), 
	POLE_IND2 VARCHAR2(25), 
	FILTR_2 VARCHAR2(25), 
	PR_VIBOR NUMBER(1,0), 
	PR_FILTR NUMBER(1,0), 
	DATA_O DATE, 
	DATA_C DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPR_KL ***
 exec bpa.alter_policies('SPR_KL');


COMMENT ON TABLE BARS.SPR_KL IS '';
COMMENT ON COLUMN BARS.SPR_KL.NAME IS '';
COMMENT ON COLUMN BARS.SPR_KL.TXT IS '';
COMMENT ON COLUMN BARS.SPR_KL.MODE_DEL IS '';
COMMENT ON COLUMN BARS.SPR_KL.PR_SAVE IS '';
COMMENT ON COLUMN BARS.SPR_KL.POLE_IND IS '';
COMMENT ON COLUMN BARS.SPR_KL.NAME_IND IS '';
COMMENT ON COLUMN BARS.SPR_KL.DLSTRN IS '';
COMMENT ON COLUMN BARS.SPR_KL.FORMFEED IS '';
COMMENT ON COLUMN BARS.SPR_KL.POLE_IND2 IS '';
COMMENT ON COLUMN BARS.SPR_KL.FILTR_2 IS '';
COMMENT ON COLUMN BARS.SPR_KL.PR_VIBOR IS '';
COMMENT ON COLUMN BARS.SPR_KL.PR_FILTR IS '';
COMMENT ON COLUMN BARS.SPR_KL.DATA_O IS '';
COMMENT ON COLUMN BARS.SPR_KL.DATA_C IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPR_KL.sql =========*** End *** ======
PROMPT ===================================================================================== 
