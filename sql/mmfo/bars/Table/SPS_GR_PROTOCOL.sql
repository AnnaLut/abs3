PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPS_GR_PROTOCOL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPS_GR_PROTOCOL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPS_GR_PROTOCOL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPS_GR_PROTOCOL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPS_GR_PROTOCOL ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPS_GR_PROTOCOL 
   (    RU        VARCHAR2(6)     constraint CC_SPS_GR_PROT_RU_NN not null REFERENCES MV_KF(KF),
        GROUP_SPS VARCHAR2(15)    constraint CC_SPS_GR_PROT_GROUP_SPS_NN not null,
        USER_ID   NUMBER(38)      default sys_context(''bars_global'',''user_id''),
        MESSAGE   VARCHAR2(4000),
        TIME_SPS  DATE            default sysdate,
        DB        DATE            default to_date(sys_context(''bars_gl'',''bankdate''), ''mm.dd.yyyy'') 
   )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to SPS_GR_PROTOCOL ***
 exec bpa.alter_policies('SPS_GR_PROTOCOL');


COMMENT ON TABLE  BARS.SPS_GR_PROTOCOL           IS 'Протокол роботи технологічних списань';
COMMENT ON COLUMN BARS.SPS_GR_PROTOCOL.RU        IS 'РУ';
COMMENT ON COLUMN BARS.SPS_GR_PROTOCOL.GROUP_SPS IS 'Група рахунків';
COMMENT ON COLUMN BARS.SPS_GR_PROTOCOL.USER_ID   IS 'ID користувача';
COMMENT ON COLUMN BARS.SPS_GR_PROTOCOL.MESSAGE   IS 'Повідомлення';
COMMENT ON COLUMN BARS.SPS_GR_PROTOCOL.TIME_SPS  IS 'Дата/Час повідомлення';
COMMENT ON COLUMN BARS.SPS_GR_PROTOCOL.DB        IS 'Банківська дата';

PROMPT *** Create  grants  SPS_GR_PROTOCOL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPS_GR_PROTOCOL         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPS_GR_PROTOCOL         to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPS_GR_PROTOCOL.sql =========*** End *** =====
PROMPT ===================================================================================== 
