

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BM_NLS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BM_NLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BM_NLS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BM_NLS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BM_NLS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BM_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BM_NLS 
   (	KV NUMBER(*,0), 
	TIP NUMBER(*,0), 
	PDV NUMBER(*,0), 
	S1001 VARCHAR2(14), 
	S1007 VARCHAR2(14), 
	S1101 VARCHAR2(14), 
	S1107 VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BM_NLS ***
 exec bpa.alter_policies('BM_NLS');


COMMENT ON TABLE BARS.BM_NLS IS '';
COMMENT ON COLUMN BARS.BM_NLS.KV IS '';
COMMENT ON COLUMN BARS.BM_NLS.TIP IS '';
COMMENT ON COLUMN BARS.BM_NLS.PDV IS '';
COMMENT ON COLUMN BARS.BM_NLS.S1001 IS '';
COMMENT ON COLUMN BARS.BM_NLS.S1007 IS '';
COMMENT ON COLUMN BARS.BM_NLS.S1101 IS '';
COMMENT ON COLUMN BARS.BM_NLS.S1107 IS '';




PROMPT *** Create  constraint PK_BMNLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BM_NLS ADD CONSTRAINT PK_BMNLS PRIMARY KEY (KV, TIP, PDV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BMNLS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BMNLS ON BARS.BM_NLS (KV, TIP, PDV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BM_NLS ***
grant SELECT                                                                 on BM_NLS          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BM_NLS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BM_NLS          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BM_NLS          to PYOD001;
grant SELECT                                                                 on BM_NLS          to UPLD;
grant FLASHBACK,SELECT                                                       on BM_NLS          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BM_NLS.sql =========*** End *** ======
PROMPT ===================================================================================== 
