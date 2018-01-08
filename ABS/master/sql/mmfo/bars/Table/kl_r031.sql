

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R031.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R031 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_R031'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R031'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R031'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R031 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R031 
   (	R031 CHAR(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_R031 ***
 exec bpa.alter_policies('KL_R031');


COMMENT ON TABLE BARS.KL_R031 IS '';
COMMENT ON COLUMN BARS.KL_R031.R031 IS '';
COMMENT ON COLUMN BARS.KL_R031.TXT IS '';



PROMPT *** Create  grants  KL_R031 ***
grant SELECT                                                                 on KL_R031         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_R031         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_R031         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_R031         to KL_R031;
grant SELECT                                                                 on KL_R031         to UPLD;
grant FLASHBACK,SELECT                                                       on KL_R031         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R031.sql =========*** End *** =====
PROMPT ===================================================================================== 
