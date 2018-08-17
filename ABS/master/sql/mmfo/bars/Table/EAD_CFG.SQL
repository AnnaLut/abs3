

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_CFG.sql =========*** Run
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to EAD_CFG ***
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EAD_CFG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_CFG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_CFG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EAD_CFG ***
begin 
  execute immediate '
create table BARS.EAD_CFG
(
    kf   varchar2(6) not null,
    modes number(1) not null
)
tablespace BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EAD_CFG ***
 exec bpa.alter_policies('EAD_CFG');

-- Add comments
comment on table BARS.EAD_CFG is 'Ќастройки дл€ запуска сервиса по регионам';
comment on column BARS.EAD_CFG.kf is '–егион';
comment on column BARS.EAD_CFG.modes is 'ѕараметр запуска потока (0-выкл, 1-вкл параллельный режим запуска, 2-вкл последовательный режим запуска)';

PROMPT *** Create  constraint PK_EADCFG_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_CFG ADD CONSTRAINT PK_EADCFG_KF PRIMARY KEY (KF)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/


PROMPT *** Create  constraint CC_EADCFG_MODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_CFG ADD CONSTRAINT CC_EADCFG_MODES CHECK (MODES IN (0,1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/




PROMPT *** Create  grants  EAD_CFG ***
grant ALL                                                                 on BARS.EAD_CFG to BARS_ACCESS_DEFROLE;
grant ALL                                                                 on BARS.EAD_CFG   to BARSREADER_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_CFG.sql =========*** End
PROMPT ===================================================================================== 


PROMPT *** Run *** ==========  Importing EAD_CFG =========*** Run
MERGE INTO BARS.EAD_CFG A
     USING (SELECT kf, 0 AS MODES FROM mv_kf) B
        ON (A.KF = B.KF)
WHEN NOT MATCHED
THEN
    INSERT     (KF, MODES)
        VALUES (B.KF, B.MODES)
WHEN MATCHED
THEN
    UPDATE SET A.MODES = B.MODES;
COMMIT;
PROMPT *** End *** ========== Importing EAD_CFG =========*** End
