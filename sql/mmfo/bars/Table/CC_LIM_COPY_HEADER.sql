

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_LIM_COPY_HEADER.sql =========*** Run *** =====
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to CC_LIM_COPY_HEADER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_LIM_COPY_HEADER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_LIM_COPY_HEADER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_LIM_COPY_HEADER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_LIM_COPY_HEADER ***
begin 
  execute immediate '
  create table CC_LIM_COPY_HEADER
(
  id        NUMBER not null,
  nd        NUMBER not null,
  oper_date DATE default sysdate not null,
  userid    NUMBER not null,
  comments  VARCHAR2(4000)
)
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to CC_LIM_COPY_HEADER ***
 exec bpa.alter_policies('CC_LIM_COPY_HEADER');
 

PROMPT *** Create  constraint PK_CC_LIM_COPY_ID ***
begin   
 execute immediate '
  alter table CC_LIM_COPY_HEADER add constraint PK_CC_LIM_COPY_ID primary key (ID)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CC_LIM_COPY_HEADER ***
grant SELECT                                                                 on CC_LIM_COPY_HEADER         to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CC_LIM_COPY_HEADER         to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_LIM_COPY_HEADER         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_LIM_COPY_HEADER         to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_LIM_COPY_HEADER         to FOREX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_LIM_COPY_HEADER         to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_LIM_COPY_HEADER         to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on CC_LIM_COPY_HEADER         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_LIM_COPY_HEADER.sql =========*** End *** =====
PROMPT ===================================================================================== 
