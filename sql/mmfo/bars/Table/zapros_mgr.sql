

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAPROS_MGR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAPROS_MGR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAPROS_MGR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAPROS_MGR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAPROS_MGR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAPROS_MGR 
   (	BRANCH VARCHAR2(30), 
	PKEY VARCHAR2(30), 
	KODZ_OLD NUMBER(38,0), 
	KODZ_NEW NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAPROS_MGR ***
 exec bpa.alter_policies('ZAPROS_MGR');


COMMENT ON TABLE BARS.ZAPROS_MGR IS '';
COMMENT ON COLUMN BARS.ZAPROS_MGR.BRANCH IS '';
COMMENT ON COLUMN BARS.ZAPROS_MGR.PKEY IS '';
COMMENT ON COLUMN BARS.ZAPROS_MGR.KODZ_OLD IS '';
COMMENT ON COLUMN BARS.ZAPROS_MGR.KODZ_NEW IS '';



PROMPT *** Create  grants  ZAPROS_MGR ***
grant SELECT                                                                 on ZAPROS_MGR      to BARSREADER_ROLE;
grant SELECT                                                                 on ZAPROS_MGR      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAPROS_MGR.sql =========*** End *** ==
PROMPT ===================================================================================== 
