

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/K2TMP.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to K2TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''K2TMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''K2TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''K2TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table K2TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.K2TMP 
   (	ISP NUMBER(*,0), 
	ACC9 NUMBER(*,0), 
	NLS9 VARCHAR2(15), 
	PR NUMBER(*,0), 
	OCH NUMBER(*,0), 
	ACC NUMBER(*,0), 
	REF NUMBER(*,0), 
	FDAT DATE, 
	SD NUMBER(38,0), 
	S NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to K2TMP ***
 exec bpa.alter_policies('K2TMP');


COMMENT ON TABLE BARS.K2TMP IS '';
COMMENT ON COLUMN BARS.K2TMP.ISP IS '';
COMMENT ON COLUMN BARS.K2TMP.ACC9 IS '';
COMMENT ON COLUMN BARS.K2TMP.NLS9 IS '';
COMMENT ON COLUMN BARS.K2TMP.PR IS '';
COMMENT ON COLUMN BARS.K2TMP.OCH IS '';
COMMENT ON COLUMN BARS.K2TMP.ACC IS '';
COMMENT ON COLUMN BARS.K2TMP.REF IS '';
COMMENT ON COLUMN BARS.K2TMP.FDAT IS '';
COMMENT ON COLUMN BARS.K2TMP.SD IS '';
COMMENT ON COLUMN BARS.K2TMP.S IS '';



PROMPT *** Create  grants  K2TMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on K2TMP           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on K2TMP           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/K2TMP.sql =========*** End *** =======
PROMPT ===================================================================================== 
