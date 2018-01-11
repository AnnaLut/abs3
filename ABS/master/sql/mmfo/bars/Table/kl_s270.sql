

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S270.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S270 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S270'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S270'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S270'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S270 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S270 
   (	S270 VARCHAR2(2), 
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




PROMPT *** ALTER_POLICIES to KL_S270 ***
 exec bpa.alter_policies('KL_S270');


COMMENT ON TABLE BARS.KL_S270 IS '';
COMMENT ON COLUMN BARS.KL_S270.S270 IS '';
COMMENT ON COLUMN BARS.KL_S270.TXT IS '';
COMMENT ON COLUMN BARS.KL_S270.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_S270.DATA_C IS '';
COMMENT ON COLUMN BARS.KL_S270.DATA_M IS '';



PROMPT *** Create  grants  KL_S270 ***
grant SELECT                                                                 on KL_S270         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_S270         to BARSUPL;
grant SELECT                                                                 on KL_S270         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_S270         to BARS_DM;
grant SELECT                                                                 on KL_S270         to START1;
grant SELECT                                                                 on KL_S270         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_S270         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S270.sql =========*** End *** =====
PROMPT ===================================================================================== 
