
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_xmlklb_utl.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_XMLKLB_UTL is

   ------------------------------------------------------------
   --
   --  ����� ������������� ������������
   --  ���� ��� ��� ��������� (���������)
   --
   --  SBR  - ��������
   --  MKF  - �������. ����� (��������)
   --
   ------------------------------------------------------------


   G_HEADER_VERSION  constant varchar2(64) := 'version 1.2 05.09.2009';

   -----------------------------------------------------------------
   --   ����
   -----------------------------------------------------------------


   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     ������� ���������� ������ � ������� ��������� ������
   --
   --
   --
   function header_version return varchar2;
   

   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     ������� ���������� ������ � ������� ���� ������
   --
   --
   --
   function body_version return varchar2;

                                         
                                         
   -----------------------------------------------------------------
   --   ADD_OFFLINE_CLIENT2
   --
   --   �������� ����� ��������� ������� ( ��� ����������� �������� ������������� ��� � ����� �����)
   --   ��� �������
   --   p_branch  - ����� ������ ���������
   --   p_sab     - ��. ������������ ��� ���������,
   --	p_techkey - ���� ���������, �� �������� ���������� ����� � �����
   --
   procedure add_offline_client2(
                p_branch   branch.branch%type,
   		p_sab      customer.sab%type,
		p_techkey  kl_customer_params.tech_key%type);

   -----------------------------------------------------------------
   --   ADD_OFFLINE_CLIENT
   --
   --   �������� ����� ��������� �������
   --
   --   p_branch  - ����� ������ ���������
   --   p_rnk     - ��� ����� ��������� (���� ����)
   --   p_sab     - ��. ������������ ��� ���������,
   --	p_techkey - ���� ���������, �� �������� ���������� ����� � �����
   --	p_filesab - ��������� � ��� ����, �������� ����� ���������� �����. 
   --              (������. ��� ��������� � ��� = 289YIB, ��� ���� = 89YIB, ��� ����, ��� � ������������ ����
   --               �89YIB8J.01E. ���� �������� �� �������, �� ������������� ��������������� � substr(sab,2,5)
   --
   procedure add_offline_client(
                p_branch   branch.branch%type,
                p_rnk      customer.rnk%type  default null,                
		p_sab      customer.sab%type,
		p_techkey  kl_customer_params.tech_key%type,
		p_filesab  kl_customer_params.filesab%type default null);
                                         

   
   -----------------------------------------------------------------
   --   ADD_OFFLINE_CLIENT3
   --
   --   �������� ����� ��������� ������� ( ��� ����������� �������� ������������� ��� � ����� �����)
   --   ��� �������, ��� ����������� ����������, �� ������� �� � �����. ��������
   --   ����� ����� ��� ����������� ������ ���������
   --
   --   p_branch  -  ����� ������ ���������
   --   p_sab     -  ��. ������������ ��� ���������,
   --	p_techkey -  ���� ���������, �� �������� ���������� ����� � �����
   --   p_errcode -  ��� ������ (0-��������� �������, 1 - � ��������) 
   --   p_errmsg  -  ����� ������
   --
   procedure add_offline_client3(
                p_branch        branch.branch%type,
   		p_sab           customer.sab%type,
		p_techkey       kl_customer_params.tech_key%type,
		p_errcode   out number,
		p_errmsg    out varchar2);



   -----------------------------------------------------------------
   --   GET_CLIENT_REGISTRATION_INFO
   --
   --   �������� ���������� � ������������������ ������� �������
   --   ���
   --   p_branch  - ����� ������ ���������
   --   p_info    - ����� ����� � �����������
   --   p_result  - =1 ����������� ���������, =0 - �����������
   --
   procedure get_client_registration_info(
                p_branch       branch.branch%type,
   		p_info     out varchar2,
		p_result   out number	) ;

   -----------------------------------------------------------------
   --   CLEAR_REF_JOURNALS
   --
   --   ��������� ������ ����������� ������������
   --
   --   p_date - ���� �� ����� (�� ������������)
   --
   procedure clear_ref_journals(p_date date);



   -----------------------------------------------------------------
   --   CLEAR_ALL_JOURNALS
   --
   --   ��������� ��� �������, ���������� ������ ������ 
   --
   --   p_refdat - ���� �� ����� ������� ������ ����������� ������������ 
   --   p_xmldat - ���� �� ����� ������� ������ �������� ��������� ������ � ������ ��������
   --
   procedure clear_all_journals(p_refdat date, p_xmldat date );



   -----------------------------------------------------------------
   --    CLEAR_FILES_JOURNAL()
   --
   --    ������� ������ ������������ ������
   --
   --    p_date  -  ���� �� ����� ������� ������ (�� �������)
   --
   procedure clear_files_journal(p_date date);
   
   

   -------------------------------------------------------
   --   PURGE_JBOSS_QUEUE
   --
   --   �������� ���������� ������� aqt_klbx_replies
   --   ������ ������� ������ jboss ��� ������������ ������
   --
   --   p_dummy number - ��� ������������� � Centura
   --
   procedure purge_jboss_queue(p_dummy number  default 0);
   
   
   
    -------------------------------------------------------
    --   TAKE_JOB_OFFLINE
    --
    --   ������������ ���� , ������� ������ ������� aq_refsync_tbl(������� apply ��������)
    --   � ������ broken
    --
    procedure take_job_offline(p_dummy number  default 0);
    
    
    
    -------------------------------------------------------
    --   TAKE_JOB_ONLINE
    --
    --   ������������ ���� , ������� ������ ������� aq_refsync_tbl(������� apply ��������)
    --   � ������ online
    --
    procedure take_job_online(p_dummy number  default 0);


    
    -------------------------------------------------------
    --  JOB_INFO
    --
    --  �������� ��������� � job-�, �������
    --  ������ aq_refsync � ��������� ������� ������� ������� ��� JBOOS
    --
    procedure job_info(
                  p_job        out number,
                  p_status     out varchar2,
                  p_next_date  out date,
                  p_failures   out number);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_XMLKLB_UTL is


   ------------------------------------------------------------
   -- 
   --  ����� ����������. ������� �� ������������ ������ �������
   --  ���� ��� ��� ��������� (���������)
   --
   --  SBR  - ��������
   --  MKF  - �������. ����� (��������)
   --
   ------------------------------------------------------------


   G_BODY_DEFS constant varchar2(512) := ''
        ||' '
  	||'MKF - ���������������� �����'
        ;


   ----------------------------------------------
   --  ���������
   ----------------------------------------------

   G_BODY_VERSION    constant varchar2(64) := 'version 2.0 16.03.2011';
   G_TRACE           constant varchar2(20) := 'xmlklb_utl.';
   G_MODULE          constant varchar2(20) := 'KLB';


   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     ������� ���������� ������ � ������� ��������� ������
   --
   --
   --
   function header_version return varchar2
   is
   begin
       return 'package header BARS_XMLKLB_UTL: ' || G_BODY_VERSION;
   end header_version;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     ������� ���������� ������ � ������� ���� ������
   --
   --
   --
   function body_version return varchar2
   is
   begin
       return 'package body BARS_XMLKLB_UTL ' || G_BODY_VERSION || chr(10) ||
              'package body definition(s):' || chr(10) || G_BODY_DEFS;
   end body_version;



   
   -----------------------------------------------------------------
   --   CHECK_INPUT_PARAMS
   --
   --   �������� ����. ������������� ����������� �������
   --
   --   p_branch  - ����� ������ ���������
   --   p_rnk     - ��� ����� ��������� (���� ����)
   --   p_sab     - ��. ������������ ��� ���������,
   --	p_techkey - ���� ���������, �� �������� ���������� ����� � �����
   --              (������. ��� ��������� � ��� = 289YIB, ��� ���� = 89YIB, ��� ����, ��� � ������������ ����
   --               �89YIB8J.01E. ���� �������� �� �������, �� ������������� ��������������� � substr(sab,2,5)
   procedure check_input_params(
                p_branch   branch.branch%type             ,
                p_rnk      customer.rnk%type  default null,
		p_sab      customer.sab%type              , 
		p_techkey  kl_customer_params.tech_key%type)
   is
      l_branch    branch.branch%type;      
      l_rnk       customer.rnk%type;
      l_trace     varchar2(1000) := G_TRACE||'check_input_params: ';
   begin

      bars_audit.trace(l_trace||'������ �������� �������� ���������� ��� ����������� ��������� '||p_branch );
      -- �������� ������� ��������� ������
      if p_branch is not null then
         bars_audit.trace(l_trace||'�������� �������� BRANCH');
	 if length(p_branch) = length('/000000/') then
	    bars_error.raise_nerror(G_MODULE, 'NO_SUCH_BRANCH', p_branch);
	 end if;
         
	 begin 
            select branch into l_branch
              from branch
             where branch = p_branch;
         exception when no_data_found then
            bars_error.raise_nerror(G_MODULE, 'NO_SUCH_BRANCH', p_branch);
         end;
      else
	 bars_error.raise_nerror(G_MODULE, 'NO_BRANCH');
      end if;
      
      
      -- �������� ������� ���, ���� �������
      if p_rnk is not null then
         bars_audit.trace(l_trace||'���������� �������� RNK');
	 begin 
            select rnk into l_rnk
              from customer
             where rnk = p_rnk;
         exception when no_data_found then
            bars_error.raise_nerror(G_MODULE, 'NO_SUCH_RNK', to_char(p_rnk));
         end;
         
         --�������� ���������� �� �������� ������ ������� ��� ������� ���
         select branch into l_branch
           from customer
          where rnk = p_rnk;
          if p_branch <>  l_branch then
             bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_BRANCH', to_char(p_rnk), p_branch, l_branch);
          end if;
      end if;
   
            
      -- �������� ���
      bars_audit.trace(l_trace||'���������� �������� SAB');
      if p_sab is null then
         
         bars_error.raise_nerror(G_MODULE, 'NO_SAB', p_branch);
      else 
         if length(p_sab) <>  6 then
            bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_SAB', p_sab, p_branch);
         end if;
      end if;
      
      -- �������� ����
      bars_audit.trace(l_trace||'���������� �������� TECHKEY');
      if p_techkey is null then
         bars_error.raise_nerror(G_MODULE, 'NO_TECHKEY', p_branch);
      else 
         if length(p_techkey) <>  6 then
            bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_TECHKEY', p_techkey, p_branch);
         end if;
      end if;
   
   end;

  
   
   
   -----------------------------------------------------------------
   --   CREATE_TRANSITS
   --
   --   �������� ������ ��������� ��� ���������
   --
   --   p_branch  - ����� ������ ���������
   --   p_rnk     - ��� ����� ��������� (���� ����)
   --
   procedure create_transits(
                p_branch       branch.branch%type,
                p_rnk          customer.rnk%type default null,
		p_nls   in out accounts.nls%type)
   is
      l_nls       accounts.nls%type;
      l_nms       accounts.nms%type;
      l_ret       number;
      l_acc       number;
      l_trace     varchar2(1000):= G_TRACE||'create_transits: ';
   begin

      bars_context.subst_branch(p_branch);
      l_nls := vkrzn( substr(gl.amfo,1,5), '29090'||rpad(p_rnk, 9, '0')  );
      l_nms := '���.���.�� ����������� � ���� ';
      
      for c in (select lcv, kv 
                  from tabval$global 
                 where lcv in ('UAH', 'EUR', 'USD', 'RUB')   ) loop
          begin 
             op_reg(9, 0, 0, 0, l_ret, p_rnk, l_nls, c.kv, l_nms||c.lcv||' '||p_branch, 'ODB', 1, l_acc);
             bars_audit.info(l_trace||'������� ���� '||l_nls||'('||c.kv||')');
          exception when others then 
	     bars_audit.info(l_trace||'���� '||l_nls||'('||c.kv||') ��� ��� ������');
	     null;
          end;
      end loop;
     
      p_nls := l_nls;           
      bars_context.set_context;
   exception when others then   
     bars_context.set_context;
     null;
   end;   

 
    
   -----------------------------------------------------------------
   --   ADD_BRANCH_PARAM
   --
   --   ���������� ��������� � branch_parameters
   --
   --   p_branch  - ����� ������ ���������
   --   p_tag     - ��� ���������
   --   p_val     - �������� ���������
   --
   procedure add_branch_param(
                p_branch   branch.branch%type,
                p_tag      branch_parameters.tag%type,
		p_val      branch_parameters.val%type)
   is
      l_trace     varchar2(1000):= G_TRACE||'add_branch_param: ';
   begin
      null;
      insert into branch_parameters(branch, tag, val)
      values(p_branch, p_tag, p_val);
      bars_audit.info(l_trace||'���������� ��������� '||p_tag||' = '||p_val);
   exception when dup_val_on_index then
      update branch_parameters
         set val = p_val
       where branch = p_branch
         and tag = p_tag;
       bars_audit.info(l_trace||'���������� ��������� '||p_tag||' = '||p_val);
   end;
   

   -----------------------------------------------------------------
   --   REGISTER_TECH_USER
   --
   --   ������������ ������������� ������������ ��� ��������
   --
   --   p_branch  - ����� ������ ���������
   --   p_satffid  - ����� ��� ������������ �� staff$base ��� ������������
   --
   procedure register_tech_user(
                p_branch      branch.branch%type,
                p_staffid  out number)
   is
      l_logname   staff$base.logname%type;
      l_staffid   number;
      l_trace     varchar2(1000):= G_TRACE||'register_tech_user: ';
   begin 
      case 
         when length(p_branch) = length('/000000/000000/000000/') then l_logname := 'TVBV_'||substr(p_branch,12,3)||'_'||substr(p_branch,-4,3); 
         when length(p_branch) = length('/000000/000000/')        then l_logname := 'TVBV_'||substr(p_branch,12,3);
         else 
            bars_error.raise_nerror(G_MODULE,'NOT_CORRECT_BRANCH2',p_branch);
      end case;
      l_staffid := bars_sqnc.get_nextval('s_staff');

      insert into staff$base(id, fio,logname,type, bax, disable, clsid,approve, branch, policy_group, created)
      values(l_staffid, '������������ ��� '||p_branch, l_logname, 0,0,0,2,1, p_branch, 'FILIAL', sysdate);
	 
      bars_audit.info(l_trace||'������ ��������������� ������������: '||l_logname);
      p_staffid := l_staffid;    
   exception when dup_val_on_index then 
      -- �������� �� PK - ������ sequence
      begin
         select id into l_staffid 
           from staff$base 
          where id = l_staffid;
         bars_error.raise_nerror(G_MODULE,'BROKEN_SEQUENCE', 's_staff', to_char(l_staffid));
      exception when no_data_found then                 
         -- ���, ������ ����� ����������� ��� ����������
         select id into l_staffid 
	   from staff$base 
	  where logname = l_logname;
       end;
       
       p_staffid := l_staffid;    
       
   end;


   -----------------------------------------------------------------
   --   ADD_OFFLINE_CLIENT
   --
   --   �������� ����� ��������� �������
   --
   --   p_branch  - ����� ������ ���������
   --   p_rnk     - ��� ����� ��������� (���� ����)
   --   p_sab     - ��. ������������ ��� ���������,
   --	p_techkey - ���� ���������, �� �������� ���������� ����� � �����
   --	p_filesab - ��������� � ��� ����, �������� ����� ���������� �����. 
   --              (������. ��� ��������� � ��� = 289YIB, ��� ���� = 89YIB, ��� ����, ��� � ������������ ����
   --               �89YIB8J.01E. ���� �������� �� �������, �� ������������� ��������������� � substr(sab,2,5)
   --
   procedure add_offline_client(
                p_branch   branch.branch%type,
                p_rnk      customer.rnk%type  default null,                
		p_sab      customer.sab%type,
		p_techkey  kl_customer_params.tech_key%type,
		p_filesab  kl_customer_params.filesab%type default null)
   is
      l_rnk       customer.rnk%type;      
      l_staffid   number;
      l_nls       accounts.nls%type;
      l_filesab   kl_customer_params.filesab%type;
      l_trace     varchar2(1000):= G_TRACE||'add_offline_client: ';
   begin
     
      bars_audit.info(l_trace||'����������� ������� ���������: '||p_branch||'  ���:'||p_sab||'  ���.����:'||p_techkey);
      -- ��������� ����. ��������� �� ������������
      check_input_params(p_branch, p_rnk, p_sab, p_techkey);
     
     
      -- ����������� ��������� ��� �������, ��������� �������� ���
      if p_rnk is not null then
	 begin 
            update customer set sab = upper(p_sab) where rnk = p_rnk;
         exception when dup_val_on_index then 
	     bars_error.raise_nerror(G_MODULE,'SUCH_SAB_EXISTS', p_sab);
 	 end;   
         l_rnk := p_rnk;
      else
         -- �������� ��� ���������������� ��� ��������� ��� ��������
         begin
            select rnk into l_rnk
              from customer
              where branch = p_branch and  notes='BRANCH<->RNK';

              begin 
                 update customer set sab = upper(p_sab) where rnk = l_rnk;
              exception when dup_val_on_index then 
	          bars_error.raise_nerror(G_MODULE,'SUCH_SAB_EXISTS', p_sab); 	      
 	      end;   
	      bars_audit.info(l_trace||'��������� ��� ���� ���������������� ��� ������');

	 exception when no_data_found then
	    l_rnk := bars_sqnc.get_nextval('s_customer');
       
            insert into customer (rnk,tgr,custtype,country,nmk,nmkk,notes,branch, sab)
            select l_rnk, 1,1,804, substr(name,1,70), substr(name,1,38),'BRANCH<->RNK', p_branch, upper(p_sab)
              from branch 
             where branch = p_branch;
             bars_audit.info(l_trace||'���������������� ������ ������� � ���: '||l_rnk);
        end;
      end if;
   

      add_branch_param(p_branch, 'RNK', l_rnk);
      add_branch_param(p_branch, 'DPTNUM', '1');
   
      -- ������� ��������  ��� ������ � ������� ����������
      create_transits(p_branch, l_rnk, l_nls);
      add_branch_param(p_branch, 'TRDPT', l_nls);
   
   
      -- ���������������� ���������������� ������������
      register_tech_user(p_branch, l_staffid);


      -- ������ ������ � dpt_staff - ����������� �� ���������
      begin
         insert into dpt_staff(userid, fio, mfo, branch, isp)
         values(l_staffid, '������ ��� �������',substr(p_branch,2,6) ,p_branch, l_staffid);
      exception when dup_val_on_index then null;
      end;
      
      -- ������ ������ � kl_customer_params
      begin 
         if p_filesab is null then
            l_filesab := substr(p_sab,2);
         else
	    if length(p_filesab) <> 5 then 
	       bars_error.raise_nerror(G_MODULE,'NOT_CORRECT_FILESAB', p_filesab, p_branch);
	    end if;   
	    l_filesab := p_filesab;
         end if;
	 
	 insert into kl_customer_params(rnk, blk, post_type, tech_key, filesab, isactive,  last_filenum)
         values (l_rnk, 0, 'F', p_techkey, l_filesab, 0, 0); 
         bars_audit.info(l_trace||'��������� ���������� � ���������� ������� ��������');
      exception when dup_val_on_index then
         update kl_customer_params
            set blk          = 0,  
	        post_type    = 'F',
		tech_key     = p_techkey,
		filesab      = l_filesab,
		isactive     = 0,
		last_filenum = 0
          where rnk = l_rnk;
      end;
      
   end;
   

   -----------------------------------------------------------------
   --   ADD_OFFLINE_CLIENT2
   --
   --   �������� ����� ��������� ������� ( ��� ����������� �������� ������������� ��� � ����� �����)
   --   ��� �������
   --   p_branch  - ����� ������ ���������
   --   p_sab     - ��. ������������ ��� ���������,
   --	p_techkey - ���� ���������, �� �������� ���������� ����� � �����
   --
   procedure add_offline_client2(
                p_branch   branch.branch%type,
   		p_sab      customer.sab%type,
		p_techkey  kl_customer_params.tech_key%type)
   is
   begin
      
      add_offline_client(
                p_branch  => p_branch,
		p_sab     => p_sab,
		p_techkey => p_techkey);

   end;
   
   -----------------------------------------------------------------
   --   ADD_OFFLINE_CLIENT3
   --
   --   �������� ����� ��������� ������� ( ��� ����������� �������� ������������� ��� � ����� �����)
   --   ��� �������, ��� ����������� ����������, �� ������� �� � �����. ��������
   --   ����� ����� ��� ����������� ������ ���������
   --
   --   p_branch  -  ����� ������ ���������
   --   p_sab     -  ��. ������������ ��� ���������,
   --	p_techkey -  ���� ���������, �� �������� ���������� ����� � �����
   --   p_errcode -  ��� ������ (0-��������� �������, 1 - � ��������) 
   --   p_errmsg  -  ����� ������
   --
   procedure add_offline_client3(
                p_branch        branch.branch%type,
   		p_sab           customer.sab%type,
		p_techkey       kl_customer_params.tech_key%type,
		p_errcode   out number,
		p_errmsg    out varchar2)
   is
      l_errumsg  err_texts.err_msg%type  ;
      l_errcode  varchar2(10)            ;
      l_errmsg   err_texts.err_msg%type  ;
   begin

      add_offline_client(
                p_branch  => p_branch,
		p_sab     => p_sab,
		p_techkey => p_techkey);

      p_errcode := 0;
      p_errmsg  := 'Success';
   exception when others then
      if bars_xmlklb.get_error_type = bars_xmlklb.G_ERR_SYS then
         raise;
      else
         bars_error.get_error_info( 
	           substr(sqlerrm, 1, 250),
                   l_errumsg,
                   l_errcode,
                   l_errmsg);

         l_errcode:=substr(l_errcode, 6,4);

         if (instr(l_errumsg,'ORA-')>0 ) then
             l_errumsg:=substr(l_errumsg, 1, instr(l_errumsg,'ORA-')-1 );
         end if;

         begin 
	    p_errcode := to_number(l_errcode);
         exception when others then p_errcode := 1;
         end;
         p_errmsg  := l_errumsg;

      end if;   
   end;


   -----------------------------------------------------------------
   --   GET_CLIENT_REGISTRATION_INFO
   --
   --   �������� ���������� � ������������������ ������� �������
   --   ���
   --   p_branch  - ����� ������ ���������
   --   p_info    - ����� ����� � �����������
   --   p_result  - =1 ����������� ���������, =0 - �����������
   --
   procedure get_client_registration_info(
                p_branch       branch.branch%type,
   		p_info     out varchar2,
		p_result   out number	) 
   is
      l_info  varchar2(2000);
      l_data  varchar2(1000);
      l_data2 varchar2(1000);
      l_ndata number;
      l_res   number;
      l_count number;
      l_nl    char(2) := chr(13)||chr(10);
   begin
      begin 

         select val  into l_data
           from branch_parameters
          where branch = p_branch and tag = 'RNK'; 
         l_info  := '�������� ������ RNK ���������� � �������� '||l_data;
	 l_res   := 1;
	 l_ndata := to_number(l_data);
	 
	 --
	 --  �������� ������������ RNK
	 --
	 begin
            select to_char(rnk), sab into l_ndata, l_data
              from customer
             where rnk = to_number(l_ndata); 
            l_info := l_info||l_nl||'��������������� ������. ������ � ������ RNK.';
	    l_res  := 1;
	    
	    if l_data is not null and length(l_data) = 6 then
               l_info := l_info||l_nl||'���������� ��.���������.(���): '||l_data;
    	       l_res  := 1;
	    end if;
	 
	  exception when no_data_found then
            l_info := l_info||l_nl||'��� ����������  RNK �� ������ ������';
            l_res := 0;
          end;    
	 
	 
	  begin
	     select tech_key, filesab into l_data, l_data2
	       from kl_customer_params
	      where rnk = l_ndata; 
	     l_info := l_info||l_nl||'��������� ������ ��������������� � ��������';
	     l_res  := bitand(l_res, 1); 
	     if l_data is null then
  	        l_info := l_info||l_nl||'�� ������� �������� ���.�����';
	        l_res  := 0; 
	     end if;
	     
	     if l_data2 is null then 
	        l_info := l_info||l_nl||'�� ������� �������� �������������� ��� �����';
	        l_res  := 0; 
	     end if;
	     
	  exception when no_data_found then
            l_info := l_info||l_nl||'��������� ������ �� ��������������� � ��������(��� ������ � kl_customer_params)';
            l_res := 0;
          end;        
	 
         
	 
	 --
	 --  �������� ������������ DPTNUM
	 --
	 begin
            select val  into l_data
              from branch_parameters
             where branch = p_branch and tag = 'DPTNUM'; 
            l_info := '�������� ������ DPTNUM(����� ���. ��������) ���������� � �������� '||l_data;
            l_res  := bitand(l_res, 1);
         exception when no_data_found then
            l_info := l_info||l_nl||'�� ������ �������� ������ DPTNUM(����� ���. ��������)';
            l_res  := 0;
         end;    
                          
         
	 --
	 --  �������� ������������ TRDPT
	 --
	 begin
            select val  into l_data
              from branch_parameters
             where branch = p_branch and tag = 'TRDPT'; 
             l_info := '�������� ������ TRDPT(����� ��������) ���������� � �������� '||l_data;
             l_res  := bitand(l_res, 1);
             begin
                 select nls, count(*) into l_data, l_count                  
                   from accounts where nls= l_data
                  group by nls;
                 l_info := '������� ����� '||l_data||' � '||l_count||'-� �������';
                 l_res := bitand(l_res, 1);
	     exception when no_data_found then
                l_info := l_info||l_nl||'�� ������� �����('||l_data||'), ��������� � ��������� TRDPT';
                l_res := 0;
             end;    
 	 exception when no_data_found then
            l_info := l_info||l_nl||'�� ������ �������� ������ TRDPT(����� ��������)';
            l_res := 0;
         end;    
	 
         
      exception when others then
         if sqlcode = -01403  or  sqlcode = 100  then -- no_data_found
            l_info := '�� ������ �������� ������ RNK';
            l_res := 0;
	 end if;
         if sqlcode = -01722 then -- invalid number
	    l_info := l_info||l_nl||'�� ������ �������� ������ RNK';
            l_res := 0;
         end if;
      end;    
      
      p_info   := l_info;
      p_result := l_res;
      
   end;
   



   -----------------------------------------------------------------
   --   CLEAR_REF_JOURNALS
   --
   --   ��������� ������ ����������� ������������
   --
   --   p_date - ���� �� ����� (�� ������������)
   --
   procedure clear_ref_journals(p_date date)
   is
   begin
      delete from xml_syncfiles
      where datf <= p_date;
   end;





   -----------------------------------------------------------------
   --    CLEAR_FILES_JOURNAL()
   --
   --    ������� ������ ������������ ������
   --
   --    p_date  -  ���� �� ����� ������� ������ (�� �������)
   --
   procedure clear_files_journal(p_date date)
   is
   begin
      for c in (select id from xml_gate where datf < p_date ) loop
 
          delete from xml_gate_receipt where id = c.id;
          delete from xml_gate         where id = c.id;
      end loop;

   end;


   -----------------------------------------------------------------
   --   CLEAR_ALL_JOURNALS
   --
   --   ��������� ��� �������, ���������� ������ ������ 
   --
   --   p_refdat - ���� �� ����� ������� ������ ����������� ������������ 
   --   p_xmldat - ���� �� ����� ������� ������ �������� ��������� ������ � ������ ��������
   --
   procedure clear_all_journals(p_refdat date, p_xmldat date )
   is
   begin
      clear_ref_journals(p_refdat);
      clear_files_journal(p_xmldat);     
   end;



    -------------------------------------------------------
    --   GET_JOBID
    --
    --   �������� ����� �����, �������
    --   ������ aq_refsync � ��������� ������� ������� ������� ��� JBOOS 
    --
    function get_jobid return number
    is
       l_jobid number;
    begin

       select job 
         into l_jobid 
         from dba_jobs
        where lower(what) like  ('%bars_xmlklb_ref.post_incref_for_all%')
          and log_user='JBOSS_USR' and rownum=1;
        return l_jobid;

    exception when no_data_found then
       return -1;
    end;

   
   -------------------------------------------------------
   --   PURGE_JBOSS_QUEUE
   --
   --   �������� ���������� ������� aqt_klbx_replies
   --   ������ ������� ������ jboss ��� ������������ ������
   --
   --   p_dummy number - ��� ������������� � Centura
   --
   procedure purge_jboss_queue(p_dummy number  default 0)
   is
      l_purge_opt   dbms_aqadm.aq$_purge_options_t;
   begin
      l_purge_opt.block         := false;
      l_purge_opt.delivery_mode := dbms_aq.persistent;


      dbms_aqadm.purge_queue_table(
          queue_table        => 'bars.aqt_klbx_replies',
          purge_condition    => '',
          purge_options      => l_purge_opt);
  end;

    -------------------------------------------------------
    --   TAKE_JOB_OFFLINE
    --
    --   ������������ ���� , ������� ������ ������� aq_refsync_tbl(������� apply ��������)
    --   � ������ broken
    --
    procedure take_job_offline(p_dummy number  default 0)
    is
    begin
       sys.dbms_job.broken
         ( job       => get_jobid,
           broken    => true,
           next_date => sysdate + 1 
          );
    end;


    -------------------------------------------------------
    --   TAKE_JOB_ONLINE
    --
    --   ������������ ���� , ������� ������ ������� aq_refsync_tbl(������� apply ��������)
    --   � ������ online
    --
    procedure take_job_online(p_dummy number  default 0)
    is
       l_cnt number;
    begin
       
       execute immediate 'select count(*) from 	barsaq.aq_refsync_tbl' into l_cnt;
       

       if l_cnt > 10000 then
          bars.bars_error.raise_error(G_MODULE, 18009);
       end if;

       sys.dbms_job.broken
         ( job       => get_jobid,
           broken    => false,
           next_date => sysdate + (5/(24*60)) 
         );

    end;



    



    -------------------------------------------------------
    --  JOB_INFO
    --
    --  �������� ��������� � job-�, �������
    --  ������ aq_refsync � ��������� ������� ������� ������� ��� JBOOS
    --
    procedure job_info(
                  p_job        out number,
                  p_status     out varchar2,
                  p_next_date  out date,
                  p_failures   out number)
    is
       l_jobid number;
    begin

       l_jobid := get_jobid;
   
       select job,  next_date, decode(broken,'Y','broken','worked') status, failures
         into p_job,  p_next_date, p_status, p_failures
         from dba_jobs
        where job = l_jobid;

    exception when no_data_found then
       p_job    := -1;
       p_status := 'not exists';
    end;


  
  
end;
/
 show err;
 
PROMPT *** Create  grants  BARS_XMLKLB_UTL ***
grant EXECUTE                                                                on BARS_XMLKLB_UTL to ABS_ADMIN;
grant EXECUTE                                                                on BARS_XMLKLB_UTL to BARSAQ;
grant EXECUTE                                                                on BARS_XMLKLB_UTL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_XMLKLB_UTL to KLBX;
grant EXECUTE                                                                on BARS_XMLKLB_UTL to OPER000;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_xmlklb_utl.sql =========*** End
 PROMPT ===================================================================================== 
 