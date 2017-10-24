

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CH_KV.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CH_KV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CH_KV'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CH_KV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CH_KV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CH_KV ***
begin 
  execute immediate '
  CREATE TABLE BARS.CH_KV 
   (	KVC NUMBER(*,0), 
	KVP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CH_KV ***
 exec bpa.alter_policies('CH_KV');


COMMENT ON TABLE BARS.CH_KV IS '';
COMMENT ON COLUMN BARS.CH_KV.KVC IS '';
COMMENT ON COLUMN BARS.CH_KV.KVP IS '';




PROMPT *** Create  constraint XPK_CH_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CH_KV ADD CONSTRAINT XPK_CH_KV PRIMARY KEY (KVC, KVP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CH_KV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CH_KV ON BARS.CH_KV (KVC, KVP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CH_KV ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CH_KV           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CH_KV           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CH_KV           to RCH_1;
grant FLASHBACK,SELECT                                                       on CH_KV           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CH_KV.sql =========*** End *** =======
PROMPT ===================================================================================== 
