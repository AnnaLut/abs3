

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNK2NLS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNK2NLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNK2NLS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''RNK2NLS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNK2NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNK2NLS 
   (	RNKFROM NUMBER, 
	RNKTO NUMBER, 
	SDATE DATE, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	ID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNK2NLS ***
 exec bpa.alter_policies('RNK2NLS');


COMMENT ON TABLE BARS.RNK2NLS IS '';
COMMENT ON COLUMN BARS.RNK2NLS.RNKFROM IS '';
COMMENT ON COLUMN BARS.RNK2NLS.RNKTO IS '';
COMMENT ON COLUMN BARS.RNK2NLS.SDATE IS '';
COMMENT ON COLUMN BARS.RNK2NLS.NLS IS '';
COMMENT ON COLUMN BARS.RNK2NLS.KV IS '';
COMMENT ON COLUMN BARS.RNK2NLS.ID IS '';




PROMPT *** Create  index IK_R ***
begin   
 execute immediate '
  CREATE INDEX BARS.IK_R ON BARS.RNK2NLS (RNKTO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IK_RFROM ***
begin   
 execute immediate '
  CREATE INDEX BARS.IK_RFROM ON BARS.RNK2NLS (RNKFROM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNK2NLS ***
grant SELECT                                                                 on RNK2NLS         to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on RNK2NLS         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNK2NLS.sql =========*** End *** =====
PROMPT ===================================================================================== 
