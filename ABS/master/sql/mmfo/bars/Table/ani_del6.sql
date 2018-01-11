

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI_DEL6.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI_DEL6 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI_DEL6'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_DEL6'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_DEL6'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI_DEL6 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI_DEL6 
   (	G01 VARCHAR2(50), 
	G02 VARCHAR2(6), 
	G03 VARCHAR2(22), 
	G04 VARCHAR2(38), 
	G05 VARCHAR2(10), 
	G06 VARCHAR2(4), 
	G07 VARCHAR2(2), 
	G08 VARCHAR2(14), 
	G09 NUMBER(*,0), 
	G10 NUMBER(*,0), 
	G11 VARCHAR2(35), 
	G12 NUMBER(*,0), 
	G13 NUMBER(*,0), 
	G14 VARCHAR2(10), 
	G15 VARCHAR2(10), 
	G16 NUMBER, 
	G17 NUMBER, 
	G18 NUMBER, 
	G19 NUMBER, 
	G20 NUMBER, 
	G21 NUMBER(*,0), 
	G22 CHAR(1), 
	G23 CHAR(1), 
	G24 VARCHAR2(2), 
	G25 VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI_DEL6 ***
 exec bpa.alter_policies('ANI_DEL6');


COMMENT ON TABLE BARS.ANI_DEL6 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G01 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G02 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G03 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G04 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G05 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G06 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G07 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G08 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G09 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G10 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G11 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G12 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G13 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G14 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G15 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G16 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G17 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G18 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G19 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G20 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G21 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G22 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G23 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G24 IS '';
COMMENT ON COLUMN BARS.ANI_DEL6.G25 IS '';



PROMPT *** Create  grants  ANI_DEL6 ***
grant SELECT                                                                 on ANI_DEL6        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANI_DEL6        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANI_DEL6        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANI_DEL6        to START1;
grant SELECT                                                                 on ANI_DEL6        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI_DEL6.sql =========*** End *** ====
PROMPT ===================================================================================== 
