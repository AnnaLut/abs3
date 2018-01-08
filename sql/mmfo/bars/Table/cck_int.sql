

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_INT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_INT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_INT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CCK_INT 
   (	FDAT DATE, 
	FDAT1 DATE, 
	OST NUMBER(38,0), 
	OSTI NUMBER(38,0), 
	KV NUMBER(3,0), 
	OTM NUMBER(38,0), 
	F10 NUMBER(38,0), 
	F11 NUMBER(38,0), 
	F12 NUMBER(38,0), 
	F13 NUMBER(38,0), 
	F14 NUMBER(38,0), 
	F15 NUMBER(38,0), 
	OTMP NUMBER(38,0), 
	OSTD NUMBER(38,0), 
	F06 NUMBER(38,0), 
	F07 NUMBER(38,0), 
	F08 NUMBER(38,0), 
	F09 NUMBER(38,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_INT ***
 exec bpa.alter_policies('CCK_INT');


COMMENT ON TABLE BARS.CCK_INT IS '';
COMMENT ON COLUMN BARS.CCK_INT.FDAT IS '';
COMMENT ON COLUMN BARS.CCK_INT.FDAT1 IS '';
COMMENT ON COLUMN BARS.CCK_INT.OST IS '';
COMMENT ON COLUMN BARS.CCK_INT.OSTI IS '';
COMMENT ON COLUMN BARS.CCK_INT.KV IS '';
COMMENT ON COLUMN BARS.CCK_INT.OTM IS '';
COMMENT ON COLUMN BARS.CCK_INT.F10 IS '';
COMMENT ON COLUMN BARS.CCK_INT.F11 IS '';
COMMENT ON COLUMN BARS.CCK_INT.F12 IS '';
COMMENT ON COLUMN BARS.CCK_INT.F13 IS '';
COMMENT ON COLUMN BARS.CCK_INT.F14 IS '';
COMMENT ON COLUMN BARS.CCK_INT.F15 IS '';
COMMENT ON COLUMN BARS.CCK_INT.OTMP IS '';
COMMENT ON COLUMN BARS.CCK_INT.OSTD IS '';
COMMENT ON COLUMN BARS.CCK_INT.F06 IS '';
COMMENT ON COLUMN BARS.CCK_INT.F07 IS '';
COMMENT ON COLUMN BARS.CCK_INT.F08 IS '';
COMMENT ON COLUMN BARS.CCK_INT.F09 IS '';



PROMPT *** Create  grants  CCK_INT ***
grant SELECT                                                                 on CCK_INT         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_INT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_INT         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_INT         to RCC_DEAL;
grant SELECT                                                                 on CCK_INT         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_INT         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_INT.sql =========*** End *** =====
PROMPT ===================================================================================== 
