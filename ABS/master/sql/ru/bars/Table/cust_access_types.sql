BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''cust_access_types'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''cust_access_types'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


begin 
  execute immediate '
  CREATE TABLE cust_access_types
 (  access_type_code varchar2(50),
    access_type_desc varchar2(200)
 )
 TABLESPACE brssmld';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/



exec bpa.alter_policies('cust_access_types');


COMMENT ON TABLE BARS.cust_access_types IS 'Типы доступа к полям';
COMMENT ON COLUMN BARS.cust_access_types.access_type_code IS 'Код';
COMMENT ON COLUMN BARS.cust_access_types.access_type_desc IS 'Наименовнаие?????';




begin   
 execute immediate ' alter table bars.cust_access_types add constraint xpk_cust_access_types primary key (access_type_code) using index tablespace brsmdli  enable';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


grant DELETE,INSERT,SELECT,UPDATE                                            on cust_access_types        to BARS_ACCESS_DEFROLE;
