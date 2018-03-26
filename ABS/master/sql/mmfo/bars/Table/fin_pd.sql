

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_PD.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_PD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_PD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_PD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_PD ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_PD 
   (	IDF NUMBER(*,0), 
		FIN NUMBER(2,0), 
		VNCRR NUMBER(3,0), 
		IP1 NUMBER(1,0), 
		IP2 NUMBER(1,0), 
		IP3 NUMBER(1,0), 
		IP4 NUMBER(1,0), 
		IP5 NUMBER(1,0), 
		K   NUMBER(8,5), 
		K2  NUMBER(8,5),
		alg varchar2(30) 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate 
    ' ALTER TABLE BARS.FIN_PD  ADD (VED number DEFAULT 0 )';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' ALTER TABLE BARS.FIN_PD  ADD (ALG VARCHAR2(30) DEFAULT ''FIN_351_16'' )';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/


begin 
  execute immediate 
    ' ALTER TABLE BARS.FIN_PD  MODIFY (ALG VARCHAR2(30) DEFAULT ''FIN_351_18'' )';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/





PROMPT *** ALTER_POLICIES to FIN_PD ***
 exec bpa.alter_policies('FIN_PD');


COMMENT ON TABLE BARS.FIN_PD IS 'Значення показників PD для Ощадбанк';
COMMENT ON COLUMN BARS.FIN_PD.IP2 IS 'Мін. зн. Кофіциент покриття боргу';
COMMENT ON COLUMN BARS.FIN_PD.IP3 IS 'Мін. зн. Менеджмент та ринки';
COMMENT ON COLUMN BARS.FIN_PD.IP4 IS 'Мін. зн. Виконання БП та ТЕО';
COMMENT ON COLUMN BARS.FIN_PD.IP5 IS 'Мін. зн. Інша негативна інформація';
COMMENT ON COLUMN BARS.FIN_PD.K IS 'Значення показнику ризику';
COMMENT ON COLUMN BARS.FIN_PD.K2 IS 'Значення показнику ризику при не виконанні субєктивних показників ';
COMMENT ON COLUMN BARS.FIN_PD.IDF IS '50-ЮО';
COMMENT ON COLUMN BARS.FIN_PD.FIN IS 'Клас боржника постанова 351';
COMMENT ON COLUMN BARS.FIN_PD.VNCRR IS 'Мінімальне значення ВКР';
COMMENT ON COLUMN BARS.FIN_PD.IP1 IS 'Мін. зн. Кредитна історія';


begin 
  execute immediate 
    ' ALTER TABLE BARS.FIN_PD  DROP CONSTRAINT PK_FINPD';
exception when others then 
  if sqlcode=-2443 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' drop index PK_FINPD';
exception when others then 
  if sqlcode=-02429 or sqlcode=-01418 then null; else raise; end if;
end;
/

PROMPT *** Create  constraint PK_FINPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_PD ADD CONSTRAINT PK_FINPD PRIMARY KEY (FIN, VNCRR, IDF, VED, ALG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINPD ON BARS.FIN_PD (FIN, VNCRR, IDF, VED, ALG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_PD ***
--grant SELECT                                                                 on FIN_PD          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_PD          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_PD          to START1;
grant SELECT                                                                 on FIN_PD          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_PD.sql =========*** End *** ======
PROMPT ===================================================================================== 
