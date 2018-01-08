begin
   execute immediate 'begin bpa.alter_policy_info( ''XOZ_REF_ARC'', ''WHOLE'' , null, null, null, null ); end;'; 
   execute immediate 'begin bpa.alter_policy_info( ''XOZ_REF_ARC'', ''FILIAL'', null, null, null, null ); end;';
end;
/

begin  EXECUTE IMMEDIATE 'create table XOZ_REF_ARC( 
       ACC    NUMBER                                 NOT NULL,
       REF1   NUMBER                                 NOT NULL,
       STMT1  NUMBER                                 NOT NULL,
       REF2   NUMBER,
       MDATE  DATE,
       S      NUMBER,
       FDAT   DATE                                   NOT NULL,
       S0     NUMBER,
       NOTP   INTEGER,
       PRG    INTEGER,
       BU     VARCHAR2(30 BYTE),
       DATZ   DATE,
       REFD   NUMBER,
       ID     NUMBER(38),
       mdat   date)
    TABLESPACE BRSMDLD ';
exception when others then  if SQLCODE = -00955 then null;   else raise; end if;
end;
/

exec  bpa.alter_policies('XOZ_REF_ARC'); 
/

-------------------------------------------------------------
grant select on  XOZ_REF_ARC to start1;
---------------------------------------------
COMMENT ON TABLE  BARS.XOZ_REF_ARC       IS 'Архив картотеки дебиторов (предназ по задумке для хоз.деб)';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.REF1  IS 'Референс начального документа  ДЕБЕТ';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.STMT1 IS 'stmt начального документа  ДЕБЕТ';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.REF2  IS 'Референс передебетованного док КРЕДИТ';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.ACC   IS 'Идентификатор счета картотеки';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.MDATE IS 'План-дата закриття';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.S     IS 'План-сума закриття';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.FDAT  IS 'Факт-дата откр.деб.';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.S0    IS 'Сума проплати (ДЕБЕТ)';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.NOTP  IS 'Признак "Нет.дог". 1 = В рез-23 НЕ учитывать просрочку по дате, как просрочку';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.PRG   IS 'Код проекту';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.BU    IS 'Код бюджетної одиниці';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.DATZ  IS 'Звітна дата зактиття деб.заб.';
COMMENT ON COLUMN BARS.XOZ_REF_ARC.REFd  IS 'Референс деб.запиту до ЦА на закриття дебітора';
----------------------------------------------
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.XOZ_REF_ARC TO BARS_ACCESS_DEFROLE;

begin    execute immediate '  ALTER TABLE BARS.XOZ_REF_ARC ADD (  CONSTRAINT PK_XOZREFARC  PRIMARY KEY  (mdat, REF1, STMT1)) ';
exception when others then   if SQLCODE = - 02260 then null;   else raise; end if; --ORA-02260: table can have only one primary key
end;
/

begin    execute immediate ' ALTER TABLE BARS.XOZ_REF_ARC ADD (  CONSTRAINT CC_xozrefarc_ref2datz CHECK (REF2 IS NULL AND DATZ IS NULL 
                                                                     OR 
                                                                   REF2 IS NOT NULL AND DATZ IS NOT NULL
                                                           )
                             ENABLE VALIDATE
                             )';
exception when others then if SQLCODE = - 02264 then null; else raise; end if; -- ORA-02264: name already used by an existing constraint
end;
/

begin
   execute immediate 'CREATE INDEX I1_XOZ_REF_ARC ON XOZ_REF_ARC (mdat, acc)';
   exception when others then if (sqlcode = -00955 or sqlcode = -54) then null; else raise; end if;    
end;
/

begin    execute immediate ' ALTER TABLE BARS.XOZ_REF_ARC ADD (  CONSTRAINT CC_XOZREFARC_FDAT_MDATE  CHECK (FDAT <= MDATe)   ENABLE VALIDATE) ' ;
exception when others then   if SQLCODE = - 02264 then null;   else raise; end if; --ORA-02264: name already used by an existing constraint
end;
/

exec bars_policy_adm.add_column_kf(p_table_name => 'XOZ_REF_ARC');
exec bars_policy_adm.alter_policy_info(p_table_name => 'XOZ_REF_ARC', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
exec bars_policy_adm.alter_policy_info(p_table_name => 'XOZ_REF_ARC', p_policy_group => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'M', p_update_policy => 'M', p_delete_policy => 'M');
exec bars_policy_adm.alter_policies(p_table_name => 'XOZ_REF_ARC');

exec bars_policy_adm.alter_policy_info(p_table_name => 'XOZ_REF', p_policy_group => 'WHOLE', p_select_policy => null, p_insert_policy => 'E', p_update_policy => 'E', p_delete_policy => 'E');
exec bars_policy_adm.alter_policy_info(p_table_name => 'XOZ_REF', p_policy_group => 'FILIAL', p_select_policy => 'M', p_insert_policy => 'M', p_update_policy => 'M', p_delete_policy => 'M');
exec bars_policy_adm.alter_policies(p_table_name => 'XOZ_REF');



