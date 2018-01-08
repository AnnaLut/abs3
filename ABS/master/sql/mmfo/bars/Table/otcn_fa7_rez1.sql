

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_FA7_REZ1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_FA7_REZ1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_FA7_REZ1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_FA7_REZ1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_FA7_REZ1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_FA7_REZ1 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_FA7_REZ1 
   (	ND NUMBER, 
	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	KODP VARCHAR2(20), 
	ZNAP VARCHAR2(200), 
	SUMA NUMBER, 
	SUMD NUMBER, 
	SUMP NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_FA7_REZ1 ***
 exec bpa.alter_policies('OTCN_FA7_REZ1');


COMMENT ON TABLE BARS.OTCN_FA7_REZ1 IS 'Временная таблица для дисконтов/премий';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.ND IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.KV IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.KODP IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.ZNAP IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.SUMA IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.SUMD IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.SUMP IS '';




PROMPT *** Create  index I1_OTCN_FA7_REZ1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTCN_FA7_REZ1 ON BARS.OTCN_FA7_REZ1 (ND, KV) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_FA7_REZ1 ***
grant SELECT                                                                 on OTCN_FA7_REZ1   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_FA7_REZ1   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_FA7_REZ1   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_FA7_REZ1.sql =========*** End ***
PROMPT ===================================================================================== 
