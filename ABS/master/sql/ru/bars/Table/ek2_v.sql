

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK2_V.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK2_V ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK2_V'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK2_V'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK2_V ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK2_V 
   (	NBS VARCHAR2(4), 
	NAME VARCHAR2(40), 
	PAP NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK2_V ***
 exec bpa.alter_policies('EK2_V');


COMMENT ON TABLE BARS.EK2_V IS '������������� ������� ������ '�i���������' (EK2_V)';
COMMENT ON COLUMN BARS.EK2_V.NBS IS '';
COMMENT ON COLUMN BARS.EK2_V.NAME IS '';
COMMENT ON COLUMN BARS.EK2_V.PAP IS '';




PROMPT *** Create  constraint SYS_C0010125 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK2_V MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK2_V ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EK2_V           to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK2_V           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK2_V           to RPBN002;
grant SELECT                                                                 on EK2_V           to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK2_V           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK2_V.sql =========*** End *** =======
PROMPT ===================================================================================== 
