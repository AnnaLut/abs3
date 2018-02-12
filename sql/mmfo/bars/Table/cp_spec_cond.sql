BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_SPEC_COND'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_SPEC_COND'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_SPEC_COND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

begin 
  execute immediate '
  CREATE TABLE BARS.CP_SPEC_COND
   (	ID NUMBER(2), 
	TITLE VARCHAR2(100),
        DEL_DATE DATE
   ) TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin   
 execute immediate 'create unique index U_CP_SPEC_COND on CP_SPEC_COND (id)
  tablespace BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'alter table CP_SPEC_COND
  add constraint PK_CP_SPEC_COND primary key (ID)
USING INDEX U_CP_SPEC_COND';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




 exec bpa.alter_policies('CP_SPEC_COND');

COMMENT ON TABLE BARS.CP_SPEC_COND IS 'Особливі умови ЦП';

grant SELECT                                                                 on CP_SPEC_COND          to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_SPEC_COND          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_SPEC_COND          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_SPEC_COND          to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_SPEC_COND          to START1;
grant SELECT                                                                 on CP_SPEC_COND          to UPLD;
grant FLASHBACK,SELECT                                                       on CP_SPEC_COND          to WR_REFREAD;
