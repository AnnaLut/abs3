

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S280.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S280 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S280'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S280'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S280'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S280 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S280 
   (	S280 CHAR(1), 
	TXT VARCHAR2(40), 
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




PROMPT *** ALTER_POLICIES to KL_S280 ***
 exec bpa.alter_policies('KL_S280');


COMMENT ON TABLE BARS.KL_S280 IS '';
COMMENT ON COLUMN BARS.KL_S280.S280 IS '';
COMMENT ON COLUMN BARS.KL_S280.TXT IS '';
COMMENT ON COLUMN BARS.KL_S280.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S280.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_S280.DATA_M IS '';



PROMPT *** Create  grants  KL_S280 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S280         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_S280         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S280         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S280.sql =========*** End *** =====
PROMPT ===================================================================================== 
