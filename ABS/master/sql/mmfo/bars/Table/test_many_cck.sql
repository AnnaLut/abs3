-- Добавлен в индекс NLS (было два 9129 при тестировании)
begin 
  execute immediate 'ALTER TABLE BARS.TEST_MANY_CCK DROP PRIMARY KEY CASCADE';
exception when others then 
  if sqlcode in (-02441) then null; else raise; end if; --,-02441
end;
/

begin 
 execute immediate 'DROP TABLE BARS.TEST_MANY_CCK CASCADE CONSTRAINTS';
exception when others then 
  if sqlcode=-942 then null; else raise; end if;
end;
/

begin

  if getglobaloption('HAVETOBO') = 2 then   

     execute immediate 'begin bpa.alter_policy_info(''TEST_MANY_CCK'', ''WHOLE'' , null , ''E'', ''E'', ''E'' ); end;'; 
     execute immediate 'begin bpa.alter_policy_info(''TEST_MANY_CCK'', ''FILIAL'', ''M'', ''M'', ''M'', ''M'' ); end;';

     EXECUTE IMMEDIATE 'CREATE TABLE BARS.TEST_MANY_CCK'||
    '(
      ND      NUMBER,
      PV      NUMBER,
      IRR0    NUMBER,
      BRANCH  VARCHAR2(22 BYTE),
      VIDD    NUMBER(38),
      SDATE   DATE,
      WDATE   DATE,
      IR      NUMBER,
      BV      NUMBER,
      RNK     NUMBER,
      K       NUMBER,
      KAT     NUMBER,
      NLS     VARCHAR2(15 BYTE),
      KV      NUMBER(38),
      OBS     NUMBER(38),
      FIN     NUMBER(38),
      FINN    VARCHAR2(35 BYTE),
      OBESP   NUMBER,
      REZ     NUMBER,
      DAT     DATE,
      ID      NUMBER(38)     DEFAULT sys_context(''bars_global'',''user_id''),
      BASEY   NUMBER(38),
      BVQ     NUMBER,
      PVQ     NUMBER,
      ZALQ    NUMBER,
      REZQ    NUMBER,
      PVZ     NUMBER,
      PVZQ    NUMBER,
      R013    CHAR(1 BYTE),
      SDI     NUMBER,
      VKR     VARCHAR2(10 BYTE),
      KF      VARCHAR2(6 BYTE)  DEFAULT sys_context(''bars_context'',''user_mfo'') CONSTRAINT CC_TEST_MANY_CCK_KF_NN NOT NULL
     )';
  end if;

exception when others then
  -- ORA-00955: name is already used by an existing object
  if SQLCODE = -00955 then null;   else raise; end if; 
end;
/
begin
  if getglobaloption('HAVETOBO') = 2 then    
     execute immediate 'begin   bpa.alter_policies(''TEST_MANY_CCK''); end;'; 
   end if;
end;
/
commit;

COMMENT ON COLUMN BARS.TEST_MANY_CCK.BVQ  IS 'BV-екв';
COMMENT ON COLUMN BARS.TEST_MANY_CCK.PVQ  IS 'PV-екв';
COMMENT ON COLUMN BARS.TEST_MANY_CCK.ZALQ IS 'Залог-екв';
COMMENT ON COLUMN BARS.TEST_MANY_CCK.REZQ IS 'Резерв-екв';
COMMENT ON COLUMN BARS.TEST_MANY_CCK.PVZ  IS 'Враховане (частина або все Справ.варт) забезпечення, ном в 1.00';
COMMENT ON COLUMN BARS.TEST_MANY_CCK.PVZQ IS 'Враховане (частина або все Справ.варт) забезпечення, екв в 1.00';
COMMENT ON COLUMN BARS.TEST_MANY_CCK.R013 IS 'R013~для~9129';
COMMENT ON COLUMN BARS.TEST_MANY_CCK.VKR  IS 'Внутренний кредитный рейтинг';

--CREATE UNIQUE INDEX BARS.PK_TESTMANYCCK ON BARS.TEST_MANY_CCK
--(DAT, ID, ND);

begin
   execute immediate 'alter table TEST_MANY_CCK add constraint PK_TESTMANYCCK primary key (DAT, ID, ND, NLS)';
   exception when others then if (sqlcode = -2260 or sqlcode = -54) then null; else raise; end if;
end;
/


begin 
  execute immediate 'DROP PUBLIC SYNONYM TEST_MANY_CCK1';
exception when others then 
  if sqlcode=-01432 then null; else raise; end if;
end;
/

CREATE PUBLIC SYNONYM TEST_MANY_CCK1 FOR BARS.TEST_MANY_CCK;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.TEST_MANY_CCK TO BARS_ACCESS_DEFROLE;
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.TEST_MANY_CCK TO RCC_DEAL;
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.TEST_MANY_CCK TO START1;