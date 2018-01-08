

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_70_2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_70_2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_70_2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_70_2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_70_2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_70_2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_70_2 
   (	P63 VARCHAR2(11), 
	TXT VARCHAR2(60), 
	TXT108 VARCHAR2(108), 
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




PROMPT *** ALTER_POLICIES to KOD_70_2 ***
 exec bpa.alter_policies('KOD_70_2');


COMMENT ON TABLE BARS.KOD_70_2 IS '';
COMMENT ON COLUMN BARS.KOD_70_2.P63 IS '';
COMMENT ON COLUMN BARS.KOD_70_2.TXT IS '';
COMMENT ON COLUMN BARS.KOD_70_2.TXT108 IS '';
COMMENT ON COLUMN BARS.KOD_70_2.DATA_O IS '';
COMMENT ON COLUMN BARS.KOD_70_2.DATA_C IS '';



PROMPT *** Create  grants  KOD_70_2 ***
grant FLASHBACK,SELECT                                                       on KOD_70_2        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_70_2        to BARS_DM;
grant FLASHBACK,SELECT                                                       on KOD_70_2        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_70_2.sql =========*** End *** ====
PROMPT ===================================================================================== 
