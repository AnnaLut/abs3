

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_HIST_PR_VIEW.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_HIST_PR_VIEW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_HIST_PR_VIEW ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_HIST_PR_VIEW 
   (	PercenRate NUMBER(10,0), 
	DA DATE, 
	Percen NUMBER(26,8), 
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




PROMPT *** ALTER_POLICIES to S6_HIST_PR_VIEW ***
 exec bpa.alter_policies('S6_HIST_PR_VIEW');


COMMENT ON TABLE BARS.S6_HIST_PR_VIEW IS '';
COMMENT ON COLUMN BARS.S6_HIST_PR_VIEW.PercenRate IS '';
COMMENT ON COLUMN BARS.S6_HIST_PR_VIEW.DA IS '';
COMMENT ON COLUMN BARS.S6_HIST_PR_VIEW.Percen IS '';
COMMENT ON COLUMN BARS.S6_HIST_PR_VIEW.ISP_Modify IS '';
COMMENT ON COLUMN BARS.S6_HIST_PR_VIEW.D_Modify IS '';




PROMPT *** Create  constraint SYS_C009179 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_HIST_PR_VIEW MODIFY (PercenRate NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009180 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_HIST_PR_VIEW MODIFY (DA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_HIST_PR_VIEW ***
grant SELECT                                                                 on S6_HIST_PR_VIEW to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_HIST_PR_VIEW to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_HIST_PR_VIEW to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_HIST_PR_VIEW to START1;
grant SELECT                                                                 on S6_HIST_PR_VIEW to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_HIST_PR_VIEW.sql =========*** End *
PROMPT ===================================================================================== 
