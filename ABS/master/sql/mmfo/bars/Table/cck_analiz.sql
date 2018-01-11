

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_ANALIZ.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_ANALIZ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_ANALIZ ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CCK_ANALIZ 
   (	DL CHAR(1), 
	NBS CHAR(4), 
	NAME VARCHAR2(30), 
	KV NUMBER(*,0), 
	PR NUMBER(38,0), 
	SROK NUMBER(38,0), 
	S NUMBER(38,0), 
	DOS NUMBER(38,0), 
	KOS NUMBER(38,0), 
	SN NUMBER(38,0), 
	DOSN NUMBER(38,0), 
	KOSN NUMBER(38,0), 
	OE NUMBER(*,0), 
	INSIDER NUMBER(*,0), 
	TIP NUMBER(*,0), 
	POROG NUMBER(*,0), 
	REG NUMBER(*,0), 
	ZAL NUMBER(38,0), 
	ZALQ NUMBER(38,0), 
	REZ NUMBER(38,0), 
	REZQ NUMBER(38,0), 
	UV NUMBER(38,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_ANALIZ ***
 exec bpa.alter_policies('CCK_ANALIZ');


COMMENT ON TABLE BARS.CCK_ANALIZ IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.DL IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.NBS IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.NAME IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.KV IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.PR IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.SROK IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.S IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.DOS IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.KOS IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.SN IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.DOSN IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.KOSN IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.OE IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.INSIDER IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.TIP IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.POROG IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.REG IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.ZAL IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.ZALQ IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.REZ IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.REZQ IS '';
COMMENT ON COLUMN BARS.CCK_ANALIZ.UV IS '';



PROMPT *** Create  grants  CCK_ANALIZ ***
grant SELECT                                                                 on CCK_ANALIZ      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_ANALIZ      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_ANALIZ      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_ANALIZ      to RCC_DEAL;
grant SELECT                                                                 on CCK_ANALIZ      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_ANALIZ      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_ANALIZ.sql =========*** End *** ==
PROMPT ===================================================================================== 
