
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/fin_formaf3.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.FIN_FORMAF3 
AS
   G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.1.1  18.08.2018';

TYPE t_col_F3DC IS RECORD
 (
  okpo      fin_forma3_dm.okpo%type,
  fdat      fin_forma3_dm.fdat%type,
  id        fin_forma3_dm.id%type,
  kod       fin_forma3_ref.kod%type,
  name      fin_forma3_ref.name%type,
  colum3    number(28,2), --varchar2(100), --number(28,2),
  colum4    number(28,2), --varchar2(100), --number(28,2),
  col3      varchar2(1),
  col4      varchar2(1),
  type_row  fin_forma3_ref.type_row%type,
  ord       fin_forma3_ref.ord%type
 );

 TYPE t_v_F3DC iS TABLE OF t_col_F3DC;


 TYPE t_form_col_validat IS RECORD
  ( kod      varchar2(6)
   ,idf      pls_integer
   ,sql_text varchar2(4000)
   ,colum        number
  );
 TYPE t_col_validat  IS TABLE OF t_form_col_validat;


 TYPE t_form_col_prot IS RECORD
  ( id      number
   ,col1    Varchar2(4000)
   ,col2    number
   ,col3    Varchar2(4000)
   ,col4    number
   ,col5    varchar2(4000)
   ,col6    number
   );
 TYPE t_col_prot  IS TABLE OF t_form_col_prot;

  TYPE t_form_col_prot1 IS RECORD
  ( id      number
   ,col1    Varchar2(4000)
   ,col2    number
   ,col3    Varchar2(4000)
   ,col4    number
   ,col5    varchar2(4000)
   ,col6    number
   );

 TYPE t_col_prot1 iS TABLE OF t_form_col_prot1 index by binary_integer;
  g_col_prot     t_col_prot1;

 /**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;


/**
 * body_version - возвращает версию тела пакета
 */
function body_version   return varchar2;

Function t_numb (p_value varchar2) return number  ;
Function t_char(p_value number, p_def_val varchar2 default null, p_typerow number, p_zero boolean default false) return varchar2;


--видалення даних
procedure data_deletion (  p_okpo fin_forma3_dm.okpo%type
                          ,p_fdat fin_forma3_dm.fdat%type
                          ,p_idf  fin_forma3_ref.idf%type);


-- завантаження вхідних даних
procedure load_in_data (   p_okpo fin_forma3_dm.okpo%type
                          ,p_fdat fin_forma3_dm.fdat%type
                          ,p_idf  fin_forma3_ref.idf%type);


-- введення даних
procedure data_entry ( p_okpo fin_forma3_dm.okpo%type
                      ,p_fdat fin_forma3_dm.fdat%type
                      ,p_id   fin_forma3_ref.id%type
                      ,p_colum3  number
                      ,p_colum4  number );

-- введення даних
procedure data_entry_s( p_okpo fin_forma3_dm.okpo%type
                       ,p_fdat fin_forma3_dm.fdat%type
                       ,p_id   fin_forma3_ref.id%type
                       ,p_colum3  varchar2
                       ,p_colum4  varchar2 );


function f_forms( p_okpo fin_forma3_dm.okpo%type
                 ,p_fdat fin_forma3_dm.fdat%type
                 ,p_idf  fin_forma3_ref.idf%type )
                  RETURN t_v_F3DC PIPELINED  PARALLEL_ENABLE;

--первірка введених даних (протокол)
procedure data_validation (  p_okpo fin_forma3_dm.okpo%type
							,p_fdat fin_forma3_dm.fdat%type
							,p_idf  fin_forma3_ref.idf%type
							,p_err  out  pls_integer
                           );

function f_protokol(  p_okpo fin_forma3_dm.okpo%type
					 ,p_fdat fin_forma3_dm.fdat%type
					 ,p_idf  fin_forma3_ref.idf%type )
                  RETURN t_col_prot PIPELINED  PARALLEL_ENABLE;

function f_prot_kol(  p_okpo fin_forma3_dm.okpo%type
					 ,p_fdat fin_forma3_dm.fdat%type
					 ,p_idf  fin_forma3_ref.idf%type )
                            RETURN number;

function LOGK_read (
                   DAT_ date,
                   OKPO_ int,
                   IDF_  int,
				   mode_ int ) RETURN number;

