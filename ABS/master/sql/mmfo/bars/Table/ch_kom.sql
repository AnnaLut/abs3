

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CH_KOM.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CH_KOM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CH_KOM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CH_KOM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CH_KOM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CH_KOM ***
begin 
  execute immediate '
  CREATE TABLE BARS.CH_KOM 
   (	BIC_E VARCHAR2(11), 
	IDS NUMBER(*,0), 
	KV NUMBER(*,0), 
	ACC NUMBER(*,0), 
	S NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CH_KOM ***
 exec bpa.alter_policies('CH_KOM');


COMMENT ON TABLE BARS.CH_KOM IS '';
COMMENT ON COLUMN BARS.CH_KOM.BIC_E IS '';
COMMENT ON COLUMN BARS.CH_KOM.IDS IS '';
COMMENT ON COLUMN BARS.CH_KOM.KV IS '';
COMMENT ON COLUMN BARS.CH_KOM.ACC IS '';
COMMENT ON COLUMN BARS.CH_KOM.S IS '';




PROMPT *** Create  constraint PK_CH_KOM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CH_KOM ADD CONSTRAINT PK_CH_KOM PRIMARY KEY (BIC_E, ACC, IDS, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CH_KOM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CH_KOM ON BARS.CH_KOM (BIC_E, ACC, IDS, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CH_KOM ***
grant SELECT                                                                 on CH_KOM          to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CH_KOM          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CH_KOM          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CH_KOM          to RCH_1;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CH_KOM          to START1;
grant SELECT                                                                 on CH_KOM          to UPLD;
grant FLASHBACK,SELECT                                                       on CH_KOM          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CH_KOM.sql =========*** End *** ======
PROMPT ===================================================================================== 
