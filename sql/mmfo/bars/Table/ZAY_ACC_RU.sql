PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_ACC_RU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_ACC_RU ***

BEGIN
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_ACC_RU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_ACC_RU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** CREATE TABLE to ZAY_ACC_RU ***

BEGIN
   EXECUTE IMMEDIATE q'[
            CREATE TABLE BARS.ZAY_ACC_RU (
                                             ACC   VARCHAR2 (15)  CONSTRAINT CC_ZAY_ACC_RU_ACC_NN NOT NULL  
                                            ,RU    VARCHAR2 (38)  CONSTRAINT CC_ZAY_ACC_RU_RU_NN NOT NULL
					  )]';
EXCEPTION
   WHEN OTHERS
   THEN
      IF SQLCODE = -955
      THEN
         NULL;
      ELSE
         RAISE;
      END IF;
END;
/


PROMPT *** ALTER_POLICIES to ZAY_ACC_RU ***
 exec bpa.alter_policies('ZAY_ACC_RU');


COMMENT ON TABLE BARS.ZAY_ACC_RU IS        'Довідник рахунків РУ на рівні ЦА на які приходять кошти по біржевому модулю';
COMMENT ON COLUMN BARS.ZAY_ACC_RU.ACC IS   'Номер рахунку';
COMMENT ON COLUMN BARS.ZAY_ACC_RU.RU  IS   'Назва РУ';


PROMPT *** Create  constraint PK_ZAY_ACC_RU ***
begin
    execute immediate 'alter table ZAY_ACC_RU
  add constraint PK_ZAY_ACC_RU primary key (ACC)';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/


PROMPT *** Create  grants  ZAY_ACC_RU ***

grant DELETE,INSERT,SELECT,UPDATE                                          on BARS.ZAY_ACC_RU         to BARS_ACCESS_DEFROLE;
