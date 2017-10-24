

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER_INTPER.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER_INTPER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER_INTPER'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_OVER_INTPER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER_INTPER ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER_INTPER 
   (	BR_ID NUMBER, 
	LIM1 NUMBER(*,0), 
	LIM2 NUMBER(*,0), 
	RATE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_OVER_INTPER ***
 exec bpa.alter_policies('ACC_OVER_INTPER');


COMMENT ON TABLE BARS.ACC_OVER_INTPER IS '�����R�-�� �_��R�R� ��_�_-� ����_�� ��R�. ����R� �<� OVR';
COMMENT ON COLUMN BARS.ACC_OVER_INTPER.BR_ID IS '';
COMMENT ON COLUMN BARS.ACC_OVER_INTPER.LIM1 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_INTPER.LIM2 IS '';
COMMENT ON COLUMN BARS.ACC_OVER_INTPER.RATE IS '';




PROMPT *** Create  constraint FK_ACC_OVER_INTPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_INTPER ADD CONSTRAINT FK_ACC_OVER_INTPER FOREIGN KEY (BR_ID)
	  REFERENCES BARS.BRATES (BR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_OVER_INTPER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_INTPER to ABS_ADMIN;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ACC_OVER_INTPER to BARS009;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_INTPER to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_INTPER to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_INTPER to TECH006;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_OVER_INTPER to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to ACC_OVER_INTPER ***

  CREATE OR REPLACE PUBLIC SYNONYM ACC_OVER_INTPER FOR BARS.ACC_OVER_INTPER;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER_INTPER.sql =========*** End *
PROMPT ===================================================================================== 
