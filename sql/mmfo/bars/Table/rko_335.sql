

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_335.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_335 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_335'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RKO_335'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RKO_335'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_335 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.RKO_335 
   (	BRANCH VARCHAR2(30), 
	NLS VARCHAR2(14), 
	CNT1 NUMBER(*,0), 
	S1 NUMBER(25,0), 
	CNT2 NUMBER(*,0), 
	S2 NUMBER(25,0), 
	CNT3 NUMBER(*,0), 
	S3 NUMBER(25,0), 
	CNT4 NUMBER(*,0), 
	S4 NUMBER(25,0), 
	CNT5 NUMBER(*,0), 
	S5 NUMBER(25,0), 
	S_ALL NUMBER(*,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_335 ***
 exec bpa.alter_policies('RKO_335');


COMMENT ON TABLE BARS.RKO_335 IS '';
COMMENT ON COLUMN BARS.RKO_335.BRANCH IS '';
COMMENT ON COLUMN BARS.RKO_335.NLS IS '';
COMMENT ON COLUMN BARS.RKO_335.CNT1 IS '';
COMMENT ON COLUMN BARS.RKO_335.S1 IS '';
COMMENT ON COLUMN BARS.RKO_335.CNT2 IS '';
COMMENT ON COLUMN BARS.RKO_335.S2 IS '';
COMMENT ON COLUMN BARS.RKO_335.CNT3 IS '';
COMMENT ON COLUMN BARS.RKO_335.S3 IS '';
COMMENT ON COLUMN BARS.RKO_335.CNT4 IS '';
COMMENT ON COLUMN BARS.RKO_335.S4 IS '';
COMMENT ON COLUMN BARS.RKO_335.CNT5 IS '';
COMMENT ON COLUMN BARS.RKO_335.S5 IS '';
COMMENT ON COLUMN BARS.RKO_335.S_ALL IS '';



PROMPT *** Create  grants  RKO_335 ***
grant SELECT                                                                 on RKO_335         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on RKO_335         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT                                                   on RKO_335         to START1;
grant SELECT                                                                 on RKO_335         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_335.sql =========*** End *** =====
PROMPT ===================================================================================== 
