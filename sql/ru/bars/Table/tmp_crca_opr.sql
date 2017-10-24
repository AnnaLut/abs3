

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CRCA_OPR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CRCA_OPR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CRCA_OPR ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CRCA_OPR 
   (	NSC_ID VARCHAR2(38), 
	DATE_O VARCHAR2(10), 
	CODE_O VARCHAR2(3), 
	NAME_O VARCHAR2(24), 
	SUMM_O NUMBER(14,2)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CRCA_OPR ***
 exec bpa.alter_policies('TMP_CRCA_OPR');


COMMENT ON TABLE BARS.TMP_CRCA_OPR IS '';
COMMENT ON COLUMN BARS.TMP_CRCA_OPR.NSC_ID IS '';
COMMENT ON COLUMN BARS.TMP_CRCA_OPR.DATE_O IS '';
COMMENT ON COLUMN BARS.TMP_CRCA_OPR.CODE_O IS '';
COMMENT ON COLUMN BARS.TMP_CRCA_OPR.NAME_O IS '';
COMMENT ON COLUMN BARS.TMP_CRCA_OPR.SUMM_O IS '';




PROMPT *** Create  index IDX_TMP_CRCA_OPR_NSC_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_TMP_CRCA_OPR_NSC_ID ON BARS.TMP_CRCA_OPR (NSC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CRCA_OPR ***
grant DELETE,INSERT,SELECT                                                   on TMP_CRCA_OPR    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CRCA_OPR.sql =========*** End *** 
PROMPT ===================================================================================== 
