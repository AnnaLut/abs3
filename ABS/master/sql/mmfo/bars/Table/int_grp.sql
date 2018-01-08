

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_GRP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_GRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_GRP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT_GRP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INT_GRP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_GRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_GRP 
   (	IDG NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_GRP ***
 exec bpa.alter_policies('INT_GRP');


COMMENT ON TABLE BARS.INT_GRP IS '';
COMMENT ON COLUMN BARS.INT_GRP.IDG IS '';
COMMENT ON COLUMN BARS.INT_GRP.NAME IS '';



PROMPT *** Create  grants  INT_GRP ***
grant SELECT                                                                 on INT_GRP         to BARSREADER_ROLE;
grant SELECT                                                                 on INT_GRP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_GRP         to BARS_DM;
grant SELECT                                                                 on INT_GRP         to RPBN001;
grant SELECT                                                                 on INT_GRP         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_GRP         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_GRP.sql =========*** End *** =====
PROMPT ===================================================================================== 
