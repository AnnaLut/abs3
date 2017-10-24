

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STRU_KL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STRU_KL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STRU_KL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STRU_KL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STRU_KL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STRU_KL ***
begin 
  execute immediate '
  CREATE TABLE BARS.STRU_KL 
   (	NAME VARCHAR2(8), 
	POLE VARCHAR2(10), 
	TYP VARCHAR2(2), 
	LEN NUMBER(3,0), 
	DEC NUMBER(3,0), 
	TXT VARCHAR2(144)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STRU_KL ***
 exec bpa.alter_policies('STRU_KL');


COMMENT ON TABLE BARS.STRU_KL IS '';
COMMENT ON COLUMN BARS.STRU_KL.NAME IS '';
COMMENT ON COLUMN BARS.STRU_KL.POLE IS '';
COMMENT ON COLUMN BARS.STRU_KL.TYP IS '';
COMMENT ON COLUMN BARS.STRU_KL.LEN IS '';
COMMENT ON COLUMN BARS.STRU_KL.DEC IS '';
COMMENT ON COLUMN BARS.STRU_KL.TXT IS '';



PROMPT *** Create  grants  STRU_KL ***
grant SELECT                                                                 on STRU_KL         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STRU_KL.sql =========*** End *** =====
PROMPT ===================================================================================== 
