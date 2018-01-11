

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IDENT_FM_FL_SPD_OLD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IDENT_FM_FL_SPD_OLD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IDENT_FM_FL_SPD_OLD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IDENT_FM_FL_SPD_OLD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IDENT_FM_FL_SPD_OLD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IDENT_FM_FL_SPD_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.IDENT_FM_FL_SPD_OLD 
   (	G00 DATE, 
	G01 NUMBER, 
	G02 VARCHAR2(70), 
	G03 VARCHAR2(70), 
	G04 VARCHAR2(14), 
	G05 DATE, 
	G06 DATE, 
	G07 DATE, 
	G08 DATE, 
	G09 DATE, 
	G10 DATE, 
	G11 DATE, 
	G12 VARCHAR2(50)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IDENT_FM_FL_SPD_OLD ***
 exec bpa.alter_policies('IDENT_FM_FL_SPD_OLD');


COMMENT ON TABLE BARS.IDENT_FM_FL_SPD_OLD IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G00 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G01 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G02 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G03 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G04 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G05 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G06 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G07 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G08 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G09 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G10 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G11 IS '';
COMMENT ON COLUMN BARS.IDENT_FM_FL_SPD_OLD.G12 IS '';



PROMPT *** Create  grants  IDENT_FM_FL_SPD_OLD ***
grant SELECT                                                                 on IDENT_FM_FL_SPD_OLD to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on IDENT_FM_FL_SPD_OLD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on IDENT_FM_FL_SPD_OLD to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on IDENT_FM_FL_SPD_OLD to START1;
grant SELECT                                                                 on IDENT_FM_FL_SPD_OLD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IDENT_FM_FL_SPD_OLD.sql =========*** E
PROMPT ===================================================================================== 
