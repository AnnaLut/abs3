

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SB_P0853_BARS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SB_P0853_BARS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SB_P0853_BARS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SB_P0853_BARS 
   (	NLS VARCHAR2(15), 
	P080 CHAR(4), 
	R020_FA CHAR(4), 
	OB22_FA CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SB_P0853_BARS ***
 exec bpa.alter_policies('TMP_SB_P0853_BARS');


COMMENT ON TABLE BARS.TMP_SB_P0853_BARS IS '';
COMMENT ON COLUMN BARS.TMP_SB_P0853_BARS.NLS IS '';
COMMENT ON COLUMN BARS.TMP_SB_P0853_BARS.P080 IS '';
COMMENT ON COLUMN BARS.TMP_SB_P0853_BARS.R020_FA IS '';
COMMENT ON COLUMN BARS.TMP_SB_P0853_BARS.OB22_FA IS '';




PROMPT *** Create  constraint PK_TMP_SB_P0853_BARS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SB_P0853_BARS ADD CONSTRAINT PK_TMP_SB_P0853_BARS PRIMARY KEY (NLS, P080)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_SB_P0853_BARS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_SB_P0853_BARS ON BARS.TMP_SB_P0853_BARS (NLS, P080) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SB_P0853_BARS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_SB_P0853_BARS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_SB_P0853_BARS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SB_P0853_BARS to NALOG;
grant FLASHBACK,SELECT                                                       on TMP_SB_P0853_BARS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SB_P0853_BARS.sql =========*** End
PROMPT ===================================================================================== 
