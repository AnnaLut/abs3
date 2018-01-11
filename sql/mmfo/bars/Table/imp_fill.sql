

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IMP_FILL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IMP_FILL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IMP_FILL ***
begin 
  execute immediate '
  CREATE TABLE BARS.IMP_FILL 
   (	RMIN NUMBER, 
	RMAX NUMBER, 
	PNAME VARCHAR2(20), 
	REFCOMMIT_OPR NUMBER, 
	REFCOMMIT_OPL NUMBER, 
	REFCOMMIT_OPRW NUMBER, 
	REFCOMMIT_ARC NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IMP_FILL ***
 exec bpa.alter_policies('IMP_FILL');


COMMENT ON TABLE BARS.IMP_FILL IS '';
COMMENT ON COLUMN BARS.IMP_FILL.REFCOMMIT_OPR IS '';
COMMENT ON COLUMN BARS.IMP_FILL.REFCOMMIT_OPL IS '';
COMMENT ON COLUMN BARS.IMP_FILL.REFCOMMIT_OPRW IS '';
COMMENT ON COLUMN BARS.IMP_FILL.REFCOMMIT_ARC IS '';
COMMENT ON COLUMN BARS.IMP_FILL.RMIN IS '';
COMMENT ON COLUMN BARS.IMP_FILL.RMAX IS '';
COMMENT ON COLUMN BARS.IMP_FILL.PNAME IS '';



PROMPT *** Create  grants  IMP_FILL ***
grant SELECT                                                                 on IMP_FILL        to BARSREADER_ROLE;
grant SELECT                                                                 on IMP_FILL        to BARS_DM;
grant SELECT                                                                 on IMP_FILL        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IMP_FILL.sql =========*** End *** ====
PROMPT ===================================================================================== 
