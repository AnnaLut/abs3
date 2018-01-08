

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S134.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S134 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S134'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S134'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S134'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S134 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S134 
   (	S134 VARCHAR2(2), 
	TXT VARCHAR2(58), 
	TXT27 VARCHAR2(27), 
	DATA_O DATE, 
	DATA_C DATE, 
	DATA_M DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_S134 ***
 exec bpa.alter_policies('KL_S134');


COMMENT ON TABLE BARS.KL_S134 IS '';
COMMENT ON COLUMN BARS.KL_S134.S134 IS '';
COMMENT ON COLUMN BARS.KL_S134.TXT IS '';
COMMENT ON COLUMN BARS.KL_S134.TXT27 IS '';
COMMENT ON COLUMN BARS.KL_S134.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S134.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_S134.DATA_M IS '';



PROMPT *** Create  grants  KL_S134 ***
grant SELECT                                                                 on KL_S134         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S134.sql =========*** End *** =====
PROMPT ===================================================================================== 
