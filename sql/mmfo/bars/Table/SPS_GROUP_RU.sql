PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPS_GROUP_RU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPS_GROUP_RU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPS_GROUP_RU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPS_GROUP_RU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPS_GROUP_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPS_GROUP_RU 
   (	ID        NUMBER       constraint CC_ID_NN not null,
        GROUP_SPS VARCHAR2(15) ,
        RU        VARCHAR2(6)  constraint CC_RU_NN  not null REFERENCES MV_KF(KF),
        UNION_ID  NUMBER 
   )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


--

PROMPT *** ALTER_POLICIES to SPS_GROUP_RU ***
 exec bpa.alter_policies('SPS_GROUP_RU');


COMMENT ON TABLE BARS.SPS_GROUP_RU IS 'Довідник груп рахунків перекриття в розрізі РУ, які використовуються технологами при договірних списаннях';
COMMENT ON COLUMN BARS.SPS_GROUP_RU.ID        IS 'ID черговості';
COMMENT ON COLUMN BARS.SPS_GROUP_RU.GROUP_SPS IS 'Група рахунків';
COMMENT ON COLUMN BARS.SPS_GROUP_RU.RU        IS 'РУ';
COMMENT ON COLUMN BARS.SPS_GROUP_RU.UNION_ID  IS 'ID групування';



PROMPT *** Create  constraint PK_GROUP_SPS_RU ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPS_GROUP_RU ADD CONSTRAINT PK_GROUP_SPS_RU PRIMARY KEY (ID, GROUP_SPS, RU)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  SPS_GROUP_RU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPS_GROUP_RU         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPS_GROUP_RU         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPS_GROUP_RU.sql =========*** End *** =====
PROMPT ===================================================================================== 
