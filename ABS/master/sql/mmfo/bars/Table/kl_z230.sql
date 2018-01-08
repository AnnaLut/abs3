

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z230.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z230 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z230'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z230'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z230'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z230 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z230 
   (	Z230 CHAR(2), 
	TXT VARCHAR2(54), 
	TXT54 VARCHAR2(54), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_CHANGE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_Z230 ***
 exec bpa.alter_policies('KL_Z230');


COMMENT ON TABLE BARS.KL_Z230 IS '';
COMMENT ON COLUMN BARS.KL_Z230.Z230 IS '';
COMMENT ON COLUMN BARS.KL_Z230.TXT IS '';
COMMENT ON COLUMN BARS.KL_Z230.TXT54 IS '';
COMMENT ON COLUMN BARS.KL_Z230.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z230.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_Z230.D_CHANGE IS '';



PROMPT *** Create  grants  KL_Z230 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z230         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_Z230         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z230         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z230.sql =========*** End *** =====
PROMPT ===================================================================================== 
