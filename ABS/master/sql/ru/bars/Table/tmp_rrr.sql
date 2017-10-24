

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_RRR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_RRR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_RRR'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_RRR ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_RRR 
   (	RISK NUMBER(*,0), 
	ACC NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_RRR ***
 exec bpa.alter_policies('TMP_RRR');


COMMENT ON TABLE BARS.TMP_RRR IS '';
COMMENT ON COLUMN BARS.TMP_RRR.RISK IS '';
COMMENT ON COLUMN BARS.TMP_RRR.ACC IS '';



PROMPT *** Create  grants  TMP_RRR ***
grant SELECT                                                                 on TMP_RRR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_RRR         to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_RRR         to TMP_RRR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_RRR.sql =========*** End *** =====
PROMPT ===================================================================================== 