END fin_formaf3;
/
CREATE OR REPLACE PACKAGE BODY BARS.FIN_FORMAF3 
AS

 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 1.1.1  18.08.2018';

   -- маска формата для преобразования char <--> number
  g_number_format constant varchar2(128) := 'FM999999999999999999999999999990';
  g_decimal_format constant varchar2(128) := 'FM999999999999999999999999999990D00';
  -- параметры преобразования char <--> number
  g_number_nlsparam constant varchar2(30) := 'NLS_NUMERIC_CHARACTERS = ''. ''';
  g_number_nlsweb constant varchar2(30)   := 'NLS_NUMERIC_CHARACTERS = '', ''';
  -- маска формата для преобразования char <--> date
  g_date_format constant varchar2(30) := 'DD.MM.YYYY HH24:MI:SS';

 /**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2 is
begin
  return 'Package header '||$$PLSQL_UNIT||' '||G_HEADER_VERSION;
end header_version;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2 is
begin
  return 'Package body '||$$PLSQL_UNIT||' '||G_BODY_VERSION;
end body_version;

 procedure trace ( p_msg  SEC_AUDIT.REC_MESSAGE%type)
 as
 p_mod varchar2(100) :=  $$PLSQL_UNIT;
 begin

 if user_id in( 1, 20094) then   logger.info  (p_mod||' '||p_msg);
                                 dbms_output.put_line(p_mod||' '||p_msg);
                          else   logger.trace (p_mod||' '||p_msg);
 end if;

 end;

Function t_numb (p_value varchar2) return number
is
l_ number;
begin

   return to_number(replace(trim(p_value),'.',','),g_decimal_format,g_number_nlsweb);
exception when others then
    logger.trace('t_numb>'||trim(p_value)||' >'||g_decimal_format||' >'||g_number_nlsweb);
  return null;
end;

Function t_char(p_value number, p_def_val varchar2 default null, p_typerow number, p_zero boolean default false) return varchar2
is
l_ varchar2(100);
begin

 if p_def_val = 'X' or  p_def_val = 'Х'
    then  l_ := 'X';
 elsif	p_typerow in ( 2 , 1)
    then  l_ := null;
	else
	          if p_zero and p_value = 0
				    then  l_ := '-';
				    else  l_ := trim(to_char(p_value,g_decimal_format,g_number_nlsweb));
			  end if;
  end if;



   return l_;

exception when others then
  if p_zero and p_value = 0
    then  return '-';
	else  return null;
  end if;

end;
--видалення даних
procedure data_deletion (  p_okpo fin_forma3_dm.okpo%type
                          ,p_fdat fin_forma3_dm.fdat%type
                          ,p_idf  fin_forma3_ref.idf%type)
is
begin

	delete from fin_forma3_dm
	 where fdat = p_fdat
	   and okpo = p_okpo
	   and id   in (select id from  fin_forma3_ref where idf = p_idf);

end;

-- завантаження вхідних даних
procedure load_in_data (   p_okpo fin_forma3_dm.okpo%type
                          ,p_fdat fin_forma3_dm.fdat%type
                          ,p_idf  fin_forma3_ref.idf%type)
is

begin

  -- вставка даних для форми.
	for x in (
				 Select id
				   from bars.fin_forma3_ref
				  where idf = p_idf
              )
    Loop

	   Begin
        Insert into fin_forma3_dm(fdat, okpo, id, colum3, colum4)
		   values (p_fdat, p_okpo, x.id, 0, 0);
          exception when dup_val_on_index then
            null;
       End;

	End loop;


end;



-- введення даних
procedure data_entry ( p_okpo fin_forma3_dm.okpo%type
                      ,p_fdat fin_forma3_dm.fdat%type
                      ,p_id   fin_forma3_ref.id%type
                      ,p_colum3  number
                      ,p_colum4  number )
is
begin

  update  fin_forma3_dm
     set  colum3 = nvl2(p_colum3, (p_colum3), colum3)
	     ,colum4 = nvl2(p_colum4, (p_colum4), colum4)
   where  id     = p_id
     and  okpo   = p_okpo
	 and  fdat   = p_fdat;

end;


-- введення даних
procedure data_entry_s ( p_okpo fin_forma3_dm.okpo%type
                        ,p_fdat fin_forma3_dm.fdat%type
                        ,p_id   fin_forma3_ref.id%type
                        ,p_colum3  varchar2
                        ,p_colum4  varchar2 )
is

begin
 logger.info('FIN >> p_okpo='||p_okpo||' p_id='||p_id||' p_fdat='||to_char(p_fdat,'dd-mm-yyyy')||' p_colum3='||p_colum3 ||' p_colum4='||p_colum4);
  update  fin_forma3_dm
     set  colum3  = nvl2(p_colum3, t_numb(p_colum3), colum3)
	     ,colum4  = nvl2(p_colum4, t_numb(p_colum4), colum4)
   where  id     = p_id
     and  okpo   = p_okpo
	 and  fdat   = p_fdat;

end;


function f_forms( p_okpo fin_forma3_dm.okpo%type
                 ,p_fdat fin_forma3_dm.fdat%type
                 ,p_idf  fin_forma3_ref.idf%type )
                  RETURN t_v_F3DC PIPELINED  PARALLEL_ENABLE
as
  l_forms       t_col_F3DC;
  l_forms_null  t_col_F3DC;
  l_zero        boolean := false;
  l_            pls_integer;

  PRAGMA AUTONOMOUS_TRANSACTION;
begin
   l_forms := l_forms_null;

    Select count(1)
	  into l_
      from fin_forma3_dm d
	   join fin_forma3_ref r on d.id = r.id
	 where  d.okpo = p_okpo
	   and  d.fdat = p_fdat
	   and  r.idf  = p_idf;

    if l_ = 0
       then   load_in_data (   p_okpo =>  p_okpo
	                          ,p_fdat =>  p_fdat
	                          ,p_idf  =>  p_idf );
       commit;
	end if;





 for  x in (
				select d.okpo, d.fdat, d.id, r.ord, r.kod, r.name, d.colum3, d.colum4, r.TYPE_ROW, r.col3, r.col4
				 from fin_forma3_dm  d
				 join fin_forma3_ref r on d.id = r.id
				where d.okpo = p_okpo
				  and d.fdat = p_fdat
				  and r.idf  = p_idf
				order by ord
            )

 Loop

  l_forms.okpo      :=  x.okpo;
  l_forms.fdat      :=  x.fdat;
  l_forms.id        :=  x.id;
  l_forms.kod       :=  x.kod;
  l_forms.name      :=  x.name;
  l_forms.colum3    :=  nvl(x.colum3,0); --t_char(nvl(x.colum3,0) , x.col3 , x.TYPE_ROW, l_zero);   -- nvl(x.colum3,0);
  case when p_idf = 3
         then  l_forms.colum4    :=  null;
		 else  l_forms.colum4    :=  nvl(x.colum4,0); --t_char(nvl(x.colum4,0) , x.col4 , x.TYPE_ROW, l_zero);   -- nvl(x.colum4,0);
  end case;
  l_forms.col3      :=  x.col3;
  l_forms.col4      :=  x.col4;
  l_forms.type_row  :=  x.type_row;
  l_forms.ord       :=  x.ord;

  PIPE ROW(l_forms);
 End loop;

 return;
end;


--первірка введених даних (протокол)
procedure data_validation (  p_okpo fin_forma3_dm.okpo%type
							,p_fdat fin_forma3_dm.fdat%type
							,p_idf  fin_forma3_ref.idf%type
							,p_err   out  pls_integer
                           )
is
l_forms   t_col_validat;
l_list    varchar2(4000);

l_col        number;
l_colum      number;
l_mod varchar2(100) := '.data_validation( okpo='||p_okpo||',fdat='||to_char(p_fdat,'dd/mm/yyyy')||'): ';
procedure add_prot (  p_col1   Varchar2
                     ,p_col2   number
                     ,p_col3   Varchar2
                     ,p_col4   number
                     ,p_col5   varchar2
                     ,p_col6   number
					)
as
l_ pls_integer := 0;
begin
 l_ :=  g_col_prot.count+1;
 g_col_prot(l_).id    := l_;
 g_col_prot(l_).col1  := p_col1;
 g_col_prot(l_).col2  := p_col2;
 g_col_prot(l_).col3  := p_col3;
 g_col_prot(l_).col4  := p_col4;
 g_col_prot(l_).col5  := p_col5;
 g_col_prot(l_).col6  := p_col6;
 --trace(  g_col_prot(l_).id||' '||g_col_prot(l_).col1||' '||g_col_prot(l_).col2||' '||g_col_prot(l_).col3||' '||g_col_prot(l_).col4||' '||g_col_prot(l_).col5||' '||g_col_prot(l_).col6 );
end;
Begin
   g_col_prot.delete();
  -- Forma3
    Select kod, idf, sql_text, colum
	 bulk collect into l_forms
	 from (
		   Select  r.kod||'.3' as kod, to_number(r.idf) idf, r.sql_text3 as sql_text, nvl(d.colum3,0) as colum
		     from FIN_FORMA3_DM d,
				  FIN_FORMA3_REF r
			where d.okpo = p_okpo
			  and d.fdat = p_fdat
			  and r.id   = d.id
			  and r.idf  = 3
			  and r.idf  = p_idf
			  and r.kod is not null
		union all
           Select  r.kod||'.3' as kod, to_number(r.idf) idf, r.sql_text3 as sql_text, nvl(d.colum3,0) as colum
		     from FIN_FORMA3_DM d,
				  FIN_FORMA3_REF r
			where d.okpo = p_okpo
			  and d.fdat = p_fdat
			  and r.id   = d.id
			  and r.idf  = 4
			  and r.idf  = p_idf
			  and r.kod is not null
		union all
           Select  r.kod||'.4' as kod, to_number(r.idf) idf, r.sql_text4 as sql_text, nvl(d.colum4,0) as colum
		     from FIN_FORMA3_DM d,
				  FIN_FORMA3_REF r
			where d.okpo = p_okpo
			  and d.fdat = p_fdat
			  and r.id   = d.id
			  and r.idf  = 4
			  and r.idf  = p_idf
			  and r.kod is not null
		union all
		   Select  d.kod||'.3' as kod, d.idf, null as sql_text, s colum
			 from FIN_rnk d
			where d.okpo = p_okpo
			  and d.fdat = p_fdat
			  and d.idf  in (1,2)
		union all
		   Select  d.kod||'.4' as kod, d.idf, null as sql_text, s colum
			 from FIN_rnk d
			where d.okpo = p_okpo
			  and d.fdat = add_months(p_fdat,-12)
			  and d.idf  in (1,2)
		   );


	IF (l_forms.COUNT > 0) THEN

	<<ROW_SQLTEXT>>
	FOR i IN   l_forms.FIRST..l_forms.LAST
		LOOP
		   -- виходимо якщо немає формули в полі sql_text або idf  не відповідає типу протоколу
		   continue when  l_forms(i).sql_text is null  or  l_forms(i).idf != p_idf or  p_idf  = 4 or l_forms(i).kod in ('3405.3','3415.3','3405.4','3415.4');  -- відключили IDF = 4? Для Графи 3405 та 3415 Форми №3 Прямого методу відключити контролі (тимчасово)

		    -- Формули з декількми строками розкладемо на строки   Formula
			<<LIST_SQL_TEXT>>
			FOR x0 IN ( select regexp_replace(regexp_replace(column_value,chr(13),''),chr(10),'')  as sql_text from table(GETTOKENS(l_forms(i).sql_text)))
			LOOP

		    l_list := 	 regexp_replace(x0.sql_text,'\-',',-');
			l_list := 	 regexp_replace(l_list,'\+',',');
			l_list := 	 regexp_replace(l_list,' ','');
			l_list := 	 regexp_replace(l_list,chr(10),'');
			l_list := 	 regexp_replace(l_list,chr(13),'');
			trace( l_mod||l_forms(i).kod||' = '||l_list);

             --  Перевірка по формулах	3
				begin
				     l_colum        := 0;
					<<VALIDAT_SQLTEXT>>
					for x0 in  ( select  lpad(to_number( abs( column_value ) ),6,'0')  i       -- кода показника
									  , SIGN( to_number( trim( column_value ) ) )      sign_   -- знак дії +/-
								   from table(  GETTOKENS(l_list) ) )
						Loop
						-- Підраховуємо формули
						-- trace('x0.i='||x0.i||' x0.sign_='||x0.sign_);
						    l_col := 0;
				            for s in 1 .. l_forms.count()
							loop
								  if l_forms(s).kod = x0.i
									then l_col := nvl(l_forms(s).colum ,0);
								  end if;
							end loop;

							l_colum :=  nvl(l_colum, 0) + (x0.sign_ *  l_col  );

						end loop VALIDAT_SQLTEXT;

					-- Перевіряємо умову , в разі помилки в протокл

                    if	l_forms(i).colum != l_colum
                        then
								 add_prot (  p_col1   =>  'КОД '||l_forms(i).kod
											,p_col2   =>   l_forms(i).colum
											,p_col3   =>   x0.sql_text
											,p_col4   =>   l_colum
											,p_col5   =>   'відхилення'
											,p_col6   =>   l_forms(i).colum- l_colum
										  );
							    trace('err KOD='||l_forms(i).kod||'  '||l_forms(i).colum||' <> '||x0.sql_text||' '||l_colum);

                    end if;
 				        -- record total
						--l_forms(i).colum :=  l_colum;

				  exception when others then  logger.error('Помилка формули l_list = ''' ||l_list||'''' );
                                              trace('Помилка формули l_list = ''' ||l_list||'''' );
				end;

            END LOOP LIST_SQL_TEXT;



		END LOOP ROW_SQLTEXT;
	END IF;

    p_err  := g_col_prot.count;

End data_validation;



function f_protokol(  p_okpo fin_forma3_dm.okpo%type
					 ,p_fdat fin_forma3_dm.fdat%type
					 ,p_idf  fin_forma3_ref.idf%type )
                            RETURN t_col_prot PIPELINED  PARALLEL_ENABLE
as
  l_forms       t_form_col_prot;
  l_forms_null  t_form_col_prot;
  l_  pls_integer;
begin
 l_forms := l_forms_null;

 data_validation(  p_okpo => p_okpo
                  ,p_fdat => p_fdat
                  ,p_idf  => p_idf
                  ,p_err  => l_);

	if g_col_prot.count > 0 then

			FOR i IN   g_col_prot.FIRST..g_col_prot.LAST

			 Loop

			  l_forms.id    :=   g_col_prot(i).id    ;
			  l_forms.col1  :=   g_col_prot(i).col1  ;
			  l_forms.col2  :=   g_col_prot(i).col2  ;
			  l_forms.col3  :=   g_col_prot(i).col3  ;
			  l_forms.col4  :=   g_col_prot(i).col4  ;
			  l_forms.col5  :=   g_col_prot(i).col5  ;
			  l_forms.col6  :=   g_col_prot(i).col6  ;


			  PIPE ROW(l_forms);
			 End loop;
	  else
		  l_forms.col1 := 'Помилок не виявлено.';
		   PIPE ROW(l_forms);
	end if;

	 return;
end f_protokol;


function f_prot_kol(  p_okpo fin_forma3_dm.okpo%type
					 ,p_fdat fin_forma3_dm.fdat%type
					 ,p_idf  fin_forma3_ref.idf%type )
                            RETURN number
as
  l_  pls_integer;
begin

 data_validation(  p_okpo => p_okpo
                  ,p_fdat => p_fdat
                  ,p_idf  => p_idf
                  ,p_err  => l_);
  return l_;
end f_prot_kol;



FUNCTION LOGK_read (
                   DAT_ date,
                   OKPO_ int,
                   IDF_  int,
				   mode_ int ) RETURN number
  is
coun_ number;
sum_  number;
kont_ number;

 begin


 select nvl(count(colum3),0), nvl(sum(abs(colum3+colum4)),0)
   into     coun_, sum_
   from FIN_FORMA3_DM a, FIN_FORMA3_REF r
  where  okpo = okpo_
    and idf = idf_
    and fdat = dat_
	and r.id = a.id;

	 data_validation(  p_okpo => OKPO_
					  ,p_fdat => DAT_
					  ,p_idf  => IDF_
					  ,p_err  => kont_);

	-- kont_:= sign(kont_);

	if mode_ = 1 then
	      if kont_ = 0  and coun_ !=0 and sum_ != 0 then return 0;           -- повністю заповненна форма та пройдена логіку
	   elsif kont_ = 0  and coun_ !=0 and sum_  = 0 then return 1;           -- створена форма , клієгт ненадав даних
	   elsif kont_ != 0 and coun_ !=0 and sum_ != 0 then return 2;         -- створена форма , набрана з помилками
	   elsif kont_ != 0 and coun_ !=0               then return 2;         -- створена форма , набрана з помилками
	   elsif kont_ = 0  and coun_ =0  and sum_  = 0 then RETURN 3;            ---ЗВІТНІСТЬ НЕ ВВОДИЛАСЬ
	   end if;
	elsif mode_ = 2 then
	   if kont_ = 0 and coun_ !=0 and sum_ != 0
	        then return 0;      -- заборонити редагування
			else return 1;      -- дозволити редагування
	   end if;
	else return -1;
	end if;
			return -1;
end LOGK_read;


END fin_formaf3;
/
 show err;
 
PROMPT *** Create  grants  FIN_FORMAF3 ***
grant EXECUTE                                                                on FIN_FORMAF3     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/fin_formaf3.sql =========*** End ***
 PROMPT ===================================================================================== 
 