

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_HIST_PR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_HIST_PR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_HIST_PR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S6_HIST_PR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''S6_HIST_PR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_HIST_PR ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_HIST_PR 
   (	PercenRate NUMBER(10,0), 
	DA DATE, 
	Percen NUMBER(16,8), 
	ISP_Modify NUMBER(5,0), 
	D_Modify DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_HIST_PR ***
 exec bpa.alter_policies('S6_HIST_PR');


COMMENT ON TABLE BARS.S6_HIST_PR IS '';
COMMENT ON COLUMN BARS.S6_HIST_PR.PercenRate IS '';
COMMENT ON COLUMN BARS.S6_HIST_PR.DA IS '';
COMMENT ON COLUMN BARS.S6_HIST_PR.Percen IS '';
COMMENT ON COLUMN BARS.S6_HIST_PR.ISP_Modify IS '';
COMMENT ON COLUMN BARS.S6_HIST_PR.D_Modify IS '';




PROMPT *** Create  constraint SYS_C009181 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_HIST_PR MODIFY (PercenRate NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009182 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_HIST_PR MODIFY (DA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009183 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_HIST_PR MODIFY (Percen NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_S6_HIST_PR ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_S6_HIST_PR ON BARS.S6_HIST_PR (PercenRate) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_HIST_PR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_HIST_PR      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_HIST_PR      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_HIST_PR      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_HIST_PR.sql =========*** End *** ==
PROMPT ===================================================================================== 
