

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_LIM_COPY.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_LIM_COPY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_LIM_COPY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_LIM_COPY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_LIM_COPY'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_LIM_COPY ***
begin 
  execute immediate '
  create table CC_LIM_COPY
(
  id        NUMBER not null,
  nd        NUMBER(38) not null,
  fdat      DATE not null,
  lim2      NUMBER(38),
  acc       INTEGER,
  not_9129  INTEGER,
  sumg      NUMBER(38),
  sumo      NUMBER(38),
  otm       INTEGER,
  kf        VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'') not null,
  sumk      NUMBER,
  not_sn    INTEGER,
  oper_date DATE default sysdate not null,
  userid    NUMBER default sys_context(''userenv'', ''session_userid'') not null,
  comments  VARCHAR2(4000)
)
tablespace BRSBIGD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_LIM_COPY ***
exec bpa.alter_policies('CC_LIM_COPY');


PROMPT *** Create  constraint PK_CC_LIM_COPY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY add constraint PK_CC_LIM_COPY primary key (ID, ND, OPER_DATE, FDAT)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CC_LIM_COPY ***
grant SELECT                                                                 on CC_LIM_COPY         to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CC_LIM_COPY         to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_LIM_COPY         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_LIM_COPY         to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_LIM_COPY         to FOREX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_LIM_COPY         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_LIM_COPY         to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_LIM_COPY         to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on CC_LIM_COPY         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_LIM_COPY.sql =========*** End *** =====
PROMPT ===================================================================================== 
