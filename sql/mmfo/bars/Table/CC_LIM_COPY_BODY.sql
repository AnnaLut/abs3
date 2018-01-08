

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_LIM_COPY_BODY.sql =========*** Run *** =====
PROMPT ===================================================================================== 

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_LIM_COPY_BODY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_LIM_COPY_BODY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_LIM_COPY_BODY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


PROMPT *** Create  table CC_LIM_COPY_BODY ***
begin 
  execute immediate '
  create table CC_LIM_COPY_BODY
(
  id       NUMBER,
  nd       NUMBER(38),
  fdat     DATE,
  lim2     NUMBER(38),
  acc      INTEGER,
  not_9129 INTEGER,
  sumg     NUMBER(38),
  sumo     NUMBER(38),
  otm      INTEGER,
  kf       VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'') not null,
  sumk     NUMBER,
  not_sn   INTEGER
)
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
PROMPT *** ALTER_POLICIES to DPU_PROC_DR ***
 exec bpa.alter_policies('DPU_PROC_DR');


PROMPT *** Create  constraint PK_CC_LIM_COPY_ID ***
begin   
 execute immediate '
  alter table CC_LIM_COPY_BODY 
  add constraint FK_CC_LIM_COPY_ID foreign key (ID)
  references CC_LIM_COPY_HEADER (ID) on delete cascade';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  index I_CC_LIM_COPY_ID ***
begin   
 execute immediate '
  create index I_CC_LIM_COPY_ID on CC_LIM_COPY_BODY (ID)
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CC_LIM_COPY_BODY ***
grant SELECT                                                                 on CC_LIM_COPY_BODY         to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CC_LIM_COPY_BODY         to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_LIM_COPY_BODY         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_LIM_COPY_BODY         to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_LIM_COPY_BODY         to FOREX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_LIM_COPY_BODY         to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_LIM_COPY_BODY         to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on CC_LIM_COPY_BODY         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_LIM_COPY_BODY.sql =========*** End *** =====
PROMPT ===================================================================================== 
