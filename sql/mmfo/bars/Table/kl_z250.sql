

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_Z250.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_Z250 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_Z250'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z250'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_Z250'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_Z250 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_Z250 
   (	Z250 CHAR(2), 
	TXT VARCHAR2(25), 
	S_MIN NUMBER(15,0), 
	S_MAX NUMBER(15,0), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_Z250 ***
 exec bpa.alter_policies('KL_Z250');


COMMENT ON TABLE BARS.KL_Z250 IS '';
COMMENT ON COLUMN BARS.KL_Z250.Z250 IS '';
COMMENT ON COLUMN BARS.KL_Z250.TXT IS '';
COMMENT ON COLUMN BARS.KL_Z250.S_MIN IS '';
COMMENT ON COLUMN BARS.KL_Z250.S_MAX IS '';
COMMENT ON COLUMN BARS.KL_Z250.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_Z250.D_CLOSE IS '';



PROMPT *** Create  grants  KL_Z250 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z250         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_Z250         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_Z250         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_Z250.sql =========*** End *** =====
PROMPT ===================================================================================== 
