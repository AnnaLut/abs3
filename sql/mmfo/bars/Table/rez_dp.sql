

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_DP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_DP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_DP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_DP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_DP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_DP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.REZ_DP 
   (	ACC NUMBER(38,0), 
	ND NUMBER(38,0), 
	KV NUMBER(3,0), 
	PR VARCHAR2(1), 
	REST NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_DP ***
 exec bpa.alter_policies('REZ_DP');


COMMENT ON TABLE BARS.REZ_DP IS '';
COMMENT ON COLUMN BARS.REZ_DP.ACC IS '';
COMMENT ON COLUMN BARS.REZ_DP.ND IS '';
COMMENT ON COLUMN BARS.REZ_DP.KV IS '';
COMMENT ON COLUMN BARS.REZ_DP.PR IS '';
COMMENT ON COLUMN BARS.REZ_DP.REST IS '';




PROMPT *** Create  constraint SYS_C0010348 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_DP MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010350 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_DP MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010349 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_DP MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_REZ_DP_ND ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_REZ_DP_ND ON BARS.REZ_DP (ND) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_DP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_DP          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_DP          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_DP.sql =========*** End *** ======
PROMPT ===================================================================================== 
